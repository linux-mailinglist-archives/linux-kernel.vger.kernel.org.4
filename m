Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19625F3BB9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 05:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJDDjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 23:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJDDjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:39:45 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78645F7F;
        Mon,  3 Oct 2022 20:39:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b15so3717337pje.1;
        Mon, 03 Oct 2022 20:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=RT0EFEbIo3WJcZcZui18R3eX6a/+w1mMSvFbIuTPhfQ=;
        b=RVETNlk0kdaOY/NVgR2Tp/hrs9quaSekl0qy0jNeXd7DFI3tqKzMi1zo6VWCK/vvgx
         0OORzGKhRIpCAgOrb685xfzvMiIsGTz3tXu+sQCbTATq4M84sgTMSZOn1Be4W9Y4IHnW
         tBua/NzAKSrfiUuGzX+u2LeCiTf0SneImNIs+F/Nu+DCq2isUhtuL6kGiH2JGez3uINz
         FgtH/hjqREbFezY6DwDCxKVhxR14pKDsJCvvhC+ras3vc7lbRgRtb+md1hqmyFlpMrXF
         VKLkfFapcFKiOJeJL05F19DNWljIQpZ1AuYe2pfR36oAVny1cxIgbf+9BzEqaFeRanoF
         k66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=RT0EFEbIo3WJcZcZui18R3eX6a/+w1mMSvFbIuTPhfQ=;
        b=RwpMa3EzObymTjbJPJUysqaDDfWHwq+4q389kyN6DcrhYhqV2/doOB3BdTCMRmhJPQ
         mjRHNUkq3ta9GwCgPL1FTtIC8ZeTv68TOGrSoeA1sf9PT8e7jaWWLik1BrGeSR5MsdeK
         64aKJIkA0D1uipYilrIeKkqNi9MrIX6D3OP4lu2LbIhPNKLcrvzfmaBjvot0McpPkTz5
         Das5pMYvMpn0rJLdnD1SXUsg4Z/lyqhzagvlhXJ45o0YfclRQImVNed4LK0wg8N3ftF7
         UL920yM3zuMOWL6hNjnxLKuQsgSOpLWNQTxvBbf9UFomJbS2kEYDCC3QtuvTq2sBbJM7
         rd6w==
X-Gm-Message-State: ACrzQf1Rga4Kw/+dBmAlGo9F+H8iu3xqb9WeSAmz/ZI6U5WLG7Ze8YcL
        b4CF2Vge1g/e5RGoaFD8IVJ+QQTUIZcdXw==
X-Google-Smtp-Source: AMsMyM6cJrldb23mZ8ga0o8hv7uXqCyC3XKPKUMI53QIqmr+bowu2COavZwpX4HXDQtAekt4WH4d1A==
X-Received: by 2002:a17:90b:3741:b0:20a:da56:b07d with SMTP id ne1-20020a17090b374100b0020ada56b07dmr625560pjb.239.1664854780998;
        Mon, 03 Oct 2022 20:39:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902d50e00b0017a122e3f09sm7990366plg.195.2022.10.03.20.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 20:39:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [RFC/RFT PATCH resend] thermal: Protect thermal device operations against thermal device removal
Date:   Mon,  3 Oct 2022 20:39:36 -0700
Message-Id: <20221004033936.1047691-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A call to thermal_zone_device_unregister() results in thermal device
removal. While the thermal device itself is reference counted and
protected against removal of its associated data structures, the
thermal device operations are owned by the calling code and unprotected.
This may result in crashes such as

