Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED274CA97
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjGJDd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGJDdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:33:25 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B23F9;
        Sun,  9 Jul 2023 20:33:20 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 36A3Wd9E089360;
        Mon, 10 Jul 2023 11:32:39 +0800 (+08)
        (envelope-from Di.Shen@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4QzqL567v8z2LcN4n;
        Mon, 10 Jul 2023 11:31:41 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.63) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 10 Jul 2023 11:32:37 +0800
From:   Di Shen <di.shen@unisoc.com>
To:     <lukasz.luba@arm.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <amitk@kernel.org>, <rui.zhang@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuewen.yan@unisoc.com>, <jeson.gao@unisoc.com>,
        <orsonzhai@gmail.com>, <zhanglyra@gmail.com>, <di.shen@unisoc.com>
Subject: [PATCH V5] thermal/core/power_allocator: reset thermal governor when trip point is changed
Date:   Mon, 10 Jul 2023 11:32:34 +0800
Message-ID: <20230710033234.28641-1-di.shen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.73.63]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 36A3Wd9E089360
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the thermal trip point is changed, the governor should
be reset so that the policy algorithm can be updated to adapt
to the new trip point.

1.Thermal governor is working for the passive trip point or active
trip point. Therefore, when the trip point is changed it should
reset the governor only for passic/active trip points.

2.For "power_allocator" governor reset, the parameters of pid
controller and the states of power cooling devices should be reset.

2.1
The IPA controls temperature using PID mechanism. It is a closed-
loop feedback monitoring system. It uses the gap between target
temperature and current temperature which says "error" as the
input of the PID controller:

err = desired_temperature - current_temperature
P_max =
k_p * err + k_i * err_integral + k_d * diff_err + sustainable_power

That algorithm can 'learn' from the 'observed' in the past reaction
for it's control decisions and accumulates that information in the
I(Integral) part so that it can conpensate for those 'learned'
mistakes.

Based on the above, the most important is the desired temperature
comes from the trip point. When the trip point is changed, all the
previous learned errors won't help for the IPA. So the pid parameters
should be reset for IPA governor reset.

2.2
Other wise, the cooling devices should also be reset when the trip
point is changed.

This patch adds an ops for the thermal_governor structure to reset
the governor and give the 'reset' function definition for power
allocator. The ops is called when the trip points are changed via
sysfs interface.

Signed-off-by: Di Shen <di.shen@unisoc.com>
---
 drivers/thermal/gov_power_allocator.c | 9 +++++++++
 drivers/thermal/thermal_trip.c        | 5 +++++
 include/linux/thermal.h               | 3 +++
 3 files changed, 17 insertions(+)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 8642f1096b91..8d17a10671e4 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -729,10 +729,19 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
 	return allocate_power(tz, trip.temperature);
 }
 
+static void power_allocator_reset(struct thermal_zone_device *tz)
+{
+	struct power_allocator_params *params = tz->governor_data;
+
+	reset_pid_controller(params);
+	allow_maximum_power(tz, true);
+}
+
 static struct thermal_governor thermal_gov_power_allocator = {
 	.name		= "power_allocator",
 	.bind_to_tz	= power_allocator_bind,
 	.unbind_from_tz	= power_allocator_unbind,
 	.throttle	= power_allocator_throttle,
+	.reset		= power_allocator_reset,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index 907f3a4d7bc8..13bbe029c6ab 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -173,6 +173,11 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
 	if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
 		tz->trips[trip_id] = *trip;
 
+	/* Reset the governor only when the trip type is active or passive. */
+	ret = (trip->type == THERMAL_TRIP_PASSIVE || trip->type == THERMAL_TRIP_ACTIVE);
+	if (ret && t.temperature != trip->temperature && tz->governor && tz->governor->reset)
+		tz->governor->reset(tz);
+
 	thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
 				      trip->temperature, trip->hysteresis);
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 87837094d549..d27d053319bf 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -197,6 +197,8 @@ struct thermal_zone_device {
  *			thermal zone.
  * @throttle:	callback called for every trip point even if temperature is
  *		below the trip point temperature
+ * @reset:	callback called for governor reset
+ *
  * @governor_list:	node in thermal_governor_list (in thermal_core.c)
  */
 struct thermal_governor {
@@ -204,6 +206,7 @@ struct thermal_governor {
 	int (*bind_to_tz)(struct thermal_zone_device *tz);
 	void (*unbind_from_tz)(struct thermal_zone_device *tz);
 	int (*throttle)(struct thermal_zone_device *tz, int trip);
+	void (*reset)(struct thermal_zone_device *tz);
 	struct list_head	governor_list;
 };
 
-- 
2.17.1

