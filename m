Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D205F667F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiJFMrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiJFMra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:47:30 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF116A287F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:47:14 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a29so2563093lfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=s5gqgC6F8H12j/3mwOFaxBkWJqMnqVFVlaFtZkq3pf0=;
        b=Lwpe0mq0h/arV/xbQkB3ZRK3XmTt1o6/eZ4hBjZLx348P58TebbXDewigdSIyPhuD9
         MN154PnAVyjOIYjnmhSefMTd8RkRULMKCsIwXUQdYm9Nj/TodMaUr1bSSjX0CncfoYe+
         J2xkTCyXjPECHf2QGiR3bCi+1CfWndPN/bGjKc2+6tf+0cHGnh4OFCkgxDHUy84PbyUb
         ZvHcmJ0jKzQI9KAeU8fSt07/P5Gi4IKH6OvIlayyI1Kj8+DkBgfUIwEA0pdGM4AtKG9C
         qT4Qyogy8PP6DOlHY1nDey9FWjD94A1+4CwVt2ApOLFPuQhAg4195lPuj/AhTleu3ACv
         2v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=s5gqgC6F8H12j/3mwOFaxBkWJqMnqVFVlaFtZkq3pf0=;
        b=A2c3vD81AS1gVAW3hecXgM4btn8Mqn/WDvd0y/rydVIj/Ur2TgKzUKEF41TGcIVvJc
         XXCOFCEEz3Ge/7dKnu1jmazJQBChcTJFWGg5DTKBFQTMhp7o1qWAe+gkFPn1Hc3/MVex
         wE38vHVDGfqMBHLHi4Plqk01/o3rcOzlVEnLhs0W51Y1cbbGtqVjyaZQ+D41ZA7PaPIg
         8JvWcnolPUWYPEg5WX0lRA2jtVNOwxG9jU4EM8GGkjssOUYtGL+MGhqxqaV++azz8gjK
         7ge6+xMgckqav2n6sn1uA41eHRBnNPa9UKgt4GmPB+zK/aOJscSrJDy4njvfp+1OtlMr
         ukvw==
X-Gm-Message-State: ACrzQf2RJpFVP0ADsPufbkxw5AIOqrLeadS81os1OQze/wkDkqy2CFTm
        C5yoa859hi3uEX1yzmXEEIRSjg==
X-Google-Smtp-Source: AMsMyM4YEjNrnR7YCnLMuTw/uAtiFNA/YNA65F0PON8RftEs68BdD043RPvwZB3GH+ZEVOa1raUm1Q==
X-Received: by 2002:a05:6512:32c7:b0:4a2:4544:120d with SMTP id f7-20020a05651232c700b004a24544120dmr1968542lfg.598.1665060432279;
        Thu, 06 Oct 2022 05:47:12 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b00497a3e2a191sm2687659lfb.112.2022.10.06.05.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:47:12 -0700 (PDT)
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
Subject: [PATCH v4 09/34] dt-bindings: pinctrl: qcom,ipq6018: correct BLSP6->BLSP0 functions
Date:   Thu,  6 Oct 2022 14:46:34 +0200
Message-Id: <20221006124659.217540-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
References: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
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

