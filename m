Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BAC6C6892
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjCWMib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjCWMiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:38:19 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702F426C0E;
        Thu, 23 Mar 2023 05:38:18 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id bl9so3424863iob.8;
        Thu, 23 Mar 2023 05:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679575098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ENFbyVo6ntDOx+QsNQdjIvn/5kMh1BsTEjEJ3xCsmA=;
        b=gusgrPJ5tIfDMajJ9dD9H6OPD/k85/TF8VNdLZ9CSn3HKJpS2UHnT3ndA7cbj+z6Yg
         D/R40cVIC2EW/UvTz2uoeTG1q5tQ7He0Sa5cBtLuM8D8+WVssapgIT7mQoII1OtfGpwR
         snxu1+TuXy9KzPh/yCKcn/TeveiTxMy5FeJZRNq4D9g5xtgy3pY/tqGRudkE6gwk6xyI
         rOvm5US8DecYxfAy1fMcGGi/4jlTz5o4L5zY1NcmQFbitFu8GUddM11TA4qjwYCMOqFR
         QtuzEBQyQ+D72cmqVTT3+3ibT57+GI4ckVz1KExeq6c7ieHBg34I5oZi45YYlJjV4zmm
         vVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679575098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ENFbyVo6ntDOx+QsNQdjIvn/5kMh1BsTEjEJ3xCsmA=;
        b=Q4nVv4rX55XbzOQwKIADf5uyprbHxsMXKVYOjMEHvBKol4VrAmL9fYXiQy3AZLTUWm
         FmhnWY6DPlDSnNOH4S21l0ejNE7EMrkxuau6fru1j3sGCs44BhbE8lptbWD1RhPR7p7B
         ENLFyTYkADVuO5pAJnh6Bgyb2ZsD1st3tNYSo2OjpTA+F7AhiCcvRMo2AKPa0FuXC49f
         Nz+XqXcLtHQpgfu8bPbZiLM++dWsKfvxeaJHckKScrk6WuOcZ4z3heC9XFDpjG3Sz+Oh
         A8s/9KoWvmF4SfURHc4yEhpwk5ipQ8iCMVTbI6qOdrBzi+rjFX5nYyYbV3sWZlPjcb8A
         KFCg==
X-Gm-Message-State: AO0yUKUaM5L17XrFFODSmGUYj2GruTWJKb5NFxHbwfN8mir9IH1+bNhC
        HcDfXYQXMZiKUVONYuSEdhg=
X-Google-Smtp-Source: AK7set+IaJfYgWqqcuRAkH2Km+qXS+Iwzem0q/SeHq8SA0lVnfafOdrDz9WP8FLjnAaL1C8mue4bQA==
X-Received: by 2002:a5e:9705:0:b0:758:a91a:aa82 with SMTP id w5-20020a5e9705000000b00758a91aaa82mr3711730ioj.11.1679575097662;
        Thu, 23 Mar 2023 05:38:17 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id n11-20020a6bed0b000000b00758993500f3sm1307608iog.7.2023.03.23.05.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:38:17 -0700 (PDT)
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
Subject: [PATCH 4/4] arm64: dts: rockchip: Add Xunlong OrangePi R1 Plus LTS
Date:   Thu, 23 Mar 2023 20:38:07 +0800
Message-Id: <20230323123807.11882-5-cnsztl@gmail.com>
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

The OrangePi R1 Plus LTS is a minor variant of OrangePi R1 Plus with
the on-board NIC chip changed from rtl8211e to yt8531c, and otherwise
identical to OrangePi R1 Plus.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../rockchip/rk3328-orangepi-r1-plus-lts.dts  | 40 +++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 0bdcddd221f8..2d585bbb8f3a 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -17,6 +17,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-orangepi-r1-plus.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-orangepi-r1-plus-lts.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock64.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock-pi-e.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-roc-cc.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
new file mode 100644
index 000000000000..5d7d567283e5
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2016 Xunlong Software. Co., Ltd.
+ * (http://www.orangepi.org)
+ *
+ * Copyright (c) 2021-2023 Tianling Shen <cnsztl@gmail.com>
+ */
+
+/dts-v1/;
+#include "rk3328-orangepi-r1-plus.dts"
+
+/ {
+	model = "Xunlong Orange Pi R1 Plus LTS";
+	compatible = "xunlong,orangepi-r1-plus-lts", "rockchip,rk3328";
+};
+
+&gmac2io {
+	phy-handle = <&yt8531c>;
+	tx_delay = <0x19>;
+	rx_delay = <0x05>;
+
+	mdio {
+		/delete-node/ ethernet-phy@1;
+
+		yt8531c: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+
+			motorcomm,clk-out-frequency-hz = <125000000>;
+			motorcomm,keep-pll-enabled;
+			motorcomm,auto-sleep-disabled;
+
+			pinctrl-0 = <&eth_phy_reset_pin>;
+			pinctrl-names = "default";
+			reset-assert-us = <15000>;
+			reset-deassert-us = <50000>;
+			reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
-- 
2.40.0

