Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019886B803C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCMSTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCMSTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:19:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEB061885
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0AD96146B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D085EC433D2;
        Mon, 13 Mar 2023 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678731546;
        bh=cib7ApbQtRG8MKintUh5TbtWUrZ34MnqLkrh57nxADo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhFcuJZ6fGcme+4atL/gZMwiMxBV6BL9g861TBYP0AzpWyon1x6GwllZ1sQWHuKna
         m8OkFMjW2cPD0L6SOW04436JbzUdZEvy+59xtHfCzwbsHSmfzmgl8W3TPUgYIHt1xa
         YW7/Ca+03tVbPsPEPhl/lVj3xBGlBWBCiBoUlc1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 03/12] driver core: class: remove struct module owner out of struct class
Date:   Mon, 13 Mar 2023 19:18:34 +0100
Message-Id: <20230313181843.1207845-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
References: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4809; i=gregkh@linuxfoundation.org; h=from:subject; bh=cib7ApbQtRG8MKintUh5TbtWUrZ34MnqLkrh57nxADo=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn8mYxS1uJJ72xnNwRyeVx/kzP1VlR0XcEOnWVh9+peV uRfkXTtiGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgIm84WeYp3WVZ1PpyX9PVZLn bHAXlmMpn6XMxrDgUqzAtxfu3kwHGxQ2aKR9CmaYvTUUAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module owner field for a struct class was never actually used, so
remove it as it is not doing anything at all.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c         |  9 +++------
 include/linux/device/class.h | 18 +++++++-----------
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 90dc5788957a..9439c6c7466f 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -154,7 +154,7 @@ static void class_remove_groups(struct class *cls,
 	return sysfs_remove_groups(&cls->p->subsys.kobj, groups);
 }
 
-int __class_register(struct class *cls, struct module *owner, struct lock_class_key *key)
+int __class_register(struct class *cls, struct lock_class_key *key)
 {
 	struct subsys_private *cp;
 	int error;
@@ -187,7 +187,6 @@ int __class_register(struct class *cls, struct module *owner, struct lock_class_
 	if (error)
 		goto err_out;
 
-	cls->owner = owner;
 	error = class_add_groups(class_get(cls), cls->class_groups);
 	class_put(cls);
 	if (error) {
@@ -220,7 +219,6 @@ static void class_create_release(struct class *cls)
 
 /**
  * __class_create - create a struct class structure
- * @owner: pointer to the module that is to "own" this struct class
  * @name: pointer to a string for the name of this class.
  * @key: the lock_class_key for this class; used by mutex lock debugging
  *
@@ -232,8 +230,7 @@ static void class_create_release(struct class *cls)
  * Note, the pointer created here is to be destroyed when finished by
  * making a call to class_destroy().
  */
-struct class *__class_create(struct module *owner, const char *name,
-			     struct lock_class_key *key)
+struct class *__class_create(const char *name, struct lock_class_key *key)
 {
 	struct class *cls;
 	int retval;
@@ -247,7 +244,7 @@ struct class *__class_create(struct module *owner, const char *name,
 	cls->name = name;
 	cls->class_release = class_create_release;
 
-	retval = __class_register(cls, owner, key);
+	retval = __class_register(cls, key);
 	if (retval)
 		goto error;
 
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index d1ba4ee235dc..bf736f14f0c1 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -25,7 +25,6 @@ struct fwnode_handle;
 /**
  * struct class - device classes
  * @name:	Name of the class.
- * @owner:	The module owner.
  * @class_groups: Default attributes of this class.
  * @dev_groups:	Default attributes of the devices that belong to the class.
  * @dev_kobj:	The kobject that represents this class and links it into the hierarchy.
@@ -53,7 +52,6 @@ struct fwnode_handle;
  */
 struct class {
 	const char		*name;
-	struct module		*owner;
 
 	const struct attribute_group	**class_groups;
 	const struct attribute_group	**dev_groups;
@@ -85,16 +83,15 @@ struct class_dev_iter {
 extern struct kobject *sysfs_dev_block_kobj;
 extern struct kobject *sysfs_dev_char_kobj;
 extern int __must_check __class_register(struct class *class,
-					 struct module *owner,
 					 struct lock_class_key *key);
 extern void class_unregister(struct class *class);
 
 /* This is a #define to keep the compiler from merging different
  * instances of the __key variable */
-#define class_register(class)				\
-({							\
-	static struct lock_class_key __key;		\
-	__class_register(class, THIS_MODULE, &__key);	\
+#define class_register(class)			\
+({						\
+	static struct lock_class_key __key;	\
+	__class_register(class, &__key);	\
 })
 
 struct class_compat;
@@ -250,8 +247,7 @@ struct class_interface {
 extern int __must_check class_interface_register(struct class_interface *);
 extern void class_interface_unregister(struct class_interface *);
 
-extern struct class * __must_check __class_create(struct module *owner,
-						  const char *name,
+extern struct class * __must_check __class_create(const char *name,
 						  struct lock_class_key *key);
 extern void class_destroy(struct class *cls);
 
@@ -260,7 +256,7 @@ extern void class_destroy(struct class *cls);
 
 /**
  * class_create - create a struct class structure
- * @owner: pointer to the module that is to "own" this struct class
+ * @owner: dummy pointer, does nothing, will be removed soon.
  * @name: pointer to a string for the name of this class.
  *
  * This is used to create a struct class pointer that can then be used
@@ -274,7 +270,7 @@ extern void class_destroy(struct class *cls);
 #define class_create(owner, name)		\
 ({						\
 	static struct lock_class_key __key;	\
-	__class_create(owner, name, &__key);	\
+	__class_create(name, &__key);		\
 })
 
 
-- 
2.39.2

