Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286E364A4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiLLQgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbiLLQfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:35:50 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFFBD136
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:35:46 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b3so342570lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MhRmIwqiimhM0hU/ny7BJCiWCN3HyB8MyrfD6CbYtU=;
        b=uy4HgYN0uRqGM8cMy+QL9myXVpoeWEZwaz+wMUd35PefJkG61oUwRDGQ5dQ1NN0HGN
         iZihOU2+Udx63EJFwskcjgxYeYc3GYm8St6tuYPwQt4oi3fERQMpyD+DZ+1mKOiZLceu
         i/FfCOh3gdA2PNG3+NKtB409cv+QK1M0rSoOdI2zLVs1Xfs7OfOUrAuJhkLj0osEPBic
         4kytn0LBtPg750TmgeTEsSi5eFrT/r9iFvIMYMF6lH8RG5QJuiyNHTtaGLHBPwH8MOOP
         n2gibzRWaN+qj0uhfKG4szZ5pQNIWl6/auFMAvXD89+XB/6JRv1AN4lPdTcg4x+obRCd
         8vRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MhRmIwqiimhM0hU/ny7BJCiWCN3HyB8MyrfD6CbYtU=;
        b=SX55LTE3RakU38OZhjFUzEiNRUHt/E81IzIWGsz0oToKiCyI2oCdzcxOgQcewNNXaX
         QKtMq8gk6Ys4XtuBiFAOnDWyRl0I4NM+fX29ePJLb/gD2aIQ//UsE8wStj+zAZlHdryZ
         wTJn4BH1iwnPcNzUQU/dgq3Q/X2OOq1UUKVbDqsnz/d7xyHLxrF+aWddRfvQCU9l+JXm
         8gkXYiYSxPUy/IuYf++5i+AsWuxcurjo8xXoWwoXv8JgOUxwXsbzRw311zKd4LKqx+j3
         cIrg77Xa3ayGGp7WAwsyrfkwArLuteJDhcTwDnJXLOVUSyXg4vuriVsIxvfPhNuTHfyI
         VPag==
X-Gm-Message-State: ANoB5pnh95fyIQklobPxshlSIq1opjlYdHn/R4D++fk+FtmZYiF9561H
        6DZhbYta4k6mUkQJAgye/ogatA==
X-Google-Smtp-Source: AA0mqf7xUv2jmQK3i5+5KlYg9i8KU8zB46JPYfemztw+j90RVuRAt4Lnfx4YeNvqPJHInSSAQf40iA==
X-Received: by 2002:a19:5513:0:b0:4b5:5ddc:da32 with SMTP id n19-20020a195513000000b004b55ddcda32mr3873335lfe.56.1670862942224;
        Mon, 12 Dec 2022 08:35:42 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v16-20020ac25b10000000b004acff58a951sm29209lfn.133.2022.12.12.08.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:35:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] dt-bindings: watchdog: qcom-wdt: allow interrupts
Date:   Mon, 12 Dec 2022 17:35:25 +0100
Message-Id: <20221212163532.142533-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
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

Both of type of watchdogs described in the binding (the KPSS watchdog
and APSS WDT timer) have interrupts.  Allow interrupts and describe them
for KPSS watchdog to fix warnings like:

  watchdog@17c10000: Unevaluated properties are not allowed ('interrupts' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/watchdog/qcom-wdt.yaml           | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 1828eaf70b3b..b7fc57f4800e 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -9,9 +9,6 @@ title: Qualcomm Krait Processor Sub-system (KPSS) Watchdog timer
 maintainers:
   - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
 
-allOf:
-  - $ref: watchdog.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -51,11 +48,31 @@ properties:
   clocks:
     maxItems: 1
 
+  interrupts:
+    minItems: 1
+    maxItems: 5
+
 required:
   - compatible
   - reg
   - clocks
 
+allOf:
+  - $ref: watchdog.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,kpss-wdt
+    then:
+      properties:
+        interrupts:
+          minItems: 1
+          items:
+            - description: Bark
+            - description: Bite
+
 unevaluatedProperties: false
 
 examples:
@@ -66,5 +83,6 @@ examples:
       compatible = "qcom,apss-wdt-sm8150", "qcom,kpss-wdt";
       reg = <0x17c10000 0x1000>;
       clocks = <&sleep_clk>;
+      interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
       timeout-sec = <10>;
     };
-- 
2.34.1

