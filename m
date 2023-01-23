Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1EC6775B1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 08:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjAWHgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 02:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjAWHgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 02:36:48 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8181E18B1F
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 23:36:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674459357; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=H7BwwRZ01ZN1U1RMbNO1pzm8QIU76QnpD1Vo+T4QfTTTFJsT3KYL8TyQM5QLd8ot6lcCeraREJkrjla9Pa6uiBnni+LDreRm299NAp8epsAvhspRIBy8yb7emmnYILSR1hTvSerkrPNB0a4jIcLQa8+6JHBBEJJiU+215wfLyRo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1674459357; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject; 
        bh=HkG+SmbIjA7sw7BLtfWk5YKVQYC6xM4eS1D5oo5HkRg=; 
        b=CkpUrhKdNV6tLpuCqRjAYMct1rnU7+6ddITri4lxt2d1A0BgOASuGBeLothybj6CdE0RNaUqOMD6Ew9qaPweozGL+no3AP/39+41YOI77glP8KAOxpOowicvsncnZyL9ct6An7d8w5sVdtjg+1TXPy6fh9BJDFgR/8+8+W5EcZs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<lchen@ambarella.com>
Received: from shbuild9.ambarella.net (116.246.37.178 [116.246.37.178]) by mx.zohomail.com
        with SMTPS id 1674459355500620.8753836206259; Sun, 22 Jan 2023 23:35:55 -0800 (PST)
From:   Li Chen <lchen@ambarella.com>
Cc:     Li Chen <lchen@ambarella.com>,
        =?UTF-8?q?Andreas=20B=C3=B6hler?= <dev@aboehler.at>,
        Arnd Bergmann <arnd@arndb.de>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daniel Palmer <daniel@0x0f.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jean Delvare <jdelvare@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liang Yang <liang.yang@amlogic.com>,
        Li Chen <lchen@ambarella.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:MEMORY TECHNOLOGY DEVICES
        (MTD)), linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Rickard x Andersson <rickaran@axis.com>,
        Rob Herring <robh@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH 00/15] Ambarella S6LM SoC bring-up
Date:   Mon, 23 Jan 2023 15:32:15 +0800
Message-Id: <20230123073305.149940-1-lchen@ambarella.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings up initial support for the Ambarella S6LM
SoC.

The following features are supported in this initial port:

- UART with console support
- Pinctrl with GPIO controller
- Nand flash controller
- Devicetree

Li Chen (15):
  debugfs: allow to use regmap for print regs
  dt-bindings: vendor-prefixes: add Ambarella prefix
  dt-bindings: arm: ambarella: Add binding for Ambarella ARM platforms
  dt-bindings: arm: add support for Ambarella SoC
  arm64: Kconfig: Introduce CONFIG_ARCH_AMBARELLA
  soc: add Ambarella driver
  dt-bindings: clock: Add Ambarella clock bindings
  clk: add support for Ambarella clocks
  dt-bindings: serial: add support for Ambarella
  serial: ambarella: add support for Ambarella uart_port
  dt-bindings: mtd: Add binding for Ambarella
  mtd: nand: add Ambarella nand support
  dt-bindings: pinctrl: add support for Ambarella
  pinctrl: Add pinctrl/GPIO for Ambarella SoCs
  arm64: dts: ambarella: introduce Ambarella s6lm SoC

 .../devicetree/bindings/arm/ambarella.yaml    |   22 +
 .../arm/ambarella/ambarella,cpuid.yaml        |   24 +
 .../bindings/arm/ambarella/ambarella,rct.yaml |   24 +
 .../arm/ambarella/ambarella,scratchpad.yaml   |   24 +
 .../bindings/arm/ambarella/ambarella.yaml     |   22 +
 .../clock/ambarella,composite-clock.yaml      |   52 +
 .../bindings/clock/ambarella,pll-clock.yaml   |   59 +
 .../bindings/mtd/ambarella,nand.yaml          |   77 +
 .../bindings/pinctrl/ambarella,pinctrl.yaml   |  160 ++
 .../bindings/serial/ambarella_uart.yaml       |   57 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 Documentation/filesystems/debugfs.rst         |    2 +
 MAINTAINERS                                   |   29 +
 arch/arm64/Kconfig.platforms                  |    9 +
 .../boot/dts/ambarella/ambarella-s6lm.dtsi    |  332 ++++
 .../boot/dts/ambarella/s6lm_pineapple.dts     |   29 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/ambarella/Makefile                |    5 +
 drivers/clk/ambarella/clk-composite.c         |  293 +++
 drivers/clk/ambarella/clk-pll-common.c        |  308 ++++
 drivers/clk/ambarella/clk-pll-common.h        |   96 +
 drivers/clk/ambarella/clk-pll-normal.c        |  328 ++++
 drivers/mtd/nand/raw/Kconfig                  |    8 +
 drivers/mtd/nand/raw/Makefile                 |    1 +
 drivers/mtd/nand/raw/ambarella_combo_nand.c   | 1519 ++++++++++++++++
 drivers/mtd/nand/raw/ambarella_combo_nand.h   |  370 ++++
 drivers/mtd/nand/raw/nand_ids.c               |    4 +
 drivers/pinctrl/Kconfig                       |    6 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/pinctrl-ambarella.c           | 1357 ++++++++++++++
 drivers/soc/Makefile                          |    1 +
 drivers/soc/ambarella/Makefile                |    3 +
 drivers/soc/ambarella/soc.c                   |  136 ++
 drivers/tty/serial/Kconfig                    |   16 +
 drivers/tty/serial/Makefile                   |    1 +
 drivers/tty/serial/ambarella_uart.c           | 1581 +++++++++++++++++
 drivers/tty/serial/ambarella_uart.h           |  120 ++
 fs/debugfs/file.c                             |   43 +-
 include/linux/debugfs.h                       |   11 +
 include/soc/ambarella/misc.h                  |   17 +
 40 files changed, 7149 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/ambarella.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/ambarella/ambarella,cpuid.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/ambarella/ambarella,rct.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/ambarella/ambarella,scratchpad.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/ambarella/ambarella.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/ambarella,composite-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/ambarella,pll-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/ambarella,nand.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ambarella,pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/ambarella_uart.yaml
 create mode 100644 arch/arm64/boot/dts/ambarella/ambarella-s6lm.dtsi
 create mode 100644 arch/arm64/boot/dts/ambarella/s6lm_pineapple.dts
 create mode 100644 drivers/clk/ambarella/Makefile
 create mode 100644 drivers/clk/ambarella/clk-composite.c
 create mode 100644 drivers/clk/ambarella/clk-pll-common.c
 create mode 100644 drivers/clk/ambarella/clk-pll-common.h
 create mode 100644 drivers/clk/ambarella/clk-pll-normal.c
 create mode 100644 drivers/mtd/nand/raw/ambarella_combo_nand.c
 create mode 100644 drivers/mtd/nand/raw/ambarella_combo_nand.h
 create mode 100644 drivers/pinctrl/pinctrl-ambarella.c
 create mode 100644 drivers/soc/ambarella/Makefile
 create mode 100644 drivers/soc/ambarella/soc.c
 create mode 100644 drivers/tty/serial/ambarella_uart.c
 create mode 100644 drivers/tty/serial/ambarella_uart.h
 create mode 100644 include/soc/ambarella/misc.h

-- 
2.34.1

