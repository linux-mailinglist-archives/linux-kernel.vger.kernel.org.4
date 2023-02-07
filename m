Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A0068E290
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBGVBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjBGVAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:00:39 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133B123675
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 13:00:35 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so38359wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 13:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EL0UxKkbBJyJQsPoDByYBOTCFVMLiiPVdLRpwYhsZyU=;
        b=QYvkwDEtI17eFx3Aky5tWD098dmnaGI3c54T+cIdcAwUqyzH1RwHuKU5MEuuZ3xajx
         WaZVGXsze1tpE3vp8YrGuB4flr0lNTu/u1UjUGlMK6ZxiYqzRsZU/GVPVfH9b7b2IxDM
         I1zLkcQrDtvDWPfH6kzDPeKZ8aeimwOQ3ML2jSC/YaOqXy6rgobFjwcT2Aov3gkDQm6C
         IWIkSE6K0o1KLTt8Sr8Z3SUPA9oB9cM+PTf8KjPmW9CWgUwgJ7KgavUwaKG1XDpfwizt
         QjPaJAjiz1xuv61x36wVlC/1Qs8ptleONoKPJddwnmPFJzyorKByIyawP8SeYtWel9ss
         oaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EL0UxKkbBJyJQsPoDByYBOTCFVMLiiPVdLRpwYhsZyU=;
        b=t8dRuQE/JyFQsvLkPi15n9PBjD5//dHNElD7S9tKH4MQrzIcF3itNPTaSa+wIBIosx
         YSMZP0w8fUPwqJICUoPNZGevqQ9Fx48fPYYvJaCERVR2Wj0GIPtpBwp1Peu3G0fr1rR3
         HRVE5HWpX0FPhEimSxeI986Jv6qVdVGIrlSxBowR0p2k2RYXghRGwP+hg+3NtSZHmc0Y
         Karp7E5DBklENtRNkhB1NntMyZKDw1UAo5ycGa5jzBbI0gEgiOQ3yY0m+L0/HPbGW2Wt
         62sryvG0fVw+B9KvnUKZWLxIPon/P00CYACjtR53eMCA95lYc1heyNHkxEnwv+kB0mtE
         F1wQ==
X-Gm-Message-State: AO0yUKXGuhfOweZaWZdg996FuSn+KOFOhDkj0z5elG3S+x1Z3TDMva75
        3ejYKMILmWSxLRM8rEMZJq10Iw==
X-Google-Smtp-Source: AK7set+iWPMML3Nm2brY9DDC78PaPSUmaB2xj9+8+sVGsinSPH+VjBv0oq3VZeEnT0ElEM52IECvQg==
X-Received: by 2002:a05:600c:a295:b0:3da:1e35:dfec with SMTP id hu21-20020a05600ca29500b003da1e35dfecmr4247864wmb.4.1675803633511;
        Tue, 07 Feb 2023 13:00:33 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c44c900b003dc4fd6e624sm8041631wmo.19.2023.02.07.13.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:00:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 7/7] ARM: dts: exynos: move I2C10 out of soc node on Arndale
Date:   Tue,  7 Feb 2023 22:00:20 +0100
Message-Id: <20230207210020.677007-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207210020.677007-1-krzysztof.kozlowski@linaro.org>
References: <20230207210020.677007-1-krzysztof.kozlowski@linaro.org>
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

I2C10 is represented as i2c-gpio device, thus it is not really a part of
soc MMIO bus:

  exynos5250-arndale.dtb: soc: i2c-10: {'pinctrl-names': ['default'], ... } should not be valid under {'type': 'object'}

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 28 +++++++++++-------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 305289ed06d8..56f08ca4762c 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -73,6 +73,19 @@ key-wakeup {
 		};
 	};
 
+	/*
+	 * For unknown reasons HDMI-DDC does not work with Exynos I2C
+	 * controllers. Lets use software I2C over GPIO pins as a workaround.
+	 */
+	i2c_ddc: i2c-10 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c2_gpio_bus>;
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpa0 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpa0 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <2>;
+	};
+
 	panel: panel {
 		compatible = "boe,hv070wsa-100";
 		power-supply = <&vcc_3v3_reg>;
@@ -615,21 +628,6 @@ &sata_phy_i2c {
 	status = "okay";
 };
 
-&soc {
-	/*
-	 * For unknown reasons HDMI-DDC does not work with Exynos I2C
-	 * controllers. Lets use software I2C over GPIO pins as a workaround.
-	 */
-	i2c_ddc: i2c-10 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&i2c2_gpio_bus>;
-		compatible = "i2c-gpio";
-		sda-gpios = <&gpa0 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-		scl-gpios = <&gpa0 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-		i2c-gpio,delay-us = <2>;
-	};
-};
-
 &usbdrd {
 	vdd10-supply = <&ldo15_reg>;
 	vdd33-supply = <&ldo12_reg>;
-- 
2.34.1

