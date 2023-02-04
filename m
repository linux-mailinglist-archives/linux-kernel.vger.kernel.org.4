Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F3668ACEB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 23:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjBDWhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 17:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBDWhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 17:37:08 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793A876AB;
        Sat,  4 Feb 2023 14:37:07 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675550225;
        bh=0XwHzWlQO9utV3c23HfF5d3lVc1tHK1hks1/3/+GhYo=;
        h=From:Date:Subject:To:Cc:From;
        b=STejYmVfI53D9/kq/WcaYju5UGgGXs1jDerfpfCF40EI9t084D2ECHECqGa7scSIC
         dGTa7tZ8MzOAygjvy3V57NHU5fQtDAIeWQZtrGHp/8maox9qGPsgINhU4zcvi2lhwr
         8VTiK6sk75/FYJ0AyKgUk3uEUWcFC4a+hpFCFGk4=
Date:   Sat, 04 Feb 2023 22:36:58 +0000
Subject: [PATCH] driver core: make kobj_type structures constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230204-kobj_type-driver-core-v1-1-b9f809419f2c@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAne3mMC/x2N0QrCMAwAf2Xk2UCt1Qd/RUSaNnPR0Y50DmXs3
 xd8vIPjVmiswg2u3QrKizSpxeB46CANsTwZJRuDd/7kvAv4rvR6zL+JMassrJiqMl4oEOfgfDw
 TWEuxMZLGkgary2ccTU7KvXz/s9t923Y4idgTfAAAAA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675550218; l=3049;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0XwHzWlQO9utV3c23HfF5d3lVc1tHK1hks1/3/+GhYo=;
 b=xFPR+hJqKZFs5DaJ7n/jPy5Kdyj0cLcKjN2d72v7FvIeoM5SMD0gRQe1mKcUus5/vflKq/N+N
 m6BwWG7M+3KCJJa/Cha9fxeEq8EP3KAi18o18k2u6r5+2Z3u57x1EK7
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definitions to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/base/bus.c    | 4 ++--
 drivers/base/class.c  | 2 +-
 drivers/base/core.c   | 4 ++--
 drivers/base/swnode.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 4ec6dbab73be..f9c05f4c7d1f 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -91,7 +91,7 @@ static void driver_release(struct kobject *kobj)
 	kfree(drv_priv);
 }
 
-static struct kobj_type driver_ktype = {
+static const struct kobj_type driver_ktype = {
 	.sysfs_ops	= &driver_sysfs_ops,
 	.release	= driver_release,
 };
@@ -158,7 +158,7 @@ static void bus_release(struct kobject *kobj)
 	bus->p = NULL;
 }
 
-static struct kobj_type bus_ktype = {
+static const struct kobj_type bus_ktype = {
 	.sysfs_ops	= &bus_sysfs_ops,
 	.release	= bus_release,
 };
diff --git a/drivers/base/class.c b/drivers/base/class.c
index 86ec554cfe60..3a0e8cf8970c 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -75,7 +75,7 @@ static const struct sysfs_ops class_sysfs_ops = {
 	.store	   = class_attr_store,
 };
 
-static struct kobj_type class_ktype = {
+static const struct kobj_type class_ktype = {
 	.sysfs_ops	= &class_sysfs_ops,
 	.release	= class_release,
 	.child_ns_type	= class_child_ns_type,
diff --git a/drivers/base/core.c b/drivers/base/core.c
index a3e14143ec0c..dd17852f1c03 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2354,7 +2354,7 @@ static void device_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t
 		dev->class->get_ownership(dev, uid, gid);
 }
 
-static struct kobj_type device_ktype = {
+static const struct kobj_type device_ktype = {
 	.release	= device_release,
 	.sysfs_ops	= &dev_sysfs_ops,
 	.namespace	= device_namespace,
@@ -2992,7 +2992,7 @@ struct kobj_ns_type_operations *class_dir_child_ns_type(const struct kobject *ko
 	return dir->class->ns_type;
 }
 
-static struct kobj_type class_dir_ktype = {
+static const struct kobj_type class_dir_ktype = {
 	.release	= class_dir_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
 	.child_ns_type	= class_dir_child_ns_type
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 0a482212c7e8..81fb6d492c15 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -760,7 +760,7 @@ static void software_node_release(struct kobject *kobj)
 	kfree(swnode);
 }
 
-static struct kobj_type software_node_type = {
+static const struct kobj_type software_node_type = {
 	.release = software_node_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 };

---
base-commit: 95078069c1e70d1b3b141132d18d0c563acedd0c
change-id: 20230204-kobj_type-driver-core-6b4bed402a5b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

