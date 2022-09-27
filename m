Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2555ECB60
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiI0Rld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbiI0Rk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:40:26 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E174C1EAD43
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 10so16811814lfy.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1QJkk+vQOB36zDh7TVEesCBla0uHOGKfK/9NnJQaTyM=;
        b=b+GZNBvZIV/P/cby8+vgiMfpViV/PmBa0cAQaWvcI5sa1/IKjVDCs+QiKhubd4mnsP
         Wt44BrTr+jYHf4ClKz2yUpHJRvWyvjwgstxbWFGmHUiwNdmFUuIGwYJk/3C7XCw9avf5
         WttxxssPjcc8sVgT00kZLTOwtBaQsZYtDcIYvf3DahVPNuiR9tIYZYy64gpWYURclduc
         OpiwzqW4iiqMcISooX0h1D3jC4UVomfPIYbuCzMuwlfo6laS1Ut2f8/jWI2AuqPaJwD6
         Zm0sC7M2YwdAruv8G4B/HBou4JPQ+6UXuD8mE9KxB/AjWyL3fplF3HDbCcq7plJ4gbkx
         W3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1QJkk+vQOB36zDh7TVEesCBla0uHOGKfK/9NnJQaTyM=;
        b=6ngBcZVvefqVL/4WgxSZNSkytzLBuUhEIqFaPpUU/AotRrYjOxr4SD7c5Cfp6S5yd4
         OJZBOZ1GuqBYTzmF4ecpgQI5Ix9jlHTdS8SUQt8UiTUx1rHWUgZ9uKEVc+Sva7ncPlCj
         gppouh+0kUMptSjGmw7STq1oW+nShqvhj9ESoEfJWOwP3LH6WXbBrSf+uuJK0ni3wN8M
         p196gHuFvq41q6E1oEGBJwI403XehHQAwRSw0hRrey0Buwlfy1Or/qqv3+WjhgDMpeEr
         /exsU4cSBkriyYeFxYzndd71Rh8P0XIgbtMNV1V5QqiBzaMAGVpTYB6bHbSlPINw54Aj
         6Abg==
X-Gm-Message-State: ACrzQf3N4ZJcR+BOA4T35If8ADE07FmWgyXveDtEEjP7+qBRbn5KVIbP
        /mlLyAKoyR/8sGpj3zU8uQUPxg==
X-Google-Smtp-Source: AMsMyM5v0KjQxhDpJWnoKveGxshlrbAVJrlZMD9/5OCDgNPK445iwsl9/d2T0Wxfm8xQdesN4ZVSEg==
X-Received: by 2002:a05:6512:3134:b0:49f:ba4d:3b71 with SMTP id p20-20020a056512313400b0049fba4d3b71mr12110532lfd.30.1664300350026;
        Tue, 27 Sep 2022 10:39:10 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac246ec000000b00498f570aef2sm218879lfo.209.2022.09.27.10.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:39:07 -0700 (PDT)
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
Subject: [PATCH v3 29/34] dt-bindings: pinctrl: qcom,sdx55: use common TLMM schema
Date:   Tue, 27 Sep 2022 19:36:57 +0200
Message-Id: <20220927173702.5200-30-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
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

Reference common Qualcomm TLMM pin controller schema, to bring other
regular schemas and additional checks, like function required only for
GPIOs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>

---

v1 was reviewed by Rob, but patch was changed since that time, so not
adding Rob's tag.
---
 .../devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml      | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
index fff57abf4fbc..498f2f87217f 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml
@@ -60,7 +60,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "/schemas/pinctrl/pincfg-node.yaml"
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
@@ -122,12 +122,11 @@ $defs:
 
     required:
       - pins
-      - function
 
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
 
 required:
   - compatible
-- 
2.34.1

