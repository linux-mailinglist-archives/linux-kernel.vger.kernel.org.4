Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CD06AE0CD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCGNiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjCGNiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:38:05 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851C12411F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:38:02 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h11so12146524wrm.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678196281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpDMcBBLQyF8LgqHxboWMTUnYVwMKYwzb0k+I2z6s1c=;
        b=lisF83AxJvSh6DA0RlrtTx09wKFawmHLIpSEn4KF0rznqL5TJpY1E9n2PY4Sfo9+QG
         uh7WuzJnm7J3PM/cwsJxcDK6N7kD6x+WmDK3pFw9JxOfO+MRb/W88kLm1shD2LHhH8ew
         cbFDopAM4fsLuhoFCF0IBlPYZMaKmPa9tG7f3tFcwqh9o27n3MaKlgeVmBQXxyYYPvmN
         OlKzfd+OqgN81HU0s1U95UHmnZ4edFAdq/qvBVaZiaXQAKOnlXa4c7YzUaqYJnkHJZ6J
         WS5GyHeG6Qk0XMQR9hGfPOtTHvIeRjBuzWz+LNF51lXn9RIEWRppGsn9W+Ya0SJ816mp
         K7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpDMcBBLQyF8LgqHxboWMTUnYVwMKYwzb0k+I2z6s1c=;
        b=bXxtECRgNLofk4WfIteyGw9WeRx/cBhxLMJcDjSq9F0d8LSbt2m5CX57oy3eQjk1f6
         7xit10PmXiAhY3HFxe2gNjfI2CeBJQAsF9yQn2uh2X0B/6PRW/GPqCNMWeGCqXR7dsR5
         jQeH5lyMLDeDkBRxCj8MktWnupQDQyByITkkmZvEfABWvWyBQr3jFNd5BfK9jklyRmpp
         Yl3usEvX77SMQtZqjE2IkuldcveVyx0csT5Rx9qvovuBnL4+8F7WmA9B9iKlI+FvOgNK
         0J+vF3H4tlGM5VD/MA/FrA0Mwi9DjOT9/rpKkHoJrvWTDf6TmO+WoGYWevx0nB6e0sSI
         CHRw==
X-Gm-Message-State: AO0yUKX5ucf54cqr1DZWiXF36ObpVetH4sUf/Td1cL7X60Y55LcchD2s
        oVm1JzQBaY+SNcLTFS/qk36dPQ==
X-Google-Smtp-Source: AK7set8lV3Qtw70a9ky+eOgzFG00YBYwvd9fFWnYlMqkkOwH3u5x7jj9HhyKgtqvVbIPNs7maG344Q==
X-Received: by 2002:adf:e343:0:b0:2c7:f56:285b with SMTP id n3-20020adfe343000000b002c70f56285bmr9946678wrj.63.1678196281789;
        Tue, 07 Mar 2023 05:38:01 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5ab9:1ac6:870d:35c])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b002c55de1c72bsm12311477wrr.62.2023.03.07.05.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:38:01 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Thierry Reding <treding@nvidia.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 07/11] thermal/drivers/bcm2835: Remove buggy call to thermal_of_zone_unregister
Date:   Tue,  7 Mar 2023 14:37:31 +0100
Message-Id: <20230307133735.90772-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133735.90772-1-daniel.lezcano@linaro.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is using the devm_thermal_of_zone_device_register().

In the error path of the function calling
devm_thermal_of_zone_device_register(), the function
devm_thermal_of_zone_unregister() should be called instead of
thermal_of_zone_unregister(), otherwise this one will be called twice
when the device is freed.

The same happens for the remove function where the devm_ guarantee the
thermal_of_zone_unregister() will be called, so adding this call in
the remove function will lead to a double free also.

Use devm_ variant in the error path of the probe function.

Remove thermal_of_zone_unregister() in the remove function.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index a217d832f24e..ea07152a6d0d 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -269,13 +269,13 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	 */
 	err = thermal_add_hwmon_sysfs(tz);
 	if (err)
-		goto err_tz;
+		goto err_clk;
 
 	bcm2835_thermal_debugfs(pdev);
 
 	return 0;
 err_tz:
-	thermal_of_zone_unregister(tz);
+	devm_thermal_of_zone_unregister(&pdev->dev, tz);
 err_clk:
 	clk_disable_unprepare(data->clk);
 
@@ -285,10 +285,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 static int bcm2835_thermal_remove(struct platform_device *pdev)
 {
 	struct bcm2835_thermal_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tz = data->tz;
 
 	debugfs_remove_recursive(data->debugfsdir);
-	thermal_of_zone_unregister(tz);
 	clk_disable_unprepare(data->clk);
 
 	return 0;
-- 
2.34.1

