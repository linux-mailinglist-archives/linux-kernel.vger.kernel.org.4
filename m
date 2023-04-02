Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FAF6D399E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 19:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjDBR7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 13:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjDBR7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 13:59:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602DEDBF3
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 10:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D72DBB80F02
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 17:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C32BC433D2;
        Sun,  2 Apr 2023 17:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680458349;
        bh=4x1kMrX4o0OHNQFtezpfSrEFxvp1hGakgpbo4FR7d1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1X/OWQT+qUf88EQhJxJt7QwVAJGGOlfP0aR7DqS95FxnoYIvjgyYE1uCEW6O7MlLu
         zZDhlVn7xtCMKPnRcHbJOzBry4BZKvmKkVcW6CtZ4ESu8ua9rJc85gQAvkzBzIRj+A
         gA4oWK2lsira/5wgEwqRT0fnAnBCSV4ANyqQSglI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/5] driver core: class: make class_register() take a const *
Date:   Sun,  2 Apr 2023 19:58:47 +0200
Message-Id: <2023040248-customary-release-4aec@gregkh>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <2023040244-duffel-pushpin-f738@gregkh>
References: <2023040244-duffel-pushpin-f738@gregkh>
MIME-Version: 1.0
Lines:  71
X-Developer-Signature: v=1; a=openpgp-sha256; l=2435; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=4x1kMrX4o0OHNQFtezpfSrEFxvp1hGakgpbo4FR7d1g=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmahyI353021p6+7XlKo7pCsYxVUIFkQhTrs4yr0dG3t szM2nS4I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACay5gDDHG7jU7Xzptq0L/h4 Odm8gs3xUZa6KcOCHWFs2p2iW6qPbiiUsf25K4ZXyFcbAA==
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

Now that the class code is cleaned up to not modify the class pointer
registered with it, change class_register() to take a const * to allow
the structure to be placed into read-only memory.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h          | 2 +-
 drivers/base/class.c         | 6 +++---
 include/linux/device/class.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index e96f3343fd7c..eb4c0ace9242 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -54,7 +54,7 @@ struct subsys_private {
 	struct device *dev_root;
 
 	struct kset glue_dirs;
-	struct class *class;
+	const struct class *class;
 
 	struct lock_class_key lock_key;
 };
diff --git a/drivers/base/class.c b/drivers/base/class.c
index 53fc7052340c..05bce79d3d19 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -93,7 +93,7 @@ static ssize_t class_attr_store(struct kobject *kobj, struct attribute *attr,
 static void class_release(struct kobject *kobj)
 {
 	struct subsys_private *cp = to_subsys_private(kobj);
-	struct class *class = cp->class;
+	const struct class *class = cp->class;
 
 	pr_debug("class '%s': release.\n", class->name);
 
@@ -110,7 +110,7 @@ static void class_release(struct kobject *kobj)
 static const struct kobj_ns_type_operations *class_child_ns_type(const struct kobject *kobj)
 {
 	const struct subsys_private *cp = to_subsys_private(kobj);
-	struct class *class = cp->class;
+	const struct class *class = cp->class;
 
 	return class->ns_type;
 }
@@ -175,7 +175,7 @@ static void klist_class_dev_put(struct klist_node *n)
 	put_device(dev);
 }
 
-int class_register(struct class *cls)
+int class_register(const struct class *cls)
 {
 	struct subsys_private *cp;
 	struct lock_class_key *key;
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index f3c418fa129a..4bf46f9bbb56 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -76,7 +76,7 @@ struct class_dev_iter {
 	const struct device_type	*type;
 };
 
-int __must_check class_register(struct class *class);
+int __must_check class_register(const struct class *class);
 void class_unregister(const struct class *class);
 bool class_is_registered(const struct class *class);
 
-- 
2.40.0

