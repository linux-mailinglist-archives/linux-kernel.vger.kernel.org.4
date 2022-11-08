Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBA9621A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbiKHRPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbiKHRPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:15:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98D71AF24;
        Tue,  8 Nov 2022 09:15:08 -0800 (PST)
Received: from jupiter.universe (dyndsl-095-033-156-208.ewe-ip-backbone.de [95.33.156.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2E0BC6602901;
        Tue,  8 Nov 2022 17:15:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667927707;
        bh=LDWBRm+RmRbZ3a+FpCb+UmXdQ+0wzNjj7oK1rCF41pc=;
        h=From:To:Cc:Subject:Date:From;
        b=V2dXGiUee/xHKbO6SoC3Jsp6GQfzb2anNKgi6X2BVoGXMleYssdvc9P7QELKQdJST
         oNSKm2R5HkK4wxhEdaVJ75oLOgalg8HHOcyWsLoPn8QJ0KjUl467Bd7MhQMcqDpI7d
         DUWZaSSSOe5u09mchpM84HEk008v/3Yx+S5Gcmwd8nP/GbgJHKi/rBgbsDXyNNzn0Z
         /vqWxVD723SGJkTJlZ6D1Nqf1IDor6yQ3mn6gKRnJztiaZDX/V+GkihHP8c7RlWkOn
         B9cX1NH/wBANoRwPztJosRxyb4ZX8a4wYIpvnX2FfJOJvmIxRdC3MEqYPSo29kHKZS
         7cOpF4Q31KvJQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 0E0DF480078; Tue,  8 Nov 2022 18:15:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 0/5] Initial rk3588 DT
Date:   Tue,  8 Nov 2022 18:14:55 +0100
Message-Id: <20221108171500.99599-1-sebastian.reichel@collabora.com>
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
devicetrees. This patchset has a couple of dependencies:

 * clock support
   https://lore.kernel.org/all/20221018151407.63395-1-sebastian.reichel@collabora.com/

 * dt binding fixes
   https://lore.kernel.org/all/20221107173310.60503-1-sebastian.reichel@collabora.com/
   https://lore.kernel.org/all/20221107180231.73663-1-sebastian.reichel@collabora.com/
   https://lore.kernel.org/all/20221021172012.87954-1-sebastian.reichel@collabora.com/

Even with that there is still one warning from the DT check:

$ make CHECK_DTBS=y rockchip/rk3588-evb1-v10.dtb rockchip/rk3588s-rock-5a.dtb
  DTC_CHK arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb
/home/sre/src/collabora/rode/linux-rockchip-upstream/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb:
    ethernet@fe1c0000: Unevaluated properties are not allowed ('interrupt-names', 'interrupts', 'mdio',
    'power-domains', 'reg', 'reset-names', 'resets', 'rx-queues-config', 'snps,axi-config', 'snps,mixed-burst',
    'snps,mtl-rx-config', 'snps,mtl-tx-config', 'snps,tso', 'stmmac-axi-config', 'tx-queues-config' were unexpected)
	From schema: /home/sre/src/collabora/rode/linux-rockchip-upstream/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml

This is for gmac1. gmac0 has the same properties and there is no warning. Also
rk3588s (and thus the Rock 5A) has only gmac1 and there is no warning for the
Rock 5A. It looks like the for some reason the referenced "snps,dwmac.yaml#"
is only checked for the first node. I think it's a bug in dt-validate.

-- Sebastian

Jianqun Xu (1):
  arm64: dts: rockchip: Add rk3588 pinctrl data

Kever Yang (2):
  arm64: dts: rockchip: Add base DT for rk3588 SoC
  arm64: dts: rockchip: Add rk3588-evb1 board

Sebastian Reichel (2):
  dt-bindings: soc: rockchip: add initial rk3588 syscon compatibles
  arm64: dts: rockchip: Add rock-5a board

 .../devicetree/bindings/arm/rockchip.yaml     |   10 +
 .../devicetree/bindings/soc/rockchip/grf.yaml |    5 +
 arch/arm64/boot/dts/rockchip/Makefile         |    2 +
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     |  156 +
 .../boot/dts/rockchip/rk3588-pinctrl.dtsi     |  516 +++
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |   62 +
 .../boot/dts/rockchip/rk3588s-pinctrl.dtsi    | 3403 +++++++++++++++++
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     |   63 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 1678 ++++++++
 9 files changed, 5895 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s.dtsi

-- 
2.35.1

