Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730A36E8359
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjDSVTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDSVTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:19:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3EA618D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dx24so1557365ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681939145; x=1684531145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ot+kluXa878vBfmqUMyXkIy7tIL8gH1qDXYW4gOUqxo=;
        b=qxhJ+nvw+TmAb1tl47pR8sZBgHVlXXr/Mwfnu7wMwVBGjUQgqQOufdXrTdGTlRxNe1
         Vq8iuASBCTDdqhj3wY/qavvvRfGVKvHwBI6s5Yz0xLSF5QWZ8gdRO7E8daJxi9R3r9ZL
         KBwFpew3Z2CkIiP78jM672zVtX/xTNHtnCheLC1EVcFGyoL3IlsfkzRNuhqsItWg15/S
         6rVPgbdAwYTY7PvFDMnW1diXg413lFi3dV6yG1eKQNcHn40bMw8hOdYG/agME0zxlwDj
         lgf3fDNZXttAih3QudyuVRu8T6ULhBsVoUDlE0U1pzxRsjtxaszzkTCThx63KSz5B3UM
         Tsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939145; x=1684531145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ot+kluXa878vBfmqUMyXkIy7tIL8gH1qDXYW4gOUqxo=;
        b=C4U/Wfggp6YY5BCmZmGjl3oFsWK7Xb8cg8SCZq5mHzjJotSGDyWRCO8tDWf2IaTPrK
         k30P5Alp7ohbVP43lI5QDlLp/czWl4AQ4Zun3hDE32faygV3Zh0Q6w9yokyomCg6wjxz
         ut0Uun5QuuFzPvlXKgtP55gvNxCPGpfY4NJM+wFFCXvxY+teQqelps3W2yZfvucGJax4
         Vzg1e+KS+lRxgTQx54wi8cD11/9rThdq1LK+H2iXBeEJj5iEh9tb0aOEn2mHl/06P0hS
         bvPQWplIpZMkcxbSObs2xqW1SeTNhOHeFMYbuYT0Rfofjo4yKtp3gMpvK9LUo8GklMQe
         9JBA==
X-Gm-Message-State: AAQBX9eYtb+RHx1fEHxgCz6qiZ06iP3wpfDfIKDLZ0H1/aIUIxn1jn4Y
        aYLVDE1S4ILXpDB9RWU2uFsOAQ==
X-Google-Smtp-Source: AKy350bZrcsrDqDIZHiQL1KMP4/cuI6uo2tYMN1WXeraKKZzG9xgeGdHv4tIwq1OKK9tfDXDTGVA5Q==
X-Received: by 2002:a17:906:1c49:b0:94e:bcb6:5f31 with SMTP id l9-20020a1709061c4900b0094ebcb65f31mr3575135ejg.20.1681939145081;
        Wed, 19 Apr 2023 14:19:05 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090682cc00b0094f109a5b3asm7092739ejy.135.2023.04.19.14.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:19:04 -0700 (PDT)
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
Subject: [PATCH 04/18] arm64: dts: qcom: msm8916: correct WCNSS unit address
Date:   Wed, 19 Apr 2023 23:18:42 +0200
Message-Id: <20230419211856.79332-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
References: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match unit-address to reg entry to fix dtbs W=1 warnings:

  Warning (simple_bus_reg): /soc@0/remoteproc@a21b000: simple-bus unit address format error, expected "a204000"

Fixes: 88106096cbf8 ("ARM: dts: msm8916: Add and enable wcnss node")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index f6ccce0dad4e..bf88c10ff55b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1871,7 +1871,7 @@ usb_hs_phy: phy {
 			};
 		};
 
-		wcnss: remoteproc@a21b000 {
+		wcnss: remoteproc@a204000 {
 			compatible = "qcom,pronto-v2-pil", "qcom,pronto";
 			reg = <0x0a204000 0x2000>, <0x0a202000 0x1000>, <0x0a21b000 0x3000>;
 			reg-names = "ccu", "dxe", "pmu";
-- 
2.34.1