BUG: unable to handle page fault for address: ffffffffc04ef420
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
PGD 5d60e067 P4D 5d60e067 PUD 5d610067 PMD 110197067 PTE 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 1 PID: 3209 Comm: cat Tainted: G        W         5.10.136-19389-g615abc6eb807 #1 02df41ac0b12f3a64f4b34245188d8875bb3bce1
Hardware name: Google Coral/Coral, BIOS Google_Coral.10068.92.0 11/27/2018
RIP: 0010:thermal_zone_get_temp+0x26/0x73
Code: 89 c3 eb d3 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 53 48 85 ff 74 50 48 89 fb 48 81 ff 00 f0 ff ff 77 44 48 8b 83 98 03 00 00 <48> 83 78 10 00 74 36 49 89 f6 4c 8d bb d8 03 00 00 4c 89 ff e8 9f
RSP: 0018:ffffb3758138fd38 EFLAGS: 00010287
RAX: ffffffffc04ef410 RBX: ffff98f14d7fb000 RCX: 0000000000000000
RDX: ffff98f17cf90000 RSI: ffffb3758138fd64 RDI: ffff98f14d7fb000
RBP: ffffb3758138fd50 R08: 0000000000001000 R09: ffff98f17cf90000
R10: 0000000000000000 R11: ffffffff8dacad28 R12: 0000000000001000
R13: ffff98f1793a7d80 R14: ffff98f143231708 R15: ffff98f14d7fb018
FS:  00007ec166097800(0000) GS:ffff98f1bbd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffc04ef420 CR3: 000000010ee9a000 CR4: 00000000003506e0
Call Trace:
 temp_show+0x31/0x68
 dev_attr_show+0x1d/0x4f
 sysfs_kf_seq_show+0x92/0x107
 seq_read_iter+0xf5/0x3f2
 vfs_read+0x205/0x379
 __x64_sys_read+0x7c/0xe2
 do_syscall_64+0x43/0x55
 entry_SYSCALL_64_after_hwframe+0x61/0xc6

if a thermal device is removed while accesses to its device attributes
are ongoing.

Use the thermal device mutex to protect device operations. Clear the
device operations pointer in thermal_zone_device_unregister() under
protection of this mutex, and only access it while the mutex is held.
Flatten and simplify device mutex operations to only acquire the mutex
once and hold it instead of acquiring and releasing it several times
during thermal operations. Only validate parameters once at module entry
points after acquiring the mutex. Execute governor operations under mutex
instead of expecting governors to acquire and release it.  

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
RFC/RFT:
  This patch ended up being substantially more complex than I initially
  thought it would be. It should only be applied after extensive review
  and testing (I don't think it is 6.1 material).
  I tested it as much as I could with Chromebooks using chromeos-5.10
  and chromeos-5.15. Plan is to apply it to those branches as well as to
  older ChromeOS kernel branches, but I would like to get some level of
  confidence that this is the right approach before doing that.

 drivers/thermal/gov_bang_bang.c       |   8 --
 drivers/thermal/gov_fair_share.c      |   3 -
 drivers/thermal/gov_power_allocator.c |  19 +---
 drivers/thermal/gov_step_wise.c       |   8 --
 drivers/thermal/gov_user_space.c      |   2 -
 drivers/thermal/thermal_core.c        |  97 +++++++++++--------
 drivers/thermal/thermal_core.h        |   3 +
 drivers/thermal/thermal_helpers.c     |  56 ++++++++---
 drivers/thermal/thermal_hwmon.c       |  15 ++-
 drivers/thermal/thermal_netlink.c     |   5 +
 drivers/thermal/thermal_sysfs.c       | 134 ++++++++++++++++++++------
 11 files changed, 223 insertions(+), 127 deletions(-)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index 991a1c54296d..a1b63cd54e1a 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -31,8 +31,6 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 				trip, trip_temp, tz->temperature,
 				trip_hyst);
 
-	mutex_lock(&tz->lock);
-
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
 			continue;
@@ -65,8 +63,6 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		instance->cdev->updated = false; /* cdev needs update */
 		mutex_unlock(&instance->cdev->lock);
 	}
