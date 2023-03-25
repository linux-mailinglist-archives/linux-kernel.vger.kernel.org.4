Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D915C6C908B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 20:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjCYTmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 15:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCYTml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 15:42:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070213A9B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 12:42:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96BBC60D27
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 19:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63154C433EF;
        Sat, 25 Mar 2023 19:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679773359;
        bh=LMJaj8fZccWYkSYxa6ua+HxKjVQ+2DSpF22IjtslcZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzO1eCyMY4DdOFd+dqtqnRNoWpFDXWoL3nMeQFvGN4ke5DSPJSMDerrlhyHkhcjZ5
         pHkzqGAQRxSfwi65PR32MA8f4/CInnW2QvAKvi9hterfJdFdtNpubW5N52D8TYI9Gj
         w0Z2zRU9HHM1BNxtGrtoFrFONkYF58g70g//Bf/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/2] driver core: class.c: convert to only use class_to_subsys
Date:   Sat, 25 Mar 2023 20:42:34 +0100
Message-Id: <20230325194234.46588-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230325194234.46588-1-gregkh@linuxfoundation.org>
References: <20230325194234.46588-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8213; i=gregkh@linuxfoundation.org; h=from:subject; bh=LMJaj8fZccWYkSYxa6ua+HxKjVQ+2DSpF22IjtslcZU=; b=owGbwMvMwCRo6H6F97bub03G02pJDCnyfqu2fjVwi1o2rXXB6eaQJNnLOTumZWxVVqjmkIpY9 /RO3GeLjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjI5g8Mc7hOOUq8cLj1S4Lz ZmV5xT6za9ZfWxjmKWqkqt9/udAjdD7r3MisBUtuzqv7CAA=
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

Now that class_to_subsys() can be used to get access to the internal
class private pointer, convert the remaining few places in class.c that
were accessing the pointer directly to use class_to_subsys() instead.

By doing this, the need for class_get() and class_put() goes away as no
one actually tries to increment the class structures anymore, only the
internal dynamic one.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c | 113 +++++++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 52 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 90678f6ed4ba..45d66a4fb375 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -66,24 +66,6 @@ static struct subsys_private *class_to_subsys(const struct class *class)
 	return sp;
 }
 
