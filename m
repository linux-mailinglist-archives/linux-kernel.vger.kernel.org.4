Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4835F12BD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiI3Tbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiI3TaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:30:25 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A735050F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:30:13 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bs18so4226885ljb.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=D4UikLTplWsHhZaUVls61V0/b6sUXu3Z8bQRTT/fioM=;
        b=DlDOTLmE/3K9A1fyyNvzhl65kiZ3T7Ie6Bil8zmwXlww+YoeawtfDqe4h1+lsSqJj0
         FEvBVI5MQc0XGN480GaRmhbhBRMmX2O7WLGCSSKtct/PUc7DVIU+T7e69jFGKWG7IUB5
         PfiPd919QmwqSTLoIq+fuHzINwZv+D1KEavJLUpsaqzrcAz0N+ETYyjB5wP8zjzYaYZq
         g9asxPEiXppHKFRp0uobCF5IhS8EV4qOA11XN/OGb2cKZd/OL4Bx8ToWbdWbrJtuC8OV
         hAovSOkPfp5WsOy1mM399GcELKeABSAGEzWijn0Jwc6MCkSSRWYM5vl85JXApmMSpYzw
         tRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=D4UikLTplWsHhZaUVls61V0/b6sUXu3Z8bQRTT/fioM=;
        b=NODdVGGaDZPa3Avyex4nNAdGk+8BlO2lRdpR5LPmnFwq7lY6G2YzIEnAkUyhOdcTac
         w6Is4oCYDMD/+uAdUZ9iDxjA4sY0L0apmKxOD1YwS+DJYDuudXx42d4ukHeE94NdnwM+
         osPE3q3LB9pko5L2ygWCpeo7QPO1cGzqulJ66O3+82YPl+QWtpNdcIym+QK3kV1x6WeQ
         IwmAtiNVZily6S7BJ9GbGWKkdq5E9zXNVo7hgI+p7wlyCxo2bPVn5fF6XNLSZhTalsid
         sRZRnXwQMFcJaY92uXaV7MJeGT+0Yu6BCdTrnzh15U/6HfLN3K9T/mbKFV9K1HqX5fZ+
         Ka6Q==
X-Gm-Message-State: ACrzQf1V8zAD+q8RrfWgeWnI5bSpWPQ6dj/sCg9YBp4ipxV2EyCzhkQk
        7+6TdyGquIKPsdti/+NxZmdMiA==
X-Google-Smtp-Source: AMsMyM57Ib5akcpmzoy0N5pqvXa9scToASPNmSaFb5mBPkLhQOljFXK5PJPbJIyANZcTWwPDHeLq5Q==
X-Received: by 2002:a2e:8e8d:0:b0:26c:5d95:b31b with SMTP id z13-20020a2e8e8d000000b0026c5d95b31bmr3158920ljk.465.1664566213340;
        Fri, 30 Sep 2022 12:30:13 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b0049f9799d349sm393603lfb.187.2022.09.30.12.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:30:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 16/16] dt-bindings: pinctrl: qcom,sc7280: correct number of GPIOs
Date:   Fri, 30 Sep 2022 21:29:54 +0200
Message-Id: <20220930192954.242546-17-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
References: <20220930192954.242546-1-krzysztof.kozlowski@linaro.org>
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

SC7280 has 175 GPIOs (gpio0-174), so correct size of gpio-line-names and
narrow the pattern for matching pin names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
index 1db05c43d58c..2a6b5a719d18 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
@@ -43,7 +43,7 @@ properties:
     maxItems: 1
 
   gpio-line-names:
-    maxItems: 174
+    maxItems: 175
 
   wakeup-parent: true
 
@@ -70,7 +70,7 @@ $defs:
           subnode.
         items:
           oneOf:
-            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9]|18[0-2])$"
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-6][0-9]|17[0-4])$"
             - enum: [ sdc1_rclk, sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk,
                       sdc2_cmd, sdc2_data, ufs_reset ]
         minItems: 1
@@ -132,7 +132,7 @@ $defs:
       - if:
           properties:
             pins:
-              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9]|18[0-2])$"
+              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-6][0-9]|17[0-4])$"
         then:
           required:
             - function
-- 
2.34.1

