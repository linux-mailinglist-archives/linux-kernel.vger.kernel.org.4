Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6893965524A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiLWPjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbiLWPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:38:43 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163E546660
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:38:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bx10so4935654wrb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 07:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuQJZUiYgsrv6ydPrE/ryH64TRoc2yWi4dM3ARWJNR4=;
        b=RTjhswt+6tiiYquqWIf1Bv153VnSU5lDEY/YBSphlnlos0M3DB13yo7Hh+2JH2ey+Y
         1Ymok9XvOR/yPOU0DYRS5sk8YHSlt6OBr9V3sCmo8ujrt6odD5XcgfuoUzb9+BBU/iZd
         AgFVwYFMQWZUWh4OGWuCgczBV3lRP+qNQSHciNEps3oi4wSyxKE1Hku5Xq/XJsq1wqVg
         KZJvbjVHNElq3pyjVIF5WJjtUEizlrUOrf/M/cXR2296ja2hQget+VGe1YJ8sIHnzSUy
         FVswQmXyWDODAv2PevUwlny7tYq4kJP8sQiyc4UQjba38d9U4qXJtndmu2UAvOYWu1m2
         MhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuQJZUiYgsrv6ydPrE/ryH64TRoc2yWi4dM3ARWJNR4=;
        b=6nBkTMFZ8QG846ygT7olmcHoRm1cmzi5DlsveODzKb8FxNbMWdgy/vOc2cAPHjW158
         LYeER39RhXh8wNE6JrZeY3cxYxCqwGH/lMJJ5NxH7DvkDKwhcVpYGZ3rWLf/qituEUrm
         oPPeTTmT+/QETv1QrSIvlf+woWayhM5dJS3yafc7WbAiw5oHVaVQjPUU9eFgkT2WFPOy
         JsS1knCvrN0F0ax6rTwZvClqklxTV45amTH+2ummSmP7xzSvNHyn+G08pt+ehrMnAUTe
         OnoNbJkFbYfkqQvpHvjf6j1yuZZdTZ09bEZC/3u3tcFa437PKwEIEVD5LDReuslWlAVZ
         r6Pw==
X-Gm-Message-State: AFqh2krgraQtI2sz4iPdnB+ziSBFBvjNLwfQ66lPuY+lDZ8ZX1pckciL
        Q/y7MTqDe1qIG7Aeytm/weXsWw==
X-Google-Smtp-Source: AMrXdXt+D8+ShGwprnyREr39W/oKiY2rcuXwLgfb5FfMzfQ33k2idZKt03tPoJi/+kllQcoCQDJupQ==
X-Received: by 2002:a5d:470a:0:b0:242:22e4:998f with SMTP id y10-20020a5d470a000000b0024222e4998fmr6055124wrq.55.1671809912419;
        Fri, 23 Dec 2022 07:38:32 -0800 (PST)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id m5-20020adfc585000000b00236488f62d6sm3491610wrg.79.2022.12.23.07.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 07:38:32 -0800 (PST)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH v7 10/10] pwm: dwc: use clock rate in hz to avoid rounding issues
Date:   Fri, 23 Dec 2022 15:38:20 +0000
Message-Id: <20221223153820.404565-11-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221223153820.404565-1-ben.dooks@sifive.com>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

As noted, the clock-rate when not a nice multiple of ns is probably
going to end up with inacurate caculations, as well as on a non pci
system the rate may change (although we've not put a clock rate
change notifier in this code yet) so we also add some quick checks
of the rate when we do any calculations with it.

Signed-off-by; Ben Dooks <ben.dooks@sifive.com>
Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-dwc-of.c |  2 +-
 drivers/pwm/pwm-dwc.c    | 29 ++++++++++++++++++++---------
 drivers/pwm/pwm-dwc.h    |  2 +-
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-dwc-of.c b/drivers/pwm/pwm-dwc-of.c
index c5b4351cc7b0..5f7f066859d4 100644
--- a/drivers/pwm/pwm-dwc-of.c
+++ b/drivers/pwm/pwm-dwc-of.c
@@ -50,7 +50,7 @@ static int dwc_pwm_plat_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(dwc->clk),
 				     "failed to get timer clock\n");
 
-	dwc->clk_ns = NSEC_PER_SEC / clk_get_rate(dwc->clk);
+	dwc->clk_rate = clk_get_rate(dwc->clk);
 	return devm_pwmchip_add(dev, &dwc->chip);
 }
 
diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 5ef0fe7ea3e9..f48a6245a3b5 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -43,18 +43,22 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	u32 high;
 	u32 low;
 
+	if (dwc->clk)
+		dwc->clk_rate = clk_get_rate(dwc->clk);
+
 	/*
 	 * Calculate width of low and high period in terms of input clock
 	 * periods and check are the result within HW limits between 1 and
 	 * 2^32 periods.
 	 */
-	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
+	tmp = state->duty_cycle * dwc->clk_rate;
+	tmp = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	low = tmp - 1;
 
-	tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
-				    dwc->clk_ns);
+	tmp = (state->period - state->duty_cycle) * dwc->clk_rate;
+	tmp = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	high = tmp - 1;
@@ -120,6 +124,7 @@ static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 			      struct pwm_state *state)
 {
 	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+	unsigned long clk_rate;
 	u64 duty, period;
 	u32 ctrl, ld, ld2;
 
@@ -129,22 +134,28 @@ static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	ld = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
 	ld2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
 
+	if (dwc->clk)
+		dwc->clk_rate = clk_get_rate(dwc->clk);
+
+	clk_rate = dwc->clk_rate;
 	state->enabled = !!(ctrl & DWC_TIM_CTRL_EN);
 
 	/* If we're not in PWM, technically the output is a 50-50
 	 * based on the timer load-count only.
 	 */
 	if (ctrl & DWC_TIM_CTRL_PWM) {
-		duty = (ld + 1) * dwc->clk_ns;
-		period = (ld2 + 1)  * dwc->clk_ns;
+		duty = ld + 1;
+		period = ld2 + 1;
 		period += duty;
 	} else {
-		duty = (ld + 1) * dwc->clk_ns;
+		duty = ld + 1;
 		period = duty * 2;
 	}
 
-	state->period = period;
-	state->duty_cycle = duty;
+	duty *= NSEC_PER_SEC;
+	period *= NSEC_PER_SEC;
+	state->period = DIV_ROUND_CLOSEST_ULL(period, clk_rate);
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(duty, clk_rate);
 	state->polarity = PWM_POLARITY_INVERSED;
 
 	pm_runtime_put_sync(chip->dev);
@@ -164,7 +175,7 @@ struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
 	if (!dwc)
 		return NULL;
 
-	dwc->clk_ns = 10;
+	dwc->clk_rate = NSEC_PER_SEC / 10;
 	dwc->chip.dev = dev;
 	dwc->chip.ops = &dwc_pwm_ops;
 	dwc->chip.npwm = DWC_TIMERS_TOTAL;
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index dc451cb2eff5..19bdc2224690 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -41,7 +41,7 @@ struct dwc_pwm {
 	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
-	unsigned int clk_ns;
+	unsigned long clk_rate;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
 #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
-- 
2.35.1

