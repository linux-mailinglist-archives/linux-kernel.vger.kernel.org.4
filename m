Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428E1600BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiJQKDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiJQKDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:03:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8F35E654
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:03:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so13756861pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4ECXKPxuSi9FlL0YX5UZrOOqChEolMljlUJMvD0OCY=;
        b=gZ22LJbRBZC4XEHPVSBT0gTQZjF75VJEv8GWn/tPZ9gJLtkTAS93CnERDsy63KhCpO
         fqBlcTAGClPK4PI38DBjKM2ZdTRD6g/ara7Joxr8IHwX2ayDURN0t8ozoiZLWgrDWYVu
         Cd+gjDR+XnxcqFrLfLYaIcwNvPhOlixq0wtBd2N+3HZVg8P5jVz3h3jnw8gHkJMhSp0h
         5ZwiR6H1tgEULsQKRFkvvQhcaJNaPI01LsAfrfNn/eIZooJauY3MDG4e9nJON5Yu8TpU
         ztE6G/mggqW0FOOLMwCD2pHmaXEwmzk+ZNdxXryzeQYzWVWAmWmFsNQOhvPfJm7sD637
         xTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4ECXKPxuSi9FlL0YX5UZrOOqChEolMljlUJMvD0OCY=;
        b=d6ocuRW5f5wKMEeEHgakjAsTBeB3gfjGhh+DE7xR0qwi8CsQ5CUXBl0A+zOc3FKXEN
         NTOBvHDK9XYd0in8uJnTKaqNRiKcKI/GMOOUvEN6PkY8xyBeC5YeWPx300PIpyFwmm32
         2D/zf8xF6SrDjGD/HMQAwKF8Z6IJJ1KR7m5tqC/SWyYSNNblB5xtMckrFGbP6dLzRich
         SU+Vb7kqw4hZahuhK1inFvdFtIkKnXTIu1dXwP1k/6xQcm0YhhjNtrtXMkNFJW/K+OfQ
         vQwMzAllsCpkBM2m2lVM6HMxCIcvN4rUC4Ia8RR6/cDJmEYz6BTgOoehCd6zgsXCyRzU
         M0dg==
X-Gm-Message-State: ACrzQf2xTs339m2PLOrJa1/L2UUpFpaTCfkli5CilU5Pe0jLMYqXAhgv
        b2GpfdjqXDvYLG/7Urt3PgFECA==
X-Google-Smtp-Source: AMsMyM4NhfHDJD2hLKC5bLKj3iKelofKvfP4UvUFgTg/zAYNeFiXVx3/ooXoYnq1Agb9vtYfh1gJuw==
X-Received: by 2002:a17:90b:4c0b:b0:20d:8572:ab27 with SMTP id na11-20020a17090b4c0b00b0020d8572ab27mr12633543pjb.193.1666000992367;
        Mon, 17 Oct 2022 03:03:12 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id g8-20020a631108000000b00462612c2699sm5864667pgl.86.2022.10.17.03.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 03:03:11 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thermal: Validate new state in cur_state_store()
Date:   Mon, 17 Oct 2022 15:33:01 +0530
Message-Id: <100e1f814d0d3e20a291e4bfdddabc2c0a4a12f0.1666000867.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1666000867.git.viresh.kumar@linaro.org>
References: <cover.1666000867.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cur_state_store(), the new state of the cooling device is received
from user-space and is not validated by the thermal core but the same is
left for the individual drivers to take care of. Apart from duplicating
the code it leaves possibility for introducing bugs where a driver may
not do it right.

Lets make the thermal core check the new state itself and store the max
value in the cooling device structure.

Link: https://lore.kernel.org/all/Y0ltRJRjO7AkawvE@kili/
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/gov_fair_share.c |  6 +-----
 drivers/thermal/thermal_core.c   | 15 +++++++--------
 drivers/thermal/thermal_sysfs.c  | 11 +++++------
 include/linux/thermal.h          |  1 +
 4 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index a4ee4661e9cc..1cfeac16e7ac 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -49,11 +49,7 @@ static int get_trip_level(struct thermal_zone_device *tz)
 static long get_target_state(struct thermal_zone_device *tz,
 		struct thermal_cooling_device *cdev, int percentage, int level)
 {
-	unsigned long max_state;
-
-	cdev->ops->get_max_state(cdev, &max_state);
-
-	return (long)(percentage * level * max_state) / (100 * tz->num_trips);
+	return (long)(percentage * level * cdev->max_state) / (100 * tz->num_trips);
 }
 
 /**
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 117eeaf7dd24..08de59369e94 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -603,8 +603,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	struct thermal_instance *pos;
 	struct thermal_zone_device *pos1;
 	struct thermal_cooling_device *pos2;
-	unsigned long max_state;
-	int result, ret;
+	int result;
 
 	if (trip >= tz->num_trips || trip < 0)
 		return -EINVAL;
@@ -621,15 +620,11 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	if (tz != pos1 || cdev != pos2)
 		return -EINVAL;
 
-	ret = cdev->ops->get_max_state(cdev, &max_state);
-	if (ret)
-		return ret;
-
 	/* lower default 0, upper default max_state */
 	lower = lower == THERMAL_NO_LIMIT ? 0 : lower;
-	upper = upper == THERMAL_NO_LIMIT ? max_state : upper;
+	upper = upper == THERMAL_NO_LIMIT ? cdev->max_state : upper;
 
-	if (lower > upper || upper > max_state)
+	if (lower > upper || upper > cdev->max_state)
 		return -EINVAL;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
@@ -900,6 +895,10 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->updated = false;
 	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
+
+	if (cdev->ops->get_max_state(cdev, &cdev->max_state))
+		goto out_kfree_type;
+
 	thermal_cooling_device_setup_sysfs(cdev);
 	ret = device_register(&cdev->device);
 	if (ret)
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index ec495c7dff03..bd7596125461 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -589,13 +589,8 @@ static ssize_t max_state_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
-	unsigned long state;
-	int ret;
 
-	ret = cdev->ops->get_max_state(cdev, &state);
-	if (ret)
-		return ret;
-	return sprintf(buf, "%ld\n", state);
+	return sprintf(buf, "%ld\n", cdev->max_state);
 }
 
 static ssize_t cur_state_show(struct device *dev, struct device_attribute *attr,
@@ -625,6 +620,10 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 	if ((long)state < 0)
 		return -EINVAL;
 
+	/* Requested state should be less than max_state + 1 */
+	if (state > cdev->max_state)
+		return -EINVAL;
+
 	mutex_lock(&cdev->lock);
 
 	result = cdev->ops->set_cur_state(cdev, state);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 9ecc128944a1..5e093602e8fc 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -100,6 +100,7 @@ struct thermal_cooling_device_ops {
 struct thermal_cooling_device {
 	int id;
 	char *type;
+	unsigned long max_state;
 	struct device device;
 	struct device_node *np;
 	void *devdata;
-- 
2.31.1.272.g89b43f80a514

