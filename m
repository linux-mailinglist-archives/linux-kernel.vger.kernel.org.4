Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4106245A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiKJPZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiKJPZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:25:33 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8FD3E0B5;
        Thu, 10 Nov 2022 07:25:17 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46-20020a9d0631000000b00666823da25fso1324917otn.0;
        Thu, 10 Nov 2022 07:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmjCJ069G5ZA0ck/PetkxKT25fldp2oH5LB83pWLxGg=;
        b=pq817FLfAn/Vc+Gbr+dri0aLEbm7xOXgkMHfcYwLZWDsOkLu6cXfGVRcxqTpN/DjPd
         kPgHYrUrrkMbgofm0bOpmslcKQjl27DfROxRDRPLmqszVVDoFXS5/9vlzwROSVEPFgOi
         T+XnIY8JxHd1NTEMuao9sVo4VwLBUw54N6YJ1UV7FQa9YkJuMYoX+O9bQBm1GwMPyCWi
         l4/YccSnq8KydeqH+40CIICdYCQQKfo7YWbTjpT/cM9mMRtKU7DHeSjuxTi9TUKwSjlj
         wp95dLPLLXDtv/b9uOKVyu5EZS2ZYhwP1z4zoCfApIBN7DwhbHYLgBDgnVG+hK0UjOJp
         XzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GmjCJ069G5ZA0ck/PetkxKT25fldp2oH5LB83pWLxGg=;
        b=bAzYPUA5lXbeHvziD9Z3ACiEt9mkMkht+u+AV38HsN1++ofaSU7R8k3ICSqfWouLn9
         UjHIiy300zCF3kFGZj6Igrv3bTced4eDPdhGQa9cI3wKviQjc0Dv6PaatAJF36HUgW3h
         pKDrspaT0hyn9QjBzjABo0xMno7PgSxxEXHXdZENIHkp11xHarBYNK22jg2LdSwXGcbc
         p4/dP5xYGiOvE2CO+W9u1jrRaF8ZYaohJrTzbXGQi294sCsQg7KAFM3Cg+uXjfxabDna
         m+SQsy1RGDFCvWMY7lqcFtd25zsm4Nij5+NY0iruXCKsD4Ag1CBxnZaDry6NBq0pfM2P
         Zsbw==
X-Gm-Message-State: ACrzQf0ukJUhbB6SlsHUW2GE/rVw5Ituz6+wAvgwSEhJNIKePSMVEqM5
        pJR9x+P7xxewnKvASDjkyto=
X-Google-Smtp-Source: AMsMyM7Cpy8eu01F6zW9zK8OBu5c/uNTzlGJaHmX7bjgdoQWsygkrOlz0VJ6lDBiKrdfTuJmcR/vcA==
X-Received: by 2002:a05:6830:12:b0:66c:74a0:beeb with SMTP id c18-20020a056830001200b0066c74a0beebmr20826692otp.70.1668093916976;
        Thu, 10 Nov 2022 07:25:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f1-20020a056830204100b006619483182csm6454623otp.18.2022.11.10.07.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:25:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 8/9] thermal/core: Remove thermal_zone_set_trips()
Date:   Thu, 10 Nov 2022 07:24:59 -0800
Message-Id: <20221110152500.3032655-9-linux@roeck-us.net>
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

Since no callers of thermal_zone_set_trips() are left, remove the function.
Document __thermal_zone_set_trips() instead. Explicitly state that the
thermal zone lock must be held when calling the function, and that the
pointer to the thermal zone must be valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No change

 drivers/thermal/thermal_core.h    |  1 -
 drivers/thermal/thermal_helpers.c | 34 ++++++++++++++-----------------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 7b51b9a22e7e..b834cb273429 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -113,7 +113,6 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event);
 
 /* Helpers */
-void thermal_zone_set_trips(struct thermal_zone_device *tz);
 void __thermal_zone_set_trips(struct thermal_zone_device *tz);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 321f8020082d..56aa2e88f34f 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -147,6 +147,21 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
+/**
+ * __thermal_zone_set_trips - Computes the next trip points for the driver
+ * @tz: a pointer to a thermal zone device structure
+ *
+ * The function computes the next temperature boundaries by browsing
+ * the trip points. The result is the closer low and high trip points
+ * to the current temperature. These values are passed to the backend
+ * driver to let it set its own notification mechanism (usually an
+ * interrupt).
+ *
+ * This function must be called with tz->lock held. Both tz and tz->ops
+ * must be valid pointers.
+ *
+ * It does not return a value
+ */
 void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 {
 	int low = -INT_MAX;
@@ -193,25 +208,6 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
 }
 
-/**
- * thermal_zone_set_trips - Computes the next trip points for the driver
- * @tz: a pointer to a thermal zone device structure
- *
- * The function computes the next temperature boundaries by browsing
- * the trip points. The result is the closer low and high trip points
- * to the current temperature. These values are passed to the backend
- * driver to let it set its own notification mechanism (usually an
- * interrupt).
- *
- * It does not return a value
- */
-void thermal_zone_set_trips(struct thermal_zone_device *tz)
-{
-	mutex_lock(&tz->lock);
-	__thermal_zone_set_trips(tz);
-	mutex_unlock(&tz->lock);
-}
-
 static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
 				       int target)
 {
-- 
2.36.2

