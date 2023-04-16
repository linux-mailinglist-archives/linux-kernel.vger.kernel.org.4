Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86BF6E3818
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjDPMh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjDPMhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:37:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4FE269E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:37:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-504e232fe47so4161663a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681648671; x=1684240671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqbmQdhJxWShIT6akuz9LXzlxn5HqqoJaw3hlWbg/iY=;
        b=EFvyuzKxl0kHq2XbFzDmattULuYHz0mBq9eLyxIEG7S6iI6q1xok67hX9AYRHnrPPm
         xCZDMscwtHDRK1zmfkumGn5w3h86oQYBKn4ylJm6YwsRhxhtL4tP5D0CFgfxx/GYP0rh
         MGkdJ0oZo62M//ahiHTy7bMhqg+uainGSoMf1qrMGjNU6biMg7c20P6Mt/9vX8YWFR4s
         K2Rh4bczwZSFfaRSSppzGtNQn2ON+dobxaZAC5ST1pLsN+ivyXB8mjy15Qek/D7eYpDw
         KREvIausXWyY9FeTHpmQOQTz8K0hHMZiD+wAdpb79rjVvsLYxzM2h15eGjmfbF4/kCk7
         Uitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681648671; x=1684240671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqbmQdhJxWShIT6akuz9LXzlxn5HqqoJaw3hlWbg/iY=;
        b=RFyUbcnGscPDd31fSO4XdBpXOUqmPzLqVFE3+gU0onqwgTQrbRD50J2SesQAv74rJq
         9LI9cPbaq3BHhYpDtaFYc+1jkwH0fD60aTgvfmw7fyjNnqbxLvG/8veU3hfepjnKustV
         FZPbpIHJlVb7n7qCZ/wnshim6ZUmQ/5R/FJsmQRmvhAAl/U+dCUNA4nCy0nd4ZstmsDP
         gZYIstbDsKbG4+pdxzpYAQrp+w0Gc0nPU4an9/roJxrV62PjgeLj2vgFZwTv7dmVcswR
         ZSzFTsDUvcT3i5sbdcIzaka5EqmgL70PYHSle2m98XgDfvgY31zNVTOZiVh2oZngMin/
         12iA==
X-Gm-Message-State: AAQBX9fnsudlsaC3M9zidF2I1ajEpE9nE479Vp89LCRB+OStz1MrXdEa
        fqVTYQP0kehkfiS6pZPMj5mp2JuWV5mTm3nKhhs=
X-Google-Smtp-Source: AKy350Y33ooqVfTSbbB9wXNyBjLH9Nmm/rMWbJQ/NzT0SlG+fLHp3mC/NX2N6vdmEK8Y46BFdXUkSw==
X-Received: by 2002:a05:6402:1489:b0:506:8dba:bd71 with SMTP id e9-20020a056402148900b005068dbabd71mr5051894edv.27.1681648671363;
        Sun, 16 Apr 2023 05:37:51 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id j23-20020aa7de97000000b0050432d2b443sm4556889edv.48.2023.04.16.05.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 05:37:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/6] arm64: dts: qcom: ipq8074: drop incorrect SPI bus spi-max-frequency
Date:   Sun, 16 Apr 2023 14:37:26 +0200
Message-Id: <20230416123730.300863-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230416123730.300863-1-krzysztof.kozlowski@linaro.org>
References: <20230416123730.300863-1-krzysztof.kozlowski@linaro.org>
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

The spi-max-frequency property belongs to SPI devices, not SPI
controller:

  ipq8074-hk01.dtb: spi@78b5000: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 5b2c1986c8f4..3b801c4d7eb3 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -476,7 +476,6 @@ blsp1_spi1: spi@78b5000 {
 			#size-cells = <0>;
 			reg = <0x078b5000 0x600>;
 			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-			spi-max-frequency = <50000000>;
 			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
 				<&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-- 
2.34.1