-
-	mutex_unlock(&tz->lock);
 }
 
 /**
@@ -102,13 +98,9 @@ static int bang_bang_control(struct thermal_zone_device *tz, int trip)
 
 	thermal_zone_trip_update(tz, trip);
 
-	mutex_lock(&tz->lock);
-
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
 		thermal_cdev_update(instance->cdev);
 
-	mutex_unlock(&tz->lock);
-
 	return 0;
 }
 
diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index 6a2abcfc648f..12ab7171cc4d 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -82,8 +82,6 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 	int total_instance = 0;
 	int cur_trip_level = get_trip_level(tz);
 
-	mutex_lock(&tz->lock);
-
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
 			continue;
@@ -112,7 +110,6 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 		mutex_unlock(&cdev->lock);
 	}
 
-	mutex_unlock(&tz->lock);
 	return 0;
 }
 
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 1d5052470967..84e02664bc7b 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -392,8 +392,6 @@ static int allocate_power(struct thermal_zone_device *tz,
 	int i, num_actors, total_weight, ret = 0;
 	int trip_max_desired_temperature = params->trip_max_desired_temperature;
 
-	mutex_lock(&tz->lock);
-
 	num_actors = 0;
 	total_weight = 0;
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
@@ -404,10 +402,8 @@ static int allocate_power(struct thermal_zone_device *tz,
 		}
 	}
 
-	if (!num_actors) {
-		ret = -ENODEV;
-		goto unlock;
-	}
+	if (!num_actors)
+		return -ENODEV;
 
 	/*
 	 * We need to allocate five arrays of the same size:
@@ -421,10 +417,8 @@ static int allocate_power(struct thermal_zone_device *tz,
 	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*extra_actor_power));
 	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*weighted_req_power));
 	req_power = kcalloc(num_actors * 5, sizeof(*req_power), GFP_KERNEL);
-	if (!req_power) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
+	if (!req_power)
+		return -ENOMEM;
 
 	max_power = &req_power[num_actors];
 	granted_power = &req_power[2 * num_actors];
@@ -496,9 +490,6 @@ static int allocate_power(struct thermal_zone_device *tz,
 				      control_temp - tz->temperature);
 
 	kfree(req_power);
-unlock:
-	mutex_unlock(&tz->lock);
-
 	return ret;
 }
 
@@ -576,7 +567,6 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 	struct power_allocator_params *params = tz->governor_data;
 	u32 req_power;
 
-	mutex_lock(&tz->lock);
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		struct thermal_cooling_device *cdev = instance->cdev;
 
@@ -598,7 +588,6 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 
 		mutex_unlock(&instance->cdev->lock);
 	}
-	mutex_unlock(&tz->lock);
 }
 
 /**
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 9729b46d0258..d18ab7ef6262 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -117,8 +117,6 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
 				trip, trip_type, trip_temp, trend, throttle);
 
-	mutex_lock(&tz->lock);
-
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != trip)
 			continue;
@@ -145,8 +143,6 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		instance->cdev->updated = false; /* cdev needs update */
 		mutex_unlock(&instance->cdev->lock);
 	}
