Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AEF5EC7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiI0Pft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiI0PfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:35:25 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90827670
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:35:03 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a10so11418769ljq.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7sJl4vE6bSD7GZqCJlHjtVSgYLna8lnN5EzCJBmeopA=;
        b=nRDvZwPBrTayD+fBxzdQRAc0HV8Azre+t740Fq4iLVZ0n0g5ROIWKQt3ERsppYQOAG
         mnQpS6PQG8UKqNLV2xlQoSu5mbEsSOZBZCZOh1X0Jgn5PCjSYQfi3wvJN3Ive3Wr7b0M
         AOjVmRMRPBJnTFwnq2Xwi7iSRNQZIyuyI4QXi/CocKgIZzlTz+wodo5x548c++dVtlx3
         nrjoFAKjKe3fkQYgRXMtPzh7iwqzHy1qoVHSdix4cUtnZcpFyntCa/3kOmT3OPmPQOaW
         5nGgybhzap4bcvUdCsuUXUteI79ZbEc+hOldapyFRYpRo8G/7vAjm90d2ZC6347bvGNd
         hBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7sJl4vE6bSD7GZqCJlHjtVSgYLna8lnN5EzCJBmeopA=;
        b=iUyhub/GJM/8LbZQtPQ7qeNqaF4oSPsODUbUH+bHQx6F6XMbTts+t0wcc3UHYQqu4E
         /7IehP2GjqBDAZCSybmKeV4QO3B9AU2hsk7Xibe99l3DFjvf9hZOxciVBbYBJTfLggSB
         4PO3Lg8zJYHvaYDmzLlwPW2XheNko4zRMHU/AdneZy8pRjm2luTZtDbeuCksPepigM9x
         DnB8J7RjP/LvrAE/Mbdu358yqrB6jVPm6nqkNsdDdw5egdhCoiOjivrAROPzDF/SMCvg
         wM0J0g8LfNFPsRfOAJOvASCNX5MLGom8jqmigudn+XJyBKwxXKZBFGL2A8acEH4NUMXS
         a5rw==
X-Gm-Message-State: ACrzQf3hiX1tzpkYlWyRHAmV/dHfLayoQpS7Rj5Fxczwg4RNEaGZLmfN
        /tGDoJxsZhATR54WOr+IlLrn0Q==
X-Google-Smtp-Source: AMsMyM7enD0wwe3qFFVAo1ipolYZLlhG0hrKNSJ4mspYSlmdtozSrsK1DmHigcHASyNbDIBhHKCt7Q==
X-Received: by 2002:a2e:ba15:0:b0:26c:1798:b178 with SMTP id p21-20020a2eba15000000b0026c1798b178mr9297272lja.19.1664292901145;
        Tue, 27 Sep 2022 08:35:01 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o18-20020a2e7312000000b00268bc2c1ed0sm191592ljc.22.2022.09.27.08.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:35:00 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 07/12] dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: fix matching pin config
Date:   Tue, 27 Sep 2022 17:34:24 +0200
Message-Id: <20220927153429.55365-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927153429.55365-1-krzysztof.kozlowski@linaro.org>
References: <20220927153429.55365-1-krzysztof.kozlowski@linaro.org>
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

The LPASS pin controller follows generic pin-controller bindings, so
just like TLMM, should have subnodes with '-state' and '-pins'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../qcom,sc7280-lpass-lpi-pinctrl.yaml        | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
index 624e14f00790..a8a48b684692 100644
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
+      - $ref: "#/$defs/qcom-sc7280-lpass-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sc7280-lpass-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sc7280-lpass-state:
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

