Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57FD654624
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiLVSv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiLVSvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:51:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CEDA23303
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:51:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49F7C2F4;
        Thu, 22 Dec 2022 10:51:54 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA72F3FA32;
        Thu, 22 Dec 2022 10:51:11 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, Ludvig.Parsson@axis.com,
        cristian.marussi@arm.com
Subject: [PATCH 5/9] firmware: arm_scmi: Refactor protocol device creation
Date:   Thu, 22 Dec 2022 18:50:45 +0000
Message-Id: <20221222185049.737625-6-cristian.marussi@arm.com>
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

Move protocol device request helpers from driver.c compilation unit to
bus.c, so reducing the cross interactions between driver.c and bus.c.

Get rid of old protocol device creation process as a whole from driver.c
and remove also stale SCMI system power unicity checks.

While at that make such helpers call into scmi_requested_devices_nh
notification chain.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Note that this patch disables SCMI device creation, it will be
restored later in the series, together with SCMI syspower checks,
using a new approach.
---
 drivers/firmware/arm_scmi/bus.c    | 157 ++++++++++++++-
 drivers/firmware/arm_scmi/common.h |   2 -
 drivers/firmware/arm_scmi/driver.c | 296 -----------------------------
 3 files changed, 156 insertions(+), 299 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index bed566f58029..e63cc1194d43 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -9,6 +9,7 @@
 
 #include <linux/types.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/device.h>
@@ -20,6 +21,160 @@ EXPORT_SYMBOL_GPL(scmi_requested_devices_nh);
 
 static DEFINE_IDA(scmi_bus_id);
 
