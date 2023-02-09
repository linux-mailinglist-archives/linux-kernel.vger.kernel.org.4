Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2787E6903F1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBIJgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBIJgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:36:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A77D3B0EB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:36:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9D496184B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 09:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36F2C4339B;
        Thu,  9 Feb 2023 09:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675935361;
        bh=1hAyD7M3xjKCOTtuat/cLUesEuTBD1OtwoSuOHanH/g=;
        h=From:To:Cc:Subject:Date:From;
        b=NSH4mQStk9JoFV/izsTm2bZhUpoUILdHl7Oa0ByKa5dkBW7ORUTuFr64smAFvT23+
         pgUhha7ttoEfdWQBIdveoxNOUkXrP013Xd6eOk5eJ5xllsivaFmhwMyP0/WPVXQcjF
         WJhhtLuQHhU6ICoyiL5jCqKyKZhp0XSDEGcgAGTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: bus: add bus_get_dev_root() function
Date:   Thu,  9 Feb 2023 10:35:56 +0100
Message-Id: <20230209093556.19132-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3711; i=gregkh@linuxfoundation.org; h=from:subject; bh=1hAyD7M3xjKCOTtuat/cLUesEuTBD1OtwoSuOHanH/g=; b=owGbwMvMwCRo6H6F97bub03G02pJDMlP9lWbJjB+0TTv3GJx4l/do2lGGRPu1XL6ba/5/vThfkNm a6egjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhIQBPDgpX9E9/7/L65NV7HfefFGP sDPWoPPBgWTHZQfxrt7y8rxy21NCGkYM7NH8HHAQ==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of poking around in the struct bus_type directly for the
dev_root pointer, provide a function to return it properly reference
counted, if it is present in the bus.  This will be needed to move the
pointer out of struct bus_type in the future.

Use the function in the driver core code at the same time it is
introduced to verify that it works properly.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c         | 20 ++++++++++++++++++++
 drivers/base/core.c        | 14 +++++++++++---
 drivers/base/cpu.c         | 10 +++++++---
 include/linux/device/bus.h |  1 +
 4 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 4c85d264113a..6db88965116a 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -1334,6 +1334,26 @@ bool bus_is_registered(const struct bus_type *bus)
 	return is_initialized;
 }
 
+/**
+ * bus_get_dev_root - return a pointer to the "device root" of a bus
+ * @bus: bus to return the device root of.
+ *
+ * If a bus has a "device root" structure, return it, WITH THE REFERENCE
+ * COUNT INCREMENTED.
+ *
+ * Note, when finished with the device, a call to put_device() is required.
+ *
+ * If the device root is not present (or bus is not a valid pointer), NULL
+ * will be returned.
+ */
+struct device *bus_get_dev_root(const struct bus_type *bus)
+{
+	if (bus)
+		return get_device(bus->dev_root);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(bus_get_dev_root);
+
 int __init buses_init(void)
 {
 	bus_kset = kset_create_and_add("bus", &bus_uevent_ops, NULL);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index e4b18f7ac58a..5f0933188a21 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3026,8 +3026,9 @@ static DEFINE_MUTEX(gdp_mutex);
 static struct kobject *get_device_parent(struct device *dev,
 					 struct device *parent)
 {
+	struct kobject *kobj = NULL;
+
 	if (dev->class) {
-		struct kobject *kobj = NULL;
 		struct kobject *parent_kobj;
 		struct kobject *k;
 
@@ -3075,8 +3076,15 @@ static struct kobject *get_device_parent(struct device *dev,
 	}
 
 	/* subsystems can specify a default root directory for their devices */
-	if (!parent && dev->bus && dev->bus->dev_root)
-		return &dev->bus->dev_root->kobj;
+	if (!parent && dev->bus) {
+		struct device *dev_root = bus_get_dev_root(dev->bus);
+
+		if (dev_root) {
+			kobj = &dev_root->kobj;
+			put_device(dev_root);
+			return kobj;
+		}
+	}
 
 	if (parent)
 		return &parent->kobj;
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 441eb5bdec7d..8bb623039bb2 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -610,9 +610,13 @@ static const struct attribute_group cpu_root_vulnerabilities_group = {
 
 static void __init cpu_register_vulnerabilities(void)
 {
-	if (sysfs_create_group(&cpu_subsys.dev_root->kobj,
-			       &cpu_root_vulnerabilities_group))
-		pr_err("Unable to register CPU vulnerabilities\n");
+	struct device *dev = bus_get_dev_root(&cpu_subsys);
+
+	if (dev) {
+		if (sysfs_create_group(&dev->kobj, &cpu_root_vulnerabilities_group))
+			pr_err("Unable to register CPU vulnerabilities\n");
+		put_device(dev);
+	}
 }
 
 #else
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 31be18608f83..6ce32ef4b8fd 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -282,5 +282,6 @@ enum bus_notifier_event {
 };
 
 extern struct kset *bus_get_kset(const struct bus_type *bus);
+struct device *bus_get_dev_root(const struct bus_type *bus);
 
 #endif
-- 
2.39.1

