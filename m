Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F86069E710
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjBUSJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjBUSIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:08:36 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E902A2DE64
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:07:59 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t13so5346914wrv.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ezEc6A/YkeOfDdMrb507e1ylDVbi788yh7gKtVJ50s=;
        b=nAitZ675oyeRfothdhY716BmMpAt/3sxWyhpoECXSKhzfcK2UvMI+8cnRaM09PSRj4
         2cUkKVuLGiH0L8ma/SmOPafi0wBzPojeOa98H7dAtvD3budEf5axe0rB+y3+bdsTYs0z
         YeNWicN8lH4I6d3FW5pd5YjUyqVCnLXP9lpIQMFCt61o1bDRrydXmvufHJcgLNFxMqzA
         aIxoSFLfzQCX4KfIQR2Jfk/8uoN7RKR2AE0adv1kQeU2cZkjHNl7PBzoQ4SvEGws9FSJ
         wQuz80m72XXyzlJSh77Vdo6ZMEn3PNILXcCruw53RJRlA41kHy1FYqJU7Ih5NGZRWpoB
         TJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ezEc6A/YkeOfDdMrb507e1ylDVbi788yh7gKtVJ50s=;
        b=aEKUlf+Oq2byF/qJt+5QTvSNEtaR8e+CTvTfkL20ZgjFawb8X9kiGxO9W/vDrESd8E
         yXJ+3b0IVyEdvrNwzROs6W7Cd82kagGIVIhO+ZG78/t1czJwYayLgzq/hdBRIKhttjEc
         b1ovajdMfgoRrgUAwR90z3PlQoPMmbaCvGzBHZMPN09BAHwt59DRbYTPAM0fuwLaeTyD
         MzuRqBir31ihPq8Ll7V+IKGBx0td90CShQYZSyBkB1tBMJFwFxQbnpHZYuI7PqBqg4hi
         jgJhQbotx5spE4S/HxgnNfwuO1dpPKm0pL/6B54sOJK2bZU/7kwYuD+M4q4MzD2YtXf9
         49Xg==
X-Gm-Message-State: AO0yUKVaLmyPsKcJRafBikW7FPrKbf0bBOnzx2jo/B8HSsw0TgaQ5K98
        ZcWclgq/chHggQoXQkN3XYPeiQ==
X-Google-Smtp-Source: AK7set/soV5ezaxbxiC0k21pKqAsgpfGS7RZe3hvloq6lIpLm1euGOya3NW90+JTLW4f9jqnRMIn9w==
X-Received: by 2002:a5d:5945:0:b0:2c5:5c00:b917 with SMTP id e5-20020a5d5945000000b002c55c00b917mr3293354wri.0.1677002878283;
        Tue, 21 Feb 2023 10:07:58 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1e9:315c:bb40:e382])
        by smtp.gmail.com with ESMTPSA id c128-20020a1c3586000000b003e21558ee9dsm5107815wma.2.2023.02.21.10.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:07:57 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v2 08/16] thermal: Add a thermal zone id accessor
Date:   Tue, 21 Feb 2023 19:07:02 +0100
Message-Id: <20230221180710.2781027-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
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

In order to get the thermal zone id but without directly accessing the
thermal zone device structure, add an accessor.

Use the accessor from the hwmon_scmi

No functional change intented.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/scmi-hwmon.c     | 2 +-
 drivers/thermal/thermal_core.c | 6 ++++++
 include/linux/thermal.h        | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 046ac157749d..6681478ea41c 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -220,7 +220,7 @@ static int scmi_thermal_sensor_register(struct device *dev,
 			sensor->name);
 	} else {
 		dev_dbg(dev, "Sensor '%s' attached to thermal zone ID:%d\n",
-			sensor->name, tzd->id);
+			sensor->name, thermal_zone_device_get_id(tzd));
 	}
 
 	return 0;
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9fa12147fead..73b7a060f768 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1384,6 +1384,12 @@ void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_priv);
 
+int thermal_zone_device_get_id(struct thermal_zone_device *tzd)
+{
+	return tzd->id;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_get_id);
+
 /**
  * thermal_zone_device_unregister - removes the registered thermal zone device
  * @tz: the thermal zone device to remove
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 7dbb5712434c..321aa3c71f58 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -367,6 +367,8 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
 
+int thermal_zone_device_get_id(struct thermal_zone_device *tzd);
+
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
 				     unsigned long, unsigned long,
-- 
2.34.1

