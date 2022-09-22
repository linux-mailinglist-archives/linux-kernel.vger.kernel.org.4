Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792F55E6C59
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiIVT5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiIVT5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:57:03 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E13E5F81
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:57:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u18so16421644lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bYzFDpsBX2kTeJEZsPEKL8j9cV/QL84TV4CpBdT6eXg=;
        b=rmXKiFtZirzjsxJjmylXBux+KqqiN36gtjB2CBsG+xmfUwv1bSnJjQwTxRzKgEcrLj
         5ZxARW1T/BkTeu86wsqrJsplaMYVKV/oXPNNGltUPuA7B/PdadvkQKpo4wHu/3cwpTSd
         Foobht00t016zEwKnJnR0UUyh+7t+O9Fr2FMmdRhCgX7HE/+efLiDhGKTd0qXNZ/FWZS
         JXEiwQiH1DUnpcGjb1MqlJvywVUC1+zKol8HTDV1VRe48ssa+djCfJmCN+1DFU1f+4zF
         4P1QGxSl3ItYgVCADnaIZo4IxbGVYg18PC8XUEW3vmATY3aDdVRNZWuYku4iCdl7mNEt
         4RwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bYzFDpsBX2kTeJEZsPEKL8j9cV/QL84TV4CpBdT6eXg=;
        b=aHmnr4kYBFGZjn6e7xeBo+vyzLkDQWFKIMMsblC/KI1qJTTqaHvtVI6gJLVNUoO9mT
         2qO4gWp/4pdteAifd7ZYJO3V7+k5d0yrmy/Ng97olkgREPx7EcKV5e7edUk+jsDWSmrs
         JMIhvqrdSI+9ClMJmJ6dlcXVvWnYT0ORgH50y0WJabMu7OgekRF7HtnWHDDnFPHuJClp
         l28jQXPLyBlvEBfj7de9EmUMcIQS4LxDGTKP8mXeJM7jtd0nJDMtvQyatCF+r/yJFFRR
         GQdfPvHQJMv0s0vcH/WFTA8+5Ot5WsT/qHuIbrAArYD1h3VJpvZ8lDtDFRlpytOeog+e
         1Iyw==
X-Gm-Message-State: ACrzQf169q5DG2AYQo/z9Z6kn1ruF46yfKwkntV441Q7tuf61/JSPfdE
        ku8sKCagEL8bTpaDPgBGuaIxwg==
X-Google-Smtp-Source: AMsMyM5QobcXnMnPR2vghwmw5psuStIob8dfahNPEwyw92OcSVCeiJ02jK76bpj64Uti2P028ShFuA==
X-Received: by 2002:a05:6512:2303:b0:49b:ec39:c4ab with SMTP id o3-20020a056512230300b0049bec39c4abmr1877739lfu.512.1663876620291;
        Thu, 22 Sep 2022 12:57:00 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x15-20020a19e00f000000b00498fc3d4d15sm1079375lfg.190.2022.09.22.12.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 12:56:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/12] dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: fix matching pin config
Date:   Thu, 22 Sep 2022 21:56:42 +0200
Message-Id: <20220922195651.345369-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922195651.345369-1-krzysztof.kozlowski@linaro.org>
References: <20220922195651.345369-1-krzysztof.kozlowski@linaro.org>
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

The LPASS pin controller follows generic pin-controller bindings, so
just like TLMM, should have subnodes with '-state' and '-pins'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../qcom,sc7280-lpass-lpi-pinctrl.yaml        | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
index 624e14f00790..1daeca62625d 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
@@ -37,9 +37,17 @@ properties:
   gpio-ranges:
     maxItems: 1
 
-#PIN CONFIGURATION NODES
 patternProperties:
-  '-pins$':
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sc7280-lpass-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sc7280-lpass-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sc7280-lpass-tlmm-state:
     type: object
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
@@ -116,4 +124,21 @@ examples:
         gpio-controller;
         #gpio-cells = <2>;
         gpio-ranges = <&lpass_tlmm 0 0 15>;
+
+        dmic01-state {
+            dmic01-clk-pins {
+                pins = "gpio6";
+                function = "dmic1_clk";
+            };
+
+            dmic01-clk-sleep-pins {
+                pins = "gpio6";
+                function = "dmic1_clk";
+            };
+        };
+
+        tx-swr-data-sleep-state {
+            pins = "gpio1", "gpio2", "gpio14";
+            function = "swr_tx_data";
+        };
     };
-- 
2.34.1

