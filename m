Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B05E9B12
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiIZHsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiIZHrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:47:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC7836DD1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bu25so7595552lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tI3YcFf7I0VJoXV1p2liiPk9SIh1pwH6bZoypN8Fx6k=;
        b=B6DQNJN0Gy3IB48xNNmvDIQKpcJJOmfOWoo9Ru/OuFJoQBEaBLP6z1gpX3JlCSvFbR
         4YpHY+XkYGLDEuH37A5Gb1VLvgg/fcCloX1jV6gtFEuigJa84jNRyUVtvlEICB5PHqZC
         LEvmrxDOMp51sibQuLOngNDlqIBc4PqQTcl6BoYA5RT7fmuQ0qHGZu787JRujOMPrQ6l
         qoR82PtVoHHI4Dj996fYtff2ZXtNPyFLAZoA5vBRfr5u3TXfW8holaOk02egU+7ODTmp
         /auDWkfPR6VZQJZ7qNRn18cS3ofFcLrU+lC8U2PvS6q7VPyCix92sesL9rpmqE/4i9MM
         OqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tI3YcFf7I0VJoXV1p2liiPk9SIh1pwH6bZoypN8Fx6k=;
        b=nzro/SEoi72jqodXpjXb/ONxXnIDBjwxzGYwm8CAqQJHxvc8CfNNc45tF1sCBzKB9j
         PO27ju812mqqpQ6FB1DWpi3OWqpUyTD1Lwk64JTaY9kuC6IGUN6bVjjha3RiE0Z4Gxce
         OSbpuBFM/zjq8JovCzjtJ1MPqrNcMoJHQJGWQ0b9rzqlIYB92zW0vhumtX5fWFFZBSkW
         1VmGtqxd1NZrWQY56xsV/pjY28ONd+k5atk0MktcV+DKktztZZWdtHuLaFaAntF/ChNB
         h7uxS4QzqQZzM0oiD7VfR1GOmY7OsR6tElkH/xAK2JLpMHdLBGlv+XgYlYt/wcjjjw1D
         NzgA==
X-Gm-Message-State: ACrzQf2M10QmtCXZHSqIneRmZaUsjZXD3y8To421mivpwzk4hOAi452h
        V4NQuBdhKC3reGQm+y3Y8P3A7Q==
X-Google-Smtp-Source: AMsMyM5N4/irmtZnIsS+4oWZetiJXOrZmj5YFqXF6nnJfHnG0BTvUOXEXSApkaCKTCAnHxokOgWzUA==
X-Received: by 2002:ac2:4e15:0:b0:4a1:b113:d431 with SMTP id e21-20020ac24e15000000b004a1b113d431mr3485532lfr.385.1664178302279;
        Mon, 26 Sep 2022 00:45:02 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:45:01 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 20/33] dt-bindings: pinctrl: qcom,msm8953: fix matching pin config
Date:   Mon, 26 Sep 2022 09:44:02 +0200
Message-Id: <20220926074415.53100-21-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
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

The TLMM pin controller follows generic pin-controller bindings, so
should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
(level one and two) are not properly matched.  This method also unifies
the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml     | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
index d4da558cde54..c162796ab604 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
@@ -44,9 +44,17 @@ properties:
   gpio-ranges:
     maxItems: 1
 
-#PIN CONFIGURATION NODES
 patternProperties:
-  '-pins$':
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-msm8953-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-msm8953-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-msm8953-tlmm-state:
     type: object
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
@@ -163,7 +171,7 @@ examples:
               #gpio-cells = <2>;
               gpio-ranges = <&tlmm 0 0 142>;
 
-              serial_default: serial-pins {
+              serial_default: serial-state {
                     pins = "gpio4", "gpio5";
                     function = "blsp_uart2";
                     drive-strength = <2>;
-- 
2.34.1

