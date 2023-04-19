Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C586E7554
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjDSIeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjDSIeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:34:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4794B451
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:33:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bi21-20020a05600c3d9500b003f17a8eaedbso1039464wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681893231; x=1684485231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VZk/Xuf/BecNwwdsFB/838vQVCvaje2TQnFopmd7IM=;
        b=kqvD1wS2ErlZOZ6LzMudKMXG1HyAcYSdSjNuc9Q7/X77eZsJZrqSJ9UTIYC9BrbQL+
         16yHHMVnkp4q/IDBDhzxYxKbnMXKDx4ozH0u/Zp7yZ2JJFcG8v49cejsci+mpqcqm6rc
         oUfIKrC9B94LztB3abF0hG2JCwhek+fpVUQkQhzjrY1BHQ+2De9Vlo7S1xlGn1/4b/R4
         zO7nIKc5swbfbIY0fEZleTCRfWe9oYsHQnihzI+wZcAGaHu6wUwLIoYZ9sqWjobfWSre
         g+mROweYTMthRhMT47bU3t66balndfeg2Aibs0WdAPgf86TN6bFCHBsr0qyVHobCKMjB
         zkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681893231; x=1684485231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VZk/Xuf/BecNwwdsFB/838vQVCvaje2TQnFopmd7IM=;
        b=OFNVP7vPJIWp/z0tsaba5JNVuZ2XXi5DpNdzxAS8LSQkBarUFIMgbInhrbDQ2OrRXY
         CvDVXkZdVPfOY7o6dwd30bzprUvgTvOah0DLMRQ4Ae0UZce/UXkoUKGRuA9bTPDCa3di
         JkbqT0O5uNGIngpIO487E+9nDyLRww8sgNmkDH6zVSTIIjBseffh2Uun7mf3ccZYNY+t
         cdieU76hdVrpn2UI5EQDdt0fL3YKBNQ6wEZ77Uu+A0uewT+uv1zlU7toTxO/lGNc8UAZ
         OPtkMwlW0BatK0kUNCjxC6gq3lC9cPluWBmRkPWaTS8MZvz1oTs1G7X9p9JqJB9bxRRn
         90OA==
X-Gm-Message-State: AAQBX9f+/ApFbKaiRbWEg2zwk9ZOoHothqKlCT6ZPYGIBLsQkR2kuvUo
        36BivVrvUXqCpwzH8nME+RkSDw==
X-Google-Smtp-Source: AKy350bhWuv8l4xbkOG83XJs5OTDFxSQo6hP86nRCvWtzPSnGTDj6JV9qccrOBzrmbTmGm5aW0p66Q==
X-Received: by 2002:a1c:f719:0:b0:3f0:a9b1:81e0 with SMTP id v25-20020a1cf719000000b003f0a9b181e0mr15260941wmh.19.1681893231030;
        Wed, 19 Apr 2023 01:33:51 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a794:9fb2:29fb:606d])
        by smtp.gmail.com with ESMTPSA id s5-20020a1cf205000000b003ed1ff06faasm1442033wmc.19.2023.04.19.01.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 01:33:50 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI THERMAL DRIVER)
Subject: [PATCH v4 3/6] thermal/drivers/acpi: Use thermal_zone_device()
Date:   Wed, 19 Apr 2023 10:33:40 +0200
Message-Id: <20230419083343.505780-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419083343.505780-1-daniel.lezcano@linaro.org>
References: <20230419083343.505780-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get the device associated with the thermal zone, let's use
the wrapper thermal_zone_device() instead of accessing directly the
content of the thermal zone device structure.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 255efa73ed70..5763db4528b8 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -789,6 +789,7 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 {
+	struct device *tzdev;
 	int trips = 0;
 	int result;
 	acpi_status status;
@@ -820,12 +821,14 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
+	tzdev = thermal_zone_device(tz->thermal_zone);
+	
 	result = sysfs_create_link(&tz->device->dev.kobj,
-				   &tz->thermal_zone->device.kobj, "thermal_zone");
+				   &tzdev->kobj, "thermal_zone");
 	if (result)
 		goto unregister_tzd;
 
-	result = sysfs_create_link(&tz->thermal_zone->device.kobj,
+	result = sysfs_create_link(&tzdev->kobj,
 				   &tz->device->dev.kobj, "device");
 	if (result)
 		goto remove_tz_link;
@@ -849,7 +852,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 acpi_bus_detach:
 	acpi_bus_detach_private_data(tz->device->handle);
 remove_dev_link:
-	sysfs_remove_link(&tz->thermal_zone->device.kobj, "device");
+	sysfs_remove_link(&tzdev->kobj, "device");
 remove_tz_link:
 	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
 unregister_tzd:
@@ -860,8 +863,10 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 
 static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
 {
+	struct device *tzdev = thermal_zone_device(tz->thermal_zone);
+	
 	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
-	sysfs_remove_link(&tz->thermal_zone->device.kobj, "device");
+	sysfs_remove_link(&tzdev->kobj, "device");
 	thermal_zone_device_unregister(tz->thermal_zone);
 	tz->thermal_zone = NULL;
 	acpi_bus_detach_private_data(tz->device->handle);
-- 
2.34.1

