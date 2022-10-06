Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0885F66C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiJFMtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiJFMsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:48:41 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E5AA4855
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:47:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j4so2645763lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KzWzb3hZrQFEQ0Rr65DWDq+RHVqeUt74LUhgKPrHSTM=;
        b=pbV132erSrm7elZPfUZmdVYCpRBOwrj08a4lY8jaP2h+xs0PQy6gk79ARw0Jp1Fq/D
         xaFTbyps+2U2c1qxkav+9XSrgBSJHTU9aBujEnR+FcdoJAPFEDgnagsNROJFRr+6LBK3
         bsU7WYtndhfG5yPUHZPn9zPKAY+dHmUeM7bIagckiVTptaf6UVkk1qxNvDcmnGMwoV2e
         Kuyr6ShexfFegP51KQNGkYyQ0PFInNp4VG22SNib59rp/Y+BGhD7s6IEsLOqFQa68Dc0
         cC+PqZrYOVZ1xb6/eVSoWcwaR3WrKIWllRy/xHSI+oS+YKi0c1YTnN2pb3UtwClurB+t
         LAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KzWzb3hZrQFEQ0Rr65DWDq+RHVqeUt74LUhgKPrHSTM=;
        b=tDxwlxUMFiEm6BrH3SeydhyUqkqhZxWULL1aFIdu5Twfzsj2ReK5leY9nLJ7ymrEhB
         PUN+CZmnE3aDM9XXYJdnYB2DDN+RRU5i7ztgD0FGOpE292s8m75oci47b1ayuDiOZjzq
         CY1VCryyG0F/Y6aiXrM6OiMBB1vc1zopSuFbO/PJ9q2XYH2qBJNs6ukSgMGICU5wQDid
         Di5isrM3IGI3X8E6Poi8UN3nt9VlIkJQYdElk5GqQ3vUKSotCKwnMWXd/GJrIuXMimJ5
         9nnGbHtS/3QiUWT8W+PFeFqqzSzgxPSQ02pYSu4k4lleNY5z3lwtn8twlx5DyNLs1mjj
         RBlg==
X-Gm-Message-State: ACrzQf0ftPkDiL4oO8iZTZs2w5BJ2jmP2/3fc5UBxbz3ph1leaz1aaQf
        qadWeK/zhoU1+8qjykOiF0NU9A==
X-Google-Smtp-Source: AMsMyM4nqPq7cboF8SSXawT3xALdyQXIQ3wwuiV91S6EyNIsbWNNKXYAKfC2J5jejaV/U2J/ttEUaw==
X-Received: by 2002:a05:6512:12c2:b0:4a2:71c2:a7f4 with SMTP id p2-20020a05651212c200b004a271c2a7f4mr1293656lfg.3.1665060445855;
        Thu, 06 Oct 2022 05:47:25 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b00497a3e2a191sm2687659lfb.112.2022.10.06.05.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:47:25 -0700 (PDT)
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
Subject: [PATCH v4 21/34] dt-bindings: pinctrl: qcom,msm8953: fix matching pin config
Date:   Thu,  6 Oct 2022 14:46:46 +0200
Message-Id: <20221006124659.217540-22-krzysztof.kozlowski@linaro.org>
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

The TLMM pin controller follows generic pin-controller bindings, so
should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
(level one and two) are not properly matched.  This method also unifies
the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml     | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
index d4da558cde54..c162796ab604 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
@@ -44,9 +44,17 @@ properties:
   gpio-ranges:
     maxItems: 1
 
-#PIN CONFIGURATION NODES
 patternProperties:
-  '-pins$':
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-msm8953-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-msm8953-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-msm8953-tlmm-state:
     type: object
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
@@ -163,7 +171,7 @@ examples:
               #gpio-cells = <2>;
               gpio-ranges = <&tlmm 0 0 142>;
 
-              serial_default: serial-pins {
+              serial_default: serial-state {
                     pins = "gpio4", "gpio5";
                     function = "blsp_uart2";
                     drive-strength = <2>;
-- 
2.34.1

