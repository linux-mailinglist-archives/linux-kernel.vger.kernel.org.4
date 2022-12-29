Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4546F659055
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiL2SYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiL2SYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:24:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B6E513EB0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:24:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8640B169E;
        Thu, 29 Dec 2022 10:24:53 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19C3B3F71A;
        Thu, 29 Dec 2022 10:24:09 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 10/17] firmware: arm_scmi: Populate a common SCMI debugsfs root
Date:   Thu, 29 Dec 2022 18:22:46 +0000
Message-Id: <20221229182253.948175-11-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229182253.948175-1-cristian.marussi@arm.com>
References: <20221229182253.948175-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a common SCMI debugfs root-directory and populate it with some
common SCMI data for each discovered SCMI platform instance if SCMI debugfs
is needed by any configured SCMI facility.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/Kconfig  |   7 ++
 drivers/firmware/arm_scmi/driver.c | 135 ++++++++++++++++++++++++++++-
 2 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index a14f65444b35..f36f89a22740 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -23,6 +23,13 @@ config ARM_SCMI_PROTOCOL
 
 if ARM_SCMI_PROTOCOL
 
+config ARM_SCMI_NEED_DEBUGFS
+	bool
+	help
+	  This declares whether at least one SCMI facility is configured
+	  which needs debugfs support. When selected causess the creation
+	  of a common SCMI debugfs root directory.
+
 config ARM_SCMI_HAVE_TRANSPORT
 	bool
 	help
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index c765d0c51dc5..7735f7634514 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -17,6 +17,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bitmap.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/idr.h>
@@ -51,6 +52,8 @@ static DEFINE_MUTEX(scmi_list_mutex);
 /* Track the unique id for the transfers for debug & profiling purpose */
 static atomic_t transfer_last_id;
 
