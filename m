Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21623621643
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbiKHOZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbiKHOZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:25:26 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1EE7054F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 06:24:04 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id d6so21451544lfs.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 06:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnA9bYpkTooTYFD8QmC/+zf1bx2KSFMylSXBFYcLmDE=;
        b=w+jxQcrXMmL3YJK2Yqlz9qJJAFSmW9RV0w4RDT8uZYaWLnavtdA9o9cOAPvlAz3Nzm
         ROxchebgsEtjz33rq0UOvaZYn10Q8fRNW79DAWcpzLxvTUUdyM8RBB38SjnOwU0XEvnn
         4ez2AXTkfjZ2vnqovvqVfhPEwo8ePxqlV1+uPkURDejBDWjm9oqRZ+TMOASEm21GChGg
         EsJiOX9BvEb2CXqKbHpnV+PyNbhk2vhJG0f5ji3er96WIi5x7bhKxeLhd8Q71HvCRLTF
         tUZD7iJv1GIK5jXoKjXoMcK/aFdMZI3cGp4CLw57hOQ35WvKAJ3MoZlOo31jKOgwyWXO
         hsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnA9bYpkTooTYFD8QmC/+zf1bx2KSFMylSXBFYcLmDE=;
        b=E8OyPXueTVHeX4OkxGz/GN8B2ZwNqQpp2wVxb7Z6Klxg0uO6v+DltdzpbcPXNK7O8A
         /FTSK9BwklhjZPLGFNUAdK63KGT0B0PQ2+g9M/HK9WJ1NH09XvCMcP2maB3ZHuY5JDoN
         czxBjGpHDTXr7EoZbN+mi11fyH+qbKVyrfabgqbmSDQyx5js9zVRYiRw3RXjZHrrpGF9
         gXBCYBhHQg/y8fknLloUIGJKCQw0l0n9Fhr9XJahI0FpYV0ewzeljWssqPFVP0y4d/KP
         ftstaO5q77tBSCPBtWdoLCvG1sPpF8XK6WRitYPUoUV5UwCHp9wCmu8K7RcLb+J+G5Vr
         q68g==
X-Gm-Message-State: ACrzQf1LFayxULbAnYZ6pWHvZmLc+6elHCfFdgjn42oqx2fJ3/YNIYea
        dynQrU1HGxHRjyIyaAlBt0lBSQ==
X-Google-Smtp-Source: AMsMyM6GqXVfTcMkI6O8ZqfO3omLsoJJHDwa+uiCfDjpOJFpULP4ho/TRINlM+RIDv9MIuruVlxMGw==
X-Received: by 2002:ac2:447c:0:b0:4a2:4fc6:4cbb with SMTP id y28-20020ac2447c000000b004a24fc64cbbmr18747443lfl.99.1667917442449;
        Tue, 08 Nov 2022 06:24:02 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id k7-20020ac24f07000000b004a65780e4cfsm1815117lfr.106.2022.11.08.06.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:24:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq8074: align TLMM pin configuration with DT schema
Date:   Tue,  8 Nov 2022 15:23:57 +0100
Message-Id: <20221108142357.67202-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221108142357.67202-1-krzysztof.kozlowski@linaro.org>
References: <20221108142357.67202-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects TLMM pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index d3d9e7eb5837..363ccc272cf1 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -317,35 +317,35 @@ tlmm: pinctrl@1000000 {
 			interrupt-controller;
 			#interrupt-cells = <0x2>;
 
-			serial_4_pins: serial4-pinmux {
+			serial_4_pins: serial4-state {
 				pins = "gpio23", "gpio24";
 				function = "blsp4_uart1";
 				drive-strength = <8>;
 				bias-disable;
 			};
 
-			i2c_0_pins: i2c-0-pinmux {
+			i2c_0_pins: i2c-0-state {
 				pins = "gpio42", "gpio43";
 				function = "blsp1_i2c";
 				drive-strength = <8>;
 				bias-disable;
 			};
 
-			spi_0_pins: spi-0-pins {
+			spi_0_pins: spi-0-state {
 				pins = "gpio38", "gpio39", "gpio40", "gpio41";
 				function = "blsp0_spi";
 				drive-strength = <8>;
 				bias-disable;
 			};
 
-			hsuart_pins: hsuart-pins {
+			hsuart_pins: hsuart-state {
 				pins = "gpio46", "gpio47", "gpio48", "gpio49";
 				function = "blsp2_uart";
 				drive-strength = <8>;
 				bias-disable;
 			};
 
-			qpic_pins: qpic-pins {
+			qpic_pins: qpic-state {
 				pins = "gpio1", "gpio3", "gpio4",
 				       "gpio5", "gpio6", "gpio7",
 				       "gpio8", "gpio10", "gpio11",
-- 
2.34.1