-static const struct class *class_get(const struct class *class)
-{
-	struct subsys_private *sp = class_to_subsys(class);
-
-	if (sp)
-		return class;
-	return NULL;
-}
-
-static void class_put(const struct class *class)
-{
-	struct subsys_private *sp = class_to_subsys(class);
-
-	/* two puts are required as the call to bus_to_subsys incremented it again */
-	subsys_put(sp);
-	subsys_put(sp);
-}
-
 static ssize_t class_attr_show(struct kobject *kobj, struct attribute *attr,
 			       char *buf)
 {
@@ -148,13 +130,15 @@ static const struct kobj_type class_ktype = {
 int class_create_file_ns(const struct class *cls, const struct class_attribute *attr,
 			 const void *ns)
 {
+	struct subsys_private *sp = class_to_subsys(cls);
 	int error;
 
-	if (cls)
-		error = sysfs_create_file_ns(&cls->p->subsys.kobj,
-					     &attr->attr, ns);
-	else
-		error = -EINVAL;
+	if (!sp)
+		return -EINVAL;
+
+	error = sysfs_create_file_ns(&sp->subsys.kobj, &attr->attr, ns);
+	subsys_put(sp);
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(class_create_file_ns);
@@ -162,8 +146,13 @@ EXPORT_SYMBOL_GPL(class_create_file_ns);
 void class_remove_file_ns(const struct class *cls, const struct class_attribute *attr,
 			  const void *ns)
 {
-	if (cls)
-		sysfs_remove_file_ns(&cls->p->subsys.kobj, &attr->attr, ns);
+	struct subsys_private *sp = class_to_subsys(cls);
+
+	if (!sp)
+		return;
+
+	sysfs_remove_file_ns(&sp->subsys.kobj, &attr->attr, ns);
+	subsys_put(sp);
 }
 EXPORT_SYMBOL_GPL(class_remove_file_ns);
 
@@ -187,18 +176,6 @@ static void klist_class_dev_put(struct klist_node *n)
 	put_device(dev);
 }
 
-static int class_add_groups(const struct class *cls,
-			    const struct attribute_group **groups)
-{
-	return sysfs_create_groups(&cls->p->subsys.kobj, groups);
-}
-
-static void class_remove_groups(const struct class *cls,
-				const struct attribute_group **groups)
-{
-	return sysfs_remove_groups(&cls->p->subsys.kobj, groups);
-}
-
 int class_register(struct class *cls)
 {
 	struct subsys_private *cp;
@@ -235,8 +212,7 @@ int class_register(struct class *cls)
 	if (error)
 		goto err_out;
 
-	error = class_add_groups(class_get(cls), cls->class_groups);
-	class_put(cls);
+	error = sysfs_create_groups(&cp->subsys.kobj, cls->class_groups);
 	if (error) {
 		kobject_del(&cp->subsys.kobj);
 		kfree_const(cp->subsys.kobj.name);
@@ -253,9 +229,16 @@ EXPORT_SYMBOL_GPL(class_register);
 
 void class_unregister(const struct class *cls)
 {
+	struct subsys_private *sp = class_to_subsys(cls);
+
+	if (!sp)
+		return;
+
 	pr_debug("device class '%s': unregistering\n", cls->name);
-	class_remove_groups(cls, cls->class_groups);
-	kset_unregister(&cls->p->subsys);
+
+	sysfs_remove_groups(&sp->subsys.kobj, cls->class_groups);
+	kset_unregister(&sp->subsys);
+	subsys_put(sp);
 }
 EXPORT_SYMBOL_GPL(class_unregister);
 
@@ -335,11 +318,15 @@ EXPORT_SYMBOL_GPL(class_destroy);
 void class_dev_iter_init(struct class_dev_iter *iter, const struct class *class,
 			 const struct device *start, const struct device_type *type)
 {
+	struct subsys_private *sp = class_to_subsys(class);
 	struct klist_node *start_knode = NULL;
 
+	if (!sp)
+		return;
+
 	if (start)
 		start_knode = &start->p->knode_class;
-	klist_iter_init_node(&class->p->klist_devices, &iter->ki, start_knode);
+	klist_iter_init_node(&sp->klist_devices, &iter->ki, start_knode);
 	iter->type = type;
 }
 EXPORT_SYMBOL_GPL(class_dev_iter_init);
@@ -406,13 +393,14 @@ EXPORT_SYMBOL_GPL(class_dev_iter_exit);
 int class_for_each_device(const struct class *class, const struct device *start,
 			  void *data, int (*fn)(struct device *, void *))
 {
+	struct subsys_private *sp = class_to_subsys(class);
 	struct class_dev_iter iter;
 	struct device *dev;
 	int error = 0;
 
 	if (!class)
 		return -EINVAL;
-	if (!class->p) {
+	if (!sp) {
 		WARN(1, "%s called for class '%s' before it was initialized",
 		     __func__, class->name);
 		return -EINVAL;
@@ -425,6 +413,7 @@ int class_for_each_device(const struct class *class, const struct device *start,
 			break;
 	}
 	class_dev_iter_exit(&iter);
+	subsys_put(sp);
 
 	return error;
 }
@@ -454,12 +443,13 @@ struct device *class_find_device(const struct class *class, const struct device
 				 const void *data,
 				 int (*match)(struct device *, const void *))
 {
+	struct subsys_private *sp = class_to_subsys(class);
 	struct class_dev_iter iter;
 	struct device *dev;
 
 	if (!class)
 		return NULL;
-	if (!class->p) {
+	if (!sp) {
 		WARN(1, "%s called for class '%s' before it was initialized",
 		     __func__, class->name);
 		return NULL;
@@ -473,6 +463,7 @@ struct device *class_find_device(const struct class *class, const struct device
 		}
 	}
 	class_dev_iter_exit(&iter);
+	subsys_put(sp);
 
 	return dev;
 }
@@ -480,6 +471,7 @@ EXPORT_SYMBOL_GPL(class_find_device);
 
 int class_interface_register(struct class_interface *class_intf)
 {
+	struct subsys_private *sp;
 	const struct class *parent;
 	struct class_dev_iter iter;
 	struct device *dev;
@@ -487,19 +479,25 @@ int class_interface_register(struct class_interface *class_intf)
 	if (!class_intf || !class_intf->class)
 		return -ENODEV;
 
-	parent = class_get(class_intf->class);
-	if (!parent)
+	parent = class_intf->class;
+	sp = class_to_subsys(parent);
+	if (!sp)
 		return -EINVAL;
 
-	mutex_lock(&parent->p->mutex);
-	list_add_tail(&class_intf->node, &parent->p->interfaces);
+	/*
+	 * Reference in sp is now incremented and will be dropped when
+	 * the interface is removed in the call to class_interface_unregister()
+	 */
+
+	mutex_lock(&sp->mutex);
+	list_add_tail(&class_intf->node, &sp->interfaces);
 	if (class_intf->add_dev) {
 		class_dev_iter_init(&iter, parent, NULL, NULL);
 		while ((dev = class_dev_iter_next(&iter)))
 			class_intf->add_dev(dev, class_intf);
 		class_dev_iter_exit(&iter);
 	}
-	mutex_unlock(&parent->p->mutex);
+	mutex_unlock(&sp->mutex);
 
 	return 0;
 }
@@ -507,6 +505,7 @@ EXPORT_SYMBOL_GPL(class_interface_register);
 
 void class_interface_unregister(struct class_interface *class_intf)
 {
+	struct subsys_private *sp;
 	struct class *parent = class_intf->class;
 	struct class_dev_iter iter;
 	struct device *dev;
@@ -514,7 +513,11 @@ void class_interface_unregister(struct class_interface *class_intf)
 	if (!parent)
 		return;
 
-	mutex_lock(&parent->p->mutex);
+	sp = class_to_subsys(parent);
+	if (!sp)
+		return;
+
+	mutex_lock(&sp->mutex);
 	list_del_init(&class_intf->node);
 	if (class_intf->remove_dev) {
 		class_dev_iter_init(&iter, parent, NULL, NULL);
@@ -522,9 +525,15 @@ void class_interface_unregister(struct class_interface *class_intf)
 			class_intf->remove_dev(dev, class_intf);
 		class_dev_iter_exit(&iter);
 	}
-	mutex_unlock(&parent->p->mutex);
+	mutex_unlock(&sp->mutex);
 
-	class_put(parent);
+	/*
+	 * Decrement the reference count twice, once for the class_to_subsys()
+	 * call in the start of this function, and the second one from the
+	 * reference increment in class_interface_register()
+	 */
+	subsys_put(sp);
+	subsys_put(sp);
 }
 EXPORT_SYMBOL_GPL(class_interface_unregister);
 
-- 
2.40.0

