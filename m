Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2290A6E38C4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjDPNf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjDPNfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:35:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839C3270D;
        Sun, 16 Apr 2023 06:35:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-504eac2f0b2so4020985a12.3;
        Sun, 16 Apr 2023 06:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681652142; x=1684244142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p71y//uR+D7cixeMALk8VhvdwbZ2ImHTuWWM7+KMyYU=;
        b=pJXFgk+NWdlcUWqn0CAJER8vvEVEsgWfuzc+d4oDR+4JPfI0l+9p13UP24yjnlotOQ
         QA+hvrFp47yzq08fnypXcq+33V6ao+pTGROzOzbDVlcdqay/CcY0jdmknsIEJk67LRC1
         BHntnCxsLYiJPmnRxY0zx14QO/tGrqQvcaEh5XwW1/9OLDLy/M0af93NVFdvBsh52Zm4
         bvo2lz2v2q21biuHZ6i4g+8PIUreOfZNZRnNnovx6PkAq6kUIxRvQ8xWUYPVP9sYp2QI
         3NGcbfx1UZ3/gW6hg9YPch/cZiSdGoNcKBatd/1JXdhUBNpyjtTJ8azkYheGV1JbJyTb
         oD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681652142; x=1684244142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p71y//uR+D7cixeMALk8VhvdwbZ2ImHTuWWM7+KMyYU=;
        b=f+i9wsGQvEHp7h+a7oTebfac3ZfEPhh9P4+Z0d9kPcO+3aughIy5CShNNoOADKS3xi
         1Eiw4VcR34u2z5NIq22+Rj0YakvDC9MasWzrH6AhEDDMYuBpplglR1oWTCEFzl2ensjs
         cgBHcJAfY3s6KHq44StHW5iJvVCPzYrfgipPqjur6YtvmrFZLMao9275sF+bLOJ78V0A
         4ZP0djHcMIlq0k+HD1HNgEVFKd+2pXYwxf1KdjIdJ9m25GTn1SSUAiQRSDDxhN62npbv
         JthY3bLyi0HqzOAonmZN2oueo88Q8OtpTbhe81bOaVkhwTIL0uORJ4fhNPgNumGvqW5N
         cEeA==
X-Gm-Message-State: AAQBX9fxxXegxd7loVR3ECTxHdV4ck/wPH8zamHn19dLWHShFEegEDDe
        hOlIhVlP7zCLglA9w3ip4Qw=
X-Google-Smtp-Source: AKy350a4bDFc1nDQ4TpPm8FPIuPeDQN6bY3okrym98knbaDGqTAnZNubzYyTwKGklnso2Fml0g+Smw==
X-Received: by 2002:aa7:c90b:0:b0:506:7385:9653 with SMTP id b11-20020aa7c90b000000b0050673859653mr10582713edt.39.1681652141742;
        Sun, 16 Apr 2023 06:35:41 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id gn23-20020a1709070d1700b009373f1b5c4esm5122958ejc.161.2023.04.16.06.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 06:35:41 -0700 (PDT)
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
Subject: [PATCH v2 04/12] soc: samsung: Re-introduce Exynos4212 support
Date:   Sun, 16 Apr 2023 15:34:14 +0200
Message-Id: <20230416133422.1949-5-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416133422.1949-1-aweber.kernel@gmail.com>
References: <20230416133422.1949-1-aweber.kernel@gmail.com>
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

