Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1738B6A34E7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBZWyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBZWyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:54:37 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302E8EF94
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:54:24 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bx12so1258979wrb.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAtw1U/BTDOrZHgBLIQAFfpKcmyk/l+MkBAEZzxdNlo=;
        b=O1nUAvNuzXyl2MlL+QjZlnWfvovXA7TLZNj3oxW25yIo3NprmRry63nVZKcYm8NzHy
         mWrRId1xU+OTYEIlg2jJ33vtpZKKi75k25g4/QMs0gAUFibDANMCgzkJWt6XrE3HpQVn
         ZqMUWVdx8Gwgpw64fto+TOSGjM+P9k2+s3IbYTPD8UCCdFLqqazB/a7FW6ftCfV9nD3V
         mbwaaAevY6xE+QyV9E0AJ/6caP2v5hapVCQrLDOfEbOXNOgyFWm934ynQ/CSHPW7o7DL
         nulbVxtnjO7+Bec8DszgArZiUvG00pp0A9MK9aBNsf1tC7Omr1iGiCegNqELN3gWsE9f
         rvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAtw1U/BTDOrZHgBLIQAFfpKcmyk/l+MkBAEZzxdNlo=;
        b=gS/0bwQa2czfwPd04IMdzP3NnxadrUwgAQmVhgsz9OMsluv7UZLsM3XnUw5y9cQ/bQ
         /qcRFsWTQUiB/3A08PD4xqL9T9XPGOhapVBFsQWyyFWa1+mjPHWJ2Rv73B4yeVhSYgL3
         e5Tky5zaNPn1QYJUCCTxzar34wyiV+E1wO9ZOimF7anDIEsYn1w+ZB4xCOxq0tKjPWy2
         pIb3HI/WIUu09aZA/vgVWzN7oRSLY1j+Mv2YFI+1gnS59vMSyaeVaL3ozFaXMKe6ZGNw
         cYKamomEx8O5snIjMHFba6Ka52v5+5E/Ye0/dgOjxJgTUb6N7CV9hrsJfIp7mFCz8iaJ
         MKBA==
X-Gm-Message-State: AO0yUKVPhCzvhw5RmV6vSOUZRmpHRX5JHXER+QOr8V2/UPClntzJGvGJ
        lMN/pYN4IE/Y92fqsJee0FQXMw==
X-Google-Smtp-Source: AK7set/3C4mSSF5HU8TY5ZnOFtp4m9CKt8hVMVXWuRfpgf+jQBgetZWxyajbmGv8FANooBaQNp5ahQ==
X-Received: by 2002:adf:f5d2:0:b0:2c7:bbe:456e with SMTP id k18-20020adff5d2000000b002c70bbe456emr12321845wrp.56.1677452062545;
        Sun, 26 Feb 2023 14:54:22 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003eb369abd92sm6138074wms.2.2023.02.26.14.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:54:22 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 01/20] thermal/core: Add a thermal zone 'devdata' accessor
Date:   Sun, 26 Feb 2023 23:53:47 +0100
Message-Id: <20230226225406.979703-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226225406.979703-1-daniel.lezcano@linaro.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
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

