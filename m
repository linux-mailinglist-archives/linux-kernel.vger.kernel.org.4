Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD026E834A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjDSVTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjDSVTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:19:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121BC44BE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id xd13so1707624ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681939139; x=1684531139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XNdQHUKODXXt67LxaUJzh+dDCQhTNW3uFMbegpJCJsk=;
        b=nX5oPLbdwltmiYoQBnR4YxIT2zRkKw7dW9RzYvBDXorZs9N4KO/oD/g/e8Svec3y0k
         HEFmVwAIWDcvt3/rhIwcs+3OSGSjDgkS00vSLOmJkgrbjW7r9l2L4Pf4siQHImEl6zZ0
         DacojzsnLflHR5QuQFMR0PrPLf7Me3LpuWd390K62WOrUBSUaEMHa52QmB3mcSUmRV9Z
         Ntg3Y92b+icXZINL7L7QEgPNQaGGF78JIi0piPFwzeITQ7zKVuQLKQFGMjGUO9E71evM
         uUDnu6IdwW8EFmDGsD2xf1rHSx5Zcp+LngzeNXJMZX4qTURtYY3GO49JdISVPz6j/Dne
         Mw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939139; x=1684531139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XNdQHUKODXXt67LxaUJzh+dDCQhTNW3uFMbegpJCJsk=;
        b=K2l4Qh7ThBhy8ZcjyvOxRm1NbIowD8tu2mGaBHLbeYHVoP9aBVUdWAcRTkdzgAuUx3
         b+6HNAq76ciGOj8j7E+fAT/mhSIRRprvMdz59M7G+JkpZCqPO/q7ZVg6ECgV5nZ8fqQ7
         V+5miygTL33kQAuMxhO24LIWSiF01CLY73irFL5/o/+dVpB+WgeQw2vLYbOcdmkO33ty
         gHyLc06OLO7Qe/XFffAcFlvKz4nM35ZyVMeFJlwwQbhnzp7m7AP2uJviitxZMGdEj6C0
         cffa4TFjLYMhiJNtvNVQmGUQnyJqqXmw9a/klm/cENCiFD7D37m0vjj05FgBCkVGJ6Hy
         HLrg==
X-Gm-Message-State: AAQBX9ewngNwiZ4Khv2r7k7PAj/99JfwHIedn863cjbil0komilIqz4y
        pR1GAXKyCOOpbh+k1/3h+fsOMA==
X-Google-Smtp-Source: AKy350ZgzRCuAoWVAG/NVKKjpMHo44jBMi6sU6qS/XC10WZcV/Jxsi+tjrstlMFaAYREbP5Gz/6J+w==
X-Received: by 2002:a17:907:204c:b0:94d:57d2:7632 with SMTP id pg12-20020a170907204c00b0094d57d27632mr16504563ejb.31.1681939139568;
        Wed, 19 Apr 2023 14:18:59 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090682cc00b0094f109a5b3asm7092739ejy.135.2023.04.19.14.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:18:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Todor Tomov <todor.too@gmail.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robert Foss <rfoss@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Molly Sophia <mollysophia379@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 01/18] arm64: dts: qcom: ipq6018: correct qrng unit address
Date:   Wed, 19 Apr 2023 23:18:39 +0200
Message-Id: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match unit-address to reg entry to fix dtbs W=1 warnings:

  Warning (simple_bus_reg): /soc/qrng@e1000: simple-bus unit address format error, expected "e3000"

Fixes: 5bf635621245 ("arm64: dts: ipq6018: Add a few device nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 54af7cb3c7a8..992e8ed64617 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -302,7 +302,7 @@ mdio: mdio@90000 {
 			status = "disabled";
 		};
 
-		prng: qrng@e1000 {
+		prng: qrng@e3000 {
 			compatible = "qcom,prng-ee";
 			reg = <0x0 0x000e3000 0x0 0x1000>;
 			clocks = <&gcc GCC_PRNG_AHB_CLK>;
-- 
2.34.1

