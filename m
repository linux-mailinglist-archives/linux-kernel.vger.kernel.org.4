Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3616E381C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjDPMh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjDPMhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:37:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72192684
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:37:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94a342f15e4so434833366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681648670; x=1684240670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbhJD9kC/BcS5f31BmZ7z4fLnTBoltMR968i2T4jNzQ=;
        b=eg/lfEIorHyeK6BM4EJNj4VvE7mWrQNmhq3XURwMzSZ7FuQgE0ZHaLzNO8fmcsL3+d
         LIzyP2W6RHtAL1n5qCYIhIE+DXawh7JyYko8vbPBgEy8CK3ZI+9NIrzdlLQtHPMwNm5X
         TTAQINuWpV15WbzcfiBIon6JvbH/CfwAl6WI3K5T58LECOqFz1v4TOfbW3YqzfC7zkU+
         g93ySv64ok4xK9qmw/8NTvJ9zjeHk+mRFMXAgXOltD2+xgAzKHntjpSO9GoApJOQdKPr
         hb4Bqn0St9OOZ9UQFyLGFA9vh2/Ne1aUmpYn7iYtMFpFgU9nnsAfC2Fjs+w7BvJpPpDL
         4S7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681648670; x=1684240670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbhJD9kC/BcS5f31BmZ7z4fLnTBoltMR968i2T4jNzQ=;
        b=BcBauKifFOmyPWr0D3BNRI8KUa1U1QjxMYthCgxngcjbRpr8c8O2dOA/xIdrUJZgrV
         5ZLMKjcWvZVG5KZEJHmD4oIFzRaISIzvIs0jDJc/HoYC0yZ4UzbgLdUAMElMLWW9seLL
         JpAxeYHAxevnib5vbf3Cb6fvL9P3umRG2e88riFlMqolh/BHi8o0NAsf4P3dDJ2J/vKH
         x3bFplBQdj7n0hr5bKEM3YoxWH/8G8Tka7+bMUFAlTIqY43QdVeILc6fY7CV0c9E6RO5
         gXgNdUrZwVRb76CdVm0p9gcBg9wyFz1wHGm2LpbUwJ6kgeww+o5AAA89qoCq4PUYVyGU
         72Qw==
X-Gm-Message-State: AAQBX9fkeEN4z3rJrp3WCtZPubnqf5AYQFDXM7o5LaNrel2OoY7m3jRN
        cPzVkbKlRC2haNrvczWfWo+ZBA==
X-Google-Smtp-Source: AKy350ZqMZY6Wq2Fo0UB4LTewsbC4CPDnHKMOoKFsN85Nja6lrREKvEjTvECuVIZWNh9hZNROQOPPA==
X-Received: by 2002:aa7:d98b:0:b0:505:4391:398 with SMTP id u11-20020aa7d98b000000b0050543910398mr9473352eds.33.1681648670383;
        Sun, 16 Apr 2023 05:37:50 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id j23-20020aa7de97000000b0050432d2b443sm4556889edv.48.2023.04.16.05.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 05:37:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/6] arm64: dts: qcom: ipq6018: drop incorrect SPI bus spi-max-frequency
Date:   Sun, 16 Apr 2023 14:37:25 +0200
Message-Id: <20230416123730.300863-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The spi-max-frequency property belongs to SPI devices, not SPI
controller:

  ipq6018-cp01-c1.dtb: spi@78b5000: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index f531797f2619..54af7cb3c7a8 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -441,7 +441,6 @@ blsp1_spi1: spi@78b5000 {
 			#size-cells = <0>;
 			reg = <0x0 0x078b5000 0x0 0x600>;
 			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-			spi-max-frequency = <50000000>;
 			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
@@ -456,7 +455,6 @@ blsp1_spi2: spi@78b6000 {
 			#size-cells = <0>;
 			reg = <0x0 0x078b6000 0x0 0x600>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-			spi-max-frequency = <50000000>;
 			clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
-- 
2.34.1

