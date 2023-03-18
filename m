Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CB36BF910
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjCRIiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCRIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:38:07 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BDFA76B9;
        Sat, 18 Mar 2023 01:37:55 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id t129so3320557iof.12;
        Sat, 18 Mar 2023 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679128675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNoijDRMgUGYwTQk51CaDMUDN+KxP0US29mL2A3xBvU=;
        b=XTd+RyshUmyQzK+GnEwmpUB715Q/+3GD23ggNEgdM5AKgUpdjYarNFzxu9QoNs6kzo
         c5SK6Z6HppnvKdG+F/p9r8mnwjwrG+cYW5WCCzZlpE/JXOhG3hTIJpoIkxSInNAwFDrz
         qDcat2SpDionvPdmU8bs5kCZ6toWpdy2RpG2OQzIj8AQQ2mPqZAxVTpHlxM6HEJ0VeCo
         U37Rzqd+NIRKwU1xKTrpavEfatzJ3G3M/79vIFsRLEmzuOFd3Vm1ZY2ypeliN9Wqb0K1
         rUi33j62o5uVD3rklysBoByRHWpvkTLzr6n6cOScqkdOaZBMkq0lk6p2inVfSxDZHpbI
         dxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679128675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNoijDRMgUGYwTQk51CaDMUDN+KxP0US29mL2A3xBvU=;
        b=QlfjEOvQrZzcz58NiZNBHa5vgDZryyKBfz0XZl4NMRuHHUknm68K49RYID0h8Qjw+V
         kUm/j98z2eq1/k1g0n+Niw91yzn1IJWs90J9AgUb+VSYx4XlbDf+26rb+uoVwjchHjLl
         NGCz/HXYcZI/X9Pti/4x1Tqltez70Tf5ooxaUiyArdGdAMgQiiEm7vUI5n6Um4CIaQpP
         GnSXSxaLoLrG4HGHXdLRvPsYazQyMw7PSXS390vyistkopHVZ5fLIqUmekkAbL8EY6IM
         NByjNg6mlloan244Z/yHlgkz+arki1NHtxPOc6oss/uvtCAZ9C6QuuYTI31+MhuMWQJL
         Da5w==
X-Gm-Message-State: AO0yUKVNaK7lQRHduLBpJSbIkxUXH5ozGljTz+fm7ZL5mmZNLShyqzRt
        EQe1tqSlqzJGgx5x3+TKmXI=
X-Google-Smtp-Source: AK7set/F1NtDVyHhOFJmWG7a1TB0Kfgk5Zwx3vOBh5pVh+W0ztTzXaMExGrUCfnxshiOj0n9goy+6g==
X-Received: by 2002:a6b:7e4d:0:b0:74c:97ee:4e56 with SMTP id k13-20020a6b7e4d000000b0074c97ee4e56mr958857ioq.3.1679128674694;
        Sat, 18 Mar 2023 01:37:54 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id h8-20020a6b7a08000000b00746041ecbf9sm1174834iom.39.2023.03.18.01.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 01:37:54 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] arm64: dts: rockchip: fix gmac support for NanoPi R5S
Date:   Sat, 18 Mar 2023 16:37:44 +0800
Message-Id: <20230318083745.6181-5-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230318083745.6181-1-cnsztl@gmail.com>
References: <20230318083745.6181-1-cnsztl@gmail.com>
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

- Changed phy-mode to rgmii.

- Fixed pull type in pinctrl for gmac0.

- Removed duplicate properties in mdio node.
  These properties are defined in the gmac0 node already.

Fixes: c6629b9a6738 ("arm64: dts: rockchip: Add FriendlyElec Nanopi R5S")

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
index e9adf5e66529..2a1118f15c29 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
@@ -57,7 +57,7 @@ &gmac0 {
 	assigned-clock-rates = <0>, <125000000>;
 	clock_in_out = "output";
 	phy-handle = <&rgmii_phy0>;
-	phy-mode = "rgmii-id";
+	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac0_miim
 		     &gmac0_tx_bus2
@@ -79,9 +79,6 @@ rgmii_phy0: ethernet-phy@1 {
 		reg = <1>;
 		pinctrl-0 = <&eth_phy0_reset_pin>;
 		pinctrl-names = "default";
-		reset-assert-us = <10000>;
-		reset-deassert-us = <50000>;
-		reset-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
 	};
 };
 
@@ -115,7 +112,7 @@ &pcie3x2 {
 &pinctrl {
 	gmac0 {
 		eth_phy0_reset_pin: eth-phy0-reset-pin {
-			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;
+			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
-- 
2.40.0

