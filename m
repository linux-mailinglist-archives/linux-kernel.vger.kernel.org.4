Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6301E5F6946
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJFOJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJFOIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:08:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B34AE872
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:07:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bu25so2895310lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LNOm/g59h82MMqu2oiIUDJ7a82zJhV/3uCYr2M3cOac=;
        b=U3TQm24Bw8serEWeoG9+QjBcWSKVW2eeDD7yuqsEsbxNdvjOsrnIEEntxAUpNH/MCA
         KCNrKMggCcENZdT9C1xtcqx1vjWkYeQdyHEso80QUol+aCBJQz9hzVML9uLGMOSe0VGg
         i+gkBpYp3xXhbVriZaiMEBCFltO7CZds3KGAvGiKJJ5zmdDEsG1qCzggkjsaGDnLZZA4
         s+OKtFpkA5COwtZhDagsG5OFXQEAAdFbgYDBFZVc1dYJVH5ra7gFRYVZUkiTNJWCEpvV
         tNwxvoLjlCUk3jSNUcmCEbAddJVhwhYX00pDSz0Koxi3T7GkAXMNUA4S3RaVHvCymvOe
         r1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LNOm/g59h82MMqu2oiIUDJ7a82zJhV/3uCYr2M3cOac=;
        b=7KdOjYQ/NABv+B6P6SK+1EKTO2TzXkOpyKXL6M7N3PKHk6bF9/nvv902k6UvHphY4k
         cDZFOeBFrpAxhx/QnMX+zAA+8YPLwF6RYq9U1nsv7SCEk45BqxwKDxYGeGqIqZYKGxjb
         ML15OtZsVXc1LDvlkmW8wyTBbZWGqCN0TOOWKCqqn+SvF1KCONGRgbJAjKDrISYnD6Xy
         i50Mv/wPWgt5V9uebkpoh5WMY1EmdsPXsu1xCzmr6990YtroGlFNLHS2heNuV0Q2hEZL
         rJvC3XIRGwXSvmGc/3gWfFmwIYaJwb9YaN532MIfvJ/xZbgDDXFDSq4jWKmDWZxJ9huL
         IxWA==
X-Gm-Message-State: ACrzQf18IxjM5gOwKRv+sxwMZALLcDWtymp09ZrNLFCEeYxRLEYDXThM
        hMdrWCZzUiGJADt1I9FV5Q5A0Q==
X-Google-Smtp-Source: AMsMyM4k8anD4+xuWW2Cw4y5DHgdMY/fEvHTJcIvdzDpf5oof1g+Nhr2q2P3HKg6YAXfLBT4kgnNFg==
X-Received: by 2002:ac2:5a44:0:b0:4a2:5c3d:d68c with SMTP id r4-20020ac25a44000000b004a25c3dd68cmr40213lfn.347.1665065244787;
        Thu, 06 Oct 2022 07:07:24 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:07:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 32/34] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: minor style cleanups
Date:   Thu,  6 Oct 2022 16:06:35 +0200
Message-Id: <20221006140637.246665-33-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
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

Drop "binding" from description (and align it with other Qualcomm
pinctrl bindings), use double quotes consistently and drop redundant
quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml    | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
index edf38c774514..7d2589387e1a 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
@@ -4,15 +4,14 @@
 $id: http://devicetree.org/schemas/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
-  Low Power Island (LPI) TLMM block
+title: Qualcomm SC8280XP SoC LPASS LPI TLMM
 
 maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer block found in the
-  LPASS LPI IP on most Qualcomm SoCs
+description:
+  Top Level Mode Multiplexer pin controller in the Low Power Audio SubSystem
+  (LPASS) Low Power Island (LPI) of Qualcomm SC8280XP SoC.
 
 properties:
   compatible:
@@ -35,7 +34,7 @@ properties:
 
   gpio-controller: true
 
-  '#gpio-cells':
+  "#gpio-cells":
     description: Specifying the pin number and flags, as defined in
       include/dt-bindings/gpio/gpio.h
     const: 2
@@ -120,7 +119,7 @@ required:
   - clocks
   - clock-names
   - gpio-controller
-  - '#gpio-cells'
+  - "#gpio-cells"
   - gpio-ranges
 
 additionalProperties: false
-- 
2.34.1

