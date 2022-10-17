Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80585600FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJQNJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJQNJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:09:38 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C911E62C4;
        Mon, 17 Oct 2022 06:09:26 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-132af5e5543so13141342fac.8;
        Mon, 17 Oct 2022 06:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4d3iRvEV+6jWxwqm/UWU+ztirujQ1MGfWO9XCWvtifk=;
        b=hm6rxDSSYxzO0a7hrOC7v4Ok5SEm+QWP+XI1IsRXjCV6wH1ynzDJqgg0TpW9LptWMP
         80ZHFQjmIi8oYZFFf0IDAWmo6T1ABd4DC0Dz9npefYtgS1Q46VQnFWZr8DxaoSUWKH4G
         JCxDystIiiUltocG1kYOoazhiz7tnJGIQkcA3S+ML9cDts9BFMl6VtsNfA0iMLLey3jB
         jA7IhIQhMLMQiRgrLZedVCRr/92xzTbWbWDc1ln3lKlMh0pMG0bJpmksuduvBYblu2NV
         JPyC2A7Nmkly3dzRXdYGcRUOobLPnbGyGRjM0UAPGkOJbU6z1hK+yY9y1u0jUaD1tsB9
         iqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4d3iRvEV+6jWxwqm/UWU+ztirujQ1MGfWO9XCWvtifk=;
        b=pCcWd5i8HZPVUPYnElrO8rtFZRoiQo4r/+s9dXIaGbQPfDZ8xOAGjNnfsqwoU+1bKA
         TVaF1HgyWuZhFTxZspTPw93Mqj77tDbBkLOMR7txILX7SWPFSDpHY9Sbg/3KPePjKSw2
         MxOBt/mm25SLHLWs9SbSOk0FJs8yz1HGRRwZH/903qIv7J2s/6MnFg+J1NHHFdlC3GP5
         FxWYuinu3QCbnPkdmql0/Npyr8Vulc/L9laoN6pnvqE9RxwcdvKDIMKlcUjgMIgFyYYk
         z9qYFQ2ZUcRLS5a6GbAJjgFkssiSppOAJGbL0GjD3BgdIvZoSzSQLP+gJy90NJnEakpb
         9+xw==
X-Gm-Message-State: ACrzQf0Ry+KsicCie8TP4/YYN6v9oEAugeWrIqvqhhI4xfjjUQW56pc/
        SnG1Q7S84zr090oNDaOFDSQ=
X-Google-Smtp-Source: AMsMyM4WmoXA6Qn3gkEqm581mJkJWOVYDNiT9ejL/XJSEPZjAUctjIYvbxesvQmI3DBtlFxi4NppYw==
X-Received: by 2002:a05:6870:f704:b0:132:9901:df2 with SMTP id ej4-20020a056870f70400b0013299010df2mr5451032oab.278.1666012165087;
        Mon, 17 Oct 2022 06:09:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u7-20020a4aa347000000b00480646ecd45sm4128567ool.48.2022.10.17.06.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:09:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 8/9] thermal/core: Remove thermal_zone_set_trips()
Date:   Mon, 17 Oct 2022 06:09:09 -0700
Message-Id: <20221017130910.2307118-9-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <20221017130910.2307118-1-linux@roeck-us.net>
References: <20221017130910.2307118-1-linux@roeck-us.net>
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
index 0161d5fb1cf2..02b353c8d9aa 100644
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

