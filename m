Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7567B6B9141
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjCNLN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCNLNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:13:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAE4746EC;
        Tue, 14 Mar 2023 04:13:15 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PbW7Y6862zrTLG;
        Tue, 14 Mar 2023 19:11:53 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 19:12:46 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <robbiek@xsightlabs.com>, <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>,
        <lihuisong@huawei.com>
Subject: [PATCH v2 2/2] mailbox: pcc: Support shared interrupt for multiple subspaces
Date:   Tue, 14 Mar 2023 19:11:35 +0800
Message-ID: <20230314111135.16520-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20230314111135.16520-1-lihuisong@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230314111135.16520-1-lihuisong@huawei.com>
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

If the platform acknowledge interrupt is level triggered, then it can
be shared by multiple subspaces provided each one has a unique platform
interrupt ack preserve and ack set masks.

If it can be shared, then we can request the irq with IRQF_SHARED and
IRQF_ONESHOT flags. The first one indicating it can be shared and the
latter one to keep the interrupt disabled until the hardirq handler
finished.

Further, since there is no way to detect if the interrupt is for a given
channel as the interrupt ack preserve and ack set masks are for clearing
the interrupt and not for reading the status(in case Irq Ack register
may be write-only on some platforms), we need a way to identify if the
given channel is in use and expecting the interrupt.

PCC type0, type1 and type5 do not support shared level triggered interrupt.
The methods of determining whether a given channel for remaining types
should respond to an interrupt are as follows:
 - type2: Whether the interrupt belongs to a given channel is only
          determined by the status field in Generic Communications Channel
          Shared Memory Region, which is done in rx_callback of PCC client.
 - type3: This channel checks chan_in_use flag first and then checks the
          command complete bit(value '1' indicates that the command has
          been completed).
 - type4: Platform ensure that the default value of the command complete
          bit corresponding to the type4 channel is '1'. This command
          complete bit is '0' when receive a platform notification.

The new field, 'chan_in_use' is used by the type only support the
communication from OSPM to Platform (like type3) and should be completely
ignored by other types so as to avoid too many type unnecessary checks in
IRQ handler.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/mailbox/pcc.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index a0a87c480d8b..7804dcf72646 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -92,6 +92,13 @@ struct pcc_chan_reg {
  * @error: PCC register bundle for the error status register
  * @plat_irq: platform interrupt
  * @type: PCC subspace type
+ * @plat_irq_flags: platform interrupt flags
+ * @chan_in_use: this flag is used just to check if the interrupt needs
+ *		handling when it is shared. Since only one transfer can occur
+ *		at a time and mailbox takes care of locking, this flag can be
+ *		accessed without a lock. Note: the type only support the
+ *		communication from OSPM to Platform, like type3, use it, and
+ *		other types completely ignore it.
  */
 struct pcc_chan_info {
 	struct pcc_mbox_chan chan;
@@ -102,6 +109,8 @@ struct pcc_chan_info {
 	struct pcc_chan_reg error;
 	int plat_irq;
 	u8 type;
+	unsigned int plat_irq_flags;
+	bool chan_in_use;
 };
 
 #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
@@ -225,6 +234,12 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
 	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
 }
 
+static bool pcc_chan_plat_irq_can_be_shared(struct pcc_chan_info *pchan)
+{
+	return (pchan->plat_irq_flags & ACPI_PCCT_INTERRUPT_MODE) ==
+		ACPI_LEVEL_SENSITIVE;
+}
+
 static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
 {
 	u64 val;
@@ -268,6 +283,10 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	int ret;
 
 	pchan = chan->con_priv;
+	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
+	    !pchan->chan_in_use)
+		return IRQ_NONE;
+
 	if (!pcc_mbox_cmd_complete_check(pchan))
 		return IRQ_NONE;
 
@@ -289,9 +308,12 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	/*
 	 * The PCC slave subspace channel needs to set the command complete bit
 	 * and ring doorbell after processing message.
+	 *
+	 * The PCC master subspace channel clears chan_in_use to free channel.
 	 */
 	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
 		pcc_send_data(chan, NULL);
+	pchan->chan_in_use = false;
 
 	return IRQ_HANDLED;
 }
@@ -340,10 +362,13 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	if (pchan->plat_irq > 0) {
+		unsigned long irqflags;
 		int rc;
 
-		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
-				      MBOX_IRQ_NAME, chan);
+		irqflags = pcc_chan_plat_irq_can_be_shared(pchan) ?
+					IRQF_SHARED | IRQF_ONESHOT : 0;
+		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq,
+				      irqflags, MBOX_IRQ_NAME, chan);
 		if (unlikely(rc)) {
 			dev_err(dev, "failed to register PCC interrupt %d\n",
 				pchan->plat_irq);
@@ -405,7 +430,11 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 	if (ret)
 		return ret;
 
-	return pcc_chan_reg_read_modify_write(&pchan->db);
+	ret = pcc_chan_reg_read_modify_write(&pchan->db);
+	if (!ret && pchan->plat_irq > 0)
+		pchan->chan_in_use = true;
+
+	return ret;
 }
 
 static const struct mbox_chan_ops pcc_chan_ops = {
@@ -488,6 +517,7 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
 		       pcct_ss->platform_interrupt);
 		return -EINVAL;
 	}
+	pchan->plat_irq_flags = pcct_ss->flags;
 
 	if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
 		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;
@@ -509,6 +539,12 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
 					"PLAT IRQ ACK");
 	}
 
+	if (pcc_chan_plat_irq_can_be_shared(pchan) &&
+	    !pchan->plat_irq_ack.gas) {
+		pr_err("PCC subspace has level IRQ with no ACK register\n");
+		return -EINVAL;
+	}
+
 	return ret;
 }
 
-- 
2.33.0

