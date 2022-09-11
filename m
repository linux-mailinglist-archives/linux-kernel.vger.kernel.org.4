Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C38C5B4DF0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiIKLNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiIKLNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:13:05 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B3833A2E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:29 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id v6so7446525ljj.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=11whfBmZQZTESKD6+YPUVTdrbpEpmk+FiIRnZHBW3ck=;
        b=Pve93wqdlwmK5mjKf0pPzYZhKuqHUik7JU0zfO0y1gXK+JKDzB7WsO25wrjmtnsBup
         4NXxcf0zwpFyPvxBkPobcHFtzLLkANUALGK/0q30EqbVswYwO/CMpkwKWHcM1Jw8ocIr
         RORF9+Cgt3S7URWiK9qgLp+OQYZh6dW/dhV4wTz/CbmMs5UlVRiC1lInL9jlLy+vPAnk
         QPJrnGYjnIPT1rAGV8RS2i02F/5VHDVtznlaJWqtAVRrYjPND4oenu23r1WO9HVoK6o4
         4FwN2AeMW4crduOaJcUNIqffEx8zJXcpeAXqUgoJGs15yHrmk42i+oMdR6MSH26TsOFU
         ULhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=11whfBmZQZTESKD6+YPUVTdrbpEpmk+FiIRnZHBW3ck=;
        b=HpPzoxw/8Y60e98ohZr9izS+XALJR7EjJRj+4SjWRtHJnj4VLAY4O3g3CEhkwmNZUA
         f8clDDzmFreuLkW0znUAcOQS1cK6jeg5JzkPktxHF/fiGMpeBMoyZcKhLSl9vXgPDlg3
         Q/CMaT4zewLjQ1GpRE9HdRD7ZnTSmRXixhTwA7SovESNcG7bT1sqNEK7AI2ZTueuG0kW
         LGGK9MWxNGD6UhoZazZgs5rFqx5Gq9sCmhjTXxCSWPfQ7UPdDszS8Lk90Sl+DOxXQuJ2
         jwNHKsT/g63Vl1xOi0uCgpPGivVtRlEJdTNqBhUkG9Fp4LU86PTNy4SkQ1NvUYkyemXS
         Lfvg==
X-Gm-Message-State: ACgBeo37X/JbOMiJsqs/ASwIBSnRRi4o2bWhByc53HUgwVq4rB4WqGMJ
        /NvCd3bKDzN40tWDnO/azGZC7w==
X-Google-Smtp-Source: AA6agR70mp0hoUv7NrTPXl4ZjssyLfQ8EXRd4kH3UQ32x1WRcdBhcBMORnVzYq+ABfa2+UjRI/UrPA==
X-Received: by 2002:a2e:9e11:0:b0:268:c7d0:9662 with SMTP id e17-20020a2e9e11000000b00268c7d09662mr6093546ljk.309.1662894748500;
        Sun, 11 Sep 2022 04:12:28 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025dfd8c9287sm607365ljc.69.2022.09.11.04.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 04:12:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 19/40] dt-bindings: pinctrl: qcom,sm8450-pinctrl: fix matching pin config
Date:   Sun, 11 Sep 2022 13:11:39 +0200
Message-Id: <20220911111200.199182-20-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
References: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matching PMIC GPIOs config nodes within a '-state' node by '.*' pattern
does not work as expected because of linux,phandle in the DTB:

  qcom/sm4250-oneplus-billie2.dtb: pinctrl@500000: sdc1-on-state: 'oneOf' conditional failed, one must be fixed:
    'pins' is a required property
    'clk', 'cmd', 'data', 'rclk' do not match any of the regexes: 'pinctrl-[0-9]+'
    [[26]] is not of type 'object'

Make the schema stricter and expect such nodes to be either named
'pinconfig' or followed with '-pins' prefix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml   | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
index 9c891246245b..d1d1c1455b3c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-pinctrl.yaml
@@ -43,8 +43,9 @@ patternProperties:
     oneOf:
       - $ref: "#/$defs/qcom-sm8450-tlmm-state"
       - patternProperties:
-          ".*":
+          "-pins$":
             $ref: "#/$defs/qcom-sm8450-tlmm-state"
+        additionalProperties: false
 
 $defs:
   qcom-sm8450-tlmm-state:
@@ -127,13 +128,13 @@ examples:
                 };
 
                 uart-w-subnodes-state {
-                    rx {
+                    rx-pins {
                             pins = "gpio26";
                             function = "qup7";
                             bias-pull-up;
                     };
 
-                    tx {
+                    tx-pins {
                             pins = "gpio27";
                             function = "qup7";
                             bias-disable;
-- 
2.34.1

