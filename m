Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC4868ED93
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBHLOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBHLOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688AE241C2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FEA7B81BA8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FBEC433D2;
        Wed,  8 Feb 2023 11:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854839;
        bh=rwIGY1WYkAlAsKJ0FGrYBjNgl4bfna2Pv/jSrRTDqWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNvW8xAx+3A0fmXyJnO3GaUva2pjH6o9Nl5pKbiZTZfRdss+dHAMno+pXAeBGPWpi
         xAa8r14FT75p629t3rl6JTi6Qb+MwpGlntZqszJIenVwDPxBBhyxbqNSomyogBOJSY
         US8Vlux4ghXJHfY+8K1/TYq7MYE7wrYu6YjKC5xc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 14/21] driver core: move driver_find() to bus.c
Date:   Wed,  8 Feb 2023 12:13:23 +0100
Message-Id: <20230208111330.439504-15-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2801; i=gregkh@linuxfoundation.org; h=from:subject; bh=rwIGY1WYkAlAsKJ0FGrYBjNgl4bfna2Pv/jSrRTDqWA=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm28UVOjn3z6lGJ8nLv391RV2oz86TFVeH3KMNr+vMxL9 EjizI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACbyZBLDgr5ymTtvJjR6WnRJhy0/GM fxaWXyOoZ5Rqt3OdxZ9V5f4RQD266QdIOG7657AQ==
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

This function really is a bus function, not a driver one, so move it
from driver.c to bus.c so that we can clean up some internal bus logic
easier.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c    | 27 +++++++++++++++++++++++++++
 drivers/base/driver.c | 27 ---------------------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 87e21aafe6e6..727de4c36d59 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -1288,6 +1288,33 @@ int subsys_virtual_register(struct bus_type *subsys,
 }
 EXPORT_SYMBOL_GPL(subsys_virtual_register);
 
+/**
+ * driver_find - locate driver on a bus by its name.
+ * @name: name of the driver.
+ * @bus: bus to scan for the driver.
+ *
+ * Call kset_find_obj() to iterate over list of drivers on
+ * a bus to find driver by name. Return driver if found.
+ *
+ * This routine provides no locking to prevent the driver it returns
+ * from being unregistered or unloaded while the caller is using it.
+ * The caller is responsible for preventing this.
+ */
+struct device_driver *driver_find(const char *name, struct bus_type *bus)
+{
+	struct kobject *k = kset_find_obj(bus->p->drivers_kset, name);
+	struct driver_private *priv;
+
+	if (k) {
+		/* Drop reference added by kset_find_obj() */
+		kobject_put(k);
+		priv = to_driver(k);
+		return priv->driver;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(driver_find);
+
 int __init buses_init(void)
 {
 	bus_kset = kset_create_and_add("bus", &bus_uevent_ops, NULL);
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 676b6275d5b5..aa5e5166a671 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -274,30 +274,3 @@ void driver_unregister(struct device_driver *drv)
 	bus_remove_driver(drv);
 }
 EXPORT_SYMBOL_GPL(driver_unregister);
-
-/**
- * driver_find - locate driver on a bus by its name.
- * @name: name of the driver.
- * @bus: bus to scan for the driver.
- *
- * Call kset_find_obj() to iterate over list of drivers on
- * a bus to find driver by name. Return driver if found.
- *
- * This routine provides no locking to prevent the driver it returns
- * from being unregistered or unloaded while the caller is using it.
- * The caller is responsible for preventing this.
- */
-struct device_driver *driver_find(const char *name, struct bus_type *bus)
-{
-	struct kobject *k = kset_find_obj(bus->p->drivers_kset, name);
-	struct driver_private *priv;
-
-	if (k) {
-		/* Drop reference added by kset_find_obj() */
-		kobject_put(k);
-		priv = to_driver(k);
-		return priv->driver;
-	}
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(driver_find);
-- 
2.39.1

