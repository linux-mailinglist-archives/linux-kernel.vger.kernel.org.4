Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBC0725C74
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbjFGK7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbjFGK5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:57:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC1C1FC7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:57:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f7e7fc9fe6so24455045e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686135398; x=1688727398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A26FY2EOWGHMttoswYCrKkWs1qsnhgkNG3ne6FDcRAY=;
        b=f56RxJaY8iD0G/krUqQOnU0Zg4nKsTPfvhCYAvkQryp6ijzM6zjS6vvl4yS0ZPqR+S
         94pljyqD14G0wz9XEPyq2DHt7A/IiD2eLKR2gnq5/ZYbuTBAhWaWJEJ1ncffhqNJv1My
         ztV1xsgMEo/744bayRVmZqrdr2rF9dGRnYbB2SAT/Y/brL9Pg0PExTLdzBqFz9HzDCpP
         IfSrh8658s86/m+Knv4+WyUysrJExFN5k5pTfcRjlGGTdE5/GSFOUeDQhVZ0clVl9HB9
         329Y+Kz6nPyB8LxK051nFlKFQBGLcuR5XWVP/prFYvYMM2j3DAcH5qFqYI0IStlujE8N
         JXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686135398; x=1688727398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A26FY2EOWGHMttoswYCrKkWs1qsnhgkNG3ne6FDcRAY=;
        b=cfHkfOzC+TALaxPiwFX0h5+9sKXCkjCu31k8iOL73zuwyWovL8t7SBZUIfHkTZm1B3
         aziuIzk3M755uDGJz634ZdWjyRnKPVTgm+7L8+5JprYeY1IizYqkfIL7ySeX271mi3Sg
         67VR9erMcFAUeasu6nn44CDUWAVdPzw2CvlWPnMJeSkr6M+bDuZlSAAQcRA/450ZoJlu
         p/AIBzYmbl+NOx2iNJKdfLvha9Kx1yQjAGvXvt5ZpDjKnzqp/kwROgZifBzrkB3S6kHW
         qDwo6ybwP+lyxgSz78oOzsA6/JQgKxVJagX+rqdgLwyAr1UBE7KZmZF+xx7bcd9545cg
         PZmg==
X-Gm-Message-State: AC+VfDy27aJn8QioXrQ6Fj7IYD5L1uPozYy5rvXHaXMBPMc2A0JY3MSQ
        N/JJN52V4xlLGlr+/1oLNQEGEJxZNv7/JJ4CkwTaBw==
X-Google-Smtp-Source: ACHHUZ7oGQhv6TBlxkdm8bfP4/QWswGA555Bc61XsXoDipcsadeEQhT/1eu2V6ruKae68LgSIcsB/w==
X-Received: by 2002:a7b:cd98:0:b0:3f1:6fb3:ffcc with SMTP id y24-20020a7bcd98000000b003f16fb3ffccmr4535802wmj.22.1686135398362;
        Wed, 07 Jun 2023 03:56:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f60faa4612sm1761879wmd.22.2023.06.07.03.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:56:38 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 12:56:27 +0200
Subject: [PATCH 16/18] clk: meson: a1: move bindings include to main driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-16-9676afa6b22c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=MiorzJT8BJ3U4Im9MU5+c0Np88TD4TVfN8gYXiV/42w=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgGJUAVyrz2mTU4oIpoEcazaItKh5+V7OxNlXOYag
 mLvLgq2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIBiVAAKCRB33NvayMhJ0cN5D/
 4pAks67QJDuntqf61aBfWfAA1TyVWw/j9Y06kT3GiaWc5Ywdc9WwoInDtzgO98acEu6GPDFeQXEs1w
 TPosYPMpHEuGgRQam+tKtxdZBi0JsbYUc1BHCUqkFsHlJaHMIyNKy7SmqUj0b6l/T84uSG99FCp26g
 Ll65/4eVXTTwluQ8aK3RESWJtmV6h0SmsOOiFj9+p4A+hHarwTXbLXQj5nClqI8IF4gMmBTVcKtHcG
 QgIKrlh3idqyZD13pl8uL3Z5Nf6aPjzELDT8rsatb6KwJIXRHq1+XdVboAS0mTtZLIckzE/06GnzBp
 hAXiZEpv88EoGloOx5RV2eNLkuANdRdc9UPseOGsr4YytDyCEUKYRoo1HywptfE9ILLecKA61WEWEA
 pqTf15L99qqmOM5kqZidfV+JeFM/h0Ejev11Dg+hM/TkT60XUPR5JfxJpBPFyfv24JHJTTEQJ36ZKU
 JPFl69AiHFMxikHl7s6EL+ryQ48hvlZpYiZGdZ0GrpnyhrOBFW9IldJyJWKvUH7Yjt68EtEA0KZg3S
 pNDvF4KXwPSv9nbZ/gqrbt9mkqktE41uQ+weC/81CA2ONmPAgM3pLlliNdnqkriaiCXYiwIyLZIf34
 64HQuI5B2TzQtSWK2DFPKRyGnjELLWvxzLDBozvbISGTUq6J0OLSzT8N+lcA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 094246cb5f6c..ef0881b8ee07 100644
--- a/drivers/clk/meson/a1-peripherals.c
+++ b/drivers/clk/meson/a1-peripherals.c
@@ -14,6 +14,8 @@
 #include "clk-dualdiv.h"
 #include "clk-regmap.h"
 
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
index 25d102dc8a5d..9a757862abab 100644
--- a/drivers/clk/meson/a1-pll.c
+++ b/drivers/clk/meson/a1-pll.c
@@ -13,6 +13,8 @@
 #include "a1-pll.h"
 #include "clk-regmap.h"
 
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

