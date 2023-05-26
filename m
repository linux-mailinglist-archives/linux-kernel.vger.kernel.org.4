Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A67712D87
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244025AbjEZTbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244022AbjEZTbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:31:02 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58272E6B;
        Fri, 26 May 2023 12:30:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6d01d390bso11892865e9.2;
        Fri, 26 May 2023 12:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685129453; x=1687721453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pM/LPuq+crw58Br+yK0qd+I4lbnJHtjzEVoX/VQ84uQ=;
        b=EldHgGIA3Tv85EJKaqAN/HusU3ux1Do2Ch3hkYhXRewE9Vexa3GvViKOSM2mckcVSK
         FH/wnqcfyrE4bvTuZ8yNw7X/t7G0lht/RiBYpgV+EVqKdeGiXS7STNdeg0/s5dLFRUAN
         Q0RH7WWKsV48zQnHvnOekozCl+VThGWseKiiP0iuR4ZJBr4ZWQT+rLN2PwINqpk41F0R
         Ow0enpNgcuSzASvojtJdGK/RzwRHzhCleuNkEedBpCcy7fxv6o1Pb6pq0NyeNpZUTVSg
         73g7rOr3f2tqwngcsD5KHW6HjDQQ7/DGrycii0WuCOq9sSPXiTrdmjFN966maPUxHMR7
         rtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129453; x=1687721453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pM/LPuq+crw58Br+yK0qd+I4lbnJHtjzEVoX/VQ84uQ=;
        b=UNZT++CBf6JqLlQdhj+eAN0p7eBLLw58zBEj04vu2FcKJlwG9wqgynq67goeZdoCt3
         J5bpg4SHkOSOuh0oKooi5PA6sY7TEhr84w8q5HGzEhBbSslcPbB4uO/y8ysf4vfooqo5
         jHWBCHtqjmxu+MlpNojKWRbH3CwaObi64CZy21xG+kxx7PeABGDVupOBm/QePW1z1VOB
         OLxonp/JzSOGKoQhfPM3NTm9ZVzDgKCkeMWGQ/AzzPC+WRL0+CyJd2+zBBkOLcJx8gVC
         Y2Y9QWpkXanmdrh7nhtBG+VdOuExARbEpYSFhNWP2kTPsTfSK3oVY8oljgIiYcBJuPM1
         y+dQ==
X-Gm-Message-State: AC+VfDxLgnk35DCq21VBSHShqLCHIofPXXRTq3mIQ302Fo5k3jYAdz1b
        b7SwSOdg3i9HGkRgljV3QvwvQv7Hzp8=
X-Google-Smtp-Source: ACHHUZ6WPvUjqJJM9XvrHnWP/l+kilzoaRyl9VRR9lXzqkR7dJzl4YKfNPcUeX/g9DpYpwIRxkiwhg==
X-Received: by 2002:a1c:f709:0:b0:3f4:2c71:b9ad with SMTP id v9-20020a1cf709000000b003f42c71b9admr2744268wmh.30.1685129452700;
        Fri, 26 May 2023 12:30:52 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c24cd00b003f4dde07956sm9704192wmu.42.2023.05.26.12.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:30:52 -0700 (PDT)
Date:   Fri, 26 May 2023 21:30:50 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] ARM: dts: bcm28155-ap: use node labels
Message-ID: <cb52d36db90fa24e40fccc69724a685344f2c2f3.1685127525.git.stano.jakubek@gmail.com>
References: <cover.1685127525.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1685127525.git.stano.jakubek@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use node labels instead of nodename@address for BCM28155 AP board
to simplify its DTS file.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
I was not sure what to do about the &pmu node here, so I left it as is.

 arch/arm/boot/dts/bcm28155-ap.dts | 110 +++++++++++++++---------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 0a8ad1d673d8..08eea8b941b6 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -15,64 +15,21 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
+};
 
-	serial@3e000000 {
-		status = "okay";
-	};
-
-	i2c@3e016000 {
-		clock-frequency = <400000>;
-		status = "okay";
-	};
-
-	i2c@3e017000 {
-		clock-frequency = <400000>;
-		status = "okay";
-	};
-
-	i2c@3e018000 {
-		clock-frequency = <400000>;
-		status = "okay";
-	};
-
-	i2c@3500d000 {
-		clock-frequency = <100000>;
-		status = "okay";
-
-		pmu: pmu@8 {
-			reg = <0x08>;
-		};
-	};
-
-	sdio2: mmc@3f190000 {
-		non-removable;
-		max-frequency = <48000000>;
-		vmmc-supply = <&camldo1_reg>;
-		vqmmc-supply = <&iosr1_reg>;
-		status = "okay";
-	};
-
-	sdio4: mmc@3f1b0000 {
-		max-frequency = <48000000>;
-		cd-gpios = <&gpio 14 GPIO_ACTIVE_LOW>;
-		vmmc-supply = <&sdldo_reg>;
-		vqmmc-supply = <&sdxldo_reg>;
-		status = "okay";
-	};
-
-	pwm: pwm@3e01a000 {
-		status = "okay";
-	};
+&bsc1 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
 
-	usbotg: usb@3f120000 {
-		vusb_d-supply = <&usbldo_reg>;
-		vusb_a-supply = <&iosr1_reg>;
-		status = "okay";
-	};
+&bsc2 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
 
-	usbphy: usb-phy@3f130000 {
-		status = "okay";
-	};
+&bsc3 {
+	clock-frequency = <400000>;
+	status = "okay";
 };
 
 #include "bcm59056.dtsi"
@@ -110,3 +67,46 @@ iosr1_reg: iosr1 {
 		};
 	};
 };
+
+&pmu_bsc {
+	clock-frequency = <100000>;
+	status = "okay";
+
+	pmu: pmu@8 {
+		reg = <0x08>;
+	};
+};
+
+&pwm {
+	status = "okay";
+};
+
+&sdio2 {
+	non-removable;
+	max-frequency = <48000000>;
+	vmmc-supply = <&camldo1_reg>;
+	vqmmc-supply = <&iosr1_reg>;
+	status = "okay";
+};
+
+&sdio4 {
+	max-frequency = <48000000>;
+	cd-gpios = <&gpio 14 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&sdldo_reg>;
+	vqmmc-supply = <&sdxldo_reg>;
+	status = "okay";
+};
+
+&uartb {
+	status = "okay";
+};
+
+&usbotg {
+	vusb_d-supply = <&usbldo_reg>;
+	vusb_a-supply = <&iosr1_reg>;
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.25.1

