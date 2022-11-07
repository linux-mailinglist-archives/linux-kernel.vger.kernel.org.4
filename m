Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E0461F294
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiKGMKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiKGMKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:10:00 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAABE52
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:09:56 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a15so15894865ljb.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 04:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxKWVOswdBco5ma866B6Lf4pSuG2XDt8/IH4jcoYTSQ=;
        b=jmAhlMLKWKm2L2oRzwVLoe/YclTG857LI5aHsp4261khfuvRx867Kd4EyOHyfjq4e1
         YSzoHEeHnP7b6TbUEkcB48FwaedLYR7Fd7KOoS3MPQDLLJq9EG/cwS11IjopccNSIBIc
         vnC5HJ9Sw0H7fLMl3SlZ255iHxW7xZW/UyF4hcgJ/7XXdNCcAf5DUoSGF3DmYKKuXGUP
         k1HlljnYPkHC4w6ldXkjCDbh5F/YeS7ysdaUDCJRw+ipeI8CO7S8YpqOa7xvoIr9uQym
         4AsTKxo6iCCoEF8NnYXJLFtaJKiBaFkIH9x0w/Jnr4BgqUciegje2Xnk+iBJJy8SKGF3
         sv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxKWVOswdBco5ma866B6Lf4pSuG2XDt8/IH4jcoYTSQ=;
        b=fxKs0gcF806sUQrieBE8x6E0y5fAM7untDhM00AnzspYg+1aSSDxA3wooIoGQ5ve63
         Pz9284p312P/8kbsl8H22O6hpoT8fex3OyTxi3qDW62F7QCtPhB+XfsDGYo53wJ77mfI
         0U13yXqdZx6dpoU4+ZdMoxyy0VrQPEHUBJ1GOM4fTuEAVq+MXbCC/FrE0NYHwzL47UXH
         7IfLKyIQeQfPHqE4dH4mBE4oDp7qy3pdBhnPhZU1Ds4H/rN2IixIlOjlmdd8PKBQGtWO
         0tuTMnDEr7nTzHXUfGiYAbtB4UJjgxeNWB8n8JtY9AqFCZ4CwHEamINfORvCPVzwdFcr
         hdpQ==
X-Gm-Message-State: ACrzQf0obfWC/JvQnpxQyBZW4MbVz6WdPM9qQK96a+cHoTRQEIKz2yqK
        RWOT53Cs7H8tUbK0NuMPLhDKhg==
X-Google-Smtp-Source: AMsMyM7S/PSn5TZVi5GtjxfZrpsY7HoYZwinRMq7G0i1mRqfmZEuMUkrWSB9imGJumnH7MIIbD+yJQ==
X-Received: by 2002:a2e:834c:0:b0:277:24e1:7b80 with SMTP id l12-20020a2e834c000000b0027724e17b80mr16375564ljh.302.1667822994621;
        Mon, 07 Nov 2022 04:09:54 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id p13-20020ac24ecd000000b004a608ec6d8csm1219723lfr.27.2022.11.07.04.09.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Nov 2022 04:09:54 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Chanho Park <chanho61.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-hardening@vger.kernel.org
Subject: [PATCH RESEND v3 4/4] arm64: dts: qcom: Add device tree for Sony Xperia 10 IV
Date:   Mon,  7 Nov 2022 13:09:19 +0100
Message-Id: <20221107120920.12593-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221107120920.12593-1-konrad.dybcio@linaro.org>
References: <20221107120920.12593-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add support for Sony Xperia 10 IV, a.k.a PDX225. This device is a part
of the SoMC SM6375 Murray platform and currently it is the only
device based on that board, so no -common DTSI is created until (if?)
other Murray devices appear.

This commit brings support for:
* USB (only USB2 for now)
* Display via simplefb

To create a working boot image, you need to run:
cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/sm6375-sony-xperia-\
murray-pdx225.dtb > .Image.gz-dtb

mkbootimg \
--kernel .Image.gz-dtb \
--ramdisk some_initrd.img \
--pagesize 4096 \
--base 0x0 \
--kernel_offset 0x8000 \
--ramdisk_offset 0x1000000 \
--tags_offset 0x100 \
--cmdline "SOME_CMDLINE" \
--dtb_offset 0x1f00000 \
--header_version 1 \
--os_version 12 \
--os_patch_level 2022-04 \ # or newer
-o boot.img-sony-xperia-pdx225

