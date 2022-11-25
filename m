Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A05F638C46
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiKYOd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiKYOdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:33:42 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF64E30F62
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:33:38 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id r8so5375174ljn.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y3a98agTTuTX1jVNEjy44NE9w3cHQ5Lb1+gIhtRkWA=;
        b=hS5c0+dIHOjIZqq0x2fAc5Qzoj15r81Mw73Pnu8/JJIerGbiPo3MpuJeeS5VxlUsvD
         p2sjNHNL1sLRn1lHftzKw1JIn27GlIRh+ynJfUEh1A0c7O2LtdrYDA1DyY/88SvmXib0
         hkgXuKlGqC7NxEwJMC1g1A2AHkuvefwdyVbSuBpKMuJFXtTiTRQANJHype5IIv9IqQPq
         Z2hKOKX9RUOCuBpm9DcFG1QcZElpaiTQqrQaX7/8npQRD5CP4T161oNGGutsuxygtwWp
         Hq5WnZwydHGXdFq37Jb7iRjpz+0AkQuSB8dMUnf8/naXq4M0gNrTDK0rWJgJdP6pTRwk
         yfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8y3a98agTTuTX1jVNEjy44NE9w3cHQ5Lb1+gIhtRkWA=;
        b=8FsYZpz5Wiz8AJ73oyXZlYQ75I3KrzD2teAMMMnzHve71XedfViSgJL0LSAkKzWn2F
         wEBUP6fL4v1PZjBwwbWM+ckDORVIFvxDUXeq2s5i6e33pYIHwcrKYUTrVNxtBHSeMBtM
         Vw683i37XzgBQXE8a0Kz2owTRP4VXMB3+BYkw9+X8JgEfDGuX9Zvsqq1YoYzcnPZZ+5d
         0JeTLwDnDEMF6x2uCoNOu9MEaCMlgjIS8ixPDcujwqmmA1zPsVlqmoSMflW6Si7M62Fh
         6LRhaxFHxhZr5AvpChiGnvBdSVjonXA+ga7CvHyFPWvm443q2kDav2ut+YNUcd4QKqv4
         2i5Q==
X-Gm-Message-State: ANoB5plsFLO6nMMU367ojJ9INY7AlwqwBr0szUUdUl1N6m2Bx3Zh++vZ
        laGN3QWg2EMb/vFsej4/1MH95w==
X-Google-Smtp-Source: AA0mqf5wzZeyZBpsU1bGgU8eBUDra12IZlK9ZLIMvAYF9zIMTKhgrtoY4kXxrXfa5x6MW42EPVLtKA==
X-Received: by 2002:a2e:a26a:0:b0:277:34bb:ea2 with SMTP id k10-20020a2ea26a000000b0027734bb0ea2mr7824151ljm.427.1669386816879;
        Fri, 25 Nov 2022 06:33:36 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k26-20020a05651c10ba00b002798ab42fffsm312966ljn.129.2022.11.25.06.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:33:36 -0800 (PST)
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
        Luca Weiss <luca@z3ntu.xyz>, - NeilBrown <neilb@suse.de>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] dt-bindings: leds: lp55xx: rework to match multi-led
Date:   Fri, 25 Nov 2022 15:33:30 +0100
Message-Id: <20221125143331.473981-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125143331.473981-1-krzysztof.kozlowski@linaro.org>
References: <20221125143331.473981-1-krzysztof.kozlowski@linaro.org>
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

The binding allows two type of LEDs - single and multi-color.  They
differ with properties, so fix the bindings to accept both cases.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/leds/leds-lp55xx.yaml | 43 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
index dfaa957eee74..0018e963f83a 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
@@ -67,9 +67,50 @@ properties:
     const: 0
 
 patternProperties:
-  "(^led@[0-9a-f]$|led)":
+  '^multi-led@[0-8]$':
+    type: object
+    $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        maximum: 8
+
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      "^led@[0-8]$":
+        type: object
+        $ref: common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          led-cur:
+            $ref: /schemas/types.yaml#/definitions/uint8
+            description: |
+              Current setting at each LED channel (mA x10, 0 if LED is not connected)
+            minimum: 0
+            maximum: 255
+
+          max-cur:
+            $ref: /schemas/types.yaml#/definitions/uint8
+            description: Maximun current at each LED channel.
+
+          reg:
+            maximum: 8
+
+        required:
+          - reg
+
+  "^led@[0-8]$":
     type: object
     $ref: common.yaml#
+    unevaluatedProperties: false
+
     properties:
       led-cur:
         $ref: /schemas/types.yaml#/definitions/uint8
-- 
2.34.1

