Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02BB69C0DB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjBSOjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjBSOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:38:38 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076CD40EF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:17 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b11so1186947wrw.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xv3bh2zC0J+7vpmzMRFSxk7m0hcCBp2b/iLCrIz7G/o=;
        b=XC5Wo9srbZi3yY8KorNxezRLSEpXC4giMo2mU6HA4cWHQzmU6Mu/pX2nRlaXvY32rI
         r262bNFNaJYMMTJWIsgu0+/LztOlolOYgAiazTl5Q//M15SR+cPxWdmBApPItFsDn5gE
         tfYp69rY5dF1gpHndpWm9vM7TJWEk0tc53FpDiS/NNuEfI5UJtHyXBZCHj8QZkChaMQm
         6IOtva1EZTEAR2fenKoTKdoA8Vi2IAUnGdVc4Fdho3GzfcCQX2TKOA4dkkXuZvLtDBEl
         hdovEk8gFtd9x6eUR3Kf37LbjWs25nhk6pjj09W2LDpLUoYa+VCycduqo/4vmzrJHSiN
         fxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xv3bh2zC0J+7vpmzMRFSxk7m0hcCBp2b/iLCrIz7G/o=;
        b=LouE0vXA2w4XrR6u/LKn3k95bH+r056s9hud9QI+zAWjI3zo734M+j6konZaJsKd03
         wMcPYLO+/g8Y5fzOvyi4kBCw73HJGLskSd+WC2FI9B8P0c6i5CD+dwV/1KmcdnIjRhtl
         XrP7JLKxoxug0c7+Hu0wCN9R6AHdidKv6v0jadrguA5m6fIUCWkz85f4ikgAfJN9pdoh
         f5sJnarDxeZWBLn5GecObpX2QH+FfXfoN87I9Uk+GKBA7Wk9YpXfjgSghELfsyYYDaML
         y6P5chfJehCpCeSPyD4d354NVzasq8MoHvgnced+gUHIcwsrJHe+misGfVQlYtCjIya4
         wPPA==
X-Gm-Message-State: AO0yUKXgInDX1J4eqeNitCmvF3HziXtQGmCp7P8w5IUm/XYQBYaJBkWL
        dHDN9a5MxZkBsFG05wsYI/7msA==
X-Google-Smtp-Source: AK7set8GWLf4JlCIofR3paOsNVIlWn9C52sC04eD1IEBdiF9wnaw+PcT9kVK6A7ritTiQV5JJm0y7Q==
X-Received: by 2002:a5d:684f:0:b0:2c5:594b:10d1 with SMTP id o15-20020a5d684f000000b002c5594b10d1mr1454118wrw.23.1676817495488;
        Sun, 19 Feb 2023 06:38:15 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6f43:b92:7670:463])
        by smtp.gmail.com with ESMTPSA id a18-20020adfe5d2000000b002be505ab59asm86176wrn.97.2023.02.19.06.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 06:38:15 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH v1 14/17] thermal/tegra: Do not enable the thermal zone, it is already enabled
Date:   Sun, 19 Feb 2023 15:36:54 +0100
Message-Id: <20230219143657.241542-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230219143657.241542-1-daniel.lezcano@linaro.org>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
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

The code enables the thermal zone after setting it up. But the thermal
zone is already enabled by thermal_of_zone_register() function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/tegra/tegra30-tsensor.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 9cf74208673f..5b87b83a00aa 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -346,7 +346,7 @@ static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
 {
 	const struct tegra_tsensor_channel *tsc = &ts->ch[id];
 	struct thermal_zone_device *tzd = tsc->tzd;
-	int err, hot_trip = 0, crit_trip = 0;
+	int hot_trip = 0, crit_trip = 0;
 	u32 val;
 
 	if (!tzd) {
@@ -401,12 +401,6 @@ static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
 	val |= FIELD_PREP(TSENSOR_SENSOR0_CONFIG0_INTR_THERMAL_RST_EN, 1);
 	writel_relaxed(val, tsc->regs + TSENSOR_SENSOR0_CONFIG0);
 
-	err = thermal_zone_device_enable(tzd);
-	if (err) {
-		dev_err(ts->dev, "ch%u: failed to enable zone: %d\n", id, err);
-		return err;
-	}
-
 	return 0;
 }
 
-- 
2.34.1

