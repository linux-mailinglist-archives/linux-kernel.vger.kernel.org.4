Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C81655D05
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 12:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiLYL7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 06:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiLYL6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 06:58:53 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEB32728
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:58:52 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p36so12840869lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7AC94VQgQoxhQZz7ucxTtLY+de0f9ECtnoEPYUnvao=;
        b=LeB4KI+DzfuH+OCQmBRFiP0IthvFrX11t34yBSgZSKj6SsY6KKvZYlotoJlWkmsPDb
         PlUSX90b5W5XFwqDQUcWcWkepZRy6DZVnFDPUw9PAZ3/z3x+x2ujIQ7wI2VtH3jMrcBa
         LO67rdkr97MrHTKINCwkGK1Zf+RMVq7cjd8Odn+ui1EqHBsijrg4S7mnF0P7ADP4Sb4C
         F8UxDbXTzSZH5WsIidwklfNTAx3dVHJEixxRCv/pua5hhkYyaU7N86MRTYv1V5xFQJ89
         aceV33cscmLVHmaQ8mTs3BqXVOFL2mE+wYM5XyNKMx39hlL1q09hSLYI3WMgUc8JwA98
         pMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7AC94VQgQoxhQZz7ucxTtLY+de0f9ECtnoEPYUnvao=;
        b=SOo7zJ5URWYM18TbfnYNL3AMMFA3xbvyBVHM3T6c92c8crLfIVz6kMSDbNPYFk59CP
         HXDCuSCGwJN44IZk+1wzTjWvvJBUbCZY+2AeQ8bn2dE5w1kBaE9UiQn4sC0nJuySWq9S
         BQS9M1uIp38lUGn8eZWde2pNo4DiYetPNk5gaaxEetyF5GFtpM0mV+x6Rb0+UQQtV6/X
         5UFLQq0U/aDFwhUi8Dv65GiptSld4dLwPXQBJubpPf/5uoPhL3TArWeeEXYx3puuEuFS
         g1b1UHqAE3San9lqNekKVk67KHsAj8QfU9EIFOq4p8Un5my3paX67CVvqvxvFeKKvJQz
         fFiw==
X-Gm-Message-State: AFqh2kreQrRnsxP4Z3e4xRdRkuWvLqWnZrK6O5IXB+tZXupAASAoZrhI
        BQw8yG/3MGQlfzRtCpFi9i5AOl7xqzUdgq6m
X-Google-Smtp-Source: AMrXdXtiuFUjd+pLdr9EJXHaqoUgrI8X4mE8u7Ett0S+pQz0zW4GUj+p2U+yiARdqbxibRzfADzwiA==
X-Received: by 2002:a05:6512:39cc:b0:4b5:580f:2497 with SMTP id k12-20020a05651239cc00b004b5580f2497mr4627027lfu.17.1671969530513;
        Sun, 25 Dec 2022 03:58:50 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c1-20020ac25301000000b004b5901b8011sm1318141lfh.105.2022.12.25.03.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 03:58:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] arm64: dts: qcom: sm8250: drop unused properties from tx-macro
Date:   Sun, 25 Dec 2022 12:58:44 +0100
Message-Id: <20221225115844.55126-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225115844.55126-1-krzysztof.kozlowski@linaro.org>
References: <20221225115844.55126-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither qcom,sm8250-lpass-tx-macro bindings nor the driver use
"clock-frequency" and address/size cells properties.

  sm8250-mtp.dtb: txmacro@3220000: Unevaluated properties are not allowed ('clock-frequency', '#address-cells', '#size-cells' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a58f51083715..ddd750591e8c 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2329,10 +2329,7 @@ txmacro: txmacro@3220000 {
 			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
 
 			#clock-cells = <0>;
-			clock-frequency = <9600000>;
 			clock-output-names = "mclk";
-			#address-cells = <2>;
-			#size-cells = <2>;
 			#sound-dai-cells = <1>;
 		};
 
-- 
2.34.1