-
-	mutex_unlock(&tz->lock);
 }
 
 /**
@@ -166,13 +162,9 @@ static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
 
 	thermal_zone_trip_update(tz, trip);
 
-	mutex_lock(&tz->lock);
-
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
 		thermal_cdev_update(instance->cdev);
 
-	mutex_unlock(&tz->lock);
-
 	return 0;
 }
 
diff --git a/drivers/thermal/gov_user_space.c b/drivers/thermal/gov_user_space.c
index a62a4e90bd3f..0e7750273679 100644
--- a/drivers/thermal/gov_user_space.c
+++ b/drivers/thermal/gov_user_space.c
@@ -34,7 +34,6 @@ static int notify_user_space(struct thermal_zone_device *tz, int trip)
 	char *thermal_prop[5];
 	int i;
 
-	mutex_lock(&tz->lock);
 	thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", tz->type);
 	thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", tz->temperature);
 	thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=%d", trip);
@@ -43,7 +42,6 @@ static int notify_user_space(struct thermal_zone_device *tz, int trip)
 	kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
 	for (i = 0; i < 4; ++i)
 		kfree(thermal_prop[i]);
-	mutex_unlock(&tz->lock);
 	return 0;
 }
 
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 50d50cec7774..ee41f02142a7 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -295,9 +295,14 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 		cancel_delayed_work(&tz->poll_queue);
 }
 
+static int __thermal_zone_device_is_enabled(struct thermal_zone_device *tz)
+{
+	return tz->ops && tz->mode == THERMAL_DEVICE_ENABLED;
+}
+
 static inline bool should_stop_polling(struct thermal_zone_device *tz)
 {
-	return !thermal_zone_device_is_enabled(tz);
+	return !__thermal_zone_device_is_enabled(tz);
 }
 
 static void monitor_thermal_zone(struct thermal_zone_device *tz)
@@ -306,16 +311,12 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 
 	stop = should_stop_polling(tz);
 
-	mutex_lock(&tz->lock);
-
 	if (!stop && tz->passive)
 		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
 	else if (!stop && tz->polling_delay_jiffies)
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
 	else
 		thermal_zone_device_set_polling(tz, 0);
-
-	mutex_unlock(&tz->lock);
 }
 
 static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
@@ -394,7 +395,7 @@ static void update_temperature(struct thermal_zone_device *tz)
 {
 	int temp, ret;
 
-	ret = thermal_zone_get_temp(tz, &temp);
+	ret = __thermal_zone_get_temp(tz, &temp);
 	if (ret) {
 		if (ret != -EAGAIN)
 			dev_warn(&tz->device,
@@ -403,10 +404,8 @@ static void update_temperature(struct thermal_zone_device *tz)
 		return;
 	}
 
-	mutex_lock(&tz->lock);
 	tz->last_temperature = tz->temperature;
 	tz->temperature = temp;
-	mutex_unlock(&tz->lock);
 
 	trace_thermal_temperature(tz);
 
@@ -423,6 +422,31 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 		pos->initialized = false;
 }
 
+void __thermal_zone_device_update(struct thermal_zone_device *tz,
+				  enum thermal_notify_event event)
+{
+	int count;
+
+	if (should_stop_polling(tz))
+		return;
+
+	if (atomic_read(&in_suspend))
+		return;
+
+	if (WARN_ONCE(!tz->ops->get_temp,
+		      "'%s' must not be called without 'get_temp' ops set\n", __func__))
+		return;
+
+	update_temperature(tz);
+
+	thermal_zone_set_trips(tz);
+
+	tz->notify_event = event;
+
+	for (count = 0; count < tz->num_trips; count++)
+		handle_thermal_trip(tz, count);
+}
+
 static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 					enum thermal_device_mode mode)
 {
@@ -431,10 +455,12 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 	mutex_lock(&tz->lock);
 
 	/* do nothing if mode isn't changing */
-	if (mode == tz->mode) {
-		mutex_unlock(&tz->lock);
+	if (mode == tz->mode)
+		goto unlock;
 
-		return ret;
+	if (!tz->ops) {
+		ret = -EINVAL;
+		goto unlock;
 	}
 
 	if (tz->ops->change_mode)
@@ -443,15 +469,15 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 	if (!ret)
 		tz->mode = mode;
 
-	mutex_unlock(&tz->lock);
-
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	if (mode == THERMAL_DEVICE_ENABLED)
 		thermal_notify_tz_enable(tz->id);
 	else
 		thermal_notify_tz_disable(tz->id);
 
+unlock:
+	mutex_unlock(&tz->lock);
 	return ret;
 }
 
