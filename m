Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355785FB98D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJKR3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiJKR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:28:43 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A8275FD2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:27:10 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 8so1472840qka.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBTPGnB6xCp92zRWIKe7A6aSdXZ2iRizgQ0TLXxzR8A=;
        b=gV6LjKtLqy/uUCALRf4iphyiiwkIkDdv48IwVvNPX9afBvxvlqrkuLmtIg43BJbiPQ
         68WbTlT6CQKgXVXgZn9mILuxnjJdMa1ORf9BfSffwdc0QFTcrAYVVSfmht4ZgeXHl+Bx
         BWUEUr1RQTJOHiCixvibx/jQbo0bVq+5l1PkVgzB3vhcYlTYjvn+uRhqpNcEaSxCdMlu
         KqYEdQxPK1VMPXlD8T2IupbSUwes+Y0AasDc4/UrMa2EHQm80jZQ+2nvMXVxHR04aRQS
         JpWDoGcr13CM0P15wrOWiHypLslD+nAPWHw5fQ1bjlBkH4b3CzjgXRM6FmzfN2gigJ6d
         bRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBTPGnB6xCp92zRWIKe7A6aSdXZ2iRizgQ0TLXxzR8A=;
        b=8Bx96CRMY3UxRX6Lv6FRCFN7ZK97D6/Ee5ca5u250Gjm+NB+5cxDbHDg7ZOIyLyywv
         5SsSi98ViCt4g6fMMUmiw2gKAIBZeZJymiMmkPv8K9c7Uy5iF70p6XBpsA/jdVFE91vN
         zGCIE5OLTM7vExE89e06XIdClEk1OdSruM76xEUYqvt3MOjbdbQVQ6QYiNCLHpttVSzu
         ZRAqkaL/dN7RSmCdF78Z9UboMyp46m2aOcFRGOUeNONTkOVuqJNUmwak86uZP5PM/tk+
         1Ax8vgmcxSZ4CccD5wyy91MYKqqJ/waPCSTzA81E1OejliqPC5+XaMG/DpkdD7xhxuS8
         H3rQ==
X-Gm-Message-State: ACrzQf2IEUndkMBhwyaOPKzTNes3pXSBzymvGPk2lNi7IEQUIb/QXrkK
        x7frZy8Fg3eySXClVYWOiZ3vLg==
X-Google-Smtp-Source: AMsMyM7npWuUNBxPdIUW5wZ8W5qt4VnrwAHPXNZZ/7ymrloelazFCEtztPMFuw/PUP/Uj6YMcA0USQ==
X-Received: by 2002:a05:620a:290b:b0:6ee:7e19:c446 with SMTP id m11-20020a05620a290b00b006ee7e19c446mr2687421qkp.190.1665509208141;
        Tue, 11 Oct 2022 10:26:48 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006bba46e5eeasm14289087qkn.37.2022.10.11.10.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:26:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 27/34] dt-bindings: pinctrl: qcom,sm8250: minor style cleanups
Date:   Tue, 11 Oct 2022 13:23:51 -0400
Message-Id: <20221011172358.69043-28-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011172358.69043-1-krzysztof.kozlowski@linaro.org>
References: <20221011172358.69043-1-krzysztof.kozlowski@linaro.org>
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

Drop "binding" from description (and align it with other Qualcomm
pinctrl bindings), drop redundant minItems, use double quotes
consistently and drop redundant quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 36 +++++++++----------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
index 824a4dce1202..1e42a4c60da9 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
@@ -9,23 +9,21 @@ title: Qualcomm Technologies, Inc. SM8250 TLMM block
 maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer block found in the
-  SM8250 platform.
+description:
+  Top Level Mode Multiplexer pin controller in the Qualcomm SM8250 SoC.
 
 properties:
   compatible:
     const: qcom,sm8250-pinctrl
 
   reg:
-    minItems: 3
     maxItems: 3
 
   reg-names:
     items:
-      - const: "west"
-      - const: "south"
-      - const: "north"
+      - const: west
+      - const: south
+      - const: north
 
   interrupts: true
   interrupt-controller: true
@@ -126,16 +124,16 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     pinctrl@1f00000 {
-            compatible = "qcom,sm8250-pinctrl";
-            reg = <0x0f100000 0x300000>,
-                  <0x0f500000 0x300000>,
-                  <0x0f900000 0x300000>;
-            reg-names = "west", "south", "north";
-            interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-            gpio-controller;
-            #gpio-cells = <2>;
-            interrupt-controller;
-            #interrupt-cells = <2>;
-            gpio-ranges = <&tlmm 0 0 180>;
-            wakeup-parent = <&pdc>;
+        compatible = "qcom,sm8250-pinctrl";
+        reg = <0x0f100000 0x300000>,
+              <0x0f500000 0x300000>,
+              <0x0f900000 0x300000>;
+        reg-names = "west", "south", "north";
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 180>;
+        wakeup-parent = <&pdc>;
     };
-- 
2.34.1

