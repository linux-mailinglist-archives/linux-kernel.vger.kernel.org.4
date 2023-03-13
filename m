Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489426B8036
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCMSTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCMSS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:18:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1641C4DBFD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:18:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4A8DB811B3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A0DC433EF;
        Mon, 13 Mar 2023 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678731535;
        bh=7JjMhndsMDUXE8DafQk0gW/zTqbD/+DD3G1NK5IQe+0=;
        h=From:To:Cc:Subject:Date:From;
        b=fQMIyCIRY+9wS0eO9vdqAfApHXqTWcAq8oiY1nx0vT+QTR6Yxm0CCxTo18iR9FHBd
         uxoZEWX2X+CH5HOaxq4TLLUkKV9aT2VROWPEUCj5mQwBR+ZzwAVvdjMoBqiJkGlQfI
         RvMlgqjVILrGF5mxlJ4Av8+9gOtf/VkjTjJDmi+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 01/12] driver core: class: specify the module owner in __class_register()
Date:   Mon, 13 Mar 2023 19:18:32 +0100
Message-Id: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2805; i=gregkh@linuxfoundation.org; h=from:subject; bh=7JjMhndsMDUXE8DafQk0gW/zTqbD/+DD3G1NK5IQe+0=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn8Gf+/LM/161pfIFN5M27j6vt/phjOjGP207oft2vTk f5vzr68HbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRrQcZ5vAlRzPYbJqs5sLp 21NxX+549kUHJoYFV4rEbm17aH7OO6R9c9+SqdZc5w8pAgA=
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

There's no need to manually have to set the module owner of a class, the
compiler should do it automatically for you, so add a module * to the
__class_register() function and allow it to set the module owner
automatically.

This will let us move the module pointer out of struct class eventually,
as it should not be embedded in there if we wish for it to be a
read-only structure eventually.

And, funny story, this module pointer isn't even being used for
anything, so while we will keep it around for now, it's not like it even
matters.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c         | 6 +++---
 include/linux/device/class.h | 9 +++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 5983eead8391..90dc5788957a 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -154,7 +154,7 @@ static void class_remove_groups(struct class *cls,
 	return sysfs_remove_groups(&cls->p->subsys.kobj, groups);
 }
 
-int __class_register(struct class *cls, struct lock_class_key *key)
+int __class_register(struct class *cls, struct module *owner, struct lock_class_key *key)
 {
 	struct subsys_private *cp;
 	int error;
@@ -187,6 +187,7 @@ int __class_register(struct class *cls, struct lock_class_key *key)
 	if (error)
 		goto err_out;
 
+	cls->owner = owner;
 	error = class_add_groups(class_get(cls), cls->class_groups);
 	class_put(cls);
 	if (error) {
@@ -244,10 +245,9 @@ struct class *__class_create(struct module *owner, const char *name,
 	}
 
 	cls->name = name;
-	cls->owner = owner;
 	cls->class_release = class_create_release;
 
-	retval = __class_register(cls, key);
+	retval = __class_register(cls, owner, key);
 	if (retval)
 		goto error;
 
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index 42cc3fb44a84..d1ba4ee235dc 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -85,15 +85,16 @@ struct class_dev_iter {
 extern struct kobject *sysfs_dev_block_kobj;
 extern struct kobject *sysfs_dev_char_kobj;
 extern int __must_check __class_register(struct class *class,
+					 struct module *owner,
 					 struct lock_class_key *key);
 extern void class_unregister(struct class *class);
 
 /* This is a #define to keep the compiler from merging different
  * instances of the __key variable */
-#define class_register(class)			\
-({						\
-	static struct lock_class_key __key;	\
-	__class_register(class, &__key);	\
+#define class_register(class)				\
+({							\
+	static struct lock_class_key __key;		\
+	__class_register(class, THIS_MODULE, &__key);	\
 })
 
 struct class_compat;
-- 
2.39.2

