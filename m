Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E506001BE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJPRDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJPRCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:02:21 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382034055C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:05 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o22so5429759qkl.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1g7suIt+4OBLitlMz8jW4GyQ0Mo1+XrQ4m2hVDoC2ZQ=;
        b=nBdIwQhkZcSuoiCgYM0rGg3E6nFS+WzXRiQtfW02hC9OJ5X2MAfwJfePYASTDTjtPW
         S5S3Ae/T9o/oxnTFn7ndcGKbXqqoQC0EXzsSAhEO5t63z/6djB726wiObCd8xAU795BK
         5uvd0IjdYg5dKcpDltTpv0vBUQe6gBcYZfnBTrlSsp9BkMfpBsFCY0nJ21N//jqeUjh5
         f3qbH6Y+U+8oQkIYHw7dIVkZVe/U8/s2mnCkRSaV6ADD63GQs/bftraT4kKLPRR7hFOP
         8oWOjSnRqCnE+pgrO8itNGqvDk/jW+OVoKMxqDIV1NoyBNkpoRqXD3UPihh/HSytJMFj
         2gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1g7suIt+4OBLitlMz8jW4GyQ0Mo1+XrQ4m2hVDoC2ZQ=;
        b=fjLmVeg/o6CQi3vhgztYnxjmf5fOpRy828ysEm8xw+Q85hMzSdvSVXr9Rs7WpQRirg
         NMNGPsp9s34VPvCSztUoGpjxU7PlgsQLGf7sXRtuzI9drABiGQP6HTC59yHgjMstPDth
         b4Hfxz3S4Ap44otxtIbxdbbL+uNnq+fA2NlDY8Q9kPwpn8SAuzfgHEdZHy3r8QcvGDSK
         xpB5izfcnnPsZhDSmkBb6H6EF+4883n6s2Mb97K0q8gni79VURIm6wwtuBZjG1mb84yC
         D/7qwuTjBelqpVpgwOb73n9NJ8Et4YNEOjRylkzOc0DhmgDvWibFG7N8Sp7+/WKt0SXA
         AVGA==
X-Gm-Message-State: ACrzQf3+8PBLVs6XVreJFSe6vW6m4ZhhsWGo/6wSZPIYUJqKjHPBqrDs
        PVOzvXlKjjIannVIetAvphg7tw==
X-Google-Smtp-Source: AMsMyM6ZKUQ+dkF/EYdCwAT1zGVXiIuUYSc1dmc4slV3GG4VUqY3gnLBP80ItEpqitWdmOuPKhnLOg==
X-Received: by 2002:a05:620a:24c9:b0:6ee:d791:9f84 with SMTP id m9-20020a05620a24c900b006eed7919f84mr5111360qkn.490.1665939724776;
        Sun, 16 Oct 2022 10:02:04 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:02:03 -0700 (PDT)
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
Subject: [PATCH v5 16/34] dt-bindings: pinctrl: qcom,msm8226: add functions and input-enable
Date:   Sun, 16 Oct 2022 13:00:17 -0400
Message-Id: <20221016170035.35014-17-krzysztof.kozlowski@linaro.org>
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

The MSM8226 pinctrl driver supports input-enable, blsp_i2c4, blsp_uart4
and sdc3 functions and DTS already uses it:

  qcom-msm8226-samsung-s3ve3g.dtb: pinctrl@fd510000: 'blsp1-i2c1', 'blsp1-i2c2', 'blsp1-i2c3', 'blsp1-i2c4', 'blsp1-i2c5' ...
  qcom-apq8026-lg-lenok.dtb: pinctrl@fd510000: touch-state: 'oneOf' conditional failed, one must be fixed:
    'input-enable' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml         | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
index 8e634d07eb67..1d89bc85c3d9 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
@@ -65,19 +65,17 @@ $defs:
           Specify the alternative function to be configured for the specified
           pins. Functions are only valid for gpio pins.
         enum: [ gpio, cci_i2c0, blsp_uim1, blsp_uim2, blsp_uim3, blsp_uim5,
-                blsp_i2c1, blsp_i2c2, blsp_i2c3, blsp_i2c5, blsp_spi1,
+                blsp_i2c1, blsp_i2c2, blsp_i2c3, blsp_i2c4, blsp_i2c5, blsp_spi1,
                 blsp_spi2, blsp_spi3, blsp_spi5, blsp_uart1, blsp_uart2,
-                blsp_uart3, blsp_uart5, cam_mclk0, cam_mclk1, wlan ]
+                blsp_uart3, blsp_uart4, blsp_uart5, cam_mclk0, cam_mclk1, sdc3,
+                wlan ]
 
       bias-pull-down: true
-
       bias-pull-up: true
-
       bias-disable: true
       drive-strength: true
-
+      input-enable: true
       output-high: true
-
       output-low: true
 
     required:
-- 
2.34.1

