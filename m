Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED0C6E3735
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDPKTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjDPKSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:18:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C72030DF;
        Sun, 16 Apr 2023 03:18:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id jg21so56458674ejc.2;
        Sun, 16 Apr 2023 03:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681640300; x=1684232300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsVMP+nc4oNcZ87McW4OVdy6DpQdiSat54tBtHLhBBY=;
        b=nfr1zVEw9kPnLlYUrcbByybp16B3MuFjdqImbC7ms95NuitM7HO538K0NAk+bYVGm+
         VMfIGm5E5jFbUYTbOhrKD/2XnlznH5U1I/XmsKu5kq9+yPUCQztZKlJ5S7+tHyCHRLdp
         pLNOWMIuBaP969GCwvUkFO6A+9hbN3sT0yhfbjvzyetl/obzZqNpcQdTFk/lpmhlbTnb
         WpnuV3fHhpRne6stvD2t6TvjxTORCuTkrGwhFFkFctwvBlJvi1BLivYa5XK9bRExHFDj
         YCVhGMK7QkfpJlp9R2Jdh0UQ8vje0IiCc+JWfPDLD6Pgy2kcaU4J2dK4wI5joxk1ubv2
         hD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681640300; x=1684232300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsVMP+nc4oNcZ87McW4OVdy6DpQdiSat54tBtHLhBBY=;
        b=K6gtg03kLBKmVGopiY+CCd6PxQifBDI3dFFEMrfhRqQtt7BQDGly3JgB2kMHh5crYP
         WsFqImEQHr3QAMIcYlxRGCw7jaxXGAhyhVS0q4nwXXcNz1GLvF7FW4ZCEc6Wrd5hDM9X
         loeTXbgI7iZKAncGT6Ip7p5i04u0j3Be8eK5r7v9zftzzi186pLW/IvUaeBsRAjlAjnG
         i5xXYl9PM6qvtFHcg+u13T8ej0Jn8fR7T/7X7+um4GykmAcWa3OLNfyHcfMPr8d6RzxE
         fUkCm4pIkRR59B6VDm2JDr0PwUOZlmuZafNbj4ePHAYpmZLmJxaLuqCmg+Mh2+K9tQxR
         hOoQ==
X-Gm-Message-State: AAQBX9efsdy7aWrtx6Ec27Bou6Wa/0HLo3vok4E1gjy6CeC7e7bXsCMi
        eSNzdzqG4cue1Z1ndkzqy60=
X-Google-Smtp-Source: AKy350Y2lZk3tbzxpDLIO3N9WFJh/eVD/q3CDUxh62fYMbYn+3t5erUqoeMqEi2LTAa6ReHdAtk0pQ==
X-Received: by 2002:a17:907:8a1e:b0:94f:695f:b177 with SMTP id sc30-20020a1709078a1e00b0094f695fb177mr422788ejc.30.1681640299547;
        Sun, 16 Apr 2023 03:18:19 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id r20-20020a056402019400b0050476da5160sm4427443edv.45.2023.04.16.03.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:18:19 -0700 (PDT)
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
Subject: [PATCH 06/12] clk: samsung: Re-add support for Exynos4212 CPU clock
Date:   Sun, 16 Apr 2023 12:16:18 +0200
Message-Id: <20230416101624.15866-7-aweber.kernel@gmail.com>
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

