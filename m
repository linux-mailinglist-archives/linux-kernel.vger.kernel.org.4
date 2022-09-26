Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08315E9B26
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiIZHs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiIZHrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:47:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60B760EE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o2so9454538lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8KHbSdK0R146ghgYDwfxWBheqlrOeLbmtxLPw9rHJdI=;
        b=t81lkCyq37RMtQ5/0rcnAfHNgWAm6G4Hh0NVVNuCFBm8NrAfrgTbJPGVWQ+KpD8x6r
         HHC5+udgAbTrytXBvP/Pd+4vW6viVYyJCS1BC6hNB1fJ/4gm4RC2R5RZCfzSEVa1dJ84
         fbbRoV4+RPEMx5L06DRlATIWbBwBPe+v3oCcTqJxFSDH+REdHsZidx9cJ+GpiUz8tV5x
         O700vyR1TMY8B5MoYoZyDhI0aRoCOk6NZSJBX8ECHxAnm+tcVJMDH6xb45ttYS1ov3VM
         adLY9/AQPlX7iN1O7g+SR/4d/50Xuif/xESWoeOc57mOfLH3i1CpXFMbsrLOC6ErWz9e
         MWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8KHbSdK0R146ghgYDwfxWBheqlrOeLbmtxLPw9rHJdI=;
        b=Khy/i+3xADA0vwLRluC0DypMH35dob2lJKp0hdrZTPUSAAyXpXMajAs8MR+JzcpxGG
         wpsOk97r0z2AJ92B4Kt01PF2CZEhLwbiwBxtIcQ58I74XsTRRNwW1h8elCHqj9yKrbDE
         4Tr2mQFCsKwTAdhF2UrvKS45KpUXJtN8ldaQP+oqisroLKmYAE+G47dHb8VVZgtYPwfR
         poTyo8PYJU15d1BWKHLc8bc75Bmdzr1KyXhLc2ew5//6YBQNB+uUEUApGXaAx8VGojnV
         KhrFTVsTuysRnEU/aqpdY27zqNK3pxGUkhCsPSKzm1+oTNOx7ohAKvKw52cmu/SbaVJZ
         aUWw==
X-Gm-Message-State: ACrzQf3lwk4negQGTO9i8QAE/sKS8BYuPV8sfUC8Kv2wfJETBleSqApF
        oTn4RgSgeVLmgLN99bAKxkDMAA==
X-Google-Smtp-Source: AMsMyM5kNEdtxdZTHiynp64TnmGW7I/FY+3SlwkDjK2yFnvrKVRVAlnzpfEqMRcpuZAtV1ca8qPYaw==
X-Received: by 2002:a05:6512:33c3:b0:4a0:4434:1c85 with SMTP id d3-20020a05651233c300b004a044341c85mr6649809lfg.302.1664178310797;
        Mon, 26 Sep 2022 00:45:10 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:45:10 -0700 (PDT)
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
Subject: [PATCH v2 24/33] dt-bindings: pinctrl: qcom,mdm9607: fix indentation in example
Date:   Mon, 26 Sep 2022 09:44:06 +0200
Message-Id: <20220926074415.53100-25-krzysztof.kozlowski@linaro.org>
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

Bindings example should be indented with 4-spaces.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../pinctrl/qcom,mdm9607-pinctrl.yaml         | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
index 57a4fed55de7..a37b358715a3 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-pinctrl.yaml
@@ -120,14 +120,14 @@ patternProperties:
 
 examples:
   - |
-        #include <dt-bindings/interrupt-controller/arm-gic.h>
-        tlmm: pinctrl@1000000 {
-          compatible = "qcom,mdm9607-tlmm";
-          reg = <0x01000000 0x300000>;
-          interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-          gpio-controller;
-          gpio-ranges = <&msmgpio 0 0 80>;
-          #gpio-cells = <2>;
-          interrupt-controller;
-          #interrupt-cells = <2>;
-        };
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    tlmm: pinctrl@1000000 {
+        compatible = "qcom,mdm9607-tlmm";
+        reg = <0x01000000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        gpio-ranges = <&msmgpio 0 0 80>;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+    };
-- 
2.34.1

