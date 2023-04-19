Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBC36E8375
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjDSVUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjDSVTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:19:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306F49ED6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fy21so1598831ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681939161; x=1684531161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uCLIGeLxQr9ljzwadfVn/99q0kinYdKnpUPlrBXw6M=;
        b=plsYe56jM4BTEpAPwPFtRxzoF0uw6lH28hj+jyAvb/+vWoK9T9fAPwly5EXPrcxUny
         IvXf/mPkuPB4e412PchPlMoXjoSC/6yHOpPqY/USeCejhzH37B2SIGFG1lUPOTb8Xqeq
         XA8+WIrPgjKBj8ktLn3PbVQXvv862wFBX5gDkTJ1AgdrzfHP9isFmF8Ys0jOQ7wh5XT1
         /fbSUwVgGcphlot/23gZwYZj6P2nA9U0wXen8Ddpxqfn4yXig9pkhw6drIqcCxG2Al02
         qIarZsr0pCdyOW8WaSyzghoczXluIUH8XT0cvz6izw21L6daBngdytvXq0eT0CTec1eq
         lRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939161; x=1684531161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uCLIGeLxQr9ljzwadfVn/99q0kinYdKnpUPlrBXw6M=;
        b=TdabuXsh5Big77OfsBysj+Py7vsaoOghbtlwOK426IMglbc7qMTr5lZO3rf0tyPIxB
         wFBOc+wYctMuagd8r5L0/ZgZk8Cj0BfQXvZkYUo1N/Ec5OBvU/qs8d8mo1hOYylsQpiS
         li7Y2yatpaMr3JSfYo14NMH3nQBhI2JKOi5W9IftBjq3EVrNiuiJLyfwtp4hWUMU1fAU
         SjUqdWVCW9LkGwRHjWpSHH4PpGdzGU5751a6DzpP+0F+atlhJRAyLqskGImVbZ1y0wgc
         FtwpmwgAbmY/lH93f3xERzeTq4Ig9Bzk9IN+R9IkUCBfElSYzquOT4Y3Apz/IoKlv5nd
         LS9Q==
X-Gm-Message-State: AAQBX9fTKGgl63IvujoarRr2vzKMPmTx5LGLrHVKzCa+ws9vPiZaXLga
        bE00tb48US/hXb3lbzWUBw/Aig==
X-Google-Smtp-Source: AKy350ZsXMfBW8xu0aKbrc7ii5ZdXgJGWFfpsRPt7t6kwi0b2JRq7VVGs3QRyN0lEZtYKmBeg0Yg2g==
X-Received: by 2002:a17:906:d9b:b0:93f:505b:9742 with SMTP id m27-20020a1709060d9b00b0093f505b9742mr16512098eji.65.1681939161405;
        Wed, 19 Apr 2023 14:19:21 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090682cc00b0094f109a5b3asm7092739ejy.135.2023.04.19.14.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:19:21 -0700 (PDT)
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
Subject: [PATCH 14/18] arm64: dts: qcom: sm8350: correct PCI phy unit address
Date:   Wed, 19 Apr 2023 23:18:52 +0200
Message-Id: <20230419211856.79332-14-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
References: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
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

  Warning (simple_bus_reg): /soc@0/phy@1c0f000: simple-bus unit address format error, expected "1c0e000"

Fixes: 6daee40678a0 ("arm64: dts: qcom: sm8350: add PCIe devices")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index a9af730e0b1c..5ca21cd1cbec 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1638,7 +1638,7 @@ pcie1: pci@1c08000 {
 			status = "disabled";
 		};
 
-		pcie1_phy: phy@1c0f000 {
+		pcie1_phy: phy@1c0e000 {
 			compatible = "qcom,sm8350-qmp-gen3x2-pcie-phy";
 			reg = <0 0x01c0e000 0 0x2000>;
 			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
-- 
2.34.1

