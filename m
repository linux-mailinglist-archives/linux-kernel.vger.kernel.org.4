Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B806AE0D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjCGNi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjCGNiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:38:12 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6C93E0B8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:38:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id l25so12166030wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678196284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8U/QSyAheawCOnLmWTGKUDR8tl2aMMA2m4dtkvqkUZc=;
        b=GR6ZQlXqA5cqbeBm2gQcshttPTPWd+AO20+ha+UgpBnbdoF57VHEazFHgSYJbPDU7h
         jbJKY7pNig8f1vgtG5FHV7ImJRpzSHWX9XGcBv2zacGJDfGl0h0f7/47LutUsYIfiK6x
         jqQiM3SCII7ftweKSw2deYgPSj7CfP6cs82rGAgVQWVwcQYXbGwYzCS6orzKGRK9CsxW
         0/KpHJXqXSaqZ2NRrumfb5XowjkTAdqEgpM8ApxlZrPCG8lodXqqoNSOskqX8n+DCJgH
         YX1wsWuEkmda/NWDY8dYOn4EJcAt6mLtao7N/IYPFmZwBVSXNe1BTjnml4WooEhfTJrv
         8Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8U/QSyAheawCOnLmWTGKUDR8tl2aMMA2m4dtkvqkUZc=;
        b=GydMsR0X4kybcYwWZOABcv97iOnbncc0VT43OD1h+K6gZiJ4eqYVQsTAt1NVg1oiEM
         jrBYlxLbQ4iUhq1+qgJL/cTW6WNeH9sU7xsTRLNVSIBUuJrMfuC5Jp6kQ2PX2NuJOhIE
         pzJK4eik7e+3pegVnxVZy7vfQhIaEifCWKpl++X/TlvEV4/6MBdcTISt3ucN3UPV6Cqf
         SbTpEzfAXEpbNxkMgsks/NLan6vFtXf79n/IjcrZnGTLrNuAitD9hL9TGB7fNyG8wEzs
         Uo0hYYv/UF/89TgRt3FoeJDjLDr42VNM9TUp1Afu+uMYR0ApbnfcXZ3CEe1X5fZ128Jb
         ZlGQ==
X-Gm-Message-State: AO0yUKWwLJk4kBC+qvVo/m/knkAi/li1R+9NXQMYncduXMyqZ+YaU31I
        qplfY+xXKQtlJP6JmOVW03bemA==
X-Google-Smtp-Source: AK7set8oVcooSVgCWWdmxDWpuyEd2Z3jvnRJ2CeM+7+8qMqBJQHNlAg09K5E7c9EClzqOD8fHohQ1Q==
X-Received: by 2002:adf:e74a:0:b0:2c7:efb:dded with SMTP id c10-20020adfe74a000000b002c70efbddedmr10591530wrn.24.1678196284325;
        Tue, 07 Mar 2023 05:38:04 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5ab9:1ac6:870d:35c])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b002c55de1c72bsm12311477wrr.62.2023.03.07.05.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:38:04 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 10/11] thermal/core: Alloc-copy-free the thermal zone parameters structure
Date:   Tue,  7 Mar 2023 14:37:34 +0100
Message-Id: <20230307133735.90772-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133735.90772-1-daniel.lezcano@linaro.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The caller of the function thermal_zone_device_register_with_trips()
can pass a thermal_zone_params structure parameter.

This one is used by the thermal core code until the thermal zone is
destroyed. That forces the caller, so the driver, to keep the pointer
valid until it unregisters the thermal zone if we want to make the
thermal zone device structure private the core code.

As the thermal zone device structure would be private, the driver can
not access to thermal zone device structure to retrieve the tzp field
after it passed it to register the thermal zone.

So instead of forcing the users of the function to deal with the tzp
structure life cycle, make the usage easier by allocating our own
thermal zone params, copying the parameter content and by freeing at
unregister time. The user can then create the parameters on the stack,
pass it to the registering function and forget about it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index ca91189bc441..6cbda8f4522e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1263,13 +1263,19 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	if (!tz)
 		return ERR_PTR(-ENOMEM);
 
+	if (tzp) {
+		tz->tzp = kmemdup(tzp, sizeof(*tzp), GFP_KERNEL);
+		if (!tz->tzp)
+			goto free_tz;
+	}
+	
 	INIT_LIST_HEAD(&tz->thermal_instances);
 	ida_init(&tz->ida);
 	mutex_init(&tz->lock);
 	id = ida_alloc(&thermal_tz_ida, GFP_KERNEL);
 	if (id < 0) {
 		result = id;
-		goto free_tz;
+		goto free_tzp;
 	}
 
 	tz->id = id;
@@ -1279,7 +1285,6 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 		ops->critical = thermal_zone_device_critical;
 
 	tz->ops = ops;
-	tz->tzp = tzp;
 	tz->device.class = thermal_class;
 	tz->devdata = devdata;
 	tz->trips = trips;
@@ -1377,6 +1382,8 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	tz = NULL;
 remove_id:
 	ida_free(&thermal_tz_ida, id);
+free_tzp:
+	kfree(tz->tzp);
 free_tz:
 	kfree(tz);
 	return ERR_PTR(result);
@@ -1472,6 +1479,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	device_del(&tz->device);
 	mutex_unlock(&tz->lock);
 
+	kfree(tzp);
+	
 	put_device(&tz->device);
 
 	thermal_notify_tz_delete(tz_id);
-- 
2.34.1

