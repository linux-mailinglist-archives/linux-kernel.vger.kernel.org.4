Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031CC6E837F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjDSVUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjDSVT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:19:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6CDA27E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sz19so1753280ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681939166; x=1684531166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbreylAZiZx0MR8q7RqMTF0y34SxdXJDIuOtW2itW1w=;
        b=cj6BH1lUn66fVNPgS4eB3Mg232JxY99ElnAGz4/ljGeKP+D8VPU4/8iFHgC3YVtIOt
         T26O/d/dwRpO0HArH2HbToPJ9IOc+PZnm6dDGugmqserxvLkU+/7sBOkNHXlWbMmMPEz
         8KwD44+3bo0EooBBu0tfc3vYBdTNt01tkgQ8wVQq/Yz5CQ/O4Pcseh+PUYzaI0vb1qo9
         RMe5gLjOk/4TCE89fWY9TJ1yOdPJ1gEpaLN96s85+/BcfiCNO5gov19e07ok2IGN0a07
         eqXIN1B4KLr71W1pzkz5eamtwBUmXJ0L29JATNwSP3kx608hRXCD9cQqYt5A81PL1I54
         gr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939166; x=1684531166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbreylAZiZx0MR8q7RqMTF0y34SxdXJDIuOtW2itW1w=;
        b=lita9NTXgdnjaTpb1KvTKgm9FKsXiMFFefvXFju/uCm8FasuvfsprgXtNsASf4NHyf
         Slg2vJq7TOSUJMINekUpCvP3X6vn+QiDIRS8YAn8PhSjD1934Ks2X0/RXkhOnx72b8hk
         xaub3B4zs0khK2Bt4KMLqINh8oN0fBIQqLwEpBsImlqmauKjfU+VnedD6Z0j7YXvvJOi
         c09XONuI3kkFuAkqzKdA1xnfVNWIlIvvcw1sRnG9KiF5HC+5C1T3Nqei+QvMzsuhMh5w
         mCER2T8Wt+STRrtMrKcEvs944OEvCb4nCWRyGmAHNf0fV6PcdxbACbd9HR/jW3A3j9DP
         5SJg==
X-Gm-Message-State: AAQBX9eoohfq0QaHqEwBuaOslTyOW7QMj7fbOCDc9kpu8UBgzIg48d6x
        gp0orY4qbOL1BbLbsG99bBCESg==
X-Google-Smtp-Source: AKy350aNR3xVlVQs2+sqhApRA2xgROk+MQy/CH8WB3kmlSSVTDbvRBfIJB3owaakGaOj2lB01VOZZg==
X-Received: by 2002:a17:906:c787:b0:931:624b:680c with SMTP id cw7-20020a170906c78700b00931624b680cmr14043844ejb.29.1681939166704;
        Wed, 19 Apr 2023 14:19:26 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090682cc00b0094f109a5b3asm7092739ejy.135.2023.04.19.14.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:19:26 -0700 (PDT)
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
Subject: [PATCH 17/18] arm64: dts: qcom: sm8550: correct pinctrl unit address
Date:   Wed, 19 Apr 2023 23:18:55 +0200
Message-Id: <20230419211856.79332-17-krzysztof.kozlowski@linaro.org>
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

  Warning (simple_bus_reg): /soc@0/pinctrl@f000000: simple-bus unit address format error, expected "f100000"

Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 90d2b7057b75..eef46045df93 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2883,7 +2883,7 @@ spmi_bus: spmi@c400000 {
 			#interrupt-cells = <4>;
 		};
 
-		tlmm: pinctrl@f000000 {
+		tlmm: pinctrl@f100000 {
 			compatible = "qcom,sm8550-tlmm";
 			reg = <0 0x0f100000 0 0x300000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