@@ -469,40 +495,21 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_disable);
 
 int thermal_zone_device_is_enabled(struct thermal_zone_device *tz)
 {
-	enum thermal_device_mode mode;
+	bool enabled;
 
 	mutex_lock(&tz->lock);
-
-	mode = tz->mode;
-
+	enabled = __thermal_zone_device_is_enabled(tz);
 	mutex_unlock(&tz->lock);
 
-	return mode == THERMAL_DEVICE_ENABLED;
+	return enabled;
 }
 
 void thermal_zone_device_update(struct thermal_zone_device *tz,
 				enum thermal_notify_event event)
 {
-	int count;
-
-	if (should_stop_polling(tz))
-		return;
-
-	if (atomic_read(&in_suspend))
-		return;
-
-	if (WARN_ONCE(!tz->ops->get_temp, "'%s' must not be called without "
-		      "'get_temp' ops set\n", __func__))
-		return;
-
-	update_temperature(tz);
-
-	thermal_zone_set_trips(tz);
-
-	tz->notify_event = event;
-
-	for (count = 0; count < tz->num_trips; count++)
-		handle_thermal_trip(tz, count);
+	mutex_lock(&tz->lock);
+	__thermal_zone_device_update(tz, event);
+	mutex_unlock(&tz->lock);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
@@ -779,6 +786,7 @@ static void thermal_release(struct device *dev)
 		     sizeof("thermal_zone") - 1)) {
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
+		mutex_destroy(&tz->lock);
 		kfree(tz);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
 			    sizeof("cooling_device") - 1)) {
@@ -1397,10 +1405,19 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_remove_hwmon_sysfs(tz);
 	ida_free(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
-	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
 
 	thermal_notify_tz_delete(tz_id);
+
+	/*
+	 * tz->ops is not reference counted, and the caller will likely
+	 * release it. Make sure it is no longer used after this call returns.
+	 * Note that we can not call mutex_destroy() on the mutex since the
+	 * tz device may still be in use.
+	 */
+	mutex_lock(&tz->lock);
+	tz->ops = NULL;
+	mutex_unlock(&tz->lock);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index c991bb290512..eb8a13ebd676 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -109,9 +109,12 @@ int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
 int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
 int thermal_build_list_of_policies(char *buf);
+void __thermal_zone_device_update(struct thermal_zone_device *tz,
+				  enum thermal_notify_event event);
 
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
+int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 690890f054a3..ad1720278b5b 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -65,27 +65,26 @@ get_thermal_instance(struct thermal_zone_device *tz,
 EXPORT_SYMBOL(get_thermal_instance);
 
 /**
- * thermal_zone_get_temp() - returns the temperature of a thermal zone
+ * __thermal_zone_get_temp() - returns the temperature of a thermal zone
  * @tz: a valid pointer to a struct thermal_zone_device
  * @temp: a valid pointer to where to store the resulting temperature.
  *
  * When a valid thermal zone reference is passed, it will fetch its
  * temperature and fill @temp.
  *
+ * Both tz and tz->ops must be valid pointers when calling this function,
+ * and tz->ops->get_temp must be set.
+ * The function must be called under tz->lock.
+ *
  * Return: On success returns 0, an error code otherwise
  */
-int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
+int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	int ret = -EINVAL;
+	int ret;
 	int count;
 	int crit_temp = INT_MAX;
 	enum thermal_trip_type type;
 
-	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
-		goto exit;
-
-	mutex_lock(&tz->lock);
-
 	ret = tz->ops->get_temp(tz, temp);
 
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
@@ -107,8 +106,35 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 			*temp = tz->emul_temperature;
 	}
 
+	return ret;
+}
+
+/**
+ * thermal_zone_get_temp() - returns the temperature of a thermal zone
+ * @tz: a valid pointer to a struct thermal_zone_device
+ * @temp: a valid pointer to where to store the resulting temperature.
+ *
+ * When a valid thermal zone reference is passed, it will fetch its
+ * temperature and fill @temp.
+ *
+ * Return: On success returns 0, an error code otherwise
+ */
+int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	int ret = -EINVAL;
+
+	if (!tz || IS_ERR(tz))
+		return ret;
+
+	mutex_lock(&tz->lock);
+
+	if (!tz->ops || !tz->ops->get_temp)
+		goto unlock;
+
+	ret = __thermal_zone_get_temp(tz, temp);
+
+unlock:
 	mutex_unlock(&tz->lock);
-exit:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
@@ -123,6 +149,9 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
  * driver to let it set its own notification mechanism (usually an
  * interrupt).
  *
+ * This function must be called under tz->lock. Both tz and tz->ops
+ * must be valid pointers.
+ *
  * It does not return a value
  */
 void thermal_zone_set_trips(struct thermal_zone_device *tz)
@@ -132,10 +161,8 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	int trip_temp, hysteresis;
 	int i, ret;
 
-	mutex_lock(&tz->lock);
-
 	if (!tz->ops->set_trips || !tz->ops->get_trip_hyst)
-		goto exit;
+		return;
 
 	for (i = 0; i < tz->num_trips; i++) {
 		int trip_low;
@@ -154,7 +181,7 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 
 	/* No need to change trip points */
 	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
-		goto exit;
+		return;
 
 	tz->prev_low_trip = low;
 	tz->prev_high_trip = high;
@@ -169,9 +196,6 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	ret = tz->ops->set_trips(tz, low, high);
 	if (ret)
 		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
-
-exit:
-	mutex_unlock(&tz->lock);
 }
 
 static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 09e49ec8b6f4..98086c898bba 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -75,13 +75,22 @@ temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
 				       temp_crit);
 	struct thermal_zone_device *tz = temp->tz;
 	int temperature;
