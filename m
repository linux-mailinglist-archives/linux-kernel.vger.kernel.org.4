Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4656001B7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJPRC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJPRCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:02:19 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B5C402EF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:04 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i12so6268542qvs.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG30mhHToHQxNxl2utL2ECwMv4QzlmyfMxHel7c8yiw=;
        b=vAPmAlXIgEyd9+0xxPeCQ7wsNuC8+7ArHGCrpMQSr8uDn0KXM7eKfCZXmEU+dOXlvJ
         sLqhdlMZ8T71s6bxE8BEKw6BvnBUrd+xjOk7OB/OaOVtxGAIF3NIMCdBbWEhjmoW+dHy
         5LFc9pP/8jL/AHx11dhufwNRW8ybie9/Q3UMhAz9d5FdosjJNUi2wuPaDGkJpaRMFcOC
         MP4fJys0B4Ks4skrZCflE0s9AiUY0jck7s0Idvq64yRimSEP0R6vifNI/1c8zuuDoPpd
         S28luwXE5Brsza35TMifRu5PBqUn3cTRnr+MUsozXvnBmNDRWeSyKSi9hqkU0VeBIDUL
         b65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG30mhHToHQxNxl2utL2ECwMv4QzlmyfMxHel7c8yiw=;
        b=vgol6ttyzk6m5bPUkLkMn7LlmQ2IVBZkRJRCnvD1ORw86ghDQ5/dye6PvcWnR4BDbJ
         czkQg0QkP/1eBpiCr7gMBOWW3VjFBWziJM9+WLZocss7US9TwsuWcEdqkmlxQHgwCrBJ
         xce4YWcOoqRf9NeczFrd2qz0+tJoofpZ/ALfO+UV62SR3NVZz+ar7FAFIyM8qysFDVqI
         rfZ5YGFVYhi2BRsXCg8fssyhmoHm6IhFaTALeg1UfBkLE4gfHACMmIKzdXF+LqZ7gsU7
         hZ62tUKfjHq77fCxRwIrphpVDi/tWN/SaVKBwvbncLx+gqrsa5rFuOZcoNRTricluPh5
         CJbw==
X-Gm-Message-State: ACrzQf1k8AIpbe3SlXV3c+m+rNzCCemPbWEfKTE60kqfuMHkkEA9tmwK
        BhsTDuKKBY4CxBsLA9P/+M+upQ==
X-Google-Smtp-Source: AMsMyM4v2o6T/2KxeFbJ6ZYL48juWFumRoWVfxaL2JTAvryXNn3eCrNYNi7Gxsrd1Dinwbz4mmnbuQ==
X-Received: by 2002:a05:6214:e8d:b0:4b1:acfe:511d with SMTP id hf13-20020a0562140e8d00b004b1acfe511dmr5609182qvb.67.1665939714549;
        Sun, 16 Oct 2022 10:01:54 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:01:53 -0700 (PDT)
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
Subject: [PATCH v5 12/34] dt-bindings: pinctrl: qcom,ipq6018: use common TLMM schema
Date:   Sun, 16 Oct 2022 13:00:13 -0400
Message-Id: <20221016170035.35014-13-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
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

Reference common Qualcomm TLMM pin controller schema, to bring common
properties, other pinctrl schemas and additional checks, like function
required only for GPIOs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v4:
1. Drop drive-strength (included by common TLMM node).

Changes since v3:
1. Drop properties and required items which are already provided by
   common TLMM schema.
---
 .../pinctrl/qcom,ipq6018-pinctrl.yaml         | 45 +++----------------
 1 file changed, 7 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
index 735a8786cb13..6c6b14d1efea 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
@@ -20,27 +20,12 @@ properties:
   reg:
     maxItems: 1
 
-  interrupts:
-    description: Specifies the TLMM summary IRQ
-    maxItems: 1
-
+  interrupts: true
   interrupt-controller: true
-
-  '#interrupt-cells':
-    description:
-      Specifies the PIN numbers and Flags, as defined in defined in
-      include/dt-bindings/interrupt-controller/irq.h
-    const: 2
-
+  "#interrupt-cells": true
   gpio-controller: true
-
-  '#gpio-cells':
-    description: Specifying the pin number and flags, as defined in
-      include/dt-bindings/gpio/gpio.h
-    const: 2
-
-  gpio-ranges:
-    maxItems: 1
+  "#gpio-cells": true
+  gpio-ranges: true
 
 patternProperties:
   "-state$":
@@ -56,7 +41,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "/schemas/pinctrl/pincfg-node.yaml"
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
@@ -103,40 +88,24 @@ $defs:
                 sd_write, sec_mi2s, smb_int, ssbi_wtr0, ssbi_wtr1, uim1, uim2,
                 uim3, uim_batt, wcss_bt, wcss_fm, wcss_wlan, webcam1_rst ]
 
-      drive-strength:
-        enum: [2, 4, 6, 8, 10, 12, 14, 16]
-        default: 2
-        description:
-          Selects the drive strength for the specified pins, in mA.
-
       bias-pull-down: true
-
       bias-pull-up: true
-
       bias-disable: true
-
+      drive-strength: true
       output-high: true
-
       output-low: true
 
     required:
       - pins
-      - function
 
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
 
 required:
   - compatible
   - reg
-  - interrupts
-  - interrupt-controller
-  - '#interrupt-cells'
-  - gpio-controller
-  - '#gpio-cells'
-  - gpio-ranges
 
 additionalProperties: false
 
-- 
2.34.1

