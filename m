Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147E26640B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbjAJMnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjAJMnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:43:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE778431B5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:43:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7684B815D7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B71C433D2;
        Tue, 10 Jan 2023 12:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673354586;
        bh=76mL1CWsSpBh9hXbk2sZALSlSYHpUUdAK13lAYNsT9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VyfVLsar1ATpt+kA3YuRSnuZyg1BoRxpMvOTGLVKxsFsAv3t45+T/rgze4mmR3qCp
         QOWGT1KoxCZ0gPfK8cz/eYSrL0GTUqud9pdfLD2fiOxJlO2PdHhnwKIZpcW0lGyCWx
         4opBe3Iifz4MTM+eB4nvKR4PjakwuS7saxLmwrS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/2] driver core: bus: move bus notifier logic into bus.c
Date:   Tue, 10 Jan 2023 13:42:56 +0100
Message-Id: <20230110124256.1663859-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110124256.1663859-1-gregkh@linuxfoundation.org>
References: <20230110124256.1663859-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5512; i=gregkh@linuxfoundation.org; h=from:subject; bh=76mL1CWsSpBh9hXbk2sZALSlSYHpUUdAK13lAYNsT9Y=; b=owGbwMvMwCRo6H6F97bub03G02pJDMl7YwPeBc/ZW+Gmwuog/7F/cjy/oe8zvn06P5M0WbYsu7Lo sJtJRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEwkpJhhflZklMbd7S7su59uetKUVv BKXK75HMM8Mx6ue9xmNjdmzRdb//DRja7u5muHAA==
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

The logic to touch the bus notifier was open-coded in numberous places
in the driver core.  Clean that up by creating a local bus_notify()
function and have everyone call this function instead, making the
reading of the caller code simpler and easier to maintain over time.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h |  1 +
 drivers/base/bus.c  |  8 ++++++++
 drivers/base/core.c | 13 +++----------
 drivers/base/dd.c   | 28 +++++++---------------------
 4 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 7d4803c03d3e..2e08258ce82e 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -130,6 +130,7 @@ struct kobject *virtual_device_parent(struct device *dev);
 extern int bus_add_device(struct device *dev);
 extern void bus_probe_device(struct device *dev);
 extern void bus_remove_device(struct device *dev);
+void bus_notify(struct device *dev, enum bus_notifier_event value);
 
 extern int bus_add_driver(struct device_driver *drv);
 extern void bus_remove_driver(struct device_driver *drv);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 428c26c6b615..cf1b8f00b4c0 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -850,6 +850,14 @@ int bus_unregister_notifier(struct bus_type *bus, struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(bus_unregister_notifier);
 
+void bus_notify(struct device *dev, enum bus_notifier_event value)
+{
+	struct bus_type *bus = dev->bus;
+
+	if (bus)
+		blocking_notifier_call_chain(&bus->p->bus_notifier, value, dev);
+}
+
 struct kset *bus_get_kset(struct bus_type *bus)
 {
 	return &bus->p->subsys;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index a3e14143ec0c..af6a2761b31d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3453,10 +3453,7 @@ int device_add(struct device *dev)
 	/* Notify clients of device addition.  This call must come
 	 * after dpm_sysfs_add() and before kobject_uevent().
 	 */
-	if (dev->bus)
-		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
-					     BUS_NOTIFY_ADD_DEVICE, dev);
-
+	bus_notify(dev, BUS_NOTIFY_ADD_DEVICE);
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
 
 	/*
@@ -3636,9 +3633,7 @@ void device_del(struct device *dev)
 	 * before dpm_sysfs_remove().
 	 */
 	noio_flag = memalloc_noio_save();
-	if (dev->bus)
-		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
-					     BUS_NOTIFY_DEL_DEVICE, dev);
+	bus_notify(dev, BUS_NOTIFY_DEL_DEVICE);
 
 	dpm_sysfs_remove(dev);
 	if (parent)
@@ -3669,9 +3664,7 @@ void device_del(struct device *dev)
 	device_platform_notify_remove(dev);
 	device_links_purge(dev);
 
-	if (dev->bus)
-		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
-					     BUS_NOTIFY_REMOVED_DEVICE, dev);
+	bus_notify(dev, BUS_NOTIFY_REMOVED_DEVICE);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	glue_dir = get_glue_dir(dev);
 	kobject_del(&dev->kobj);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index e9b2f9c25efe..a519eaf1990c 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -413,10 +413,7 @@ static void driver_bound(struct device *dev)
 	driver_deferred_probe_del(dev);
 	driver_deferred_probe_trigger();
 
-	if (dev->bus)
-		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
-					     BUS_NOTIFY_BOUND_DRIVER, dev);
-
+	bus_notify(dev, BUS_NOTIFY_BOUND_DRIVER);
 	kobject_uevent(&dev->kobj, KOBJ_BIND);
 }
 
@@ -435,9 +432,7 @@ static int driver_sysfs_add(struct device *dev)
 {
 	int ret;
 
-	if (dev->bus)
-		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
-					     BUS_NOTIFY_BIND_DRIVER, dev);
+	bus_notify(dev, BUS_NOTIFY_BIND_DRIVER);
 
 	ret = sysfs_create_link(&dev->driver->p->kobj, &dev->kobj,
 				kobject_name(&dev->kobj));
@@ -502,9 +497,8 @@ int device_bind_driver(struct device *dev)
 		device_links_force_bind(dev);
 		driver_bound(dev);
 	}
-	else if (dev->bus)
-		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
-					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
+	else
+		bus_notify(dev, BUS_NOTIFY_DRIVER_NOT_BOUND);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(device_bind_driver);
@@ -695,9 +689,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 probe_failed:
 	driver_sysfs_remove(dev);
 sysfs_failed:
-	if (dev->bus)
-		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
-					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
+	bus_notify(dev, BUS_NOTIFY_DRIVER_NOT_BOUND);
 	if (dev->bus && dev->bus->dma_cleanup)
 		dev->bus->dma_cleanup(dev);
 pinctrl_bind_failed:
@@ -1243,10 +1235,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 		driver_sysfs_remove(dev);
 
-		if (dev->bus)
-			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
-						     BUS_NOTIFY_UNBIND_DRIVER,
-						     dev);
+		bus_notify(dev, BUS_NOTIFY_UNBIND_DRIVER);
 
 		pm_runtime_put_sync(dev);
 
@@ -1260,11 +1249,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 		klist_remove(&dev->p->knode_driver);
 		device_pm_check_callbacks(dev);
-		if (dev->bus)
-			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
-						     BUS_NOTIFY_UNBOUND_DRIVER,
-						     dev);
 
+		bus_notify(dev, BUS_NOTIFY_UNBOUND_DRIVER);
 		kobject_uevent(&dev->kobj, KOBJ_UNBIND);
 	}
 }
-- 
2.39.0

