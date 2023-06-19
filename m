Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE68734FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjFSJZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjFSJYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:24:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB3AE65
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:24:29 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f76a4c211dso3994633e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687166667; x=1689758667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6jodbFVefGofwsOC02jBd4/o5V3o0lQxYLRG3ofRjU=;
        b=jU8Wd9mFcZhKKX0p6C6VEG7ievfAaJRkR/52fZK1EHMb6wma8TStUaEXvdJgseClqO
         eIEQQssCH+wlqmnuVqzP609KHwmvn7BrYjJgiXGwQMyU2zK/H4K2e/+y24P0HpOk8W1i
         SecwzuWX3Of1aPo2dkn4lrRuCK/4gwDtkomQUrEZhedPm8DMQ+6hDQa3xJRTEaSR6TC7
         CD+uqLPyhSLuzq5cxeMXUOvbdYCfAM456Z3/FGYqKlNm4sFx4/cV1+t+bHreZgt5P2IV
         05dBRymeMGUiJkmsJjPuvjlDYwC5A9xJSQZ1YzU/S9L9FkpUB69AGcH/ZCEb8dw/dBO1
         uaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687166667; x=1689758667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6jodbFVefGofwsOC02jBd4/o5V3o0lQxYLRG3ofRjU=;
        b=ai5zeWCPS9Te0efzLHjSE+7Kb+Bik40Q1PUDM7GPE5J8veyUk/e807l5NQqh7v/HaN
         ipZ0wYFVZQKGiMTcCiq1BGyDypdUFg88nyDY+bShsr+m6lnH9/6IfIKiZIeLXGo+WiTg
         pDg5YJYzdplFRdpAgmditFRyO82jZjqHKFB80wO7Zi4tZx4KrCeze5y/vSuyBOzPJFiU
         DHacMZy8+Pr6XTsk7VA2fI2yTkNdN+5+BJ1T9iDF4lqs9SQQwVu/AzCFedhKLjGT80bh
         LFa9zbr58+rKxCx5PmFm6X7APJV6ENo/sz7TMFyFXH2lh0Vjo2FeE7D1w0a/dfDyQGe0
         97ZQ==
X-Gm-Message-State: AC+VfDwKpNVpr6X5zqdkWBANYdaqXC2jUNX6InFMy367MCr9RdtGiiZA
        cQfFNdATQX9cJVwXc0lIUWwYcA==
X-Google-Smtp-Source: ACHHUZ64aSmZeaRayZqnyOMW64taQxIAjCHAjUgxv/OQQgJSg3V/UkyL8eNJlDKlvN8kbmXyQqPU1g==
X-Received: by 2002:a05:6512:1dc:b0:4f6:2722:9a5a with SMTP id f28-20020a05651201dc00b004f627229a5amr5576347lfp.57.1687166667681;
        Mon, 19 Jun 2023 02:24:27 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d9e8:ddbf:7391:a0b0])
        by smtp.gmail.com with ESMTPSA id q9-20020a7bce89000000b003f7cb42fa20sm10045229wmj.42.2023.06.19.02.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:24:27 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v2 13/14] dt-bindings: net: qcom,ethqos: add description for sa8775p
Date:   Mon, 19 Jun 2023 11:24:01 +0200
Message-Id: <20230619092402.195578-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619092402.195578-1-brgl@bgdev.pl>
References: <20230619092402.195578-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the compatible for the MAC controller on sa8775p platforms. This MAC
works with a single interrupt so add minItems to the interrupts property.
The fourth clock's name is different here so change it. Enable relevant
PHY properties. Add the relevant compatibles to the binding document for
snps,dwmac as well.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/qcom,ethqos.yaml         | 12 +++++++++++-
 .../devicetree/bindings/net/snps,dwmac.yaml          |  3 +++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
index 60a38044fb19..7bdb412a0185 100644
--- a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     enum:
       - qcom,qcs404-ethqos
+      - qcom,sa8775p-ethqos
       - qcom,sc8280xp-ethqos
       - qcom,sm8150-ethqos
 
@@ -32,11 +33,13 @@ properties:
       - const: rgmii
 
   interrupts:
+    minItems: 1
     items:
       - description: Combined signal for various interrupt events
       - description: The interrupt that occurs when Rx exits the LPI state
 
   interrupt-names:
+    minItems: 1
     items:
       - const: macirq
       - const: eth_lpi
@@ -49,11 +52,18 @@ properties:
       - const: stmmaceth
       - const: pclk
       - const: ptp_ref
-      - const: rgmii
+      - enum:
+          - rgmii
+          - phyaux
 
   iommus:
     maxItems: 1
 
+  phys: true
+
+  phy-names:
+    const: serdes
+
 required:
   - compatible
   - clocks
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 363b3e3ea3a6..ddf9522a5dc2 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -67,6 +67,7 @@ properties:
         - loongson,ls2k-dwmac
         - loongson,ls7a-dwmac
         - qcom,qcs404-ethqos
+        - qcom,sa8775p-ethqos
         - qcom,sc8280xp-ethqos
         - qcom,sm8150-ethqos
         - renesas,r9a06g032-gmac
@@ -582,6 +583,7 @@ allOf:
               - ingenic,x1600-mac
               - ingenic,x1830-mac
               - ingenic,x2000-mac
+              - qcom,sa8775p-ethqos
               - qcom,sc8280xp-ethqos
               - snps,dwmac-3.50a
               - snps,dwmac-4.10a
@@ -638,6 +640,7 @@ allOf:
               - ingenic,x1830-mac
               - ingenic,x2000-mac
               - qcom,qcs404-ethqos
+              - qcom,sa8775p-ethqos
               - qcom,sc8280xp-ethqos
               - qcom,sm8150-ethqos
               - snps,dwmac-4.00
-- 
2.39.2

