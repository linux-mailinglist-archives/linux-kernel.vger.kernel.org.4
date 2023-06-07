Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32FE725C72
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbjFGK6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbjFGK5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:57:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792811BFE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:57:05 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so31916295e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686135397; x=1688727397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Lndesv8TY3zpBho5S2AngSkgWp3EvCO8f19S2YQJhs=;
        b=DxaMTiMgIx5dN3zV+ZMqE8LLzYkYT1VN+1ne0nkw0Yl27ZmYWq9ZAKjwza+cBlfJIf
         q0yWYSLNWVjc2GG9a0hyuwtziz7iioXGY5TCR6DJslIYSTw42Pu1UplRJermhQW1WZdj
         3DQ1+St5ZWtbtBBmWNPDkgga9lS7ckl8ZCTzfo1z/stTpVRgxEbs8ziowpgFrAMjdWmx
         aQOid92d/Ci+469aT0PPQY2KNgHtK5q0ZgLsNvxkj1UfOfiSEMuckjyn4XhvAIg0Z7PA
         bxoPa6nXM960/5xkGurlFAUy8jZmN34VP299rLrmhXd8bnJl1AL67K1qqtRyR31vJt4m
         gEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686135397; x=1688727397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Lndesv8TY3zpBho5S2AngSkgWp3EvCO8f19S2YQJhs=;
        b=Gx3ngC6NCich3cGVwHcBle1GzUZmL0w+DGLeFgg5nLJDtIVXZIgFJIzM0vN+jMAEkd
         4us9zjdHlg5hjpRzjBwC1S3xLE5OeOpgXTZUuaN+ouW17NtpxY9XWeVh0Hb2s1HLJK19
         qkEIDtoGtfhG2bhUwnRGLtuna6A7DJ50tXpoh3jYCEUhuJvOUIp7mwLblpUt7/k7teg5
         tv4gRwi0Uv2iJ/ISRgrohhFJ1unRZjjV+n4NtbRH4zHQFw4/VQrvOQZFzFrMHcZvnSP/
         2t5otNfAkFb8Bc8nsgIjEScHSYZS58va1QSMmE58EeVBIqmQPdWow13WVtM9GCHsolLl
         Dx4Q==
X-Gm-Message-State: AC+VfDwHAOThHBxicoUPQFcczLSh+KXhMURGNc2XKe7BTqm2gJOxDIL2
        cLo783drUqT4LSmECYjZBr+pUw==
X-Google-Smtp-Source: ACHHUZ6qSi78NbG1hu2vzKtTf12eb69NQQtGbYW7nE0tFNONCsXLL3uknwiFhY9dZBDSdt34V45Iug==
X-Received: by 2002:a1c:6a12:0:b0:3f0:b1c9:25d4 with SMTP id f18-20020a1c6a12000000b003f0b1c925d4mr4424961wmc.21.1686135397444;
        Wed, 07 Jun 2023 03:56:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f60faa4612sm1761879wmd.22.2023.06.07.03.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:56:37 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 12:56:26 +0200
