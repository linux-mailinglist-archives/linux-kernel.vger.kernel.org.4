Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7547380E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjFUJzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjFUJzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:55:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E930EEA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:55:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f86bc35f13so5317098e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687341343; x=1689933343;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cHDeuA0BCZm9Mf3LuBjPH47HJ3bTPiRckRvN89KzLZQ=;
        b=GqxXjRwWaKH4O2DIYiZYa4yeoO13DgadXj5p6HDOiVCwg5X/WCjbpkmykwSDzr37ER
         c9GfxdRyKM3RA5P5Fn+J96qsC2KtorE3uf9w13Fx0vAbM6RygQqqphRttyrnFRNaeP9q
         qr+H135irn5iTAR7DrkYSuZEf461cRwp8qPhOSbABIy/tC8Cvfz236NdJWKDR9bGKoGi
         d5AJoz222DyW5kzKBlN8NGu3ThEiN2pu3pUG3yubHDXMJ7Eye84Sdlb9jeoTBmsKO1mv
         T5NR3uTgrV3RgMDJMnlj/8q2U0iR9xtQP69R/GFEzxOt6lmJ5L/0IBeX1A7mYw3DWAVb
         vfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687341343; x=1689933343;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHDeuA0BCZm9Mf3LuBjPH47HJ3bTPiRckRvN89KzLZQ=;
        b=LchanJGdjHeCl9uewiUnfIrfbvWK9SP3F2E6+IJcjdDNnUuEa52LNOmlUy5recQhuu
         o3DVZKt+WnrPxUGaUIlN4pMX1NA+OG2Rt5RnNVu1DStJ85JX39AWaqW6SsMXKQYYL45T
         akogRVY/wT0J8APB+pRt6SOsyV8EM7RLwZTf7yKW34dDXRUfPJ4qVGhNzW84AqT/ZxzM
         PQBVFK7VQvt33juaNEOIoI97E+ADZDH6xyTU3gTwF3FHsvC0tQ9G3t55dX0+u1r1XIWg
         LAaSsqcuKrMiVGAzKDzJNSpxyjOdxSQhriKbLOYYHDhMWQyFXkX37eEqwR8qp3DrlLLl
         T8dA==
X-Gm-Message-State: AC+VfDyItHQTbRo13f/wBpXx741hM1mO7BhRtnuI6R89ckfzqLKclzaU
        YVL/NTmJtkhmdf7sQ48+aclfcA==
X-Google-Smtp-Source: ACHHUZ6ySlB8AFsYGsXPJVpD0AgAwtSuQaMhMapnyz6G8Bzm0NrHJE5ekHdsoPJNi/tg12hykfhv7A==
X-Received: by 2002:a05:6512:224d:b0:4f9:5d3b:6a3a with SMTP id i13-20020a056512224d00b004f95d3b6a3amr552225lfu.31.1687341343175;
        Wed, 21 Jun 2023 02:55:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x23-20020a05600c21d700b003f427687ba7sm4437478wmj.41.2023.06.21.02.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:55:42 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 21 Jun 2023 11:55:41 +0200
Subject: [PATCH] arm64: dts: qcom: sm8450: add missing power-domains
 property to usb qmpphy node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-topic-sm8450-upstream-usb-phy-missing-power-domains-v1-1-d850c086c43c@linaro.org>
X-B4-Tracking: v=1; b=H4sIABzJkmQC/x2OOQrDMBAAv2JUZ0GWj8T5SkihY20vWAdaKwfGf
 49IOVMMcwjGTMji3hwi44uYYqjQXhphVx0WBHKVhZKqk6NqYY+JLLC/9YOEknjPqD0UNpDWL3h
 iprBAim/M4KLXFBj6adKdG+1VDbOoZaMZwWQd7FrboWxblSnjTJ//yuN5nj9coSUbmgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=G6+Bov5hTBJLt1e/L02QrltMcTDY6r7pkw3usfxiqi0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkskd9J3VdkwZe0ldVUWqjgPTYH5wY2JZ/GYHBulI
 bLEyOe+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJLJHQAKCRB33NvayMhJ0ZhmEA
 CFfVZtcjJjWw5KkarOluj/ZgCKpyZTRfb389AmdzXKesFcLr0RgKLoqMWfutoeCTgGGyvS4V+IUkbU
 xTY5WuB65T3LLCZJmzMKCLl8DriVs5KTyBqUDYQ8dVTaEi6ZEwbp9Pi07NMCt9ZWgJVqUxIQlCZRYv
 SnXDy7UVHDmh4QiLmQ4b/wavM2cxoLHi++xNOlR2gl0Zso9SV0w+E4kyhW4NhtQOgLeTD7xFH8Kk6n
 UbEsgT0fA5XlTDOcQqH6ULKMr9xjPwj2Fo+0DgRE0FH7VDQ1KC/oY7Lax3UOTks+XRqDt38o0thQzc
 hKI8HedC/mzJ/FdqP4HoXPzPHczTtORUYnIq1zd7nw/oeHp2savvtoysjRUGCiQvpLyNsLUqe0H8d6
 IDoWSd5DooQop+0eHO8/qT1UGCRL5j08laQ/xLCIlAHLaQQDWYwbAo2c2Lf7NgrB7TifluPOorxwEN
 X6e/heObZ5XSLqr6h440/Lm2Nh3Zth7bl1VeoAH6rkbfu43U4NsYqJgN7AZE8ShR3uDoMUi2ClDUSA
 o90yjK1DWTxflbWGDUcmfsj0znC2yR+6AXZxaMbH7lipgiqydFwbYhZRhf5TnB5leDD43Lqa/pSqFl
 eJrWXy+pyk3yjS5fzeFx6uJ2Wq8ZESGGZp9oHf6MGxn30ofUgqXZcFfywxsg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing property to fix the bindings check error:
arch/arm64/boot/dts/qcom/sm8450-hdk.dtb: phy@88e8000: 'power-domains' is a required property
    From schema: Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 5cd7296c7660..f921bd520e40 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2046,6 +2046,8 @@ usb_1_qmpphy: phy@88e8000 {
 				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
 			clock-names = "aux", "ref", "com_aux", "usb3_pipe";
 
+			power-domains = <&gcc USB30_PRIM_GDSC>;
+
 			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
 				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
 			reset-names = "phy", "common";

---
base-commit: 15e71592dbae49a674429c618a10401d7f992ac3
change-id: 20230621-topic-sm8450-upstream-usb-phy-missing-power-domains-499a3d6c725f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

