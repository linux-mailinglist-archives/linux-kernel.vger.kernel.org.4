Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75B0601D36
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiJQXEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiJQXDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:03:34 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906C9844D8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:02:22 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o2so7649092qkk.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoKPLdIpY8TSLpZdcYtoGE+wwd6ojWybuYPiXVO8xDg=;
        b=N+fIuwx14TY5W8cxgUM4GSz4KhfhmL/m3laaxjyeIiXamf2koAaWZyx2DMsqzg7nZ/
         zhxtJC5uey3w0B4qogR5aHvqYoBT9Dr7tGF32bE0VNgMll8OGSww7n8lsD5/+sKRRCnV
         tOmYttCTu9nGWzSAHh238dCqkKhsUbuqAAZR9GYN3396Lz4kTbceyyCYkGUtUL+VWGjv
         PgTG0OvH5dEdP8qXsWcUfGN76rslers/pzeJ/XFtNZ0IkvzKhiCe87/p4AtqZdGIQisP
         OyOTjc6084qBiIr1FVvpjnoiQEelWiqKUawEeW2uUpJscR4HNPhPSkk7x0Cq5+Zq6/em
         jsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoKPLdIpY8TSLpZdcYtoGE+wwd6ojWybuYPiXVO8xDg=;
        b=CuB97K1hmu6/gL6QhnmBa2E+G++MpIg0ZT3+Fm7EZLGWuMt+PvtmOIsLFWaNSPClev
         ROlWWwKGLR7x/A6eoYK8kGTXDaKZzhz3QflJEqc9fBbCL1XtxUp+3FsGwx2EoqDMT9hU
         o8Jd2pF6+M/x3NiI8KTOn8d9a5N0qAe96m6wxMYe7YAUbLP4vkNmRoBWDR3KxfgfxdAc
         tnUcUyvEKY3Kaay06Gw1XbCYJ597NMhCv7Q3LvIoJsG8VM60NAriEw1Y7fKpl5CnlRAd
         Qd9zWlQCxNSA7uc+w7LxtxR84JZqHPJBBX8wcKSqQMGe7ew0xiYHe7ErXDONfjGBcZd9
         8Ybg==
X-Gm-Message-State: ACrzQf1gYssJR6OSaP4gMXERGavD9pEZep0d+jjgfQE2Pmelk0pCnm3h
        JR1ulAlJL3Jm46uMX+KD/0EALQ==
X-Google-Smtp-Source: AMsMyM4xfOZi7BTOdrfCdbqUEmTf3gfRPT0QzzADr38G/58kuvDa7AxM3F3fbkXJ/xsPI0hwbjF+0w==
X-Received: by 2002:a05:620a:440d:b0:6ee:b5eb:a0c6 with SMTP id v13-20020a05620a440d00b006eeb5eba0c6mr9645100qkp.356.1666047678963;
        Mon, 17 Oct 2022 16:01:18 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id fg11-20020a05622a580b00b0039cb9b6c390sm729670qtb.79.2022.10.17.16.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 16:01:18 -0700 (PDT)
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
Subject: [PATCH v3 23/33] dt-bindings: pinctrl: qcom,sm6125-tlmm: minor style cleanups
Date:   Mon, 17 Oct 2022 19:00:02 -0400
Message-Id: <20221017230012.47878-24-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
References: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
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
consistently, drop redundant quotes and rename file to match compatible
(to match coding convention).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 ...125-pinctrl.yaml => qcom,sm6125-tlmm.yaml} | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{qcom,sm6125-pinctrl.yaml => qcom,sm6125-tlmm.yaml} (93%)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml
similarity index 93%
rename from Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml
rename to Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml
index 50f721d5f843..e1dd54a160d5 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml
@@ -1,16 +1,15 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/qcom,sm6125-pinctrl.yaml#
+$id: http://devicetree.org/schemas/pinctrl/qcom,sm6125-tlmm.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies, Inc. SM6125 TLMM block
 
 maintainers:
   - Martin Botka <martin.botka@somainline.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer (TLMM) block found
-  in the SM6125 platform.
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SM6125 SoC.
 
 allOf:
   - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
@@ -20,21 +19,20 @@ properties:
     const: qcom,sm6125-tlmm
 
   reg:
-    minItems: 3
     maxItems: 3
 
   reg-names:
     items:
-      - const: "west"
-      - const: "south"
-      - const: "east"
+      - const: west
+      - const: south
+      - const: east
 
   interrupts: true
   interrupt-controller: true
-  '#interrupt-cells': true
+  "#interrupt-cells": true
   gpio-controller: true
   gpio-reserved-ranges: true
-  '#gpio-cells': true
+  "#gpio-cells": true
   gpio-ranges: true
   wakeup-parent: true
 
@@ -46,7 +44,7 @@ required:
 additionalProperties: false
 
 patternProperties:
-  '-state$':
+  "-state$":
     oneOf:
       - $ref: "#/$defs/qcom-sm6125-tlmm-state"
       - patternProperties:
-- 
2.34.1

