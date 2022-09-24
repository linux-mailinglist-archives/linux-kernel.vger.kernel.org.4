Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D705E89A8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbiIXIHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiIXIGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:06:18 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C391251A5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:37 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id j24so2322192lja.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I9UI65DEwAIEvnPw/7Aklq9Nug9drrNeZhV+82t1En4=;
        b=coQfwEXcRvx4ZbcQ4ke1HnuHdi5hVuUsbEBsrM9hTNtsP5FWLCfljrBMJeHbQ2B7Kn
         ZYn2/jpgH8gaXoBaNHzUffbEhA7NOYrM1T1RGTHMxcTONyPIf+MHfzt+nAaDnA1f13EU
         pVN9jUNZtGF/EdpD/BSVukWhMBia6wpLicsHciD5v8BxZOdZGXVu9284/uTDafttsF3S
         DY0UObeu3j/TOno6Yr0N7eO0MZsaz0Ji8xUYVdh+ngKxLSmMC4LxAo2W/2wij44PvRyp
         +mQ0hkdbm9kOgIBhUsO51UOVYGVjFw8J8nWRHF5atLGIrpQjKSpPdETSI964cHz9A7OQ
         uSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I9UI65DEwAIEvnPw/7Aklq9Nug9drrNeZhV+82t1En4=;
        b=ptFPx4M/bnanVORguCybjf+FPpenjd14EaOhqX+VQnRyjGJzfxMMrpdQ4PcBwwn3Ux
         xO9YZNbe98qyBVrGENR4/8qNYIKf/7ChE8s4r/tUBWk5cz8KGqiYlRM6cMdpJ/0rJLbK
         HGamlkAzYYD7bfZoWH22beoTviep8s5zd7/43IOw6zEnFKMS1StTXoOW+kz+mzVls5gT
         ATNLfJoDLFWJ//vL7GL936z8KWWx7M9mrs/PVee96rgmqh0Ih9/MdI/dKgFtkbQplk7c
         ApyYtZsOxNSUMsFLOsnfnxF4CX8q4PLgQ1Dbg3dPWjuVYxQa+u2DGNKJy5k5GVKHZElw
         Ae/g==
X-Gm-Message-State: ACrzQf2WqKkOoktfAMqxcLYMz0ZSifUwKDX5dDvT2SOTihwGdkCRxNSn
        4XZ0BdVsinO3c+LWz4hweXaZIA==
X-Google-Smtp-Source: AMsMyM7sRo70fgBGTXgxjxqoLxubcDvl0NgXGmiAAPeKxyLV70pEN8PKSiXAusDGICoBOzkh7KFRhg==
X-Received: by 2002:a2e:a7ca:0:b0:26c:51d6:55ed with SMTP id x10-20020a2ea7ca000000b0026c51d655edmr3940457ljp.426.1664006736602;
        Sat, 24 Sep 2022 01:05:36 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y2-20020a2e5442000000b0026c41574790sm1696668ljd.30.2022.09.24.01.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 01:05:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 22/32] dt-bindings: pinctrl: qcom,mdm9607: do not require function on non-GPIOs
Date:   Sat, 24 Sep 2022 10:04:49 +0200
Message-Id: <20220924080459.13084-23-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
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

Certain pins, like SDcard related, do not have functions and such should
not be required.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,mdm9607-pinctrl.yaml       | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
index f7bd4be1739e..ef22090fd6d6 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
@@ -53,7 +53,6 @@ patternProperties:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
 
     properties:
       pins:
@@ -115,7 +114,16 @@ patternProperties:
 
     required:
       - pins
-      - function
+
+    allOf:
+      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
+      - if:
+          properties:
+            pins:
+              pattern: "^gpio([1-9]|[1-7][0-9]|80)$"
+        then:
+          required:
+            - function
 
     additionalProperties: false
 
-- 
2.34.1

