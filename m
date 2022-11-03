Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA47618739
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiKCSPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiKCSOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:14:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583B262C2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:14:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so3966620wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpWkdxUe4lkq+ssLF6RjxVO7r2F+0rfvCYX5i/7pnv8=;
        b=pQ7icVZZVpaKZBpDM7CnZUN2NFuwCgKUP487ZR6s1hC9c9p83rb0/NwpjmKwOmQNba
         ZmxHLWmO7HWbEsWkMPXDl9PUuxspiHDQ4/6K9z0r+5+mBJfk68G/8m4FLwSpOZ5hcqn+
         PHIb1shU/+ggQPgi3Idn3lGTOL3jwbesowvfBwsetHBnRMrCk1xjMKvYIldcaEJi5FrH
         61QSBXGQOUuRBhC2NoRseSooFtkwlZoqZPo2N2tSewvSWrdb0ro7TIg8Co6b6PQnM5cX
         iCKdryzsN5RkRr94hV3VB90VuOQjIrWGZy5UiLU+gzw/c13S60dC3Q1nYJJcwje8UiwW
         ZaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpWkdxUe4lkq+ssLF6RjxVO7r2F+0rfvCYX5i/7pnv8=;
        b=klNHrZ0gPGwfOChgjE3sOA1j0uRQTgAVYRLvTpu+Rid4LvCEU+hLqHaSdWQz8sgxhi
         hhQg8bsFRnlZrWCjNEQre0WETzCKLpUHC0Ap5gE3qqHUMob7wg748XqLLSMbbY/QtOrH
         JVADZF7lMT/vSBRCx9/1WidESb1zvnHbD4OTc8/t0rHsn1i4XBh26MfUHqpR/4GqXTJi
         cu9uFWiB9qQvLKTiLCzVxkqGLLITWxmc6zyd4cnZ8yJ+Fz5iyK0IqX3ozu3obdN8hujr
         o4PZxaRE4JIydQ8EL6ET5PWlYSDFVjqMuGXfVj5tmRbjtpdppiKGm7d8jEwH5fqP8I4c
         RuYA==
X-Gm-Message-State: ACrzQf2X7XBZxXCw8mUoCu8jpjRVdwxXdtxqemNiDIRkCUx7XYPT5fcn
        /RIUa0NHAvLAMQVmIeAhqxOLLQ==
X-Google-Smtp-Source: AMsMyM6Dlg+6MyWEJenu9b6cXcpqx/uWksNoEfL5vwliylACxNYieSQiRpmky/X9UFOi5JgiHiCp1g==
X-Received: by 2002:a7b:c398:0:b0:3c7:87f:3b48 with SMTP id s24-20020a7bc398000000b003c7087f3b48mr20787901wmj.65.1667499283930;
        Thu, 03 Nov 2022 11:14:43 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (254.31.102.84.rev.sfr.net. [84.102.31.254])
        by smtp.gmail.com with ESMTPSA id h19-20020a1ccc13000000b003b49ab8ff53sm639212wmb.8.2022.11.03.11.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 11:14:43 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-am62: add watchdog nodes
Date:   Thu,  3 Nov 2022 19:14:39 +0100
Message-Id: <20221103181440.232727-2-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221103181440.232727-1-jpanis@baylibre.com>
References: <20221103181440.232727-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for watchdogs :
- 5 in main domain
- 1 in MCU domain
- 1 in wakeup domain

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi   | 45 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    |  9 +++++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi |  9 +++++
 3 files changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 03660476364f..fb8480d7cf76 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -591,6 +591,51 @@ main_mcan0: can@20701000 {
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
 	};
 
+	main_rti0: watchdog@e000000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e000000 0x00 0x100>;
+		clocks = <&k3_clks 125 0>;
+		power-domains = <&k3_pds 125 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 125 0>;
+		assigned-clock-parents = <&k3_clks 125 2>;
+	};
+
+	main_rti1: watchdog@e010000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e010000 0x00 0x100>;
+		clocks = <&k3_clks 126 0>;
+		power-domains = <&k3_pds 126 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 126 0>;
+		assigned-clock-parents = <&k3_clks 126 2>;
+	};
+
+	main_rti2: watchdog@e020000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e020000 0x00 0x100>;
+		clocks = <&k3_clks 127 0>;
+		power-domains = <&k3_pds 127 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 127 0>;
+		assigned-clock-parents = <&k3_clks 127 2>;
+	};
+
+	main_rti3: watchdog@e030000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e030000 0x00 0x100>;
+		clocks = <&k3_clks 128 0>;
+		power-domains = <&k3_pds 128 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 128 0>;
+		assigned-clock-parents = <&k3_clks 128 2>;
+	};
+
+	main_rti15: watchdog@e0f0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e0f0000 0x00 0x100>;
+		clocks = <&k3_clks 130 0>;
+		power-domains = <&k3_pds 130 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 130 0>;
+		assigned-clock-parents = <&k3_clks 130 2>;
+	};
+
 	epwm0: pwm@23000000 {
 		compatible = "ti,am64-epwm", "ti,am3352-ehrpwm";
 		#pwm-cells = <3>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index f56c803560f2..f82e94def774 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -81,4 +81,13 @@ mcu_gpio0: gpio@4201000 {
 		clocks = <&k3_clks 79 0>;
 		clock-names = "gpio";
 	};
+
+	mcu_rti0: watchdog@4880000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x04880000 0x00 0x100>;
+		clocks = <&k3_clks 131 0>;
+		power-domains = <&k3_pds 131 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 131 0>;
+		assigned-clock-parents = <&k3_clks 131 2>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index 4090134676cf..3c95ac3a0dd5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -38,4 +38,13 @@ wkup_i2c0: i2c@2b200000 {
 		clocks = <&k3_clks 107 4>;
 		clock-names = "fck";
 	};
+
+	wkup_rti0: watchdog@2b000000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2b000000 0x00 0x100>;
+		clocks = <&k3_clks 132 0>;
+		power-domains = <&k3_pds 132 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 132 0>;
+		assigned-clock-parents = <&k3_clks 132 2>;
+	};
 };
-- 
2.37.3

