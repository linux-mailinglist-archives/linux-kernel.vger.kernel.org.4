Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA01A6F38B9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjEAT4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjEATzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:55:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B028D3595;
        Mon,  1 May 2023 12:55:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc37e1525so3232419a12.1;
        Mon, 01 May 2023 12:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682970939; x=1685562939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLSZpIAboHzgVbT7Sw0USchSefiPMjo/APH/aRCJgwc=;
        b=kvNa1cCQSsyShGbcmSY9LtTR/ubbhUC58zLuiuiIxvmZM0CntKrxcRvuVC2Ys3Cord
         uZU1v5xy2iggLb8nXB4c1gkkXMjs0XysxwuLz1OxaUEZ5Np1FvfLTPnYZbOiLLJLSDgH
         9VF7pb2fyZpmvaVBkpRjpkK/m1Bt0jSbU5m5BWynuQxYvPa6HZF5nm+pwpma+AQ4vf2u
         dZ0AsZZukBTz4gn3Z6o1cbsy/92VFHYaJ5LcEioERsRxzojKhtta/S43docCpH4Kfu6N
         FhD6rAYp5z9Ie5VTrmysUyfiSJcfuX0xtWWiRaFTWXX0G54Re78DcanjBvgsBxYRqcbu
         pSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970939; x=1685562939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLSZpIAboHzgVbT7Sw0USchSefiPMjo/APH/aRCJgwc=;
        b=b0H3wFsCqZiuKwIi6kEYN/HIf2JNRDS1QYC5ZW0MRwbL5C1RxqR2GAvOrk+nuiYgnZ
         aDSOEH52Cdah0Bgx70bOJS8ixrSPCH2ZgnYo0gm766t6NwaeYAM0Ylyr+R+E+sR7+NBG
         5Y28A7fascJIFrYvsROVEeepDHRhVxuL86VkTcOse/5UfiTVpN0LoZV2Aku20zl2EcDb
         zguvZPJGtky9S2ar1LnAa5Pfd9S6H9cptbwdq0HHbNgr+tL6eD2fYIRH+07gSs6bz/6D
         P16oN0X7GnqpvHkeBAd/cSbCzpu3uc5oTfEj8zZBM4QiDtxwL2jXmjMw8s5Sf9EurSJx
         n9Ug==
X-Gm-Message-State: AC+VfDxD7nEOQamZourC/MOYzD6rft0Bdtj0tx+EiZeiM1kiTZU8H22h
        lgaCeOpkJdx2sNY+CJMFsdY=
X-Google-Smtp-Source: ACHHUZ5ZCGOrq9T2/dMqh+EebCYn41HBamo7hGHDONnr9quhO7MswQKOIIb0fUuOgrvewpALqyEN9w==
X-Received: by 2002:a17:906:99c5:b0:94e:9a73:1637 with SMTP id s5-20020a17090699c500b0094e9a731637mr13471342ejn.75.1682970938918;
        Mon, 01 May 2023 12:55:38 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id og36-20020a1709071de400b009600ce4fb53sm6333650ejc.37.2023.05.01.12.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:55:38 -0700 (PDT)
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
Subject: [PATCH v3 04/13] soc: samsung: Re-introduce Exynos4212 support
Date:   Mon,  1 May 2023 21:55:16 +0200
Message-Id: <20230501195525.6268-5-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230501195525.6268-1-aweber.kernel@gmail.com>
References: <20230501195525.6268-1-aweber.kernel@gmail.com>
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

Support for the Exynos4212 SoC was originally dropped as there were
no boards using it. We will be adding a device that uses it, so add
it back.

This reverts commit c40610198f35e8264f9175dafe74db6288a07eda.

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
2.40.1

