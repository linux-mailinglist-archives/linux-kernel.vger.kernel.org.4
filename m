Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DD0698D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBPGhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBPGhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:37:50 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0899B42DCC;
        Wed, 15 Feb 2023 22:37:46 -0800 (PST)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PHQF36YR6zJsWv;
        Thu, 16 Feb 2023 14:35:51 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Feb 2023 14:37:39 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <robbiek@xsightlabs.com>, <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>,
        <lihuisong@huawei.com>
Subject: [PATCH 1/2] mailbox: pcc: Add processing platform notification for slave subspaces
Date:   Thu, 16 Feb 2023 14:36:52 +0800
Message-ID: <20230216063653.1995-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20230216063653.1995-1-lihuisong@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230216063653.1995-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.79.22]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, PCC driver doesn't support the processing of platform
notification for slave PCC subspaces because of the incomplete
communication flow.

According to ACPI specification, if platform sends a notification
to OSPM, it must clear the command complete bit and trigger platform
interrupt. OSPM needs to check whether the command complete bit is
cleared, clear platform interrupt, process command, and then set the
command complete and ring doorbell to Platform. But the current judgment
on the command complete is not applicable to type4 in pcc_mbox_irq().

This patch determines whether the PCC driver needs to respond to the
interrupt of the channel with the master or slave subspace based on
the command complete register. And PCC driver needs to add the phase
of setting the command complete and ring doorbell in pcc_mbox_irq()
to complete type4 communication flow after processing command from
Platform.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/mailbox/pcc.c | 57 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 105d46c9801b..ecd54f049de3 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -91,6 +91,7 @@ struct pcc_chan_reg {
  * @cmd_update: PCC register bundle for the command complete update register
  * @error: PCC register bundle for the error status register
  * @plat_irq: platform interrupt
+ * @type: PCC subspace type
  */
 struct pcc_chan_info {
 	struct pcc_mbox_chan chan;
@@ -100,12 +101,15 @@ struct pcc_chan_info {
 	struct pcc_chan_reg cmd_update;
 	struct pcc_chan_reg error;
 	int plat_irq;
+	u8 type;
 };
 
 #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
 static struct pcc_chan_info *chan_info;
 static int pcc_chan_count;
 
+static int pcc_send_data(struct mbox_chan *chan, void *data);
+
 /*
  * PCC can be used with perf critical drivers such as CPPC
  * So it makes sense to locally cache the virtual address and
@@ -221,6 +225,43 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
 	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
 }
 
+static bool pcc_chan_command_complete(struct pcc_chan_info *pchan,
+				      u64 cmd_complete_reg_val)
+{
+	bool complete;
+
+	if (!pchan->cmd_complete.gas)
+		return true;
+
+	cmd_complete_reg_val &= pchan->cmd_complete.status_mask;
+
+	switch (pchan->type) {
+	case ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE:
+		/*
+		 * If this channel with the PCC master subspace is in use,
+		 * the command complete bit is 1 indicates that the executing
+		 * command has been completed by Platform and OSPM needs to
+		 * process the response.
+		 */
+		complete = cmd_complete_reg_val != 0;
+		break;
+	case ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE:
+		/*
+		 * If this channel with the PCC slave subspace is in use,
+		 * the command complete bit is 0 indicates that Platform is
+		 * sending a notification and OSPM needs to response the
+		 * interrupt to process this command.
+		 */
+		complete = cmd_complete_reg_val == 0;
+		break;
+	default:
+		complete = true;
+		break;
+	}
+
+	return complete;
+}
+
 /**
  * pcc_mbox_irq - PCC mailbox interrupt handler
  * @irq:	interrupt number
@@ -240,12 +281,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
 	if (ret)
 		return IRQ_NONE;
-
-	if (val) { /* Ensure GAS exists and value is non-zero */
-		val &= pchan->cmd_complete.status_mask;
-		if (!val)
-			return IRQ_NONE;
-	}
+	if (!pcc_chan_command_complete(pchan, val))
+		return IRQ_NONE;
 
 	ret = pcc_chan_reg_read(&pchan->error, &val);
 	if (ret)
@@ -262,6 +299,13 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 
 	mbox_chan_received_data(chan, NULL);
 
+	/*
+	 * The PCC slave subspace channel needs to set the command complete bit
+	 * and ring doorbell after processing message.
+	 */
+	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+		pcc_send_data(chan, NULL);
+
 	return IRQ_HANDLED;
 }
 
@@ -692,6 +736,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 
 		pcc_parse_subspace_shmem(pchan, pcct_entry);
 
+		pchan->type = pcct_entry->type;
 		pcct_entry = (struct acpi_subtable_header *)
 			((unsigned long) pcct_entry + pcct_entry->length);
 	}
-- 
2.33.0

