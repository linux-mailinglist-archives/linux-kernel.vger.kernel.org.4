Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AE574BD5C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 13:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGHL2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 07:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGHL2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 07:28:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02981997
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 04:28:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1qI66T-0002PN-BZ; Sat, 08 Jul 2023 13:27:53 +0200
Received: from [2a0a:edc0:0:1101:1d::54] (helo=dude05.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1qI66S-00CwkO-Lz; Sat, 08 Jul 2023 13:27:52 +0200
Received: from afa by dude05.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <afa@pengutronix.de>)
        id 1qI66S-00C9mn-07;
        Sat, 08 Jul 2023 13:27:52 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] thermal: of: fix double-free on unregistration
Date:   Sat,  8 Jul 2023 13:27:20 +0200
Message-Id: <20230708112720.2897484-2-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230708112720.2897484-1-a.fatoum@pengutronix.de>
References: <20230708112720.2897484-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal
zone parameters structure"), thermal_zone_device_register() allocates
a copy of the tzp argument and frees it when unregistering, so
thermal_of_zone_register() now ends up leaking its original tzp and
double-freeing the tzp copy. Fix this by locating tzp on stack instead.

Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/thermal/thermal_of.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 6fb14e521197..bc07ae1c284c 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -238,17 +238,13 @@ static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdel
 	return 0;
 }
 
-static struct thermal_zone_params *thermal_of_parameters_init(struct device_node *np)
+static void thermal_of_parameters_init(struct device_node *np,
+				       struct thermal_zone_params *tzp)
 {
-	struct thermal_zone_params *tzp;
 	int coef[2];
 	int ncoef = ARRAY_SIZE(coef);
 	int prop, ret;
 
-	tzp = kzalloc(sizeof(*tzp), GFP_KERNEL);
-	if (!tzp)
-		return ERR_PTR(-ENOMEM);
-
 	tzp->no_hwmon = true;
 
 	if (!of_property_read_u32(np, "sustainable-power", &prop))
@@ -267,8 +263,6 @@ static struct thermal_zone_params *thermal_of_parameters_init(struct device_node
 
 	tzp->slope = coef[0];
 	tzp->offset = coef[1];
-
-	return tzp;
 }
 
 static struct device_node *thermal_of_zone_get_by_name(struct thermal_zone_device *tz)
@@ -442,13 +436,11 @@ static int thermal_of_unbind(struct thermal_zone_device *tz,
 static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 {
 	struct thermal_trip *trips = tz->trips;
-	struct thermal_zone_params *tzp = tz->tzp;
 	struct thermal_zone_device_ops *ops = tz->ops;
 
 	thermal_zone_device_disable(tz);
 	thermal_zone_device_unregister(tz);
 	kfree(trips);
-	kfree(tzp);
 	kfree(ops);
 }
 
@@ -477,7 +469,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 {
 	struct thermal_zone_device *tz;
 	struct thermal_trip *trips;
-	struct thermal_zone_params *tzp;
+	struct thermal_zone_params tzp = {};
 	struct thermal_zone_device_ops *of_ops;
 	struct device_node *np;
 	int delay, pdelay;
@@ -509,12 +501,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		goto out_kfree_trips;
 	}
 
-	tzp = thermal_of_parameters_init(np);
-	if (IS_ERR(tzp)) {
-		ret = PTR_ERR(tzp);
-		pr_err("Failed to initialize parameter from %pOFn: %d\n", np, ret);
-		goto out_kfree_trips;
-	}
+	thermal_of_parameters_init(np, &tzp);
 
 	of_ops->bind = thermal_of_bind;
 	of_ops->unbind = thermal_of_unbind;
@@ -522,12 +509,12 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	mask = GENMASK_ULL((ntrips) - 1, 0);
 
 	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
-						     mask, data, of_ops, tzp,
+						     mask, data, of_ops, &tzp,
 						     pdelay, delay);
 	if (IS_ERR(tz)) {
 		ret = PTR_ERR(tz);
 		pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
-		goto out_kfree_tzp;
+		goto out_kfree_trips;
 	}
 
 	ret = thermal_zone_device_enable(tz);
@@ -540,8 +527,6 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 
 	return tz;
 
-out_kfree_tzp:
-	kfree(tzp);
 out_kfree_trips:
 	kfree(trips);
 out_kfree_of_ops:
-- 
2.39.2

