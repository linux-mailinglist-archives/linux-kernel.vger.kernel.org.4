Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3566B2601
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjCIN70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjCIN5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:57:21 -0500
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC115CBE;
        Thu,  9 Mar 2023 05:55:44 -0800 (PST)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 329DtK86091946;
        Thu, 9 Mar 2023 21:55:20 +0800 (+08)
        (envelope-from Di.Shen@unisoc.com)
Received: from bj10906pcu1.spreadtrum.com (10.0.74.67) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 9 Mar 2023 21:55:19 +0800
From:   Di Shen <di.shen@unisoc.com>
To:     <lukasz.luba@arm.com>, <rafael@kernel.org>
CC:     <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xuewen.yan@unisoc.com>
Subject: [PATCH] thermal/core/power_allocator: avoid cdev->state can not be reset
Date:   Thu, 9 Mar 2023 21:55:15 +0800
Message-ID: <20230309135515.1232-1-di.shen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.67]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 329DtK86091946
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0952177f2a1f (thermal/core/power_allocator: Update once cooling devices when temp is low)
add a update flag to update cooling device only once when temp is low.
But when the switch_on_temp is set to be a higher value, the cooling device state
may not be reset to max, because the last_temp is smaller than the switch_on_temp.

For example:
First:
swicth_on_temp=70 control_temp=85;

Then userspace change the trip_temp:
swicth_on_temp=45 control_temp=55 cur_temp=54

Then userspace reset the trip_temp:
swicth_on_temp=70 control_temp=85 cur_temp=57 last_temp=54

At this time, the cooling device state should be reset to be max.
However, because cur_temp(57) < switch_on_temp(70)
last_temp(54) < swicth_on_temp(70) --> update = false
When update is false, the cooling device state can not be reset.

So delete the update condition, so that the cooling device state
could be reset.

Fixes: 0952177f2a1f (thermal/core/power_allocator: Update once cooling devices when temp is low)
Signed-off-by: Di Shen <di.shen@unisoc.com>
---
 drivers/thermal/gov_power_allocator.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 0eaf1527d3e3..153bf528b98c 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -560,7 +560,7 @@ static void reset_pid_controller(struct power_allocator_params *params)
 	params->prev_err = 0;
 }
 
-static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
+static void allow_maximum_power(struct thermal_zone_device *tz)
 {
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
@@ -582,8 +582,7 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 		 */
 		cdev->ops->get_requested_power(cdev, &req_power);
 
-		if (update)
-			__thermal_cdev_update(instance->cdev);
+		__thermal_cdev_update(instance->cdev);
 
 		mutex_unlock(&instance->cdev->lock);
 	}
@@ -697,7 +696,6 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
 	struct power_allocator_params *params = tz->governor_data;
 	struct thermal_trip trip;
 	int ret;
-	bool update;
 
 	lockdep_assert_held(&tz->lock);
 
@@ -710,10 +708,9 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
 
 	ret = __thermal_zone_get_trip(tz, params->trip_switch_on, &trip);
 	if (!ret && (tz->temperature < trip.temperature)) {
-		update = (tz->last_temperature >= trip.temperature);
 		tz->passive = 0;
 		reset_pid_controller(params);
-		allow_maximum_power(tz, update);
+		allow_maximum_power(tz);
 		return 0;
 	}
 
-- 
2.17.1

