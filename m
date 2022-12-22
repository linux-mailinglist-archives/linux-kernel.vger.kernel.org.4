Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7241654621
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiLVSvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLVSvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:51:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B74E122B26
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:51:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94FEDAD7;
        Thu, 22 Dec 2022 10:51:49 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23A133FA32;
        Thu, 22 Dec 2022 10:51:07 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, Ludvig.Parsson@axis.com,
        cristian.marussi@arm.com
Subject: [PATCH 2/9] firmware: arm_scmi: Use dedicated devices to initialize channels
Date:   Thu, 22 Dec 2022 18:50:42 +0000
Message-Id: <20221222185049.737625-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222185049.737625-1-cristian.marussi@arm.com>
References: <20221222185049.737625-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor channels initialization to use dedicated transport devices instead
of using devices borrowed from the SCMI drivers.

Initialize all channels, as described in the DT, upfront during SCMI core
stack probe phase and free all of them, including the underlying devices,
when the SCMI core is removed.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h  |   1 -
 drivers/firmware/arm_scmi/driver.c  | 158 ++++++++++++++++++++--------
 drivers/firmware/arm_scmi/mailbox.c |   2 -
 drivers/firmware/arm_scmi/optee.c   |   2 -
 drivers/firmware/arm_scmi/smc.c     |   2 -
 drivers/firmware/arm_scmi/virtio.c  |   2 -
 6 files changed, 116 insertions(+), 51 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 16db1e177123..136bfd30f99c 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -229,7 +229,6 @@ extern const struct scmi_desc scmi_optee_desc;
 #endif
 
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr, void *priv);
-void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id);
 
 /* shmem related declarations */
 struct scmi_shared_mem;
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index f1ebadffdfe4..f85b34e69d01 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1987,23 +1987,20 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
 	return ret;
 }
 
