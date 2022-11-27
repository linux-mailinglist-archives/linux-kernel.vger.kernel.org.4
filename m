Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD36639CE1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiK0UlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiK0UlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:41:06 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD8DDF98
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:41:04 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id z24so11038699ljn.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCo1AkWD2FgarCrXoedmAiqLbycN5G3SgzmeYSK7Dpg=;
        b=nwaxkdhZ4DN5k/R6IH8bbOjgnMj10tWrlkVFBqcaSVRKYpbEfnesnq1liiCvq49Mw6
         /hSn6dqMJltJFY/LZfYbuwDcJ6XED9WHbKw/GSs73o8GGSa74CmFyy8BiEcfS1oLlZFm
         ip9k/Wc0Ldhh+AdL5Cj4eHYMy9dOF0dGlONteMh89IjFLEZttZsFhzfT4SmzyvQdEdpD
         3/YI0lM++TZIKQsc0/9RNYwCEKQOPU4oxv7KvYX3vKIbLcr8kHRrUf2GAM8XYpyioybh
         t0RtPqtbdCl3xIRqmnPWAe1jzhKQ9Pj+NeHdP2jZqsLo3G1cK4T14+u1LOC4L8EZsDxg
         qI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCo1AkWD2FgarCrXoedmAiqLbycN5G3SgzmeYSK7Dpg=;
        b=637A+EAFHkQ9DHKoajoqeetync4DXgytNkclgvMA0fj1eK5ikMtEbjpUcNNh26amym
         cL/shgLoEXj76N+ZYkj78QxB2nhFINMOIfj4I4tIsMjeqljFiBA6Zy+ckAiK/9Ke8dYB
         IKywanGHgjKZv45guFPCkcNKsMq8ahAETt+j+02Xh4+H/64ZriUg1z5iqHhZ/hQMMiEH
         DwRH2+2pHmnu6ouCJGdGGfjRUbd1ZOnEwq4hPKav1YeL32uzrNvBlscOhClgy6N9jxPh
         0cI+8yZLEc0/w+Pa7GKm7sihQxYtsMEtSR4XyxCM8AZhPZxdHPBaGacWQpt71yEsHWcZ
         fhFA==
X-Gm-Message-State: ANoB5pmIQZ4F5CvK8DfVdU9dPftzW/5OVXeD4fAotf9VG2tNqt46Zb5E
        6+PKKgz1bTHXsOHlXklVIkH+JA==
X-Google-Smtp-Source: AA0mqf6pTDKs6NES1VpquDFIMXzG3rHRmFl7tbVum6ZhfTc6vzbNQJxSmQRtXXQVDfJoEGUtN9CHMw==
X-Received: by 2002:a05:651c:b0e:b0:277:3ca2:dac6 with SMTP id b14-20020a05651c0b0e00b002773ca2dac6mr14570830ljr.143.1669581663153;
        Sun, 27 Nov 2022 12:41:03 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bi39-20020a05651c232700b002773ac59697sm644607ljb.0.2022.11.27.12.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 12:41:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Nikita Travkin <nikitos.tr@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Andrew Davis <afd@ti.com>, Gene Chen <gene_chen@richtek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Luca Weiss <luca@z3ntu.xyz>, Neil Brown <neilb@suse.de>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/6] dt-bindings: leds: use unevaluatedProperties for common.yaml
Date:   Sun, 27 Nov 2022 21:40:53 +0100
Message-Id: <20221127204058.57111-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221127204058.57111-1-krzysztof.kozlowski@linaro.org>
References: <20221127204058.57111-1-krzysztof.kozlowski@linaro.org>
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

