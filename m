Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449026A57BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjB1LXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjB1LW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:22:58 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C22DA3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:22:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v16so6526624wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677583369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAtw1U/BTDOrZHgBLIQAFfpKcmyk/l+MkBAEZzxdNlo=;
        b=vVUSFi+bHE1gez+bGnBMUsIOJ/M0sRmZZHuuZZv56KTBUEfP3KgbfDZds399wxHWVi
         L7rnrQODeLDclBWPp+2sfnax1FVupEbgMdfQb7kQW6flA/XEdj4hSJCrIL6SKa7QN/Ai
         CRE8k/qw4pcN64xEE5cr5d15wXFcZbd9SHvH1z0JxkYqVdebvGa9P/UdK5Weo4rBpZqJ
         5waptRF3DKKS4736KUpw/FZhmy28hfPoxktObEQEQrp3RYO2bWFJ2mlYaW184bOtjmCW
         IKlIbaEUfNVXG9qbh9YF2lCyO0GYBmAoWshQ2NDO3XkqYVBrlwgRWkGxaoAnXuWlB1AL
         +S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677583369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAtw1U/BTDOrZHgBLIQAFfpKcmyk/l+MkBAEZzxdNlo=;
        b=k9n6YRbtJwoW8EFVnFCsN6OBP+dzyL9X6jL1fdNd5eyUDVpbvG3698uU8WLHHWdllA
         2jynhm8eagDOIpSrsW2GUHLDqRaZRoilqg4+wJDGCbY4XHGxyOLvV7AeK5obVTQFgRFo
         grpBe2MUG9yJT/+B+MsazHSxToqCyFXC933anyjm8NSBNQdgF6CoC2KoJgTTcZaMRzmA
         6pVWQlXORSDmxkHUH3o+6CxlKMzYU9c3n7uzlBrkZ4PeKCy+fjGoeYkOEvXMT8bFEi8y
         TmSEIJyOyv0nbIvQEtrTK+YI92rYuWkX2cWhGVRg31FlENmXFYHqtogaOXvTPW+oPbNM
         Jp5w==
X-Gm-Message-State: AO0yUKURqnBythqBQaMNIgFaMFDQcSqKSswcaKEif40qN/w2HPjksw1H
        Oj0k6IVCCwGdzh9VX6X+5au2GA==
X-Google-Smtp-Source: AK7set8tfUcUd2ti9tdeNjjRBm6KRnuFrW44BNqqJFPCyXRlq0joTqzXpH9IT2mwnVwO0IgPbhxyEQ==
X-Received: by 2002:adf:ce0a:0:b0:2c7:aed:b97b with SMTP id p10-20020adfce0a000000b002c70aedb97bmr1779397wrn.62.1677583369629;
        Tue, 28 Feb 2023 03:22:49 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6830:6390:2815:b6a5])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6545000000b002c5501a5803sm9598130wrv.65.2023.02.28.03.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:22:49 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v4 01/19] thermal/core: Add a thermal zone 'devdata' accessor
Date:   Tue, 28 Feb 2023 12:22:20 +0100
Message-Id: <20230228112238.2312273-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal zone device structure is exposed to the different drivers
and obviously they access the internals while that should be
restricted to the core thermal code.

In order to self-encapsulate the thermal core code, we need to prevent
the drivers accessing directly the thermal zone structure and provide
accessor functions to deal with.

Provide an accessor to the 'devdata' structure and make use of it in
the different drivers.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/thermal/thermal_core.c | 6 ++++++
 include/linux/thermal.h        | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 0675df54c8e6..9fa12147fead 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1378,6 +1378,12 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type, int n
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_register);
 
+void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
+{
+	return tzd->devdata;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_priv);
+
 /**
  * thermal_zone_device_unregister - removes the registered thermal zone device
  * @tz: the thermal zone device to remove
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 2bb4bf33f4f3..7dbb5712434c 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -365,6 +365,8 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
 					void *, struct thermal_zone_device_ops *,
 					struct thermal_zone_params *, int, int);
 
+void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
+
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
 				     unsigned long, unsigned long,
@@ -436,6 +438,11 @@ static inline int thermal_zone_get_offset(
 		struct thermal_zone_device *tz)
 { return -ENODEV; }
 
+static inline void *thermal_zone_device_priv(struct thermal_zone_device *tz)
+{
+	return NULL;
+}
+
 static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
 { return -ENODEV; }
 
-- 
2.34.1

