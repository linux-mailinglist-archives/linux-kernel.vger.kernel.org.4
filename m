Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CFB725BE4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbjFGKsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbjFGKsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:48:22 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A0410EC;
        Wed,  7 Jun 2023 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=U3bMcXZqzkAneJMjKzEWcszuciWDCOJw7wff8jyvZQo=; b=L9T0m5gaPPE+pFX0eTirrcLw6h
        FLmlK5IO6MsJynlxUPsaqwUKI4efwRg0muODVl8ngc/S06HUyKGQPyU85/WqDwIdpvko0ceenCfI+
        jP5mI3Or+QPco0VuTlcTIWdghNmleCQzFGGGorn3edOKjlbVtCUaGZBpvfnzbYIeU/ksrqpHLxTc0
        I6dPNgI9LGOmqyj7+hn1i9Dz0Pb461kEgrvPoABx5Yu7xEwJxMXPOww49XqzbPXqnH2m/a4cGjUDI
        e2H+LrVVwQygep9ufsAIa1Yq/qmbpLt/v++XdVeIAu1GK8N7wvi1LknBo6+HMUEPwrDCzyFV8N07c
        1l5ieY5g==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1q6qi2-0069NL-QH; Wed, 07 Jun 2023 12:48:10 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Wed, 07 Jun 2023 12:47:47 +0200
Subject: [PATCH v5 4/6] dt-bindings: thermal: qcom-tsens: Drop redundant
 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-msm8909-tsens-v5-4-5eb632235ba7@kernkonzept.com>
References: <20230508-msm8909-tsens-v5-0-5eb632235ba7@kernkonzept.com>
In-Reply-To: <20230508-msm8909-tsens-v5-0-5eb632235ba7@kernkonzept.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the SoC compatibles must be followed by the IP version compatible
(e.g. compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";) it is
redundant to list all the SoC compatibles again in the if statement.
It will already match the IP-version compatible.

The list has already become inconsistent since for example
"qcom,msm8939-tsens" is covered by the if statement but is not listed
there explicitly like the other SoCs.

Simplify this by dropping the redundant SoC compatibles. ipq8064 and
msm8960 are still needed because they do not have an IP-version
compatible.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 .../devicetree/bindings/thermal/qcom-tsens.yaml    | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 92fa70e8ea86..8cc9488686d7 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -224,12 +224,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq8064-tsens
-              - qcom,mdm9607-tsens
-              - qcom,msm8916-tsens
               - qcom,msm8960-tsens
-              - qcom,msm8974-tsens
-              - qcom,msm8976-tsens
-              - qcom,qcs404-tsens
               - qcom,tsens-v0_1
               - qcom,tsens-v1
     then:
@@ -245,22 +240,7 @@ allOf:
       properties:
         compatible:
           contains:
-            enum:
-              - qcom,msm8953-tsens
-              - qcom,msm8996-tsens
-              - qcom,msm8998-tsens
-              - qcom,sc7180-tsens
-              - qcom,sc7280-tsens
-              - qcom,sc8180x-tsens
-              - qcom,sc8280xp-tsens
-              - qcom,sdm630-tsens
-              - qcom,sdm845-tsens
-              - qcom,sm6350-tsens
-              - qcom,sm8150-tsens
-              - qcom,sm8250-tsens
-              - qcom,sm8350-tsens
-              - qcom,sm8450-tsens
-              - qcom,tsens-v2
+            const: qcom,tsens-v2
     then:
       properties:
         interrupts:

-- 
2.30.2

