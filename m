Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CCB6E372E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjDPKSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjDPKSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:18:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CCF171F;
        Sun, 16 Apr 2023 03:18:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94e8cdbc8ebso249921266b.2;
        Sun, 16 Apr 2023 03:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681640295; x=1684232295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p71y//uR+D7cixeMALk8VhvdwbZ2ImHTuWWM7+KMyYU=;
        b=Vvbpd3apjcdGYBnyB3Nhd5Y6xlhA5EkmAlFoD8DEnfMfacrcRRo8QqumBwvb2UB/C9
         rRGwKoZymC0IODiNlnIGs0znkZlbbGAT/FtJlQyoLZh7dJ0/hK1R7ajWRi+0MCTexsPB
         G2cQuDK0Vc1VZ51VHIqYjozjmaLkXgzQMno+oEoqI1IixpekROyLp+xHu0MZcZjXYAzf
         D0KHyD079yN6VHQPIobK/Hd8KQrQEeBEn3gNRVcxVuyKTlDD0Sgk28lGSZrfHI8dS7uR
         eOEuN0uJqJN0VNcwmDbMEBq0C4+PkmNLM3qz9Uo+6TWfzxcaDs/po3OavbT7Rs4X3WZh
         10TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681640295; x=1684232295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p71y//uR+D7cixeMALk8VhvdwbZ2ImHTuWWM7+KMyYU=;
        b=Y4hUxBk5Q7V9tXrqSj520ofzFRaUmng6zJ1wSoYN4LausF3jaOx8ZQpBDZgtAmvxWm
         OirNql/gtHNiAt7obulpssEsgHy0PHsXLxEuWqfc9utAnmYwBLxiMUoxdZalDPHkWnAr
         JIU8OJQk/Bdu+04/v5+287kOr5lcQBaGiGSy49yWybgEqQTtgTyF7mr1HBpP5TuGocJ1
         0Chlp5T8D/xmXvZ50aC5cHttKLFOLebUlUxshlBgA7ul5F34uQ5W4UphyCV6SDUq/Dmu
         VPLF7drlNuV0SdQBR0zEqT/5cA14TgFtKl/tmGqvpncXkm5+oAWJPd1Yf9CRLQUZHbJ4
         87vA==
X-Gm-Message-State: AAQBX9fSK4dDdG0tvwGu/M7pHKgTB+USwkYwHkgYxE3MA7HcGWYDWEez
        YBhrksY8EX6euGgwKJKiZak=
X-Google-Smtp-Source: AKy350ZBTe9qI+j2VYHMJ0JIoNndaUrUtPEre2RPlaNr7FWkp/9AM44D2kjX2mWsuvvMsIe5MMAjgQ==
X-Received: by 2002:aa7:df0d:0:b0:504:9345:ffa4 with SMTP id c13-20020aa7df0d000000b005049345ffa4mr11519364edy.21.1681640295273;
        Sun, 16 Apr 2023 03:18:15 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id r20-20020a056402019400b0050476da5160sm4427443edv.45.2023.04.16.03.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:18:14 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 04/12] soc: samsung: Re-introduce Exynos4212 support