+static DEFINE_IDR(scmi_requested_devices);
+/* Protect access to scmi_requested_devices */
+static DEFINE_MUTEX(scmi_requested_devices_mtx);
+
+struct scmi_requested_dev {
+	const struct scmi_device_id *id_table;
+	struct list_head node;
+};
+
+/**
+ * scmi_protocol_device_request  - Helper to request a device
+ *
+ * @id_table: A protocol/name pair descriptor for the device to be created.
+ *
+ * This helper let an SCMI driver request specific devices identified by the
+ * @id_table to be created for each active SCMI instance.
+ *
+ * The requested device name MUST NOT be already existent for any protocol;
+ * at first the freshly requested @id_table is annotated in the IDR table
+ * @scmi_requested_devices and then the requested device is advertised to any
+ * registered party via the @scmi_requested_devices_nh notification chain.
+ *
+ * Return: 0 on Success
+ */
+static int scmi_protocol_device_request(const struct scmi_device_id *id_table)
+{
+	int ret = 0;
+	unsigned int id = 0;
+	struct list_head *head, *phead = NULL;
+	struct scmi_requested_dev *rdev;
+
+	pr_debug("Requesting SCMI device (%s) for protocol %x\n",
+		 id_table->name, id_table->protocol_id);
+
+	/*
+	 * Search for the matching protocol rdev list and then search
+	 * of any existent equally named device...fails if any duplicate found.
+	 */
+	mutex_lock(&scmi_requested_devices_mtx);
+	idr_for_each_entry(&scmi_requested_devices, head, id) {
+		if (!phead) {
+			/* A list found registered in the IDR is never empty */
+			rdev = list_first_entry(head, struct scmi_requested_dev,
+						node);
+			if (rdev->id_table->protocol_id ==
+			    id_table->protocol_id)
+				phead = head;
+		}
+		list_for_each_entry(rdev, head, node) {
+			if (!strcmp(rdev->id_table->name, id_table->name)) {
+				pr_err("Ignoring duplicate request [%d] %s\n",
+				       rdev->id_table->protocol_id,
+				       rdev->id_table->name);
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+	}
+
+	/*
+	 * No duplicate found for requested id_table, so let's create a new
+	 * requested device entry for this new valid request.
+	 */
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	rdev->id_table = id_table;
+
+	/*
+	 * Append the new requested device table descriptor to the head of the
+	 * related protocol list, eventually creating such head if not already
+	 * there.
+	 */
+	if (!phead) {
+		phead = kzalloc(sizeof(*phead), GFP_KERNEL);
+		if (!phead) {
+			kfree(rdev);
+			ret = -ENOMEM;
+			goto out;
+		}
+		INIT_LIST_HEAD(phead);
+
+		ret = idr_alloc(&scmi_requested_devices, (void *)phead,
+				id_table->protocol_id,
+				id_table->protocol_id + 1, GFP_KERNEL);
+		if (ret != id_table->protocol_id) {
+			pr_err("Failed to save SCMI device - ret:%d\n", ret);
+			kfree(rdev);
+			kfree(phead);
+			ret = -EINVAL;
+			goto out;
+		}
+		ret = 0;
+	}
+	list_add(&rdev->node, phead);
+
+out:
+	mutex_unlock(&scmi_requested_devices_mtx);
+
+	if (!ret)
+		blocking_notifier_call_chain(&scmi_requested_devices_nh,
+					     SCMI_BUS_NOTIFY_DEVICE_REQUEST,
+					     (void *)rdev->id_table);
+
+	return ret;
+}
+
+/**
+ * scmi_protocol_device_unrequest  - Helper to unrequest a device
+ *
+ * @id_table: A protocol/name pair descriptor for the device to be unrequested.
+ *
+ * The unrequested device, described by the provided id_table, is at first
+ * removed from the IDR @scmi_requested_devices and then the removal is
+ * advertised to any registered party via the @scmi_requested_devices_nh
+ * notification chain.
+ */
+static void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table)
+{
+	struct list_head *phead;
+
+	pr_debug("Unrequesting SCMI device (%s) for protocol %x\n",
+		 id_table->name, id_table->protocol_id);
+
+	mutex_lock(&scmi_requested_devices_mtx);
+	phead = idr_find(&scmi_requested_devices, id_table->protocol_id);
+	if (phead) {
+		struct scmi_requested_dev *victim, *tmp;
+
+		list_for_each_entry_safe(victim, tmp, phead, node) {
+			if (!strcmp(victim->id_table->name, id_table->name)) {
+				list_del(&victim->node);
+
+				mutex_unlock(&scmi_requested_devices_mtx);
+				blocking_notifier_call_chain(&scmi_requested_devices_nh,
+							     SCMI_BUS_NOTIFY_DEVICE_UNREQUEST,
+							     (void *)victim->id_table);
+				kfree(victim);
+				mutex_lock(&scmi_requested_devices_mtx);
+				break;
+			}
+		}
+
+		if (list_empty(phead)) {
+			idr_remove(&scmi_requested_devices,
+				   id_table->protocol_id);
+			kfree(phead);
+		}
+	}
+	mutex_unlock(&scmi_requested_devices_mtx);
+}
+
 static const struct scmi_device_id *
 scmi_dev_match_id(struct scmi_device *scmi_dev, struct scmi_driver *scmi_drv)
 {
@@ -124,7 +279,7 @@ int scmi_driver_register(struct scmi_driver *driver, struct module *owner,
 
 	retval = driver_register(&driver->driver);
 	if (!retval)
-		pr_debug("registered new scmi driver %s\n", driver->name);
+		pr_debug("Registered new scmi driver %s\n", driver->name);
 
 	return retval;
 }
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 7ddae90eb945..0f411679df7e 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -172,8 +172,6 @@ struct scmi_transport_ops {
 	bool (*poll_done)(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer);
 };
 
-int scmi_protocol_device_request(const struct scmi_device_id *id_table);
-void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table);
 struct scmi_device *scmi_child_dev_find(struct device *parent,
 					int prot_id, const char *name);
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 62760bed1645..73f640e9448f 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -61,19 +61,6 @@ static DEFINE_MUTEX(scmi_list_mutex);
 /* Track the unique id for the transfers for debug & profiling purpose */
 static atomic_t transfer_last_id;
 
-static DEFINE_IDR(scmi_requested_devices);
-static DEFINE_MUTEX(scmi_requested_devices_mtx);
-
-/* Track globally the creation of SCMI SystemPower related devices */
-static bool scmi_syspower_registered;
-/* Protect access to scmi_syspower_registered */
-static DEFINE_MUTEX(scmi_syspower_mtx);
-
-struct scmi_requested_dev {
-	const struct scmi_device_id *id_table;
-	struct list_head node;
-};
-
 /**
  * struct scmi_xfers_info - Structure to manage transfer information
  *
@@ -2199,288 +2186,6 @@ static int scmi_channels_setup(struct scmi_info *info)
 	return 0;
 }
 
-/**
- * scmi_get_protocol_device  - Helper to get/create an SCMI device.
- *
- * @np: A device node representing a valid active protocols for the referred
- * SCMI instance.
- * @info: The referred SCMI instance for which we are getting/creating this
- * device.
- * @prot_id: The protocol ID.
- * @name: The device name.
- *
- * Referring to the specific SCMI instance identified by @info, this helper
- * takes care to return a properly initialized device matching the requested
- * @proto_id and @name: if device was still not existent it is created as a
- * child of the specified SCMI instance @info and its transport properly
- * initialized as usual.
- *
- * Return: A properly initialized scmi device, NULL otherwise.
- */
-static inline struct scmi_device *
-scmi_get_protocol_device(struct device_node *np, struct scmi_info *info,
-			 int prot_id, const char *name)
-{
-	struct scmi_device *sdev;
-
-	/* Already created for this parent SCMI instance ? */
-	sdev = scmi_child_dev_find(info->dev, prot_id, name);
-	if (sdev)
-		return sdev;
-
-	mutex_lock(&scmi_syspower_mtx);
-	if (prot_id == SCMI_PROTOCOL_SYSTEM && scmi_syspower_registered) {
-		dev_warn(info->dev,
-			 "SCMI SystemPower protocol device must be unique !\n");
-		mutex_unlock(&scmi_syspower_mtx);
-
-		return NULL;
-	}
-
-	pr_debug("Creating SCMI device (%s) for protocol %x\n", name, prot_id);
-
-	sdev = scmi_device_create(np, info->dev, prot_id, name);
-	if (!sdev) {
-		dev_err(info->dev, "failed to create %d protocol device\n",
-			prot_id);
-		mutex_unlock(&scmi_syspower_mtx);
-
-		return NULL;
-	}
-
-	if (prot_id == SCMI_PROTOCOL_SYSTEM)
-		scmi_syspower_registered = true;
-
-	mutex_unlock(&scmi_syspower_mtx);
-
-	return sdev;
-}
-
-static inline void
-scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
-			    int prot_id, const char *name)
-{
-	struct scmi_device *sdev;
-
-	sdev = scmi_get_protocol_device(np, info, prot_id, name);
-	if (!sdev)
-		return;
-
-	/* setup handle now as the transport is ready */
-	scmi_set_handle(sdev);
-}
-
-/**
- * scmi_create_protocol_devices  - Create devices for all pending requests for
- * this SCMI instance.
- *
- * @np: The device node describing the protocol
- * @info: The SCMI instance descriptor
- * @prot_id: The protocol ID
- *
- * All devices previously requested for this instance (if any) are found and
- * created by scanning the proper @&scmi_requested_devices entry.
- */
-static void scmi_create_protocol_devices(struct device_node *np,
-					 struct scmi_info *info, int prot_id)
-{
-	struct list_head *phead;
-
-	mutex_lock(&scmi_requested_devices_mtx);
-	phead = idr_find(&scmi_requested_devices, prot_id);
-	if (phead) {
-		struct scmi_requested_dev *rdev;
-
-		list_for_each_entry(rdev, phead, node)
-			scmi_create_protocol_device(np, info, prot_id,
-						    rdev->id_table->name);
-	}
-	mutex_unlock(&scmi_requested_devices_mtx);
-}
-
-/**
- * scmi_protocol_device_request  - Helper to request a device
- *
- * @id_table: A protocol/name pair descriptor for the device to be created.
- *
- * This helper let an SCMI driver request specific devices identified by the
- * @id_table to be created for each active SCMI instance.
- *
- * The requested device name MUST NOT be already existent for any protocol;
- * at first the freshly requested @id_table is annotated in the IDR table
- * @scmi_requested_devices, then a matching device is created for each already
- * active SCMI instance. (if any)
- *
- * This way the requested device is created straight-away for all the already
- * initialized(probed) SCMI instances (handles) and it remains also annotated
- * as pending creation if the requesting SCMI driver was loaded before some
- * SCMI instance and related transports were available: when such late instance
- * is probed, its probe will take care to scan the list of pending requested
- * devices and create those on its own (see @scmi_create_protocol_devices and
- * its enclosing loop)
- *
- * Return: 0 on Success
- */
-int scmi_protocol_device_request(const struct scmi_device_id *id_table)
-{
-	int ret = 0;
-	unsigned int id = 0;
-	struct list_head *head, *phead = NULL;
-	struct scmi_requested_dev *rdev;
-	struct scmi_info *info;
-
-	pr_debug("Requesting SCMI device (%s) for protocol %x\n",
-		 id_table->name, id_table->protocol_id);
-
-	/*
-	 * Search for the matching protocol rdev list and then search
-	 * of any existent equally named device...fails if any duplicate found.
-	 */
-	mutex_lock(&scmi_requested_devices_mtx);
-	idr_for_each_entry(&scmi_requested_devices, head, id) {
-		if (!phead) {
-			/* A list found registered in the IDR is never empty */
-			rdev = list_first_entry(head, struct scmi_requested_dev,
-						node);
-			if (rdev->id_table->protocol_id ==
-			    id_table->protocol_id)
-				phead = head;
-		}
-		list_for_each_entry(rdev, head, node) {
-			if (!strcmp(rdev->id_table->name, id_table->name)) {
-				pr_err("Ignoring duplicate request [%d] %s\n",
-				       rdev->id_table->protocol_id,
-				       rdev->id_table->name);
-				ret = -EINVAL;
-				goto out;
-			}
-		}
-	}
-
-	/*
-	 * No duplicate found for requested id_table, so let's create a new
-	 * requested device entry for this new valid request.
-	 */
-	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
-	if (!rdev) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	rdev->id_table = id_table;
-
-	/*
-	 * Append the new requested device table descriptor to the head of the
-	 * related protocol list, eventually creating such head if not already
-	 * there.
-	 */
-	if (!phead) {
-		phead = kzalloc(sizeof(*phead), GFP_KERNEL);
-		if (!phead) {
-			kfree(rdev);
-			ret = -ENOMEM;
-			goto out;
-		}
-		INIT_LIST_HEAD(phead);
-
-		ret = idr_alloc(&scmi_requested_devices, (void *)phead,
-				id_table->protocol_id,
-				id_table->protocol_id + 1, GFP_KERNEL);
-		if (ret != id_table->protocol_id) {
-			pr_err("Failed to save SCMI device - ret:%d\n", ret);
-			kfree(rdev);
-			kfree(phead);
-			ret = -EINVAL;
-			goto out;
-		}
-		ret = 0;
-	}
-	list_add(&rdev->node, phead);
-
-	/*
-	 * Now effectively create and initialize the requested device for every
-	 * already initialized SCMI instance which has registered the requested
-	 * protocol as a valid active one: i.e. defined in DT and supported by
-	 * current platform FW.
-	 */
-	mutex_lock(&scmi_list_mutex);
-	list_for_each_entry(info, &scmi_list, node) {
-		struct device_node *child;
-
-		child = idr_find(&info->active_protocols,
-				 id_table->protocol_id);
-		if (child) {
-			struct scmi_device *sdev;
-
-			sdev = scmi_get_protocol_device(child, info,
-							id_table->protocol_id,
-							id_table->name);
-			if (sdev) {
-				/* Set handle if not already set: device existed */
-				if (!sdev->handle)
-					sdev->handle =
-						scmi_handle_get_from_info_unlocked(info);
-				/* Relink consumer and suppliers */
-				if (sdev->handle)
-					scmi_device_link_add(&sdev->dev,
-							     sdev->handle->dev);
-			}
-		} else {
-			dev_err(info->dev,
-				"Failed. SCMI protocol %d not active.\n",
-				id_table->protocol_id);
-		}
-	}
-	mutex_unlock(&scmi_list_mutex);
-
-out:
-	mutex_unlock(&scmi_requested_devices_mtx);
-
-	return ret;
-}
-
-/**
- * scmi_protocol_device_unrequest  - Helper to unrequest a device
- *
- * @id_table: A protocol/name pair descriptor for the device to be unrequested.
- *
- * An helper to let an SCMI driver release its request about devices; note that
- * devices are created and initialized once the first SCMI driver request them
- * but they destroyed only on SCMI core unloading/unbinding.
- *
- * The current SCMI transport layer uses such devices as internal references and
- * as such they could be shared as same transport between multiple drivers so
- * that cannot be safely destroyed till the whole SCMI stack is removed.
- * (unless adding further burden of refcounting.)
- */
-void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table)
-{
-	struct list_head *phead;
-
-	pr_debug("Unrequesting SCMI device (%s) for protocol %x\n",
-		 id_table->name, id_table->protocol_id);
-
-	mutex_lock(&scmi_requested_devices_mtx);
-	phead = idr_find(&scmi_requested_devices, id_table->protocol_id);
-	if (phead) {
-		struct scmi_requested_dev *victim, *tmp;
-
-		list_for_each_entry_safe(victim, tmp, phead, node) {
-			if (!strcmp(victim->id_table->name, id_table->name)) {
-				list_del(&victim->node);
-				kfree(victim);
-				break;
-			}
-		}
-
-		if (list_empty(phead)) {
-			idr_remove(&scmi_requested_devices,
-				   id_table->protocol_id);
-			kfree(phead);
-		}
-	}
-	mutex_unlock(&scmi_requested_devices_mtx);
-}
-
 static int scmi_chan_destroy(int id, void *p, void *idr)
 {
 	struct scmi_chan_info *cinfo = p;
@@ -2689,7 +2394,6 @@ static int scmi_probe(struct platform_device *pdev)
 		}
 
 		of_node_get(child);
-		scmi_create_protocol_devices(child, info, prot_id);
 	}
 
 	return 0;
-- 
2.34.1