+static struct dentry *scmi_top_dentry;
+
 /**
  * struct scmi_xfers_info - Structure to manage transfer information
  *
@@ -97,6 +100,20 @@ struct scmi_protocol_instance {
 
 #define ph_to_pi(h)	container_of(h, struct scmi_protocol_instance, ph)
 
+/**
+ * struct scmi_debug_info  - Debug common info
+ * @top_dentry: A reference to the top debugfs dentry
+ * @name: Name of this SCMI instance
+ * @type: Type of this SCMI instance
+ * @is_atomic: Flag to state if the transport of this instance is atomic
+ */
+struct scmi_debug_info {
+	struct dentry *top_dentry;
+	const char *name;
+	const char *type;
+	bool is_atomic;
+};
+
 /**
  * struct scmi_info - Structure representing a SCMI instance
  *
@@ -132,6 +149,7 @@ struct scmi_protocol_instance {
  * @dev_req_nb: A notifier to listen for device request/unrequest on the scmi
  *		bus
  * @devreq_mtx: A mutex to serialize device creation for this SCMI instance
+ * @dbg: A pointer to debugfs related data (if any)
  */
 struct scmi_info {
 	int id;
@@ -156,6 +174,7 @@ struct scmi_info {
 	struct notifier_block dev_req_nb;
 	/* Serialize device creation process for this instance */
 	struct mutex devreq_mtx;
+	struct scmi_debug_info *dbg;
 };
 
 #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
@@ -2478,6 +2497,99 @@ static int scmi_device_request_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static void scmi_debugfs_common_cleanup(void *d)
+{
+	struct scmi_debug_info *dbg = d;
+
+	if (!dbg || !dbg->top_dentry)
+		return;
+
+	debugfs_remove_recursive(dbg->top_dentry);
+	kfree(dbg->name);
+	kfree(dbg->type);
+}
+
+static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
+{
+	int ret;
+	const char *c_ptr;
+	char top_dir[16];
+	struct dentry *trans, *top_dentry;
+	struct scmi_debug_info *dbg;
+
+	dbg = devm_kzalloc(info->dev, sizeof(*dbg), GFP_KERNEL);
+	if (!dbg)
+		return NULL;
+
+	dbg->name = kstrdup(of_node_full_name(info->dev->of_node), GFP_KERNEL);
+	if (!dbg->name) {
+		devm_kfree(info->dev, dbg);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	of_property_read_string(info->dev->of_node, "compatible", &c_ptr);
+	dbg->type = kstrdup(c_ptr, GFP_KERNEL);
+	if (!dbg->type) {
+		kfree(dbg->name);
+		devm_kfree(info->dev, dbg);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	snprintf(top_dir, 16, "%d", info->id);
+	top_dentry = debugfs_create_dir(top_dir, scmi_top_dentry);
+	if (IS_ERR(top_dentry)) {
+		kfree(dbg->name);
+		kfree(dbg->type);
+		devm_kfree(info->dev, dbg);
+		return NULL;
+	}
+
+	trans = debugfs_create_dir("transport", top_dentry);
+	if (IS_ERR(trans)) {
+		debugfs_remove_recursive(top_dentry);
+		kfree(dbg->name);
+		kfree(dbg->type);
+		devm_kfree(info->dev, dbg);
+		return NULL;
+	}
+
+	dbg->is_atomic = info->desc->atomic_enabled &&
+				is_transport_polling_capable(info->desc);
+
+	debugfs_create_str("instance_name", 0400, top_dentry,
+			   (char **)&dbg->name);
+
+	debugfs_create_u32("atomic_threshold_us", 0400, top_dentry,
+			   &info->atomic_threshold);
+
+	debugfs_create_str("type", 0400, trans, (char **)&dbg->type);
+
+	debugfs_create_bool("is_atomic", 0400, trans, &dbg->is_atomic);
+
+	debugfs_create_u32("max_rx_timeout_ms", 0400, trans,
+			   (u32 *)&info->desc->max_rx_timeout_ms);
+
+	debugfs_create_u32("max_msg_size", 0400, trans,
+			   (u32 *)&info->desc->max_msg_size);
+
+	debugfs_create_u32("tx_max_msg", 0400, trans,
+			   (u32 *)&info->tx_minfo.max_msg);
+
+	debugfs_create_u32("rx_max_msg", 0400, trans,
+			   (u32 *)&info->rx_minfo.max_msg);
+
+	dbg->top_dentry = top_dentry;
+
+	ret = devm_add_action_or_reset(info->dev,
+				       scmi_debugfs_common_cleanup, dbg);
+	if (ret) {
+		scmi_debugfs_common_cleanup(dbg);
+		return NULL;
+	}
+
+	return dbg;
+}
+
 static int scmi_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -2552,6 +2664,9 @@ static int scmi_probe(struct platform_device *pdev)
 	if (ret)
 		goto clear_dev_req_notifier;
 
+	if (scmi_top_dentry)
+		info->dbg = scmi_debugfs_common_setup(info);
+
 	if (scmi_notification_init(handle))
 		dev_err(dev, "SCMI Notifications NOT available.\n");
 
@@ -2763,7 +2878,7 @@ static inline int __scmi_transports_setup(bool init)
 
 		if (ret) {
 			pr_err("SCMI transport %s FAILED initialization!\n",
-			       trans->compatible);
+			       trans->type);
 			break;
 		}
 	}
@@ -2781,6 +2896,19 @@ static void __exit scmi_transports_exit(void)
 	__scmi_transports_setup(false);
 }
 
+static struct dentry *scmi_debugfs_init(void)
+{
+	struct dentry *d;
+
+	d = debugfs_create_dir("scmi", NULL);
+	if (IS_ERR(d)) {
+		pr_err("Could NOT create SCMI top dentry.\n");
+		return NULL;
+	}
+
+	return d;
+}
+
 static int __init scmi_driver_init(void)
 {
 	int ret;
@@ -2794,6 +2922,9 @@ static int __init scmi_driver_init(void)
 	if (ret)
 		return ret;
 
+	if (IS_ENABLED(CONFIG_ARM_SCMI_NEED_DEBUGFS))
+		scmi_top_dentry = scmi_debugfs_init();
+
 	scmi_base_register();
 
 	scmi_clock_register();
@@ -2825,6 +2956,8 @@ static void __exit scmi_driver_exit(void)
 	scmi_transports_exit();
 
 	platform_driver_unregister(&scmi_driver);
+
+	debugfs_remove_recursive(scmi_top_dentry);
 }
 module_exit(scmi_driver_exit);
 
-- 
2.34.1

