Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAE2654626
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiLVSvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiLVSvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:51:18 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A06E022BCE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:51:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84ACC1FB;
        Thu, 22 Dec 2022 10:51:57 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FF003FA32;
        Thu, 22 Dec 2022 10:51:15 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, Ludvig.Parsson@axis.com,
        cristian.marussi@arm.com
Subject: [PATCH 7/9] firmware: arm_scmi: Refactor device create/destroy helpers
Date:   Thu, 22 Dec 2022 18:50:47 +0000
Message-Id: <20221222185049.737625-8-cristian.marussi@arm.com>
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

Refactor SCMI device create/destroy helpers: it is now possible to ask
for the creation of all the currently requested devices for a whole
protocol, not only for the creation of a single well-defined device.

While at that, re-instate uniqueness checks on the creation of SCMI
SystemPower devices.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/bus.c    | 141 ++++++++++++++++++++++++++---
 drivers/firmware/arm_scmi/common.h |   8 +-
 drivers/firmware/arm_scmi/driver.c |   9 +-
 include/linux/scmi_protocol.h      |   5 -
 4 files changed, 141 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 61113def5a9a..190999a658b2 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/atomic.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -30,6 +31,9 @@ struct scmi_requested_dev {
 	struct list_head node;
 };
 
+/* Track globally the creation of SCMI SystemPower related devices */
+static atomic_t scmi_syspower_registered = ATOMIC_INIT(0);
+
 /**
  * scmi_protocol_device_request  - Helper to request a device
  *
@@ -213,11 +217,11 @@ static int scmi_match_by_id_table(struct device *dev, void *data)
 	struct scmi_device_id *id_table = data;
 
 	return sdev->protocol_id == id_table->protocol_id &&
-		!strcmp(sdev->name, id_table->name);
+		(id_table->name && !strcmp(sdev->name, id_table->name));
 }
 
-struct scmi_device *scmi_child_dev_find(struct device *parent,
-					int prot_id, const char *name)
+static struct scmi_device *scmi_child_dev_find(struct device *parent,
+					       int prot_id, const char *name)
 {
 	struct scmi_device_id id_table;
 	struct device *dev;
@@ -297,13 +301,53 @@ static void scmi_device_release(struct device *dev)
 	kfree(to_scmi_dev(dev));
 }
 
-struct scmi_device *
-scmi_device_create(struct device_node *np, struct device *parent, int protocol,
-		   const char *name)
+static void __scmi_device_destroy(struct scmi_device *scmi_dev)
+{
+	pr_debug("(%s) Destroying SCMI device '%s' for protocol 0x%x (%s)\n",
+		 of_node_full_name(scmi_dev->dev.parent->of_node),
+		 dev_name(&scmi_dev->dev), scmi_dev->protocol_id,
+		 scmi_dev->name);
+
+	if (scmi_dev->protocol_id == SCMI_PROTOCOL_SYSTEM)
+		atomic_set(&scmi_syspower_registered, 0);
+
+	kfree_const(scmi_dev->name);
+	ida_free(&scmi_bus_id, scmi_dev->id);
+	device_unregister(&scmi_dev->dev);
+}
+
+static struct scmi_device *
+__scmi_device_create(struct device_node *np, struct device *parent,
+		     int protocol, const char *name)
 {
 	int id, retval;
 	struct scmi_device *scmi_dev;
 
+	/*
+	 * If the same protocol/name device already exist under the same parent
+	 * (i.e. SCMI instance) just return the existent device.
+	 * This avoids any race between the SCMI driver, creating devices for
+	 * each DT defined protocol at probe time, and the concurrent
+	 * registration of SCMI drivers.
+	 */
+	scmi_dev = scmi_child_dev_find(parent, protocol, name);
+	if (scmi_dev)
+		return scmi_dev;
+
+	/*
+	 * Ignore any possible subsequent failures while creating the device
+	 * since we are doomed anyway at that point; not using a mutex which
+	 * spans across this whole function to keep things simple and to avoid
+	 * to serialize all the __scmi_device_create calls across possibly
+	 * different SCMI server instances (parent)
+	 */
+	if (protocol == SCMI_PROTOCOL_SYSTEM &&
+	    atomic_cmpxchg(&scmi_syspower_registered, 0, 1)) {
+		dev_warn(parent,
+			 "SCMI SystemPower protocol device must be unique !\n");
+		return NULL;
+	}
+
 	scmi_dev = kzalloc(sizeof(*scmi_dev), GFP_KERNEL);
 	if (!scmi_dev)
 		return NULL;
