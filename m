Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C926333F2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiKVDaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKVDah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:30:37 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8325EBF;
        Mon, 21 Nov 2022 19:30:34 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGVBN2nTpzRpNh;
        Tue, 22 Nov 2022 11:30:04 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 11:30:32 +0800
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 11:30:31 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <robbiek@xsightlabs.com>, <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>,
        <lihuisong@huawei.com>
Subject: [RFC V2] ACPI: PCC: Support shared interrupt for multiple subspaces
Date:   Tue, 22 Nov 2022 11:30:51 +0800
Message-ID: <20221122033051.15507-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221016034043.52227-1-lihuisong@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
the interrupt and not for reading the status, we need a way to identify
if the given channel is in use and expecting the interrupt.

The way and differences of identification interrupt of each types for a
given channel are as follows:
1) type0, type1 and type5: do not support shared level triggered interrupt.
2) type2: whether the interrupt belongs to a given channel is detected
          based on the status field in Generic Communications Channel
          Shared Memory Region during calling rx_callback in PCC client
          code.
3) type3: use the command complete register and chan_in_use flag to control
4) type4: use the command complete register and need to set the
          corresponding bit of salve subspace to 1 by default in platform.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Robbie King <robbiek@xsightlabs.com>
---
 -v2: don't use platform interrupt ack register to identify if the given
      channel should respond interrupt.

---
 drivers/mailbox/pcc.c | 130 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 116 insertions(+), 14 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 3c2bc0ca454c..674e214d64d1 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -80,6 +80,13 @@ struct pcc_chan_reg {
 	u64 status_mask;
 };
 
+enum pcc_chan_mesg_dir {
+	PCC_ONLY_AP_TO_SCP,
+	PCC_ONLY_SCP_TO_AP,
+	PCC_BIDIRECTIONAL,
+	PCC_DIR_UNKNOWN,
+};
+
 /**
  * struct pcc_chan_info - PCC channel specific information
  *
@@ -91,6 +98,10 @@ struct pcc_chan_reg {
  * @cmd_update: PCC register bundle for the command complete update register
  * @error: PCC register bundle for the error status register
  * @plat_irq: platform interrupt
+ * @plat_irq_flags: platform interrupt flags
+ * @chan_in_use: flag indicating whether the channel is in use or not when use
+ *               platform interrupt, and only use it for PCC_ONLY_AP_TO_SCP
+ * @mesg_dir: direction of message transmission supported by the channel
  */
 struct pcc_chan_info {
 	struct pcc_mbox_chan chan;
@@ -100,12 +111,17 @@ struct pcc_chan_info {
 	struct pcc_chan_reg cmd_update;
 	struct pcc_chan_reg error;
 	int plat_irq;
+	unsigned int plat_irq_flags;
+	bool chan_in_use;
+	u8 mesg_dir;
 };
 
 #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
 static struct pcc_chan_info *chan_info;
 static int pcc_chan_count;
 
+static int pcc_send_data(struct mbox_chan *chan, void *data);
+
 /*
  * PCC can be used with perf critical drivers such as CPPC
  * So it makes sense to locally cache the virtual address and
@@ -221,6 +237,47 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
 	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
 }
 
+static bool pcc_chan_plat_irq_can_be_shared(struct pcc_chan_info *pchan)
+{
+	return (pchan->plat_irq_flags & ACPI_PCCT_INTERRUPT_MODE) ==
+		ACPI_LEVEL_SENSITIVE;
+}
+
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
+	switch (pchan->mesg_dir) {
+	case PCC_ONLY_AP_TO_SCP:
+		/*
+		 * For the communication from AP to SCP, if this channel is in
+		 * use, command complete bit is 1 indicates that the command
+		 * being executed has been completed.
+		 */
+		need_rsp = cmd_complete_reg_val != 0;
+		break;
+	case PCC_ONLY_SCP_TO_AP:
+		/*
+		 * For the communication from SCP to AP， if this channel is in
+		 * use, command complete bit is 0 indicates that the bit has
+		 * been cleared and AP should response the interrupt.
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
@@ -232,37 +289,54 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 {
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan = p;
+	static irqreturn_t rc;
 	u64 val;
 	int ret;
 
 	pchan = chan->con_priv;
+	if (pchan->mesg_dir == PCC_ONLY_AP_TO_SCP && !pchan->chan_in_use)
+		return IRQ_NONE;
 
 	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
 	if (ret)
 		return IRQ_NONE;
+	if (!pcc_chan_need_rsp_irq(pchan, val))
+		return IRQ_NONE;
 
-	if (val) { /* Ensure GAS exists and value is non-zero */
-		val &= pchan->cmd_complete.status_mask;
-		if (!val)
-			return IRQ_NONE;
+	ret = pcc_chan_reg_read(&pchan->error, &val);
+	if (ret) {
+		rc = IRQ_NONE;
+		goto out;
 	}
 
-	ret = pcc_chan_reg_read(&pchan->error, &val);
-	if (ret)
-		return IRQ_NONE;
 	val &= pchan->error.status_mask;
 	if (val) {
 		val &= ~pchan->error.status_mask;
 		pcc_chan_reg_write(&pchan->error, val);
-		return IRQ_NONE;
+		rc = IRQ_NONE;
+		goto out;
 	}
 
-	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
-		return IRQ_NONE;
+	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack)) {
+		rc = IRQ_NONE;
+		goto out;
+	}
 
 	mbox_chan_received_data(chan, NULL);
