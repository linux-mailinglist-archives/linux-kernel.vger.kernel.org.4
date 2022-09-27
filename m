Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206A55ECB2E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiI0Rjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiI0Ris (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:38:48 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A631E45BD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:38:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b6so11705066ljr.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ce1RLC8Lp4whfUOlQ7LnP5iwovECtMTj8NmWNaZ5bG8=;
        b=oJkUwCAgT3gSmz67OllTriTcdGxpwOlWQkIJu6B4x/RbFPurBhwHF7vuCWPuhjQJNy
         fbPfV1M0odRal4T7BQFLNYH4CiVpA1U9Mc9WEzXNTrTHNX0mdkr1U19ejJC8S3QNESRU
         tZux00lg6TXeqJNtZ3XXb5GvIk7tgpALDB6x7+yv4vSXWCUdAPzqhyl/nhVM2By8f0yi
         uq0dEgr8nFoLOfTJDD1HOFtflCpESW22E3fu6AnXoOpKMcdakx9LHaafH5noFJGQA2d1
         9d+2Wp19F5QoM+7fmmcyb79r72bAdPth4TL50YdQ7RKk1uS0I6K5yhMc6hY3txtYgR6Z
         QXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ce1RLC8Lp4whfUOlQ7LnP5iwovECtMTj8NmWNaZ5bG8=;
        b=aaWIKWCOfQ1WpHL9axHZok2B2l5o2O5Ln2asQ7Mbv0u7k1lL+8jfo66a8JDkWeqILA
         SYr+yY/mJdUdZhdFAhsaT6qpS6KPdYhj1atZ6biF/X/iXbCgIyiieNmkobaq3J2LD9Xf
         zfTXj219w00JBXoNZzKaVs+qZjiMRKfBFcQqqZxQF+Yt/VPMh+XYBKRuIc+iGzg6E5nY
         jc6+yEg8w9IsZQRL7LTdAp6tb8XBkJVupbnKzyzV8nEUADGHUUTX92OqfLQFr0IZ+eqx
         itUz01YUeL1lhSq+WcZU/2wq4IfQikEZzRJM+vIi4f+69GTiVVgyJcqAMDUllC/KyRy3
         GKzA==
X-Gm-Message-State: ACrzQf1ZN446COYE6joUW05yafmhRx7f9WDp+JfbDL2fKdzqVLaT8+/D
        UbWGMeX9vS1cwPYWnzSJoW/fDQ==
X-Google-Smtp-Source: AMsMyM5wprF7tgdmJ47jhCu372/u4zL0YN4y3SgTEhUzs9YOkmW+i7SP84eyFfmmO8P+443NS+qMcA==
X-Received: by 2002:a05:651c:114a:b0:25d:5ae6:42a4 with SMTP id h10-20020a05651c114a00b0025d5ae642a4mr9908009ljo.255.1664300310655;
        Tue, 27 Sep 2022 10:38:30 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac246ec000000b00498f570aef2sm218879lfo.209.2022.09.27.10.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:38:27 -0700 (PDT)
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
Subject: [PATCH v3 16/34] dt-bindings: pinctrl: qcom,msm8226: add functions and input-enable
Date:   Tue, 27 Sep 2022 19:36:44 +0200
Message-Id: <20220927173702.5200-17-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
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
---
 .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml         | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
index a64e2dbb0972..9c2dbc1e31fe 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
@@ -79,9 +79,10 @@ $defs:
           Specify the alternative function to be configured for the specified
           pins. Functions are only valid for gpio pins.
         enum: [ gpio, cci_i2c0, blsp_uim1, blsp_uim2, blsp_uim3, blsp_uim5,
-                blsp_i2c1, blsp_i2c2, blsp_i2c3, blsp_i2c5, blsp_spi1,
+                blsp_i2c1, blsp_i2c2, blsp_i2c3, blsp_i2c4, blsp_i2c5, blsp_spi1,
                 blsp_spi2, blsp_spi3, blsp_spi5, blsp_uart1, blsp_uart2,
-                blsp_uart3, blsp_uart5, cam_mclk0, cam_mclk1, wlan ]
+                blsp_uart3, blsp_uart4, blsp_uart5, cam_mclk0, cam_mclk1, sdc3,
+                wlan ]
 
       drive-strength:
         enum: [2, 4, 6, 8, 10, 12, 14, 16]
@@ -90,13 +91,10 @@ $defs:
           Selects the drive strength for the specified pins, in mA.
 
       bias-pull-down: true
-
       bias-pull-up: true
-
       bias-disable: true
-
+      input-enable: true
       output-high: true
-
       output-low: true
 
     required:
-- 
2.34.1