The common.yaml schema allows further properties, so the bindings using
it should restrict it with unevaluatedProperties:false.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/leds/issi,is31fl319x.yaml    |  1 +
 .../devicetree/bindings/leds/leds-aw2013.yaml        |  1 +
 .../devicetree/bindings/leds/leds-gpio.yaml          |  2 +-
 .../devicetree/bindings/leds/leds-lp50xx.yaml        |  8 ++++++++
 Documentation/devicetree/bindings/leds/leds-pwm.yaml |  2 +-
 .../devicetree/bindings/leds/leds-qcom-lpg.yaml      | 12 +++++++++++-
 .../devicetree/bindings/leds/leds-rt4505.yaml        |  1 +
 .../devicetree/bindings/leds/leds-sgm3140.yaml       |  1 +
 .../devicetree/bindings/leds/ti,tca6507.yaml         |  2 +-
 9 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
index 940333f2d69c..2929382625b6 100644
--- a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
+++ b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
@@ -57,6 +57,7 @@ patternProperties:
   "^led@[1-9]$":
     type: object
     $ref: common.yaml#
+    unevaluatedProperties: false
 
     properties:
       reg:
diff --git a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
index e24b0d15ef01..6c3ea0f06cef 100644
--- a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
@@ -33,6 +33,7 @@ patternProperties:
   "^led@[0-2]$":
     type: object
     $ref: common.yaml#
+    unevaluatedProperties: false
 
     properties:
       reg:
diff --git a/Documentation/devicetree/bindings/leds/leds-gpio.yaml b/Documentation/devicetree/bindings/leds/leds-gpio.yaml
index 7ad2baeda0b0..7e11703acbd6 100644
--- a/Documentation/devicetree/bindings/leds/leds-gpio.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-gpio.yaml
@@ -23,8 +23,8 @@ patternProperties:
   # node name to at least catch some child nodes.
   "(^led-[0-9a-f]$|led)":
     type: object
-
     $ref: common.yaml#
+    unevaluatedProperties: false
 
     properties:
       gpios:
diff --git a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
index 63da380748bf..402c25424525 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
@@ -77,6 +77,14 @@ patternProperties:
       "^led@[0-9a-f]+$":
         type: object
         $ref: common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            maxItems: 1
+
+        required:
+          - reg
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/leds/leds-pwm.yaml b/Documentation/devicetree/bindings/leds/leds-pwm.yaml
index fe4d5fd25913..7de6da58be3c 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-pwm.yaml
@@ -20,8 +20,8 @@ properties:
 patternProperties:
   "^led(-[0-9a-f]+)?$":
     type: object
-
     $ref: common.yaml#
+    unevaluatedProperties: false
 
     properties:
       pwms:
diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index 497db289169d..1df837798249 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -72,14 +72,24 @@ properties:
       "^led@[0-9a-f]$":
         type: object
         $ref: common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            maxItems: 1
+
+        required:
+          - reg
 
 patternProperties:
   "^led@[0-9a-f]$":
     type: object
     $ref: common.yaml#
+    unevaluatedProperties: false
 
     properties:
-      reg: true
+      reg:
+        maxItems: 1
 
     required:
       - reg
diff --git a/Documentation/devicetree/bindings/leds/leds-rt4505.yaml b/Documentation/devicetree/bindings/leds/leds-rt4505.yaml
index 5b0c74aa6723..cb71fec173c1 100644
--- a/Documentation/devicetree/bindings/leds/leds-rt4505.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-rt4505.yaml
@@ -27,6 +27,7 @@ properties:
   led:
     type: object
     $ref: common.yaml#
+    unevaluatedProperties: false
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
index f68259619488..56b2b2630108 100644
--- a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
@@ -34,6 +34,7 @@ properties:
   led:
     type: object
     $ref: common.yaml#
+    unevaluatedProperties: false
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/leds/ti,tca6507.yaml b/Documentation/devicetree/bindings/leds/ti,tca6507.yaml
index 32c600387895..9ce5c0f16e17 100644
--- a/Documentation/devicetree/bindings/leds/ti,tca6507.yaml
+++ b/Documentation/devicetree/bindings/leds/ti,tca6507.yaml
@@ -38,8 +38,8 @@ properties:
 patternProperties:
   "^led@[0-6]$":
     type: object
-
     $ref: common.yaml#
+    unevaluatedProperties: false
 
     properties:
       reg:
-- 
2.34.1

