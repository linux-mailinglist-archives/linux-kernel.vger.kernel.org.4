Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3BF5F694A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiJFOJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiJFOIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:08:32 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31227AD99B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:07:40 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id p5so2334012ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pz+xQ/sudSMqZIDeQ8gYL314AARwnvQptTAk3JIoPJU=;
        b=s69/TS1Sk9VtpdR9w5ep9mwrJWJBjMQnvJC1ZegYlR2IFS82E5yQbWZs4umydbLNR5
         rO+Rnbxz5MOsv/xVHaXXWYgXMfZdpGE1WT/b5LqGCdESwfLe6oIKnNR1PsiQzDK1ELdR
         9eQxXiORHEa3dOCfvw8OT52VLqz5ws1o0Tt3TpbdVm+T9Bbp10E2VYvg9blN6XpqHYD6
         ysMS1cCInvOpugxy6sn0vIX94p/bHy8Cp1/lNmynGDaCgJMWziJ5nT5Nqhuae3DXSiT4
         CSPANOooLUNftYbk6ZLw6wSYxW/LRz31NypvGZz0X9Qega5ls8lyGsAMDukLQ6INXBoc
         wTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pz+xQ/sudSMqZIDeQ8gYL314AARwnvQptTAk3JIoPJU=;
        b=mu7VzgK5faJ5tVautQx0FTh4yEkTblfMTpMGXHjVihUA5uBi2vZh9RabJU8qOZ895s
         KnxHCCStVwVkgXviaWwH9kpw7OGLdt8x7kZFVV5IrdMuesgIyHM0UpBMsjuFSKnxwv5f
         PVuD3wmCkPsFPX5C4aZREIFy5IrvPVGXhA3H6LAiNI3gD97R7IPHEDyJkSJKnKKw6EEt
         wEqv7BS2UdqaAdMVX3qhegclbfy1gZ5hxSwPEHCCubXZ0CtxTVVancI+1r+7pvFKOWEG
         /EybsSJxlWemgarFedeiML4IpkQ38wHSDaNkLYEBbg3ZTVC6B4+YpGjf7VjhK2K/oEP3
         +L6A==
X-Gm-Message-State: ACrzQf1+Y58Q2foP7UQ1JeiS2owL/OiU5jlUyNgMqYtTZ4dryTdF54Vf
        8Mk5pB8IHu/lTTTMs5Uukd/GCg==
X-Google-Smtp-Source: AMsMyM6LsOWCu5/OR7UjmdSjQoKSroH/T2CHlzmU6mqFpfG6LIiDTNntUIddYbBuxQlt5TdSBhKxiw==
X-Received: by 2002:a2e:a54d:0:b0:26c:64ae:236a with SMTP id e13-20020a2ea54d000000b0026c64ae236amr1960445ljn.207.1665065236534;
        Thu, 06 Oct 2022 07:07:16 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:07:16 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 26/34] dt-bindings: pinctrl: qcom,sm6375: minor style cleanups
Date:   Thu,  6 Oct 2022 16:06:29 +0200
Message-Id: <20221006140637.246665-27-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
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
pinctrl bindings), use double quotes consistently and drop redundant
quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
index 4482625b6b1f..d54ebb2bd5a8 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
@@ -9,9 +9,8 @@ title: Qualcomm Technologies, Inc. SM6375 TLMM block
 maintainers:
   - Konrad Dybcio <konrad.dybcio@somainline.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer (TLMM) block found
-  in the SM6375 platform.
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SM6375 SoC.
 
 allOf:
   - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
@@ -25,10 +24,10 @@ properties:
 
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
 
@@ -39,7 +38,7 @@ required:
 additionalProperties: false
 
 patternProperties:
-  '-state$':
+  "-state$":
     oneOf:
       - $ref: "#/$defs/qcom-sm6375-tlmm-state"
       - patternProperties:
-- 
2.34.1

