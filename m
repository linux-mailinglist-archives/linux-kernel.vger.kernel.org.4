Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B232D734BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjFSGgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjFSGgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:36:35 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1A0123;
        Sun, 18 Jun 2023 23:36:32 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 35J6Zc1M009285;
        Mon, 19 Jun 2023 14:35:38 +0800 (+08)
        (envelope-from Di.Shen@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Ql0Pj1WnWz2KlGkP;
        Mon, 19 Jun 2023 14:35:21 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.63) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 19 Jun 2023 14:35:36 +0800
From:   Di Shen <di.shen@unisoc.com>
To:     <lukasz.luba@arm.com>, <daniel.lezcano@linaro.org>,
        <rafael@kernel.org>, <rui.zhang@intel.com>
CC:     <amitk@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xuewen.yan@unisoc.com>,
        <jeson.gao@unisoc.com>, <zhanglyra@gmail.com>,
        <orsonzhai@gmail.com>, <di.shen@unisoc.com>
Subject: [PATCH V4] thermal/core/power_allocator: reset thermal governor when trip point is changed
Date:   Mon, 19 Jun 2023 14:35:34 +0800
Message-ID: <20230619063534.12831-1-di.shen@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org>
References: <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.73.63]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 35J6Zc1M009285
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the thermal trip point is changed, the governor should
be reset so that the policy algorithm be updated to adapt to the
new trip point.

This patch adds an ops for thermal the governor structure to reset
the governor. The ops is called when the trip point is changed.
For power allocator, the parameters of pid controller and the states
of power cooling devices can be reset when the passive trip point
is changed.

Signed-off-by: Di Shen <di.shen@unisoc.com>

---
V4:
- Compared to V3, handle it in thermal core instead of in governor.

- Add an ops to the governor structure, and call it when a trip
  point is changed.

- Define reset ops for power allocator.

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
 drivers/thermal/gov_power_allocator.c | 21 +++++++++++++++++++++
 drivers/thermal/thermal_trip.c        |  6 ++++++
 include/linux/thermal.h               |  1 +
 3 files changed, 28 insertions(+)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 8642f1096b91..41d155adc616 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -729,10 +729,31 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
 	return allocate_power(tz, trip.temperature);
 }
 
+static int power_allocator_reset(struct thermal_zone_device *tz, int trip_id)
+{
+	int ret = 0;
+	struct thermal_trip trip;
+	struct power_allocator_params *params = tz->governor_data;
+
+	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
+	if (ret)
+		return ret;
+
+	/* Only need reset for passive trips */
+	if (trip.type != THERMAL_TRIP_PASSIVE)
+		return -EINVAL;
+
+	reset_pid_controller(params);
+	allow_maximum_power(tz, true);
+
+	return ret;
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
index 907f3a4d7bc8..52eb768fada8 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -173,6 +173,12 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
 	if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
 		tz->trips[trip_id] = *trip;
 
+	if (t.temperature != trip->temperature && tz->governor && tz->governor->reset) {
+		ret = tz->governor->reset(tz, trip_id);
+		if (ret)
+			pr_warn_once("Failed to reset thermal governor\n");
+	}
+
 	thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
 				      trip->temperature, trip->hysteresis);
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 87837094d549..155ce2291fa5 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -204,6 +204,7 @@ struct thermal_governor {
 	int (*bind_to_tz)(struct thermal_zone_device *tz);
 	void (*unbind_from_tz)(struct thermal_zone_device *tz);
 	int (*throttle)(struct thermal_zone_device *tz, int trip);
+	int (*reset)(struct thermal_zone_device *tz, int trip);
 	struct list_head	governor_list;
 };
 
-- 
2.17.1

