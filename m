Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B4C62459D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiKJPZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiKJPZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:25:13 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53AA326E8;
        Thu, 10 Nov 2022 07:25:12 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id d26-20020a05683018fa00b0066ab705617aso1268805otf.13;
        Thu, 10 Nov 2022 07:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LM2EPhN1nhlDPDS4PEgysbO7FCLJZz7jFfUt9dT+ukM=;
        b=PgDgYUHnijUqOXnXpT2/400UFKTQ2AaTUgtzXeMT3PswiE8/2oTCtsKorY6+xea5ES
         5Uhmi/pR6TKGj8ZtAD91itVcvoYRc3WWfOcAHHXkYwmgeMmx/4fZ17LOU0L5/H1iGE+O
         KaSDA9qDafA6F9FYpPzXsCQnczCFoTHZvRW20YEWR1NIXkN6fUKO2bkPB9ReWOenhS7m
         AkvjxkFjNr+Z3ZMLoZ6aQraaqZTaHGEibAGSsGe21W1apY51SKhj9D4SpP3fJa/OxQBX
         Z14AZyMoTSpcBKGSj7iU9f0qh5CdnbJjF+4/inRcQEP7x+MXQdNPm1YHL4u2RkZyD2yj
         AtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LM2EPhN1nhlDPDS4PEgysbO7FCLJZz7jFfUt9dT+ukM=;
        b=LllgMUoppPo6HqRqdAADXiGQSi2Vj1uFy7MtkdXWj/yoAjBhvt3x/LOoH8UnQT1txP
         1JEkKxDJmQK76s6TS3C8Z8rXxcNP5PS1W5cY5l1V7pShqweymUhPW7lqTlEXB8fnsGiu
         FjU7T7bGV2Ic9JMnk4+Xm8KA7o453bvBJAbsMUsSlqFaGXihn/lMT2H9eFQHFVzCDWAP
         owh+99sBFzfVBTiJqN4Y6e0fCGR1ufcWKKx0CuCj7dDhtCP74jvd/lU7WUYA57wtc/VM
         s7kwi0n3hz/lnYZnRefbhbeRdgJPu8ckz/uG4egtAiVI0jOUudAC7WhvJ0S3nRU/UxeJ
         eJ9Q==
X-Gm-Message-State: ACrzQf30ALp1NX6u58W3nL7uXHrBwU6vN53ueWLN3oC8dr3bcxF5qT20
        cC0i4SAgNnFaHeNsAvHM8MA=
X-Google-Smtp-Source: AMsMyM7uSC3JNSbqyegGtf/DgnaTDyxILC5S7kqEVrO/qFIHQXkGY1Wdy8+kjUkjtUJs+CdeBmlnUw==
X-Received: by 2002:a05:6830:832:b0:66c:a704:f987 with SMTP id t18-20020a056830083200b0066ca704f987mr11957357ots.89.1668093911953;
        Thu, 10 Nov 2022 07:25:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x34-20020a056870b42200b0013d7fffbc3csm7651214oap.58.2022.11.10.07.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:25:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 5/9] thermal/core: Introduce locked version of thermal_zone_device_update
Date:   Thu, 10 Nov 2022 07:24:56 -0800
Message-Id: <20221110152500.3032655-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <20221110152500.3032655-1-linux@roeck-us.net>
References: <20221110152500.3032655-1-linux@roeck-us.net>
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

In thermal_zone_device_set_mode(), the thermal zone mutex is released only
to be reacquired in the subsequent call to thermal_zone_device_update().

Introduce __thermal_zone_device_update(), which is similar to
thermal_zone_device_update() but has to be called with the thermal device
mutex held. Call the new function from thermal_zone_device_set_mode()
to avoid the extra thermal device mutex release/acquire sequence in that
function.

With the new function in place, re-implement thermal_zone_device_update()
as wrapper around __thermal_zone_device_update() to acquire and release
the thermal device mutex.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Reword description to clarify that the new function must be called with
    thermal device mutex held.

 drivers/thermal/thermal_core.c | 57 ++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 562ece8d16aa..9facd9c5b70f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -403,6 +403,34 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 		pos->initialized = false;
 }
 
+static void __thermal_zone_device_update(struct thermal_zone_device *tz,
+					 enum thermal_notify_event event)
+{
+	int count;
+
+	if (atomic_read(&in_suspend))
+		return;
+
+	if (WARN_ONCE(!tz->ops->get_temp,
+		      "'%s' must not be called without 'get_temp' ops set\n",
+		      __func__))
+		return;
+
+	if (!thermal_zone_device_is_enabled(tz))
+		return;
+
+	update_temperature(tz);
+
+	__thermal_zone_set_trips(tz);
+
+	tz->notify_event = event;
+
+	for (count = 0; count < tz->num_trips; count++)
+		handle_thermal_trip(tz, count);
+
+	monitor_thermal_zone(tz);
+}
+
 static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 					enum thermal_device_mode mode)
 {
@@ -423,9 +451,9 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 	if (!ret)
 		tz->mode = mode;
 
-	mutex_unlock(&tz->lock);
+	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	mutex_unlock(&tz->lock);
 
 	if (mode == THERMAL_DEVICE_ENABLED)
 		thermal_notify_tz_enable(tz->id);
@@ -457,31 +485,8 @@ int thermal_zone_device_is_enabled(struct thermal_zone_device *tz)
 void thermal_zone_device_update(struct thermal_zone_device *tz,
 				enum thermal_notify_event event)
 {
-	int count;
-
-	if (atomic_read(&in_suspend))
-		return;
-
-	if (WARN_ONCE(!tz->ops->get_temp, "'%s' must not be called without "
-		      "'get_temp' ops set\n", __func__))
-		return;
-
 	mutex_lock(&tz->lock);
-
-	if (!thermal_zone_device_is_enabled(tz))
-		goto out;
-
-	update_temperature(tz);
-
-	__thermal_zone_set_trips(tz);
-
-	tz->notify_event = event;
-
-	for (count = 0; count < tz->num_trips; count++)
-		handle_thermal_trip(tz, count);
-
-	monitor_thermal_zone(tz);
-out:
+	__thermal_zone_device_update(tz, event);
 	mutex_unlock(&tz->lock);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
-- 
2.36.2

