Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9906B57FB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 04:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCKDPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 22:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCKDO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 22:14:59 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10798132A94
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 19:14:57 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678504495;
        bh=7UpojwGw4Wjc6iwDTG11oJXV5hBbJObX8sfOzw0j3+8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Zuk3/bEco0V/MQXZlAcAPaRUfq7PBCyCHrQ5lII+Ejk8k5muVy2a8j2D9o65dIe4F
         SN5qJxczydCRpCvjAZlU61FElYRahnllDt3phpk2ftEsX3DwthmRQCWOpaC0HIJJ0W
         fojPpoCxInntp/Jpzl3pMUswSsbdVq9HDcIg5YR8=
Date:   Sat, 11 Mar 2023 03:14:46 +0000
Subject: [PATCH 1/4] kobject: define common logging prefix
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230311-kobject-warning-v1-1-1ebba4f71fb5@weissschuh.net>
References: <20230311-kobject-warning-v1-0-1ebba4f71fb5@weissschuh.net>
In-Reply-To: <20230311-kobject-warning-v1-0-1ebba4f71fb5@weissschuh.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678504493; l=4592;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=7UpojwGw4Wjc6iwDTG11oJXV5hBbJObX8sfOzw0j3+8=;
 b=srn5/5x4qNccxjCHSdFcj5F169tzEJq4pb0s/zWHAQ8IsN85mklJg4gN9ClW7E8LNGFsu+m19
 eUbb4wQJLKgA94beuVi7iaIN2+Jx8vzhVXebWmGchzayQCZ7O5c8qIg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All log messages start with the prefix "kobject: ".
Deduplicate this by using the pr_fmt() facility.

This makes the very long log strings shorter.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 lib/kobject.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/lib/kobject.c b/lib/kobject.c
index 6e2f0bee3560..09c81ffb8b33 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -10,6 +10,8 @@
  * about using the kobject interface.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kobject.h>
 #include <linux/string.h>
 #include <linux/export.h>
@@ -127,7 +129,7 @@ static int fill_kobj_path(const struct kobject *kobj, char *path, int length)
 		*(path + --length) = '/';
 	}
 
-	pr_debug("kobject: '%s' (%p): %s: path = '%s'\n", kobject_name(kobj),
+	pr_debug("'%s' (%p): %s: path = '%s'\n", kobject_name(kobj),
 		 kobj, __func__, path);
 
 	return 0;
@@ -223,7 +225,7 @@ static int kobject_add_internal(struct kobject *kobj)
 		kobj->parent = parent;
 	}
 
-	pr_debug("kobject: '%s' (%p): %s: parent: '%s', set: '%s'\n",
+	pr_debug("'%s' (%p): %s: parent: '%s', set: '%s'\n",
 		 kobject_name(kobj), kobj, __func__,
 		 parent ? kobject_name(parent) : "<NULL>",
 		 kobj->kset ? kobject_name(&kobj->kset->kobj) : "<NULL>");
@@ -359,7 +361,7 @@ static __printf(3, 0) int kobject_add_varg(struct kobject *kobj,
 
 	retval = kobject_set_name_vargs(kobj, fmt, vargs);
 	if (retval) {
-		pr_err("kobject: can not set name properly!\n");
+		pr_err("can not set name properly!\n");
 		return retval;
 	}
 	kobj->parent = parent;
@@ -588,7 +590,7 @@ static void __kobject_del(struct kobject *kobj)
 
 	/* send "remove" if the caller did not do it but sent "add" */
 	if (kobj->state_add_uevent_sent && !kobj->state_remove_uevent_sent) {
-		pr_debug("kobject: '%s' (%p): auto cleanup 'remove' event\n",
+		pr_debug("'%s' (%p): auto cleanup 'remove' event\n",
 			 kobject_name(kobj), kobj);
 		kobject_uevent(kobj, KOBJ_REMOVE);
 	}
@@ -658,16 +660,16 @@ static void kobject_cleanup(struct kobject *kobj)
 	const struct kobj_type *t = get_ktype(kobj);
 	const char *name = kobj->name;
 
-	pr_debug("kobject: '%s' (%p): %s, parent %p\n",
+	pr_debug("'%s' (%p): %s, parent %p\n",
 		 kobject_name(kobj), kobj, __func__, kobj->parent);
 
 	if (t && !t->release)
-		pr_debug("kobject: '%s' (%p): does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.\n",
+		pr_debug("'%s' (%p): does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.\n",
 			 kobject_name(kobj), kobj);
 
 	/* remove from sysfs if the caller did not do it */
 	if (kobj->state_in_sysfs) {
-		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
+		pr_debug("'%s' (%p): auto cleanup kobject_del\n",
 			 kobject_name(kobj), kobj);
 		__kobject_del(kobj);
 	} else {
@@ -676,14 +678,14 @@ static void kobject_cleanup(struct kobject *kobj)
 	}
 
 	if (t && t->release) {
-		pr_debug("kobject: '%s' (%p): calling ktype release\n",
+		pr_debug("'%s' (%p): calling ktype release\n",
 			 kobject_name(kobj), kobj);
 		t->release(kobj);
 	}
 
 	/* free name if we allocated it */
 	if (name) {
-		pr_debug("kobject: '%s': free name\n", name);
+		pr_debug("'%s': free name\n", name);
 		kfree_const(name);
 	}
 
@@ -703,8 +705,8 @@ static void kobject_release(struct kref *kref)
 	struct kobject *kobj = container_of(kref, struct kobject, kref);
 #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
 	unsigned long delay = HZ + HZ * get_random_u32_below(4);
-	pr_info("kobject: '%s' (%p): %s, parent %p (delayed %ld)\n",
-		 kobject_name(kobj), kobj, __func__, kobj->parent, delay);
+	pr_info("'%s' (%p): %s, parent %p (delayed %ld)\n",
+		kobject_name(kobj), kobj, __func__, kobj->parent, delay);
 	INIT_DELAYED_WORK(&kobj->release, kobject_delayed_cleanup);
 
 	schedule_delayed_work(&kobj->release, delay);
@@ -733,7 +735,7 @@ EXPORT_SYMBOL(kobject_put);
 
 static void dynamic_kobj_release(struct kobject *kobj)
 {
-	pr_debug("kobject: (%p): %s\n", kobj, __func__);
+	pr_debug("(%p): %s\n", kobj, __func__);
 	kfree(kobj);
 }
 
@@ -910,7 +912,7 @@ EXPORT_SYMBOL_GPL(kset_find_obj);
 static void kset_release(struct kobject *kobj)
 {
 	struct kset *kset = container_of(kobj, struct kset, kobj);
-	pr_debug("kobject: '%s' (%p): %s\n",
+	pr_debug("'%s' (%p): %s\n",
 		 kobject_name(kobj), kobj, __func__);
 	kfree(kset);
 }

-- 
2.39.2

