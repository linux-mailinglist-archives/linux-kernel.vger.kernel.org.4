Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216746CA977
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjC0PqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjC0Pp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:45:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04DD410C9;
        Mon, 27 Mar 2023 08:45:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01367143D;
        Mon, 27 Mar 2023 08:46:42 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 631AB3F6C4;
        Mon, 27 Mar 2023 08:45:56 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     sudeep.holla@arm.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, nicola.mazzucato@arm.com,
        cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v2 2/2] firmware: arm_scmi: Add support for unidirectional mailbox channels
Date:   Mon, 27 Mar 2023 16:45:28 +0100
Message-Id: <20230327154528.460836-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327154528.460836-1-cristian.marussi@arm.com>
References: <20230327154528.460836-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the SCMI transport layer to support mailbox controllers that expose
communication channels that are unidirectional by nature.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/mailbox.c | 95 +++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 112c285deb97..1efa5e9392c4 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -19,13 +19,15 @@
  * struct scmi_mailbox - Structure representing a SCMI mailbox transport
  *
  * @cl: Mailbox Client
- * @chan: Transmit/Receive mailbox channel
+ * @chan: Transmit/Receive mailbox uni/bi-directional channel
+ * @chan_receiver: Optional Receiver mailbox unidirectional channel
  * @cinfo: SCMI channel info
  * @shmem: Transmit/Receive shared memory area
  */
 struct scmi_mailbox {
 	struct mbox_client cl;
 	struct mbox_chan *chan;
+	struct mbox_chan *chan_receiver;
 	struct scmi_chan_info *cinfo;
 	struct scmi_shared_mem __iomem *shmem;
 };
@@ -48,30 +50,62 @@ static void rx_callback(struct mbox_client *cl, void *m)
 
 static bool mailbox_chan_available(struct device_node *of_node, int idx)
 {
+	int num_mb;
+
+	/*
+	 * Just check if bidirrectional channels are involved, and check the
+	 * index accordingly; proper full validation will be made later
+	 * in mailbox_chan_setup().
+	 */
+	num_mb = of_count_phandle_with_args(of_node, "mboxes", "#mbox-cells");
+	if (num_mb == 3 && idx == 1)
+		idx = 2;
+
 	return !of_parse_phandle_with_args(of_node, "mboxes",
 					   "#mbox-cells", idx, NULL);
 }
 