@@ -333,6 +377,10 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
 	if (retval)
 		goto put_dev;
 
+	pr_debug("(%s) Created SCMI device '%s' for protocol 0x%x (%s)\n",
+		 of_node_full_name(parent->of_node),
+		 dev_name(&scmi_dev->dev), protocol, name);
+
 	return scmi_dev;
 put_dev:
 	kfree_const(scmi_dev->name);
@@ -341,18 +389,85 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
 	return NULL;
 }
 
-void scmi_device_destroy(struct scmi_device *scmi_dev)
+/**
+ * scmi_device_create  - A method to create one or more SCMI devices
+ *
+ * @np: A reference to the device node to use for the new device(s)
+ * @parent: The parent device to use identifying a specific SCMI instance
+ * @protocol: The SCMI protocol to be associated with this device
+ * @name: The requested-name of the device to be created; this is optional
+ *	  and if no @name is provided, all the devices currently known to
+ *	  be requested on the SCMI bus for @protocol will be created.
+ *
+ * This method can be invoked to create a single well-defined device (like
+ * a transport device or a device requested by an SCMI driver loaded after
+ * the core SCMI stack has been probed), or to create all the devices currently
+ * known to have been requested by the loaded SCMI drivers for a specific
+ * protocol (typically during SCMI core protocol enumeration at probe time).
+ *
+ * Return: The created device (or one of them if @name was NOT provided and
+ *	   multiple devices were created) or NULL if no device was created;
+ *	   note that NULL indicates an error ONLY in case a specific @name
+ *	   was provided: when @name param was not provided, a number of devices
+ *	   could have been potentially created for a whole protocol, unless no
+ *	   device was found to have been requested for that specific protocol.
+ */
+struct scmi_device *scmi_device_create(struct device_node *np,
+				       struct device *parent, int protocol,
+				       const char *name)
 {
-	kfree_const(scmi_dev->name);
-	ida_free(&scmi_bus_id, scmi_dev->id);
-	device_unregister(&scmi_dev->dev);
+	struct list_head *phead;
+	struct scmi_requested_dev *rdev;
+	struct scmi_device *scmi_dev = NULL;
+
+	if (name)
+		return __scmi_device_create(np, parent, protocol, name);
+
+	mutex_lock(&scmi_requested_devices_mtx);
+	phead = idr_find(&scmi_requested_devices, protocol);
+	/* Nothing to do. */
+	if (!phead) {
+		mutex_unlock(&scmi_requested_devices_mtx);
+		return scmi_dev;
+	}
+
+	/* Walk the list of requested devices for protocol and create them */
+	list_for_each_entry(rdev, phead, node) {
+		struct scmi_device *sdev;
+
+		sdev = __scmi_device_create(np, parent,
+					    rdev->id_table->protocol_id,
+					    rdev->id_table->name);
+		/* Report errors and carry on... */
+		if (sdev)
+			scmi_dev = sdev;
+		else
+			pr_err("(%s) Failed to create device for protocol 0x%x (%s)\n",
+			       of_node_full_name(parent->of_node),
+			       rdev->id_table->protocol_id,
+			       rdev->id_table->name);
+	}
+	mutex_unlock(&scmi_requested_devices_mtx);
+
+	return scmi_dev;
 }