-	int ret;
+	int ret = -EINVAL;
+
+	mutex_lock(&tz->lock);
+
+	if (!tz->ops)
+		goto unlock;
 
 	ret = tz->ops->get_crit_temp(tz, &temperature);
 	if (ret)
-		return ret;
+		goto unlock;
 
-	return sprintf(buf, "%d\n", temperature);
+	ret = sprintf(buf, "%d\n", temperature);
+
+unlock:
+	mutex_unlock(&tz->lock);
+	return ret;
 }
 
 
diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
index 050d243a5fa1..90fb9d9fda80 100644
--- a/drivers/thermal/thermal_netlink.c
+++ b/drivers/thermal/thermal_netlink.c
@@ -469,6 +469,11 @@ static int thermal_genl_cmd_tz_get_trip(struct param *p)
 
 	mutex_lock(&tz->lock);
 
+	if (!tz->ops) {
+		mutex_unlock(&tz->lock);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < tz->num_trips; i++) {
 
 		enum thermal_trip_type type;
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 3a8d6e747c25..b211b983acbc 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -82,28 +82,46 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
 	enum thermal_trip_type type;
 	int trip, result;
 
-	if (!tz->ops->get_trip_type)
-		return -EPERM;
-
 	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip) != 1)
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
+
+	if (!tz->ops) {
+		result = -EINVAL;
+		goto unlock;
+	}
+
+	if (!tz->ops->get_trip_type) {
+		result = -EPERM;
+		goto unlock;
+	}
+
 	result = tz->ops->get_trip_type(tz, trip, &type);
 	if (result)
-		return result;
+		goto unlock;
 
 	switch (type) {
 	case THERMAL_TRIP_CRITICAL:
-		return sprintf(buf, "critical\n");
+		result = sprintf(buf, "critical\n");
+		break;
 	case THERMAL_TRIP_HOT:
-		return sprintf(buf, "hot\n");
+		result = sprintf(buf, "hot\n");
+		break;
 	case THERMAL_TRIP_PASSIVE:
-		return sprintf(buf, "passive\n");
+		result = sprintf(buf, "passive\n");
+		break;
 	case THERMAL_TRIP_ACTIVE:
-		return sprintf(buf, "active\n");
+		result = sprintf(buf, "active\n");
+		break;
 	default:
-		return sprintf(buf, "unknown\n");
+		result = sprintf(buf, "unknown\n");
+		break;
 	}
