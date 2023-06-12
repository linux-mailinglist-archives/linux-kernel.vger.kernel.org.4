Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573FA72C0E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbjFLKzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbjFLKzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:55:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354533A9B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:41:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so28609535e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686566517; x=1689158517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWikiPW2cUcJbbQrNCBtpcns5WVgI8QQ3+VmuZnpaK4=;
        b=WdimDH2/FVKcMhT+9TZ5OedDdp32bCH+GeVkUFGEyEXbpSBoVt6ZhVQRnACrhTafC/
         QEoekC6P5WPvRuOdUPiBKLG9DbS/VPL7kO0LZDjCJlD43j4nHnZbmnlNIs3j68Oydypd
         8XG0a0+S6poGI0B4XhTSqr4WA5elLQrGLQsKxtMD2lUXmmw2Uqd4e+E5CTSdxcPDtm2p
         Wms+dgyiWaimnsJ/ARdiODQlAX8Wq0W/w8IhrjQVc3hVIh77fUCGhZ1UEDsHgoK7vNDw
         7MRnfRqMmHmcYZpnDjxYT6ClN+/aJOBQl8XDpXhBCd7cM0fukqnvgh870Uv+V0IRs7VN
         bQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686566517; x=1689158517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWikiPW2cUcJbbQrNCBtpcns5WVgI8QQ3+VmuZnpaK4=;
        b=hY82wN0fLp0jQeR4X+5uPG7sRyrXGPZgBWAxuJlR4vokd6rQnHjXBlT2jBKGcftH6R
         6q9+MkR33KZiNzv6la/zoj9KhbFx9CNsqSqA3WbGM4kUiwsmcb7ml92su9xk/lXwV/8s
         G18w0R0JlMGUTsxbYZ74GnK4pYcV0VQ7w/5/19nqEROukOMbFxRkFzSeeFAv/DQ08nLP
         URG2HJbViYFfviTmNEpy3DiWvw8GaQtrK7JqJpk/FdEDe+LKi8heNTcKk0owSpSdkmGU
         lrVe0pygoR2StNiU/6C6+gAQi1RIupoou8DTHDYjqawspgF/srffhTWDrucMNstuCr4C
         /hpw==
X-Gm-Message-State: AC+VfDy2BFfzKVI3//x87hnEPRXCG+7xhLcjRU2iS+HGNzi8eqGBY1sy
        MmZc+TKitu1DD3ZdSnGH3d41l7OtK4hKEPxgXqivxA==
X-Google-Smtp-Source: ACHHUZ7Ma7sCiGe8HySFslKdv1KtT+4tivJqG8hUQ1GAmKrlvPdIh5E9lsSHkY0m8a/68jOPtdU1Qg==
X-Received: by 2002:a7b:c846:0:b0:3f5:1241:6cfa with SMTP id c6-20020a7bc846000000b003f512416cfamr5607891wml.37.1686563870505;
        Mon, 12 Jun 2023 02:57:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bcd19000000b003f7ff520a14sm10829525wmj.22.2023.06.12.02.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:57:50 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 12 Jun 2023 11:57:33 +0200
Subject: [PATCH v2 16/19] clk: meson: eeclk: move bindings include to main
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-16-38172d17c27a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2909;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Wk7owxOdyJK0QkY8zyxIiRPr+2RNohL4MIdS38lxWuU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhuwLCmDkNgP+75AH+w2uzJ8MUa+VSnC3u09pDFh4
 LkrYsa+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIbsCwAKCRB33NvayMhJ0f9VD/
 41zr5oZSpYNIsDz4J2tF4zcenuEd2VZO5TngKZ1T0vgtfNZ9xs3fKw3aUnghqFAtOgWWucvf5E2hf0
 oz3uBGfuZDSYFuerVuEWXisBJjBezRTo4vEO2nc0vTntzxmYixG4/sB3Byd4sg6NvDhqhjcsi4W43a
 P/hKEulaTu9LaFVfgbIjPwuFmzMIzSDX9LTraEUEEwYAf2Y7RgyrPgk0L8s4YNokWYPj4MXhe19AWa
 2iGORoS7cA7+8fGqIEvXF3ebrPHHrf2IDFJf2JwuQBjs/5vD0+y88UpVfHDaRSFU1au/nLzcdiAimL
 kVqEJBpwFpbb47YQUKM+yLAMoXbgf+eZr3hkC91RYDUhb/gXZRe2SfpoKj7upsJjq+H7WanHriv5vm
 LQJZ1RfSCwMUY5sa2d9RDPmxVM3kQ7jdYejq8HwybB7IFD6VP7WEikhRibCOToPLkfbqKi+emMB7ye
 uzQ2pqTfVo8JV/TUenQ4A0iCO2L5f2+rAStVDSnsnK51gShnQWsMed+rGOTSmUsypKwWvDiAJFfSjX
 sa/dNFLD2+D+KBv8MjQ1WXrWap3AJJP35Ewe6MGmRvM5PfNR+NxW+hTpraSmTvKTVE3Apo+rWKZI/S
 JA788Oewcu64k5FQPByB4rU1yJc4XHyEaE0j17hBxgPqVy2es4QznoZHUFrQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 drivers/clk/meson/axg.c  | 2 ++
 drivers/clk/meson/axg.h  | 3 ---
 drivers/clk/meson/g12a.c | 2 ++
 drivers/clk/meson/g12a.h | 3 ---
 drivers/clk/meson/gxbb.c | 2 ++
 drivers/clk/meson/gxbb.h | 3 ---
 6 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 75f0912a9805..f132439a33a4 100644
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
index e0e295645c9e..ceabd5f4b2ac 100644
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
index 116fcb6ba160..1ee0774a9827 100644
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

