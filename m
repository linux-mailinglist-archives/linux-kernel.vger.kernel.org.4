Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6974654623
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiLVSv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLVSvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:51:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44FB022B2A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:51:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 212FE1FB;
        Thu, 22 Dec 2022 10:51:51 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE9633FA32;
        Thu, 22 Dec 2022 10:51:08 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, Ludvig.Parsson@axis.com,
        cristian.marussi@arm.com
Subject: [PATCH 3/9] firmware: arm_scmi: Move protocol registration helpers
Date:   Thu, 22 Dec 2022 18:50:43 +0000
Message-Id: <20221222185049.737625-4-cristian.marussi@arm.com>
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

Move protocol registration helpers and logic out of bus.c compilation
unit into driver.c.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/bus.c    | 68 ------------------------------
 drivers/firmware/arm_scmi/common.h |  3 --
 drivers/firmware/arm_scmi/driver.c | 67 +++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 71 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 35bb70724d44..089957f5fb9b 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -16,8 +16,6 @@
 #include "common.h"
 
 static DEFINE_IDA(scmi_bus_id);
-static DEFINE_IDR(scmi_protocols);
-static DEFINE_SPINLOCK(protocol_lock);
 
 static const struct scmi_device_id *
 scmi_dev_match_id(struct scmi_device *scmi_dev, struct scmi_driver *scmi_drv)
@@ -76,30 +74,6 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
 	return to_scmi_dev(dev);
 }
 
-const struct scmi_protocol *scmi_protocol_get(int protocol_id)
-{
-	const struct scmi_protocol *proto;
-
-	proto = idr_find(&scmi_protocols, protocol_id);
-	if (!proto || !try_module_get(proto->owner)) {
-		pr_warn("SCMI Protocol 0x%x not found!\n", protocol_id);
-		return NULL;
-	}
-
-	pr_debug("Found SCMI Protocol 0x%x\n", protocol_id);
-
-	return proto;
-}
-
-void scmi_protocol_put(int protocol_id)
-{
-	const struct scmi_protocol *proto;
-
-	proto = idr_find(&scmi_protocols, protocol_id);
-	if (proto)
-		module_put(proto->owner);
-}
-
 static int scmi_dev_probe(struct device *dev)
 {
 	struct scmi_driver *scmi_drv = to_scmi_driver(dev->driver);
@@ -232,48 +206,6 @@ void scmi_set_handle(struct scmi_device *scmi_dev)
 		scmi_device_link_add(&scmi_dev->dev, scmi_dev->handle->dev);
 }
 
-int scmi_protocol_register(const struct scmi_protocol *proto)
-{
-	int ret;
-
-	if (!proto) {
-		pr_err("invalid protocol\n");
-		return -EINVAL;
-	}
-
-	if (!proto->instance_init) {
-		pr_err("missing init for protocol 0x%x\n", proto->id);
-		return -EINVAL;
-	}
-
-	spin_lock(&protocol_lock);
-	ret = idr_alloc(&scmi_protocols, (void *)proto,
-			proto->id, proto->id + 1, GFP_ATOMIC);
-	spin_unlock(&protocol_lock);
-	if (ret != proto->id) {
-		pr_err("unable to allocate SCMI idr slot for 0x%x - err %d\n",
-		       proto->id, ret);
-		return ret;
-	}
-
-	pr_debug("Registered SCMI Protocol 0x%x\n", proto->id);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(scmi_protocol_register);
-
-void scmi_protocol_unregister(const struct scmi_protocol *proto)
-{
-	spin_lock(&protocol_lock);
-	idr_remove(&scmi_protocols, proto->id);
-	spin_unlock(&protocol_lock);
-
-	pr_debug("Unregistered SCMI Protocol 0x%x\n", proto->id);
-
-	return;
-}
-EXPORT_SYMBOL_GPL(scmi_protocol_unregister);
-
 static int __scmi_devices_unregister(struct device *dev, void *data)
 {
 	struct scmi_device *scmi_dev = to_scmi_dev(dev);
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 136bfd30f99c..6a38244494fd 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -106,9 +106,6 @@ void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
 int __init scmi_bus_init(void);
 void __exit scmi_bus_exit(void);
 
-const struct scmi_protocol *scmi_protocol_get(int protocol_id);
-void scmi_protocol_put(int protocol_id);
-
 int scmi_protocol_acquire(const struct scmi_handle *handle, u8 protocol_id);
 void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index f85b34e69d01..d1e32ea6d90a 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -51,6 +51,9 @@ enum scmi_error_codes {
 	SCMI_ERR_PROTOCOL = -10,/* Protocol Error */
 };
 
+static DEFINE_IDR(scmi_protocols);
+static DEFINE_SPINLOCK(protocol_lock);
+
 /* List of all SCMI devices active in system */
 static LIST_HEAD(scmi_list);
 /* Protection for the entire list */
@@ -194,6 +197,70 @@ static inline int scmi_to_linux_errno(int errno)
 	return -EIO;
 }
 
+static const struct scmi_protocol *scmi_protocol_get(int protocol_id)
+{
+	const struct scmi_protocol *proto;
+
+	proto = idr_find(&scmi_protocols, protocol_id);
+	if (!proto || !try_module_get(proto->owner)) {
+		pr_warn("SCMI Protocol 0x%x not found!\n", protocol_id);
+		return NULL;
+	}
+
+	pr_debug("Found SCMI Protocol 0x%x\n", protocol_id);
+
+	return proto;
+}
+
+static void scmi_protocol_put(int protocol_id)
+{
+	const struct scmi_protocol *proto;
+
+	proto = idr_find(&scmi_protocols, protocol_id);
+	if (proto)
+		module_put(proto->owner);
+}
+
+int scmi_protocol_register(const struct scmi_protocol *proto)
+{
+	int ret;
+
+	if (!proto) {
+		pr_err("invalid protocol\n");
+		return -EINVAL;
+	}
+
+	if (!proto->instance_init) {
+		pr_err("missing init for protocol 0x%x\n", proto->id);
+		return -EINVAL;
+	}
+
+	spin_lock(&protocol_lock);
+	ret = idr_alloc(&scmi_protocols, (void *)proto,
+			proto->id, proto->id + 1, GFP_ATOMIC);
+	spin_unlock(&protocol_lock);
+	if (ret != proto->id) {
+		pr_err("unable to allocate SCMI idr slot for 0x%x - err %d\n",
+		       proto->id, ret);
+		return ret;
+	}
+
+	pr_debug("Registered SCMI Protocol 0x%x\n", proto->id);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(scmi_protocol_register);
+
+void scmi_protocol_unregister(const struct scmi_protocol *proto)
+{
+	spin_lock(&protocol_lock);
+	idr_remove(&scmi_protocols, proto->id);
+	spin_unlock(&protocol_lock);
+
+	pr_debug("Unregistered SCMI Protocol 0x%x\n", proto->id);
+}
+EXPORT_SYMBOL_GPL(scmi_protocol_unregister);
+
 void scmi_notification_instance_data_set(const struct scmi_handle *handle,
 					 void *priv)
 {
-- 
2.34.1