This is effectively a revert of commit c9194fb623b0 ("clk: samsung:
Remove support for obsolete Exynos4212 CPU clock"); the driver
has changed significantly since then, prompting this re-make.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/clk/samsung/clk-exynos4.c | 44 +++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 22009cb53428..9655f46db95c 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -138,7 +138,8 @@
 /* the exynos4 soc type */
 enum exynos4_soc {
 	EXYNOS4210,
-	EXYNOS4X12,
+	EXYNOS4412,
+	EXYNOS4212,
 };
 
 /* list of PLLs to be registered */
@@ -1205,6 +1206,24 @@ static const struct exynos_cpuclk_cfg_data e4210_armclk_d[] __initconst = {
 	{  0 },
 };
 
+static const struct exynos_cpuclk_cfg_data e4212_armclk_d[] __initconst = {
+	{ 1500000, E4210_CPU_DIV0(2, 1, 6, 0, 7, 3), E4210_CPU_DIV1(2, 6), },
+	{ 1400000, E4210_CPU_DIV0(2, 1, 6, 0, 7, 3), E4210_CPU_DIV1(2, 6), },
+	{ 1300000, E4210_CPU_DIV0(2, 1, 5, 0, 7, 3), E4210_CPU_DIV1(2, 5), },
+	{ 1200000, E4210_CPU_DIV0(2, 1, 5, 0, 7, 3), E4210_CPU_DIV1(2, 5), },
+	{ 1100000, E4210_CPU_DIV0(2, 1, 4, 0, 6, 3), E4210_CPU_DIV1(2, 4), },
+	{ 1000000, E4210_CPU_DIV0(1, 1, 4, 0, 5, 2), E4210_CPU_DIV1(2, 4), },
+	{  900000, E4210_CPU_DIV0(1, 1, 3, 0, 5, 2), E4210_CPU_DIV1(2, 3), },
+	{  800000, E4210_CPU_DIV0(1, 1, 3, 0, 5, 2), E4210_CPU_DIV1(2, 3), },
+	{  700000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4210_CPU_DIV1(2, 3), },
+	{  600000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4210_CPU_DIV1(2, 3), },
+	{  500000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4210_CPU_DIV1(2, 3), },
+	{  400000, E4210_CPU_DIV0(1, 1, 3, 0, 4, 2), E4210_CPU_DIV1(2, 3), },
+	{  300000, E4210_CPU_DIV0(1, 1, 2, 0, 4, 2), E4210_CPU_DIV1(2, 3), },
+	{  200000, E4210_CPU_DIV0(1, 1, 1, 0, 3, 1), E4210_CPU_DIV1(2, 3), },
+	{  0 },
+};
+
 #define E4412_CPU_DIV1(cores, hpm, copy)				\
 		(((cores) << 8) | ((hpm) << 4) | ((copy) << 0))
 
@@ -1233,6 +1252,11 @@ static const struct samsung_cpu_clock exynos4210_cpu_clks[] __initconst = {
 			CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1, 0x14200, e4210_armclk_d),
 };
 
+static const struct samsung_cpu_clock exynos4212_cpu_clks[] __initconst = {
+	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MPLL_USER_C,
+			CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1, 0x14200, e4212_armclk_d),
+};
+
 static const struct samsung_cpu_clock exynos4412_cpu_clks[] __initconst = {
 	CPU_CLK(CLK_ARM_CLK, "armclk", CLK_MOUT_APLL, CLK_MOUT_MPLL_USER_C,
 			CLK_CPU_NEEDS_DEBUG_ALT_DIV | CLK_CPU_HAS_DIV1, 0x14200, e4412_armclk_d),
@@ -1326,11 +1350,15 @@ static void __init exynos4_clk_init(struct device_node *np,
 		samsung_clk_register_fixed_factor(ctx,
 			exynos4x12_fixed_factor_clks,
 			ARRAY_SIZE(exynos4x12_fixed_factor_clks));
-		samsung_clk_register_cpu(ctx, exynos4412_cpu_clks,
-				ARRAY_SIZE(exynos4412_cpu_clks));
+		if (soc == EXYNOS4412)
+			samsung_clk_register_cpu(ctx, exynos4412_cpu_clks,
+					ARRAY_SIZE(exynos4412_cpu_clks));
+		else
+			samsung_clk_register_cpu(ctx, exynos4212_cpu_clks,
+					ARRAY_SIZE(exynos4212_cpu_clks));
 	}
 
-	if (soc == EXYNOS4X12)
+	if (soc == EXYNOS4412 || soc == EXYNOS4212)
 		exynos4x12_core_down_clock();
 
 	samsung_clk_extended_sleep_init(reg_base,
@@ -1363,8 +1391,14 @@ static void __init exynos4210_clk_init(struct device_node *np)
 }
 CLK_OF_DECLARE(exynos4210_clk, "samsung,exynos4210-clock", exynos4210_clk_init);
 
+static void __init exynos4212_clk_init(struct device_node *np)
+{
+	exynos4_clk_init(np, EXYNOS4212);
+}
+CLK_OF_DECLARE(exynos4212_clk, "samsung,exynos4212-clock", exynos4212_clk_init);
+
 static void __init exynos4412_clk_init(struct device_node *np)
 {
-	exynos4_clk_init(np, EXYNOS4X12);
+	exynos4_clk_init(np, EXYNOS4412);
 }
 CLK_OF_DECLARE(exynos4412_clk, "samsung,exynos4412-clock", exynos4412_clk_init);
-- 
2.40.0

