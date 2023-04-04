Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA9F6D5A00
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjDDHv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjDDHv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:51:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F36A1987
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 00:51:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e18so31760423wra.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680594713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFvRLhngTFwxCndBYKnLhBjEwWc0V3/dOnfK/S5B9Y0=;
        b=u0JxvO1sP+n7h4WyeR6ljLwFEPkS2vuMVXIaSoKYbj1xlkfLpAMW0wGhroLeuG+BOV
         OLKXK3aB68MQJ2f5NXwj6Y09rI+Lery4AYdd8Jtv027xE5L3ioffli6xH03rx/hpc5fL
         t39pRnGUxjBN2AcD6n3JMD5BgZvOFoXldcjjkqv+zgvqiTab/+7XPD/4KeshFFwR75Yy
         /E/hoFyH7fT9J19PGaWkIlUGDvySlrpbvM24vpc3xDUfV4gP6Y8naRYnuf6Nke6Bwm1K
         fIqD0O1nU1aPoAZ8vm2zCyFoyBexjKKnJziRp3+MctahMcQul6LpWjADxF3szXh2sSgu
         sH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680594713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFvRLhngTFwxCndBYKnLhBjEwWc0V3/dOnfK/S5B9Y0=;
        b=yt/530xV/Z1Xje5C+z5HBU3IyPSy+uh8zI77+dLirgRosY0xTuyN0jOzHeJquR47xx
         BkdzlEl9zEVhWRIQckl62dMiBd1PQrDYwfKXUxs78vD/3EEYUxliE82c2gLaF70U8gw+
         B+BvulLodN9eBO5xlAvQ07V4DjTxkwQkPHN4I8b37SbhOF6Vt8wEs5WyGYx/IcVlMWIL
         n6s5i1wMhOito9SkG4+nBt1Iw0/WowOK/V6+I49RDoGc0slGOXBQgK33GHqbnyeIs0n7
         ty06u5ApBv+FZdny5lcI82BFoZiiJ8BnBgk3X1VDMOMaZWHiJtNNOU2JarHV0KYIN+nO
         HScw==
X-Gm-Message-State: AAQBX9fFijRh9O8gIfAx3CQdFOY/l96qJrSDEim3aLjlCynglg4dy/+0
        RAZpevou9oIiObCFMtWDFYRYOQ==
X-Google-Smtp-Source: AKy350YZZhXDp2mXjdnPadGvXRf/NqdHNtmc//rj+7wf8rZdqfiQtYJADyGmyu8GT0Xu6+HfRbG11A==
X-Received: by 2002:a5d:400a:0:b0:2d8:97c7:713d with SMTP id n10-20020a5d400a000000b002d897c7713dmr813559wrp.38.1680594713477;
        Tue, 04 Apr 2023 00:51:53 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9754:a4ba:a0f5:8937])
        by smtp.gmail.com with ESMTPSA id r13-20020adff10d000000b002e45f6ffe63sm11591561wro.26.2023.04.04.00.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 00:51:53 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 3/3] thermal/core: Alloc-copy-free the thermal zone parameters structure
Date:   Tue,  4 Apr 2023 09:51:37 +0200
Message-Id: <20230404075138.2914680-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404075138.2914680-1-daniel.lezcano@linaro.org>
References: <20230404075138.2914680-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
  V2:
    - Fixed 'result' uninitialized on the error path
---
 drivers/thermal/thermal_core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 8196d35f4c08..518b87cddaeb 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1170,13 +1170,21 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	if (!tz)
 		return ERR_PTR(-ENOMEM);
 
+	if (tzp) {
+		tz->tzp = kmemdup(tzp, sizeof(*tzp), GFP_KERNEL);
+		if (!tz->tzp) {
+			result = -ENOMEM;
+			goto free_tz;
+		}
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
@@ -1186,7 +1194,6 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 		ops->critical = thermal_zone_device_critical;
 
 	tz->ops = ops;
-	tz->tzp = tzp;
 	tz->device.class = thermal_class;
 	tz->devdata = devdata;
 	tz->trips = trips;
@@ -1284,6 +1291,8 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	tz = NULL;
 remove_id:
 	ida_free(&thermal_tz_ida, id);
+free_tzp:
+	kfree(tz->tzp);
 free_tz:
 	kfree(tz);
 	return ERR_PTR(result);
@@ -1364,6 +1373,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	device_del(&tz->device);
 	mutex_unlock(&tz->lock);
 
+	kfree(tz->tzp);
+
 	put_device(&tz->device);
 
 	thermal_notify_tz_delete(tz_id);
-- 
2.34.1

