Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6041F72BEB1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjFLKTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjFLKSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:18:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B118C229DB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:59:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6e4554453so29625655e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686563871; x=1689155871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyo0FhQ7XOXgYkNho+HgsYkKUoW/UgZhudYs6M4MPKs=;
        b=RWiPKv/M2EYOqQB6JKLzC/zCIY3Hz8Lpc8Zf+HkoN/rETLDlPRvlqL6gjyXjxUIrhz
         bVyF1t+fRJEkShd5CHOtdRhgLkf60tOXEfkpsMni3L3df1CdW8GTp+vL+LO7IVkyyykx
         o92hNe4scI4jDSHMnVqeWe79Dpb75F7nPcb0UVftbIMjpHMZAdFHzdf3npWCSRFQGaQj
         XZxFzUVdahl2KK+p2Ll4IwskzEWlfdnMIrVxjt5tigLf/oDMPR7RszzJIS/PskQDHVjY
         gX+jHAUU8xxDAfKRbfLyQXabjdT8Bt21PL1Ma3r2suhXpJ5v3vKAUEBKjp18MtarCxZp
         eZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686563871; x=1689155871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyo0FhQ7XOXgYkNho+HgsYkKUoW/UgZhudYs6M4MPKs=;
        b=SKT9k993hUQAYCxoIk8yiQ4sWBDyBqd0ZQyPSNwXIam09H7YYgCcLYnFO3EEooNHvs
         AKGYhd3w009EsVwlxCXd4v+pPv0r1J9Fhla7GE/rOKCvZLLwmux9FbjsRPYeBLxOZS/+
         xCQTB8B+x3da986sfm9wnlwx0UOjZk9R32vPppFQisIVHkMcCELrnwtNcxaKRGgqnnyI
         g/Ux+JmnPlxng9UtJ9iYjKIxFEneYgCSL8gAeyVO0MEOnmWcHSHyo0EE7g7Ar2AujvMa
         YYrRHQRT0+X/lUQ1ixhMYWKNCaYj2AE+EjGXU85pb6QXqYkkdNrJluMZk/z1KxUexb38
         DChg==
X-Gm-Message-State: AC+VfDyPaixmSjU+bAH7WhvxsA6bfRJG+YWk0OQrT8yoBIFRj0aFbwLx
        9kmxcCJ01GIDRTldzKrGeXYTwQ==
X-Google-Smtp-Source: ACHHUZ7nRn842WraXSM0e0AmXwPJUihlWt2csYM1vOV1fHNOeGdqbkyV9qWueR8NInzv5ptlCp7rsw==
X-Received: by 2002:a7b:c5d9:0:b0:3f8:1f52:f3a9 with SMTP id n25-20020a7bc5d9000000b003f81f52f3a9mr677410wmk.23.1686563871454;
        Mon, 12 Jun 2023 02:57:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bcd19000000b003f7ff520a14sm10829525wmj.22.2023.06.12.02.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:57:51 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 12 Jun 2023 11:57:34 +0200
Subject: [PATCH v2 17/19] clk: meson: a1: move bindings include to main
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-17-38172d17c27a@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2210;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PVjNU0BFL3v5nElcK2LM4t1DhuDqjvK9OI92vIL/cWA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhuwM+BlDJlKDagRCqPDz2e3TGvZ89ru6eh6k+49v
 Phb2xGCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIbsDAAKCRB33NvayMhJ0TgcD/
 40D5uJuUodT5O6+WIbQdYf/sg36P12vVX6TsDUSnt2Tudhk2+rweNoTwMH5NS4V5W1gIdH3NdnBHKl
 bM/hra5ObXKp+u8hSwnrZy/uWw7FJ6xeHw079dgoa1g1Lrd4fy/17uMstRJE4vtE7tXHYsyZqUtOtO
 4wKRXP8cSGA/EI54kzWQmbUAV1Qsv/QWMsd8guj6d+uY2EEsrUXTIxSRwoh2U1GC8dEWq2Fbur+rIG
 toN1DU7wjka2QT0eMI4Sbdm2oQQ7MUHHztCQFs9tw9IxvRIAblMOCArx88B9k79JvSX1ycXgcYmETb
 Nhk0Y4Lc5mtzi0BOloURo2z6tccmwxMlM8sIqyvAFanG40cEFuWGV68CFKOACjOgC9HW2H++ICBAGf
 iYiyFmPflYErw/vTiW1jBH8tzkPgWjNs/3FY/AYJozsneH6BH8bRP/QQM9wbEzFySUB7pTZH+GWFEy
 MK+1ZIdSMmjRA/rr7ks2WaabjGe1xYlJqDau6pM54H6jR2SPhyg67Pab6Aa8W7Ar+QLtIIQmFKy3CN
 BJ7OVRLG8noiHu1wkf6h+gXyqiVkeaVNrrloKoVmCjEAZeRCSPhp6cegpMHqqnPwRFGp01Fe8D3OfE
 dFBVEhIgX2xCaWu/rGrrFWb0XFcYvnGNfiMP8Vz3FEpZKHN5nrfavh1xgA9w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the clock ids are no more defined in private headers,
cleanup and include the dt-bindings headers from the main
driver file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/a1-peripherals.c | 2 ++
 drivers/clk/meson/a1-peripherals.h | 3 ---
 drivers/clk/meson/a1-pll.c         | 2 ++
 drivers/clk/meson/a1-pll.h         | 3 ---
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
index a5cab418736a..070ea1427d73 100644
--- a/drivers/clk/meson/a1-peripherals.c
+++ b/drivers/clk/meson/a1-peripherals.c
@@ -15,6 +15,8 @@
 #include "clk-regmap.h"
 #include "meson-clkc-utils.h"
 
+#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
+
 static struct clk_regmap xtal_in = {
 	.data = &(struct clk_regmap_gate_data){
 		.offset = SYS_OSCIN_CTRL,
diff --git a/drivers/clk/meson/a1-peripherals.h b/drivers/clk/meson/a1-peripherals.h
index 842b52634ed0..26de8530184a 100644
--- a/drivers/clk/meson/a1-peripherals.h
+++ b/drivers/clk/meson/a1-peripherals.h
@@ -43,7 +43,4 @@
 #define PSRAM_CLK_CTRL		0xf4
 #define DMC_CLK_CTRL		0xf8
 
-/* include the CLKIDs that have been made part of the DT binding */
-#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
-
 #endif /* __A1_PERIPHERALS_H */
diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
index 25e6b567afd5..7de7d78c3813 100644
--- a/drivers/clk/meson/a1-pll.c
+++ b/drivers/clk/meson/a1-pll.c
@@ -14,6 +14,8 @@
 #include "clk-regmap.h"
 #include "meson-clkc-utils.h"
 
+#include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
+
 static struct clk_regmap fixed_pll_dco = {
 	.data = &(struct meson_clk_pll_data){
 		.en = {
diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
index 0add1c7ea9f5..4be17b2bf383 100644
--- a/drivers/clk/meson/a1-pll.h
+++ b/drivers/clk/meson/a1-pll.h
@@ -25,7 +25,4 @@
 #define ANACTRL_HIFIPLL_CTRL4	0xd0
 #define ANACTRL_HIFIPLL_STS	0xd4
 
-/* include the CLKIDs that have been made part of the DT binding */
-#include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
-
 #endif /* __A1_PLL_H */

-- 
2.34.1