+EXPORT_SYMBOL_GPL(scmi_device_create);
+
+void scmi_device_destroy(struct device *parent, int protocol, const char *name)
+{
+	struct scmi_device *scmi_dev;
+
+	scmi_dev = scmi_child_dev_find(parent, protocol, name);
+	if (scmi_dev)
+		__scmi_device_destroy(scmi_dev);
+}
+EXPORT_SYMBOL_GPL(scmi_device_destroy);
 
 static int __scmi_devices_unregister(struct device *dev, void *data)
 {
 	struct scmi_device *scmi_dev = to_scmi_dev(dev);
 
-	scmi_device_destroy(scmi_dev);
+	__scmi_device_destroy(scmi_dev);
 	return 0;
 }
 
@@ -374,6 +489,10 @@ int __init scmi_bus_init(void)
 
 void __exit scmi_bus_exit(void)
 {
+	/*
+	 * Destroy all remaining devices: just in case the drivers were
+	 * manually unbound and at first and then the modules unloaded.
+	 */
 	scmi_devices_unregister();
 	bus_unregister(&scmi_bus_type);
 	ida_destroy(&scmi_bus_id);
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 07d34954c060..19726a037991 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -107,6 +107,11 @@ extern struct bus_type scmi_bus_type;
 #define SCMI_BUS_NOTIFY_DEVICE_UNREQUEST	1
 extern struct blocking_notifier_head scmi_requested_devices_nh;
 
+struct scmi_device *scmi_device_create(struct device_node *np,
+				       struct device *parent, int protocol,
+				       const char *name);
+void scmi_device_destroy(struct device *parent, int protocol, const char *name);
+
 int scmi_protocol_acquire(const struct scmi_handle *handle, u8 protocol_id);
 void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
 
@@ -168,9 +173,6 @@ struct scmi_transport_ops {
 	bool (*poll_done)(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer);
 };
 
-struct scmi_device *scmi_child_dev_find(struct device *parent,
-					int prot_id, const char *name);
-
 /**
  * struct scmi_desc - Description of SoC integration
  *
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 8591b2c740c6..83a43a5f7bb4 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2091,6 +2091,8 @@ static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 	/* Create a uniquely named, dedicated transport device for this chan */
 	tdev = scmi_device_create(of_node, info->dev, prot_id, name);
 	if (!tdev) {
+		dev_err(info->dev,
+			"failed to create transport device (%s)\n", name);
 		devm_kfree(info->dev, cinfo);
 		return -EINVAL;
 	}
@@ -2100,7 +2102,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 	ret = info->desc->ops->chan_setup(cinfo, info->dev, tx);
 	if (ret) {
 		of_node_put(of_node);
-		scmi_device_destroy(tdev);
+		scmi_device_destroy(info->dev, prot_id, name);
 		devm_kfree(info->dev, cinfo);
 		return ret;
 	}
@@ -2123,7 +2125,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 		/* Destroy channel and device only if created by this call. */
 		if (tdev) {
 			of_node_put(of_node);
-			scmi_device_destroy(tdev);
+			scmi_device_destroy(info->dev, prot_id, name);
 			devm_kfree(info->dev, cinfo);
 		}
 		return ret;
@@ -2202,10 +2204,11 @@ static int scmi_chan_destroy(int id, void *p, void *idr)
 	struct scmi_chan_info *cinfo = p;
 
 	if (cinfo->dev) {
+		struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 		struct scmi_device *sdev = to_scmi_dev(cinfo->dev);
 
 		of_node_put(cinfo->dev->of_node);
-		scmi_device_destroy(sdev);
+		scmi_device_destroy(info->dev, id, sdev->name);
 		cinfo->dev = NULL;
 	}
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 4f765bc788ff..0ce5746a4470 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -804,11 +804,6 @@ struct scmi_device {
 
 #define to_scmi_dev(d) container_of(d, struct scmi_device, dev)
 
-struct scmi_device *
-scmi_device_create(struct device_node *np, struct device *parent, int protocol,
-		   const char *name);
-void scmi_device_destroy(struct scmi_device *scmi_dev);
-
 struct scmi_device_id {
 	u8 protocol_id;
 	const char *name;
-- 
2.34.1