Subject: [PATCH 15/18] clk: meson: eeclk: move bindings include to main
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-15-9676afa6b22c@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2909;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Foo+HUE/eeDMaQAqSm4Rc+RrlD9xCOzKuPcU4sFaqN8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgGJUPXYHLirTnD19GQyIsNf/oWC2voT8fLRY8cnN
 urdOb+yJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIBiVAAKCRB33NvayMhJ0aGaEA
 CRfY8iUu4QckYLYREX9gjzW9IR1xEz7rQPyJNCSx63yWFhSTFUdg17+oH2gdZysKSO0RZuNj81yM/o
 BO5/x3L506v1TtCXcK5suxuRRJC+BnQ/A8EqXxZXCOCEMgUDqEx0PQbywoPyH4muEsRRlVHi0uMkEo
 pzIaD0cj8pyBM5obSanPuoqBXcy00gnzHF2Gx71EFaV2iUIdYrMEJW9dyfiIn1fG1nUgWVrLvPS0Sh
 /ntViKcnd6lcWmsQFp7njQerYjBt//hNkjQ5Qemz2jbj0qYkxqqzxVJm3xxfx/a/5IMI4Cxh/vAGAT
 QxN3/dJMetpkwTK1r69+TsQie3xj7ug7mKBOKOqMX4Y8xrCkrD4Ek7qF7M5jlKtTvFTYxeW1Sz2OdZ
 9gZtoBZYQk5RNgKAxNQ+9Jtk9Z00rdOrrKzFk6v9rUvr0jqNUFPltYJlftW4a3C52sOeXmxaROYZnn
 ZPysxzcGy4a4uy/VCvzq1/NFgVT/sUiqzkaGfPk71+s/a1FrcTTQ3zAuyt5txvYYkzn9AhFe0HsQhM
 Rheykp0rgEjj0kgn9pgyjKe6nlYuXMsB72lW56Jh5bp74/APuT4pgoXOgv/VlXLJGrCE4O2UstNe6H
 r7o1oMHLDG5t/JaYDVPYyStW4FiLXvkNR2c5oeAYKV74BoxdIqG2lWgo8OLA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/clk/meson/axg.c  | 2 ++
 drivers/clk/meson/axg.h  | 3 ---
 drivers/clk/meson/g12a.c | 2 ++
 drivers/clk/meson/g12a.h | 3 ---
 drivers/clk/meson/gxbb.c | 2 ++
 drivers/clk/meson/gxbb.h | 3 ---
 6 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index d159b47c7579..ddac23a5d535 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -21,6 +21,8 @@
 #include "axg.h"
 #include "meson-eeclk.h"
 
+#include <dt-bindings/clock/axg-clkc.h>
+
 static DEFINE_SPINLOCK(meson_clk_lock);
 
 static struct clk_regmap axg_fixed_pll_dco = {
diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
index ed157532b4d7..624d8d3ce7c4 100644
--- a/drivers/clk/meson/axg.h
+++ b/drivers/clk/meson/axg.h
@@ -102,7 +102,4 @@
 #define HHI_DPLL_TOP_I			0x318
 #define HHI_DPLL_TOP2_I			0x31C
 
-/* include the CLKIDs that have been made part of the DT binding */
-#include <dt-bindings/clock/axg-clkc.h>
-
 #endif /* __AXG_H */
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index ee1ac3542ff4..4e218cbc457f 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -25,6 +25,8 @@
 #include "meson-eeclk.h"
 #include "g12a.h"
 
+#include <dt-bindings/clock/g12a-clkc.h>
+
 static DEFINE_SPINLOCK(meson_clk_lock);
 
 static struct clk_regmap g12a_fixed_pll_dco = {
diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index 8e08af3c1476..f11ee3c59849 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -126,7 +126,4 @@
 #define HHI_SYS1_PLL_CNTL5		0x394
 #define HHI_SYS1_PLL_CNTL6		0x398
 
-/* include the CLKIDs that have been made part of the DT binding */
-#include <dt-bindings/clock/g12a-clkc.h>
-
 #endif /* __G12A_H */
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 4849189cefbc..15b6c6c3114e 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -17,6 +17,8 @@
 #include "meson-eeclk.h"
 #include "vid-pll-div.h"
 
+#include <dt-bindings/clock/gxbb-clkc.h>
+
 static DEFINE_SPINLOCK(meson_clk_lock);
 
 static const struct pll_params_table gxbb_gp0_pll_params_table[] = {
diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 798ffb911103..ba5f39a8d746 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -112,7 +112,4 @@
 #define HHI_BT656_CLK_CNTL		0x3D4 /* 0xf5 offset in data sheet */
 #define HHI_SAR_CLK_CNTL		0x3D8 /* 0xf6 offset in data sheet */
 
-/* include the CLKIDs that have been made part of the DT binding */
-#include <dt-bindings/clock/gxbb-clkc.h>
-
 #endif /* __GXBB_H */

-- 
2.34.1

