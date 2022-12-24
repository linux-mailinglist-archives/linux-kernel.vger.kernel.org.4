Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369E9655A9D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 16:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiLXPnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 10:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiLXPnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 10:43:02 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924C2DE92
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 07:43:01 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m6so315805lfj.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 07:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOCggw4ncCQi+YwGEIS+Y5vGGx98ysw/b2+7NHeaShk=;
        b=yMa/mVMjKloemdRoSWbez6cga/Xe+DZJsyGi+NSA1H6Potig+VEIR8+TZrVAR1YM7O
         7xDq28OPo5s0a+lYk/nOFKp2Kalw5gNXPVi3D4m6Aqe9UgUOfdzSEKv3jLp7Xzj5PeTG
         Gq5D3ZRUok8djt7cOqHmdA9FPB6jLmfQ5CJXCHOuYEclaxSxdAkE5LSj2IVmj0uD9EW0
         R4sAUZoCwgyFZvP52kpYiSyuqzRCp12bcqCg9c603+24qDbsTWmCl3DTC8AzauRHaCwt
         IrHcmJx9nKEoXTMmRI5RG9uob1NGQ+H+XJVkgocRnkmyYK3y4cjL0Hs0XnjC0SXo/go4
         P2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOCggw4ncCQi+YwGEIS+Y5vGGx98ysw/b2+7NHeaShk=;
        b=V5i/3QJxzDk5LO3i8QZTQAhBTPF7ytbYV7caZFC14/QMMy5iOscE2MiUOUuVFgK51a
         sRUxc899Hh8iXJe1Om+2ZUvJC8n4iRLg4akXoshej7Q+DDYwkgaZS1WYlxcZ6GMfhcAN
         AFHq6AixgIk6aZ1UK9HMkawPRGzq/L08f6UnNgGTNFTwjg2P5dThzVMNWSOaDl/i6lTu
         HIBXFUaWgQgUYc7ZvLNiPfP2MGF5dFZ65r8P+hRWrOzKM4tWsVfT1otc1qgL9W7NLKtt
         9Qf7nMCCHfYAXOMZcV6J4Zs1VtlI6KsY2dEwO6P1CemO0ZEI9BS+f+pFbfRgHEW2pQKr
         9Cfg==
X-Gm-Message-State: AFqh2ko9LxfeZqDBz3jvNO8pWJb0NWwzpIIcaEboyoq6y08c3WmnEJAH
        qh07jBR9JtAkDBYGgvn4XAYxKw==
X-Google-Smtp-Source: AMrXdXugTOcyW4BJu/k/T1Rb/KedlhOhgKKbB4plE/iSnADYGcR7Z+MqrZBVyO1hbQfa17OkzMr60w==
X-Received: by 2002:ac2:4ac3:0:b0:4b5:7e4c:dcea with SMTP id m3-20020ac24ac3000000b004b57e4cdceamr4295936lfp.51.1671896579987;
        Sat, 24 Dec 2022 07:42:59 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f14-20020ac251ae000000b004b257fef958sm999927lfk.94.2022.12.24.07.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 07:42:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/5] arm64: dts: qcom: sm8250: drop unused clock-frequency from va-macro
Date:   Sat, 24 Dec 2022 16:42:53 +0100
Message-Id: <20221224154255.43499-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221224154255.43499-1-krzysztof.kozlowski@linaro.org>
References: <20221224154255.43499-1-krzysztof.kozlowski@linaro.org>
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

Neither qcom,sm8250-lpass-va-macro bindings nor the driver use
"clock-frequency" property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index b5c51203672e..b5920d8a89af 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2263,7 +2263,6 @@ vamacro: codec@3370000 {
 			clock-names = "mclk", "macro", "dcodec";
 
 			#clock-cells = <0>;
-			clock-frequency = <9600000>;
 			clock-output-names = "fsgen";
 			#sound-dai-cells = <1>;
 		};
-- 
2.34.1

