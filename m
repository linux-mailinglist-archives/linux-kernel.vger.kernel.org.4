Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828E65ECB46
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiI0Rkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiI0Rjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:39:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450431E3F5A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:38:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 10so16810505lfy.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uD2RyyoUDEDp73DlKG49OaPatIgbAFXoIb3QJoCnkRM=;
        b=PI7jVYVHsGUNnsUonQhY/OxVvEse8uvvhzz/lCB20arB7R7UBYrqcAqaLv3VcKJCbH
         nDHp4FzlxZjudjkyxUqMiYaYHxzTfl/tdnCyyiNakYq/OtopoRE9CbIVpia11szXY7P0
         3+DcZwuarbDApfylMlZ8aYZo9djicqUu1YI9+rxxMLp9yFURTgUnzNFVGGy9nq0gC3hc
         kQQh0ALu7z7B58eCP0WQxPVzcQjbjfPzcAlvauHXN2iiwx8QfRYesbSOpsL8edzHlAr7
         0U/maMDGyaUXnrJCjMkTkXnWNBHYm9Yf4a/Fb+DCjx95lBWSiBk5727Mf5yUOT5p8QJ+
         tr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uD2RyyoUDEDp73DlKG49OaPatIgbAFXoIb3QJoCnkRM=;
        b=YYF97Qh1+EABd3vsf0/lLklfb67YwnxaJsgCGCO0Dp6gAd4UqOQsyJhaOPucNT7aQ/
         RZRYzM6TrN6imdXKGm9uF7ajbE1l7qkQofTXYh6Q6sByS+GI8Mh5d485LfTh+TWhqn2B
         sDmveKZj+SMGwGD3uyse8btUEXpS3NyqE80cx0va94sC47Wba84ywiapDJa8sm/2H3OZ
         EeybTjt/f0Aft8oWzxgcTxkXuLBQuj2N4cOjwajjxKnqGQ06aFrAMRwWCrpjRk5hxEmJ
         8fXb7KIbAL29i8llBx2Run+QiVZFkvPT923cFDG2+nOX/u61xbq0eUMc/GTqgrE4u0Fw
         R3ZQ==
X-Gm-Message-State: ACrzQf0XAFZY6EzF43cQXwxDEgmW+tIulNOqDfp8g7yc0jTJ4lmKmkbk
        Y3RYJKgER76ShmbwHt9BezwGjQ==
X-Google-Smtp-Source: AMsMyM7SXDzFfaxQ4C0iI1F2BDR4krUVI54+cVu7LFnutLWKpHao5yWlgIXim5/TYPg+uy4nq07rzw==
X-Received: by 2002:ac2:484d:0:b0:4a0:5399:9b70 with SMTP id 13-20020ac2484d000000b004a053999b70mr10306484lfy.216.1664300327554;
        Tue, 27 Sep 2022 10:38:47 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q12-20020ac246ec000000b00498f570aef2sm218879lfo.209.2022.09.27.10.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 10:38:46 -0700 (PDT)
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
Subject: [PATCH v3 22/34] dt-bindings: pinctrl: qcom,msm8953: use common TLMM schema
Date:   Tue, 27 Sep 2022 19:36:50 +0200
Message-Id: <20220927173702.5200-23-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml    | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
index c162796ab604..1bf29b82f486 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml
@@ -59,7 +59,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "/schemas/pinctrl/pincfg-node.yaml"
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
@@ -139,12 +139,11 @@ $defs:
 
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

