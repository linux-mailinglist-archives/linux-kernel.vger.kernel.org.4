Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8192366AB96
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 14:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjANN1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 08:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjANN1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 08:27:08 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014699027;
        Sat, 14 Jan 2023 05:27:06 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q8so5089965wmo.5;
        Sat, 14 Jan 2023 05:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/Fxp0KlTmBwEo1nLuzPHrie4d14h9A0j9bTIw7gzKw=;
        b=TD8X0OMAzHCrbPiSDCwQFOC8jDyzGcm1xImUM4l7K3WQRocTAn/EDw2JtAH8xarawB
         agqs3rzbyzTa9O/+hSL3kpMG0M1CE40jItshSL/CrQUCydeYTIbTAjSSQJc0b8f0rkYS
         1E44hapvinqgwYXI4vtfNRRPBos2qHBZxlybB1T3LncHgSS1/HgARtmcdagL7Ssjb0AP
         1pHlmIq+RpS0LwWU+60Ugya/hzgYmO7LjSnQI+pxy7fhFrmpR8x5BZLjWmWiq3mlXsm7
         X9ViIztl87/VXh6kt6EiklAVbzoUMAl+NWn++3sAS15rcogkqCptSMgtbmthEdgQdsBF
         1rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/Fxp0KlTmBwEo1nLuzPHrie4d14h9A0j9bTIw7gzKw=;
        b=zOu0Lf56bxF4z0gM53wgMNV6r7YLQOB5LktIe2vSR0j/rd2Yty245h3VhmHCEp5qYI
         xzaJsN6IvEJgfTIRa9w+SyIfq0T+DjatvMz9tkCS5lETzDq2ZNclQsEIlKTUpwH172rI
         gq0H7asrIhtwmaczubNVl8fZaTrQ4lUS6mXnXNqZBaw94qtrKxb8UCj+eLzv0siOAdyu
         NywTn2ZrfSjpaK+H82YVSk8hZKP1tKbdfObXK8UVfzjUyyy/K6lXoDltPScxUh06g2xK
         JlazLTEWqRhtWuuIEn/UwKie70E7BjSTYbsC0sJ5Et4zNgm7BPrfPK7X+uuNoDVnuAa4
         D0bQ==
X-Gm-Message-State: AFqh2kqvkwSrQd9XdT1ptI/MlRcVVyCe/KCvSQ0BGkDCc5tAkDKv/SRR
        7wKsuGXyojxgHHnWC77Z3TE=
X-Google-Smtp-Source: AMrXdXvBIJOlly8NqvtSZHg3EZPrc5ZqQPIiBQz8VemZlxvq4gfVHX5Oc1FEsv8l3rvtzcFliCBn0g==
X-Received: by 2002:a05:600c:8505:b0:3da:f89:bc46 with SMTP id gw5-20020a05600c850500b003da0f89bc46mr9552087wmb.17.1673702825604;
        Sat, 14 Jan 2023 05:27:05 -0800 (PST)
Received: from localhost ([176.234.9.57])
        by smtp.gmail.com with UTF8SMTPSA id 2-20020a05600c020200b003d9ef8ad6b2sm19544558wmi.13.2023.01.14.05.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 05:27:05 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <7d578vix8hzw@opayq.net>,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v7 4/5] arm64: dts: apple: t600x: Add PWM controller
Date:   Sat, 14 Jan 2023 16:25:07 +0300
Message-Id: <20230114132508.96600-5-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230114132508.96600-1-fnkl.kernel@gmail.com>
References: <20230114132508.96600-1-fnkl.kernel@gmail.com>
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

From: Sasha Finkelstein <7d578vix8hzw@opayq.net>

Adds PWM controller and keyboard backlight bindings for M1 Pro/Max MacBook Pros

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Acked-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/boot/dts/apple/t600x-die0.dtsi      |  9 +++++++++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
index 1c41954e3899..9157ae2a9f7f 100644
--- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -71,6 +71,15 @@ sio_dart_1: iommu@39b008000 {
 		power-domains = <&ps_sio_cpu>;
 	};
 
+	fpwm0: pwm@39b030000 {
+		compatible = "apple,t6000-fpwm", "apple,s5l-fpwm";
+		reg = <0x3 0x9b030000 0x0 0x4000>;
+		power-domains = <&ps_fpwm0>;
+		clocks = <&clkref>;
+		#pwm-cells = <2>;
+		status = "disabled";
+	};
+
 	i2c0: i2c@39b040000 {
 		compatible = "apple,t6000-i2c", "apple,i2c";
 		reg = <0x3 0x9b040000 0x0 0x4000>;
diff --git a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
index 34906d522f0a..96de7165df6d 100644
--- a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
@@ -9,6 +9,8 @@
  * Copyright The Asahi Linux Contributors
  */
 
+#include <dt-bindings/leds/common.h>
+
 / {
 	aliases {
 		serial0 = &serial0;
@@ -34,6 +36,18 @@ memory@10000000000 {
 		device_type = "memory";
 		reg = <0x100 0 0x2 0>; /* To be filled by loader */
 	};
+
+	led-controller {
+		compatible = "pwm-leds";
+		led-0 {
+			pwms = <&fpwm0 0 40000>;
+			label = "kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			max-brightness = <255>;
+			default-state = "keep";
+		};
+	};
 };
 
 &serial0 {
@@ -110,5 +124,9 @@ &pcie0_dart_3 {
 	status = "disabled";
 };
 
+&fpwm0 {
+	status = "okay";
+};
+
 /delete-node/ &port02;
 /delete-node/ &port03;
-- 
2.37.1 (Apple Git-137.1)

