Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F656001A9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJPRCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJPRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:02:06 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5B23868B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:01:52 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id a18so5466782qko.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+J798FgdxjOymxzo9NpgSksOzAvjC4SZmthtS8ZpaI=;
        b=YRfxyGeFsuIMwTZrz91juh9A1kbPn0gWtu2EYBK+nuBv5Uvyc9F3+0pvekoXZRjkFk
         wz2rHSJplqQYnNRuF6W9OXKL6eJZf8zgnMA6bltgjjnpYapQczBW9ffN+Wdzsbd0L9WP
         NT/kFaQ2Zfrpr1uGy07PHrESrkVX2X61+95StFPup88G+EIp3X1iQoqcjcUpMJr4sNYp
         F+2a5Njnv9IYMzo8yZdq08ju/xrEbOsEx6lyY4/eNIHDvlsUxy8QHvHhJ8xlJ4pSwddE
         EzZSXfb9GMmlKSWZwE/b9NgvZq9sKvMPp+OINcKVasitVxGLvR/GvbkNvWUx5hANMuWZ
         iblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+J798FgdxjOymxzo9NpgSksOzAvjC4SZmthtS8ZpaI=;
        b=iVIcFY/eH3+obZUSrCEAzpSxdwbeFzDS6FUowRHtLHPhs+2GekeefcyQt1FrcbdL1A
         z4JWlQJIbcsuTXKfFu4OjTer+QnDYTFMXwSa4QlOy6Svh1MBKK1qnl2Bh1wlL7oljRBA
         Y5dBxIDSq97LJGs2RXGJqdWGBY7TgS1ekw3r3GO0r2hddn9Ry/yZiOd95WVOPR7NGg8F
         YtsVqnrLpFjNojrS3snSMXcrNYbN++lMv4LY8EGu+qdHVozAPmB5azefpB0OcUbumFbT
         0lQHNymoT4ycFi1AkwYRRJPtjdnaY0ydV30axy+3SWRQhnzSnYzNTKU2XGvpYXS4Y/rB
         HLXQ==
X-Gm-Message-State: ACrzQf1My4IywlVKzyj8JWBdhAe/QSAOV5q4TshCGa5HpGRslnyZaZD5
        Eh7VgGFILCKClTCS3wRAaFKqjQ==
X-Google-Smtp-Source: AMsMyM54S39k52M4s7fUuX3AO3xVZUcAi9FohjxTdiSMhblUB7vKleFRhPadXoly+OizLBBObnkhEA==
X-Received: by 2002:a05:620a:4502:b0:6cf:982a:1141 with SMTP id t2-20020a05620a450200b006cf982a1141mr5050803qkp.147.1665939712505;
        Sun, 16 Oct 2022 10:01:52 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:01:51 -0700 (PDT)
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
Subject: [PATCH v5 11/34] dt-bindings: pinctrl: qcom,ipq6018: fix matching pin config
Date:   Sun, 16 Oct 2022 13:00:12 -0400
Message-Id: <20221016170035.35014-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
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

The TLMM pin controller follows generic pin-controller bindings, so
should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
(level one and two) are not properly matched.  This method also unifies
the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml    | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
index 7202e2af200b..735a8786cb13 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
@@ -42,10 +42,17 @@ properties:
   gpio-ranges:
     maxItems: 1
 
-#PIN CONFIGURATION NODES
 patternProperties:
-  '-pinmux$':
-    type: object
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-ipq6018-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-ipq6018-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-ipq6018-tlmm-state:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
@@ -146,7 +153,7 @@ examples:
               #gpio-cells = <2>;
               gpio-ranges = <&tlmm 0 0 80>;
 
-              serial3-pinmux {
+              serial3-state {
                       pins = "gpio44", "gpio45";
                       function = "blsp2_uart";
                       drive-strength = <8>;
-- 
2.34.1

