Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C213F5B4E41
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiIKLQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiIKLPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:15:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE873ECDF
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:13:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z25so10392462lfr.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LY6MROhdDWqu/4edFHort3LM4phvkt99NZ7SpMsHito=;
        b=UlXwv8zHCBGWyOuF0fWGnm/+ajG1lCVWlYEsBbu/dKAvoHgwdqOuQgjf/WTOzXSvUq
         MqrbG3c8nac+2YDkXM7lDCliEMZm2Q9693NYyn/7thWYtKG2+fDMmCh16CkxP0xQBWak
         yVIBYEgDNEALssE4NdniucFuuaqHJAlbkR6H/NZiUqYp02tQxdJsLW7n1Kgfg5fwcUxf
         AXxb34hgNGmQv0niVlnCuIlqF51KT8+u8vYR2iza4VmyvXiENAwTwjZB2evzmqYHLWKl
         fzwpSwZETKk4A27gXcd3BPk8SSl8C/t4Q1+2ceHaOeE/5KEOMwOnyVFXURUG8TffgOWZ
         gn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LY6MROhdDWqu/4edFHort3LM4phvkt99NZ7SpMsHito=;
        b=edYSagK9xUGzRYlaZ1TUPjTJm4oX5ZBFztCYXDBur+Chd1PQ8ufUVGusWgpWCrRZAY
         4bjogq4SfNZzECo4iCgaKRB4GqjMLduM751+2+U1yVesFwLtwjkkhqATapycVo5dFoUC
         z2enXC9x7WrB2GiiVE19WPA5/t3gRf0PmtaQGRNaNhB1XWuKBfR9CIQcKaFNy+Q1oy9z
         jdFjqUywT49kicIg3Cz8F9zUWAeWlwaTmxujVyvQSwj+uUrmnX1CwuTUxFJdFwIYmw1O
         7TQYK1j9b8REstuhF0GO+4lxuaBfsHSpv+qUi7zCy7X+VUXDZPjhiuAPnKBnEdgNy7xU
         O4Jw==
X-Gm-Message-State: ACgBeo1pH8w4GliGeEZcPUXm1Pc7/vLe3GVn/aRtnU0Sss7krTD2rBxg
        iw00uzw4MM7hiMld1sshUIeBGA==
X-Google-Smtp-Source: AA6agR75JudROwn7bBCFv7WnkmTOAERMdjhFVJG5LusllC9UtEA8ZA4zgLpjORcn6SoUc/vBMI+PDQ==
X-Received: by 2002:a05:6512:3a90:b0:48a:fcf6:3137 with SMTP id q16-20020a0565123a9000b0048afcf63137mr6654623lfu.255.1662894764144;
        Sun, 11 Sep 2022 04:12:44 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0025dfd8c9287sm607365ljc.69.2022.09.11.04.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 04:12:43 -0700 (PDT)
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
Subject: [PATCH 31/40] dt-bindings: pinctrl: qcom,sc8280xp-pinctrl: fix matching pin config
Date:   Sun, 11 Sep 2022 13:11:51 +0200
Message-Id: <20220911111200.199182-32-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
index 87a381c9a19d..5147afc28721 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
@@ -43,8 +43,9 @@ patternProperties:
     oneOf:
       - $ref: "#/$defs/qcom-sc8280xp-tlmm-state"
       - patternProperties:
-          ".*":
+          "-pins$":
             $ref: "#/$defs/qcom-sc8280xp-tlmm-state"
+        additionalProperties: false
 
 '$defs':
   qcom-sc8280xp-tlmm-state:
@@ -135,13 +136,13 @@ examples:
                 };
 
                 uart-w-subnodes-state {
-                        rx {
+                        rx-pins {
                                 pins = "gpio4";
                                 function = "qup14";
                                 bias-pull-up;
                         };
 
-                        tx {
+                        tx-pins {
                                 pins = "gpio5";
                                 function = "qup14";
                                 bias-disable;
-- 
2.34.1

