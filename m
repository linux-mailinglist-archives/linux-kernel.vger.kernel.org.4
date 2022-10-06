Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02865F668D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiJFMsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiJFMrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:47:32 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F73A286B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:47:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id j23so1979830lji.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=X0qog3y6/pjQRMdLgI2wTjHB+zwmYy9wpugBMuJA3qs=;
        b=ckmbHXLFJI4cwWenO5NuntW3jM2fKKkk7KB8uy3qSZmUQT/TZiWEzbZ61g23Rbb00+
         JJGmY4K/J+GdT/3iahp0AJ9GS7Exh7XPluXfXR7bIULRpop2NhW7KV4NC7Z6Je5yCxsr
         XZqQFpljOtGWElEfAgvrIoqh+EY7fqYWDPJXp9lGS+rmbQtwBWXZ68oIBmDAGbgGz5RE
         9wXzToPcdcqpde12JgyM7ujNdgAFLfygOMMg25Z7axsLf+7A1CbGonhVIWyqQNxF+9H2
         6aNvNl37hiYdzWyfHPWDEXjTZxO7qJQYc/XSvrifRLGMtqoJR9BcngbHuh3xCRFHSJdY
         Po7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=X0qog3y6/pjQRMdLgI2wTjHB+zwmYy9wpugBMuJA3qs=;
        b=PCnxLqtTFQA1dMln0VRyF7CBjuCWd5QYRbVZW3mEvCoedJH3Q5RegYyVVURuRUoFMk
         Cz06bWYbee/GyrkbIYsPDm0zG4tTB75vYdnT9S2NreDqJGFWvFNW2EUPlGDge+zoncy/
         OPB/Ewn+H1Vsvt2PCChxGbjjs91U93pQAKDZuYUrqVMtVFlptmoclr6l9A67AX/hktwg
         9hmQYDdNfB7uzvFe6sFViovGEdubil4arLMZeiIB2o+eA9ocZhNN1U5WwUZ2lA7/PKlc
         kjfreQuoIoh7cYcAgaeoVR17dW8LmVZrgQJ0ZY6ypAu/NeXtpAB28LV9ZU34WvDAaU5E
         WIcw==
X-Gm-Message-State: ACrzQf22W4RIwFYAAMIEXHZx0bow1pMCH7GP++gfHehkwWuCE1teg3rc
        UBQBmjilIjGCARZ/4GN1Le+bjg==
X-Google-Smtp-Source: AMsMyM642mzyFfLaVBo9AnLR3/VtDKQhs34wBxygcCv64ZzSW/x2hzif2n/cFRSAqP5VdliQ6KIsYw==
X-Received: by 2002:a05:651c:897:b0:26a:c213:f0cf with SMTP id d23-20020a05651c089700b0026ac213f0cfmr1759181ljq.216.1665060430100;
        Thu, 06 Oct 2022 05:47:10 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b00497a3e2a191sm2687659lfb.112.2022.10.06.05.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:47:09 -0700 (PDT)
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
Subject: [PATCH v4 07/34] dt-bindings: pinctrl: qcom,tlmm-common: add common check for function
Date:   Thu,  6 Oct 2022 14:46:32 +0200
Message-Id: <20221006124659.217540-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
References: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
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

Certain pins, like SDcard related, do not have functions and such should
not be required.  Add a check for this in common Qualcomm TLMM pin
controller schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/qcom,tlmm-common.yaml    | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
index c88c8dcb69d9..e1354f0c64f8 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
@@ -65,10 +65,6 @@ additionalProperties: true
 
 $defs:
   qcom-tlmm-state:
-    allOf:
-      - $ref: pincfg-node.yaml#
-      - $ref: pinmux-node.yaml#
-
     properties:
       drive-strength:
         enum: [2, 4, 6, 8, 10, 12, 14, 16]
@@ -82,5 +78,21 @@ $defs:
       output-high: true
       output-low: true
 
+    allOf:
+      - $ref: pincfg-node.yaml#
+      - $ref: pinmux-node.yaml#
+
+      - if:
+          properties:
+            pins:
+              items:
+                pattern: "^gpio"
+        then:
+          required:
+            - function
+        else:
+          properties:
+            function: false
+
     additionalProperties: true
 ...
-- 
2.34.1

