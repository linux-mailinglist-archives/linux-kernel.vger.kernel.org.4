Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1A8632B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKUR6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKUR62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:58:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D468B10B53;
        Mon, 21 Nov 2022 09:58:26 -0800 (PST)
Received: from jupiter.universe (dyndsl-037-138-187-016.ewe-ip-backbone.de [37.138.187.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5E7F466029B0;
        Mon, 21 Nov 2022 17:58:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669053505;
        bh=/1aNBsrAg1ZmHtEI6sPt/HBfhYWdbp35pT6ZJ1FP9bM=;
        h=From:To:Cc:Subject:Date:From;
        b=hZTCeTiOWQg+a8VqhxofVSM7tUg1jWLRzaJ2/2MmbpmRmnsNpMB9RNvCVwgm968X/
         aQAbB6zUXEnFcvd2YDyyk4dssOTwodsyK9qR5b8A/LSnGMzN/P9a+U88ouf2BkSuQC
         8jJxHkPYzAEL9DhQUCU4ajTr1t9d5MhkdCUgUlh8bIYDkTydv7AxT7uzZykJfTMzC2
         YMhILLVjwL7kPQMwoC6QXg4CYv7TeHrvgcDsPtaow0gsf/icBf8ovaywIUE61bnnAK
         ZavJMmsc+oAwzWZIJy5nPkXEJgasrI0SJ2aFert2MiqLdbwyvErEwgWuWKye2W74HU
         fuIw6tZ29I3Nw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 0B4E2480113; Mon, 21 Nov 2022 18:58:23 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv3 0/9] Initial rk3588 DT
Date:   Mon, 21 Nov 2022 18:58:05 +0100
Message-Id: <20221121175814.68927-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
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

Christopher Obbard (2):
  dt-bindings: arm: rockchip: add Rock 5 Model B
  arm64: dts: rockchip: Add rock-5b board

Jianqun Xu (1):
  arm64: dts: rockchip: Add rk3588 pinctrl data

Kever Yang (2):
  arm64: dts: rockchip: Add base DT for rk3588 SoC
  arm64: dts: rockchip: Add rk3588-evb1 board

Sebastian Reichel (4):
  dt-bindings: soc: rockchip: add initial rk3588 syscon compatibles
  dt-bindings: arm: rockchip: add RK3588 EVB1
  dt-bindings: arm: rockchip: add Rock 5 Model A
  arm64: dts: rockchip: Add rock-5a board

 .../devicetree/bindings/arm/rockchip.yaml     |   15 +
 .../devicetree/bindings/soc/rockchip/grf.yaml |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    3 +
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     |  159 +
 .../boot/dts/rockchip/rk3588-pinctrl.dtsi     |  516 +++
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |   43 +
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |   62 +
 .../boot/dts/rockchip/rk3588s-pinctrl.dtsi    | 3403 +++++++++++++++++
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     |   66 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 1722 +++++++++
 10 files changed, 5994 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s.dtsi

-- 
2.35.1

