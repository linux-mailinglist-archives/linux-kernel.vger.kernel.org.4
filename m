Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B806B071D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCHMbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCHMbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:31:35 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F8BBF381
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:31:33 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id j11so45530551edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678278691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QPuBOY3KpDNSmY+QpQEaalWB+vfw9Nm3uyiJNt0uQhk=;
        b=FYWj7zks4LdjrffCkcTVs2C3JbUxBhvmWJNQi56yJYUbVI/R7vke4upWvXGJ329O9j
         ACpbjnVHVXGOZZ1X1vIjmLVXhnJAr5UgCTW904vn8tpz3yz86Q9fWOqa+tTBJmwts34q
         HGUxkF7LWxsIozrxRGVvsUnDh5oUFMpxr0PMTAlaPTaOVI9JM/r13AU4f+4Zp+9p+pI/
         jMPdr8hIWKsdYr5byW3qXaK2HZKFsGD3//XhUtNJwudPj68s86T7u2LBhH8RZ4JIcFvV
         X++7U+U72MI0p/esejtftCVmlMl/WSXrdFZoaB4zxNvCC0/wIdc86zqQVCN7xJoMAI+1
         JbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678278691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPuBOY3KpDNSmY+QpQEaalWB+vfw9Nm3uyiJNt0uQhk=;
        b=C3yrzUILc111uzKxwR7KfgUbgSUxdLNj/2tpJTZwk9gl5oRrizxFY+P4sJby1vt7Gn
         vh+jBF2qrDbV7Mq9ctwYDYBkE769glH+28eAQdB2wTnV/t3ouz2/oG0nJgzZ/4nK5sEX
         6rB6bvvOnnzRHrJLJXwKCkXYMKoqbfGxD6ju40Tv7H31MAbtP/+/TeEyBsZnyQ3yx76V
         vx1nn8Jg4ZH+TXxzc1taCdIZD3VxQcTK4BEB5lKhaaH1FVnK+wIuT7bfG61EUO9AU51Y
         NPCucKAw5s6doeFHmGPjxTtaWO9hzyX2kvkqepgbEp4wEpjwT3Q9eWGVGyVuCH4uuKX+
         btwQ==
X-Gm-Message-State: AO0yUKVRYhMGk3sBeMKggyygNBILBoWvSLcwVA/gi7gmgXusTkyxMDXM
        KBhnKRWOAiP4Kp8EhH6IFwH+WQ==
X-Google-Smtp-Source: AK7set+U9Cx3ePVKsToO//f1PXc8sDfP5c23Y5WYFV2nOT14n+uE0yYjXmCi6DPiNNi+CGxP40fnIQ==
X-Received: by 2002:a17:906:2887:b0:8b1:2eef:154c with SMTP id o7-20020a170906288700b008b12eef154cmr21878100ejd.0.1678278691527;
        Wed, 08 Mar 2023 04:31:31 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id uo17-20020a170907cc1100b008b17ed98d05sm7391612ejc.120.2023.03.08.04.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 04:31:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sm8450: correct WSA2 assigned clocks
Date:   Wed,  8 Mar 2023 13:31:29 +0100
Message-Id: <20230308123129.232642-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WSA2 assigned-clocks were copied from WSA, but the WSA2 uses its
own.

Fixes: 14341e76dbc7 ("arm64: dts: qcom: sm8450: add Soundwire and LPASS")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 42833188a257..a315c0a61c5f 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2142,8 +2142,8 @@ wsa2macro: codec@31e0000 {
 				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&vamacro>;
 			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
-			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-					  <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA2_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+					  <&q6prmcc LPASS_CLK_ID_WSA2_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
 			assigned-clock-rates = <19200000>, <19200000>;
 
 			#clock-cells = <0>;
-- 
2.34.1

