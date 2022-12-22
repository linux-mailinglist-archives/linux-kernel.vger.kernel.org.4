Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA0654622
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiLVSvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiLVSvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:51:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C44A322B0A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:51:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0892153B;
        Thu, 22 Dec 2022 10:51:52 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B5383FA32;
        Thu, 22 Dec 2022 10:51:10 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, Ludvig.Parsson@axis.com,
        cristian.marussi@arm.com
Subject: [PATCH 4/9] firmware: arm_scmi: Add common notifier helpers
Date:   Thu, 22 Dec 2022 18:50:44 +0000
Message-Id: <20221222185049.737625-5-cristian.marussi@arm.com>
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

Add a pair of notifier chains and generic empty notifier callbacks: still
currently unused but they will be used to act properly on device request
and creation events.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/bus.c    |  6 ++-
 drivers/firmware/arm_scmi/common.h |  5 ++
 drivers/firmware/arm_scmi/driver.c | 83 +++++++++++++++++++++++++++++-
 3 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 089957f5fb9b..bed566f58029 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -15,6 +15,9 @@
 
 #include "common.h"
 
+BLOCKING_NOTIFIER_HEAD(scmi_requested_devices_nh);
+EXPORT_SYMBOL_GPL(scmi_requested_devices_nh);
+
 static DEFINE_IDA(scmi_bus_id);
 
 static const struct scmi_device_id *
@@ -94,12 +97,13 @@ static void scmi_dev_remove(struct device *dev)
 		scmi_drv->remove(scmi_dev);
 }
 
-static struct bus_type scmi_bus_type = {
+struct bus_type scmi_bus_type = {
 	.name =	"scmi_protocol",
 	.match = scmi_dev_match,
 	.probe = scmi_dev_probe,
 	.remove = scmi_dev_remove,
 };
+EXPORT_SYMBOL_GPL(scmi_bus_type);
 
 int scmi_driver_register(struct scmi_driver *driver, struct module *owner,
 			 const char *mod_name)
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 6a38244494fd..7ddae90eb945 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -105,6 +105,11 @@ void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
 
 int __init scmi_bus_init(void);
 void __exit scmi_bus_exit(void);
+extern struct bus_type scmi_bus_type;
+
+#define SCMI_BUS_NOTIFY_DEVICE_REQUEST		0
+#define SCMI_BUS_NOTIFY_DEVICE_UNREQUEST	1
+extern struct blocking_notifier_head scmi_requested_devices_nh;
 
 int scmi_protocol_acquire(const struct scmi_handle *handle, u8 protocol_id);
 void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index d1e32ea6d90a..62760bed1645 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -150,6 +150,9 @@ struct scmi_protocol_instance {
  * @notify_priv: Pointer to private data structure specific to notifications.
  * @node: List head
  * @users: Number of users of this instance
+ * @bus_nb: A notifier to listen for device bind/unbind on the scmi bus
+ * @dev_req_nb: A notifier to listen for device request/unrequest on the scmi
+ *		bus
  */
 struct scmi_info {
 	struct device *dev;
@@ -169,9 +172,13 @@ struct scmi_info {
 	void *notify_priv;
 	struct list_head node;
 	int users;
+	struct notifier_block bus_nb;
+	struct notifier_block dev_req_nb;
 };
 
 #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
+#define bus_nb_to_scmi_info(nb)	container_of(nb, struct scmi_info, bus_nb)
+#define req_nb_to_scmi_info(nb)	container_of(nb, struct scmi_info, dev_req_nb)
 
 static const int scmi_linux_errmap[] = {
 	/* better than switch case as long as return value is continuous */
@@ -2509,6 +2516,60 @@ static void scmi_cleanup_txrx_channels(struct scmi_info *info)
 	scmi_cleanup_channels(info, &info->rx_idr);
 }
 
+static int scmi_bus_notifier(struct notifier_block *nb,
+			     unsigned long action, void *data)
+{
+	struct scmi_info *info = bus_nb_to_scmi_info(nb);
+	struct scmi_device *sdev = to_scmi_dev(data);
+
+	/* Skip transport devices and devices of different SCMI instances */
+	if (!strncmp(sdev->name, "__scmi_transport_device", 23) ||
+	    sdev->dev.parent != info->dev)
+		return NOTIFY_DONE;
+
+	switch (action) {
+	case BUS_NOTIFY_BIND_DRIVER:
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	dev_dbg(info->dev, "Device %s (%s) is now %s\n", dev_name(&sdev->dev),
+		sdev->name, action == BUS_NOTIFY_BIND_DRIVER ?
+		"about to be BOUND." : "UNBOUND.");
+
+	return NOTIFY_OK;
+}
+
+static int scmi_device_request_notifier(struct notifier_block *nb,
+					unsigned long action, void *data)
+{
+	struct device_node *np;
+	struct scmi_device_id *id_table = data;
+	struct scmi_info *info = req_nb_to_scmi_info(nb);
+
+	np = idr_find(&info->active_protocols, id_table->protocol_id);
+	if (!np)
+		return NOTIFY_DONE;
+
+	dev_dbg(info->dev, "%sRequested device (%s) for protocol 0x%x\n",
+		action == SCMI_BUS_NOTIFY_DEVICE_REQUEST ? "" : "UN-",
+		id_table->name, id_table->protocol_id);
+
+	switch (action) {
+	case SCMI_BUS_NOTIFY_DEVICE_REQUEST:
+		break;
+	case SCMI_BUS_NOTIFY_DEVICE_UNREQUEST:
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
 static int scmi_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -2528,6 +2589,8 @@ static int scmi_probe(struct platform_device *pdev)
 
 	info->dev = dev;
 	info->desc = desc;
+	info->bus_nb.notifier_call = scmi_bus_notifier;
+	info->dev_req_nb.notifier_call = scmi_device_request_notifier;
 	INIT_LIST_HEAD(&info->node);
 	idr_init(&info->protocols);
 	mutex_init(&info->protocols_mtx);
@@ -2563,10 +2626,19 @@ static int scmi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = scmi_xfer_info_init(info);
+	ret = bus_register_notifier(&scmi_bus_type, &info->bus_nb);
 	if (ret)
 		goto clear_txrx_setup;
 
+	ret = blocking_notifier_chain_register(&scmi_requested_devices_nh,
+					       &info->dev_req_nb);
+	if (ret)
+		goto clear_bus_notifier;
+
+	ret = scmi_xfer_info_init(info);
+	if (ret)
+		goto clear_dev_req_notifier;
+
 	if (scmi_notification_init(handle))
 		dev_err(dev, "SCMI Notifications NOT available.\n");
 
@@ -2624,6 +2696,11 @@ static int scmi_probe(struct platform_device *pdev)
 
 notification_exit:
 	scmi_notification_exit(&info->handle);
+clear_dev_req_notifier:
+	blocking_notifier_chain_unregister(&scmi_requested_devices_nh,
+					   &info->dev_req_nb);
+clear_bus_notifier:
+	bus_unregister_notifier(&scmi_bus_type, &info->bus_nb);
 clear_txrx_setup:
 	scmi_cleanup_txrx_channels(info);
 	return ret;
@@ -2652,6 +2729,10 @@ static int scmi_remove(struct platform_device *pdev)
 		of_node_put(child);
 	idr_destroy(&info->active_protocols);
 
+	blocking_notifier_chain_unregister(&scmi_requested_devices_nh,
+					   &info->dev_req_nb);
+	bus_unregister_notifier(&scmi_bus_type, &info->bus_nb);
+
 	/* Safe to free channels since no more users */
 	scmi_cleanup_txrx_channels(info);
 
-- 
2.34.1

