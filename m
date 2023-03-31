Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118E16D1C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjCaJeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjCaJd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8131DFBB
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90FE562434
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B65C433D2;
        Fri, 31 Mar 2023 09:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680255207;
        bh=WdGhtuuB6EG9ZfTx5rpmnXzxWjKavUFASmsUKFniNps=;
        h=From:To:Cc:Subject:Date:From;
        b=tUoX9AZ+8jNdRUJS6qgQ1XL2SVsGoIe+RingtzA4BfqK3Nx23A9MBznaXdEsp01Om
         2xq+V20t5JSQm/RucK0xIZe0BXAcY9yY7FeZrIrieHSeyRHI6m8EzfMT7asBQTZtLU
         NuBCJC1H4qtsQBSTCvjkFJmS/SFiZ9AQFXjylIa8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/7] driver core: core: move to use class_to_subsys()
Date:   Fri, 31 Mar 2023 11:33:12 +0200
Message-Id: <20230331093318.82288-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10384; i=gregkh@linuxfoundation.org; h=from:subject; bh=WdGhtuuB6EG9ZfTx5rpmnXzxWjKavUFASmsUKFniNps=; b=owGbwMvMwCRo6H6F97bub03G02pJDClqK27xcSy4FXveJ23KZeEDiv/+/OLVOGgndvh8y4+MP VbqR02Od8SyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEvr1kmJ+W+yRiGavgzz/b XkX/idP63trilM8wz5wpx/jjrB6luT3J+geU+++yiEjfBwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of places in core.c that need access to the private
subsystem structure of struct class, so move them to use
class_to_subsys() instead of accessing it directly.

This requires exporting class_to_subsys() out of class.c, but keeping it
local to the driver core.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h  |   2 +
 drivers/base/class.c |   2 +-
 drivers/base/core.c  | 121 ++++++++++++++++++++++++++++---------------
 3 files changed, 81 insertions(+), 44 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 2867ca4ee4ce..6296164bb7f3 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -73,6 +73,8 @@ static inline void subsys_put(struct subsys_private *sp)
 		kset_put(&sp->subsys);
 }
 