-static int mailbox_chan_validate(struct device *cdev)
+/**
+ * mailbox_chan_validate  - Validate transport configuration and map channels
+ *
+ * @cdev: Reference to the underlying transport device carrying the
+ *	  of_node descriptor to analyze.
+ * @a2p_rx_chan: A reference to an optional unidirectional channel to use
+ *		 for replies on the a2p channel. Set as zero if not present.
+ * @p2a_chan: A reference to the optional p2a channel.
+ *	      Set as zero if not present.
+ *
+ * At first, validate the transport configuration as described in terms of
+ * 'mboxes' and 'shmem', then determin which mailbox channel indexes are
+ * appropriate to be use in the current configuration.
+ *
+ * Return: 0 on Success or error
+ */
+static int mailbox_chan_validate(struct device *cdev,
+				 int *a2p_rx_chan, int *p2a_chan)
 {
 	int num_mb, num_sh, ret = 0;
 	struct device_node *np = cdev->of_node;
 
 	num_mb = of_count_phandle_with_args(np, "mboxes", "#mbox-cells");
 	num_sh = of_count_phandle_with_args(np, "shmem", NULL);
+	dev_dbg(cdev, "Found %d mboxes and %d shmems !\n", num_mb, num_sh);
+
 	/* Bail out if mboxes and shmem descriptors are inconsistent */
-	if (num_mb <= 0 || num_sh > 2 || num_mb != num_sh) {
-		dev_warn(cdev, "Invalid channel descriptor for '%s'\n",
-			 of_node_full_name(np));
+	if (num_mb <= 0 || num_sh <= 0 || num_sh > 2 || num_mb > 3 ||
+	    (num_mb == 1 && num_sh != 1) || (num_mb == 3 && num_sh != 2)) {
+		dev_warn(cdev,
+			 "Invalid channel descriptor for '%s' - mbs:%d  shm:%d\n",
+			 of_node_full_name(np), num_mb, num_sh);
 		return -EINVAL;
 	}
 
+	/* Bail out if provided shmem descriptors do not refer distinct areas  */
 	if (num_sh > 1) {
 		struct device_node *np_tx, *np_rx;
 
 		np_tx = of_parse_phandle(np, "shmem", 0);
 		np_rx = of_parse_phandle(np, "shmem", 1);
-		/* SCMI Tx and Rx shared mem areas have to be distinct */
 		if (!np_tx || !np_rx || np_tx == np_rx) {
 			dev_warn(cdev, "Invalid shmem descriptor for '%s'\n",
 				 of_node_full_name(np));
@@ -82,6 +116,29 @@ static int mailbox_chan_validate(struct device *cdev)
 		of_node_put(np_rx);
 	}
 
+	/* Calculate channels IDs to use depending on mboxes/shmem layout */
+	if (!ret) {
+		switch (num_mb) {
+		case 1:
+			*a2p_rx_chan = 0;
+			*p2a_chan = 0;
+			break;
+		case 2:
+			if (num_sh == 2) {
+				*a2p_rx_chan = 0;
+				*p2a_chan = 1;
+			} else {
+				*a2p_rx_chan = 1;
+				*p2a_chan = 0;
+			}
+			break;
+		case 3:
+			*a2p_rx_chan = 1;
+			*p2a_chan = 2;
+			break;
+		}
+	}
+
 	return ret;
 }
 
@@ -92,15 +149,18 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	struct device *cdev = cinfo->dev;
 	struct scmi_mailbox *smbox;
 	struct device_node *shmem;
-	int ret, idx = tx ? 0 : 1;
+	int ret, a2p_rx_chan, p2a_chan, idx = tx ? 0 : 1;
 	struct mbox_client *cl;
 	resource_size_t size;
 	struct resource res;
 
-	ret = mailbox_chan_validate(cdev);
+	ret = mailbox_chan_validate(cdev, &a2p_rx_chan, &p2a_chan);
 	if (ret)
 		return ret;
 
+	if (!tx && !p2a_chan)
+		return -ENODEV;
+
 	smbox = devm_kzalloc(dev, sizeof(*smbox), GFP_KERNEL);
 	if (!smbox)
 		return -ENOMEM;
@@ -130,15 +190,26 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
 	cl->tx_block = false;
 	cl->knows_txdone = tx;
 
-	smbox->chan = mbox_request_channel(cl, tx ? 0 : 1);
+	smbox->chan = mbox_request_channel(cl, tx ? 0 : p2a_chan);
 	if (IS_ERR(smbox->chan)) {
 		ret = PTR_ERR(smbox->chan);
 		if (ret != -EPROBE_DEFER)
-			dev_err(cdev, "failed to request SCMI %s mailbox\n",
-				tx ? "Tx" : "Rx");
+			dev_err(cdev,
+				"failed to request SCMI %s mailbox\n", desc);
 		return ret;
 	}
 
+	/* Additional unidirectional channel for TX if needed */
+	if (tx && a2p_rx_chan) {
+		smbox->chan_receiver = mbox_request_channel(cl, a2p_rx_chan);
+		if (IS_ERR(smbox->chan_receiver)) {
+			ret = PTR_ERR(smbox->chan_receiver);
+			if (ret != -EPROBE_DEFER)
+				dev_err(cdev, "failed to request SCMI Tx Receiver mailbox\n");
+			return ret;
+		}
+	}
+
 	cinfo->transport_info = smbox;
 	smbox->cinfo = cinfo;
 
@@ -152,8 +223,10 @@ static int mailbox_chan_free(int id, void *p, void *data)
 
 	if (smbox && !IS_ERR(smbox->chan)) {
 		mbox_free_channel(smbox->chan);
+		mbox_free_channel(smbox->chan_receiver);
 		cinfo->transport_info = NULL;
 		smbox->chan = NULL;
+		smbox->chan_receiver = NULL;
 		smbox->cinfo = NULL;
 	}
 
-- 
2.34.1

