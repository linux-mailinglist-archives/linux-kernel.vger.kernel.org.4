Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1110600261
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJPRYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJPRXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:23:36 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1693386F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:22:56 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id h10so6267470qvq.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhaG35hWRIUVpgM415aCFivf4GlWanLuk5wuj1yBgHM=;
        b=uGLfM+TV6K4zlP8EW6g+e71+xl3PpO524kELji0nRFm20VOeruoj+kjU7dKbk5i2zs
         GnqY4fS7ZoLl539V4m42CMLXlx5SKXTZIOKA7j76QbNuRFL4d1RUd3SICYTsKrEszzHH
         Vs7iJHT2KgvXHLszyGajSJLtht59xdYs3hq2WwCJCIE3TRjSvYBuHe6Q5nLaCkzF/7aX
         A/ztkQx57ZLpYEHZk7F8BGbWKHoBX4Guknk4dmFSzoe+PGQ6skxC1iplQcSocsZV7Ybd
         cj45UhYjhbe4dhzS0PDed2dJZt41wSWGmYINUW/2EeFZm9WOKX4km+VIN7mBrkpE0B8l
         X1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhaG35hWRIUVpgM415aCFivf4GlWanLuk5wuj1yBgHM=;
        b=ZiWk1fC2Asm/hxwfoTPsM/mpVxdyFTjsz8HbeBsrt5d/NfFmKlPwP5Z1g64U13XSOx
         74NGxBuggoF5kj3Wde8KOT8K+djkxvtQtgyaz07qXWaaHJ9aYRuK0ZL8qTaXOvs2dXkY
         MEeaLQEr9iH1Q0HxlWZ1z3K5PsV5GN2nbzOSIqlI1X+Pv11S3Y4GtnpbFJem96B+No+X
         cBLYeshM/trvxysFzPwMKBBH6TPeKgWqeb50Ewlz+IldSaVw+y3kfzgj1BwwlmVz6Dvk
         lYcO8bfu4NSua/GkAPWftCGL1TBqfUOxXw4ViSD14lXZc/ovrDcpdcBULjaDafkmKHRi
         kFdQ==
X-Gm-Message-State: ACrzQf0NQZSXGkmX3huqdmlu0KGsrZm+j6y/VZ9kX0H2hUPhQ1hFzgau
        2K8Kv+InINMGXeh52B7Ooy5Ofg==
X-Google-Smtp-Source: AMsMyM7BNQgOustDl9ZcI+vC4Tnu5RvkGKcAc0Lw9SH1BbsqxahJZn0165/r1fyPITpRFqYYHq9+5w==
X-Received: by 2002:a05:6214:1cc7:b0:4af:6573:c056 with SMTP id g7-20020a0562141cc700b004af6573c056mr5620657qvd.103.1665940973451;
        Sun, 16 Oct 2022 10:22:53 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id r5-20020ac87945000000b003431446588fsm6051008qtt.5.2022.10.16.10.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:22:52 -0700 (PDT)
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
Subject: [PATCH v3 15/17] dt-bindings: pinctrl: qcom,sc7280: correct number of GPIOs
Date:   Sun, 16 Oct 2022 13:22:10 -0400
Message-Id: <20221016172212.49105-16-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016172212.49105-1-krzysztof.kozlowski@linaro.org>
References: <20221016172212.49105-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---
 .../devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
index 4606ca980dc4..e56861892050 100644
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
@@ -134,7 +134,7 @@ $defs:
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

