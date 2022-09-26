Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EFE5EAA46
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbiIZPUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiIZPTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:19:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A521E82775
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t7so10368299wrm.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YzUTWEHUQYeukAyJEfTuM3PzyJlxwwnF0DoykmVbPWw=;
        b=YVY6NIlG8E5MYLRDa2EiAoJgns8PVyfYKnGRLgZZLm7fx8zerSdtoskRa91POGwnsc
         KzA+kBKLt/IvYFHVQX08ps11j0X9q90x5cEamJ13yQPAfMurnqQIWWd58GYbKcgYx0+W
         isVYYTBHM4veXgds5rVH3lxZEoJNNYAMQ1LgAVzVtByqGNZdWAYAirwC8HLF9zZuzLtP
         l2a0DdiUpyGB/gH1srv75MVg1Ih5UN4STdwOniy7xvHzMzXhAetI3FR9fKZZDXVztbCa
         WbFrO13ViwlC7GbUSx82BMsKYvoX7fLEnyK5ci9Hp6n+AINetViPxB6qnfsuann3yViD
         ov7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YzUTWEHUQYeukAyJEfTuM3PzyJlxwwnF0DoykmVbPWw=;
        b=V8ehpy3/iJwELjVRXk3vUX3oKb2cbR+/74gkAfvL0Wzuw+48HKU1pen6rpxW5hewit
         wuK8N30gCabn46/kKqSgwa+9OCdG0vks+QmCekXv3K9JekHNgwYABmQO2BYC/u7nfznG
         MIOQrUCPz5n8h5C0aU2/mzpu8G5IXJCMdUHvm0BuMmRWM4SXoRVHMU1iZE2FMrEFSqYy
         WnJRTS9LNcMlRIRPKE9x7H/K57KN+BZxRqaRR/iLrtzvcm1Mf/JYzX6Fhgvm6vGmWUxv
         N+0gG9xCfCuZ91QjtDpikSMH8p8cF1bS2hjgnInpXY7wjOHMDXv1JGVU66y26VluRUlQ
         CbEw==
X-Gm-Message-State: ACrzQf1pudfDyqYOdZ0YvrN3IWXio4qha+rKUKut7IzB3TawC6VSQzkU
        b+L6Pm9Xw1IrJaM1LidBT4awgQ==
X-Google-Smtp-Source: AMsMyM5veGH4dyYihTWvuy0zbsnz2bzt49D2I3XuR+AiNTbAalnoODS/c84isgnulFd8jc1u1OMlCg==
X-Received: by 2002:a05:6000:78e:b0:22a:7e99:da93 with SMTP id bu14-20020a056000078e00b0022a7e99da93mr13503449wrb.20.1664201188818;
        Mon, 26 Sep 2022 07:06:28 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:28 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
        S5P AND EXYNOS ARM ARCHITECTURES)
Subject: [PATCH v5 09/30] thermal/drivers/exynos: of_thermal_get_ntrips()
Date:   Mon, 26 Sep 2022 16:05:43 +0200
Message-Id: <20220926140604.4173723-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
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

The thermal core framework allows to get the number of thermal trips,
use it instead of visiting the thermal core structure internals.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 0e33d32a9d2e..91e6860b5ec4 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -260,6 +260,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tzd = data->tzd;
+	int num_trips = thermal_zone_get_num_trips(tzd);
 	unsigned int status;
 	int ret = 0, temp;
 
@@ -271,12 +272,12 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		goto out;
 	}
 
-	if (of_thermal_get_ntrips(tzd) > data->ntrip) {
+	if (num_trips > data->ntrip) {
 		dev_info(&pdev->dev,
 			 "More trip points than supported by this TMU.\n");
 		dev_info(&pdev->dev,
 			 "%d trip points should be configured in polling mode.\n",
-			 (of_thermal_get_ntrips(tzd) - data->ntrip));
+			 num_trips - data->ntrip);
 	}
 
 	mutex_lock(&data->lock);
@@ -289,7 +290,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		ret = -EBUSY;
 	} else {
 		int i, ntrips =
-			min_t(int, of_thermal_get_ntrips(tzd), data->ntrip);
+			min_t(int, num_trips, data->ntrip);
 
 		data->tmu_initialize(pdev);
 
-- 
2.34.1

