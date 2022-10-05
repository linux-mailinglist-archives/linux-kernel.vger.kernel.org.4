Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892AC5F5C8B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 00:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJEWNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 18:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiJEWM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:12:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B43B83069
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 15:12:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u10so27714217wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 15:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=sf7gmbsgKDhqFstk8g51OmZhGoNVa8xIzDvITlkpkK0=;
        b=WMV2J3/IFDWrBmhUz7DjYlXvyBwYCsWL8B1uZzM1kac+0ped3GCPIQ22sUsasTb2/j
         3cK8HCab8PpQqNlpw/oksHeRDolKTvMllTUR3NZVTJn92FLe8c7p0I9qAqJ+2zo4Dgvp
         3i+bWmVCSnKaZR5LnNHUKHKl1SdQVWSvImewl6CSePIksbS40J8hv/3JHx2VW2vBcx5D
         65fK7x9C7ei26oH6HHRfsVNKhJ/7iQA1VxAJrCpx0qUHjxlATMI+i3lh7qYWyEF3ADFF
         ea+0LsPUxpzC2+JmkJUbxD3rPHKAiaMa0hi9t5uOOX/wAhOAbRZ8s8d5kUJA554tMljR
         JcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sf7gmbsgKDhqFstk8g51OmZhGoNVa8xIzDvITlkpkK0=;
        b=cV6LL5rL7U2xjWyoJol1t2ddr9pQl+w73Fm9OZDhffhMuoRmjLAvcpKPChsvyvoLKO
         KswU/aPBh5k/a9yGvzvcffnMfZUa/EBQmiWip0ClykNZVQH+1BvR0RJwGwZ945vADnud
         rn88pnBT4AQi4ChcyYXjGWBKedAuSDXGclsajdUQTnitT8Hz+m/qEdNbkdYOm/2qZiIL
         XdmOqFNiIDhzg0HGQrgTwzJ5634lDCngToackR2q4bUCyvGyUDHYKH7hzHZVKrylyi3s
         wHAhVyxckarce6MpU3Ok7TloJRHFlTfEOBS8nkWPPwb8jwJAZ2KIvyv5nyzwMe2Qt5oF
         rPmg==
X-Gm-Message-State: ACrzQf2hBlcv6eLIlLe2uVzjDJKJoIu5WJQv/vlY6VdqVKfBi+T6BgUq
        MqFYKprzY9Habv9+GJwHSnbWAg==
X-Google-Smtp-Source: AMsMyM4mYKdGYq7ZXAXLcrVvSb15fttWtQdS3kRb10WzSVAdrzKMr1NtK5TXM+1ncZUWg8EICO7bag==
X-Received: by 2002:adf:ec01:0:b0:22e:35ce:7a65 with SMTP id x1-20020adfec01000000b0022e35ce7a65mr1070880wrn.498.1665007973676;
        Wed, 05 Oct 2022 15:12:53 -0700 (PDT)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id d2-20020adffd82000000b0022e327f849fsm12184437wrr.5.2022.10.05.15.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 15:12:53 -0700 (PDT)
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
Subject: [PATCH v5 07/10] pwm: dwc: make timer clock configurable
Date:   Wed,  5 Oct 2022 23:12:39 +0100
Message-Id: <20221005221242.470734-8-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221005221242.470734-1-ben.dooks@sifive.com>
References: <20221005221242.470734-1-ben.dooks@sifive.com>
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

Add a configurable clock base rate for the pwm as when being built
for non-PCI the block may be sourced from an internal clock.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v4:
 - moved earlier before the of changes to make the of changes one patch
v2:
  - removed the ifdef and merged the other clock patch in here
---
 drivers/pwm/pwm-dwc-pci.c |  1 +
 drivers/pwm/pwm-dwc.c     | 10 ++++++----
 drivers/pwm/pwm-dwc.h     |  2 ++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-dwc-pci.c b/drivers/pwm/pwm-dwc-pci.c
index 2213d0e7f3c8..949423e368f9 100644
--- a/drivers/pwm/pwm-dwc-pci.c
+++ b/drivers/pwm/pwm-dwc-pci.c
@@ -20,6 +20,7 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
+#include <linux/clk.h>
 
 #include "pwm-dwc.h"
 
diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 90a8ae1252a1..1251620ab771 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
 
@@ -47,13 +48,13 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	 * periods and check are the result within HW limits between 1 and
 	 * 2^32 periods.
 	 */
-	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, DWC_CLK_PERIOD_NS);
+	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	low = tmp - 1;
 
 	tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
-				    DWC_CLK_PERIOD_NS);
+				    dwc->clk_ns);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	high = tmp - 1;
@@ -128,12 +129,12 @@ static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
 	duty += 1;
-	duty *= DWC_CLK_PERIOD_NS;
+	duty *= dwc->clk_ns;
 	state->duty_cycle = duty;
 
 	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
 	period += 1;
-	period *= DWC_CLK_PERIOD_NS;
+	period *= dwc->clk_ns;
 	period += duty;
 	state->period = period;
 
@@ -156,6 +157,7 @@ struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
 	if (!dwc)
 		return NULL;
 
+	dwc->clk_ns = 10;
 	dwc->chip.dev = dev;
 	dwc->chip.ops = &dwc_pwm_ops;
 	dwc->chip.npwm = DWC_TIMERS_TOTAL;
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index c8dd690eefb3..dc451cb2eff5 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -40,6 +40,8 @@ struct dwc_pwm_ctx {
 struct dwc_pwm {
 	struct pwm_chip chip;
 	void __iomem *base;
+	struct clk *clk;
+	unsigned int clk_ns;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
 #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
-- 
2.35.1

