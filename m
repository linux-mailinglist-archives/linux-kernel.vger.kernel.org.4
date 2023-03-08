Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A75E6B1637
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCHXJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCHXJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:09:43 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E643E64216
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:09:39 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id t22so295373oiw.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678316979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcyN6J8psmsD0AipK3PVomDiouRZnU8VIxAcqRxXEto=;
        b=q3IlJ0PtdTA2WKmAG1d3tU8qg7pF582NBzTvvAggce9S3FSEvf8Gz1eSbYK8GaLQnn
         6L2l9Sf3hNlSlEip7YSk0h/xcJl+Ed7vho0cOw6r7pTJBDMwPj18FOSbZDbSMGgx6VGu
         RfpZTkv8DVSB82/Own1gEy/I1RlVGgYO6k9+mn+kdO5UJMSgL7tSBwUsfV+9OI+WMrEy
         mRfk0RAD/el8kQzsmmsXmjXPj3YV5Iy7eE+rEN3xqqqKeRL9XgsSHMn8wooKY7iXKRbY
         XSLksVHSnubrHoKQmQO/yhDHgAuLvhlUBANYUW53lOO+bskC5Op3QxwZY4WFty3woN9C
         IQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcyN6J8psmsD0AipK3PVomDiouRZnU8VIxAcqRxXEto=;
        b=pyhNKdch05RMBKBz8koWrl78AnrxyrFhMjQ2fJQVzOk9U61ih9wcB61IIIeDP7/O0+
         wl6hQ97Qm9Y8IfuPTtN024ppzRGy3PpdtTmp085AiJI9l/XbM7dY8OV3K0BONz33r5u9
         sWJR7OrBRUznfwLrBepYnsDjFtv8DRF1R1lr3nBAzTx33/lVafIxFe5g88vpPfoL+5Ej
         F+2Ei/CjOnrU9mjdm1I61Hq/Mbc7Li29e7Y9eaHeAI64cfauBeYIslujUI1SFoTApeTZ
         vbybSV20R6wXovJQBcG5A+YeVH61yfH0E5pTq9ihCtOISM89EFK7Z2NkzitO1r68x5m0
         6nvQ==
X-Gm-Message-State: AO0yUKW1sqL+wEFc/Djti/0t3aVQ4Os9GKwlQNETwKo8zf42KXIVOwCM
        9ZJpnx9thVtdO/v+a5k15vpEhA==
X-Google-Smtp-Source: AK7set96vUGZQ9x3seGiIj9aPGfeXEqlsBW10Gzyw7TR94eZbEmXWAiaUl8btBnUMn29SmszXEwL6g==
X-Received: by 2002:aca:240c:0:b0:384:349a:15ef with SMTP id n12-20020aca240c000000b00384349a15efmr9062265oic.36.1678316977577;
        Wed, 08 Mar 2023 15:09:37 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id g10-20020a9d618a000000b006864c8043e0sm6969520otk.61.2023.03.08.15.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:09:37 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] soc: samsung: pm_domains: Implement proper I/O operations
Date:   Wed,  8 Mar 2023 17:09:29 -0600
Message-Id: <20230308230931.27261-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308230931.27261-1-semen.protsenko@linaro.org>
References: <20230308230931.27261-1-semen.protsenko@linaro.org>
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

Instead of doing in-place readl()/writel() calls fed with magic numbers,
provide dedicated read/write functions which implement proper register
accesses:
  - Get rid of magic numbers by introducing actual constants for PD
    registers
  - Rework the write function to perform a RMW operation, as PD
    registers have some bits markes as "Reserved" in TRM, which
    shouldn't be changed
  - Add helper functions for reading the STATUS reg and writing
    CONFIGURATION reg, to make user code more neat and clean

New functions are designed in such a way that it's easy to rework those
further on top of regmap API.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/soc/samsung/pm_domains.c | 42 +++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 522a43005a5a..dd1ec3541e11 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -18,6 +18,10 @@
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 
+/* Register offsets inside Power Domain area in PMU */
+#define EXYNOS_PD_CONF		0x0
+#define EXYNOS_PD_STATUS	0x4
+
 struct exynos_pm_domain_config {
 	/* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
 	u32 local_pwr_cfg;
@@ -33,6 +37,37 @@ struct exynos_pm_domain {
 	u32 local_pwr_cfg;
 };
 
+static void exynos_pd_write(struct exynos_pm_domain *pd, unsigned int reg,
+			    unsigned int mask, unsigned int val)
+{
+	u32 v;
+
+	v = readl_relaxed(pd->base + reg);
+	v = (v & ~mask) | val;
+	writel_relaxed(v, pd->base + reg);
+}
+
+static void exynos_pd_read(struct exynos_pm_domain *pd, unsigned int reg,
+			   unsigned int *val)
+{
+	*val = readl_relaxed(pd->base + reg);
+}
+
+static unsigned int exynos_pd_read_status(struct exynos_pm_domain *pd)
+{
+	unsigned int val;
+
+	exynos_pd_read(pd, EXYNOS_PD_STATUS, &val);
+	val &= pd->local_pwr_cfg;
+
+	return val;
+}
+
+static void exynos_pd_write_conf(struct exynos_pm_domain *pd, u32 val)
+{
+	exynos_pd_write(pd, EXYNOS_PD_CONF, pd->local_pwr_cfg, val);
+}
+
 static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 {
 	struct exynos_pm_domain *pd;
@@ -44,12 +79,12 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	base = pd->base;
 
 	pwr = power_on ? pd->local_pwr_cfg : 0;
-	writel_relaxed(pwr, base);
+	exynos_pd_write_conf(pd, pwr);
 
 	/* Wait max 1ms */
 	timeout = 10;
 
-	while ((readl_relaxed(base + 0x4) & pd->local_pwr_cfg) != pwr) {
+	while (exynos_pd_read_status(pd) != pwr) {
 		if (!timeout) {
 			op = (power_on) ? "enable" : "disable";
 			pr_err("Power domain %s %s failed\n", domain->name, op);
@@ -135,8 +170,7 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;
 
-	on = readl_relaxed(pd->base + 0x4) & pd->local_pwr_cfg;
-
+	on = exynos_pd_read_status(pd);
 	pm_genpd_init(&pd->pd, NULL, !on);
 	ret = of_genpd_add_provider_simple(np, &pd->pd);
 
-- 
2.39.2

