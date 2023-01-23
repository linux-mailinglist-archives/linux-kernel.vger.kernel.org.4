Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5867D677F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjAWPQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjAWPQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:16:00 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7353274B3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:38 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so10852502wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3p9y3kfoaT+NGOwMVeQCj/E0ECJi+vhh7oaaiKliAQ=;
        b=rTxk8Rt2p0NgbWOimn7oRVcUUFn9VnSZqKr6fVJkH74X6dgJmgmJ+02omrGL4Z70NK
         VgUorRHu1alEpq8dJR/IXx/FDeBQgV5f8SOBUAzaRcYrmpleCxpEJ0ogN2k02/EWPWMo
         7LicMyTp7twIbHUb2DjL22ZyGGQ1JkFq3wwVbqojvChaQHESPjDKLl0mUUPTIDJWPmmt
         kcWAlwq1Sjj8SgPKZd4n6QWTU4CxKLpRB+SXBKje9WNlSlEokJJdXnwHtOZjTJy8HY9K
         cVIhfyZpv4F8q5lwJfdldCeaLV+dJxE73Jngor/kYNJ2hH7M3XyqOF7KMbdmFWhztJEq
         KHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3p9y3kfoaT+NGOwMVeQCj/E0ECJi+vhh7oaaiKliAQ=;
        b=N4YJvDqm331qBrjIU4otIheVZIcEi2wc6gL3YQZrxPF4jIsFYljWoopmpbZjzFOufR
         qceU1rFUv2RlruLTbz4eFY+sdLthv75Ugk6Vd9SyEWe65w3e3P/tW6SdCd22lCvCDU9m
         JUdM0xRB0k7sYbCeOspSYOIfXqWoAdb8Ndgzd9wc1kkiJVvN5UXI+hKR4qkbJJFP6ADu
         oeW7sV7mISNPqkDGTmcmLUJswyZfw4Qr1f9U3OY6uDBbTv1r6/GUzzjkzo095Z+YrH3X
         qrLLHg+StuYdqNX4pXXpcUBeC3Zi/358/ydJzX2GZ/u7Q3nRf6nlsaDtU43nektBg4bm
         Ic/Q==
X-Gm-Message-State: AFqh2koQBrXS6nFhymRBX6VSeuQmeAJfzp8Te6V59LnZ96dk3xKrzG90
        7WXmUIoV2I//4Pk6Ty6LB+OBSg==
X-Google-Smtp-Source: AMrXdXuYehyuDfdlMjVIt8USmjMupUxAao0ESnym2eX8uNOTvXFL1k7PICq14iAkfZNgcWTexPAuEQ==
X-Received: by 2002:a05:600c:3d16:b0:3cf:8b22:76b3 with SMTP id bh22-20020a05600c3d1600b003cf8b2276b3mr23306017wmb.0.1674486936432;
        Mon, 23 Jan 2023 07:15:36 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bca49000000b003c65c9a36dfsm10671161wml.48.2023.01.23.07.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:15:36 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: arm: align UART node name with bindings
Date:   Mon, 23 Jan 2023 16:15:33 +0100
Message-Id: <20230123151533.369533-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Bindings expect UART/serial node names to be "serial".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/integrator.dtsi         | 4 ++--
 arch/arm/boot/dts/integratorap-im-pd1.dts | 4 ++--
 arch/arm/boot/dts/integratorap.dts        | 4 ++--
 arch/arm/boot/dts/integratorcp.dts        | 4 ++--
 arch/arm/boot/dts/versatile-ab.dts        | 6 +++---
 arch/arm/boot/dts/versatile-pb.dts        | 2 +-
 arch/arm/boot/dts/vexpress-v2m.dtsi       | 8 ++++----
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/integrator.dtsi b/arch/arm/boot/dts/integrator.dtsi
index ad868cfebc94..7f1c8ee9dd8a 100644
--- a/arch/arm/boot/dts/integrator.dtsi
+++ b/arch/arm/boot/dts/integrator.dtsi
@@ -88,12 +88,12 @@ rtc@15000000 {
 			interrupts = <8>;
 		};
 
