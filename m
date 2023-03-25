Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073C06C8C46
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjCYHkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjCYHke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:40:34 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F88619C49;
        Sat, 25 Mar 2023 00:40:32 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i7so4899155ybt.0;
        Sat, 25 Mar 2023 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679730031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ENFbyVo6ntDOx+QsNQdjIvn/5kMh1BsTEjEJ3xCsmA=;
        b=ex/GczeP++ovZupQ3HqNy/MkN7HsVMa286tPtX0GrLD7Ds+ia9eNEyltaSDKqsF86P
         87Tt9nc5bAbOzPuKG92VXQn+8gjjA2190hqm/GCuUFHhNkRQjVhsizRW8UPrd30ny8Vr
         pZ0xmsT4Iv3P7V8hAs05kwy9TcvXx0FSBoDfRS4mWyql1+IBUZ8BotngWsujRK22k5o+
         6r9XTenmqUx3Lhnw6k/+rQAPVEKlHZLj2IsSduDihxy1/FMwJAI0cttfKGxGzjyUuSy/
         2Ma0KXEjnLCbm8/SBDSIl5e98ksZ8M4Qr6J9c6GbcZF1rhOr6q3H/oDaNxiopgVf7pYS
         8vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679730031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ENFbyVo6ntDOx+QsNQdjIvn/5kMh1BsTEjEJ3xCsmA=;
        b=NXYZ+UGXTLJ1cx5i4vboO1XcTdH5Rz6H4DocaNO51zSsAPkwZ07fSsGVX3TeEJHgO5
         Cz+YlsYPO97XwteuhgsQpFabr5bVQg5si4zxVVVY5YBCVk9kOsxIMmJj8jtWClCkkdOc
         8BMoedtOtKA8pawMRQbVdLiDSKDQH4TF5zYM1FsgJjBYvohHjp2pl0E5A/LJba6SEGlG
         3PEnAqr+2uDZVF/rEWZDiQJ7IYbt0if6n024VspPgLBnlFd13v4xrPa4+6bAgaT1gK/7
         lH5C333oSIKKzwcRyVMFbcQxIo1mUxCXfPNVt26aQ8d9US6LV49TCDA5szBHE3QFmMRY
         zMIg==
X-Gm-Message-State: AAQBX9eNtgDXdN6u5Z2t2aVGjeVTnkBffQEnN6mCCIA8n+jON+V8LvjM
        ehsYrm9OllNM6lrZTIJh5zM=
X-Google-Smtp-Source: AKy350aV8Slwn420heuYfAiUsnb7FYpKpCpimHVxcbyjyQTUtydCvA9ErH1v7wPW9p19HECCceqFgg==
X-Received: by 2002:a05:6902:1108:b0:aee:c71c:1845 with SMTP id o8-20020a056902110800b00aeec71c1845mr6924755ybu.19.1679730031503;
        Sat, 25 Mar 2023 00:40:31 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id w20-20020a25c714000000b00b7767ca7498sm969629ybe.53.2023.03.25.00.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:40:31 -0700 (PDT)
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
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Add Xunlong OrangePi R1 Plus LTS
Date:   Sat, 25 Mar 2023 15:40:22 +0800
Message-Id: <20230325074022.9818-5-cnsztl@gmail.com>
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

