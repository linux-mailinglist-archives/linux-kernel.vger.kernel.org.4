Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876B46B80BF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjCMSdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjCMScW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:32:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1711CAD1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:31:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3512B811EA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC1FC433EF;
        Mon, 13 Mar 2023 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732259;
        bh=hPDqRd7gJAlE6q+8Dn7WGhvvs2+lkO722JN+XrEQSO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8oFJt9DXLI7Dq+P3FUyBUHgoWY75uuwjRvIkZmfF04kJS+nrH0zaBjC1hT3o/u1l
         4MF3Z3ERPAVll+4EVU4gwUeSdb+Fr4p417NpIFfbISOG3HgYJeB4dx0m/7KIY66u8H
         FRd+Ej6+oWFJC9WGNYdLQtWKXAE+FgCT4FjOT0tc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 22/36] driver core: bus: move dev_root out of struct bus_type
Date:   Mon, 13 Mar 2023 19:29:04 +0100
Message-Id: <20230313182918.1312597-22-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4073; i=gregkh@linuxfoundation.org; h=from:subject; bh=hPDqRd7gJAlE6q+8Dn7WGhvvs2+lkO722JN+XrEQSO8=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82VXZF83MrzAx7Uu9yn/i/MUad/4NXcsaRGZ2/smoO lN7xEm8I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZi9oJhwVpGxbyamMO6Oz8a CFsdVVkgN/nzK4b5CYZamqqWTkceV54t+vf8guk897enAQ==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all accesses of dev_root is through the bus_get_dev_root()
call, move the pointer out of struct bus_type and into the private
dynamic structure, subsys_private.

With this change, there is no modifiable portions of struct bus_type so
it can be marked as a constant structure and moved to read-only memory.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h        |  2 ++
 drivers/base/bus.c         | 28 ++++++++++++++++++++++------
 include/linux/device/bus.h |  2 --
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index b055eba1ec30..f1034e27e651 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -27,6 +27,7 @@
  *                 on this bus.
  * @bus - pointer back to the struct bus_type that this structure is associated
  *        with.
+ * @dev_root: Default device to use as the parent.
  *
  * @glue_dirs - "glue" directory to put in-between the parent device to
  *              avoid namespace conflicts
@@ -49,6 +50,7 @@ struct subsys_private {
 	struct blocking_notifier_head bus_notifier;
 	unsigned int drivers_autoprobe:1;
 	struct bus_type *bus;
+	struct device *dev_root;
 
 	struct kset glue_dirs;
 	struct class *class;
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index dd4b82d7510f..91a6b6b1fc49 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -935,8 +935,8 @@ void bus_unregister(const struct bus_type *bus)
 		return;
 
 	pr_debug("bus: '%s': unregistering\n", bus->name);
-	if (bus->dev_root)
-		device_unregister(bus->dev_root);
+	if (sp->dev_root)
+		device_unregister(sp->dev_root);
 
 	bus_kobj = &sp->subsys.kobj;
 	sysfs_remove_groups(bus_kobj, bus->bus_groups);
@@ -1198,6 +1198,7 @@ static int subsys_register(struct bus_type *subsys,
 			   const struct attribute_group **groups,
 			   struct kobject *parent_of_root)
 {
+	struct subsys_private *sp;
 	struct device *dev;
 	int err;
 
@@ -1205,6 +1206,12 @@ static int subsys_register(struct bus_type *subsys,
 	if (err < 0)
 		return err;
 
+	sp = bus_to_subsys(subsys);
+	if (!sp) {
+		err = -EINVAL;
+		goto err_sp;
+	}
+
 	dev = kzalloc(sizeof(struct device), GFP_KERNEL);
 	if (!dev) {
 		err = -ENOMEM;
@@ -1223,7 +1230,8 @@ static int subsys_register(struct bus_type *subsys,
 	if (err < 0)
 		goto err_dev_reg;
 
-	subsys->dev_root = dev;
+	sp->dev_root = dev;
+	subsys_put(sp);
 	return 0;
 
 err_dev_reg:
@@ -1232,6 +1240,8 @@ static int subsys_register(struct bus_type *subsys,
 err_name:
 	kfree(dev);
 err_dev:
+	subsys_put(sp);
+err_sp:
 	bus_unregister(subsys);
 	return err;
 }
@@ -1349,9 +1359,15 @@ bool bus_is_registered(const struct bus_type *bus)
  */
 struct device *bus_get_dev_root(const struct bus_type *bus)
 {
-	if (bus)
-		return get_device(bus->dev_root);
-	return NULL;
+	struct subsys_private *sp = bus_to_subsys(bus);
+	struct device *dev_root;
+
+	if (!sp)
+		return NULL;
+
+	dev_root = get_device(sp->dev_root);
+	subsys_put(sp);
+	return dev_root;
 }
 EXPORT_SYMBOL_GPL(bus_get_dev_root);
 
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 6ce32ef4b8fd..c258e8770285 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -26,7 +26,6 @@ struct fwnode_handle;
  *
  * @name:	The name of the bus.
  * @dev_name:	Used for subsystems to enumerate devices like ("foo%u", dev->id).
- * @dev_root:	Default device to use as the parent.
  * @bus_groups:	Default attributes of the bus.
  * @dev_groups:	Default attributes of the devices on the bus.
  * @drv_groups: Default attributes of the device drivers on the bus.
@@ -82,7 +81,6 @@ struct fwnode_handle;
 struct bus_type {
 	const char		*name;
 	const char		*dev_name;
-	struct device		*dev_root;
 	const struct attribute_group **bus_groups;
 	const struct attribute_group **dev_groups;
 	const struct attribute_group **drv_groups;
-- 
2.39.2

