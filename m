Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39872658C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 12:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiL2LwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 06:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiL2LwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 06:52:07 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F2DE13EB1;
        Thu, 29 Dec 2022 03:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FPYog
        8VHYYQIw1Wnto4/o37NSMT3g91TZKJFzlnQXlk=; b=RAh3u5B4aDWz+BfCZmF3x
        c2SaDfVJXm2uKTMrfznYfe9KA/SzbG24xtC4wTV78oE76YLbyvo+L2C4h9CGCmU7
        7YPI5aY9BMvJ/euMAVGlAdqF9vi4cJM2PNntZdSA06assDrh/L6CyILziOMEE2m3
        OrfgQC9GkqZkPgDoDZKPTA=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wCX5SUxf61jRl5hAA--.5754S2;
        Thu, 29 Dec 2022 19:51:16 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        piotr.oniszczuk@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 2/2] arm64: dts: rockchip: Enable wifi module AP6398s for rk3566 box demo
Date:   Thu, 29 Dec 2022 19:51:11 +0800
Message-Id: <20221229115111.3899793-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229115043.3899733-1-andyshrk@163.co>
References: <20221229115043.3899733-1-andyshrk@163.co>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCX5SUxf61jRl5hAA--.5754S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF15XF15Gw45JF4kXF1DZFb_yoW8Aw1xp3
        sxCrZYgr1kCr1jganxJwn5Xrn5Kw4kta1qkwn7u3WfJr1I9a1DGF1Uurn5AF15WF48Xa1Y
        9rs8Aa4agrsFqw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_wZ2hUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbivBnmXmASagkixwAAsp
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a AP6398s wifi/bt module on this board.
Fix the sdmmc1 dt node to make wifi work.

Fixes: 2e0537b16b25 ("arm64: dts: rockchip: Add dts for rockchip rk3566 box demo board")

Signed-off-by: Andy Yan <andyshrk@163.com>
---

Changes in v2:
- add vmmc/vqmmc supply back.

 .../boot/dts/rockchip/rk3566-box-demo.dts     | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
index d956496d5221..2671f207cfd1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
@@ -324,8 +324,12 @@ wifi_enable_h: wifi-enable-h {
 			rockchip,pins = <2 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
+		wifi_host_wake_h: wifi-host-wake-l {
+			rockchip,pins = <2 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
 		wifi_32k: wifi-32k {
-			rockchip,pins = <0 RK_PB0 2 &pcfg_pull_none>;
+			rockchip,pins = <2 RK_PC6 1 &pcfg_pull_none>;
 		};
 	};
 
@@ -391,9 +395,15 @@ &sdmmc0 {
 };
 
 &sdmmc1 {
+	/* WiFi & BT combo module AMPAK AP6398S */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	bus-width = <4>;
+	clock-frequency = <150000000>;
+	cap-sdio-irq;
 	cap-sd-highspeed;
-	disable-wp;
+	sd-uhs-sdr104;
+	keep-power-in-suspend;
 	mmc-pwrseq = <&sdio_pwrseq>;
 	non-removable;
 	pinctrl-names = "default";
@@ -401,6 +411,16 @@ &sdmmc1 {
 	vmmc-supply = <&vcc_3v3>;
 	vqmmc-supply = <&vcca_1v8>;
 	status = "okay";
+
+	brcmf: wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <RK_PB2 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_host_wake_h>;
+	};
 };
 
 &spdif {
-- 
2.34.1

