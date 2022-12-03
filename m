Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23006641575
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 10:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiLCJvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 04:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiLCJvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 04:51:43 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED5C68C44;
        Sat,  3 Dec 2022 01:51:41 -0800 (PST)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NPQ6m21fVz15N2q;
        Sat,  3 Dec 2022 17:50:56 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Dec 2022 17:51:39 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <robbiek@xsightlabs.com>, <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>,
        <lihuisong@huawei.com>
Subject: [RFC-V3 1/2] mailbox: pcc: Add processing platform notification for slave subspaces
Date:   Sat, 3 Dec 2022 17:51:49 +0800
Message-ID: <20221203095150.45422-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221203095150.45422-1-lihuisong@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20221203095150.45422-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

This patch introduces a communication flow direction field to detect
whether the interrupt belongs to the master or slave subspace channel.
And PCC driver needs to add the phase of setting the command complete
and ring doorbell in pcc_mbox_irq() to complete type4 communication
flow after processing command from Platform.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/mailbox/pcc.c | 77 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 105d46c9801b..ad6d0b7d50fc 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -80,6 +80,13 @@ struct pcc_chan_reg {
 	u64 status_mask;
 };
 
+enum pcc_chan_comm_flow_dir_type {
+	PCC_ONLY_OSPM_TO_PLATFORM,
+	PCC_ONLY_PLATFORM_TO_OSPM,
+	PCC_BIDIRECTIONAL,
+	PCC_DIR_UNKNOWN,
+};
+
 /**
  * struct pcc_chan_info - PCC channel specific information
  *
@@ -91,6 +98,7 @@ struct pcc_chan_reg {
  * @cmd_update: PCC register bundle for the command complete update register
  * @error: PCC register bundle for the error status register
  * @plat_irq: platform interrupt
+ * @comm_flow_dir: direction of communication flow supported by the channel
  */
 struct pcc_chan_info {
 	struct pcc_mbox_chan chan;
@@ -100,12 +108,15 @@ struct pcc_chan_info {
 	struct pcc_chan_reg cmd_update;
 	struct pcc_chan_reg error;
 	int plat_irq;
+	u8 comm_flow_dir;
 };
 
 #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
 static struct pcc_chan_info *chan_info;
 static int pcc_chan_count;
 
+static int pcc_send_data(struct mbox_chan *chan, void *data);
+
 /*
  * PCC can be used with perf critical drivers such as CPPC
  * So it makes sense to locally cache the virtual address and
@@ -221,6 +232,43 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
 	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
 }
 
+static bool pcc_chan_need_rsp_irq(struct pcc_chan_info *pchan,
+				  u64 cmd_complete_reg_val)
+{
+	bool need_rsp;
+
+	if (!pchan->cmd_complete.gas)
+		return true;
+
+	cmd_complete_reg_val &= pchan->cmd_complete.status_mask;
+
+	switch (pchan->comm_flow_dir) {
+	case PCC_ONLY_OSPM_TO_PLATFORM:
+		/*
+		 * For the communication flow from OSPM to Platform, if this
+		 * channel is in use, command complete bit is 1 indicates that
+		 * the executing command has been completed by Platform and OSPM
+		 * needs to process response.
+		 */
+		need_rsp = cmd_complete_reg_val != 0;
+		break;
+	case PCC_ONLY_PLATFORM_TO_OSPM:
+		/*
+		 * For the communication flow from Platform to OSPM, if this
+		 * channel is in use, command complete bit is 0 indicates that
+		 * Platform is sending a notification and OSPM needs to response
+		 * the interrupt to process this command.
+		 */
+		need_rsp = cmd_complete_reg_val == 0;
+		break;
+	default:
+		need_rsp = true;
+		break;
+	}
+
+	return need_rsp;
+}
+
 /**
  * pcc_mbox_irq - PCC mailbox interrupt handler
  * @irq:	interrupt number
@@ -240,12 +288,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
 	if (ret)
 		return IRQ_NONE;
-
-	if (val) { /* Ensure GAS exists and value is non-zero */
-		val &= pchan->cmd_complete.status_mask;
-		if (!val)
-			return IRQ_NONE;
-	}
+	if (!pcc_chan_need_rsp_irq(pchan, val))
+		return IRQ_NONE;
 
 	ret = pcc_chan_reg_read(&pchan->error, &val);
 	if (ret)
@@ -262,6 +306,14 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 
 	mbox_chan_received_data(chan, NULL);
 
+	/*
+	 * For communication flow from Platform to OSPM (like, slave subspace),
+	 * need to set the command complete bit and ring doorbell after
+	 * processing message.
+	 */
+	if (pchan->comm_flow_dir == PCC_ONLY_PLATFORM_TO_OSPM)
+		pcc_send_data(chan, NULL);
+
 	return IRQ_HANDLED;
 }
 
@@ -613,6 +665,18 @@ static int __init acpi_pcc_probe(void)
 	return rc;
 }
 
+static void pcc_set_chan_comm_flow_dir(struct pcc_chan_info *pchan, u8 type)
+{
+	if (type <= ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2)
+		pchan->comm_flow_dir = PCC_BIDIRECTIONAL;
+	else if (type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE)
+		pchan->comm_flow_dir = PCC_ONLY_OSPM_TO_PLATFORM;
+	else if (type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+		pchan->comm_flow_dir = PCC_ONLY_PLATFORM_TO_OSPM;
+	else
+		pchan->comm_flow_dir = PCC_DIR_UNKNOWN;
+}
+
 /**
  * pcc_mbox_probe - Called when we find a match for the
  *	PCCT platform device. This is purely used to represent
@@ -686,6 +750,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 			if (rc < 0)
 				goto err;
 		}
+		pcc_set_chan_comm_flow_dir(pchan, pcct_entry->type);
 		rc = pcc_parse_subspace_db_reg(pchan, pcct_entry);
 		if (rc < 0)
 			goto err;
-- 
2.33.0

