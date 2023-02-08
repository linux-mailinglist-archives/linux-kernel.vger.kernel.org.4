Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B83768ED8C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjBHLOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjBHLNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:13:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B84125B96
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:13:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06840B81D49
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350EAC433EF;
        Wed,  8 Feb 2023 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854830;
        bh=IUemhhV+uquNHc+5QTYdLPOB48ArOdw5/SdNBdVRcS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P5KEp92JhYFbCTCSKKEqaKsrvwd0ItkUCgsG/MB1yt3MeNG3SjSxDVkzvJ6eetZxb
         FQlBoVXuDmAFJsd5KjlCaDlADVC55WVs+PoGmnqsI58s1E3Yi2y3bw14eECDBK8Es1
         bINuVOr3Wjz5ZzY44tUfMsHeCzZQjApq3h3nT4Xg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 11/21] driver core: bus: bus_add/remove_driver() cleanups
Date:   Wed,  8 Feb 2023 12:13:20 +0100
Message-Id: <20230208111330.439504-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3455; i=gregkh@linuxfoundation.org; h=from:subject; bh=IUemhhV+uquNHc+5QTYdLPOB48ArOdw5/SdNBdVRcS4=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm2+8r9cK1ZscbbHp/NKus8o/Lpdfvnhh4ldv79/vK54e 37OxsiOWhUGQiUFWTJHlyzaeo/srDil6GdqehpnDygQyhIGLUwAmIlDEsGDaxW+HzBkZD0dfOyb0mP 2Wocq2OYsZ5vBFbX9R9SHk4QTTFyeV+K7PSTTrsQEA
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

Convert the bus_add_driver() and bus_remove_driver() functions to use
bus_to_subsys() and not use the back-pointer to the private structure.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index f23c6f6306e2..b594804c716d 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -636,15 +636,18 @@ static DRIVER_ATTR_WO(uevent);
  */
 int bus_add_driver(struct device_driver *drv)
 {
-	struct bus_type *bus;
+	struct subsys_private *sp = bus_to_subsys(drv->bus);
 	struct driver_private *priv;
 	int error = 0;
 
-	bus = bus_get(drv->bus);
-	if (!bus)
+	if (!sp)
 		return -EINVAL;
 
-	pr_debug("bus: '%s': add driver %s\n", bus->name, drv->name);
+	/*
+	 * Reference in sp is now incremented and will be dropped when
+	 * the driver is removed from the bus
+	 */
+	pr_debug("bus: '%s': add driver %s\n", sp->bus->name, drv->name);
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
@@ -654,14 +657,14 @@ int bus_add_driver(struct device_driver *drv)
 	klist_init(&priv->klist_devices, NULL, NULL);
 	priv->driver = drv;
 	drv->p = priv;
-	priv->kobj.kset = bus->p->drivers_kset;
+	priv->kobj.kset = sp->drivers_kset;
 	error = kobject_init_and_add(&priv->kobj, &driver_ktype, NULL,
 				     "%s", drv->name);
 	if (error)
 		goto out_unregister;
 
-	klist_add_tail(&priv->knode_bus, &bus->p->klist_drivers);
-	if (drv->bus->p->drivers_autoprobe) {
+	klist_add_tail(&priv->knode_bus, &sp->klist_drivers);
+	if (sp->drivers_autoprobe) {
 		error = driver_attach(drv);
 		if (error)
 			goto out_del_list;
@@ -673,7 +676,7 @@ int bus_add_driver(struct device_driver *drv)
 		printk(KERN_ERR "%s: uevent attr (%s) failed\n",
 			__func__, drv->name);
 	}
-	error = driver_add_groups(drv, bus->drv_groups);
+	error = driver_add_groups(drv, sp->bus->drv_groups);
 	if (error) {
 		/* How the hell do we get out of this pickle? Give up */
 		printk(KERN_ERR "%s: driver_add_groups(%s) failed\n",
@@ -698,7 +701,7 @@ int bus_add_driver(struct device_driver *drv)
 	/* drv->p is freed in driver_release()  */
 	drv->p = NULL;
 out_put_bus:
-	bus_put(bus);
+	subsys_put(sp);
 	return error;
 }
 
@@ -712,19 +715,29 @@ int bus_add_driver(struct device_driver *drv)
  */
 void bus_remove_driver(struct device_driver *drv)
 {
-	if (!drv->bus)
+	struct subsys_private *sp = bus_to_subsys(drv->bus);
+
+	if (!sp)
 		return;
 
+	pr_debug("bus: '%s': remove driver %s\n", sp->bus->name, drv->name);
+
 	if (!drv->suppress_bind_attrs)
 		remove_bind_files(drv);
-	driver_remove_groups(drv, drv->bus->drv_groups);
+	driver_remove_groups(drv, sp->bus->drv_groups);
 	driver_remove_file(drv, &driver_attr_uevent);
 	klist_remove(&drv->p->knode_bus);
-	pr_debug("bus: '%s': remove driver %s\n", drv->bus->name, drv->name);
 	driver_detach(drv);
 	module_remove_driver(drv);
 	kobject_put(&drv->p->kobj);
-	bus_put(drv->bus);
+
+	/*
+	 * Decrement the reference count twice, once for the bus_to_subsys()
+	 * call in the start of this function, and the second one from the
+	 * reference increment in bus_add_driver()
+	 */
+	subsys_put(sp);
+	subsys_put(sp);
 }
 
 /* Helper for bus_rescan_devices's iter */
-- 
2.39.1

