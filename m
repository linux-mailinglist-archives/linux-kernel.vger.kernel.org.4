Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F81A6001A8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJPRCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJPRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:02:06 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBDE3847E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:01:52 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a24so6507769qto.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5gqgC6F8H12j/3mwOFaxBkWJqMnqVFVlaFtZkq3pf0=;
        b=gsUmE+nULY6/Lzc5BbTVKPOZpdnYP+tOIEB4Q2VWfIoFnJpeE6CG+VkyfsamiBrWZL
         n7w3JlX58KP6f0jNuL3e0QGQRnVpeWUBztNTiOoMEi/0jQlYnN9/5jRhubZMh9jZhxp0
         Rh1XdqqJImC7850R7lcQBKxPpvOD1P/qDTyAdSvruW2v/7mAgn/kW95FI2IVuxrCgIFs
         BvUy4WJ61jnoFR4bKFoICoAXtEaRFLQ6+UBAdyAC+TXYFL8SxHxAAssHk9O7YUbLKL2r
         xhuY+vTuLqbuNmhtihQWxpH4LIgEKfF2o4KqPmpIsYYufyfn8KkTN9ilJ1WTeNFUIf9r
         YSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5gqgC6F8H12j/3mwOFaxBkWJqMnqVFVlaFtZkq3pf0=;
        b=okPWu2I22An8S5uij/7jFrjAm05FO45FFLJ/Gu4ueagriI0PQtn9+EvWWin+MH2G5v
         nGh0NOY+vkps9lvsXwqeiHN3I0ILS5wViDw9JNtql/SKTXhxtDZWCPmUq77UeXXNBJNp
         4fQzd9Ry2uKhtYjiDTAvcZpvCRTKOEqQG/zocM9UJBCoUosPKLrceakBOuSuWDXbkOz0
         FUnmOOG0pSeC/4laPFVPS+FRUVW98IYDCWRJ4bICrw/JRfyw3jDQ3kW1ukWRnTrGXgym
         fTzQ8e+ACC/MBgQsboAIJ9IaUqRU42vpZwJ1OGQ5HYkxGMm+FZE/pqFHoBhwU4Co2Vbp
         CGBA==
X-Gm-Message-State: ACrzQf3sH3ugAFm+p5gW1SOiEpLbSbXFpk78cgTdFnwe23VZvDzdSD4J
        n5PUxbr10OnymBFPKPfdTrICcg==
X-Google-Smtp-Source: AMsMyM53OmRA4ObAYoOSIskKOETcbIAnLXc4ARQQx1Iih/kopd483oGiM2kai+VDftRGNHD4qzys4w==
X-Received: by 2002:a05:622a:90:b0:39c:e637:912 with SMTP id o16-20020a05622a009000b0039ce6370912mr2690224qtw.109.1665939704981;
        Sun, 16 Oct 2022 10:01:44 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:01:42 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 09/34] dt-bindings: pinctrl: qcom,ipq6018: correct BLSP6->BLSP0 functions
Date:   Sun, 16 Oct 2022 13:00:10 -0400
Message-Id: <20221016170035.35014-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
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

The pin controller driver has BLSP functions from 0 to 5, not 1 to 6.
Add missing blsp0_i2c, blsp0_spi (already used in ipq6018-cp01-c1) and
blsp0_uart.  Drop blsp6_i2c and blsp6_spi.

This fixes dtbs_check warning:

  ipq6018-cp01-c1.dtb: pinctrl@1000000: spi-0-state: 'oneOf' conditional failed, one must be fixed:
    'bias-pull-down', 'drive-strength', 'function', 'pins' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
    'blsp0_spi' is not one of ['adsp_ext', 'alsp_int', .....

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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

