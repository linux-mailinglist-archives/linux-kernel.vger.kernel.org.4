Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C13655D06
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 12:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiLYL7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 06:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiLYL6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 06:58:52 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A62A2BC5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:58:51 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m6so2482855lfj.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNdtkpZEOdXfGy9MVfRgRPj0usqVhiDHi+woWZD1xjo=;
        b=m/iai6Vlbz0GJG5ZHbVyp1ybwn46NRWNLDSc797akIT3T/41+w19KNVkoFhKpwdOqM
         +WNycOcfo5oSla8yrZPsMqIF0QxISzrHNyBTgSsHTigaQ/5sqOrXflKzrjDaspQwL6tH
         9haa9TVw4sYHQeRyzC4j266VEQuoPRZAdVv1XkCJ5BOym1nL7NG7i1NqHvAdu828ho7e
         0DubTFOOVloVaxnAWuAyvy9iI/NyCogGGpmcSuSnM3ZwpqnbRM1rjSztm8rDmIUBhnNL
         +hiG32Yw7zJSsAy2KtaJvQUtfpGT5szkrISIAUu9KwHv9vVNyllG2pvjYQCmxFA/gEcD
         qGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNdtkpZEOdXfGy9MVfRgRPj0usqVhiDHi+woWZD1xjo=;
        b=V+s/drF7iVW3DxjGlimyDOWlenRTe2/RKEim0eeJkeIT0ydU3KfJni89G1VkAIFwL4
         L5XF09+btzEKv6sZ+IuQVdi0C8wKhevm4Xsr2yIT+fp1dJOBXuNOMAVzygZTghA840k5
         fAvOFnZyDt+yH1fkjxUN2rd7O9ru3ZyEhbFmcm4bKCeaGmz2emeeESI4y+FyC5OqfCjV
         osJe+ZFe3wU3RQhSu0cKCWAr+j7jmTcJCXSwOV7sMlXwqe514wsxFtI2q6i2qWJWXQoE
         jbILCmLSdzSY49h7wdtoVz1LcjltLsr5VfwXH0s7It5Zhg7gI+rurIX95ASj9TbKqaYy
         plpQ==
X-Gm-Message-State: AFqh2koer5FCUwA00pLrBfsDetHXagviViacsaqNRuFJym6oX24RtrxD
        2rspscxzn6RSf5EE27FIswzpCQ==
X-Google-Smtp-Source: AMrXdXtoJlGkmUulr0XOrAtaQZh6wOEnqmTJV9ZA/AGFnxp2Z/9/oCAmLMmfsWHWY2acc7kv3TYvTw==
X-Received: by 2002:a05:6512:1288:b0:4cb:63a:54e2 with SMTP id u8-20020a056512128800b004cb063a54e2mr238699lfs.41.1671969529640;
        Sun, 25 Dec 2022 03:58:49 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c1-20020ac25301000000b004b5901b8011sm1318141lfh.105.2022.12.25.03.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 03:58:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] arm64: dts: qcom: sm8250: drop unused clock-frequency from wsa-macro
Date:   Sun, 25 Dec 2022 12:58:43 +0100
Message-Id: <20221225115844.55126-3-krzysztof.kozlowski@linaro.org>
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

Neither qcom,sm8250-lpass-wsa-macro bindings nor the driver use
"clock-frequency" property.

  sm8250-hdk.dtb: codec@3240000: Unevaluated properties are not allowed ('clock-frequency' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

