Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77266DCC5C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDJUxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDJUxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:53:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5361986
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:53:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so1272276wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681160020; x=1683752020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VZk/Xuf/BecNwwdsFB/838vQVCvaje2TQnFopmd7IM=;
        b=FxLeg2sTLVYKL6SFHQGx1FS/5j5eNFIakBq/wmiT/7z73ycZpRJOGN+zVK4lR2cyyC
         wIBkdAHRc+p5/f9InR3Q7uSswONpKuDg0e55ZkON7Efl7JAQhwTXV5ExsDMUlTHgcatG
         dox8L7LfD1XszOKEVApR/6iS6vIl3Cs8z15bNYqPgc+vw+YiRfQ7F9jTKm+FyP+sWfcx
         mdTngflLgrvi+IZw7iCa30iJrdCHbr5luYlbDMiS5P4iOxWhCTu+0v7uzlnXejf3ewPv
         8iSNvewqgw+hmJjaW2OnBwLuC97r80s9WDZm5i0QvZt1n4xpcCEzNiaF4ldhzyLPiVa0
         BT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160020; x=1683752020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VZk/Xuf/BecNwwdsFB/838vQVCvaje2TQnFopmd7IM=;
        b=qUmPu336AzO2s/9oJRUSswuI4+IEQA7gTUu1G1otlx9n7uA92mVON57jOPX97NHGSl
         GnovMqNwlPaDu+mD/CgqCCzvTKKYRS8xdTSEze3ZvVFfvxancGoPWJm9rAOxIQH+1VcO
         ddCm7ycVaJXcYOEA1FrvuRlL9V4HQ0vdr19gZdNLKFJX4qa+pFJlkqbez8fD6aU8knNb
         fvYmQ0GtZie3WVG3YjfTMej/poocO1hPnzUBs4nT6r6eiGDg39gTcapweLQnrFCh2yGt
         cS4tMmlLcKJiMFe1OrSO9QeWjSuePWIhWIFpbIUIe1/FPfpcabmk1BCelEYiB2eIr9aW
         9EPQ==
X-Gm-Message-State: AAQBX9ev5kiOzKi9blvw1w0kvWttODrj1X7yrP/4u8icdzdjEfRphdfE
        jdDs2l81+e3YgEDV/1QHPzorWw==
X-Google-Smtp-Source: AKy350ZAg2sXku/us3SLa/ABKLmYyW0fS/CTYnxWdO5C7YlSREmAzH6R6thKVE6yeBcN/q2cJ/AASw==
X-Received: by 2002:a05:600c:ce:b0:3f0:39ab:347c with SMTP id u14-20020a05600c00ce00b003f039ab347cmr5368542wmm.23.1681160020330;
        Mon, 10 Apr 2023 13:53:40 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2611:592:3b9e:d2ae])
        by smtp.gmail.com with ESMTPSA id e17-20020adffc51000000b002ef2e148d59sm11966789wrs.16.2023.04.10.13.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 13:53:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI THERMAL DRIVER)
Subject: [PATCH v2 3/7] thermal/drivers/acpi: Use thermal_zone_device()
Date:   Mon, 10 Apr 2023 22:53:01 +0200
Message-Id: <20230410205305.1649678-4-daniel.lezcano@linaro.org>
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

