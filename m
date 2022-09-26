Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51DA5E9ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiIZHq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiIZHpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:45:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341661AF3B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:44:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 10so9507874lfy.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lMBveZFkgrYcH7gLjkthX6/xgtG5HWpV1ZO7qGMNEaE=;
        b=xx/8kVnepWUDXK3BIPh4oLdP90dN8y9MdIgJZkBkc1K0/zk/Xj1RVRrsTGSCdaQsoH
         k4rJKZXSqgzXpz0AtBch1ScCRfXcjL+KSFhEGNj2ljRlepm6OI7VE+Z7MOxY49EDYvDW
         fH8j9saomGhzuNPsoCbh2gcImz3tuVvsuZ/VSQM6KcoKuSHmcujLQlRQSDsovt2FapVB
         JXAZJSrE06LcaLAKcm5ElMfFBBcY0ho4il04uL2VQPIexY+W4HkFCSJWF/iffcggZjcd
         F10sBO1HC/wd1IUA3dgExQIYZoaRKU4QtKrJAEU8qsT8upaXzj2yb4w3kJ9Z1APmUZWp
         C6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lMBveZFkgrYcH7gLjkthX6/xgtG5HWpV1ZO7qGMNEaE=;
        b=3B8WIn10yrbDiNQH11k1qVrVQo/VnIY0Q7fn+6klAQ/qONXekIrE2xl6e2xzhPgDgB
         dpnSoaaSHa+sBmOKdsHB3BmyADgA8+zwMqzO+Pp2P+9QDNgdSWW50jTmSbKtC9pz97FV
         HLvUDv5Crzm//zEeOBcCiQSmS9vtc0DjDXmbe8FaB3x+Yb6bqquJxoCgdwzpmxzTnPwR
         3RlER3IdbemNpkn2x40WyaiH1hWhBy9hZyu7pNrl4/dJYkd/vT0Of+oat/8/zbg3ZUGG
         F9RD1fvrCPtyzFrUAcWguyGNVc3PcP1G57PkM2s51SuT8jYj9l4Yb7KLJ7VC5fxwU0k1
         RsUw==
X-Gm-Message-State: ACrzQf29+Acpo6u9dvU+Uu0guvh1cy2PIP7r6KjwIG02+RIQnPTmiSw3
        FwlpVuz+OsKaPV8GkUQRyFcdbQ==
X-Google-Smtp-Source: AMsMyM4hSig/ICFy8nRLGrGA2BQKLVDYEWBFQo3tIcNMkLiErdqlMGKBcs0HiQ6QAEjH8X8mjQNQAw==
X-Received: by 2002:a05:6512:311a:b0:498:f5dc:799d with SMTP id n26-20020a056512311a00b00498f5dc799dmr8078813lfb.501.1664178290604;
        Mon, 26 Sep 2022 00:44:50 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:44:49 -0700 (PDT)
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
Subject: [PATCH v2 14/33] dt-bindings: pinctrl: qcom,msm8226: use common TLMM schema
Date:   Mon, 26 Sep 2022 09:43:56 +0200
Message-Id: <20220926074415.53100-15-krzysztof.kozlowski@linaro.org>
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

Reference common Qualcomm TLMM pin controller schema, to bring other
regular schemas and additional checks, like function required only for
GPIOs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml    | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
index ecb90c77f666..4420bb23c9dc 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
@@ -60,7 +60,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "/schemas/pinctrl/pincfg-node.yaml"
+    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
 
     properties:
       pins:
@@ -101,12 +101,11 @@ $defs:
 
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

