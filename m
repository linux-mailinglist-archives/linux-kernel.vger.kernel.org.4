Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8356036FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJSAPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJSAPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:15:11 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F1C6450
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:14:22 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w3so10758773qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPxQuovvewOKNM4sFmdgepf8my0rffxD1wdRkvUTkNM=;
        b=VA+9xuESM5YZgThqah9h4HIpCC0WfZso/X53WR5ufIAa33CBT9P1x+7A/Lmv3Q5EwH
         HjpkoIK/nUOroSs9MG76RsAQFYAOSNmznKdRNKoUw2waB44OiBz7AlB39GSHMlwlHtMy
         Hx1RZ+AkHCWrAk+1Ne438tlzPadBMAUfZlRw3Mr38Tv6Sju2/1h2Y1wQ6mfB6tsvCSRK
         uZL0zeJkXRUhu8aewSq+76ERgPoJX7ohzBkWQNkZ3Ox4B5ra6+G0N9tsQO68/jn/xYl1
         zNDKDGD09b7WZV6veO1rv/IoIS/09QufXnLaAFWdm76MlmHJmOHlqev9nbt2hG/2uPw4
         ppgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPxQuovvewOKNM4sFmdgepf8my0rffxD1wdRkvUTkNM=;
        b=eA63buUt5hf3vU+AY/eMOiqGGuEeOGNPJHnga4Ir6xVu7v4HX3ruZvwiSC0Eg3E5rQ
         D6svwHe32IE83s180g5XaJvOJxcg5qEayYieh3x7r/hUXvW89U7mbH/yZJgpnPMn6+fC
         9kpLSrgSe0N6P9Qz/gflXoXvxPzFZf/gDFTBPK+tXAifK5NDZNIk8b2tTEgEcJPPMKG7
         27JBohS5wb+DS82yvlqQoF5SX2boiPgMAp69jYGFpuJTvI6kN4tHB59BoUV/TpxZoE9/
         3dD57HGZY/f3Nzb82/WEZiKfVGMZtygKr1z4KPHmHiu3r71YwW7OQX2R9+tdTmXaRxSd
         c8+g==
X-Gm-Message-State: ACrzQf3MgGCay/xxqy9qXXVNXvs/iyEfWCI9tM+bjfAdFX8WUwVn1b7J
        g3AGvMpHVOJcFmOJS4HUO3/XGg==
X-Google-Smtp-Source: AMsMyM6sqQiSuSUa8nNzqBDCoaZ5KEW52W616gyu+bUqBd/yW3+bLy6I/6ZU1Si0p/RMg6g0KYROKw==
X-Received: by 2002:a05:622a:44f:b0:39c:dcf5:3eeb with SMTP id o15-20020a05622a044f00b0039cdcf53eebmr4300152qtx.675.1666138443893;
        Tue, 18 Oct 2022 17:14:03 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id ay40-20020a05620a17a800b006bb78d095c5sm3381240qkb.79.2022.10.18.17.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 17:14:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/4] arm64: dts: qcom: sc7180: revert "arm64: dts: qcom: sc7180: Avoid glitching SPI CS at bootup on trogdor"
Date:   Tue, 18 Oct 2022 20:13:49 -0400
Message-Id: <20221019001351.1630089-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019001351.1630089-1-krzysztof.kozlowski@linaro.org>
References: <20221019001351.1630089-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e440e30e26dd6b0424002ad0ddcbbcea783efd85 because it
is not a reliable way of fixing SPI CS glitch and it depends on specific
Linux kernel pin controller driver behavior.

This behavior of kernel driver was changed in commit b991f8c3622c
("pinctrl: core: Handling pinmux and pinconf separately") thus
effectively the DTS fix stopped being effective.

Proper solution for the glitching SPI chip select must be implemented in
the drivers, not via ordering of entries in DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. New patch

Not tested on hardware.

Cc: Doug Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 27 +++-----------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index eae22e6e97c1..8f6e19bd6a99 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -880,17 +880,17 @@ &sdhc_2 {
 };
 
 &spi0 {
-	pinctrl-0 = <&qup_spi0_cs_gpio_init_high>, <&qup_spi0_cs_gpio>;
+	pinctrl-0 = <&qup_spi0_cs_gpio>;
 	cs-gpios = <&tlmm 37 GPIO_ACTIVE_LOW>;
 };
 
 &spi6 {
-	pinctrl-0 = <&qup_spi6_cs_gpio_init_high>, <&qup_spi6_cs_gpio>;
+	pinctrl-0 = <&qup_spi6_cs_gpio>;
 	cs-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
 };
 
 ap_spi_fp: &spi10 {
-	pinctrl-0 = <&qup_spi10_cs_gpio_init_high>, <&qup_spi10_cs_gpio>;
+	pinctrl-0 = <&qup_spi10_cs_gpio>;
 	cs-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
 
 	cros_ec_fp: ec@0 {
@@ -1422,27 +1422,6 @@ pinconf {
 		};
 	};
 
-	qup_spi0_cs_gpio_init_high: qup-spi0-cs-gpio-init-high {
-		pinconf {
-			pins = "gpio37";
-			output-high;
-		};
-	};
-
-	qup_spi6_cs_gpio_init_high: qup-spi6-cs-gpio-init-high {
-		pinconf {
-			pins = "gpio62";
-			output-high;
-		};
-	};
-
-	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high {
-		pinconf {
-			pins = "gpio89";
-			output-high;
-		};
-	};
-
 	qup_uart3_sleep: qup-uart3-sleep {
 		pinmux {
 			pins = "gpio38", "gpio39",
-- 
2.34.1