Then, you need to flash it on the device and get rid of all the
vendor_boot/dtbo mess:

First, you need to get rid of vendor_boot. However, the bootloader
is utterly retarded and it will not let you neither flash nor erase it.
There are a couple ways to handle this: you can either dd /dev/zero to
it from Android (if you have root) or a custom recovery or from fastbootd
(fastboot/adb reboot fastboot). You will not be able to boot Android
images on your phone unless you lock the bootloader (fastboot oem lock)
and restore the factory image with Xperia Companion
Windows-and-macOS-only software.

The best way so far is probably to use the second (_b) slot and flash
mainline there. This will however require you to flash some partitions
manually, as they are not populated from factory:

(boot_b, dtbo_b, vendor_boot_b, vbmeta_b, vbmeta_system_b) - these we
don't really care about as we nuke/replace them

(dsp_b, imagefv_b, modem_b, oem_b, rdimage_b) - these you NEED to populate
to get a successful boot on slot B, otherwise you will have limited / no
functionality.

To switch slots, simply run:

fastboot --set-active=a //or =b

The rest assumes you are on slot A.

// You have to either pull vbmeta{"","_system"} from
// /dev/block/bootdevice/by-name/ or build one as a part of AOSP
fastboot --disable-verity --disable-verification flash vbmeta_b vbmeta.img
fastboot --disable-verity --disable-verification flash vbmeta_system_b \
vbmeta_system.img

fastboot flash boot_b boot.img-sony-xperia-pdx225
fastboot reboot fastboot // entering fastbootd
fastboot flash vendor_boot_b emptything.img
fastboot flash dtbo_b emptything.img
fastboot reboot bootloader // entering bootloader fastboot
fastboot --set-active=b
fastboot reboot // mainline time!

Where emptything.img is a tiny file that consists of 2 bytes (all zeroes),
doing a "fastboot erase" won't cut it, the bootloader will go crazy and
things will fall apart when it tries to overlay random bytes from an empty
partition onto a perfectly good appended DTB.

From there on you can flash new mainline builds by simply flashing
boot.img that you create after each kernel rebuild.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v2:
- Add second S-o-b
- Move xo freq to this DTS

 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 .../qcom/sm6375-sony-xperia-murray-pdx225.dts | 86 +++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index b0558d3389e5..0292d116c25b 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -144,6 +144,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm6375-sony-xperia-murray-pdx225.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-microsoft-surface-duo.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
new file mode 100644
index 000000000000..450d4a557df1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "sm6375.dtsi"
+#include "pmr735a.dtsi"
+
+/ {
+	model = "Sony Xperia 10 IV";
+	compatible = "sony,pdx225", "qcom,sm6375";
+	chassis-type = "handset";
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer: framebuffer@85200000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x85200000 0 0xc00000>;
+
+			width = <1080>;
+			height = <2520>;
+			stride = <(1080 * 4)>;
+			format = "a8r8g8b8";
+			/*
+			 * That's (going to be) a lot of clocks, but it's necessary due
+			 * to unused clk cleanup & no panel driver yet
+			 */
+			clocks = <&gcc GCC_DISP_AHB_CLK>,
+				 <&gcc GCC_DISP_HF_AXI_CLK>,
+				 <&gcc GCC_DISP_THROTTLE_CORE_CLK>,
+				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>;
+		};
+	};
+
+	reserved-memory {
+		cont_splash_mem: memory@85200000 {
+			reg = <0 0x85200000 0 0xc00000>;
+			no-map;
+		};
+
+		ramoops@ffc40000 {
+			compatible = "ramoops";
+			reg = <0 0xffc40000 0 0xb0000>;
+			record-size = <0x10000>;
+			console-size = <0x60000>;
+			ftrace-size = <0x10000>;
+			pmsg-size = <0x20000>;
+			ecc-size = <16>;
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <13 4>;
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_1_hsphy {
+	status = "okay";
+};
+
+&xo_board_clk {
+	clock-frequency = <19200000>;
+};
-- 
2.38.1

