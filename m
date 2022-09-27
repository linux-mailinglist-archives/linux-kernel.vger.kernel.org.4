Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160795ECB11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiI0Rif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbiI0RiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:38:06 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CF41E1CEA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:38:02 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q17so11695959lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Mi1c5O8t+ABf8uuzMkxRRUW8s/gQxdD68rNUaiMpPrM=;
        b=y/iHV/TKjBAEd4WGn82lvnfxtBRxHV9iFFz6/38Iuu7LkokYHC5h82nE0ZR7Q+/BRb
         E1QZ9lo0kms1RhomBpLBaVNd6dbXDJcmbVj7cMQqcPvuTt+MCzEizXwShIBnteRaoIJc
         u32ENujVXpOA+KHhfp6y4N93VLtVTKtxJmwcA+oWm/yrAteiBcOimnxy/2gNGKqGKUlG
         CzokHV5l1r1xjH++6DwYx1HCZR1KG21O6vLmSgOWG8d7ikZHTYql4CCaMQTaKp+ey5LF
         jkB96W5dCFhU2a+Q+4+HUMjSuny/1Pi+4tdBl9nhzuKmQ7qVv3iKNt5hfqJNA8XYkiIe
         kf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Mi1c5O8t+ABf8uuzMkxRRUW8s/gQxdD68rNUaiMpPrM=;
        b=ZYWjhskdONidL1DWetP5VX0SR1c5+fvwNq1iuYDk46yxi61ac5j4dYdpo+C2gryp16
         hIxQJ65bfPMgjBwapd23TLK3uQ5eIyEzXEjRL0KrGM6CN2y72N1YInUnMjoD4Qn2v4m/
         J+vj84381HjrMBS9qTo5PIqIfJXBCkqzOIA8Ea2KqGax73gSTdaoFF3BF2yU35ua/xw/
         8oGmkXZgDWJjVXe/0EctuoQUcG82iGlb+9JJ+YGhFPxP3z4JpGVRIwQaZM2DLX5vbUjo
         rZhR2lvLBcBrIwbHRwvsf1Qe4VFwZmZuHzgq3IujBuup2Zngiw8oSVgJrv90odSkmiqa
         0hag==
X-Gm-Message-State: ACrzQf3oR+DfdhRh3KsoU+/lzFpKp3uS5l7Ye5jrf74ljWel2sVSGA5O
        z8ve2oa0uEoFmjJaJu92CrBOVQ==
X-Google-Smtp-Source: AMsMyM4JuMfZU3TDcDw9cMWwJO3IeGLjeshApIUkPIdhLXvGMbfOjIpa4+rYJTUpuD4IbpOFWH93+w==
X-Received: by 2002:a05:651c:b0d:b0:26c:5556:81bc with SMTP id b13-20020a05651c0b0d00b0026c555681bcmr9853834ljr.495.1664300281627;
        Tue, 27 Sep 2022 10:38:01 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac246ec000000b00498f570aef2sm218879lfo.209.2022.09.27.10.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:37:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 09/34] dt-bindings: pinctrl: qcom,ipq6018: correct BLSP6->BLSP0 functions
Date:   Tue, 27 Sep 2022 19:36:37 +0200
Message-Id: <20220927173702.5200-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pin controller driver has BLSP functions from 0 to 5, not 1 to 6.
Add missing blsp0_i2c, blsp0_spi (already used in ipq6018-cp01-c1) and
blsp0_uart.  Drop blsp6_i2c and blsp6_spi.

This fixes dtbs_check warning:

  ipq6018-cp01-c1.dtb: pinctrl@1000000: spi-0-state: 'oneOf' conditional failed, one must be fixed:
    'bias-pull-down', 'drive-strength', 'function', 'pins' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
    'blsp0_spi' is not one of ['adsp_ext', 'alsp_int', .....

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. New patch
---
 .../devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
index 0bd1aded132d..76698cd97e8c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
@@ -72,12 +72,12 @@ patternProperties:
         enum: [ adsp_ext, alsp_int, atest_bbrx0, atest_bbrx1, atest_char,
                 atest_char0, atest_char1, atest_char2, atest_char3, atest_combodac,
                 atest_gpsadc0, atest_gpsadc1, atest_tsens, atest_wlan0,
-                atest_wlan1, backlight_en, bimc_dte0, bimc_dte1, blsp1_i2c,
-                blsp2_i2c, blsp3_i2c, blsp4_i2c, blsp5_i2c, blsp6_i2c, blsp1_spi,
+                atest_wlan1, backlight_en, bimc_dte0, bimc_dte1, blsp0_i2c, blsp1_i2c,
+                blsp2_i2c, blsp3_i2c, blsp4_i2c, blsp5_i2c, blsp0_spi, blsp1_spi,
                 blsp1_spi_cs1, blsp1_spi_cs2, blsp1_spi_cs3, blsp2_spi,
                 blsp2_spi_cs1, blsp2_spi_cs2, blsp2_spi_cs3, blsp3_spi,
                 blsp3_spi_cs1, blsp3_spi_cs2, blsp3_spi_cs3, blsp4_spi, blsp5_spi,
-                blsp6_spi, blsp1_uart, blsp2_uart, blsp1_uim, blsp2_uim, cam1_rst,
+                blsp0_uart, blsp1_uart, blsp2_uart, blsp1_uim, blsp2_uim, cam1_rst,
                 cam1_standby, cam_mclk0, cam_mclk1, cci_async, cci_i2c, cci_timer0,
                 cci_timer1, cci_timer2, cdc_pdm0, codec_mad, dbg_out, display_5v,
                 dmic0_clk, dmic0_data, dsi_rst, ebi0_wrcdc, euro_us, ext_lpass,
-- 
2.34.1

