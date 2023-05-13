Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6357014E1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 08:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjEMGxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 02:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjEMGw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 02:52:56 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5606E3582;
        Fri, 12 May 2023 23:52:55 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3352b8b9b70so72169215ab.0;
        Fri, 12 May 2023 23:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683960774; x=1686552774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7poAuU7GKF0H6xZoqZuq9nRfOuiUUzrRo0xSPUQing=;
        b=oRWdBwiiuzQZBr++kNKA0PLswR7yMuniAq5pZ86Jgtofh2NxHmeIMG7Q6FhkV6XNHY
         cYpQw0/li2FbXi+PBJuLPMsDuVqb8Z0bY8WW/F8nTwXKSb4nZHI+jGTyOsbjwFR0Mfck
         LFNFf11ICiwcXQ5harywfirXFmZDjKICKZKhVIKbpr5gRcgnZqp5XjlCmTfViAh1TJBQ
         qU/2UsLEK9bG4NsazlJBnN/OnZPHisoDcp1s8QzqNSqdc6hylN17qX4Fc4pXCL7KOi2q
         vyaI6g/zOkHKULAp+fE1BY5JfouEyjPN7FWzfoDsBMLAHZc7RN0fEtWPeh8vx2qX/mu4
         ZfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683960774; x=1686552774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7poAuU7GKF0H6xZoqZuq9nRfOuiUUzrRo0xSPUQing=;
        b=MbheM4a39YFfrzOihxfcmNtSEJqpsIIEGHFnLi+KuucOR+ULERDTwzhwWnedvXbEeG
         l6rWh3DrWKPAhI5PLzFbTLWHp8F4sQrq9vZmjHysWfmMXdRramLSuUOUzbWc80VynvoU
         hHhE4pPmw/ZYow4RBCbOzx75WM6SxMIgIt14hHu8nfCitNLNSxs1xPX3AKjNJdD8rv7g
         kkOiTde2BGQG1gZibcWarqrZEaKpmnxA4ybfEHjSfbjkWyLkQQ3ckRIxS+wKnUQOzlRB
         pTBJMVPNiSx58xt0glkv5OKhOpoQ3viKHgJc5ptfsF+tPwuul105J61KJR/abKl6US4R
         eAjA==
X-Gm-Message-State: AC+VfDws07NGBakQNkWEu7q7IDeqJXvdq4NU8WPoA5GsvI9ZcwMdZKx+
        cYlTjrN8NfU4WQsks0JF2cQ=
X-Google-Smtp-Source: ACHHUZ4lwkOgllV3HPGClc8F8+9ZRw24JpvcLCsqOEOaT1Qp5jmbDGnLn0Z5Ol3nXl/ErNvpPqZyyg==
X-Received: by 2002:a6b:f40d:0:b0:74c:89c4:8e03 with SMTP id i13-20020a6bf40d000000b0074c89c48e03mr15369532iog.10.1683960774537;
        Fri, 12 May 2023 23:52:54 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id a11-20020a5d980b000000b007697fe48ca8sm5371396iol.47.2023.05.12.23.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 23:52:54 -0700 (PDT)
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
Subject: [PATCH 2/2] arm64: dts: rockchip: Add FriendlyARM NanoPi R2C Plus
Date:   Sat, 13 May 2023 14:52:28 +0800
Message-Id: <20230513065228.25971-2-cnsztl@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230513065228.25971-1-cnsztl@gmail.com>
References: <20230513065228.25971-1-cnsztl@gmail.com>
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