+	/*
+	 * For slave subspace, need to set the command complete bit and ring
+	 * doorbell after processing message.
+	 */
+	if (pchan->mesg_dir == PCC_ONLY_SCP_TO_AP)
+		pcc_send_data(chan, NULL);
+
+	rc = IRQ_HANDLED;
 
-	return IRQ_HANDLED;
+out:
+	if (pchan->mesg_dir == PCC_ONLY_AP_TO_SCP)
+		pchan->chan_in_use = false;
+
+	return rc;
 }
 
 /**
@@ -309,10 +383,13 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	if (pchan->plat_irq > 0) {
+		unsigned long irqflags;
 		int rc;
 
-		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
-				      MBOX_IRQ_NAME, chan);
+		irqflags = pcc_chan_plat_irq_can_be_shared(pchan) ?
+				IRQF_SHARED | IRQF_ONESHOT : 0;
+		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq,
+				      irqflags, MBOX_IRQ_NAME, chan);
 		if (unlikely(rc)) {
 			dev_err(dev, "failed to register PCC interrupt %d\n",
 				pchan->plat_irq);
@@ -374,7 +451,12 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 	if (ret)
 		return ret;
 
-	return pcc_chan_reg_read_modify_write(&pchan->db);
+	ret = pcc_chan_reg_read_modify_write(&pchan->db);
+	if (!ret && pchan->mesg_dir == PCC_ONLY_AP_TO_SCP &&
+	    pchan->plat_irq > 0)
+		pchan->chan_in_use = true;
+
+	return ret;
 }
 
 static const struct mbox_chan_ops pcc_chan_ops = {
@@ -457,6 +539,7 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
 		       pcct_ss->platform_interrupt);
 		return -EINVAL;
 	}
+	pchan->plat_irq_flags = pcct_ss->flags;
 
 	if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
 		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;
@@ -478,6 +561,12 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
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
 
@@ -613,6 +702,18 @@ static int __init acpi_pcc_probe(void)
 	return rc;
 }
 
+static void pcc_set_chan_mesg_dir(struct pcc_chan_info *pchan, u8 type)
+{
+	if (type <= ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2)
+		pchan->mesg_dir = PCC_BIDIRECTIONAL;
+	else if (type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE)
+		pchan->mesg_dir = PCC_ONLY_AP_TO_SCP;
+	else if (type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+		pchan->mesg_dir = PCC_ONLY_AP_TO_SCP;
+	else
+		pchan->mesg_dir = PCC_DIR_UNKNOWN;
+}
+
 /**
  * pcc_mbox_probe - Called when we find a match for the
  *	PCCT platform device. This is purely used to represent
@@ -680,6 +781,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 			rc = -EINVAL;
 			goto err;
 		}
+		pcc_set_chan_mesg_dir(pchan, pcct_entry->type);
 
 		if (pcc_mbox_ctrl->txdone_irq) {
 			rc = pcc_parse_subspace_irq(pchan, pcct_entry);
-- 
2.33.0

