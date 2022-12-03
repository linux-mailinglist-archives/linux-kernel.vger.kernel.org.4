Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BDB641574
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 10:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLCJvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 04:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLCJvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 04:51:44 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B9B68C4A;
        Sat,  3 Dec 2022 01:51:42 -0800 (PST)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NPQ3f05YpzkXn6;
        Sat,  3 Dec 2022 17:48:13 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Dec 2022 17:51:40 +0800
From:   Huisong Li <lihuisong@huawei.com>
To:     <robbiek@xsightlabs.com>, <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>,
        <lihuisong@huawei.com>
Subject: [RFC-V3 2/2] mailbox: pcc: Support shared interrupt for multiple subspaces
Date:   Sat, 3 Dec 2022 17:51:50 +0800
Message-ID: <20221203095150.45422-3-lihuisong@huawei.com>
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

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/mailbox/pcc.c | 46 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index ad6d0b7d50fc..90e9cc324081 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -99,6 +99,10 @@ enum pcc_chan_comm_flow_dir_type {
  * @error: PCC register bundle for the error status register
  * @plat_irq: platform interrupt
  * @comm_flow_dir: direction of communication flow supported by the channel
+ * @plat_irq_flags: platform interrupt flags
+ * @chan_in_use: flag indicating whether the channel is in use or not when use
+ *               platform interrupt, and only use it for communication from OSPM
+ *               to Platform.
  */
 struct pcc_chan_info {
 	struct pcc_mbox_chan chan;
@@ -109,6 +113,8 @@ struct pcc_chan_info {
 	struct pcc_chan_reg error;
 	int plat_irq;
 	u8 comm_flow_dir;
+	unsigned int plat_irq_flags;
+	bool chan_in_use;
 };
 
 #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
@@ -232,6 +238,12 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
 	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
 }
 
+static bool pcc_chan_plat_irq_can_be_shared(struct pcc_chan_info *pchan)
+{
+	return (pchan->plat_irq_flags & ACPI_PCCT_INTERRUPT_MODE) ==
+		ACPI_LEVEL_SENSITIVE;
+}
+
 static bool pcc_chan_need_rsp_irq(struct pcc_chan_info *pchan,
 				  u64 cmd_complete_reg_val)
 {
@@ -284,6 +296,9 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	int ret;
 
 	pchan = chan->con_priv;
+	if (pchan->comm_flow_dir == PCC_ONLY_OSPM_TO_PLATFORM &&
+	    !pchan->chan_in_use)
+		return IRQ_NONE;
 
 	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
 	if (ret)
@@ -310,9 +325,14 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 	 * For communication flow from Platform to OSPM (like, slave subspace),
 	 * need to set the command complete bit and ring doorbell after
 	 * processing message.
+	 *
+	 * For communication flow from OSPM to Platform, clear chan_in_use flag
+	 * to free this channel.
 	 */
 	if (pchan->comm_flow_dir == PCC_ONLY_PLATFORM_TO_OSPM)
 		pcc_send_data(chan, NULL);
+	else if (pchan->comm_flow_dir == PCC_ONLY_OSPM_TO_PLATFORM)
+		pchan->chan_in_use = false;
 
 	return IRQ_HANDLED;
 }
@@ -361,10 +381,13 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
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
@@ -426,7 +449,17 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 	if (ret)
 		return ret;
 
-	return pcc_chan_reg_read_modify_write(&pchan->db);
+	ret = pcc_chan_reg_read_modify_write(&pchan->db);
+	/*
+	 * For communication flow from OSPM to Platform, set chan_in_use flag
+	 * of this channel to true after ring doorbell, and clear this flag
+	 * when the reply message is processed.
+	 */
+	if (!ret && pchan->comm_flow_dir == PCC_ONLY_OSPM_TO_PLATFORM &&
+	    pchan->plat_irq > 0)
+		pchan->chan_in_use = true;
+
+	return ret;
 }
 
 static const struct mbox_chan_ops pcc_chan_ops = {
@@ -509,6 +542,7 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
 		       pcct_ss->platform_interrupt);
 		return -EINVAL;
 	}
+	pchan->plat_irq_flags = pcct_ss->flags;
 
 	if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
 		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;
@@ -530,6 +564,12 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
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

