Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62B36DCC5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjDJUyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjDJUxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:53:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D7A1FF1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:53:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e2so5482780wrc.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681160023; x=1683752023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP0ai9WWz0txuIScl5+cGxEFfYcMtPVS0xCm4H0j7Sc=;
        b=SwtFaLlLUJ8uK7PCs+p+9q2jmdDGcKVwq2VZsU/IWs58GUENqqElwlgMGZ8UaUJnBN
         qhClHoISI+1Q+k54FGd0ILwM0AaILv4BEY6f6wGumB1/QaMe/E5yzf2QwGCRg6g0V+J4
         +SYHG056WUkzc76xWr+JpQPIc/4TNc7EClWhBAgWxYnzci8x+cqaeyBmNSJNUt4jS7jr
         yvw4SLUl/EV/lpVNbcPESPb+bwTB7k6RzUalSe2TW6D0WZyh1U5cf5ZMFO1caNcX3zop
         nlJjUg9bm+RA2xIL2wNZGtGgntUmwIkGnHtrzTmATfu2Wit7szggjPGQqw28k1jsyxi0
         il1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160023; x=1683752023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zP0ai9WWz0txuIScl5+cGxEFfYcMtPVS0xCm4H0j7Sc=;
        b=PaYxR6/a8Ah8QzOSYcEzoYe5vA0XJwe8ILn3RmxTHtdSiTF7KjtsNs0dw43cIQX1X5
         6ianYvua4oLrIhUeTc/xs7TdCmQ02b5UL0z/rFY/aaLXt5Dc6BkGd450IVM81xvHzj6b
         5T4o4NS6wtpWBmpOqB76xXhS5nkaBRap0Lj2SoViogYMm49cZtYEsQokCCpEcDW7Hnjy
         pOo+AIYW/7Yii6G4RT7eCdXr+h8YlUwBpOV1dpdU7Tl4U7BMyLTqTOFYcXUy0b9CJfy/
         h8riGab1R9m7E+FOZL7jO3e+C7sQeqMippdC5FuHTSl2a9ucU3/QnXOF8A5mPu/nxyVD
         eKYw==
X-Gm-Message-State: AAQBX9dH3RoaONbNe33jQAb+xpiXX7EPGjZywg08XvKgYNMyyC2CMGav
        GFuazUGpAHKotDDHNVf5yHz/mA==
X-Google-Smtp-Source: AKy350ZlNr1Ggj7t/rY1NAQx6q6DjJGKetJtVt34ctysK9zRe75QqXeVNlKWq//6kKmGhE+P5XLt2w==
X-Received: by 2002:a5d:544b:0:b0:2c5:3cd2:b8e with SMTP id w11-20020a5d544b000000b002c53cd20b8emr5478341wrv.1.1681160022744;
        Mon, 10 Apr 2023 13:53:42 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2611:592:3b9e:d2ae])
        by smtp.gmail.com with ESMTPSA id e17-20020adffc51000000b002ef2e148d59sm11966789wrs.16.2023.04.10.13.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 13:53:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI THERMAL DRIVER)
Subject: [PATCH v2 6/7] thermal/drivers/acpi: Make cross dev link optional by configuration
Date:   Mon, 10 Apr 2023 22:53:04 +0200
Message-Id: <20230410205305.1649678-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
References: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
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

The ACPI thermal driver creates a link in the thermal zone device
sysfs directory pointing to the device sysfs directory. At the same
time, it creates a back pointer link from the device to the thermal
zone device sysfs directory.

From a generic perspective, having a device pointer in the sysfs
thermal zone directory may make sense. But the opposite is not true as
the same driver can be related to multiple thermal zones.

The usage of these information is very specific to ACPI and it is
questionable if they are really needed.

Let's make the code optional and disable it by default.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 62 ++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 5763db4528b8..70f1d28810f2 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -787,9 +787,44 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
 	.critical = acpi_thermal_zone_device_critical,
 };
 
+#ifdef CONFIG_THERMAL_SYSFS_OBSOLETE_SINGULARITY
+static int acpi_thermal_zone_sysfs_add(struct acpi_thermal *tz)
+{
+	struct device *tzdev = thermal_zone_device(tz->thermal_zone);
+	int ret;
+	
+	ret = sysfs_create_link(&tz->device->dev.kobj,
+				&tzdev->kobj, "thermal_zone");
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&tzdev->kobj,
+				   &tz->device->dev.kobj, "device");
+	if (ret)
+		sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
+
+	return ret;
+}
+
+static void acpi_thermal_zone_sysfs_remove(struct acpi_thermal *tz)
+{
+	struct device *tzdev = thermal_zone_device(tz->thermal_zone);
+	
+	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
+	sysfs_remove_link(&tzdev->kobj, "device");
+}
+#else
+static inline int acpi_thermal_zone_sysfs_add(struct acpi_thermal *tz)
+{
+	return 0;
+}
+static inline void acpi_thermal_zone_sysfs_remove(struct acpi_thermal *tz)
+{
+}
+#endif
+
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 {
-	struct device *tzdev;
 	int trips = 0;
 	int result;
 	acpi_status status;
@@ -821,23 +856,15 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
-	tzdev = thermal_zone_device(tz->thermal_zone);
-	
-	result = sysfs_create_link(&tz->device->dev.kobj,
-				   &tzdev->kobj, "thermal_zone");
+	result = acpi_thermal_zone_sysfs_add(tz);
 	if (result)
 		goto unregister_tzd;
-
-	result = sysfs_create_link(&tzdev->kobj,
-				   &tz->device->dev.kobj, "device");
-	if (result)
-		goto remove_tz_link;
-
+	
 	status =  acpi_bus_attach_private_data(tz->device->handle,
 					       tz->thermal_zone);
 	if (ACPI_FAILURE(status)) {
 		result = -ENODEV;
-		goto remove_dev_link;
+		goto remove_links;
 	}
 
 	result = thermal_zone_device_enable(tz->thermal_zone);
@@ -851,10 +878,8 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 
 acpi_bus_detach:
 	acpi_bus_detach_private_data(tz->device->handle);
-remove_dev_link:
-	sysfs_remove_link(&tzdev->kobj, "device");
-remove_tz_link:
-	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
+remove_links:
+	acpi_thermal_zone_sysfs_remove(tz);
 unregister_tzd:
 	thermal_zone_device_unregister(tz->thermal_zone);
 
@@ -863,10 +888,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 
 static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
 {
-	struct device *tzdev = thermal_zone_device(tz->thermal_zone);
-	
-	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
-	sysfs_remove_link(&tzdev->kobj, "device");
+	acpi_thermal_zone_sysfs_remove(tz);
 	thermal_zone_device_unregister(tz->thermal_zone);
 	tz->thermal_zone = NULL;
 	acpi_bus_detach_private_data(tz->device->handle);
-- 
2.34.1

