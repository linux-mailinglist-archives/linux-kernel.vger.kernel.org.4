Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA34688432
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjBBQUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjBBQTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:19:52 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248FA1ADD1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:19:50 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so1839625wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b99oypO4bJC2iYysDhsqz1eGOYtj457EQWA47nTPG14=;
        b=KDicPQ81bvPG1npzsATdBaXv5XaB6EwXkZRZW4pjogsJoyhTt4HpeX0tkYnIHOl8Pj
         yzGO6GFXG+FXPF4Upv6UEy7jLM+hZ6fW2wD5haMSYZQHhKgpC86faoUwz8zqFaDhxqmf
         OG/QcWq4x2cXgnO1Wvcof8TIVqiBOuTX3Q3PMxwrUkze0NBjmUyL22ZL69RWHRkyq7p7
         2lDSTcoLRzGpEnPhsPzjk2wOtNP0wKtX90R0wuR+GIWDIdQyFRBNQQ2ZYFSINF49zv3l
         ymnwcWNvseqAB1VRn4xiJj73m3mTeUzgYTSyqzXFq8vsin2104pyZARtQSAvJ/1BQAR6
         vxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b99oypO4bJC2iYysDhsqz1eGOYtj457EQWA47nTPG14=;
        b=iEtgDMNT1syqpZLWrIpSWNIcgRb3NfZ9TlQRD49mSvvWXMnZsJaTPUB2YZZc4eyHJ5
         wlkfcm9ex2uDAQkHFAl01WlL8oDRzrBBgOz5jfSZ3rVKR7e47fR5rGGZBkaQmkZJOvAW
         3aXIB7FKf8k3DRZY6ZH5IZWGnbAWv51lUSgi0JlarLj0iKjOV6wm47Uwlt6qVz1UTyHF
         7MEWMBFV2Y8tCo7WUwzTMI+FcOgjG+UF5lYd2td85HqBOueT8/+poXUtcUi1oLEPpHAG
         VvmNddNuAz4NAsNTrC68e5c9i3XX02sn/qjaDa6LlZRybpR/qZdH0AzA785/63Xmxp0T
         AyXA==
X-Gm-Message-State: AO0yUKUFxnse2tmXAYYwx375+elfxOnR5lAQ21Y4g8Hc+XTwwN+9cUHL
        rXb3pX/YnC7/pOQATHKEACteTQ==
X-Google-Smtp-Source: AK7set9dNgM/hfGhbWVV6OBm3MRQbVyJ6rk0whRN0HIe6Rh3fHL732ZN6m8m3mazt4H7pkPmgyZKuA==
X-Received: by 2002:a05:600c:3783:b0:3de:e8c5:d826 with SMTP id o3-20020a05600c378300b003dee8c5d826mr5942525wmr.28.1675354789773;
        Thu, 02 Feb 2023 08:19:49 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b003dc521f336esm212416wmq.14.2023.02.02.08.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:19:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 11/13] arm64: dts: qcom: qcs404: add compatible fallback to mailbox
Date:   Thu,  2 Feb 2023 17:18:54 +0100
Message-Id: <20230202161856.385825-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202161856.385825-1-krzysztof.kozlowski@linaro.org>
References: <20230202161856.385825-1-krzysztof.kozlowski@linaro.org>
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

QCS404 mailbox is compatible with MSM8916.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9c9890cf1b10..15fd12fcfdca 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1302,7 +1302,8 @@ intc: interrupt-controller@b000000 {
 		};
 
 		apcs_glb: mailbox@b011000 {
-			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
+			compatible = "qcom,qcs404-apcs-apps-global",
+				     "qcom,msm8916-apcs-kpss-global", "syscon";
 			reg = <0x0b011000 0x1000>;
 			#mbox-cells = <1>;
 			clocks = <&apcs_hfpll>, <&gcc GCC_GPLL0_AO_OUT_MAIN>;
-- 
2.34.1

