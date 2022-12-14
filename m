Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9406564CF54
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238647AbiLNSXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbiLNSWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:22:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ADC28706;
        Wed, 14 Dec 2022 10:22:54 -0800 (PST)
Received: from jupiter.universe (dyndsl-095-033-169-234.ewe-ip-backbone.de [95.33.169.234])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DADA06602C58;
        Wed, 14 Dec 2022 18:22:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671042172;
        bh=LifJRzHYNh+w6LLxSuOA52Pf3Qj/C3AqvWlAzrrQig0=;
        h=From:To:Cc:Subject:Date:From;
        b=gNEbb3+8joNQwiCYBNGwxU6Dq/a7LBqcQU7qTCytSkXV+uxpn9DyZyYJm9FTN0C4O
         SFuDPdkRftjQqV+Na7ye1ZYCngaXMtwMdxlBwRMqPPy2S62nKST7Mj1sLqelSbeVUJ
         Wqps4qyNiFekzjQZ0T2eY5qb5RzkJATdbgJMPjiogxbHpa7tyP5MGaIi3Z3NBM3TYG
         zZsuYAK5b9NTeirjKfh68gwsvFaLdvOfvQOY/dBv/nwlzdTDnTujc1vD7c5IZWBrn7
         4nnYuhB8IQKkf/qh1vL86dvodZEo5eP2IpbJ/FDScrrABlDLRCoXuufpRQWkqcuwU6
         WIsVH9T0/JZSA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id B5A01480116; Wed, 14 Dec 2022 19:22:48 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv6 0/7] Initial rk3588 DT
Date:   Wed, 14 Dec 2022 19:22:40 +0100
Message-Id: <20221214182247.79824-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds initial rk3588(s) DT including two different board
devicetrees. All required driver changes have been merged into
the respective maintainer trees. There is one warning from the
DT check:

$ make CHECK_DTBS=y rockchip/rk3588-evb1-v10.dtb rockchip/rk3588s-rock-5a.dtb
  DTC_CHK arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb
/home/sre/src/collabora/rode/linux-rockchip-upstream/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb:
    ethernet@fe1c0000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio',
    'power-domains', 'reg', 'reset-names', 'resets', 'rx-queues-config', 'snps,axi-config', 'snps,mixed-burst',
    'snps,mtl-rx-config', 'snps,mtl-tx-config', 'snps,tso', 'stmmac-axi-config', 'tx-queues-config' were unexpected)
	From schema: /home/sre/src/collabora/rode/linux-rockchip-upstream/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml

This is for gmac1. gmac0 has the same properties and there is no warning. Also
rk3588s (and thus the Rock 5A) has only gmac1 and there is no warning for the
Rock 5A. It looks like for some reason the referenced "snps,dwmac.yaml#"
is only checked for the first node. I think it's a bug in dt-validate.
Also the same issue can be seen with rk356x.

Changes since PATCHv5:
 * https://lore.kernel.org/all/20221205172350.75234-1-sebastian.reichel@collabora.com/
 * modified GIC interrupts to use rk3399 style setup with two PPI partitions
 * add interrupt-names to the ARM timer node
 * add hyp-virt IRQ to the ARM timer node
 * re-add the #power-domain-cells for the power-controller sub-nodes and set to 0;
   the DT binding document requires it. I'm not sure why it was not pointed out by
   CHECK_DTBS when I sent v4/v5.

Changes since PATCHv4:
 * https://lore.kernel.org/all/20221124144928.35381-1-sebastian.reichel@collabora.com/
 * update compatible string for the PHY to provide PHY ID. Without the IDs
   provided in the firmware, the kernel tries to identify the correct driver by
   reading the ID. This fails, if the bootloader does not setup the reset GPIO,
   since the kernel only setups the reset GPIO in the PHY driver. Rock 5A with
   the default bootloader runs into this, but I also changed EVB1 since the kernel
   should not depend on bootloader configuration for this.
 * added pinctrl for PHY reset-gpios
 * drop rgmii-rxid from gmac1 node
 * added reviewed-by from Michael Risch for board DTs
 * I kept the order of the trailers (i.e. my SoB being the last), which is the usual
   order in most subsystems

Changes since PATCHv3:
 * https://lore.kernel.org/all/20221121175814.68927-1-sebastian.reichel@collabora.com/
 * update reset gpio + timings in EVB1 and Rock 5A DT to new style
 * change regulator- prefix to -regulator suffix in EVB1 and Rock 5B DTB
 * merge dt-binding update patches for EVB1, Rock 5A and Rock 5B and add Krzysztof's Ack
 * change pinctrl name "active" to "default" for all PWM nodes
 * remove aliases from rk3588s and rk3588 DTSI
 * sort includes in rk3588s.dtsi
 * add dma names for uart
 * some more property order fixes
 * remove #power-domain-cells for the power-controller sub-nodes; only the main node should be referenced
 * add dynamic-power-coefficient and #cooling-cells for all CPU cores

Changes since PATCHv2:
 * https://lore.kernel.org/all/20221115161702.163057-1-sebastian.reichel@collabora.com/
 * add minimal Radxa Rock 5B DT
 * Add aliases for i2c, spi and gpio in rk3588s.dtsi
 * Fix ethernet-phy node name and remove #phy-cells
 * Sort nodes / includes in both boards
 * Sort nodes in rk3588s.dtsi according to register address
 * add missing spi4 node in rk3588s.dtsi
 * split board specific dt-bindings into their own patches
 * add board specific mmc alias following the downstream enumeration

Changes since PATCHv1:
 * https://lore.kernel.org/all/20221108171500.99599-1-sebastian.reichel@collabora.com/
 * Drop Acked-by from Krzysztof
 * Add 'regulator-' prefix to VCC12V VCC5V0 regulators
 * Change 'Radxa Rock 5A' to 'Radxa ROCK 5 Model A' in DT binding
 * Update cover-letter (clock driver and some DT binding fixes got merged)

-- Sebastian

Christopher Obbard (1):
  arm64: dts: rockchip: Add rock-5b board

Jianqun Xu (1):
  arm64: dts: rockchip: Add rk3588 pinctrl data

Kever Yang (2):
  arm64: dts: rockchip: Add base DT for rk3588 SoC
  arm64: dts: rockchip: Add rk3588-evb1 board

Sebastian Reichel (3):
  dt-bindings: soc: rockchip: add initial rk3588 syscon compatibles
  dt-bindings: arm: rockchip: add initial rk3588 boards
  arm64: dts: rockchip: Add rock-5a board

 .../devicetree/bindings/arm/rockchip.yaml     |   15 +
 .../devicetree/bindings/soc/rockchip/grf.yaml |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    3 +
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     |  165 +
 .../boot/dts/rockchip/rk3588-pinctrl.dtsi     |  516 +++
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |   44 +
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |   58 +
 .../boot/dts/rockchip/rk3588s-pinctrl.dtsi    | 3403 +++++++++++++++++
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     |   73 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 1703 +++++++++
 10 files changed, 5985 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s.dtsi

-- 
2.39.0

