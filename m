Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B069C0E9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjBSOjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjBSOic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:38:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6760DE07A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:05 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id f12so575917wrr.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUidYE45QqwOhchUylILIXryDttVbD/LiMI/qWiuEu8=;
        b=KMWO2e3ra8asZTCibq/TH0eh7yyXfQ/YpoTRU80N0n+d0l1k2YieFdRnLov2a1lD+f
         pYGa1g8dRdYqeuE8QIphlV062WcX+/v7eVls9O6lwGYxNEGCfV4WV/NkBU6riCjti6Wn
         FvNQoVwUD/SaACi6sCZlaPerYy/dkGEaHqahaO9f7T4t8ABwoMNC3f1b4A1vvgcIdmXT
         8qypKIkD250DbpW9hMnzb3QfgGNls2A9pR3Y7O2Ee9tFkQJ7iiC2zRlKDYNpp5RMF1bj
         t2Pnf8ABI8ongOk0YJb9VInvHZRUJA99Fe6Jml6lFyaOqupVdoVbPCxVSZPUb3U8XjGZ
         2LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUidYE45QqwOhchUylILIXryDttVbD/LiMI/qWiuEu8=;
        b=3XpPkqVw6CFt/bB0BWY7d0Q3SNo1JeeGTWD3MDNSXphp2MlL7KYzTGeGyz5NwAMskY
         vAmCmWINImvwgdwVkpBaD4aOJoeARUj3BPdoof+Cg/2ESR2mDli8Wmj/DCM2ZHTDAPli
         fHQIjGBLMJrCrft3vZXsoH0bPMW8ZCOBiALPOnmq3VzvxJtM42+FUITiKDbLepr14cm9
         1hvNJxQcNMPz4yYUFPnTWv4wQK/CqcWune6ejLXrGXggfmRa4b3gaOtqFXBEFx6CBU51
         i2KrTYJk2AS8UI0cyw7LBwKEQW1ZhWXDEqSEllXcENO/8BaPDslzLWsoP82rjUYaFpuK
         Lvnw==
X-Gm-Message-State: AO0yUKXSuvzENcs/ctv2hCVM5LqO/16atWawnmnOaCok55L/4pHeBXFf
        ZTJSAIoJfvry7qOvK2OiulxeZw==
X-Google-Smtp-Source: AK7set9w+7iiWDGO75K4JsSY4vO06kP6rHS6Z9k1cw1W21gUqqD5eXplNGWx5/wK5+dYmg72sRyyVw==
X-Received: by 2002:a5d:6b8e:0:b0:2bf:d333:219d with SMTP id n14-20020a5d6b8e000000b002bfd333219dmr1937123wrx.17.1676817484948;
        Sun, 19 Feb 2023 06:38:04 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6f43:b92:7670:463])
        by smtp.gmail.com with ESMTPSA id a18-20020adfe5d2000000b002be505ab59asm86176wrn.97.2023.02.19.06.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 06:38:04 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v1 09/17] thermal: Add a thermal zone id accessor
Date:   Sun, 19 Feb 2023 15:36:49 +0100
Message-Id: <20230219143657.241542-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230219143657.241542-1-daniel.lezcano@linaro.org>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
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

In order to get the thermal zone id but without directly accessing the
thermal zone device structure, add an accessor.

Use the accessor from the hwmon_scmi

No functional change intented.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/hwmon/scmi-hwmon.c     | 2 +-
 drivers/thermal/thermal_core.c | 6 ++++++
 include/linux/thermal.h        | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 7951b6026f48..036b56a535c1 100644
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
index 05e5a6bda695..e06c76b38c04 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1384,6 +1384,12 @@ void *thermal_zone_device_get_data(struct thermal_zone_device *tzd)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_get_data);
 
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
index 724b95662da9..9e5c7f2f7b05 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -367,6 +367,8 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
 
 void *thermal_zone_device_get_data(struct thermal_zone_device *tzd);
 
+int thermal_zone_device_get_id(struct thermal_zone_device *tzd);
+
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
 				     unsigned long, unsigned long,
-- 
2.34.1

