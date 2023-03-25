Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314856C908C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 20:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjCYTmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 15:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCYTmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 15:42:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6A2D335
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 12:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D979A60C7B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 19:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5474C433D2;
        Sat, 25 Mar 2023 19:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679773362;
        bh=JcCdF0mN69Zz2znnMJC1O/kdnaIN+fa7+l2p4uMQljM=;
        h=From:To:Cc:Subject:Date:From;
        b=QYLEoKifZabVQouyjO7eTab2mJqL+2+L5Cnk4/3WVOtBmdUA8ogzgkXSVmTkJiBXu
         gy1Jnwfjdy8YU6X3yhKgaZYGLinwLmScVy+i9C3Tt2FxVQp21Hmcw7bq5fuwl0ky67
         8Iqqw18c/UD8In9mOQKY+oNQ4FtJ24CxiG93+r80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/2] driver core: class: implement class_get/put without the private pointer.
Date:   Sat, 25 Mar 2023 20:42:33 +0100
Message-Id: <20230325194234.46588-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4281; i=gregkh@linuxfoundation.org; h=from:subject; bh=JcCdF0mN69Zz2znnMJC1O/kdnaIN+fa7+l2p4uMQljM=; b=owGbwMvMwCRo6H6F97bub03G02pJDCnyfiuunjoWeMJVebvihnPhZ+/VbP2+p7307qkNi31fb CmQ//KXtSOWhUGQiUFWTJHlyzaeo/srDil6GdqehpnDygQyhIGLUwAmMr+HYcHOQvltjw1nmJ5N 2n47TtP7m7Ln+mCGBVPvPCstYlZutoy4LFiwxdnfoImlGgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Much like what was done in commit 273afac615ad ("driver core: bus:
implement bus_get/put() without the private pointer"), it is time to
move the driver core away from using the internal private pointer in
struct class in order to enable it to be always a constant and be placed
in read-only memory in the future.

First step in doing this is to create a helper function that turns a
'struct class' into 'struct subsys_private' called class_to_subsys().

class_to_subsys() walks the list of registered busses in the system and
finds the matching one based on the pointer to the class itself.  As
this is a short list, and this function is not on any fast path, it
should not be noticable.

Implement class_get() and class_put() using this new helper function.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c | 81 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 18 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index ecbf8b5b0dff..90678f6ed4ba 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -20,8 +20,70 @@
 #include <linux/mutex.h>
 #include "base.h"
 
+/* /sys/class */
+static struct kset *class_kset;
+
 #define to_class_attr(_attr) container_of(_attr, struct class_attribute, attr)
 
+/**
+ * class_to_subsys - Turn a struct class into a struct subsys_private
+ *
+ * @class: pointer to the struct bus_type to look up
+ *
+ * The driver core internals need to work on the subsys_private structure, not
+ * the external struct class pointer.  This function walks the list of
+ * registered classes in the system and finds the matching one and returns the
+ * internal struct subsys_private that relates to that class.
+ *
+ * Note, the reference count of the return value is INCREMENTED if it is not
+ * NULL.  A call to subsys_put() must be done when finished with the pointer in
+ * order for it to be properly freed.
+ */
+static struct subsys_private *class_to_subsys(const struct class *class)
+{
+	struct subsys_private *sp = NULL;
+	struct kobject *kobj;
+
+	if (!class || !class_kset)
+		return NULL;
+
+	spin_lock(&class_kset->list_lock);
+
+	if (list_empty(&class_kset->list))
+		goto done;
+
+	list_for_each_entry(kobj, &class_kset->list, entry) {
+		struct kset *kset = container_of(kobj, struct kset, kobj);
+
+		sp = container_of_const(kset, struct subsys_private, subsys);
+		if (sp->class == class)
+			goto done;
+	}
+	sp = NULL;
+done:
+	sp = subsys_get(sp);
+	spin_unlock(&class_kset->list_lock);
+	return sp;
+}
+
+static const struct class *class_get(const struct class *class)
+{
+	struct subsys_private *sp = class_to_subsys(class);
+
+	if (sp)
+		return class;
+	return NULL;
+}
+
+static void class_put(const struct class *class)
+{
+	struct subsys_private *sp = class_to_subsys(class);
+
+	/* two puts are required as the call to bus_to_subsys incremented it again */
+	subsys_put(sp);
+	subsys_put(sp);
+}
+
 static ssize_t class_attr_show(struct kobject *kobj, struct attribute *attr,
 			       char *buf)
 {
@@ -83,10 +145,6 @@ static const struct kobj_type class_ktype = {
 	.child_ns_type	= class_child_ns_type,
 };
 
-/* Hotplug events for classes go to the class subsys */
-static struct kset *class_kset;
-
-
 int class_create_file_ns(const struct class *cls, const struct class_attribute *attr,
 			 const void *ns)
 {
@@ -109,19 +167,6 @@ void class_remove_file_ns(const struct class *cls, const struct class_attribute
 }
 EXPORT_SYMBOL_GPL(class_remove_file_ns);
 
-static struct class *class_get(struct class *cls)
-{
-	if (cls)
-		kset_get(&cls->p->subsys);
-	return cls;
-}
-
-static void class_put(struct class *cls)
-{
-	if (cls)
-		kset_put(&cls->p->subsys);
-}
-
 static struct device *klist_class_to_dev(struct klist_node *n)
 {
 	struct device_private *p = to_device_private_class(n);
@@ -435,7 +480,7 @@ EXPORT_SYMBOL_GPL(class_find_device);
 
 int class_interface_register(struct class_interface *class_intf)
 {
-	struct class *parent;
+	const struct class *parent;
 	struct class_dev_iter iter;
 	struct device *dev;
 
-- 
2.40.0

