Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6D662571D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbiKKJn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiKKJnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:43:15 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05820654E3;
        Fri, 11 Nov 2022 01:43:15 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso4288567pjc.2;
        Fri, 11 Nov 2022 01:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJCmo94b1oJ9vc0/hCwgxQah+/q6uvuZ9wtDIOuRZ/A=;
        b=ni+fvzQCq6/9nD9W/JZrMrtM1lUktOy/aSft4Q/Qsd7BxmT4A8kPvgtrhKu98w1874
         UtqN7jPJsOq3PvlCK0/lRnM7/uVZSHteJHOGoCXQjHHxHpWaA1dbUUFih+Tezat7JNfT
         vVJG8qnHkHxRDrSl8eR8NZRuM7cDPOP8a8po/S/tJJzumvc7bH07zbUHr+G+Fo/kWLHj
         Sl3EiIknP5T+14bdwNEhYANFgwRt9feWSrUl8SYLrXclVhmG7lJP5oZTXdEV/VnBfEmL
         O4Rb3ynKqxPSqp4KOXIu83Hbqo2zMc65IntCrcs+tg8ZXTVZLBAij84n36zYIRKLUSTB
         DJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJCmo94b1oJ9vc0/hCwgxQah+/q6uvuZ9wtDIOuRZ/A=;
        b=WbCB/IboFJ0Qge4RL7GmejPuHZHXWU+TUeLZ8qnU19rv2my3YSnlrjeBJdzYFUMW2x
         1M99RwWoxz+VuAMFdJzGIxVMgIoXGMpwJj7tMlBbDyQFnvF533Q4E7D9yA7MZ3Wbqz4B
         MjMW6txG1oxcsfztlKmZJf6CrqHmY5ZOb23FQ+QMxUOQfWfAazV51hn17eLoeGiNygHi
         xmxazNBhCSApLmvAJ+QmQ9JwMaDbeiRF4Djt8cEAy96+4h68+q/PDn0aCeAkvSejd7od
         R11blnETN0SdzELDtVkXWHMeF3NUCnZldvCKPDnH9STEbl12iti6MeoUJ21NJIPUBzD/
         Bznw==
X-Gm-Message-State: ANoB5pmrOyZTaTpag6rPAXBJLprP/lSwkQ5Fw5a+CZXLO5dTVcYKHIj0
        /gCFicW0y46LsrKAbl4WRRI=
X-Google-Smtp-Source: AA0mqf5H/u8fFcWTrP/MrfNUDIYjFsgnm/vxcngxEwxttD5qYOnMHkpF+EpdyRJEPUbDKSiCmNZwnw==
X-Received: by 2002:a17:90b:2710:b0:20d:48bc:6666 with SMTP id px16-20020a17090b271000b0020d48bc6666mr1053055pjb.98.1668159794615;
        Fri, 11 Nov 2022 01:43:14 -0800 (PST)
Received: from localhost.localdomain ([103.51.72.74])
        by smtp.gmail.com with ESMTPSA id fa13-20020a17090af0cd00b002086ac07041sm1188450pjb.44.2022.11.11.01.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 01:43:14 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [linux-next-v1 3/3] arm64: dts: rockchip: Fix ethernet reset node Rock 3A sbc
Date:   Fri, 11 Nov 2022 09:42:35 +0000
Message-Id: <20221111094238.1640-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111094238.1640-1-linux.amoon@gmail.com>
References: <20221111094238.1640-1-linux.amoon@gmail.com>
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

Add support for snps,reset-gpio reset ethernet gpio pins and
drop the mdio reset code.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 16fff1ada195..9172cf60b867 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -258,6 +258,11 @@ &gmac1 {
 	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
 	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&gmac1_clkin>;
 	clock_in_out = "input";
+	snps,reset-gpio = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	/* Reset time is 20ms, 100ms for rtl8211f */
+	snps,reset-delays-us = <0 20000 100000>;
+	phy-supply = <&vcc_3v3>;
 	phy-handle = <&rgmii_phy1>;
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
@@ -267,6 +272,9 @@ &gmac1m1_rx_bus2
 		     &gmac1m1_rgmii_clk
 		     &gmac1m1_clkinout
 		     &gmac1m1_rgmii_bus>;
+
+	tx_delay = <0x4f>;
+	rx_delay = <0x26>;
 	status = "okay";
 };
 
@@ -583,11 +591,6 @@ &mdio1 {
 	rgmii_phy1: ethernet-phy@0 {
 		compatible = "ethernet-phy-ieee802.3-c22";
 		reg = <0x0>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&eth_phy_rst>;
-		reset-assert-us = <20000>;
-		reset-deassert-us = <100000>;
-		reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
 	};
 };
 
@@ -625,12 +628,6 @@ vcc_mipi_en: vcc_mipi_en {
 		};
 	};
 
-	ethernet {
-		eth_phy_rst: eth_phy_rst {
-			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
 	hym8563 {
 		hym8563_int: hym8563-int {
 			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
-- 
2.38.1

