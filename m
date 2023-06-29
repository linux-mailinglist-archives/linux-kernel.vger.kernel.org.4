Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012A2742CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjF2TBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjF2TAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:00:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6001BC5;
        Thu, 29 Jun 2023 12:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E11D61600;
        Thu, 29 Jun 2023 19:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48189C433CD;
        Thu, 29 Jun 2023 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065252;
        bh=n92uXP+PR/COY4F3gJ0g8WAUwUX5F+Y/b2NSPmdSlXQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Kuell7LR0mKWbfDnk1iJF+KEH9bG32N27meAAYldti4m5cq09h6ObpdrahepUuh+I
         NnzMX5hweB+tyQ/Sm51QaOt2ahdjflfL9PcrzlKyMxMgY79TsTlBA+tNidaIlpOHCQ
         IMkNH9cX90iimgvkxIThTLTdFg8x6H0F9AgJMUEv7pqEgtEpxrWuYOzhm5f4BfHmF6
         /EuPECozJuegVBlZBeDaCk2S7R0LrilgYWIvyPpbIpDQO8fd42oYWzZhVtbOmPnrQ6
         pfsVSQipO/GzKADbpYhmdDkkpRepQgsynuFWeforItfVGTLVg7TasXRn40F+YQR8Ta
         miPCh55rT1/JA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lorenz Brun <lorenz@brun.one>,
        Diederik de Haas <didi.debian@cknow.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 01/17] arm64: dts: rockchip: fix USB regulator on ROCK64
Date:   Thu, 29 Jun 2023 15:00:30 -0400
Message-Id: <20230629190049.907558-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenz Brun <lorenz@brun.one>

[ Upstream commit 03633c4ef1fb5ee119296dfe0c411656a9b5e04f ]

Currently the ROCK64 device tree specifies two regulators, vcc_host_5v
and vcc_host1_5v for USB VBUS on the device. Both of those are however
specified with RK_PA2 as the GPIO enabling them, causing the following
error when booting:

  rockchip-pinctrl pinctrl: pin gpio0-2 already requested by vcc-host-5v-regulator; cannot claim for vcc-host1-5v-regulator
  rockchip-pinctrl pinctrl: pin-2 (vcc-host1-5v-regulator) status -22
  rockchip-pinctrl pinctrl: could not request pin 2 (gpio0-2) from group usb20-host-drv  on device rockchip-pinctrl
  reg-fixed-voltage vcc-host1-5v-regulator: Error applying setting, reverse things back

Looking at the schematic, there are in fact three USB regulators,
vcc_host_5v, vcc_host1_5v and vcc_otg_v5. But the enable signal for all
three is driven by Q2604 which is in turn driven by GPIO_A2/PA2.

Since these three regulators are not controllable separately, I removed
the second one which was causing the error and added labels for all
rails to the single regulator.

Signed-off-by: Lorenz Brun <lorenz@brun.one>
Tested-by: Diederik de Haas <didi.debian@cknow.org>
Link: https://lore.kernel.org/r/20230421213841.3079632-1-lorenz@brun.one
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index f69a38f42d2d5..0a27fa5271f57 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -37,7 +37,8 @@ vcc_sd: sdmmc-regulator {
 		vin-supply = <&vcc_io>;
 	};
 
-	vcc_host_5v: vcc-host-5v-regulator {
+	/* Common enable line for all of the rails mentioned in the labels */
+	vcc_host_5v: vcc_host1_5v: vcc_otg_5v: vcc-host-5v-regulator {
 		compatible = "regulator-fixed";
 		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -48,17 +49,6 @@ vcc_host_5v: vcc-host-5v-regulator {
 		vin-supply = <&vcc_sys>;
 	};
 
-	vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
-		compatible = "regulator-fixed";
-		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&usb20_host_drv>;
-		regulator-name = "vcc_host1_5v";
-		regulator-always-on;
-		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
-	};
-
 	vcc_sys: vcc-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
-- 
2.39.2

