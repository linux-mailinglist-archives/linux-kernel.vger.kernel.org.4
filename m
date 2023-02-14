Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79815696724
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjBNOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjBNOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:41:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD17222782
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:41:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78F62B81D57
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5D7C433D2;
        Tue, 14 Feb 2023 14:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676385681;
        bh=lbbg43PStKyBji25cugZl7z2Wo+JqNKTmI03zrJYDYo=;
        h=From:To:Cc:Subject:Date:From;
        b=v+fbA+4JWP8YhvkxgOhYdNWHqEe0KLqbNIaixMIK+kYyIvcUBVtrzp6UYUU1xjch5
         +ydGZSeXdUH+qY9Vj7Kxoks/PvnmmlLfQyg1rpWtuStVMnJbMcc+spT3KSIrPkvVII
         SNvdGF1CSVEEh9UVG4FzLhxeQ+sfUBjalbMtQpEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: class: move EXPORT_SYMBOL_GPL() lines to the correct place
Date:   Tue, 14 Feb 2023 15:41:17 +0100
Message-Id: <20230214144117.158956-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2459; i=gregkh@linuxfoundation.org; h=from:subject; bh=lbbg43PStKyBji25cugZl7z2Wo+JqNKTmI03zrJYDYo=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmv53bfLloTd0vgqdmB59k3A3WmXNO5vHDt2SkLtyRG3OnX jE292hHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATuWPKsGB35vqbqSvaNmmvluHWuD dj3S+2w1cZ5jvdVbG+HmWx51sDD9fG1uqH/K8yQwE=
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

For some reason, the drivers/base/class.c file still had the "old style"
of exports, at the end of the file.  Move the exports to the proper
location, right after the function, to be correct.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 89d4528fcc1a..2373b3e210d8 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -99,6 +99,7 @@ int class_create_file_ns(struct class *cls, const struct class_attribute *attr,
 		error = -EINVAL;
 	return error;
 }
+EXPORT_SYMBOL_GPL(class_create_file_ns);
 
 void class_remove_file_ns(struct class *cls, const struct class_attribute *attr,
 			  const void *ns)
@@ -106,6 +107,7 @@ void class_remove_file_ns(struct class *cls, const struct class_attribute *attr,
 	if (cls)
 		sysfs_remove_file_ns(&cls->p->subsys.kobj, &attr->attr, ns);
 }
+EXPORT_SYMBOL_GPL(class_remove_file_ns);
 
 static struct class *class_get(struct class *cls)
 {
@@ -213,6 +215,7 @@ void class_unregister(struct class *cls)
 	class_remove_groups(cls, cls->class_groups);
 	kset_unregister(&cls->p->subsys);
 }
+EXPORT_SYMBOL_GPL(class_unregister);
 
 static void class_create_release(struct class *cls)
 {
@@ -276,6 +279,7 @@ void class_destroy(struct class *cls)
 
 	class_unregister(cls);
 }
+EXPORT_SYMBOL_GPL(class_destroy);
 
 /**
  * class_dev_iter_init - initialize class device iterator
@@ -460,6 +464,7 @@ int class_interface_register(struct class_interface *class_intf)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(class_interface_register);
 
 void class_interface_unregister(struct class_interface *class_intf)
 {
@@ -482,6 +487,7 @@ void class_interface_unregister(struct class_interface *class_intf)
 
 	class_put(parent);
 }
+EXPORT_SYMBOL_GPL(class_interface_unregister);
 
 ssize_t show_class_attr_string(struct class *class,
 			       struct class_attribute *attr, char *buf)
@@ -588,11 +594,3 @@ int __init classes_init(void)
 		return -ENOMEM;
 	return 0;
 }
-
-EXPORT_SYMBOL_GPL(class_create_file_ns);
-EXPORT_SYMBOL_GPL(class_remove_file_ns);
-EXPORT_SYMBOL_GPL(class_unregister);
-EXPORT_SYMBOL_GPL(class_destroy);
-
-EXPORT_SYMBOL_GPL(class_interface_register);
-EXPORT_SYMBOL_GPL(class_interface_unregister);
-- 
2.39.1

