Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973645B53DF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiILGSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiILGR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:17:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3C826540
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:17:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bn9so9324520ljb.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FI26vxDVvyB2ohU/Q2Xw8ikZ3CFzmn6rrr4FY2O/Oys=;
        b=M0/8cQ6sJ4K05sra8GufO8vQBqNlJPjWcLf14zPEPSFzixoHFP7lUzgkk1ARR51TeD
         zVL0FCRQL/lxz2tJC+yLAB0KHo7W6oI8AtKn8ui2NOoI+GT//J9OvBGzheOh7vZyDG/G
         PZuDZGh99myHf4APLISsDxePYWxV87UaEXASXFhDhyb4U0VAdhbFtp5ttGi/OL5PrTlw
         Ln+W2VBT1q/6QGJuCNIyWeemzQU9yShfSEt4KFJ99U8HeSwEZp23CPRta6kSl0KmwKhh
         T18kT+5/mn6MJ2ZZJc5CM18b7l0OXzPXwPaXo3+Bf8SDgUdqWpxZ38spoTu45GVB8tSu
         r7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FI26vxDVvyB2ohU/Q2Xw8ikZ3CFzmn6rrr4FY2O/Oys=;
        b=0A4nYsHC4vwpX9sLLo03Rgibg+u650eWheFu7FuBkHg+sYZPHNRDoSKUmh+MFJb0x+
         cGiLvapn+897GxiYXwrKfSEcFNl5JiIepAjaNouQtVoJJD6EMCwVG42+3LPVzwWhJs9a
         S9ToQhmxk2PLZwipxcjotVBESbPXeDnnTJd4rK1lYchMTQE7BHTJ5VsVuZG2bhbearv3
         8YF0TgSZX+UYda8eOgctvFEI/a1mGcG6Nkqh5z2/govBudWcwjcd+6DCnWTwArO4Awsv
         JKGHVI9rXCgi0dzSvqxdw6Vr/IcEIVUDag796s33Fiv6ft1e5gp3PBgLLMFZM915ZHrJ
         twXg==
X-Gm-Message-State: ACgBeo0gWmXD561AT1jID6xakYvVQCYNt0wyU4PaL0uSUI/tIDzV+reD
        GwKXYmDLCe6h+/M28Q6Vnd2xeA==
X-Google-Smtp-Source: AA6agR44iRqUM/EedU02ObBZe5dzrKszQKQeOKL35am5SOOWpwqC6LYWeNVNuIx/lpXvoVe9ByPhqw==
X-Received: by 2002:a05:651c:88b:b0:261:ba8e:717a with SMTP id d11-20020a05651c088b00b00261ba8e717amr7167538ljq.401.1662963473811;
        Sun, 11 Sep 2022 23:17:53 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:17:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 01/40] dt-bindings: pinctrl: qcom,sm6115-pinctrl: fix matching pin config
Date:   Mon, 12 Sep 2022 08:17:07 +0200
Message-Id: <20220912061746.6311-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
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

    'pins' is a required property
    'function' is a required property
    'rx', 'tx' do not match any of the regexes: 'pinctrl-[0-9]+'
    [[59]] is not of type 'object'

Make the schema stricter and expect such nodes to be followed with a
'-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Iskren Chernev <iskren.chernev@gmail.com>
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

