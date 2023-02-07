Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC8268DA54
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjBGORv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBGORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:17:50 -0500
X-Greylist: delayed 1254 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Feb 2023 06:17:47 PST
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E933C2884A;
        Tue,  7 Feb 2023 06:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Zrg3IByCp0PW4pKucv9m4DlG3g7aMkiLevmwDY/gzvE=; b=Yv381XU684DE4Rs0fSCgJIYiYj
        3laAxXmTYSWyMYdozopx/SZwY9ye8H4r05BjptXLZDstz13Jt64EHOxhQH8kAuufolwfpyFLx3gwk
        BMP/M4KDj/3O+5bjybx4oOGz1BBcQNPbO9lLQRUAB24sKL+vutxmYd4Q/PIPa+U572nGOFCbnxa2b
        A+Zv5rYx9C8njUZ6DaLPs6H2ExlketAqxVD3mOjjhEVkazHiuPnIvkfQ8KJ7ZRp08dnVV1iw0+lvN
        INHBTZTIeyjTr0wq/LGEWdLwPTZtfwc1KQ8FKNNAXYM3kfCouJxos1jV9CDHO1MN/smeq0G7zySQW
        wFT4UIAA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1pPOSV-002qTL-Tk; Tue, 07 Feb 2023 15:56:31 +0200
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Srikar Srimath Tirumala <srikars@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Timo Alho <talho@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] thermal: tegra-bpmp: Always (re)program trip temperatures
Date:   Tue,  7 Feb 2023 15:56:09 +0200
Message-Id: <20230207135610.3100865-2-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230207135610.3100865-1-cyndis@kapsi.fi>
References: <20230207135610.3100865-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

In the rare case that calculation of trip temperatures would result
in the same trip temperatures that were previously programmed, the
thermal core skips calling .set_trips. However, presently, if it is
not called, we may end up with no trip temperatures programmed at all.

To avoid this, make set_trips a no-op and in places where it would be
called, instead unconditionally program trip temperatures to the last
specified temperatures.

This also fixes the situation where a trip is triggered between
registering a thermal zone and registering the trip MRQ handler, in
which case we would also get stuck.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/thermal/tegra/tegra-bpmp-thermal.c | 33 +++++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index 628b18818ae9..9f69dbe1c7d4 100644
--- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
+++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
@@ -67,9 +67,8 @@ static int tegra_bpmp_thermal_get_temp(struct thermal_zone_device *tz, int *out_
 	return __tegra_bpmp_thermal_get_temp(tz->devdata, out_temp);
 }
 
-static int tegra_bpmp_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
+static int tegra_bpmp_thermal_program_trips(struct tegra_bpmp_thermal_zone *zone)
 {
-	struct tegra_bpmp_thermal_zone *zone = tz->devdata;
 	struct mrq_thermal_host_to_bpmp_request req;
 	struct tegra_bpmp_message msg;
 	int err;
@@ -78,8 +77,10 @@ static int tegra_bpmp_thermal_set_trips(struct thermal_zone_device *tz, int low,
 	req.type = CMD_THERMAL_SET_TRIP;
 	req.set_trip.zone = zone->idx;
 	req.set_trip.enabled = true;
-	req.set_trip.low = low;
-	req.set_trip.high = high;
+	mutex_lock(&zone->tzd->lock);
+	req.set_trip.low = zone->tzd->prev_low_trip;
+	req.set_trip.high = zone->tzd->prev_high_trip;
+	mutex_unlock(&zone->tzd->lock);
 
 	memset(&msg, 0, sizeof(msg));
 	msg.mrq = MRQ_THERMAL;
@@ -95,14 +96,31 @@ static int tegra_bpmp_thermal_set_trips(struct thermal_zone_device *tz, int low,
 	return 0;
 }
 
+static int tegra_bpmp_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	return 0;
+}
+
 static void tz_device_update_work_fn(struct work_struct *work)
 {
 	struct tegra_bpmp_thermal_zone *zone;
+	int err;
 
 	zone = container_of(work, struct tegra_bpmp_thermal_zone,
 			    tz_device_update_work);
 
+	/* Recalculates trip temperatures. */
 	thermal_zone_device_update(zone->tzd, THERMAL_TRIP_VIOLATED);
+
+	/*
+	 * Program trip temperatures. We must do this outside `set_trips`
+	 * since thermal core may skip calling it if the trip temperatures
+	 * are unchanged.
+	 */
+	err = tegra_bpmp_thermal_program_trips(zone);
+	if (err)
+		dev_err(zone->tegra->dev, "failed to update trip temperatures for zone '%s': %d\n",
+			zone->tzd->type, err);
 }
 
 static void bpmp_mrq_thermal(unsigned int mrq, struct tegra_bpmp_channel *ch,
@@ -293,6 +311,13 @@ static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	for (i = 0; i < tegra->num_zones; i++) {
+		err = tegra_bpmp_thermal_program_trips(tegra->zones[i]);
+		if (err)
+			dev_err(&pdev->dev, "failed to set trip temperatures for zone '%s': %d\n",
+				tzd->type, err);
+	}
+
 	platform_set_drvdata(pdev, tegra);
 
 	return 0;
-- 
2.39.0

