Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D640654625
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiLVSvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiLVSvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:51:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26E872333A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:51:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 055DAAD7;
        Thu, 22 Dec 2022 10:51:56 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71E693FA32;
        Thu, 22 Dec 2022 10:51:13 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, Ludvig.Parsson@axis.com,
        cristian.marussi@arm.com
Subject: [PATCH 6/9] firmware: arm_scmi: Move handle get/set helpers
Date:   Thu, 22 Dec 2022 18:50:46 +0000
Message-Id: <20221222185049.737625-7-cristian.marussi@arm.com>
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

Move handle get/set helpers definitions into driver.c and invoke them
through the bus notifier helper.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/bus.c    | 17 ---------------
 drivers/firmware/arm_scmi/common.h |  4 ----
 drivers/firmware/arm_scmi/driver.c | 35 +++++++++++++++++++++---------
 3 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index e63cc1194d43..61113def5a9a 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -344,27 +344,10 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
 void scmi_device_destroy(struct scmi_device *scmi_dev)
 {
 	kfree_const(scmi_dev->name);
-	scmi_handle_put(scmi_dev->handle);
 	ida_free(&scmi_bus_id, scmi_dev->id);
 	device_unregister(&scmi_dev->dev);
 }
 
-void scmi_device_link_add(struct device *consumer, struct device *supplier)
-{
-	struct device_link *link;
-
-	link = device_link_add(consumer, supplier, DL_FLAG_AUTOREMOVE_CONSUMER);
-
-	WARN_ON(!link);
-}
-
-void scmi_set_handle(struct scmi_device *scmi_dev)
-{
-	scmi_dev->handle = scmi_handle_get(&scmi_dev->dev);
-	if (scmi_dev->handle)
-		scmi_device_link_add(&scmi_dev->dev, scmi_dev->handle->dev);
-}
-
 static int __scmi_devices_unregister(struct device *dev, void *data)
 {
 	struct scmi_device *scmi_dev = to_scmi_dev(dev);
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 0f411679df7e..07d34954c060 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -96,10 +96,6 @@ static inline void unpack_scmi_header(u32 msg_hdr, struct scmi_msg_hdr *hdr)
 
 struct scmi_revision_info *
 scmi_revision_area_get(const struct scmi_protocol_handle *ph);
-int scmi_handle_put(const struct scmi_handle *handle);
-void scmi_device_link_add(struct device *consumer, struct device *supplier);
-struct scmi_handle *scmi_handle_get(struct device *dev);
-void scmi_set_handle(struct scmi_device *scmi_dev);
 void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
 				     u8 *prot_imp);
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 73f640e9448f..8591b2c740c6 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1890,13 +1890,6 @@ static bool scmi_is_transport_atomic(const struct scmi_handle *handle,
 	return ret;
 }
 
-static inline
-struct scmi_handle *scmi_handle_get_from_info_unlocked(struct scmi_info *info)
-{
-	info->users++;
-	return &info->handle;
-}
-
 /**
  * scmi_handle_get() - Get the SCMI handle for a device
  *
@@ -1908,7 +1901,7 @@ struct scmi_handle *scmi_handle_get_from_info_unlocked(struct scmi_info *info)
  *
  * Return: pointer to handle if successful, NULL on error
  */
-struct scmi_handle *scmi_handle_get(struct device *dev)
+static struct scmi_handle *scmi_handle_get(struct device *dev)
 {
 	struct list_head *p;
 	struct scmi_info *info;
@@ -1918,7 +1911,8 @@ struct scmi_handle *scmi_handle_get(struct device *dev)
 	list_for_each(p, &scmi_list) {
 		info = list_entry(p, struct scmi_info, node);
 		if (dev->parent == info->dev) {
-			handle = scmi_handle_get_from_info_unlocked(info);
+			info->users++;
+			handle = &info->handle;
 			break;
 		}
 	}
@@ -1939,7 +1933,7 @@ struct scmi_handle *scmi_handle_get(struct device *dev)
  * Return: 0 is successfully released
  *	if null was passed, it returns -EINVAL;
  */
-int scmi_handle_put(const struct scmi_handle *handle)
+static int scmi_handle_put(const struct scmi_handle *handle)
 {
 	struct scmi_info *info;
 
@@ -1955,6 +1949,23 @@ int scmi_handle_put(const struct scmi_handle *handle)
 	return 0;
 }
 
+static void scmi_device_link_add(struct device *consumer,
+				 struct device *supplier)
+{
+	struct device_link *link;
+
+	link = device_link_add(consumer, supplier, DL_FLAG_AUTOREMOVE_CONSUMER);
+
+	WARN_ON(!link);
+}
+
+static void scmi_set_handle(struct scmi_device *scmi_dev)
+{
+	scmi_dev->handle = scmi_handle_get(&scmi_dev->dev);
+	if (scmi_dev->handle)
+		scmi_device_link_add(&scmi_dev->dev, scmi_dev->handle->dev);
+}
+
 static int __scmi_xfer_info_init(struct scmi_info *sinfo,
 				 struct scmi_xfers_info *info)
 {
@@ -2234,8 +2245,12 @@ static int scmi_bus_notifier(struct notifier_block *nb,
 
 	switch (action) {
 	case BUS_NOTIFY_BIND_DRIVER:
+		/* setup handle now as the transport is ready */
+		scmi_set_handle(sdev);
 		break;
 	case BUS_NOTIFY_UNBOUND_DRIVER:
+		scmi_handle_put(sdev->handle);
+		sdev->handle = NULL;
 		break;
 	default:
 		return NOTIFY_DONE;
-- 
2.34.1

