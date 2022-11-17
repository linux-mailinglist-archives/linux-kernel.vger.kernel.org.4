Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9379362E7A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbiKQWBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241037AbiKQWAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:00:52 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC88F72121;
        Thu, 17 Nov 2022 14:00:11 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j4so5163731lfk.0;
        Thu, 17 Nov 2022 14:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQRlvK77hsvedjqbbgPjARmdvtiGduxanVRX+q1kiBQ=;
        b=fHP1kl1yM/VTKBFLmy/3ASQg8Q5561DGSp/lxTGjpivW3kYEBJZy1xb0vO+OiYceLo
         OLW+hZ3BOf5+ucl3BN2P3PCMRRRV1M1f4Ca7d6m2cIL+cpeh4FXEaV8pWn6CQWfKUHCL
         VFfc9zDjSQdBoUIvNr3eIxj+Frb2OEAPSEUT3xDt+2bzYp9FslYX4GdP5oEiVayT44f9
         qZgZ/LrY5o2/pUWHj4jUSqkkKupQYqHgVrGpQzIhYNFZwzJ4dfugpDh6dm0gWHN/Ie8c
         KP/GPYmjR0iLl4OXf/yeZPqbhGTio0wCNz6G4tRJqfz3/sOtmCZAcjA1tDqR+c3/eqxN
         X+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQRlvK77hsvedjqbbgPjARmdvtiGduxanVRX+q1kiBQ=;
        b=RAJhoNTyCZrn9WJP9aEEcPC77UW6NFacsoe5SmdsZQPMfjkqJcrLJcSxbGyeV5wLsF
         YA989hPO0NzKu/1gVMmdCnJ8d22D2frGo0uqtIoNrR8PPDXleW1tU5EiPkd0GVo2dblv
         BzEqx+y0VYFxEbjek/RzLjq7YArD9seDXZJvOLz/ti+aNlCKlzlNPX5sIqubGS5r3zVS
         4zrnOAnyc30Vy3cgpLqJQSJyTnTK12b8W3b7PvxDw+KpRmwzgz6IUX44bHfmfR2xtL6I
         1EFgdDl29QN5FeQkeChw9ShFS3yhNMA0QPR8l8VjwfynVnxGdxow79S4hF2kwPxUfzNW
         phww==
X-Gm-Message-State: ANoB5pnr7Zh6fHwwkxZNnhDa7SdLiSvq1mqoZw8G3vGwVNmrWuKBLg/F
        eviEzFFa5+OuRMFuTXsDPfU=
X-Google-Smtp-Source: AA0mqf7T8odImdw+v5OcY4vqRzJJEdUEeu1hbDqGL1SRBcLnBSP/pZJn73vBcjO261JeFV4NblM+Hg==
X-Received: by 2002:a19:2d5e:0:b0:4b4:a14a:c958 with SMTP id t30-20020a192d5e000000b004b4a14ac958mr1555505lft.579.1668722410350;
        Thu, 17 Nov 2022 14:00:10 -0800 (PST)
Received: from localhost.localdomain (79.191.9.185.ipv4.supernova.orange.pl. [79.191.9.185])
        by smtp.gmail.com with ESMTPSA id q29-20020ac25a1d000000b00497aa190523sm342985lfn.248.2022.11.17.14.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:00:10 -0800 (PST)
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
Subject: [PATCH v4 5/5] arm64: dts: rockchip: Add Anbernic RG351M
Date:   Thu, 17 Nov 2022 22:59:54 +0100
Message-Id: <20221117215954.4114202-6-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117215954.4114202-1-maccraft123mc@gmail.com>
References: <20221117215954.4114202-1-maccraft123mc@gmail.com>
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
Due to missing shunt resistor and lack of a workaroun in rk817_charger
driver rk817_charger is not enabled in dts.

There's also an LED on GPIO 77(I *guess* PB5 on &gpio2),
that is controlled in a weird way:

- It is set to red by setting output value to 1
- Set to green by setting output value to 0
- Set to yellow by setting gpio direction to input

I have no idea how to describe that in DTS, without adding a custom
driver, for now it's just left out.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../dts/rockchip/rk3326-anbernic-rg351m.dts   | 33 +++++++++++++++++++
 2 files changed, 34 insertions(+)
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
index 000000000000..61b31688b469
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3326-anbernic-rg351m.dts
@@ -0,0 +1,33 @@
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
+/delete-node/ &rk817_charger;
-- 
2.38.1

