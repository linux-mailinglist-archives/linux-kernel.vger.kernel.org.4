Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408D97501FF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjGLItv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjGLIts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:49:48 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FDFB1;
        Wed, 12 Jul 2023 01:49:44 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 36C8mjdd097455;
        Wed, 12 Jul 2023 16:48:45 +0800 (+08)
        (envelope-from Di.Shen@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4R1BFq1lLMz2MK44l;
        Wed, 12 Jul 2023 16:47:43 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.63) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 12 Jul 2023 16:48:43 +0800
From:   Di Shen <di.shen@unisoc.com>
To:     <lukasz.luba@arm.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuewen.yan@unisoc.com>, <jeson.gao@unisoc.com>,
        <orsonzhai@gmail.com>, <zhanglyra@gmail.com>, <di.shen@unisoc.com>
Subject: [PATCH] Revert "thermal: power allocator: change the 'k_*' always in estimate_pid_constants()"
Date:   Wed, 12 Jul 2023 16:48:40 +0800
Message-ID: <20230712084840.3594-1-di.shen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.73.63]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 36C8mjdd097455
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 90a996544946d1d4834ec2ec8add586edd905779.

The commit ensures that the pid constants are updated when
sustainable_power changes, but it makes it impossible for
the driver to set the pid constants when the sustainable_power
is not changed.

When the driver tries to register a thermal zone device by
thermal_zone_device_register_with_trips(const char *type,
	struct thermal_trip *trips, int num_trips, int mask,
	void *devdata, struct thermal_zone_device_ops *ops,
	struct thermal_zone_params *tzp, int passive_delay,
	int polling_delay)
and passes the private thermal_zone_params structure data,

thermal_zone_devcice_register_with_trips
	|
thermal_set_governor
	|
bind_to_tz
	|
power_allocator_bind
	|
estimate_pid_constants

the tzp->k_* will not be the data that driver have given,
but the data estimated by sustainable_power.

To make it possible for driver to add its own pid constants,
the 'force' flag is needed to indicate whether the tzp->k_*
should be estimated by sustainable_power or not.

Signed-off-by: Di Shen <di.shen@unisoc.com>
---
 drivers/thermal/gov_power_allocator.c | 28 ++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 8642f1096b91..f1753291b827 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -116,13 +116,18 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
  * @sustainable_power:	sustainable power for the thermal zone
  * @trip_switch_on:	trip point number for the switch on temperature
  * @control_temp:	target temperature for the power allocator governor
+ * @force:	whether to force the update of the constants
  *
  * This function is used to update the estimation of the PID
  * controller constants in struct thermal_zone_parameters.
+ *
+ * If @force is not set, the values in the thermal zone's parameters
+ * are preserved if they are not zero.  If @force is set, the values
+ * in thermal zone's parameters are overwritten.
  */
 static void estimate_pid_constants(struct thermal_zone_device *tz,
 				   u32 sustainable_power, int trip_switch_on,
-				   int control_temp)
+				   int control_temp, bool force)
 {
 	struct thermal_trip trip;
 	u32 temperature_threshold = control_temp;
@@ -144,14 +149,18 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 	if (!temperature_threshold)
 		return;
 
-	tz->tzp->k_po = int_to_frac(sustainable_power) /
-		temperature_threshold;
+	if (!tz->tzp->k_po || force)
+		tz->tzp->k_po = int_to_frac(sustainable_power) /
+			temperature_threshold;
 
-	tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
-		temperature_threshold;
+	if (!tz->tzp->k_pu || force)
+		tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
+			temperature_threshold;
 
-	k_i = tz->tzp->k_pu / 10;
-	tz->tzp->k_i = k_i > 0 ? k_i : 1;
+	if (!tz->tzp->k_i || force) {
+		k_i = tz->tzp->k_pu / 10;
+		tz->tzp->k_i = k_i > 0 ? k_i : 1;
+	}
 
 	/*
 	 * The default for k_d and integral_cutoff is 0, so we can
@@ -184,7 +193,8 @@ static u32 get_sustainable_power(struct thermal_zone_device *tz,
 	/* Check if it's init value 0 or there was update via sysfs */
 	if (sustainable_power != params->sustainable_power) {
 		estimate_pid_constants(tz, sustainable_power,
-				       params->trip_switch_on, control_temp);
+				       params->trip_switch_on, control_temp,
+				       true);
 
 		/* Do the estimation only once and make available in sysfs */
 		tz->tzp->sustainable_power = sustainable_power;
@@ -662,7 +672,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 		if (!ret)
 			estimate_pid_constants(tz, tz->tzp->sustainable_power,
 					       params->trip_switch_on,
-					       trip.temperature);
+					       trip.temperature, false);
 	}
 
 	reset_pid_controller(params);
-- 
2.17.1

