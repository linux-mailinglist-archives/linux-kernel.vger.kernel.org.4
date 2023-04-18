Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFBA6E670A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjDROVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjDROVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:21:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FBE13FB4;
        Tue, 18 Apr 2023 07:21:13 -0700 (PDT)
Received: from jupiter.universe (unknown [91.248.213.255])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5B3AA6603218;
        Tue, 18 Apr 2023 15:21:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681827671;
        bh=JaiGX/zKLMMzlVpGom/T53NzObIEnY5d4OtYAaV22XU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwzQC1dQYfCTwHwTbf2svOb6fTO6TtWslcKeDLXMeV6PAyVuUGkLtnIQ9shBHdd0p
         POD9tjKsdwX08hukajs9JDSmBLBPQl7ExeeUe0CpPN/uuqRMQck5z77DsdZhOuyGSG
         bC/M/NPmt7tUSfbXiE/pMOJ6sPQUPtary/q5542c3KD/LPSJi+eFZ3q6psolhOU2/d
         Mzo2Gtqq7Fe4Nhq4tp+0C29R0b3+CT8RSDlM/ltVS9n/K8wbhgvABaTP8u5iKVmXkF
         dtSTqFks4b8boHqSORJ9qd1p8Cyyi0yVXCfBmNkXvhAnYQ0DsB2MMhFwBPTpkN0lov
         fmoTUfFqe0OOg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 888D0480075; Tue, 18 Apr 2023 16:21:09 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marc Zyngier <maz@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        XiaoDong Huang <derrick.huang@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 2/2] arm64: dts: rockchip: rk3588: add GIC ITS support
Date:   Tue, 18 Apr 2023 16:21:09 +0200
Message-Id: <20230418142109.49762-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418142109.49762-1-sebastian.reichel@collabora.com>
References: <20230418142109.49762-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the two Interrupt Translation Service (ITS) IPs that are part of the
GIC-600. They are mainly required for PCIe Message Signalled Interrupts
(MSI).

Co-developed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 2124c654f665..62204b96b0b4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1741,7 +1741,24 @@ gic: interrupt-controller@fe600000 {
 		mbi-alias = <0x0 0xfe610000>;
 		mbi-ranges = <424 56>;
 		msi-controller;
+		ranges;
+		#address-cells = <2>;
 		#interrupt-cells = <4>;
+		#size-cells = <2>;
+
+		its0: msi-controller@fe640000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			#msi-cells = <1>;
+			reg = <0x0 0xfe640000 0x0 0x20000>;
+		};
+
+		its1: msi-controller@fe660000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			#msi-cells = <1>;
+			reg = <0x0 0xfe660000 0x0 0x20000>;
+		};
 
 		ppi-partitions {
 			ppi_partition0: interrupt-partition-0 {
-- 
2.39.2

