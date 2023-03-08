Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D066B1639
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCHXJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCHXJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:09:42 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91517302E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:09:39 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id w25-20020a4ae9f9000000b0052513fb2e09so19297ooc.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678316979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEY2uA2o2oPbWjPX8guKf4jPFyrDqDNeEX5TBL2/D90=;
        b=j6kAa0wPCPa7yN1ZIU3m6I1acUcTN9xge5yJvWmt5R58739PeZyQDvykgJ2PNvk5oE
         Ca3l8dybpeMnDf11qoqQEH0L5uHd0PVAQOjKKbnPrdBVUjaPayhpl9ni3ZkuwvWPZRt9
         VTxJjn3jd0L9M/R/rI7ML0V7h9TLwvDIEvxs4jevQK+0d0WvBy4OIyRggInkDeRJ/uq8
         mmSxX1UQKKxKmVnDHwq+uRzykwyy4fl0uOiMFutoyDxemoL/eSmmn1+uxLbG+7A1Ey4E
         9lQqBddbKl96/521JETtnFyEDRt04svDU4akF3CI16xjwSR498CqRevfaxRmlJ5WZEku
         liXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEY2uA2o2oPbWjPX8guKf4jPFyrDqDNeEX5TBL2/D90=;
        b=H3783urL7BG6f2EVZozvUUcmHExx0ZKKX3iKuFglGKFx96M8jFNO/RRonNdxvTNN2J
         YY1ZWdPk3deZrIg9fC4UJybK+upC2k7i4MEnB0rMQtR9zxi82sPLF8ByHnjokGcP06DM
         nhIo9fyNrdzlTsPItZBG2lDAkAbFnuMLllATFIaSI6jbOeLH4A56EO0nhwgaENC3J2fN
         34yo6eRrbKXDNMflxFyIZBSJCkG/CnB1DUv/lDYYJZVqKaVRyOQ2bHRgiNUP7IYNSZ0A
         CjE5tl7s7MDJOxyLp+1C1XCoeZ4Q1u8cjg2PZTetRigjLOpxNzKneKo3+0TlHdXwJDyK
         W8xw==
X-Gm-Message-State: AO0yUKWoZrgLIL3bCa+NzyxejhzuKntnTf+TSPcJ2NypmvMTT+xIsMot
        fTTvlU2ROAA5Rs6xamYzUGK0LA==
X-Google-Smtp-Source: AK7set88QmQlJhM0W50tNT2+6aJVp6JPQ62Z1IozArM9BOkPuX7PtZUWUiN/ybmikpNvxg2vWqeETQ==
X-Received: by 2002:a4a:8007:0:b0:525:25f1:af68 with SMTP id x7-20020a4a8007000000b0052525f1af68mr7533432oof.3.1678316978837;
        Wed, 08 Mar 2023 15:09:38 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id x8-20020a9d4588000000b00690e21a46e1sm6952404ote.56.2023.03.08.15.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:09:38 -0800 (PST)
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
Subject: [PATCH 5/6] soc: samsung: pm_domains: Allow PD to be a child of PMU syscon
Date:   Wed,  8 Mar 2023 17:09:30 -0600
Message-Id: <20230308230931.27261-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308230931.27261-1-semen.protsenko@linaro.org>
References: <20230308230931.27261-1-semen.protsenko@linaro.org>
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

Power Domains registers are a part of the PMU area in Exynos SoCs. The
PMU area is shared between multiple users (like WDT driver, reset
driver, PD driver, etc), and it's usually already implemented as a
system controller in the SoC device tree. Make it possible for a PD node
to be a child of that PMU syscon and utilize its shared regmap instance
in PD driver to access the PMU area registers.

