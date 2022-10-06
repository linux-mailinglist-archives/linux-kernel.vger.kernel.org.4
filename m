Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3208E5F66E3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiJFMuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiJFMuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:50:18 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FC8A50D3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:48:11 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id t16so2112904ljh.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KwbF9jO+sY4vXoUZ33qB21i8B3HKy8zqWPUMYNOaFag=;
        b=RDR9OpPgvastLJKKWTE/chUZe7uXRSg+FzziEdZhMaGPZC+5hceCocjfbTPJDdZ6Wt
         j819AwjwgE7ST7BO0j3LWzMcakhgZQGEL5F6DXDG3LZU7Y35ov9/2agPJy+9UpFU0QbI
         qpPV+EkE0xJqYGZu9v9Oprg+P/a1iglYsDcCrDHBigDQNEiezuW9NaVhNaulsB8tq27u
         6Oi6v+nhsayfFhSUkCpAIyoKJWOXzwp6cXfctuR7H9tyKSd3EUo0TH5PjiWNrdueiUhE
         74Rs278Fo+2rcjt13qAX9yAVgsjj5tRnax9fZpE9xRWzER9rqwjbFLyvntP5CPIFIjOD
         092w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KwbF9jO+sY4vXoUZ33qB21i8B3HKy8zqWPUMYNOaFag=;
        b=QU7BnRuSn+Hf8dCTogaMBp+WDTPN3SVHqnrXfAC+D3srQT0Oq/MToOIoyefsHEbJ/e
         2h+rGipGjWaqfAdBFTb8ObwM13Z5k7+07vtVFBOZRVZ1kqW/+Cd++iVwdNMyRdn2nH55
         loZeWBuJWZTC5OZC+UGHGxZV6HFufbdSTFRMVqAv5moMxLdCeXyxI1aOcBPBT1sg0bTo
         Wi9ODM67mvlzaxTPcduE+MR8gv49y6ijF2Y/+FKi+aoSNnzYEiy9IPlE1P1yBK6aAf6k
         SHi29zb0TwTSDPZBCxhqclEMPvUmFmfGG0bmSlUn9BuAnT4uDREYEeCx2Jefyg0fBaii
         B6dA==
X-Gm-Message-State: ACrzQf0tuS8ne8r0LoYq0o0bIjjpaMiuP1MPkW8oNEQH+nTwwy/6bT+Q
        Vkzkp7LjHX1puo3fX/eWCAhwyw==
X-Google-Smtp-Source: AMsMyM4mn9tQJaC+3CCD88sKjPIHvhKpp5WdmgzM+4uxNXeHEbcZ3J2Zv69dK+EC6uK4PDgckWC6ig==
X-Received: by 2002:a05:651c:505:b0:26c:5815:5519 with SMTP id o5-20020a05651c050500b0026c58155519mr1722907ljp.316.1665060458025;
        Thu, 06 Oct 2022 05:47:38 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b00497a3e2a191sm2687659lfb.112.2022.10.06.05.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:47:37 -0700 (PDT)
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
Subject: [PATCH v4 31/34] dt-bindings: pinctrl: qcom,sdx65: fix matching pin config
Date:   Thu,  6 Oct 2022 14:46:56 +0200
Message-Id: <20221006124659.217540-32-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
References: <20221006124659.217540-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml   | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
index cdfcf29dffee..0f796f1f0104 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
@@ -49,8 +49,10 @@ patternProperties:
     oneOf:
       - $ref: "#/$defs/qcom-sdx65-tlmm-state"
       - patternProperties:
-          ".*":
+          "-pins$":
             $ref: "#/$defs/qcom-sdx65-tlmm-state"
+        additionalProperties: false
+
 '$defs':
   qcom-sdx65-tlmm-state:
     type: object
@@ -175,13 +177,13 @@ examples:
         };
 
         uart-w-subnodes-state {
-            rx {
+            rx-pins {
                 pins = "gpio4";
                 function = "blsp_uart1";
                 bias-pull-up;
             };
 
-            tx {
+            tx-pins {
                 pins = "gpio5";
                 function = "blsp_uart1";
                 bias-disable;
-- 
2.34.1

