Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE4B69FD75
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjBVVFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjBVVF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:05:27 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86C746098;
        Wed, 22 Feb 2023 13:04:55 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i34so10460797eda.7;
        Wed, 22 Feb 2023 13:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4sT1wUlCbHRDpbMzMMTT4BWgWGszScqpQQPPR7Avx8=;
        b=fV1pXve6qVGgUZzvzS3Cvik+RMpTsqvE0467NRn8Yb6V7KweUNBEWo4/q30yGcFc9w
         D+rYJdf2EukzBDNH1v7G086P4Dv9oonD3XT2xLE1mdfg9C347zfJ0wMXCy5hhBVc14pH
         SBV+mro6+fG+QnaFP472RGso/v2hRpfnF2P7WuV8kfWU8Mqe0zirTpHBCeHrXRTAHwWJ
         RQO/Z478Q5BdO51H3sh6xqDR5tX03sOJMgzlLDVjzSY+1gQ3jogJjmrdqQLm9kBjMb+q
         SFu0bUnQ2TzX+kKa6RHt1qzdrPhfdrIk/LHxw6OAiSEcMmw0Xg9bjFXjEbqvTChMmY4Y
         utgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4sT1wUlCbHRDpbMzMMTT4BWgWGszScqpQQPPR7Avx8=;
        b=fv5Uf75FMukdHEBbzAiMOhtkcrxr/kmifSpZTek3eFnC8gBEsBTPOvlddgDoZwdTKj
         gn5jK15xyWKx4eYLlYKiDnQZj0TSHJB5FUfBEeJLomJk0sgUlLYSdklX4VX+bzur25XM
         4Yt482iZ/ZPxdjkvN/VqSsZ+QmQtExdshsVCMlvMugAs25Upe2/7s0jLNZXmz+WsGNBp
         XHLeiC99s3s5/Gvda7g/NpTqfVH8XrjGA4OiXgXtq79wbXGFHJdGyiu8SFQ4G0DsnYwZ
         ZsrCNAnoyGDU9/KtgehQGVkgepEDdS1mQ+JXdzh8aH2yS3+kIE+Z49OErbMeFQR/emyO
         Illw==
X-Gm-Message-State: AO0yUKUhbmAQDV1f6WWmLyzkEVL9gQS4y9TU0fICvAoDZ0XwiL+9vOgg
        zI5Ca2mZ5ZAxxk/S0J3DRZc=
X-Google-Smtp-Source: AK7set9UsywGgwcaKfpjQbvcN4DriltaAx6XT6S28Ki/RySsfHBlPZPWUAWYQaHmEPazeYrWLX5orw==
X-Received: by 2002:aa7:db44:0:b0:4ac:b309:3d76 with SMTP id n4-20020aa7db44000000b004acb3093d76mr9530208edt.31.1677099882731;
        Wed, 22 Feb 2023 13:04:42 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-76c9-eb00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:76c9:eb00::e63])
        by smtp.googlemail.com with ESMTPSA id m17-20020a50c191000000b004af6a840f21sm209208edf.15.2023.02.22.13.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 13:04:42 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 RFC 3/3] arm64: dts: meson-g12-common: Use the G12A UART compatible string
Date:   Wed, 22 Feb 2023 22:04:25 +0100
Message-Id: <20230222210425.626474-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222210425.626474-1-martin.blumenstingl@googlemail.com>
References: <20230222210425.626474-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch meson-12-common.dtsi to use the Meson G12A specific UART
compatible string. This enables the "divide XTAL by 2" divider which
improves support for UART attached Bluetooth modules (for example
RTL8822CS) running at a baud rate of 1500000. Without dividing XTAL
(24MHz) by 2 a baud rate of 1500000 cannot be generated cleanly and the
resulting jitter breaks communication with the module.

Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 123a56f7f818..3dc06848f3c4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2046,7 +2046,7 @@ pwm_AO_cd: pwm@2000 {
 			};
 
 			uart_AO: serial@3000 {
-				compatible = "amlogic,meson-gx-uart",
+				compatible = "amlogic,meson-g12a-uart",
 					     "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
 				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
@@ -2056,7 +2056,7 @@ uart_AO: serial@3000 {
 			};
 
 			uart_AO_B: serial@4000 {
-				compatible = "amlogic,meson-gx-uart",
+				compatible = "amlogic,meson-g12a-uart",
 					     "amlogic,meson-ao-uart";
 				reg = <0x0 0x4000 0x0 0x18>;
 				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
@@ -2293,7 +2293,7 @@ clk_msr: clock-measure@18000 {
 			};
 
 			uart_C: serial@22000 {
-				compatible = "amlogic,meson-gx-uart";
+				compatible = "amlogic,meson-g12a-uart";
 				reg = <0x0 0x22000 0x0 0x18>;
 				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
@@ -2302,7 +2302,7 @@ uart_C: serial@22000 {
 			};
 
 			uart_B: serial@23000 {
-				compatible = "amlogic,meson-gx-uart";
+				compatible = "amlogic,meson-g12a-uart";
 				reg = <0x0 0x23000 0x0 0x18>;
 				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
@@ -2311,7 +2311,7 @@ uart_B: serial@23000 {
 			};
 
 			uart_A: serial@24000 {
-				compatible = "amlogic,meson-gx-uart";
+				compatible = "amlogic,meson-g12a-uart";
 				reg = <0x0 0x24000 0x0 0x18>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
-- 
2.39.2

