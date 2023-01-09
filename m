Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3895C662422
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbjAILW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjAILWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:22:31 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70796186AC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:22:30 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso8719690wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 03:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8647YO7ObrUrMh2L0X6Xd1xc2rhUuMe5mPThBJ2xt0I=;
        b=hlBCIi8Ba0FPeOLf6PGOyAAo9D14clCAVWrtHQK2dpq7F5YT33odDR9+6BLd3Tdou6
         ZMQC/W/n8ryVZoC1WYh/5agpumaoExktE3hA7CkkkxEjuZ78SNHBUv5sLgg6PnnOPcqH
         XvP0iWRafAr1BPQwyxlAaclQjhxIlYXLzJHUKEdzbeLerwvKvA5ljrKOfEW4TksHfpjt
         7uJiUhUCM7oSvcl0TCM/IGKWqHfllkbLM1/PQfexjcDZhIkptzaBaJmftVxsiz7Y5zmy
         aqivLgB4JDirE2cc4pe9lLHrFRxMYDDjOvcB/12iaHsI54ncsXIyEU/iEE5yeHMm8M7b
         SMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8647YO7ObrUrMh2L0X6Xd1xc2rhUuMe5mPThBJ2xt0I=;
        b=ybW4v1JUu6/FNkBNrkD7pXlDZT470Td3bfOjLXcQhNRtNWCmTMJPAl5DA1+Jk19RvP
         QPmdAXCMn5ffEQXtefdGpA8vEHsE217iWz27OzsjAvnZyahi8T8SiVc0BFGDppf8FQui
         INICk1cRJcuzj/akfuIeYgLzxUApvntsr8b95XnWp3s3dRc4QaRpSNM5spKXslSXvTB2
         t3YP6dGRjOXxdRtijji9EtSvFgqUN6T0igzj5V/I7ffsCp+emW1xKeC5yUqPB3vsBXnA
         DshVoPlzxdhmQATCzyPnrkgiZU0p10IrWOAp1vWL/Sq9osTtwOezdHg1QFujdiatXkz7
         B2xg==
X-Gm-Message-State: AFqh2kqiueBX6iXxfqbGdflwZv3OG8oxWU4i+mkIZgxWGIg1RH8URmaf
        YQ186iROnqD3htu2fpwqCLI6rA==
X-Google-Smtp-Source: AMrXdXt/qqNlOIEct1cN5WW+VPE4UP0cPJDvA1moMHSZmCDa/Jc85GTqxK2Pe+3Wqk5+COrSV2nBzQ==
X-Received: by 2002:a05:600c:3d86:b0:3cf:9ac8:c537 with SMTP id bi6-20020a05600c3d8600b003cf9ac8c537mr47307546wmb.14.1673263349005;
        Mon, 09 Jan 2023 03:22:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c3b8e00b003b49bd61b19sm17456986wms.15.2023.01.09.03.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:22:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/4] arm64: dts: qcom: sm8250: drop unused clock-frequency from wsa-macro
Date:   Mon,  9 Jan 2023 12:22:20 +0100
Message-Id: <20230109112221.102473-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109112221.102473-1-krzysztof.kozlowski@linaro.org>
References: <20230109112221.102473-1-krzysztof.kozlowski@linaro.org>
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

Neither qcom,sm8250-lpass-wsa-macro bindings nor the driver use
"clock-frequency" property.

  sm8250-hdk.dtb: codec@3240000: Unevaluated properties are not allowed ('clock-frequency' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Add tags.
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 434e2c4cce79..a58f51083715 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2215,7 +2215,6 @@ wsamacro: codec@3240000 {
 			clock-names = "mclk", "npl", "macro", "dcodec", "va", "fsgen";
 
 			#clock-cells = <0>;
-			clock-frequency = <9600000>;
 			clock-output-names = "mclk";
 			#sound-dai-cells = <1>;
 
-- 
2.34.1