Date:   Sun, 16 Apr 2023 12:16:16 +0200
Message-Id: <20230416101624.15866-5-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416101624.15866-1-aweber.kernel@gmail.com>
References: <20230416101624.15866-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform was originally dropped in commit bca9085e0ae9 ("ARM:
dts: exynos: remove Exynos4212 support (dead code)"), as there were
no boards using it.

We will be adding a device that uses it, so add it back.

This effectively reverts commit c40610198f35 ("soc: samsung: Remove
Exynos4212 related dead code").

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/soc/samsung/exynos-pmu.c  |  9 +++++++++
 drivers/soc/samsung/exynos-pmu.h  |  2 ++
 drivers/soc/samsung/exynos4-pmu.c | 13 +++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 732c86ce2be8..f3437db2fbdc 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -57,6 +57,12 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 
 	if (pmu_data->powerdown_conf_extra)
 		pmu_data->powerdown_conf_extra(mode);
+
+	if (pmu_data->pmu_config_extra) {
+		for (i = 0; pmu_data->pmu_config_extra[i].offset != PMU_TABLE_END; i++)
+			pmu_raw_writel(pmu_data->pmu_config_extra[i].val[mode],
+					pmu_data->pmu_config_extra[i].offset);
+	}
 }
 
 /*
@@ -79,6 +85,9 @@ static const struct of_device_id exynos_pmu_of_device_ids[] = {
 	}, {
 		.compatible = "samsung,exynos4210-pmu",
 		.data = exynos_pmu_data_arm_ptr(exynos4210_pmu_data),
+	}, {
+		.compatible = "samsung,exynos4212-pmu",
+		.data = exynos_pmu_data_arm_ptr(exynos4212_pmu_data),
 	}, {
 		.compatible = "samsung,exynos4412-pmu",
 		.data = exynos_pmu_data_arm_ptr(exynos4412_pmu_data),
diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
index 5e851f32307e..1c652ffd79b4 100644
--- a/drivers/soc/samsung/exynos-pmu.h
+++ b/drivers/soc/samsung/exynos-pmu.h
@@ -20,6 +20,7 @@ struct exynos_pmu_conf {
 
 struct exynos_pmu_data {
 	const struct exynos_pmu_conf *pmu_config;
+	const struct exynos_pmu_conf *pmu_config_extra;
 
 	void (*pmu_init)(void);
 	void (*powerdown_conf)(enum sys_powerdown);
@@ -32,6 +33,7 @@ extern void __iomem *pmu_base_addr;
 /* list of all exported SoC specific data */
 extern const struct exynos_pmu_data exynos3250_pmu_data;
 extern const struct exynos_pmu_data exynos4210_pmu_data;
+extern const struct exynos_pmu_data exynos4212_pmu_data;
 extern const struct exynos_pmu_data exynos4412_pmu_data;
 extern const struct exynos_pmu_data exynos5250_pmu_data;
 extern const struct exynos_pmu_data exynos5420_pmu_data;
diff --git a/drivers/soc/samsung/exynos4-pmu.c b/drivers/soc/samsung/exynos4-pmu.c
index cb35103565a6..f8092190b938 100644
--- a/drivers/soc/samsung/exynos4-pmu.c
+++ b/drivers/soc/samsung/exynos4-pmu.c
@@ -86,7 +86,7 @@ static const struct exynos_pmu_conf exynos4210_pmu_config[] = {
 	{ PMU_TABLE_END,},
 };
 
-static const struct exynos_pmu_conf exynos4412_pmu_config[] = {
+static const struct exynos_pmu_conf exynos4x12_pmu_config[] = {
 	{ S5P_ARM_CORE0_LOWPWR,			{ 0x0, 0x0, 0x2 } },
 	{ S5P_DIS_IRQ_CORE0,			{ 0x0, 0x0, 0x0 } },
 	{ S5P_DIS_IRQ_CENTRAL0,			{ 0x0, 0x0, 0x0 } },
@@ -191,6 +191,10 @@ static const struct exynos_pmu_conf exynos4412_pmu_config[] = {
 	{ S5P_GPS_ALIVE_LOWPWR,			{ 0x7, 0x0, 0x0 } },
 	{ S5P_CMU_SYSCLK_ISP_LOWPWR,		{ 0x1, 0x0, 0x0 } },
 	{ S5P_CMU_SYSCLK_GPS_LOWPWR,		{ 0x1, 0x0, 0x0 } },
+	{ PMU_TABLE_END,},
+};
+
+static const struct exynos_pmu_conf exynos4412_pmu_config[] = {
 	{ S5P_ARM_CORE2_LOWPWR,			{ 0x0, 0x0, 0x2 } },
 	{ S5P_DIS_IRQ_CORE2,			{ 0x0, 0x0, 0x0 } },
 	{ S5P_DIS_IRQ_CENTRAL2,			{ 0x0, 0x0, 0x0 } },
@@ -204,6 +208,11 @@ const struct exynos_pmu_data exynos4210_pmu_data = {
 	.pmu_config	= exynos4210_pmu_config,
 };
 
+const struct exynos_pmu_data exynos4212_pmu_data = {
+	.pmu_config	= exynos4x12_pmu_config,
+};
+
 const struct exynos_pmu_data exynos4412_pmu_data = {
-	.pmu_config		= exynos4412_pmu_config,
+	.pmu_config		= exynos4x12_pmu_config,
+	.pmu_config_extra	= exynos4412_pmu_config,
 };
-- 
2.40.0