-		uart@16000000 {
+		serial@16000000 {
 			reg = <0x16000000 0x1000>;
 			interrupts = <1>;
 		};
 
-		uart@17000000 {
+		serial@17000000 {
 			reg = <0x17000000 0x1000>;
 			interrupts = <2>;
 		};
diff --git a/arch/arm/boot/dts/integratorap-im-pd1.dts b/arch/arm/boot/dts/integratorap-im-pd1.dts
index cc514cf07bff..7072a70da00d 100644
--- a/arch/arm/boot/dts/integratorap-im-pd1.dts
+++ b/arch/arm/boot/dts/integratorap-im-pd1.dts
@@ -162,7 +162,7 @@ vga_con_in: endpoint {
 		};
 	};
 
-	uart@100000 {
+	serial@100000 {
 		compatible = "arm,pl011", "arm,primecell";
 		reg = <0x00100000 0x1000>;
 		interrupts-extended = <&impd1_vic 1>;
@@ -170,7 +170,7 @@ uart@100000 {
 		clock-names = "uartclk", "apb_pclk";
 	};
 
-	uart@200000 {
+	serial@200000 {
 		compatible = "arm,pl011", "arm,primecell";
 		reg = <0x00200000 0x1000>;
 		interrupts-extended = <&impd1_vic 2>;
diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index 9148287fa0a9..5b52d75bc6be 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -218,14 +218,14 @@ rtc: rtc@15000000 {
 			clock-names = "apb_pclk";
 		};
 
-		uart0: uart@16000000 {
+		uart0: serial@16000000 {
 			compatible = "arm,pl010", "arm,primecell";
 			arm,primecell-periphid = <0x00041010>;
 			clocks = <&uartclk>, <&pclk>;
 			clock-names = "uartclk", "apb_pclk";
 		};
 
-		uart1: uart@17000000 {
+		uart1: serial@17000000 {
 			compatible = "arm,pl010", "arm,primecell";
 			arm,primecell-periphid = <0x00041010>;
 			clocks = <&uartclk>, <&pclk>;
diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index 38fc7e81bdb6..c011333eb165 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -244,13 +244,13 @@ rtc@15000000 {
 			clock-names = "apb_pclk";
 		};
 
-		uart@16000000 {
+		serial@16000000 {
 			compatible = "arm,pl011", "arm,primecell";
 			clocks = <&uartclk>, <&pclk>;
 			clock-names = "uartclk", "apb_pclk";
 		};
 
-		uart@17000000 {
+		serial@17000000 {
 			compatible = "arm,pl011", "arm,primecell";
 			clocks = <&uartclk>, <&pclk>;
 			clock-names = "uartclk", "apb_pclk";
diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index a520615f4d8d..f31dcf7e5862 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -237,7 +237,7 @@ dma@10130000 {
 			clock-names = "apb_pclk";
 		};
 
-		uart0: uart@101f1000 {
+		uart0: serial@101f1000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x101f1000 0x1000>;
 			interrupts = <12>;
@@ -245,7 +245,7 @@ uart0: uart@101f1000 {
 			clock-names = "uartclk", "apb_pclk";
 		};
 
-		uart1: uart@101f2000 {
+		uart1: serial@101f2000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x101f2000 0x1000>;
 			interrupts = <13>;
@@ -253,7 +253,7 @@ uart1: uart@101f2000 {
 			clock-names = "uartclk", "apb_pclk";
 		};
 
-		uart2: uart@101f3000 {
+		uart2: serial@101f3000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x101f3000 0x1000>;
 			interrupts = <14>;
diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/versatile-pb.dts
index e7e751a858d8..fc21ce54b33a 100644
--- a/arch/arm/boot/dts/versatile-pb.dts
+++ b/arch/arm/boot/dts/versatile-pb.dts
@@ -85,7 +85,7 @@ mmc@5000 {
 				 */
 				interrupts-extended = <&sic 22 &sic 23>;
 			};
-			uart@9000 {
+			serial@9000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x9000 0x1000>;
 				interrupt-parent = <&sic>;
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index def538ce8769..c5e92f6d2fcd 100644
--- a/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -216,7 +216,7 @@ kmi@7000 {
 					clock-names = "KMIREFCLK", "apb_pclk";
 				};
 
-				v2m_serial0: uart@9000 {
+				v2m_serial0: serial@9000 {
 					compatible = "arm,pl011", "arm,primecell";
 					reg = <0x09000 0x1000>;
 					interrupts = <5>;
@@ -224,7 +224,7 @@ v2m_serial0: uart@9000 {
 					clock-names = "uartclk", "apb_pclk";
 				};
 
-				v2m_serial1: uart@a000 {
+				v2m_serial1: serial@a000 {
 					compatible = "arm,pl011", "arm,primecell";
 					reg = <0x0a000 0x1000>;
 					interrupts = <6>;
@@ -232,7 +232,7 @@ v2m_serial1: uart@a000 {
 					clock-names = "uartclk", "apb_pclk";
 				};
 
-				v2m_serial2: uart@b000 {
+				v2m_serial2: serial@b000 {
 					compatible = "arm,pl011", "arm,primecell";
 					reg = <0x0b000 0x1000>;
 					interrupts = <7>;
@@ -240,7 +240,7 @@ v2m_serial2: uart@b000 {
 					clock-names = "uartclk", "apb_pclk";
 				};
 
-				v2m_serial3: uart@c000 {
+				v2m_serial3: serial@c000 {
 					compatible = "arm,pl011", "arm,primecell";
 					reg = <0x0c000 0x1000>;
 					interrupts = <8>;
-- 
2.34.1

