Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709526C7C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCXKCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCXKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:01:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6072A227A5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:01:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21DB2B82352
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C790C433EF;
        Fri, 24 Mar 2023 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679652100;
        bh=dqKpjepsv/5XuQ6ZcvRFX98agB/CXZ0cLaaOskZX5Es=;
        h=From:To:Cc:Subject:Date:From;
        b=BXN8/56O2RInrL5alKfDr8udd1RoBw6xn+IfpvF86eq/BMHgOld2jkID9k5UoLM8i
         FKP+WNO5BJwhrTPBmBu4dPwfLu1CF/fD5Djq1XMeHLpmn9zXa43Fwdz4gXBVjU2BnG
         qK9VtXTnPSBlVTAGSvKVBxkiMgvmnpB4DWi8pCog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/2] driver core: class: use lock_class_key already present in struct subsys_private
Date:   Fri, 24 Mar 2023 11:01:31 +0100
Message-Id: <20230324100132.1633647-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5272; i=gregkh@linuxfoundation.org; h=from:subject; bh=dqKpjepsv/5XuQ6ZcvRFX98agB/CXZ0cLaaOskZX5Es=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmyJb9keP22vF3yUSKotEptetwiPfnXVjN/1Lzj8NluI RRls/pBRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExEdgfDPOtLKpkl4QcWn47c kHdJSUpysuplEYYFRwzbvt1V1D3sWsyQ5ejx/NaXO94VAA==
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

In commit 37e98d9bedb5 ("driver core: bus: move lock_class_key into
dynamic structure"), we moved the lock_class_key into the internal
structure shared by busses and classes, but only used it for buses.

Move the class code to use this structure as it is already present and
being allocated, instead of the statically allocated on-the-stack
variable that class_create() was using as part of a macro wrapper around
the core function call.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c         | 15 +++++++++------
 include/linux/device/class.h | 36 ++----------------------------------
 2 files changed, 11 insertions(+), 40 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 3d65221b0dcb..dbaeb79ae917 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -154,9 +154,10 @@ static void class_remove_groups(struct class *cls,
 	return sysfs_remove_groups(&cls->p->subsys.kobj, groups);
 }
 
-int __class_register(struct class *cls, struct lock_class_key *key)
+int class_register(struct class *cls)
 {
 	struct subsys_private *cp;
+	struct lock_class_key *key;
 	int error;
 
 	pr_debug("device class '%s': registering\n", cls->name);
@@ -167,6 +168,8 @@ int __class_register(struct class *cls, struct lock_class_key *key)
 	klist_init(&cp->klist_devices, klist_class_dev_get, klist_class_dev_put);
 	INIT_LIST_HEAD(&cp->interfaces);
 	kset_init(&cp->glue_dirs);
+	key = &cp->lock_key;
+	lockdep_register_key(key);
 	__mutex_init(&cp->mutex, "subsys mutex", key);
 	error = kobject_set_name(&cp->subsys.kobj, "%s", cls->name);
 	if (error) {
@@ -201,7 +204,7 @@ int __class_register(struct class *cls, struct lock_class_key *key)
 	cls->p = NULL;
 	return error;
 }
-EXPORT_SYMBOL_GPL(__class_register);
+EXPORT_SYMBOL_GPL(class_register);
 
 void class_unregister(struct class *cls)
 {
@@ -218,7 +221,7 @@ static void class_create_release(struct class *cls)
 }
 
 /**
- * __class_create - create a struct class structure
+ * class_create - create a struct class structure
  * @name: pointer to a string for the name of this class.
  * @key: the lock_class_key for this class; used by mutex lock debugging
  *
@@ -230,7 +233,7 @@ static void class_create_release(struct class *cls)
  * Note, the pointer created here is to be destroyed when finished by
  * making a call to class_destroy().
  */
-struct class *__class_create(const char *name, struct lock_class_key *key)
+struct class *class_create(const char *name)
 {
 	struct class *cls;
 	int retval;
@@ -244,7 +247,7 @@ struct class *__class_create(const char *name, struct lock_class_key *key)
 	cls->name = name;
 	cls->class_release = class_create_release;
 
-	retval = __class_register(cls, key);
+	retval = class_register(cls);
 	if (retval)
 		goto error;
 
@@ -254,7 +257,7 @@ struct class *__class_create(const char *name, struct lock_class_key *key)
 	kfree(cls);
 	return ERR_PTR(retval);
 }
-EXPORT_SYMBOL_GPL(__class_create);
+EXPORT_SYMBOL_GPL(class_create);
 
 /**
  * class_destroy - destroys a struct class structure
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index 75c1451fcc63..03d2f99f84c5 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -82,18 +82,9 @@ struct class_dev_iter {
 
 extern struct kobject *sysfs_dev_block_kobj;
 extern struct kobject *sysfs_dev_char_kobj;
-extern int __must_check __class_register(struct class *class,
-					 struct lock_class_key *key);
+extern int __must_check class_register(struct class *class);
 extern void class_unregister(struct class *class);
 
-/* This is a #define to keep the compiler from merging different
- * instances of the __key variable */
-#define class_register(class)			\
-({						\
-	static struct lock_class_key __key;	\
-	__class_register(class, &__key);	\
-})
-
 struct class_compat;
 struct class_compat *class_compat_register(const char *name);
 void class_compat_unregister(struct class_compat *cls);
@@ -246,30 +237,7 @@ struct class_interface {
 extern int __must_check class_interface_register(struct class_interface *);
 extern void class_interface_unregister(struct class_interface *);
 
-extern struct class * __must_check __class_create(const char *name,
-						  struct lock_class_key *key);
+extern struct class * __must_check class_create(const char *name);
 extern void class_destroy(struct class *cls);
 
-/* This is a #define to keep the compiler from merging different
- * instances of the __key variable */
-
-/**
- * class_create - create a struct class structure
- * @name: pointer to a string for the name of this class.
- *
- * This is used to create a struct class pointer that can then be used
- * in calls to device_create().
- *
- * Returns &struct class pointer on success, or ERR_PTR() on error.
- *
- * Note, the pointer created here is to be destroyed when finished by
- * making a call to class_destroy().
- */
-#define class_create(name)			\
-({						\
-	static struct lock_class_key __key;	\
-	__class_create(name, &__key);		\
-})
-
-
 #endif	/* _DEVICE_CLASS_H_ */
-- 
2.40.0

