Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9ABC5F0EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiI3PZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiI3PZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:25:54 -0400
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0681138D6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:25:51 -0700 (PDT)
Received: from amadeus-VLT-WX0.lan (unknown [110.81.126.164])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 6618E800093;
        Fri, 30 Sep 2022 23:25:40 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     linux.amoon@gmail.com
Cc:     heiko@sntech.de, robh+dt@kernel.org, michael.riesch@wolfvision.net,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 0/1] Re: [PATCH-next v1] arm64: dts: rockchip: Enable NVM Express PCIe controller on rock3a
Date:   Fri, 30 Sep 2022 23:25:31 +0800
Message-Id: <20220930152531.5910-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANAwSgSf=JZ_JiK1Gh5EYR30KQ5Yh-w3GsxzcFVweKHPi7KuLg@mail.gmail.com>
References: <CANAwSgSf=JZ_JiK1Gh5EYR30KQ5Yh-w3GsxzcFVweKHPi7KuLg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSh1DVkhPTk0fSE1MHx9IT1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKS1VDSlVKSU1VSk1PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjY6Kio5MD0iUVZJKEk3Ojk4
        KBkwCStVSlVKTU1PTk5KTk9KS0pNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
        S1VDSlVKSU1VSk1PWVdZCAFZQUhMTU03Bg++
X-HM-Tid: 0a838f00d7a0b03akuuu6618e800093
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

> No, It's not working on my board.
> If you check the driver code it requires *data-line* and *num-lanes
> from the dts.

I have successfully tested NVME hard drives on my board. See
below for the patch, looking forward to your testing.

root@rock3a:~# lspci
0000:00:00.0 PCI bridge: Rockchip Electronics Co., Ltd \
             RK3568 Remote Signal Processor (rev 01)
0000:01:00.0 Network controller: MEDIATEK Corp. MT7921 \
             802.11ax PCI Express Wireless Network Adapter
0002:00:00.0 PCI bridge: Rockchip Electronics Co., Ltd \
             RK3568 Remote Signal Processor (rev 01)
0002:01:00.0 Non-Volatile memory controller: Sandisk Corp \
             PC SN520 NVMe SSD (rev 01)

Patch:

--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -67,6 +67,37 @@ vcc12v_dcin: vcc12v-dcin-regulator {
 		regulator-boot-on;
 	};
 
+	pcie30_avdd0v9: pcie30-avdd0v9-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie30_avdd0v9";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	pcie30_avdd1v8: pcie30-avdd1v8-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "pcie30_avdd1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
+	/* pi6c pcie clock generator */
+	vcc3v3_pi6c_03: vcc3v3-pi6c-03-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pi6c_03";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
 	vcc3v3_pcie: vcc3v3-pcie-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -546,6 +577,19 @@ &pcie2x1 {
 	status = "okay";
 };
 
+&pcie30phy {
+	phy-supply = <&vcc3v3_pi6c_03>;
+	status = "okay";
+};
+
+&pcie3x2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie30x2m1_pins>;
+	reset-gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+	status = "okay";
+};
+
 &pinctrl {
 	cam {
 		vcc_cam_en: vcc_cam_en {
-- 
2.25.1

Thanks,
Chukun
