Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8F5B4E37
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiIKLPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiIKLOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:14:43 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE5633374
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:13:06 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id by6so7372823ljb.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ahz8RWfiLMT3ul4AnyZJntS/GGhk6GDdZTcm/1GzutM=;
        b=X6S0AXvZ0GFb67PsY8UTn1E7CLRrGB7f9EO8RnF4G36cG4M0UC4NOMBuSrQXmASFEj
         tovjfH7GpwCXlChlLmg1z2ZNUw3SehaWDStuL3L7EeLYShLfSz4TlEqUll6s2OMua+Mu
         CP0wbhHKuvpefbxJYx1u2yfTOBE1RhV5A5jkOsQdluh9QvRiLsqiJag+u+nZqpiWCGBY
         lfYi218xBFNTklNfniNPD7KhOrdN+F7h6F9T0O5Jv8kJP+MDbL5tK/K3Aa+M1qOPFKXv
         TY5DH0mSJAff015iB4Hje3xKqdenlWaHyiPW4Yl292uMJgueyWn8nL3s8cVtvr5fXb8T
         HgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ahz8RWfiLMT3ul4AnyZJntS/GGhk6GDdZTcm/1GzutM=;
        b=6KtZhNtxG/GzlJajt8OvzN1rGLC1YVd8CO1mnxy3/hWhJELOgIjLY9geHxwgil1RTG
         B55LTnXYOn8yC5fEXwRwK2DKmPIuIpBKiiWG25PoT9OIsiCKcoa+ju80eUfJbv1fXcyd
         N3tYV1FLXXI3D5IRlFnSPTYr1pfEL3tLPkuA7gKZrYKyZTG9AzitmQyLtYZdVbWIDnhq
         YxFtC7qvlg72TGhhqHLKI/2Zj4lWuxSYDlxxeTYmR/7l2ooIi9oORuEWyIzaGTpM8jrT
         hW4yl5hP1EOxeq2RhFQQtSgrnov2qLOpQneza0NChfK26oYvKhLyVIUzYxHfbyx8t6kS
         3CMQ==
X-Gm-Message-State: ACgBeo2PKQ6lmnY0Ks+naM+qK4m1CDa1C9SOuUGU5oEyOWSkw+QGPw58
        kxi1Ptc4hQz1rp9WFL5HxCRQrA==
X-Google-Smtp-Source: AA6agR64bxwtgvwgbQMkFzqZVQ3tvDucah3rX04eMkfwm2nmiPYdiaRY3kUrzgzEmMPDrE8lb1ZKEQ==
X-Received: by 2002:a2e:84d6:0:b0:26b:dce5:2fe5 with SMTP id q22-20020a2e84d6000000b0026bdce52fe5mr4205708ljh.12.1662894750790;
        Sun, 11 Sep 2022 04:12:30 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025dfd8c9287sm607365ljc.69.2022.09.11.04.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 04:12:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 21/40] dt-bindings: pinctrl: qcom,sm8450-pinctrl: do not require function on non-GPIOs
Date:   Sun, 11 Sep 2022 13:11:41 +0200
Message-Id: <20220911111200.199182-22-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
References: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain pins, like SDcard related, do not have functions and such should
not be required:

  sdc1-clk-pins: 'function' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Another question is whether 'function' should be disallowed for such
pins?
---
 .../bindings/pinctrl/qcom,sm8450-pinctrl.yaml        | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
index 87347e9c5f1c..296f503c1d97 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
@@ -53,7 +53,6 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
 
     properties:
       pins:
@@ -105,7 +104,16 @@ $defs:
 
     required:
       - pins
-      - function
+
+    allOf:
+      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
+      - if:
+          properties:
+            pins:
+              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9])$"
+        then:
+          required:
+            - function
 
     additionalProperties: false
 
-- 
2.34.1

