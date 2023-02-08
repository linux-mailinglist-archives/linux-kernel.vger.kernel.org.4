Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8968ED9F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjBHLP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjBHLOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC1125287
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BFED61580
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EC7C433EF;
        Wed,  8 Feb 2023 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854872;
        bh=bOAbeWNZBH0+KrZBBH/F//OguII8S8sQl/vg+wkJb5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pWtOCJN5TKrE+KJWWXOxMeNkpCTy2uQ+fmVyYVHS/kAJN2+pDmQrDlXfSO1KX3dvM
         luwLeIaNs1ZcNRFwHmBLNdMZyXJCLHsJphQF8bBoTclX4M7mn0XlbxMVQYnJpnv2FB
         YY/f1MmbR7TkmF+1BNN9h7GbrdMeD8KtwOgCO70E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 06/21] driver core: bus: bus_add/probe/remove_device() cleanups
Date:   Wed,  8 Feb 2023 12:13:15 +0100
Message-Id: <20230208111330.439504-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4524; i=gregkh@linuxfoundation.org; h=from:subject; bh=bOAbeWNZBH0+KrZBBH/F//OguII8S8sQl/vg+wkJb5k=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm6+lT5R4/kji7gp5/di3K3Vzjn2v/Oj9iO3sP8uOROmd kW80O2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiHc8YFnQEb5kplBcbFuphv/53/7 nUG/qnmBjmWUcKmJt7PfNXdFqzIVS0TOHyX752AA==
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

Convert the bus_add_device(), bus_probe_device(), and
bus_remove_device() functions to use bus_to_subsys() and not use the
back-pointer to the private structure.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 87 ++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 33 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index f0d3ad41fd5e..f4e4efd81b29 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -466,32 +466,46 @@ EXPORT_SYMBOL_GPL(bus_for_each_drv);
  */
 int bus_add_device(struct device *dev)
 {
-	struct bus_type *bus = bus_get(dev->bus);
-	int error = 0;
+	struct subsys_private *sp = bus_to_subsys(dev->bus);
+	int error;
 
-	if (bus) {
-		pr_debug("bus: '%s': add device %s\n", bus->name, dev_name(dev));
-		error = device_add_groups(dev, bus->dev_groups);
-		if (error)
-			goto out_put;
-		error = sysfs_create_link(&bus->p->devices_kset->kobj,
-						&dev->kobj, dev_name(dev));
-		if (error)
-			goto out_groups;
-		error = sysfs_create_link(&dev->kobj,
-				&dev->bus->p->subsys.kobj, "subsystem");
-		if (error)
-			goto out_subsys;
-		klist_add_tail(&dev->p->knode_bus, &bus->p->klist_devices);
+	if (!sp) {
+		/*
+		 * This is a normal operation for many devices that do not
+		 * have a bus assigned to them, just say that all went
+		 * well.
+		 */
+		return 0;
 	}
+
+	/*
+	 * Reference in sp is now incremented and will be dropped when
+	 * the device is removed from the bus
+	 */
+
+	pr_debug("bus: '%s': add device %s\n", sp->bus->name, dev_name(dev));
+
+	error = device_add_groups(dev, sp->bus->dev_groups);
+	if (error)
+		goto out_put;
+
+	error = sysfs_create_link(&sp->devices_kset->kobj, &dev->kobj, dev_name(dev));
+	if (error)
+		goto out_groups;
+
+	error = sysfs_create_link(&dev->kobj, &sp->subsys.kobj, "subsystem");
+	if (error)
+		goto out_subsys;
+
+	klist_add_tail(&dev->p->knode_bus, &sp->klist_devices);
 	return 0;
 
 out_subsys:
-	sysfs_remove_link(&bus->p->devices_kset->kobj, dev_name(dev));
+	sysfs_remove_link(&sp->devices_kset->kobj, dev_name(dev));
 out_groups:
-	device_remove_groups(dev, bus->dev_groups);
+	device_remove_groups(dev, sp->bus->dev_groups);
 out_put:
-	bus_put(dev->bus);
+	subsys_put(sp);
 	return error;
 }
 
@@ -503,20 +517,21 @@ int bus_add_device(struct device *dev)
  */
 void bus_probe_device(struct device *dev)
 {
-	struct bus_type *bus = dev->bus;
+	struct subsys_private *sp = bus_to_subsys(dev->bus);
 	struct subsys_interface *sif;
 
-	if (!bus)
+	if (!sp)
 		return;
 
-	if (bus->p->drivers_autoprobe)
+	if (sp->drivers_autoprobe)
 		device_initial_probe(dev);
 
-	mutex_lock(&bus->p->mutex);
-	list_for_each_entry(sif, &bus->p->interfaces, node)
+	mutex_lock(&sp->mutex);
+	list_for_each_entry(sif, &sp->interfaces, node)
 		if (sif->add_dev)
 			sif->add_dev(dev, sif);
-	mutex_unlock(&bus->p->mutex);
+	mutex_unlock(&sp->mutex);
+	subsys_put(sp);
 }
 
 /**
@@ -531,21 +546,20 @@ void bus_probe_device(struct device *dev)
  */
 void bus_remove_device(struct device *dev)
 {
-	struct bus_type *bus = dev->bus;
+	struct subsys_private *sp = bus_to_subsys(dev->bus);
 	struct subsys_interface *sif;
 
-	if (!bus)
+	if (!sp)
 		return;
 
-	mutex_lock(&bus->p->mutex);
-	list_for_each_entry(sif, &bus->p->interfaces, node)
+	mutex_lock(&sp->mutex);
+	list_for_each_entry(sif, &sp->interfaces, node)
 		if (sif->remove_dev)
 			sif->remove_dev(dev, sif);
-	mutex_unlock(&bus->p->mutex);
+	mutex_unlock(&sp->mutex);
 
 	sysfs_remove_link(&dev->kobj, "subsystem");
-	sysfs_remove_link(&dev->bus->p->devices_kset->kobj,
-			  dev_name(dev));
+	sysfs_remove_link(&sp->devices_kset->kobj, dev_name(dev));
 	device_remove_groups(dev, dev->bus->dev_groups);
 	if (klist_node_attached(&dev->p->knode_bus))
 		klist_del(&dev->p->knode_bus);
@@ -553,7 +567,14 @@ void bus_remove_device(struct device *dev)
 	pr_debug("bus: '%s': remove device %s\n",
 		 dev->bus->name, dev_name(dev));
 	device_release_driver(dev);
-	bus_put(dev->bus);
+
+	/*
+	 * Decrement the reference count twice, once for the bus_to_subsys()
+	 * call in the start of this function, and the second one from the
+	 * reference increment in bus_add_device()
+	 */
+	subsys_put(sp);
+	subsys_put(sp);
 }
 
 static int __must_check add_bind_files(struct device_driver *drv)
-- 
2.39.1

