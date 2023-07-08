Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C483474BD59
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 13:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjGHL1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGHL1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 07:27:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3226F1997
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 04:27:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1qI662-0002LD-TC; Sat, 08 Jul 2023 13:27:26 +0200
Received: from [2a0a:edc0:0:1101:1d::54] (helo=dude05.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <afa@pengutronix.de>)
        id 1qI662-00CwkH-7G; Sat, 08 Jul 2023 13:27:26 +0200
Received: from afa by dude05.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <afa@pengutronix.de>)
        id 1qI662-00C9mA-0N;
        Sat, 08 Jul 2023 13:27:26 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thermal: core: constify params in thermal_zone_device_register
Date:   Sat,  8 Jul 2023 13:27:19 +0200
Message-Id: <20230708112720.2897484-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

Since commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone
parameters structure"), thermal_zone_device_register() allocates a copy
of the tzp argument and callers need not explicitly manage its lifetime.

This means the function no longer cares about the parameter being
mutable, so constify it.

No functional change.

Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 drivers/thermal/thermal_core.c | 4 ++--
 include/linux/thermal.h        | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 842f678c1c3e..cc2b5e81c620 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1203,7 +1203,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
 struct thermal_zone_device *
 thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int num_trips, int mask,
 					void *devdata, struct thermal_zone_device_ops *ops,
-					struct thermal_zone_params *tzp, int passive_delay,
+					const struct thermal_zone_params *tzp, int passive_delay,
 					int polling_delay)
 {
 	struct thermal_zone_device *tz;
@@ -1371,7 +1371,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
 
 struct thermal_zone_device *thermal_zone_device_register(const char *type, int ntrips, int mask,
 							 void *devdata, struct thermal_zone_device_ops *ops,
-							 struct thermal_zone_params *tzp, int passive_delay,
+							 const struct thermal_zone_params *tzp, int passive_delay,
 							 int polling_delay)
 {
 	return thermal_zone_device_register_with_trips(type, NULL, ntrips, mask,
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 87837094d549..dee66ade89a0 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -301,14 +301,14 @@ int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
 #ifdef CONFIG_THERMAL
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, struct thermal_zone_device_ops *,
-		struct thermal_zone_params *, int, int);
+		const struct thermal_zone_params *, int, int);
 
 void thermal_zone_device_unregister(struct thermal_zone_device *);
 
 struct thermal_zone_device *
 thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int, int,
 					void *, struct thermal_zone_device_ops *,
-					struct thermal_zone_params *, int, int);
+					const struct thermal_zone_params *, int, int);
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
 const char *thermal_zone_device_type(struct thermal_zone_device *tzd);
@@ -348,7 +348,7 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz);
 static inline struct thermal_zone_device *thermal_zone_device_register(
 	const char *type, int trips, int mask, void *devdata,
 	struct thermal_zone_device_ops *ops,
-	struct thermal_zone_params *tzp,
+	const struct thermal_zone_params *tzp,
 	int passive_delay, int polling_delay)
 { return ERR_PTR(-ENODEV); }
 static inline void thermal_zone_device_unregister(
-- 
2.39.2

