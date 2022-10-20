Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EA460641D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJTPQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJTPQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:16:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEC8141395
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:16:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j7so35081420wrr.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcsBO+PdZnMYRQoMiLKmfHmcJowiT7IWL6mFn+gZxeQ=;
        b=DfCZE7lWv/sClOVyQJlr+vLQjxoXBAXGJFNojR0QdA9ocQUVkkYfsEdNf+tWldx1uJ
         nNUAqEyMhwsEcIFy+i0cu+pZM69VbRqFeeRvaYG+np/05OwGTPaUagINTVc6QN2kr397
         KxGvX01WAVbX4iKUajYx+IS9vsMug2vYf632CfKA8Ijl0akHFOCQP3l0cVXkyWeukgB/
         +Bvpwc2uhqTOM43WzKGG191l7EN+g9Rb/m0+GuUJ9864xW6CpjyZDL9w7uhmGoZkPUzc
         s/66j3cSskP7yRyK3/rTJGqmlAuGvXvg/1McVlx3L3kRNcStBEWwATyVDYrE7//Gz40O
         HMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcsBO+PdZnMYRQoMiLKmfHmcJowiT7IWL6mFn+gZxeQ=;
        b=SnGx9KLZ04zaiGXa4HG09utVnoMnIIKHhbLHtP3aJD4taRrN+qZfocbGcXWRgbT3g9
         vd5tZLSFPq34qx820VGEBk4g2g7Bk2y4xTYt3g9QVwwFlclU1Xb+RPRdX2l7eRZ2tIYe
         6ODywzZ72Om9RBInHq0u2YtkKtMVVXB40ihjXn/xgTQx/+JhcSrhzmdJwxreFB35ARwJ
         QCB48w+tfQJ61CbaCS3N6Kp8gqwxnmX5sYuI6HRgJX6mLEBeEFdJWpsQKFyvghLLYw9G
         tz71d5FpmF8L6GOTAj5qmnG/1+TriEgNO79WcXC4P+qB9H/ep6PbE6IY8v/FCbA4HBxp
         +I7Q==
X-Gm-Message-State: ACrzQf1RYXujmkXJUaTsBS6abopPEdbksRvN4xzB/KRCg6OuMIp5fr5+
        hd7eMA4S8DWi9RjQyScWpDTdUA==
X-Google-Smtp-Source: AMsMyM60BK8vOMMwoXZkBGhTSKzXroB6DXQPnwj9us1WjdPrLedCLJAmX751RtzTa6dm1thpOlrTfQ==
X-Received: by 2002:adf:f00b:0:b0:22e:3439:cff2 with SMTP id j11-20020adff00b000000b0022e3439cff2mr9443861wro.719.1666278982214;
        Thu, 20 Oct 2022 08:16:22 -0700 (PDT)
Received: from rainbowdash.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b003c6f3e5ba42sm41362wmb.46.2022.10.20.08.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:16:21 -0700 (PDT)
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
Subject: [PATCH v6 07/10] pwm: dwc: make timer clock configurable
Date:   Thu, 20 Oct 2022 16:16:07 +0100
Message-Id: <20221020151610.59443-8-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020151610.59443-1-ben.dooks@sifive.com>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a configurable clock base rate for the pwm as when being built
for non-PCI the block may be sourced from an internal clock.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v6:
 - removed DWC_CLK_PERIOD_NS as it is now not needed
v4:
 - moved earlier before the of changes to make the of changes one patch
v2:
  - removed the ifdef and merged the other clock patch in here
---
 drivers/pwm/pwm-dwc-pci.c |  1 +
 drivers/pwm/pwm-dwc.c     | 10 ++++++----
 drivers/pwm/pwm-dwc.h     |  3 ++-
 3 files changed, 9 insertions(+), 5 deletions(-)

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
index 68f98eb76152..dc451cb2eff5 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -22,7 +22,6 @@
 #define DWC_TIMERS_COMP_VERSION	0xac
 
 #define DWC_TIMERS_TOTAL	8
-#define DWC_CLK_PERIOD_NS	10
 
 /* Timer Control Register */
 #define DWC_TIM_CTRL_EN		BIT(0)
@@ -41,6 +40,8 @@ struct dwc_pwm_ctx {
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

