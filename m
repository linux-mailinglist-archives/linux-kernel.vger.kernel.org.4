Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7897168ED98
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjBHLOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjBHLOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:14:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455F1241C2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:14:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 024B3B81C6E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732E0C433D2;
        Wed,  8 Feb 2023 11:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675854845;
        bh=SwonsbMVauLlz2Qfx4QMXpUrMImp4HMvT+4bbVQGeDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ioFPoAW9tbBA31mPYsKrBpxey8vWpIFNivXce4IM5wU1xj51peaSlX5+XGLAJNff
         UBCLqcA5ijy4EyEZVKMq1Ekdf4mkRWW8fUgakP5LfmfUX9X9KEVtxJfawpFDtreX78
         6c+jopLHqptxHRod1OzXXY4a+HKlOdksTu73aAPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 16/21] driver core: create bus_is_registered()
Date:   Wed,  8 Feb 2023 12:13:25 +0100
Message-Id: <20230208111330.439504-17-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208111330.439504-1-gregkh@linuxfoundation.org>
References: <20230208111330.439504-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2405; i=gregkh@linuxfoundation.org; h=from:subject; bh=SwonsbMVauLlz2Qfx4QMXpUrMImp4HMvT+4bbVQGeDc=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmPm2+eO32Lh0Hjytdl/6fwXO/J9NrKVRBxk6kxZer9n9ej 5myp64hlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJrFrGsKDbeYNA2KTee6pvJuzbfm q5UfKbxKcMcwXdBV8mh/Npqq5uv3X7NPvtzP/regA=
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

A local function to the driver core to determine if a bus really is
registered with the kernel or not.  To be used only by the driver core
code, as part of the driver registration path as it's not really "safe"
because the bus could be unregistered instantly after being called.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h   |  1 +
 drivers/base/bus.c    | 16 ++++++++++++++++
 drivers/base/driver.c |  2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 9e06c18c7a64..726a12a244c0 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -146,6 +146,7 @@ extern int bus_add_device(struct device *dev);
 extern void bus_probe_device(struct device *dev);
 extern void bus_remove_device(struct device *dev);
 void bus_notify(struct device *dev, enum bus_notifier_event value);
+bool bus_is_registered(const struct bus_type *bus);
 
 extern int bus_add_driver(struct device_driver *drv);
 extern void bus_remove_driver(struct device_driver *drv);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 951d63c8e885..481fb3f41a42 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -1322,6 +1322,22 @@ struct device_driver *driver_find(const char *name, struct bus_type *bus)
 }
 EXPORT_SYMBOL_GPL(driver_find);
 
+/*
+ * Warning, the value could go to "removed" instantly after calling this function, so be very
+ * careful when calling it...
+ */
+bool bus_is_registered(const struct bus_type *bus)
+{
+	struct subsys_private *sp = bus_to_subsys(bus);
+	bool is_initialized = false;
+
+	if (sp) {
+		is_initialized = true;
+		subsys_put(sp);
+	}
+	return is_initialized;
+}
+
 int __init buses_init(void)
 {
 	bus_kset = kset_create_and_add("bus", &bus_uevent_ops, NULL);
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index aa5e5166a671..c8436c26ed6a 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -224,7 +224,7 @@ int driver_register(struct device_driver *drv)
 	int ret;
 	struct device_driver *other;
 
-	if (!drv->bus->p) {
+	if (!bus_is_registered(drv->bus)) {
 		pr_err("Driver '%s' was unable to register with bus_type '%s' because the bus was not initialized.\n",
 			   drv->name, drv->bus->name);
 		return -EINVAL;
-- 
2.39.1

