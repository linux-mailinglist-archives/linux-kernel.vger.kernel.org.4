Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF8D70178A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 15:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbjEMNxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 09:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbjEMNxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 09:53:14 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014AF2716;
        Sat, 13 May 2023 06:53:13 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7665e607d1bso257402539f.3;
        Sat, 13 May 2023 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683985992; x=1686577992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lF7mehPLMjL5OZaTFQl/kMEkbCLZtsVwkKNA6vrL8JU=;
        b=qdGJFPg3NqSXLFka5rKK/RMrMKXbnVsr6NcR/ogSxw0jAlCZphr2Unb6lEe90wFA1W
         tDMARM+47esPReYF2YBFh/HYNDv0WGGv03pwazRusaKGWzo18AFyuhbgWiP0biaYoxmi
         bcNwUQT/ojxu8lB31R0vKlSO2SYxKGYK9nDqHhkC8eBm1KVzmLxW2VJRxgAxc+mukg8T
         zEetRvkJV6sBX8I54INuTsTcxr/QiKJbxyf/5G3jXawxypAiLZegaLwVu5F6mMxfaIOb
         VhOP3K9WdK/yuaxkTyLVApLY0DurPI+lv4Gpdcs6AYvEgr0dJyyv+vKl59c509XlRNHQ
         HLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683985992; x=1686577992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lF7mehPLMjL5OZaTFQl/kMEkbCLZtsVwkKNA6vrL8JU=;
        b=IcXCXKlih2On3WoUSP3RBG77WwYxi+7Jbyq5ufZMgYrzu+furjEb9V85rpQAnYwZ9w
         Cj5/D1+aG0CYRUOFIlFjJXg0rrxUBGEKHoh10NMrPbTiHVJsq6Waj6Fz/zNW0UIwcrZ+
         kdJK+dE/QG+Z3t9hQvgFsTySnxcHsS9IAmxKpmein3ji2Na9dGWGVwdKoZGnNAt7wVu8
         7/rwM5NI5a4D9o4shByPD+LLDiTBg3TP1H2DG+slzLUsWdGCkNPSCACuo2t51C8J2Dhy
         qFxTlnu2ECe+EkK6brTNAgYB7vRvlDDYqEGb5+Bmr4JKgdurz0LM/Atq3D+cIHpbOO4Q
         SjFg==
X-Gm-Message-State: AC+VfDxsXppxszdOfVv/i3+QxscIHz5nIxlX+98jb7UsxRc5JPXqRrZz
        hpAK01E7s1AbuWzkSWbi2Uk=
X-Google-Smtp-Source: ACHHUZ4HZsAhYDfynS5QZJctHJUQqMaoi49L+tG8f5On4iw+OxKku9r5jwtrTtqY0PA69aRAQhUUtg==
X-Received: by 2002:a6b:3c05:0:b0:760:ee29:5103 with SMTP id k5-20020a6b3c05000000b00760ee295103mr17995767iob.15.1683985992258;
        Sat, 13 May 2023 06:53:12 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id r15-20020a6bd90f000000b0076ca45ebfc4sm1104991ioc.14.2023.05.13.06.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 06:53:11 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Tianling Shen <cnsztl@gmail.com>, Andy Yan <andyshrk@163.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: rockchip: Add FriendlyARM NanoPi R2C Plus
Date:   Sat, 13 May 2023 21:53:07 +0800
Message-Id: <20230513135307.26554-2-cnsztl@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230513135307.26554-1-cnsztl@gmail.com>
References: <20230513135307.26554-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NanoPi R2C Plus is a small variant of NanoPi R2C with a on-board
eMMC flash (8G) included.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---

no changes in v2

---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../dts/rockchip/rk3328-nanopi-r2c-plus.dts   | 33 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 1cf105d7407f..794da4d41f14 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go3.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-a1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2c.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2c-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-orangepi-r1-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-orangepi-r1-plus-lts.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dts
new file mode 100644
index 000000000000..16a1958e4572
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dts
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2021 FriendlyElec Computer Tech. Co., Ltd.
+ * (http://www.friendlyarm.com)
+ *
+ * Copyright (c) 2023 Tianling Shen <cnsztl@gmail.com>
+ */
+
+/dts-v1/;
+#include "rk3328-nanopi-r2c.dts"
+
+/ {
+	model = "FriendlyElec NanoPi R2C Plus";
+	compatible = "friendlyarm,nanopi-r2c-plus", "rockchip,rk3328";
+
+	aliases {
+		mmc1 = &emmc;
+	};
+};
+
+&emmc {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	max-frequency = <150000000>;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
+	vmmc-supply = <&vcc_io_33>;
+	vqmmc-supply = <&vcc18_emmc>;
+	status = "okay";
+};
-- 
2.40.1