When a PD node is a child of PMU, the "samsung,pd-index" DT property is
used to specify the particular power domain (instead of providing base
address in "reg" property). Implement the support for that index
property, so that the driver can look up corresponding register offsets
by that index, if the property is present. But also keep the
compatibility with existing device trees where the index property is not
defined in PD nodes and which rely on raw read/write access to the PMU
registers.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/soc/samsung/Kconfig      |  1 +
 drivers/soc/samsung/pm_domains.c | 49 ++++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 7a8f291e7704..dfe7a973b272 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -51,6 +51,7 @@ config EXYNOS_PMU_ARM_DRIVERS
 config EXYNOS_PM_DOMAINS
 	bool "Exynos PM domains" if COMPILE_TEST
 	depends on (ARCH_EXYNOS && PM_GENERIC_DOMAINS) || COMPILE_TEST
+	select MFD_SYSCON
 
 config SAMSUNG_PM_CHECK
 	bool "S3C2410 PM Suspend Memory CRC"
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index dd1ec3541e11..ec630a151247 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -17,6 +17,8 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 /* Register offsets inside Power Domain area in PMU */
 #define EXYNOS_PD_CONF		0x0
@@ -25,6 +27,10 @@
 struct exynos_pm_domain_config {
 	/* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
 	u32 local_pwr_cfg;
+
+	/* Power domain offsets in PMU area, for each power domain index */
+	const unsigned int *pd_offsets;
+	size_t pd_offsets_num;
 };
 
 /*
@@ -35,22 +41,32 @@ struct exynos_pm_domain {
 	void __iomem *base;
 	struct generic_pm_domain pd;
 	u32 local_pwr_cfg;
+
+	unsigned int offset;
+	struct regmap *pmureg;
 };
 
 static void exynos_pd_write(struct exynos_pm_domain *pd, unsigned int reg,
 			    unsigned int mask, unsigned int val)
 {
-	u32 v;
-
-	v = readl_relaxed(pd->base + reg);
-	v = (v & ~mask) | val;
-	writel_relaxed(v, pd->base + reg);
+	if (pd->pmureg) {
+		regmap_update_bits(pd->pmureg, pd->offset + reg, mask, val);
+	} else {
+		u32 v;
+
+		v = readl_relaxed(pd->base + reg);
+		v = (v & ~mask) | val;
+		writel_relaxed(v, pd->base + reg);
+	}
 }
 
 static void exynos_pd_read(struct exynos_pm_domain *pd, unsigned int reg,
 			   unsigned int *val)
 {
-	*val = readl_relaxed(pd->base + reg);
+	if (pd->pmureg)
+		regmap_read(pd->pmureg, pd->offset + reg, val);
+	else
+		*val = readl_relaxed(pd->base + reg);
 }
 
 static unsigned int exynos_pd_read_status(struct exynos_pm_domain *pd)
@@ -133,6 +149,8 @@ static int exynos_pd_parse_dt(struct exynos_pm_domain *pd)
 	struct device *dev = pd->dev;
 	struct device_node *np = dev->of_node;
 	const char *name;
+	u32 index;
+	int ret;
 
 	variant = of_device_get_match_data(dev);
 	pd->local_pwr_cfg = variant->local_pwr_cfg;
@@ -143,9 +161,22 @@ static int exynos_pd_parse_dt(struct exynos_pm_domain *pd)
 	if (!pd->pd.name)
 		return -ENOMEM;
 
-	pd->base = of_iomap(np, 0);
-	if (!pd->base)
-		return -ENODEV;
+	ret = of_property_read_u32(np, "samsung,pd-index", &index);
+	if (!ret) {
+		if (index >= variant->pd_offsets_num)
+			return -EINVAL;
+		if (!dev->parent)
+			return -ENODEV;
+
+		pd->offset = variant->pd_offsets[index];
+		pd->pmureg = syscon_node_to_regmap(dev->parent->of_node);
+		if (IS_ERR(pd->pmureg))
+			return PTR_ERR(pd->pmureg);
+	} else {
+		pd->base = of_iomap(np, 0);
+		if (!pd->base)
+			return -ENODEV;
+	}
 
 	return 0;
 }
-- 
2.39.2

