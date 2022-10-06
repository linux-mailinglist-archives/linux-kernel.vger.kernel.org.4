Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BFE5F6947
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiJFOJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiJFOIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:08:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B629AD9A5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:07:28 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a10so2414517ljq.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SUkmCj6raKwJ6nLMDOHRNWqtzaiPr1DEvViiZWEFies=;
        b=ozXPrM9QFPCRFI+lBW323et2Jj3vh5Ya70o6UJoChkfIvDVtFRNxFogMxocrcuWDpG
         jAvgTiHyRwo/ro8H+zXwI9RM3P/aVwlnzPV5TFYNF8Uv06/ODZZcVBPDA8vx6uRO9bpl
         nfD+WpZMt6O3iiH7Sc5lrQzSLH2wxo+c2zy5Zkkcahs2K+AtIp4+tRynYIV+ylg1Slqm
         H0oQouPK4qm+bi6kBU558D/gotOmKlUYn5KHiUJsFGtOZZ/sWrGFgRsEP3dvdtJAAcks
         tItbavq9wVb5fr4nd9CLhDD7wmUFM9zCDPIqhc0gGuakQkyBlF9V5KhmuHg0CzvegnqO
         0A3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SUkmCj6raKwJ6nLMDOHRNWqtzaiPr1DEvViiZWEFies=;
        b=b7PFx8YzpO97zqTfiomuvecNxPN2wqK5MV0nI/iPuPC5eb9OQlOZkP3pJtcKbotZGs
         JhC8C0QMEhMFs5/N7cq0SQdEYZMbG3OQ4AA5Zr1yzeNYvYWj/rLjxR/LFfEuSrMgGbIo
         WenyJp49hHXst5H92zqvNNSDwuBBFxId/iFmykmB44LjgJn7Li7IWeM9cJj9wXP4CDsm
         HjVzWPQmdLQ3DKyFEEzC1GRUpelNp/YgJE5vspZ2Fus4T90W1KmkdNBGJ3YCYZxv/ESm
         kgpsMDO7sr1MS/Dt2lNcML89ixHXCdzqJoQ1H9AAFB+9ddC4bxd1LGQAh24fmu8Va1FL
         HpYw==
X-Gm-Message-State: ACrzQf1fwJnP+Ih9WXiDu5B6TkIMQKrGQpn4du17nLT9KguZ+KYp2TGX
        iQa9UpZakRqgL/gu1UmZqq3hLg==
X-Google-Smtp-Source: AMsMyM7XGf4FwJZV+8Z3SqQfeJN1VtM8LMmSNR52RL7E+IOxiETshU5EV51PLFNJuryMX4Y66XEM0Q==
X-Received: by 2002:a05:651c:1a25:b0:26c:1deb:4806 with SMTP id by37-20020a05651c1a2500b0026c1deb4806mr1874470ljb.49.1665065235254;
        Thu, 06 Oct 2022 07:07:15 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:07:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 25/34] dt-bindings: pinctrl: qcom,sm6350: minor style cleanups
Date:   Thu,  6 Oct 2022 16:06:28 +0200
Message-Id: <20221006140637.246665-26-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
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

Drop "binding" from description (and align it with other Qualcomm
pinctrl bindings), use double quotes consistently and drop redundant
quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sm6350-pinctrl.yaml         | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
index 894e59caa735..38355409fe43 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-pinctrl.yaml
@@ -9,9 +9,8 @@ title: Qualcomm Technologies, Inc. SM6350 TLMM block
 maintainers:
   - Konrad Dybcio <konrad.dybcio@somainline.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer (TLMM) block found
-  in the SM6350 platform.
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SM6350 SoC.
 
 allOf:
   - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
@@ -25,10 +24,10 @@ properties:
 
   interrupts: true
   interrupt-controller: true
-  '#interrupt-cells': true
+  "#interrupt-cells": true
   gpio-controller: true
   gpio-reserved-ranges: true
-  '#gpio-cells': true
+  "#gpio-cells": true
   gpio-ranges: true
   wakeup-parent: true
 
@@ -39,7 +38,7 @@ required:
 additionalProperties: false
 
 patternProperties:
-  '-state$':
+  "-state$":
     oneOf:
       - $ref: "#/$defs/qcom-sm6350-tlmm-state"
       - patternProperties:
-- 
2.34.1

