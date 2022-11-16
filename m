Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9398462C972
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiKPUCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbiKPUC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:02:26 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC9A63CCD;
        Wed, 16 Nov 2022 12:02:25 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id h14so17496154pjv.4;
        Wed, 16 Nov 2022 12:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWHeg8M1ItPKLADHrX13a52utCw4BMmhpRsIIQk2Fck=;
        b=XMsHoBVwkTCzyxRUnxAnS4OFKDbb1cNra2uUSHWdYCfwL9DGCbnSB80aMn0s2RiSv/
         dzgPX4ZLZz7WWLKdqaz/iMX3PYvnXcUaA+GfcKYixqUqO1KRF6V8B041ZZiWqWvWJyRs
         KjxLQ3Vfcjq7dCBSBret8vz3d2bVmpMplOdSDnlrtGBX7rhcfTReRFbwKa2w6z8qipXe
         oNNaCNmgrlR5CcasYxh5HGGqk8bm9yBmpMm224JG/biPZESuByYdmSlCtPPPHnZAyWmS
         e1T9vGJOgXrxPr/+rnxsgCAuWmUYP8EJHeiZxmeC2YJN+4J1NmjeQn3fX8/s2XEpeBfr
         XUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWHeg8M1ItPKLADHrX13a52utCw4BMmhpRsIIQk2Fck=;
        b=3hOI/UAI3J1wm7eT9Os5Rt41CTr8EFUFEq1glQefAxWBEauWPfZ3SpzWWqka+mxKDC
         sG1yqUog2c/9oQzIHvRoOOJbsGaBWruiv3AJVzeeQ2YBSVun2UR7AzKkJVR15HIscJbM
         goJvJyFzbXPUoXOn9jukw+41s0rYcID3Kf9Rgb1JiX7nNrxiGid4Vdph3SXgtvdNG+lD
         Pw9WrYBlMqEEc65ZEGTwYbFfvvArTc/fPCjdSJoakt21rNlgreIj+1K4+teghIg1J5E+
         nILY/Zy/lkUO0Ab6oNCS/IWo9lODyBa0lNVlcz4gBEUGIBsudFneUZN4tO5WhEV1ysKf
         ukDw==
X-Gm-Message-State: ANoB5pmxxK3fN69fihBZA9FVCeSvZe+jNt9eb1kw24yqv8mpVRxrmkSG
        D90zhmxccK80uHv15bIZUx1AIyfAwhn9Pg==
X-Google-Smtp-Source: AA0mqf5WKCdpBqS0le2On+nkdH9MkMJqW/Gj1R/YMS4+BiCNzeC5zLTPe4lkmEF8PNdG2C5SYXspFg==
X-Received: by 2002:a17:902:c94f:b0:188:712f:dfa5 with SMTP id i15-20020a170902c94f00b00188712fdfa5mr10049999pla.140.1668628945118;
        Wed, 16 Nov 2022 12:02:25 -0800 (PST)
Received: from localhost.localdomain ([103.51.72.182])
        by smtp.gmail.com with ESMTPSA id s18-20020a170903215200b00186a6b6350esm12423950ple.268.2022.11.16.12.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:02:24 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [linux-next-v2 1/5] arm64: dts: rockchip: Fix gmac phy mode to rgmii on Rock 3A SBC.
Date:   Wed, 16 Nov 2022 20:01:43 +0000
Message-Id: <20221116200150.4657-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116200150.4657-1-linux.amoon@gmail.com>
References: <20221116200150.4657-1-linux.amoon@gmail.com>
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

On rk356x ethernet phy support reduced media independent interface (RMII)
and reduced gigabit media independent interface (RGMII).
So set the phy mode to rgmii to support clock delay, also
add TX and RX delay for phy-mode.

Fix following warning

[    7.365215] rk_gmac-dwmac fe010000.ethernet: Can not read property: tx_delay.
[    7.365219] rk_gmac-dwmac fe010000.ethernet: set tx_delay to 0x30
[    7.365224] rk_gmac-dwmac fe010000.ethernet: Can not read property: rx_delay.
[    7.365228] rk_gmac-dwmac fe010000.ethernet: set rx_delay to 0x10

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V2: Fix commit message and added the RX and TX clock delay.
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index ea74ba32fbbd..e1c75532dcee 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -253,13 +253,16 @@ &gmac1 {
 	assigned-clock-rates = <0>, <125000000>;
 	clock_in_out = "output";
 	phy-handle = <&rgmii_phy1>;
-	phy-mode = "rgmii-id";
+	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac1m1_miim
 		     &gmac1m1_tx_bus2
 		     &gmac1m1_rx_bus2
 		     &gmac1m1_rgmii_clk
 		     &gmac1m1_rgmii_bus>;
+
+	tx_delay = <0x4f>;
+	rx_delay = <0x26>;
 	status = "okay";
 };
 
-- 
2.38.1