+
+unlock:
+	mutex_unlock(&tz->lock);
+	return result;
 }
 
 static ssize_t
@@ -115,34 +133,45 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	int temperature, hyst = 0;
 	enum thermal_trip_type type;
 
-	if (!tz->ops->set_trip_temp)
-		return -EPERM;
-
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
 		return -EINVAL;
 
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
+
+	if (!tz->ops) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (!tz->ops->set_trip_temp) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
 	ret = tz->ops->set_trip_temp(tz, trip, temperature);
 	if (ret)
-		return ret;
+		goto unlock;
 
 	if (tz->ops->get_trip_hyst) {
 		ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
 		if (ret)
-			return ret;
+			goto unlock;
 	}
 
 	ret = tz->ops->get_trip_type(tz, trip, &type);
 	if (ret)
-		return ret;
+		goto unlock;
 
 	thermal_notify_tz_trip_change(tz->id, trip, type, temperature, hyst);
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
-	return count;
+unlock:
+	mutex_unlock(&tz->lock);
+	return ret ? ret : count;
 }
 
 static ssize_t
@@ -153,18 +182,30 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 	int trip, ret;
 	int temperature;
 
-	if (!tz->ops->get_trip_temp)
-		return -EPERM;
-
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
 		return -EINVAL;
 
-	ret = tz->ops->get_trip_temp(tz, trip, &temperature);
+	mutex_lock(&tz->lock);
+
+	if (!tz->ops) {
+		ret = -EINVAL;
+		goto unlock;
+	}
 
+	if (!tz->ops->get_trip_temp) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
+	ret = tz->ops->get_trip_temp(tz, trip, &temperature);
 	if (ret)
-		return ret;
+		goto unlock;
 
-	return sprintf(buf, "%d\n", temperature);
+	ret = sprintf(buf, "%d\n", temperature);
+
+unlock:
+	mutex_unlock(&tz->lock);
+	return ret;
 }
 
 static ssize_t
@@ -175,15 +216,24 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	int trip, ret;
 	int temperature;
 
-	if (!tz->ops->set_trip_hyst)
-		return -EPERM;
-
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
 		return -EINVAL;
 
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
+
+	if (!tz->ops) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (!tz->ops->set_trip_hyst) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
 	/*
 	 * We are not doing any check on the 'temperature' value
 	 * here. The driver implementing 'set_trip_hyst' has to
@@ -194,6 +244,8 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	if (!ret)
 		thermal_zone_set_trips(tz);
 
+unlock:
+	mutex_unlock(&tz->lock);
 	return ret ? ret : count;
 }
 
@@ -205,14 +257,25 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 	int trip, ret;
 	int temperature;
 
-	if (!tz->ops->get_trip_hyst)
-		return -EPERM;
-
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
+
+	if (!tz->ops) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (!tz->ops->get_trip_hyst) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
 	ret = tz->ops->get_trip_hyst(tz, trip, &temperature);
 
+unlock:
+	mutex_unlock(&tz->lock);
 	return ret ? ret : sprintf(buf, "%d\n", temperature);
 }
 
@@ -260,17 +323,24 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
+
+	if (!tz->ops) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
 	if (!tz->ops->set_emul_temp) {
-		mutex_lock(&tz->lock);
 		tz->emul_temperature = temperature;
-		mutex_unlock(&tz->lock);
 	} else {
 		ret = tz->ops->set_emul_temp(tz, temperature);
 	}
 
 	if (!ret)
-		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
+unlock:
+	mutex_unlock(&tz->lock);
 	return ret ? ret : count;
 }
 static DEVICE_ATTR_WO(emul_temp);
-- 
2.36.2

