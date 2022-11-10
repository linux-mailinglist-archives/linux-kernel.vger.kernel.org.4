Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254A76245A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiKJPZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiKJPZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:25:36 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A863F047;
        Thu, 10 Nov 2022 07:25:19 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id v81so2138495oie.5;
        Thu, 10 Nov 2022 07:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BP0JS35IGfSl0FVl/KECGclfAmAetA4hJ3SBTMSOqEY=;
        b=K8P/qg9jSQx3oCgYAtr8dQEh/PdPjWLXH7I9sz7vHYpsmm6tPvZjZ2GZodU1BXAga/
         iPWHc8tCLgQpFL9Rq34MMot+WoWC3whB/GF3/bzQWpih5sjjSpD90h7SAplIdkKD50L9
         Lm8EzhYJ8djTH5zjsmGaU5TsUajgq0AeNeoT9kkrfFyLi/NcW9kmCRBVMlfpibdTdEyW
         ZA/2lA5ebJ7pyOjrVbmTsGIVLJ18E6i/KnwudIuE2jbmMZb5PE7pIpK+KCTpDYdlsBr6
         ljlbKpenBWOVclXzyovtd3/cB4NDEH7/e+2akCzXAmnKNLEQWxM6yxrki73TZbBlK2YM
         kDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BP0JS35IGfSl0FVl/KECGclfAmAetA4hJ3SBTMSOqEY=;
        b=2bfCWdYV9/2726VoiciW1ddSH1TUEvJwXuCMFNVVuHlMWrmt3/T+jIxHr56lXNTAmW
         kLKUIe78+Qaidl241avJUz5BVppIk/ecE1DVFmBdJAVmfFw7Ri9Z2zGkkvE+fBfbvEBI
         uVBlfPhBiMNxBcAak4x7n5hQMXDiYkijjK+EgYIwFctqWw5o1aPqDoo/TwN6UIEVsfd+
         A/DUb0xWrSt1OkEaMG6Yiab8WWH1e495gzzXTeFEi9OdMxri96DQKSk1jhkcXGFhnyEZ
         7U+BqXH2NmqzQ594crXRnxUy/Sge15Nn2TyZin+1v1LVDSQWOY4U3e+ua0/T5sedMMXL
         cHgw==
X-Gm-Message-State: ACrzQf1FXsnS3oNTmxNYniB1Dg6l4JS+Ycd8LLHLndxY4bSzPR0s8DOU
        5at+FRpVrErC11TbM560wwM=
X-Google-Smtp-Source: AMsMyM4ALT7azm9LloYY+w3ZHd6eKphnx17+3DYjAR8KyC24UtynF/axw+inDJ/wgWRwji6lBWgvYQ==
X-Received: by 2002:a54:410e:0:b0:35a:5a4b:a836 with SMTP id l14-20020a54410e000000b0035a5a4ba836mr17076466oic.95.1668093918430;
        Thu, 10 Nov 2022 07:25:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x34-20020a056870b42200b0013d7fffbc3csm7651353oap.58.2022.11.10.07.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:25:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 9/9] thermal/core: Protect thermal device operations against thermal device removal
Date:   Thu, 10 Nov 2022 07:25:00 -0800
Message-Id: <20221110152500.3032655-10-linux@roeck-us.net>
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

Thermal device operations may be called after thermal zone device removal.
After thermal zone device removal, thermal zone device operations must
no longer be called. To prevent such calls from happening, ensure that
the thermal device is registered before executing any thermal device
operations.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Fixed spelling error in description

 drivers/thermal/thermal_core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b8e3b262b2bd..aa0107f11c98 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -203,6 +203,9 @@ int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
 	mutex_lock(&thermal_governor_lock);
 	mutex_lock(&tz->lock);
 
+	if (!device_is_registered(&tz->device))
+		goto exit;
+
 	gov = __find_governor(strim(policy));
 	if (!gov)
 		goto exit;
@@ -445,6 +448,12 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 		return ret;
 	}
 
+	if (!device_is_registered(&tz->device)) {
+		mutex_unlock(&tz->lock);
+
+		return -ENODEV;
+	}
+
 	if (tz->ops->change_mode)
 		ret = tz->ops->change_mode(tz, mode);
 
@@ -486,7 +495,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 				enum thermal_notify_event event)
 {
 	mutex_lock(&tz->lock);
-	__thermal_zone_device_update(tz, event);
+	if (device_is_registered(&tz->device))
+		__thermal_zone_device_update(tz, event);
 	mutex_unlock(&tz->lock);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
-- 
2.36.2

