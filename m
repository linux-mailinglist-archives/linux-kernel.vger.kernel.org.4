Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F94D6C8CBF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjCYIpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYIpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:45:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE8949E1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:45:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAC50B80315
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 08:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F24C433EF;
        Sat, 25 Mar 2023 08:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679733931;
        bh=W7n+Htf22kQhrM+d1Y6neLm/EK7Vhnf40Pez95sKMhw=;
        h=From:To:Cc:Subject:Date:From;
        b=ilbnJZmR9mR/JVe2wsvDuoSnXVUj9WU7jDksngUcO6ycgLU7Q2BYAcke0M7j5SDj/
         F3Go7II23RmNkbgnsAjah/HwK8wWW2x+hakRBfNbSkKe1Dc7pB3+P+QOcAJugzTT7k
         g78Y7JmOFII1rbZ3MDMDyyY3YLOFITdS4rLSaZno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: bus: constify class_unregister/destroy()
Date:   Sat, 25 Mar 2023 09:45:26 +0100
Message-Id: <20230325084526.3622123-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2579; i=gregkh@linuxfoundation.org; h=from:subject; bh=W7n+Htf22kQhrM+d1Y6neLm/EK7Vhnf40Pez95sKMhw=; b=owGbwMvMwCRo6H6F97bub03G02pJDClyW5b8/zyJ8wJTj1etFK+2hS3vuXfxTR/+7byz5PTJy 7P4r/jv6YhlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJPJZjmJ/UdsK3cn3Yjfq0 +39dVE5qnpy/yZRhvrvr6xaTwLtsBnM5E7K5tQ4a3J8UAgA=
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

The class_unregister() and class_destroy() function should be taking a
const * to struct class, not just a *, so fix that up.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c         | 8 ++++----
 include/linux/device/class.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index dbaeb79ae917..41a6a10da8dd 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -142,13 +142,13 @@ static void klist_class_dev_put(struct klist_node *n)
 	put_device(dev);
 }
 
-static int class_add_groups(struct class *cls,
+static int class_add_groups(const struct class *cls,
 			    const struct attribute_group **groups)
 {
 	return sysfs_create_groups(&cls->p->subsys.kobj, groups);
 }
 
-static void class_remove_groups(struct class *cls,
+static void class_remove_groups(const struct class *cls,
 				const struct attribute_group **groups)
 {
 	return sysfs_remove_groups(&cls->p->subsys.kobj, groups);
@@ -206,7 +206,7 @@ int class_register(struct class *cls)
 }
 EXPORT_SYMBOL_GPL(class_register);
 
-void class_unregister(struct class *cls)
+void class_unregister(const struct class *cls)
 {
 	pr_debug("device class '%s': unregistering\n", cls->name);
 	class_remove_groups(cls, cls->class_groups);
@@ -266,7 +266,7 @@ EXPORT_SYMBOL_GPL(class_create);
  * Note, the pointer to be destroyed must have been created with a call
  * to class_create().
  */
-void class_destroy(struct class *cls)
+void class_destroy(const struct class *cls)
 {
 	if (IS_ERR_OR_NULL(cls))
 		return;
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index 1dc7706cb42d..59af129f77e1 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -84,7 +84,7 @@ extern struct kobject *sysfs_dev_block_kobj;
 extern struct kobject *sysfs_dev_char_kobj;
 
 int __must_check class_register(struct class *class);
-void class_unregister(struct class *class);
+void class_unregister(const struct class *class);
 
 struct class_compat;
 struct class_compat *class_compat_register(const char *name);
@@ -232,6 +232,6 @@ int __must_check class_interface_register(struct class_interface *);
 void class_interface_unregister(struct class_interface *);
 
 struct class * __must_check class_create(const char *name);
-void class_destroy(struct class *cls);
+void class_destroy(const struct class *cls);
 
 #endif	/* _DEVICE_CLASS_H_ */
-- 
2.40.0