+struct subsys_private *class_to_subsys(const struct class *class);
+
 struct driver_private {
 	struct kobject kobj;
 	struct klist klist_devices;
diff --git a/drivers/base/class.c b/drivers/base/class.c
index 1f12bd5d56d9..68a6f9b56d19 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -39,7 +39,7 @@ static struct kset *class_kset;
  * NULL.  A call to subsys_put() must be done when finished with the pointer in
  * order for it to be properly freed.
  */
-static struct subsys_private *class_to_subsys(const struct class *class)
+struct subsys_private *class_to_subsys(const struct class *class)
 {
 	struct subsys_private *sp = NULL;
 	struct kobject *kobj;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 89249be22161..e3bc34fcf779 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3149,8 +3149,8 @@ static const struct kobj_type class_dir_ktype = {
 	.child_ns_type	= class_dir_child_ns_type
 };
 
-static struct kobject *
-class_dir_create_and_add(const struct class *class, struct kobject *parent_kobj)
+static struct kobject *class_dir_create_and_add(struct subsys_private *sp,
+						struct kobject *parent_kobj)
 {
 	struct class_dir *dir;
 	int retval;
@@ -3159,12 +3159,12 @@ class_dir_create_and_add(const struct class *class, struct kobject *parent_kobj)
 	if (!dir)
 		return ERR_PTR(-ENOMEM);
 
-	dir->class = class;
+	dir->class = sp->class;
 	kobject_init(&dir->kobj, &class_dir_ktype);
 
-	dir->kobj.kset = &class->p->glue_dirs;
+	dir->kobj.kset = &sp->glue_dirs;
 
-	retval = kobject_add(&dir->kobj, parent_kobj, "%s", class->name);
+	retval = kobject_add(&dir->kobj, parent_kobj, "%s", sp->class->name);
 	if (retval < 0) {
 		kobject_put(&dir->kobj);
 		return ERR_PTR(retval);
@@ -3177,9 +3177,10 @@ static DEFINE_MUTEX(gdp_mutex);
 static struct kobject *get_device_parent(struct device *dev,
 					 struct device *parent)
 {
+	struct subsys_private *sp = class_to_subsys(dev->class);
 	struct kobject *kobj = NULL;
 
-	if (dev->class) {
+	if (sp) {
 		struct kobject *parent_kobj;
 		struct kobject *k;
 
@@ -3190,30 +3191,34 @@ static struct kobject *get_device_parent(struct device *dev,
 		 */
 		if (parent == NULL)
 			parent_kobj = virtual_device_parent(dev);
-		else if (parent->class && !dev->class->ns_type)
+		else if (parent->class && !dev->class->ns_type) {
+			subsys_put(sp);
 			return &parent->kobj;
-		else
+		} else {
 			parent_kobj = &parent->kobj;
+		}
 
 		mutex_lock(&gdp_mutex);
 
 		/* find our class-directory at the parent and reference it */
-		spin_lock(&dev->class->p->glue_dirs.list_lock);
-		list_for_each_entry(k, &dev->class->p->glue_dirs.list, entry)
+		spin_lock(&sp->glue_dirs.list_lock);
+		list_for_each_entry(k, &sp->glue_dirs.list, entry)
 			if (k->parent == parent_kobj) {
 				kobj = kobject_get(k);
 				break;
 			}
-		spin_unlock(&dev->class->p->glue_dirs.list_lock);
+		spin_unlock(&sp->glue_dirs.list_lock);
 		if (kobj) {
 			mutex_unlock(&gdp_mutex);
+			subsys_put(sp);
 			return kobj;
 		}
 
 		/* or create a new class-directory at the parent device */
-		k = class_dir_create_and_add(dev->class, parent_kobj);
+		k = class_dir_create_and_add(sp, parent_kobj);
 		/* do not emit an uevent for this simple "glue" directory */
 		mutex_unlock(&gdp_mutex);
+		subsys_put(sp);
 		return k;
 	}
 
@@ -3236,10 +3241,23 @@ static struct kobject *get_device_parent(struct device *dev,
 static inline bool live_in_glue_dir(struct kobject *kobj,
 				    struct device *dev)
 {
-	if (!kobj || !dev->class ||
-	    kobj->kset != &dev->class->p->glue_dirs)
+	struct subsys_private *sp;
+	bool retval;
+
+	if (!kobj || !dev->class)
 		return false;
-	return true;
+
+	sp = class_to_subsys(dev->class);
+	if (!sp)
+		return false;
+
+	if (kobj->kset == &sp->glue_dirs)
+		retval = true;
+	else
+		retval = false;
+
+	subsys_put(sp);
+	return retval;
 }
 
 static inline struct kobject *get_glue_dir(struct device *dev)
@@ -3336,6 +3354,7 @@ static void cleanup_glue_dir(struct device *dev, struct kobject *glue_dir)
 static int device_add_class_symlinks(struct device *dev)
 {
 	struct device_node *of_node = dev_of_node(dev);
+	struct subsys_private *sp;
 	int error;
 
 	if (of_node) {
@@ -3345,12 +3364,11 @@ static int device_add_class_symlinks(struct device *dev)
 		/* An error here doesn't warrant bringing down the device */
 	}
 
-	if (!dev->class)
+	sp = class_to_subsys(dev->class);
+	if (!sp)
 		return 0;
 
-	error = sysfs_create_link(&dev->kobj,
-				  &dev->class->p->subsys.kobj,
-				  "subsystem");
+	error = sysfs_create_link(&dev->kobj, &sp->subsys.kobj, "subsystem");
 	if (error)
 		goto out_devnode;
 
@@ -3362,35 +3380,37 @@ static int device_add_class_symlinks(struct device *dev)
 	}
 
 	/* link in the class directory pointing to the device */
-	error = sysfs_create_link(&dev->class->p->subsys.kobj,
-				  &dev->kobj, dev_name(dev));
+	error = sysfs_create_link(&sp->subsys.kobj, &dev->kobj, dev_name(dev));
 	if (error)
 		goto out_device;
-
-	return 0;
+	goto exit;
 
 out_device:
 	sysfs_remove_link(&dev->kobj, "device");
-
 out_subsys:
 	sysfs_remove_link(&dev->kobj, "subsystem");
 out_devnode:
 	sysfs_remove_link(&dev->kobj, "of_node");
+exit:
+	subsys_put(sp);
 	return error;
 }
 
 static void device_remove_class_symlinks(struct device *dev)
 {
+	struct subsys_private *sp = class_to_subsys(dev->class);
+
 	if (dev_of_node(dev))
 		sysfs_remove_link(&dev->kobj, "of_node");
 
-	if (!dev->class)
+	if (!sp)
 		return;
 
 	if (dev->parent && device_is_not_partition(dev))
 		sysfs_remove_link(&dev->kobj, "device");
 	sysfs_remove_link(&dev->kobj, "subsystem");
-	sysfs_delete_link(&dev->class->p->subsys.kobj, &dev->kobj, dev_name(dev));
+	sysfs_delete_link(&sp->subsys.kobj, &dev->kobj, dev_name(dev));
+	subsys_put(sp);
 }
 
 /**
@@ -3499,6 +3519,7 @@ static int device_private_init(struct device *dev)
  */
 int device_add(struct device *dev)
 {
+	struct subsys_private *sp;
 	struct device *parent;
 	struct kobject *kobj;
 	struct class_interface *class_intf;
@@ -3627,18 +3648,18 @@ int device_add(struct device *dev)
 		klist_add_tail(&dev->p->knode_parent,
 			       &parent->p->klist_children);
 
-	if (dev->class) {
-		mutex_lock(&dev->class->p->mutex);
+	sp = class_to_subsys(dev->class);
+	if (sp) {
+		mutex_lock(&sp->mutex);
 		/* tie the class to the device */
-		klist_add_tail(&dev->p->knode_class,
-			       &dev->class->p->klist_devices);
+		klist_add_tail(&dev->p->knode_class, &sp->klist_devices);
 
 		/* notify any interfaces that the device is here */
-		list_for_each_entry(class_intf,
-				    &dev->class->p->interfaces, node)
+		list_for_each_entry(class_intf, &sp->interfaces, node)
 			if (class_intf->add_dev)
 				class_intf->add_dev(dev, class_intf);
-		mutex_unlock(&dev->class->p->mutex);
+		mutex_unlock(&sp->mutex);
+		subsys_put(sp);
 	}
 done:
 	put_device(dev);
@@ -3758,6 +3779,7 @@ EXPORT_SYMBOL_GPL(kill_device);
  */
 void device_del(struct device *dev)
 {
+	struct subsys_private *sp;
 	struct device *parent = dev->parent;
 	struct kobject *glue_dir = NULL;
 	struct class_interface *class_intf;
@@ -3784,18 +3806,20 @@ void device_del(struct device *dev)
 		device_remove_sys_dev_entry(dev);
 		device_remove_file(dev, &dev_attr_dev);
 	}
-	if (dev->class) {
+
+	sp = class_to_subsys(dev->class);
+	if (sp) {
 		device_remove_class_symlinks(dev);
 
-		mutex_lock(&dev->class->p->mutex);
+		mutex_lock(&sp->mutex);
 		/* notify any interfaces that the device is now gone */
-		list_for_each_entry(class_intf,
-				    &dev->class->p->interfaces, node)
+		list_for_each_entry(class_intf, &sp->interfaces, node)
 			if (class_intf->remove_dev)
 				class_intf->remove_dev(dev, class_intf);
 		/* remove the device from the class list */
 		klist_del(&dev->p->knode_class);
-		mutex_unlock(&dev->class->p->mutex);
+		mutex_unlock(&sp->mutex);
+		subsys_put(sp);
 	}
 	device_remove_file(dev, &dev_attr_uevent);
 	device_remove_attrs(dev);
@@ -4458,9 +4482,16 @@ int device_rename(struct device *dev, const char *new_name)
 	}
 
 	if (dev->class) {
-		error = sysfs_rename_link_ns(&dev->class->p->subsys.kobj,
-					     kobj, old_device_name,
+		struct subsys_private *sp = class_to_subsys(dev->class);
+
+		if (!sp) {
+			error = -EINVAL;
+			goto out;
+		}
+
+		error = sysfs_rename_link_ns(&sp->subsys.kobj, kobj, old_device_name,
 					     new_name, kobject_namespace(kobj));
+		subsys_put(sp);
 		if (error)
 			goto out;
 	}
@@ -4643,6 +4674,7 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 {
 	int error;
 	struct kobject *kobj = &dev->kobj;
+	struct subsys_private *sp;
 
 	dev = get_device(dev);
 	if (!dev)
@@ -4685,10 +4717,13 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 	 * directory entry for @dev to @kuid/@kgid. This ensures that the
 	 * symlink shows the same permissions as its target.
 	 */
-	error = sysfs_link_change_owner(&dev->class->p->subsys.kobj, &dev->kobj,
-					dev_name(dev), kuid, kgid);
-	if (error)
+	sp = class_to_subsys(dev->class);
+	if (!sp) {
+		error = -EINVAL;
 		goto out;
+	}
+	error = sysfs_link_change_owner(&sp->subsys.kobj, &dev->kobj, dev_name(dev), kuid, kgid);
+	subsys_put(sp);
 
 out:
 	put_device(dev);
-- 
2.40.0

