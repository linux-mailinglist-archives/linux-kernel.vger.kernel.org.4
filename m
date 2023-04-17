Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898B76E4C41
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjDQPAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjDQPAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:00:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679184222;
        Mon, 17 Apr 2023 08:00:43 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-191-155.ewe-ip-backbone.de [91.248.191.155])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A4DB06603223;
        Mon, 17 Apr 2023 16:00:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681743641;
        bh=uM3PWO3IQObscBohW7QPL9pguhEFNiexqSSj/2QsykE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ONSf76mjLn0RMj50BOw6eqXwnjJms8Pgk1OcxbjaNuQvOai9JcudMN+9bTGf04gk4
         dq3Xz7oTHmGWq0D1dIt8ToEnJ3cX2QhAnQDXGIU6YcPNfkuyta6buZEiI11jrJW+hO
         WhgwqLi/ZWI4ec9R4aWc0rtTHOHRgavit3148PyeobgJ5UotqoO9l3LzhzX0sfKaUm
         rsmtXoJ4wlzS0g4skHGX0LvBCIrg+d9pwuVN8UasSwKlM9pARTYXcVinWtGnPNblxM
         77jd3njA9Uzj14yaW9bCtB7/4wyyvIgsTXaSNc1nsiVNvHy/YUZXy26lI8+gmMPbhi
         ecLIocrr26jXg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id DC9334807EF; Mon, 17 Apr 2023 17:00:38 +0200 (CEST)
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
Subject: [PATCH v2 2/2] arm64: dts: rockchip: rk3588: add MSI support
Date:   Mon, 17 Apr 2023 17:00:38 +0200
Message-Id: <20230417150038.51698-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417150038.51698-1-sebastian.reichel@collabora.com>
References: <20230417150038.51698-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the two Interrupt Translation Service (ITS) IPs that are part of the
GIC-600, which are required for message signalled interrupts (MSI). This
is required for PCIe, which fully relies on MSI for interrupts.

Enabling the ITS nodes requires an operating system, that has a
workaround for Rockchip errata #3588001 (GIC600 can not support
shareable attribute).

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

