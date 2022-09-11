Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383995B4DC1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiIKLMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiIKLMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:12:10 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8C532B88
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:07 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l12so7395394ljg.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=85V1z4OqIWufHfQcREFlCkHGXRpOp1EI7O4MBaWUk5Y=;
        b=d6m2dqm0zPkC52J4gJ/OMse/5xIzFQi8llLAstyimsEETJP2U7Ra4+gPqbjPgzhvAi
         7qGTBReqynDOhLtW3L+cHA6MpEwyAFlEkurPk8YhiCmIsxyrfJelCWqmHF2GoJqChhI4
         YVZKZ/VLS462h9RmZ54uqA7s9SRht66DL5UvNhJgwNQ/YF7emXDKSdzxC6Ez7kjmWlpP
         gSo4NGEAdR8wKGU8jiWR2ZLec1nGk7Ghk4uDiPCvotS+26sP6cHB0ApEQwrERmYR85ta
         nQSrf75tF6d7PvTozkGoZlytOvhT1h8kcWM3u+XE/SPFjQASHyVLF97U+IKbk1j+70dQ
         AU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=85V1z4OqIWufHfQcREFlCkHGXRpOp1EI7O4MBaWUk5Y=;
        b=wzbtFuI1woiMHbThO8FTgw1do0OvRq2htCqpCapPgqHOHe3ujqXDil97H8tuDWgG9M
         09O1OjfKhchepaiNg67V+FIaJDMat4QuyfCC3MuD1euogCbHt8mx5X/Cp0gUfU7dX5fr
         kEXdy1opf7FOn1jMR67X2eyeeO85iIazSaCMYFZfQNqmbhu0R+eLbRdeX/LXEUs2CI/H
         M+uNkWvHmhHyvqBDfEhh+AnuMDHED+7WoQX4iQNNKIRDdEEItmlYxUb7aAc6Ucxunjqi
         jnULOdItFpwK5Pm4wuEqcZBWrtar+BTJmchZoUtMVQ8pmYqBcIiWnfu8Wo7OriC3n/9f
         Ax+A==
X-Gm-Message-State: ACgBeo37hHe6MHjTDNh273WDBw1oBsukJUhIlnT8rOLx6HcNWIEKGPeB
        2Iqe6UIe3YHmc15WRmYl1FaO4g==
X-Google-Smtp-Source: AA6agR77H1mhR02bURJCSDjh8vvw7TXF9G5tDmwjugg0JNVaapXWHYWsgnrx5kA6sfZStUl0VVF4fA==
X-Received: by 2002:a2e:5d0:0:b0:26a:9a2d:ca90 with SMTP id 199-20020a2e05d0000000b0026a9a2dca90mr5946720ljf.102.1662894725931;
        Sun, 11 Sep 2022 04:12:05 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025dfd8c9287sm607365ljc.69.2022.09.11.04.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 04:12:05 -0700 (PDT)
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
Subject: [PATCH 01/40] dt-bindings: pinctrl: qcom,sm6115-pinctrl: fix matching pin config
Date:   Sun, 11 Sep 2022 13:11:21 +0200
Message-Id: <20220911111200.199182-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
References: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matching PMIC GPIOs config nodes within a '-state' node by '.*' pattern
does not work as expected because of linux,phandle in the DTB:

    'pins' is a required property
    'function' is a required property
    'rx', 'tx' do not match any of the regexes: 'pinctrl-[0-9]+'
    [[59]] is not of type 'object'

Make the schema stricter and expect such nodes to be either named
'pinconfig' or followed with '-pins' prefix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sm6115-pinctrl.yaml         | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
index d8443811767d..8a2b4767c7b6 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
@@ -59,8 +59,9 @@ patternProperties:
     oneOf:
       - $ref: "#/$defs/qcom-sm6115-tlmm-state"
       - patternProperties:
-          ".*":
+          "-pins$":
             $ref: "#/$defs/qcom-sm6115-tlmm-state"
+        additionalProperties: false
 
 '$defs':
   qcom-sm6115-tlmm-state:
@@ -155,25 +156,25 @@ examples:
                 gpio-ranges = <&tlmm 0 0 114>;
 
                 sdc2_on_state: sdc2-on-state {
-                        clk {
+                        clk-pins {
                                 pins = "sdc2_clk";
                                 bias-disable;
                                 drive-strength = <16>;
                         };
 
-                        cmd {
+                        cmd-pins {
                                 pins = "sdc2_cmd";
                                 bias-pull-up;
                                 drive-strength = <10>;
                         };
 
-                        data {
+                        data-pins {
                                 pins = "sdc2_data";
                                 bias-pull-up;
                                 drive-strength = <10>;
                         };
 
-                        sd-cd {
+                        sd-cd-pins {
                                 pins = "gpio88";
                                 function = "gpio";
                                 bias-pull-up;
-- 
2.34.1

