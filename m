Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E73168ED9D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjBHLP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjBHLOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB49529168
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E4A8ACE200A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE356C433D2;
        Wed,  8 Feb 2023 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854875;
        bh=kLYTpgwUgcqgAgROchb8ltF/FmX41QTpwY3/jau5krQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1hAZ8gYWnvg3WuhCq7o9zUMxxfqs1hGvBeisnhg444N7iYx0YwhtfskY2oUY4xp2
         tt6Ldw1bVmk7EloGP+RwdB4wQmUssCqIDt+IB0ja32FSvmkoc6vV0YeEDIpPBYjLgV
         l4PieKCsVz5xSYWQ9l+coKlMgeJQ1z70jOB/fomQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 07/21] driver core: bus: bus_register/unregister() cleanups
Date:   Wed,  8 Feb 2023 12:13:16 +0100
Message-Id: <20230208111330.439504-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4343; i=gregkh@linuxfoundation.org; h=from:subject; bh=kLYTpgwUgcqgAgROchb8ltF/FmX41QTpwY3/jau5krQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm68vOM23MNcqs6Jtf+fb1pC6hOubTpY8WZIzaxvvlTlJ k+0PdsSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEuNYxLOj/KjSF97nbO/85Ovcurl z1/sNuuQaGBTvWyG9ROWmXw27odjhypyHbjR+v/gAA
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

Convert the bus_register() and bus_unregister() functions to use
bus_to_subsys() and not use the back-pointer to the private structure.

Because bus_add_groups() and bus_remove_groups() were only called in one
place, remove those one-line-wrapper functions and call the real sysfs
group function where it is needed instead, saving another layer of
indirection.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c | 54 ++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index f4e4efd81b29..549e55dfbfda 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -774,18 +774,6 @@ int device_reprobe(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_reprobe);
 
-static int bus_add_groups(struct bus_type *bus,
-			  const struct attribute_group **groups)
-{
-	return sysfs_create_groups(&bus->p->subsys.kobj, groups);
-}
-
-static void bus_remove_groups(struct bus_type *bus,
-			      const struct attribute_group **groups)
-{
-	sysfs_remove_groups(&bus->p->subsys.kobj, groups);
-}
-
 static void klist_devices_get(struct klist_node *n)
 {
 	struct device_private *dev_prv = to_device_private_bus(n);
@@ -839,6 +827,7 @@ int bus_register(struct bus_type *bus)
 {
 	int retval;
 	struct subsys_private *priv;
+	struct kobject *bus_kobj;
 	struct lock_class_key *key;
 
 	priv = kzalloc(sizeof(struct subsys_private), GFP_KERNEL);
@@ -850,12 +839,13 @@ int bus_register(struct bus_type *bus)
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&priv->bus_notifier);
 
-	retval = kobject_set_name(&priv->subsys.kobj, "%s", bus->name);
+	bus_kobj = &priv->subsys.kobj;
+	retval = kobject_set_name(bus_kobj, "%s", bus->name);
 	if (retval)
 		goto out;
 
-	priv->subsys.kobj.kset = bus_kset;
-	priv->subsys.kobj.ktype = &bus_ktype;
+	bus_kobj->kset = bus_kset;
+	bus_kobj->ktype = &bus_ktype;
 	priv->drivers_autoprobe = 1;
 
 	retval = kset_register(&priv->subsys);
@@ -866,15 +856,13 @@ int bus_register(struct bus_type *bus)
 	if (retval)
 		goto bus_uevent_fail;
 
-	priv->devices_kset = kset_create_and_add("devices", NULL,
-						 &priv->subsys.kobj);
+	priv->devices_kset = kset_create_and_add("devices", NULL, bus_kobj);
 	if (!priv->devices_kset) {
 		retval = -ENOMEM;
 		goto bus_devices_fail;
 	}
 
-	priv->drivers_kset = kset_create_and_add("drivers", NULL,
-						 &priv->subsys.kobj);
+	priv->drivers_kset = kset_create_and_add("drivers", NULL, bus_kobj);
 	if (!priv->drivers_kset) {
 		retval = -ENOMEM;
 		goto bus_drivers_fail;
@@ -891,7 +879,7 @@ int bus_register(struct bus_type *bus)
 	if (retval)
 		goto bus_probe_files_fail;
 
-	retval = bus_add_groups(bus, bus->bus_groups);
+	retval = sysfs_create_groups(bus_kobj, bus->bus_groups);
 	if (retval)
 		goto bus_groups_fail;
 
@@ -901,15 +889,15 @@ int bus_register(struct bus_type *bus)
 bus_groups_fail:
 	remove_probe_files(bus);
 bus_probe_files_fail:
-	kset_unregister(bus->p->drivers_kset);
+	kset_unregister(priv->drivers_kset);
 bus_drivers_fail:
-	kset_unregister(bus->p->devices_kset);
+	kset_unregister(priv->devices_kset);
 bus_devices_fail:
 	bus_remove_file(bus, &bus_attr_uevent);
 bus_uevent_fail:
-	kset_unregister(&bus->p->subsys);
+	kset_unregister(&priv->subsys);
 out:
-	kfree(bus->p);
+	kfree(priv);
 	bus->p = NULL;
 	return retval;
 }
@@ -924,15 +912,25 @@ EXPORT_SYMBOL_GPL(bus_register);
  */
 void bus_unregister(struct bus_type *bus)
 {
+	struct subsys_private *sp = bus_to_subsys(bus);
+	struct kobject *bus_kobj;
+
+	if (!sp)
+		return;
+
 	pr_debug("bus: '%s': unregistering\n", bus->name);
 	if (bus->dev_root)
 		device_unregister(bus->dev_root);
-	bus_remove_groups(bus, bus->bus_groups);
+
+	bus_kobj = &sp->subsys.kobj;
+	sysfs_remove_groups(bus_kobj, bus->bus_groups);
 	remove_probe_files(bus);
-	kset_unregister(bus->p->drivers_kset);
-	kset_unregister(bus->p->devices_kset);
 	bus_remove_file(bus, &bus_attr_uevent);
-	kset_unregister(&bus->p->subsys);
+
+	kset_unregister(sp->drivers_kset);
+	kset_unregister(sp->devices_kset);
+	kset_unregister(&sp->subsys);
+	subsys_put(sp);
 }
 EXPORT_SYMBOL_GPL(bus_unregister);
 
-- 
2.39.1