-static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
+static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 			   int prot_id, bool tx)
 {
 	int ret, idx;
+	char name[32];
 	struct scmi_chan_info *cinfo;
 	struct idr *idr;
+	struct scmi_device *tdev = NULL;
 
 	/* Transmit channel is first entry i.e. index 0 */
 	idx = tx ? 0 : 1;
 	idr = tx ? &info->tx_idr : &info->rx_idr;
 
-	/* check if already allocated, used for multiple device per protocol */
-	cinfo = idr_find(idr, prot_id);
-	if (cinfo)
-		return 0;
-
-	if (!info->desc->ops->chan_available(dev->of_node, idx)) {
+	if (!info->desc->ops->chan_available(of_node, idx)) {
 		cinfo = idr_find(idr, SCMI_PROTOCOL_BASE);
 		if (unlikely(!cinfo)) /* Possible only if platform has no Rx */
 			return -EINVAL;
@@ -2014,27 +2011,49 @@ static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
 	if (!cinfo)
 		return -ENOMEM;
 
-	cinfo->dev = dev;
 	cinfo->rx_timeout_ms = info->desc->max_rx_timeout_ms;
 
+	/* Create a unique name for this transport device */
+	snprintf(name, 32, "__scmi_transport_device_%s_%02X",
+		 idx ? "rx" : "tx", prot_id);
+	/* Create a uniquely named, dedicated transport device for this chan */
+	tdev = scmi_device_create(of_node, info->dev, prot_id, name);
+	if (!tdev) {
+		devm_kfree(info->dev, cinfo);
+		return -EINVAL;
+	}
+	of_node_get(of_node);
+
+	cinfo->dev = &tdev->dev;
 	ret = info->desc->ops->chan_setup(cinfo, info->dev, tx);
-	if (ret)
+	if (ret) {
+		of_node_put(of_node);
+		scmi_device_destroy(tdev);
+		devm_kfree(info->dev, cinfo);
 		return ret;
+	}
 
 	if (tx && is_polling_required(cinfo, info)) {
 		if (is_transport_polling_capable(info))
-			dev_info(dev,
+			dev_info(&tdev->dev,
 				 "Enabled polling mode TX channel - prot_id:%d\n",
 				 prot_id);
 		else
-			dev_warn(dev,
+			dev_warn(&tdev->dev,
 				 "Polling mode NOT supported by transport.\n");
 	}
 
 idr_alloc:
 	ret = idr_alloc(idr, cinfo, prot_id, prot_id + 1, GFP_KERNEL);
 	if (ret != prot_id) {
-		dev_err(dev, "unable to allocate SCMI idr slot err %d\n", ret);
+		dev_err(info->dev,
+			"unable to allocate SCMI idr slot err %d\n", ret);
+		/* Destroy channel and device only if created by this call. */
+		if (tdev) {
+			of_node_put(of_node);
+			scmi_device_destroy(tdev);
+			devm_kfree(info->dev, cinfo);
+		}
 		return ret;
 	}
 
@@ -2043,13 +2062,14 @@ static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
 }
 
 static inline int
-scmi_txrx_setup(struct scmi_info *info, struct device *dev, int prot_id)
+scmi_txrx_setup(struct scmi_info *info, struct device_node *of_node,
+		int prot_id)
 {
-	int ret = scmi_chan_setup(info, dev, prot_id, true);
+	int ret = scmi_chan_setup(info, of_node, prot_id, true);
 
 	if (!ret) {
 		/* Rx is optional, report only memory errors */
-		ret = scmi_chan_setup(info, dev, prot_id, false);
+		ret = scmi_chan_setup(info, of_node, prot_id, false);
 		if (ret && ret != -ENOMEM)
 			ret = 0;
 	}
@@ -2057,6 +2077,54 @@ scmi_txrx_setup(struct scmi_info *info, struct device *dev, int prot_id)
 	return ret;
 }
 
+/**
+ * scmi_channels_setup  - Helper to initialize all required channels
+ *
+ * @info: The SCMI instance descriptor.
+ *
+ * Initialize all the channels found described in the DT against the underlying
+ * configured transport using custom defined dedicated devices instead of
+ * borrowing devices from the SCMI drivers; this way channels are initialized
+ * upfront during core SCMI stack probing and are no more coupled with SCMI
+ * devices used by SCMI drivers.
+ *
+ * Note that, even though a pair of TX/RX channels is associated to each
+ * protocol defined in the DT, a distinct freshly initialized channel is
+ * created only if the DT node for the protocol at hand describes a dedicated
+ * channel: in all the other cases the common BASE protocol channel is reused.
+ *
+ * Return: 0 on Success
+ */
+static int scmi_channels_setup(struct scmi_info *info)
+{
+	int ret;
+	struct device_node *child, *top_np = info->dev->of_node;
+
+	/* Initialize a common generic channel at first */
+	ret = scmi_txrx_setup(info, top_np, SCMI_PROTOCOL_BASE);
+	if (ret)
+		return ret;
+
+	for_each_available_child_of_node(top_np, child) {
+		u32 prot_id;
+
+		if (of_property_read_u32(child, "reg", &prot_id))
+			continue;
+
+		if (!FIELD_FIT(MSG_PROTOCOL_ID_MASK, prot_id))
+			dev_err(info->dev,
+				"Out of range protocol %d\n", prot_id);
+
+		ret = scmi_txrx_setup(info, child, prot_id);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * scmi_get_protocol_device  - Helper to get/create an SCMI device.
  *
@@ -2106,14 +2174,6 @@ scmi_get_protocol_device(struct device_node *np, struct scmi_info *info,
 		return NULL;
 	}
 
-	if (scmi_txrx_setup(info, &sdev->dev, prot_id)) {
-		dev_err(&sdev->dev, "failed to setup transport\n");
-		scmi_device_destroy(sdev);
-		mutex_unlock(&scmi_syspower_mtx);
-
-		return NULL;
-	}
-
 	if (prot_id == SCMI_PROTOCOL_SYSTEM)
 		scmi_syspower_registered = true;
 
@@ -2347,19 +2407,39 @@ void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table)
 	mutex_unlock(&scmi_requested_devices_mtx);
 }
 
-static int scmi_cleanup_txrx_channels(struct scmi_info *info)
+static int scmi_chan_destroy(int id, void *p, void *idr)
 {
-	int ret;
-	struct idr *idr = &info->tx_idr;
+	struct scmi_chan_info *cinfo = p;
+
+	if (cinfo->dev) {
+		struct scmi_device *sdev = to_scmi_dev(cinfo->dev);
 
-	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
-	idr_destroy(&info->tx_idr);
+		of_node_put(cinfo->dev->of_node);
+		scmi_device_destroy(sdev);
+		cinfo->dev = NULL;
+	}
 
-	idr = &info->rx_idr;
-	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
-	idr_destroy(&info->rx_idr);
+	idr_remove(idr, id);
 
-	return ret;
+	return 0;
+}
+
+static void scmi_cleanup_channels(struct scmi_info *info, struct idr *idr)
+{
+	/* At first free all channels at the transport layer ... */
+	idr_for_each(idr, info->desc->ops->chan_free, idr);
+
+	/* ...then destroy all underlying devices */
+	idr_for_each(idr, scmi_chan_destroy, idr);
+
+	idr_destroy(idr);
+}
+
+static void scmi_cleanup_txrx_channels(struct scmi_info *info)
+{
+	scmi_cleanup_channels(info, &info->tx_idr);
+
+	scmi_cleanup_channels(info, &info->rx_idr);
 }
 
 static int scmi_probe(struct platform_device *pdev)
@@ -2411,7 +2491,8 @@ static int scmi_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = scmi_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
+	/* Setup all channels described in the DT at first */
+	ret = scmi_channels_setup(info);
 	if (ret)
 		return ret;
 
@@ -2481,14 +2562,9 @@ static int scmi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id)
-{
-	idr_remove(idr, id);
-}
-
 static int scmi_remove(struct platform_device *pdev)
 {
-	int ret, id;
+	int id;
 	struct scmi_info *info = platform_get_drvdata(pdev);
 	struct device_node *child;
 
@@ -2510,9 +2586,7 @@ static int scmi_remove(struct platform_device *pdev)
 	idr_destroy(&info->active_protocols);
 
 	/* Safe to free channels since no more users */
-	ret = scmi_cleanup_txrx_channels(info);
-	if (ret)
-		dev_warn(&pdev->dev, "Failed to cleanup SCMI channels.\n");
+	scmi_cleanup_txrx_channels(info);
 
 	return 0;
 }
diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index c33dcadafea8..0d9c9538b7f4 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -120,8 +120,6 @@ static int mailbox_chan_free(int id, void *p, void *data)
 		smbox->cinfo = NULL;
 	}
 
-	scmi_free_channel(cinfo, data, id);
-
 	return 0;
 }
 
diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 5a11091c72da..929720387102 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -481,8 +481,6 @@ static int scmi_optee_chan_free(int id, void *p, void *data)
 	cinfo->transport_info = NULL;
 	channel->cinfo = NULL;
 
-	scmi_free_channel(cinfo, data, id);
-
 	return 0;
 }
 
diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index 122128d56d2f..93272e4bbd12 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -171,8 +171,6 @@ static int smc_chan_free(int id, void *p, void *data)
 	cinfo->transport_info = NULL;
 	scmi_info->cinfo = NULL;
 
-	scmi_free_channel(cinfo, data, id);
-
 	return 0;
 }
 
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index a917eca7d902..d68c01cb7aa0 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -489,8 +489,6 @@ static int virtio_chan_free(int id, void *p, void *data)
 	virtio_break_device(vioch->vqueue->vdev);
 	scmi_vio_channel_cleanup_sync(vioch);
 
-	scmi_free_channel(cinfo, data, id);
-
 	return 0;
 }
 
-- 
2.34.1

