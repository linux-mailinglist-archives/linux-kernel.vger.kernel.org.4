Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE16169C0ED
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjBSOjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjBSOif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:38:35 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D0610435
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:11 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e2so659245wri.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5V8k85WBh6qZUpgkagLV5Wwa9BhBydDB+evx63M1T6s=;
        b=bz6mRp6L8imNt6G8MfRsQFKqwpjTgd6YSs/cluna39YPGVmTIdgoBMy37z+Kj74XUV
         L6aJni6CaRqQce2AWpIWOiPV+ogfkJs0gxtk/GWJbuIWONkS6zyRVcMwsBCtHLox4DXw
         34Bpnc9ck+dXzdsjPRir+C2bCNN5k5IoY+0x5qMyMCV/WGh1Tx57DvsUJMhoDfOyy2OE
         aEON2ALmoJYZFJsSl+iE/3NdshfsL5bxIJwAyIgSo74O2gEo9PtvJtFcKPfKR21UaOno
         O88i9H0aJGVQhY8wEoOOyrgfdPF6fwMtniEDOeld84e9p5By8kpbZ6rZDjwxaPbOfZ8C
         h/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5V8k85WBh6qZUpgkagLV5Wwa9BhBydDB+evx63M1T6s=;
        b=QuRWTLh61kbqBlSpcDJnzc5wuKV76/F1VWx3UVVfM+ic2tzCEbngrKt0FTXVKWx+Gx
         M7lKFwt5hCtzDpAYRapntqgfSgQFIw+t1Td/KS8mmZd+r/hXcwn57+8Mw8PUVJ3zjgE+
         LVFj5q0j/0Omlur1/jNTVQ7O12/9H8+L+raJ5M5tXDxiI114dJdhOEasfq7LgZjdPYMq
         /fUYnMQGdK+3l6yD/9Mhxv0CKogw19qxRuutgYTRs9evXfkG7+8q5P+gR/flJHY7ERf7
         RGtIFry+ScknzSbjA4OVWXn0C+JAMuO+LdALLyKOk3s1auFRDppDO5Yg516krkOFdDSs
         2Tqg==
X-Gm-Message-State: AO0yUKWTFFPm/W0ZopCY1UZ+UEEXFme9bAjHn7hRnvo0/XzjAJAJszAn
        msb2gFssAOgaS9kFiKlpsMWMLA==
X-Google-Smtp-Source: AK7set8JspMichyJWLQwg7vvFIsYTvrkviPXxqtmKoI6Imvdjykv3GK8Dv9JGbmXxFoZ63vnOfHPzA==
X-Received: by 2002:a05:6000:106:b0:2c5:889e:3c25 with SMTP id o6-20020a056000010600b002c5889e3c25mr320055wrx.3.1676817490907;
        Sun, 19 Feb 2023 06:38:10 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6f43:b92:7670:463])
        by smtp.gmail.com with ESMTPSA id a18-20020adfe5d2000000b002be505ab59asm86176wrn.97.2023.02.19.06.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 06:38:10 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 11/17] thermal/drivers/da9062: Don't access the thermal zone device fields
Date:   Sun, 19 Feb 2023 15:36:51 +0100
Message-Id: <20230219143657.241542-12-daniel.lezcano@linaro.org>
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

The driver is reading the passive polling rate in the thermal zone
structure. We want to prevent the drivers to rummage around in the
thermal zone structure.

On the other side, the delay is what the driver passed to the
thermal_zone_device_register() function, so it has already the
information.

Reuse the information we have instead of reading the information we
set.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/da9062-thermal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index 3d937f701e0b..2294938bb496 100644
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

