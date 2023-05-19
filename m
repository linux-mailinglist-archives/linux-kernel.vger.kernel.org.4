Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9626708E55
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjESD2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjESD1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:27:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FBC12F;
        Thu, 18 May 2023 20:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 853F465262;
        Fri, 19 May 2023 03:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C28C4339C;
        Fri, 19 May 2023 03:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684466861;
        bh=XfBSJ+X/hBSEcMCTITGsqxEQnjkEMITopqVn93fGedI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hijIT/G4cLMoceAMJWoOax1lD38yWOlDuanQf/5Ma0JVzn2fFW4GBC1lrKQ0kZdfJ
         Q7i3LuOemSgKNuOmgPPYhYyFR8q0B+vA9MbwKdcTNT4czkEYIr1FSi37HxeriQTYTh
         9/vgHtutRSXXI3x6aFTn1z1WAVLb3L/g6/839lfRTL/GJVzgzpN2/M4wM9esQHX1QS
         MOTMqj1nuC3PHe+iSiDnziqmZa/i95kTvycmAOjKWxAxKrk/4XFR57ngSS2fxHRqxz
         VT4OXnOaC2510i/VMGW8vGAuO9xK66hM0u8MXOOac+42+SIQu/NcrjaQzk4Pm+hsPa
         4icRWTquW9U7A==
From:   Eduardo Valentin <evalenti@kernel.org>
To:     eduval@amazon.com, linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] thermal: stats: introduce thermal zone stats/min_gradient
Date:   Thu, 18 May 2023 20:27:16 -0700
Message-Id: <20230519032719.2581689-5-evalenti@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519032719.2581689-1-evalenti@kernel.org>
References: <20230519032719.2581689-1-evalenti@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eduardo Valentin <eduval@amazon.com>

The patch adds a statistic to track
the minimum gradient (dT/dt) to the thermal zone
stats/ folder.

Samples:

$ echo 1000 > emul_temp
$ cat stats/min_gradient
0
$ echo 2000 > emul_temp
$ echo 1000 > emul_temp
$ cat stats/min_gradient
-3460

Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
Cc: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
Cc: linux-pm@vger.kernel.org (open list:THERMAL)
Cc: linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Cc: linux-kernel@vger.kernel.org (open list)

Signed-off-by: Eduardo Valentin <eduval@amazon.com>
---
 .../driver-api/thermal/sysfs-api.rst          |  1 +
 drivers/thermal/thermal_sysfs.c               | 23 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index 18140dbb1ce1..ed5e6ba4e0d7 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -358,6 +358,7 @@ Thermal zone device sys I/F, created once it's registered::
     |---stats:			Directory containing thermal zone device's stats
     |---stats/reset_tz_stats:	Writes to this file resets the statistics.
     |---stats/max_gradient:	The maximum recorded dT/dt in uC/ms.
+    |---stats/min_gradient:	The minimum recorded dT/dt in uC/ms.
 
 Thermal cooling device sys I/F, created once it's registered::
 
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index aa28c1cae916..f89ec9a7e8c8 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -542,6 +542,7 @@ static void destroy_trip_attrs(struct thermal_zone_device *tz)
 struct thermal_zone_device_stats {
 	spinlock_t lock; /* protects this struct */
 	s64 max_gradient;
+	s64 min_gradient;
 	ktime_t last_time;
 };
 
@@ -569,6 +570,10 @@ static void temperature_stats_update(struct thermal_zone_device *tz)
 	/* update fastest temperature rise from our perspective */
 	if (cur_gradient > stats->max_gradient)
 		stats->max_gradient = cur_gradient;
+
+	/* update fastest temperature decay from our perspective */
+	if (cur_gradient < stats->min_gradient)
+		stats->min_gradient = cur_gradient;
 }
 
 void thermal_zone_device_stats_update(struct thermal_zone_device *tz)
@@ -595,6 +600,21 @@ static ssize_t max_gradient_show(struct device *dev,
 	return ret;
 }
 
+static ssize_t min_gradient_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone_device_stats *stats = tz->stats;
+	int ret;
+
+	spin_lock(&stats->lock);
+	temperature_stats_update(tz);
+	ret = snprintf(buf, PAGE_SIZE, "%lld\n", stats->min_gradient);
+	spin_unlock(&stats->lock);
+
+	return ret;
+}
+
 static ssize_t
 reset_tz_stats_store(struct device *dev, struct device_attribute *attr,
 		     const char *buf, size_t count)
@@ -604,6 +624,7 @@ reset_tz_stats_store(struct device *dev, struct device_attribute *attr,
 
 	spin_lock(&stats->lock);
 
+	stats->min_gradient = 0;
 	stats->max_gradient = 0;
 	stats->last_time = ktime_get();
 
@@ -612,10 +633,12 @@ reset_tz_stats_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static DEVICE_ATTR_RO(min_gradient);
 static DEVICE_ATTR_RO(max_gradient);
 static DEVICE_ATTR_WO(reset_tz_stats);
 
 static struct attribute *thermal_zone_device_stats_attrs[] = {
+	&dev_attr_min_gradient.attr,
 	&dev_attr_max_gradient.attr,
 	&dev_attr_reset_tz_stats.attr,
 	NULL
-- 
2.34.1

