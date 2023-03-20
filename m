Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95C76C0DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjCTKAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCTJ75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:59:57 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D4FA5EA;
        Mon, 20 Mar 2023 02:59:52 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 32K9uU3j099896;
        Mon, 20 Mar 2023 17:56:30 +0800 (+08)
        (envelope-from Di.Shen@unisoc.com)
Received: from bj10906pcu1.spreadtrum.com (10.0.74.67) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 20 Mar 2023 17:56:29 +0800
From:   Di Shen <di.shen@unisoc.com>
To:     <lukasz.luba@arm.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuewen.yan@unisoc.com>, <jeson.gao@unisoc.com>,
        <zhanglyra@gmail.com>, <orsonzhai@gmail.com>
Subject: [PATCH V3] thermal/core/power_allocator: avoid thermal cdev can not be reset
Date:   Mon, 20 Mar 2023 17:56:20 +0800
Message-ID: <20230320095620.7480-1-di.shen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.67]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 32K9uU3j099896
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit <0952177f2a1f>(thermal/core/power_allocator: Update once
cooling devices when temp is low) adds a update flag to avoid
the thermal event is triggered when there is no need, and
thermal cdev would be update once when temperature is low.

But when the trips are writable, and switch_on_temp is set
to be a higher value, the cooling device state may not be
reset to 0, because last_temperature is smaller than the
switch_on_temp.

For example:
First:
switch_on_temp=70 control_temp=85;
Then userspace change the trip_temp:
switch_on_temp=45 control_temp=55 cur_temp=54

Then userspace reset the trip_temp:
switch_on_temp=70 control_temp=85 cur_temp=57 last_temp=54

At this time, the cooling device state should be reset to 0.
However, because cur_temp(57) < switch_on_temp(70)
last_temp(54) < switch_on_temp(70)  ---->  update = false,
update is false, the cooling device state can not be reset.

This patch adds a function thermal_cdev_needs_update() to
renew the update flag value only when the trips are writable,
so that thermal cdev->state can be reset after switch_on_temp
changed from low to high.

Fixes: <0952177f2a1f> (thermal/core/power_allocator: Update once cooling devices when temp is low)
Signed-off-by: Di Shen <di.shen@unisoc.com>

---
V3:
- Add fix tag.

V2:
- Compared to v1, do not revert.

- Add a variable(last_switch_on_temp) in power_allocator_params
  to record the last switch_on_temp value.

- Adds a function to renew the update flag and update the
  last_switch_on_temp when thermal trips are writable.

V1:
- Revert commit 0952177f2a1f.
---
---
 drivers/thermal/gov_power_allocator.c | 39 ++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 0eaf1527d3e3..c9e1f3b15f15 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -59,6 +59,8 @@ static inline s64 div_frac(s64 x, s64 y)
  *			governor switches on when this trip point is crossed.
  *			If the thermal zone only has one passive trip point,
  *			@trip_switch_on should be INVALID_TRIP.
+ * @last_switch_on_temp:Record the last switch_on_temp only when trips
+			are writable.
  * @trip_max_desired_temperature:	last passive trip point of the thermal
  *					zone.  The temperature we are
  *					controlling for.
@@ -70,6 +72,9 @@ struct power_allocator_params {
 	s64 err_integral;
 	s32 prev_err;
 	int trip_switch_on;
+#ifdef CONFIG_THERMAL_WRITABLE_TRIPS
+	int last_switch_on_temp;
+#endif
 	int trip_max_desired_temperature;
 	u32 sustainable_power;
 };
@@ -554,6 +559,25 @@ static void get_governor_trips(struct thermal_zone_device *tz,
 	}
 }
 
+#ifdef CONFIG_THERMAL_WRITABLE_TRIPS
+static bool thermal_cdev_needs_update(struct thermal_zone_device *tz, int switch_on_temp)
+{
+	bool update;
+	struct power_allocator_params *params = tz->governor_data;
+	int last_switch_on_temp = params->last_switch_on_temp;
+
+	update = (tz->last_temperature >= last_switch_on_temp);
+	params->last_switch_on_temp = switch_on_temp;
+
+	return update;
+}
+#else
+static inline bool thermal_cdev_needs_update(struct thermal_zone_device *tz, int switch_on_temp)
+{
+	return false;
+}
+#endif
+
 static void reset_pid_controller(struct power_allocator_params *params)
 {
 	params->err_integral = 0;
@@ -709,12 +733,15 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
 		return 0;
 
 	ret = __thermal_zone_get_trip(tz, params->trip_switch_on, &trip);
-	if (!ret && (tz->temperature < trip.temperature)) {
-		update = (tz->last_temperature >= trip.temperature);
-		tz->passive = 0;
-		reset_pid_controller(params);
-		allow_maximum_power(tz, update);
-		return 0;
+	if (!ret) {
+		update = thermal_cdev_needs_update(tz, trip.temperature);
+		if (tz->temperature < trip.temperature) {
+			update |= (tz->last_temperature >= trip.temperature);
+			tz->passive = 0;
+			reset_pid_controller(params);
+			allow_maximum_power(tz, update);
+			return 0;
+		}
 	}
 
 	tz->passive = 1;
-- 
2.17.1

