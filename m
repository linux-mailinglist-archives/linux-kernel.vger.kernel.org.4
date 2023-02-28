Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37106A57EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjB1LYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjB1LYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:24:10 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877D6D33B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:23:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bx12so6178890wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677583417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+RTeMjiH2Yk42W57PYAK6Mb85gdhTfPcaFRy4giwH0=;
        b=EmQXnQtsDg+56Wuq6ewQRNDc28TLYzPGy1X89Ssg0MochaT9hmPr0KireBQjSDQ6E7
         bjvuyvug9z81Yd9EbbXOOxBwJg1i3N1ZuXnZgmm+0Upk0EiUbSe5UZTvyAjiPCCohQTx
         1EPy2RiGpQVVKptvZtAiTydYryNJwyZR8OcG5veCR1GjT8UnWQ5ba0ialhHB+H/0BqEJ
         bHdStmGGKz34GeGA2WXBKwEO9HSHUmh8FYElsvfQYZPEweZc9I9E7Gf6lM9m6RZS6uu9
         dRPJHrbvPaJdQureGjN6HrS9w/znb8n6nZaDYcDiRPipyO6tIE47bRCzCMEymz21NUqI
         FT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677583417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+RTeMjiH2Yk42W57PYAK6Mb85gdhTfPcaFRy4giwH0=;
        b=GhEB2YqN/sPuCJFzXJGlzgTHlEs3Fa/ZHVvu0EITl/XMznVpRRPXuZtI2sJbIrvw+P
         oIAzV8x5p+FnyoJtatWo1q6MJRlBTrsZQCIuOG4nI92I1++q9I2HOVOrZausAEBzvIWU
         IuARllgf2OHvmgRx9YzfuIgXajds/QlPlzQh2TjLYUFfvx1BQ1BxHRIa1MRvYomjgSfC
         Kt9Xedjklr1tib2oQqBDGPkpVVyS35d1+yegsBIQqZ0rsOHu3BjvX5dom84tUY+2q0Td
         m1sG7zdHcmPQgKo7e3pGqE/a7RaKRyY3Ze52Ke1QmJf6XhKWPFcjlN0AmYNhsPbqsLB5
         oscQ==
X-Gm-Message-State: AO0yUKXTeo0I14hkRijn8zODz6SoercwvVcOZzeqPDE5TC3RImRf1RPH
        A18YqsEOv5bTXLv1rACTZTlQFw==
X-Google-Smtp-Source: AK7set/Qza96mNPIlieljNjhA7dJUgVD6toVz9gG/9S+f4QAhjyTiZf47zgTvEnBET9YKnow7SAOjQ==
X-Received: by 2002:a5d:44cf:0:b0:2c7:107c:e172 with SMTP id z15-20020a5d44cf000000b002c7107ce172mr2119658wrr.41.1677583417089;
        Tue, 28 Feb 2023 03:23:37 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6830:6390:2815:b6a5])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6545000000b002c5501a5803sm9598130wrv.65.2023.02.28.03.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:23:36 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v4 14/19] thermal/drivers/da9062: Don't access the thermal zone device fields
Date:   Tue, 28 Feb 2023 12:22:33 +0100
Message-Id: <20230228112238.2312273-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
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

The driver is reading the passive polling rate in the thermal zone
structure. We want to prevent the drivers to rummage around in the
thermal zone structure.

On the other side, the delay is what the driver passed to the
thermal_zone_device_register() function, so it has already the
information.

Reuse the information we have instead of reading the information we
set.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
---
 drivers/thermal/da9062-thermal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index e7097f354750..2d31b1f73423 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -41,6 +41,8 @@
 
 #define DA9062_MILLI_CELSIUS(t)			((t) * 1000)
 
+static unsigned int pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
+
 struct da9062_thermal_config {
 	const char *name;
 };
@@ -95,7 +97,10 @@ static void da9062_thermal_poll_on(struct work_struct *work)
 		thermal_zone_device_update(thermal->zone,
 					   THERMAL_EVENT_UNSPECIFIED);
 
-		delay = thermal->zone->passive_delay_jiffies;
+		/*
+		 * pp_tmp is between 1s and 10s, so we can round the jiffies
+		 */
+		delay = round_jiffies(msecs_to_jiffies(pp_tmp));
 		queue_delayed_work(system_freezable_wq, &thermal->work, delay);
 		return;
 	}
@@ -155,7 +160,6 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 {
 	struct da9062 *chip = dev_get_drvdata(pdev->dev.parent);
 	struct da9062_thermal *thermal;
-	unsigned int pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
 	const struct of_device_id *match;
 	int ret = 0;
 
@@ -208,8 +212,7 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 	}
 
 	dev_dbg(&pdev->dev,
-		"TJUNC temperature polling period set at %d ms\n",
-		jiffies_to_msecs(thermal->zone->passive_delay_jiffies));
+		"TJUNC temperature polling period set at %d ms\n", pp_tmp);
 
 	ret = platform_get_irq_byname(pdev, "THERMAL");
 	if (ret < 0)
-- 
2.34.1

