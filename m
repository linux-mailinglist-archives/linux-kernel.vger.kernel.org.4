Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077BE6269FB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 15:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbiKLOes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 09:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiKLOec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 09:34:32 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF7E1C10A;
        Sat, 12 Nov 2022 06:34:31 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id i10so9876901ejg.6;
        Sat, 12 Nov 2022 06:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr+7dkLsIQWkssfwSwIW2QDjIIkEwPc25TwB+Qcm5uo=;
        b=YKeasKflZl4c3qMzSMsz2RorOL4VRVaj8/U3xQm+eVknrGNWTSYiZkzUube5tqAEFd
         RbXNhajc0myPH8IE0+D8K+lx3mrBlWfAihzHsZpKAXBL1zF5LSIInBLrU9dubZy1GNJB
         78w4NlIHoq2IyA4YayFm31T36U5NEeBUTUQbDlfM+iq+GFd5gRhsc9TJTMI+tWg74t3j
         wq4UqZIUijtea8WYvi22KWB0At0WgMhK3bCBI3195FCncgIZ6BsVKU2e5PAPJI4wQ66j
         3hfK+eoaOwOZqZygpRn7fbHvO4wqnoqXHZD+1zFPfl8wTMtHJaLirj584lX7XAwbMxwA
         t3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr+7dkLsIQWkssfwSwIW2QDjIIkEwPc25TwB+Qcm5uo=;
        b=6b/C/Nk0UCzMsZXJdhmNLlQU5sLlkkIowUnsEBSfId5Qmnzt18gnWjJQExUZz0v3AJ
         cGffleCys5FsSQ3z1kHz8FoDuy5gJDerf3kYUmLvmIaB2TREENn8uFzlLEAxX/IID2Ug
         6sEJ+lR2eLoNFlEBxuEuzr1DGOqsub6pJ1pCF6m5o0T8bAYI3EnEqTg9eOKF9pT/AE9z
         lSEqhx7e09K82/Nva0oDgF21E9RDubYG9vxzcRwd9TJ6Rk0wQTDZw7sC2qBlw2gSj5Jm
         +KgDJ9UO2oeV4iYKMFHDPc6/V/zY4OK383nU1B9ymxBKX6LIxCzGS9TcQH5MAMImM+HU
         4zIQ==
X-Gm-Message-State: ANoB5pnYUY158uDCT3n6RibIiAH+yYBiQeqKcaUNHmMxVg+0Na6oRzus
        LDiK4giLcM6NqV1mpVUVlSrLMHD/Qw7XrsLN
X-Google-Smtp-Source: AA0mqf4+tgay/1Fy+91DYqwR3WBS4VFwoALib4pDVA8WajyUvg8mJzbTjMXXKmO4q/kjrFsAPXyDJg==
X-Received: by 2002:a17:906:504a:b0:78d:6655:d12e with SMTP id e10-20020a170906504a00b0078d6655d12emr5328264ejk.260.1668263669639;
        Sat, 12 Nov 2022 06:34:29 -0800 (PST)
Received: from localhost.localdomain (83.31.120.236.ipv4.supernova.orange.pl. [83.31.120.236])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0077a11b79b9bsm1974668ejf.133.2022.11.12.06.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 06:34:29 -0800 (PST)
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     =?UTF-8?q?Jo=C3=A3o=20H=20=2E=20Spies?= <jhlspies@gmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] arm64: dts: rockchip: Add Anbernic RG351M
Date:   Sat, 12 Nov 2022 15:34:11 +0100
Message-Id: <20221112143411.517906-6-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112143411.517906-1-maccraft123mc@gmail.com>
References: <20221112143411.517906-1-maccraft123mc@gmail.com>
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

This device is a clone of Odroid Go Advance, with added PWM motor, internal
gamepad connected on USB instead of just having it be on GPIO + ADC, and
missing battery shunt resistor.

There's also an LED on GPIO 77(I *guess* PB5 on &gpio2), that is controlled in a weird way:

- It is set to red by setting output value to 1
- Set to green by setting output value to 0
- Set to yellow by setting gpio direction to input

I have no idea how to describe that in DTS, without adding a custom
driver, for now it's just left out.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../dts/rockchip/rk3326-anbernic-rg351m.dts   | 54 +++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 142c83d2e5aa..b379516c15eb 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-rock-pi-s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3318-a95x-z2.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-anbernic-rg351m.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2-v11.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go3.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts b/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts
new file mode 100644
index 000000000000..7f4726d4130e
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Hardkernel Co., Ltd
+ * Copyright (c) 2020 Theobroma Systems Design und Consulting GmbH
+ * Copyright (c) 2022 Maya Matuszczyk <maccraft123mc@gmail.com>
+ */
+
+/dts-v1/;
+#include "rk3326-odroid-go.dtsi"
+
+/ {
+	model = "Anbernic RG351M";
+	compatible = "anbernic,rg351m", "rockchip,rk3326";
+
+	battery: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <3450000>;
+		charge-term-current-microamp = <300000>;
+		constant-charge-current-max-microamp = <2000000>;
+		constant-charge-voltage-max-microvolt = <4200000>;
+		factory-internal-resistance-micro-ohms = <100000>;
+		voltage-max-design-microvolt = <4100000>;
+		voltage-min-design-microvolt = <3500000>;
+
+		ocv-capacity-celsius = <20>;
+		ocv-capacity-table-0 =  <4046950 100>, <4001920 95>, <3967900 90>, <3919950 85>,
+					<3888450 80>, <3861850 75>, <3831540 70>, <3799130 65>,
+					<3768190 60>, <3745650 55>, <3726610 50>, <3711630 45>,
+					<3696720 40>, <3685660 35>, <3674950 30>, <3663050 25>,
+					<3649470 20>, <3635260 15>, <3616920 10>, <3592440 5>,
+					<3574170 0>;
+	};
+
+	vibrator {
+		compatible = "pwm-vibrator";
+		pwms = <&pwm0 0 1000000 0>;
+		pwm-names = "enable";
+	};
+};
+
+/delete-node/ &builtin_gamepad;
+/delete-node/ &vcc_host; /* conflicts with pwm vibration motor */
+
+&internal_display {
+	compatible = "elida,kd35t133";
+};
+
+&pwm0 {
+	status = "okay";
+};
+
+&rk817_charger {
+	monitored-battery = <&battery>;
+};
-- 
2.38.1

