Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E906B6765F3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjAULTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAULS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:18:58 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE2586B8;
        Sat, 21 Jan 2023 03:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sjnfNZ8hw7XnaikIzmFyW/hjvInLUHEoDAKXX/TVuFo=; b=F+bqWmEc3NoVkh3NFbmuce/5KI
        WBSwstOFaLP6LUqEqd8XwM7AaHtQCN/CcXZW4+PFRLpPpJOaziMQXVZKs7QvoB+G7+TBxE5QYuRzg
        j15L5ZmDIGwMAAanVjVOy/RsRqaCya7Br3cmeizeVSbxnkA1KqNt8QFkoAq6BNFAg9DUwXQ/wNT4C
        P2V2Q+DYz15K7CJRAzCp+I2f4e74Xht4lH9lgO9aGeNpDRDOQXbi0dKCMD5bInRxEYbNxQu6RPuHM
        BzZ7VdXtEKBJTzXo+sCNlzNy8BI51ibAiP8auKmP9U8JFgKuayX8drTYZ6xsaDUtwLuWgVx84ZZMq
        wdYdnI2Q==;
Received: from p200300ccff2fb4001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2f:b400:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pJBtQ-00083d-UD; Sat, 21 Jan 2023 12:18:41 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pJBtQ-00Bq2M-Au; Sat, 21 Jan 2023 12:18:40 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     sre@kernel.org, error27@gmail.com, rafael.j.wysocki@intel.com,
        anton.vorontsov@linaro.org, ramakrishna.pallala@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hns@goldelico.com
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] power: supply: disable faulty cooling logic
Date:   Sat, 21 Jan 2023 12:16:21 +0100
Message-Id: <20230121111621.2821558-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rn5t618 power driver fails to register
a cooling device because POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX
is missing but availability is not checked before registering
cooling device. After improved error checking in the thermal
code, the registration of the power supply fails entirely.

Checking for availability of _MAX before registering cooling device
fixes the rn5t618 problem. But the whole logic feels questionable.

First, the logic is inverted here:
the code tells: max_current = max_cooling but
0 = max_cooling, so there needs to be some inversion
in the code which cannot be found. Comparing with other
cooling devices, it can be found that value for fan speed is not
inverted, value for cpufreq cooling is inverted (similar situation
as here lowest frequency = max cooling)

Second, analyzing usage of _MAX: it is seems that maximum capabilities
of charging controller are specified and not of the battery. Probably
there is not too much mismatch in the drivers actually implementing
that. So nothing has exploded yet.  So there is no easy and safe way
to specifify a max cooling value now.

Conclusion for now (as a regression fix) just remove the cooling device
registration and do it properly later on.

Fixes: e49a1e1ee078 ("thermal/core: fix error code in __thermal_cooling_device_register()")
Fixes: 952aeeb3ee28 ("power_supply: Register power supply for thermal cooling device")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/power/supply/power_supply_core.c | 93 ------------------------
 1 file changed, 93 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 7c790c41e2fe..cc5b2e22b42a 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1186,83 +1186,6 @@ static void psy_unregister_thermal(struct power_supply *psy)
 	thermal_zone_device_unregister(psy->tzd);
 }
 
-/* thermal cooling device callbacks */
-static int ps_get_max_charge_cntl_limit(struct thermal_cooling_device *tcd,
-					unsigned long *state)
-{
-	struct power_supply *psy;
-	union power_supply_propval val;
-	int ret;
-
-	psy = tcd->devdata;
-	ret = power_supply_get_property(psy,
-			POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX, &val);
-	if (ret)
-		return ret;
-
-	*state = val.intval;
-
-	return ret;
-}
-
-static int ps_get_cur_charge_cntl_limit(struct thermal_cooling_device *tcd,
-					unsigned long *state)
-{
-	struct power_supply *psy;
-	union power_supply_propval val;
-	int ret;
-
-	psy = tcd->devdata;
-	ret = power_supply_get_property(psy,
-			POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT, &val);
-	if (ret)
-		return ret;
-
-	*state = val.intval;
-
-	return ret;
-}
-
-static int ps_set_cur_charge_cntl_limit(struct thermal_cooling_device *tcd,
-					unsigned long state)
-{
-	struct power_supply *psy;
-	union power_supply_propval val;
-	int ret;
-
-	psy = tcd->devdata;
-	val.intval = state;
-	ret = psy->desc->set_property(psy,
-		POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT, &val);
-
-	return ret;
-}
-
-static const struct thermal_cooling_device_ops psy_tcd_ops = {
-	.get_max_state = ps_get_max_charge_cntl_limit,
-	.get_cur_state = ps_get_cur_charge_cntl_limit,
-	.set_cur_state = ps_set_cur_charge_cntl_limit,
-};
-
-static int psy_register_cooler(struct power_supply *psy)
-{
-	/* Register for cooling device if psy can control charging */
-	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT)) {
-		psy->tcd = thermal_cooling_device_register(
-			(char *)psy->desc->name,
-			psy, &psy_tcd_ops);
-		return PTR_ERR_OR_ZERO(psy->tcd);
-	}
-
-	return 0;
-}
-
-static void psy_unregister_cooler(struct power_supply *psy)
-{
-	if (IS_ERR_OR_NULL(psy->tcd))
-		return;
-	thermal_cooling_device_unregister(psy->tcd);
-}
 #else
 static int psy_register_thermal(struct power_supply *psy)
 {
@@ -1272,15 +1195,6 @@ static int psy_register_thermal(struct power_supply *psy)
 static void psy_unregister_thermal(struct power_supply *psy)
 {
 }
-
-static int psy_register_cooler(struct power_supply *psy)
-{
-	return 0;
-}
-
-static void psy_unregister_cooler(struct power_supply *psy)
-{
-}
 #endif
 
 static struct power_supply *__must_check
@@ -1354,10 +1268,6 @@ __power_supply_register(struct device *parent,
 	if (rc)
 		goto register_thermal_failed;
 
-	rc = psy_register_cooler(psy);
-	if (rc)
-		goto register_cooler_failed;
-
 	rc = power_supply_create_triggers(psy);
 	if (rc)
 		goto create_triggers_failed;
@@ -1387,8 +1297,6 @@ __power_supply_register(struct device *parent,
 add_hwmon_sysfs_failed:
 	power_supply_remove_triggers(psy);
 create_triggers_failed:
-	psy_unregister_cooler(psy);
-register_cooler_failed:
 	psy_unregister_thermal(psy);
 register_thermal_failed:
 wakeup_init_failed:
@@ -1540,7 +1448,6 @@ void power_supply_unregister(struct power_supply *psy)
 	sysfs_remove_link(&psy->dev.kobj, "powers");
 	power_supply_remove_hwmon_sysfs(psy);
 	power_supply_remove_triggers(psy);
-	psy_unregister_cooler(psy);
 	psy_unregister_thermal(psy);
 	device_init_wakeup(&psy->dev, false);
 	device_unregister(&psy->dev);
-- 
2.30.2

