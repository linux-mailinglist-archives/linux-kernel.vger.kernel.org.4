Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6521662AAD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbjAIP6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjAIP6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:58:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695083633E;
        Mon,  9 Jan 2023 07:58:07 -0800 (PST)
Received: from jupiter.universe (dyndsl-037-138-188-006.ewe-ip-backbone.de [37.138.188.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D08526602D11;
        Mon,  9 Jan 2023 15:58:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673279886;
        bh=cAkULhRBzF03giwfdqr6IH+cvMkj6qiyC0tTtyDFCQA=;
        h=From:To:Cc:Subject:Date:From;
        b=XcCGZqslsY0rKq1J0TDjYXad3jvAqPGB0ePZhi5yO8srXPim+u7Pliia9KyR37t4a
         x47mq1edd3voScjMZhMU6kRBBEqircjwQi+knZ6SYo62lxLyvy/5lhdK6nA1GhuoVr
         T2+S72kF32yeEjcbfy+ClfIADv66S6BD2nqFHM3MWzruFrbOteDPZ0aAjtx+eK9X7m
         ELxUUFBSlHYOjFrPMXjZxe5D3Xjl4CC/nZ7EOolS4RBb7+3IxTqWZ4HgPonZ4CwS+r
         KivsBimRP5e+Us/OUGfoDRsS04iT5Ow6VfbJWguyudMchtv3evwxP1Wri6zE86s3RJ
         cbPkr1uwWBeFQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 7DFDA480116; Mon,  9 Jan 2023 16:58:03 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv8 0/7] Initial rk3588 DT
Date:   Mon,  9 Jan 2023 16:57:54 +0100
Message-Id: <20230109155801.51642-1-sebastian.reichel@collabora.com>
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

This adds initial rk3588(s) DT including three different board
devicetrees. All required driver changes have been merged into
Linus tree already. To avoid warnings from

$ make CHECK_DTBS=y rockchip/rk3588-evb1-v10.dtb \
  rockchip/rk3588-rock-5b.dtb rockchip/rk3588s-rock-5a.dtb

it is required to have dt-schema 2022.12 (older releases may
generate warnings for the ethernet nodes) and c69bffe199270c
("dt-bindings: rtc: convert hym8563 bindings to json-schema")
from rtc-next.

Changes since PATCHv7:
 * https://lore.kernel.org/all/20221215183002.211081-1-sebastian.reichel@collabora.com/
 * update DT model string for ROCK 5A/5B to match the description in the DT binding
 * capitalize Rock (ROCK) in DT binding
 * rebase to v6.2-rc1

Changes since PATCHv6:
 * https://lore.kernel.org/all/20221214182247.79824-1-sebastian.reichel@collabora.com/
 * renamed ppi_cluster<x> to ppi_partition<x>
 * updated commit message of the third patch removing the incorrect "(single core)" and
   listing all added IP blocks.
 * removed brightness levels from EVB1 backlight; I kept the backlight node. It's the
   test case for PWM support.
 * rebase to current linus master (041fae9c105a)

Changes since PATCHv5:
 * https://lore.kernel.org/all/20221205172350.75234-1-sebastian.reichel@collabora.com/
 * modified GIC interrupts to use rk3399 style setup with two PPI partitions
 * add interrupt-names to the ARM timer node
 * add hyp-virt IRQ to the ARM timer node
 * re-add the #power-domain-cells for the power-controller sub-nodes and set to 0;
   the DT binding document requires it. I'm not sure why it was not pointed out by
   DTBS_CHECK when sending v4 and v5.

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
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     |  129 +
 .../boot/dts/rockchip/rk3588-pinctrl.dtsi     |  516 +++
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |   44 +
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |   58 +
 .../boot/dts/rockchip/rk3588s-pinctrl.dtsi    | 3403 +++++++++++++++++
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     |   73 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 1703 +++++++++
 10 files changed, 5949 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s.dtsi

-- 
2.39.0

