Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1EB6C688E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjCWMiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCWMiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:38:16 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD9E2210F;
        Thu, 23 Mar 2023 05:38:15 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d14so6997804ion.9;
        Thu, 23 Mar 2023 05:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679575095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOjM89dV+f1cFPNk0j8IHVhvMB89HUV+FlvJghSUjlQ=;
        b=oDrfA7Heo6Vii3zxTD9VbIKYMRnBixv6HAELcEcGLMpFGeAoZH9vdFffAgj20IE0Cm
         JdyQaJsBpjRACmOt7cGpDQ9ak8eIsM21e+iUUk57AYhfjF8fDHMC975KoxQhH/f61Xsj
         hINIucw99ESCNrZZ8q/a8tRz/oVzaCa7M8zScJ6G8TCrE/W8HrEpoeO3MDmmlmU0oznQ
         N3gvJs5hXYStRNmzcJe6H7H7SzuOdrJFLjo1UotAOHRWhfMssbongPqHjFobM4ng+D8Q
         TWD5xJP7Mry1dHTfJ1XvrW6aOYiDgivIxtISxvfu1VT0uuhv6buQ1GcGLSVy9yaz0zYT
         eAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOjM89dV+f1cFPNk0j8IHVhvMB89HUV+FlvJghSUjlQ=;
        b=GAQy+F9SnBZPXGYIUlwrcbVcJSB8QgroUYbBEBGhiaEeTJg5yth9tAJX5wAdya1/hA
         oSaC2SqrNAHLkvjT2henAcuxo5TSstsOOtVyH+6wgZTC36RcjJ300xQNFNu38KUyTobc
         x7MbK3mwIr7FciyuTXvGOO3jgBXCwleT/KqQtvMyzVDtvOZbU2BPwq19uYy87GweHf0n
         xIo3j5cdnwA8Gsatg1L7AqQm9ffcyWuE7xCuBZipc4c37LcQNQA/kbVjBV18O9GCzTJD
         GIxx0NOEFLlNSa+Kp0f1LGHb9atyz2ygwvy/I1hsZifps0DZFDQJCT0JJfYZuaUberH0
         v/jw==
X-Gm-Message-State: AO0yUKWHPOYQf6zqwKzcekdqC5YuUtZKO3anJ6zrv3ypXozQH03nQKoF
        31XjznazcvDP4IB6SsKyO3s=
X-Google-Smtp-Source: AK7set/emyrbUtQ4ilsKCyUOhtWp+dPiXfrcqXwi6fGfLTvcANPirMisjAWHgkNVsSJSdpJfqH5FxQ==
X-Received: by 2002:a5d:894b:0:b0:74c:9df4:5c2a with SMTP id b11-20020a5d894b000000b0074c9df45c2amr6030449iot.12.1679575095047;
        Thu, 23 Mar 2023 05:38:15 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id n11-20020a6bed0b000000b00758993500f3sm1307608iog.7.2023.03.23.05.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:38:14 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Tianling Shen <cnsztl@gmail.com>, Andy Yan <andyshrk@163.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: rockchip: Add FriendlyARM NanoPi R2C
Date:   Thu, 23 Mar 2023 20:38:05 +0800
Message-Id: <20230323123807.11882-3-cnsztl@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230323123807.11882-1-cnsztl@gmail.com>
References: <20230323123807.11882-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NanoPi R2C is a minor variant of NanoPi R2S with the on-board NIC
chip changed from rtl8211e to yt8521s, and otherwise identical to R2S.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3328-nanopi-r2c.dts   | 40 +++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index a315a8117b0f..0bdcddd221f8 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -14,6 +14,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2-v11.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go3.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-a1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-orangepi-r1-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock64.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts
new file mode 100644
index 000000000000..a07a26b944a0
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2021 FriendlyElec Computer Tech. Co., Ltd.
+ * (http://www.friendlyarm.com)
+ *
+ * Copyright (c) 2021-2023 Tianling Shen <cnsztl@gmail.com>
+ */
+
+/dts-v1/;
+#include "rk3328-nanopi-r2s.dts"
+
+/ {
+	model = "FriendlyElec NanoPi R2C";
+	compatible = "friendlyarm,nanopi-r2c", "rockchip,rk3328";
+};
+
+&gmac2io {
+	phy-handle = <&yt8521s>;
+	tx_delay = <0x22>;
+	rx_delay = <0x12>;
+
+	mdio {
+		/delete-node/ ethernet-phy@1;
+
+		yt8521s: ethernet-phy@3 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <3>;
+
+			motorcomm,clk-out-frequency-hz = <125000000>;
+			motorcomm,keep-pll-enabled;
+			motorcomm,auto-sleep-disabled;
+
+			pinctrl-0 = <&eth_phy_reset_pin>;
+			pinctrl-names = "default";
+			reset-assert-us = <10000>;
+			reset-deassert-us = <50000>;
+			reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
-- 
2.40.0

