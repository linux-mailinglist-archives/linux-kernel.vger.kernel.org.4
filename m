Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB70A6C8C42
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjCYHkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCYHka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:40:30 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9752196B1;
        Sat, 25 Mar 2023 00:40:29 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id cf7so4859356ybb.5;
        Sat, 25 Mar 2023 00:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679730029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOjM89dV+f1cFPNk0j8IHVhvMB89HUV+FlvJghSUjlQ=;
        b=gfRyBqIuHNtuwisQ4ZSxroEKvFZoJbr3nas9/f7xD74gwOPMMD6Xvf204czxNB20Xv
         Tja2SvkYzR002rDfUvE94qoNlZHiXFXwhvWjfEq+GhEuMMGjF4F9zkWCFPK4Teyia7Z+
         xOSa9ujsTkL0zAKj2i1lrWLeyD9Ai6nCsXHH85j3FdQXMah0lY45iFdRdSjxnyy69Jkm
         fUN2TTiJnCLmnzIeSbGwPZHJdlbsbllJNDqH5zRL0ID4Oq690uz2L6vt/VNOB+cvvXei
         SoM3x1UgGz8/2F7+Ju8oj1P+zfqELz43wzXZEHCUwjPsGp9cDqJM811Nx48yUNtbStrd
         yV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679730029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOjM89dV+f1cFPNk0j8IHVhvMB89HUV+FlvJghSUjlQ=;
        b=WqewBGeZG1ETQWbY95QQhv4u5Wln/S/gDRDSBPYJnS5lvxiRusp2G5KZ9diPFuP4o3
         UdooDenigOFJVbyt8xp6XYpnytiH+Ej4NDA9YFOGXTz0GB8p4G1BKTn1la7Fe/z76AMf
         3Z4cZOJjCW5LfVO89LC2Pw6pi0aoIJjAiS9oWxDOOqsn2ZViztBAEgGDGGnV2Tpo8uIx
         VVyY3IktmFe2BIyZwMYNH2+66erF7DJ7Rpi7lC98elWy513uHSe8Vp811+RUJV2uWOmy
         B1v0FovEfo3rXFZoRdQcpOplmOMMDZSjCRApoUiYTeFmk2cQFuqVkDMXC9BRchjLaRV2
         gAYw==
X-Gm-Message-State: AAQBX9cfcjHNTgESbOsYdwnSpAvCxRQxHkg/fhT1ohafq4ebB5eGppGQ
        0niMj5OFb1dwF/8g6HaZVRo=
X-Google-Smtp-Source: AKy350bKgQHX0o/LdQ5YecW3frRWq3nWQ5rIjUiyBiF+dynqiC4j/ODd0gT0jo7b766gNsbVe/fwHQ==
X-Received: by 2002:a05:6902:154f:b0:b72:571d:f6cc with SMTP id r15-20020a056902154f00b00b72571df6ccmr926484ybu.4.1679730028858;
        Sat, 25 Mar 2023 00:40:28 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id w20-20020a25c714000000b00b7767ca7498sm969629ybe.53.2023.03.25.00.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:40:28 -0700 (PDT)
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
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Vincent Legoll <vincent.legoll@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] arm64: dts: rockchip: Add FriendlyARM NanoPi R2C
Date:   Sat, 25 Mar 2023 15:40:20 +0800
Message-Id: <20230325074022.9818-3-cnsztl@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230325074022.9818-1-cnsztl@gmail.com>
References: <20230325074022.9818-1-cnsztl@gmail.com>
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

