Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5EC67B594
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbjAYPL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbjAYPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:11:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1C05974A;
        Wed, 25 Jan 2023 07:11:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b7so17384754wrt.3;
        Wed, 25 Jan 2023 07:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/Fxp0KlTmBwEo1nLuzPHrie4d14h9A0j9bTIw7gzKw=;
        b=CtGwkl+IS46rp3qQgGyErQWm/hgEB6SyCGQkoL1x+tBLynIrmC7mEtQgDewk4s45Tx
         HzrwbYIx3LH+JJhQmpwBYvSKaHQ5bTcoMeYGkHdek5p9vGBkgF/SRw8oKYNTHb0kQcV/
         DNdar1mAUffK1FG/eh6TsGdscVDdaGEHF/ZkP0ByjX1yDgkKTd9nqCts9tmH/nv1ADL1
         JbZXQnnBt5VeJPTeIa2xQqxjDvOa03K3iwOUXZfLNKIjldQ0Z1kl+vmWz65QDiS1q7C9
         bUN+1F5AaXjddy9O61D4zWUQL03JteKpoI/aN6rK3t4LvNmE0arodkP7iwVIcLrqdcz2
         IYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/Fxp0KlTmBwEo1nLuzPHrie4d14h9A0j9bTIw7gzKw=;
        b=5QnfP5ul6dpctzHHrpGyUdvpYL1UpNbIHSaVlBKJ+nP1Sbg9WWr4I7yl4SYUSr8lWs
         4Wfk7ODT322BSfFEpxAXjvM7I9wYCWlDtG5EmBHnGQoP/Z4bllj0FoB26gzYpIXOLseK
         eIyUGvzXRInYu1sL8rahpiC/XxnMm1BUAU5fz91OPlO6RDK0PK9NiDejwbmPYnznkrOy
         vSbgUJAFyIsBfoPZhm3oxhYso94CLv3wsbws+SFrQtSiGj7nkv5l04+JzYMUuWxX8fot
         lKb48opAYWtzLQXv3ATS4QHclXGQvT+jPo2xyw3EzQ6Sxoacnaxz41Aex6BQ35ErcDbW
         wFQQ==
X-Gm-Message-State: AFqh2kp35QaJ2giltUQsPnZ199gNY7OSuCjGDSJinJN9FFY5jzNdz0R2
        GnpAd9bKnbYblqEwOPDwE0k=
X-Google-Smtp-Source: AMrXdXuMkOQtZcZ4+FN91hG07gKC0iqbiy2giQLh12TtWsSBclabn/wzC+MMIA1i0c6/GJZ1lWA1mA==
X-Received: by 2002:adf:eec6:0:b0:2be:57b9:f569 with SMTP id a6-20020adfeec6000000b002be57b9f569mr17246547wrp.23.1674659471989;
        Wed, 25 Jan 2023 07:11:11 -0800 (PST)
Received: from localhost ([82.222.96.52])
        by smtp.gmail.com with UTF8SMTPSA id t9-20020adff049000000b002bddaea7a0bsm4672475wro.57.2023.01.25.07.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 07:11:11 -0800 (PST)
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
Date:   Wed, 25 Jan 2023 18:10:40 +0300
Message-Id: <20230125151041.55483-5-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230125151041.55483-1-fnkl.kernel@gmail.com>
References: <20230125151041.55483-1-fnkl.kernel@gmail.com>
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

