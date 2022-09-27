Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7875ECB7C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiI0Rmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiI0Rlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:41:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1739325C65
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:41 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id x29so11765213ljq.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=d1tmVRQxjIT1+LCWPv85FgiJzbUwILjqiWs/rdSbJ9E=;
        b=lClivy8s9Uco1i34MPyfMn8QLSq8GeARI17bmmojONEuM0ku0hhrTNWAPhkPO89nVa
         2gFPvgjjoTvi7t8nAOX+eF9sIu5rjbxsPKZsYzq10P5nI76m3R2FS0k1lotfY0MdI14F
         nsVvT4FmNjFd6einqVNX6oWQb4KqnskJPKCdAI5URBlD9Ro2cSVYXrfbm1G+0tjMX6eX
         dWFATkqkWXITjvWt5L2guqkXJXoxeAjGGyqZgVyiTfhQaVQB5ZKHu8tIwZFgDVh8Gutf
         EYLsJppIuNpilDvkVmiWF53lwyn494HoEn6wQSBlqaTURTCAskHCwMEHbA7iQeVlDODc
         ZROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=d1tmVRQxjIT1+LCWPv85FgiJzbUwILjqiWs/rdSbJ9E=;
        b=YjhrgDdSp9OKo5u5C9gMFjhJVl1ytzkoV/N1qX2l1wsAuYB86bGjhP770BbtFPq1oN
         RAyAHuYhvj9RAbj2LvJXpPy3ex9ZHbcahiuc6JRGtEnceAsTUu5rMaiCBkZ4TzV+ansU
         ajmd/kQ5ZPd7381JPIVuDsb5Iyluv48ypU+v2pLN92MlPsOu04p77l6J0wkRVUfwIHgS
         QdNPC6UCyMRLrYs7f2+X11lEvviWTkOm7OElBNlS1qqJRyId6gaCdBf6hoWS+0rsBSLt
         EMfMYkAYXqFV6086aH3xBhDdvSZZF4YpzJtxvIOEkGpHGIXoiNvjUdJOy3ZaBJxl/GXA
         J6RA==
X-Gm-Message-State: ACrzQf1/tVbU0T2nnwzJhGjMtP7tnzSbVFVpwkGt/9JOY6nGKEzYTkqb
        I4HgUHVdsfY81zuLSmTA0YgfEA==
X-Google-Smtp-Source: AMsMyM7uf7nA6OaVSa7p48KHJN6B8M7+nlfK43EL4lt27axPia4L7tX0VuPtknL1X7ScuqIWpPwGSQ==
X-Received: by 2002:a05:651c:1504:b0:26c:6331:3463 with SMTP id e4-20020a05651c150400b0026c63313463mr10482547ljf.30.1664300359678;
        Tue, 27 Sep 2022 10:39:19 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac246ec000000b00498f570aef2sm218879lfo.209.2022.09.27.10.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:39:17 -0700 (PDT)
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
Subject: [PATCH v3 33/34] dt-bindings: pinctrl: qcom,sc7280: fix matching pin config
Date:   Tue, 27 Sep 2022 19:37:01 +0200
Message-Id: <20220927173702.5200-34-krzysztof.kozlowski@linaro.org>
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

The TLMM pin controller follows generic pin-controller bindings, so
should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
(level one and two) are not properly matched.  This method also unifies
the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml      | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
index ad3496784678..4606ca980dc4 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
@@ -47,9 +47,17 @@ properties:
 
   wakeup-parent: true
 
-#PIN CONFIGURATION NODES
 patternProperties:
-  '-pins$':
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sc7280-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sc7280-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sc7280-tlmm-state:
     type: object
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
@@ -162,7 +170,7 @@ examples:
         gpio-ranges = <&tlmm 0 0 175>;
         wakeup-parent = <&pdc>;
 
-        qup_uart5_default: qup-uart5-pins {
+        qup_uart5_default: qup-uart5-state {
             pins = "gpio46", "gpio47";
             function = "qup13";
             drive-strength = <2>;
-- 
2.34.1

