Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C201649FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiLLNRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiLLNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:16:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C21E55;
        Mon, 12 Dec 2022 05:16:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E326B80D3B;
        Mon, 12 Dec 2022 13:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAC2C433F0;
        Mon, 12 Dec 2022 13:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670850981;
        bh=yU77M70lTC5XxgF2XQ/bo/Ce9DnjjaEARtSzMp53Ia4=;
        h=From:To:Cc:Subject:Date:From;
        b=k3Hs7wpzNgjXoyjbO5jVlifwQ/iIrH0eOHFaFXGZ1n4GMJ9dP8/3mhmJs+usDBwjB
         eo8ORLY/HLlGng2l1q4PRYTuD58TgBIrgDIQSsbbBdm3khTSz1sCXwKw7MjR5aQkC5
         dpVpvx3isGbRFwDmH3L9Q2AEVa5NYvaL9TMdA65J5DDpxPnFWT6noHQUD27TumcHWM
         cxoGZRp+r/k7TOYUWP9xK5Y/nNHUitoK5RAaSUmtX3bcNUem5MNTgCOLyaYPNLo3pZ
         +KsxLjy7rStepV+HMg338rOGShK/TWmC0vDeQsRvvTCNTKgf88d8FbKXnTMYv/qOrj
         cYYs9607vn23A==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.2
Date:   Mon, 12 Dec 2022 13:16:10 +0000
Message-Id: <20221212131621.6AAC2C433F0@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.2

for you to fetch changes up to 3cf241c3d56ff19f5192cb42a025bc6582b6e8fa:

  spi: dt-bindings: Convert Synquacer SPI to DT schema (2022-12-09 17:39:08 +0000)

----------------------------------------------------------------
spi: Updates for v6.2

A busy enough release, but not for the core which has only seen very
small updates.  The biggest addition is the readdition of support for
detailed configuration of the timings around chip selects.  That had
been removed for lack of use but there's been applications found for it
on Atmel systems.  Otherwise the updates are mostly feature additions
and cleanups to existing drivers.

 - Provide a helper for getting device match data in a way that
   abstracts away which firmware interface is being used.
 - Re-add the spi_set_cs_timing() API for detailed configuration of the
   timing around chip select and support it on Atmel.
 - Support for MediaTek MT7986, Microchip PCI1xxxx, Nuvoton WPCM450 FIU
   and Socionext F_OSPI.

There's a straightforward add/add conflict with the rpmsg tree in the
xilinx firmware code (both trees got new users of the firmware added
each needing new firmware<->kernel ioctls).

There's a cross tree merge with I2C in order to use the new
i2c_client_get_device_id() helper in some I2C attached SPI controllers
as part of their conversion to I2C's probe_new() API.

----------------------------------------------------------------
Alexander Sverdlin (1):
      spi: spidev: mask SPI_CS_HIGH in SPI_IOC_RD_MODE

Amit Kumar Mahapatra (5):
      spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
      spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
      spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same SPI frequency
      spi: dt-bindings: zynqmp-qspi: Add support for Xilinx Versal QSPI
      spi: spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on Versal platform

Amjad Ouled-Ameur (2):
      spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names for SPI signal states
      spi: meson-spicc: Use pinctrl to drive CLK line when idle

Andy Shevchenko (8):
      spi: pxa2xx: Simplify with devm_platform_get_and_ioremap_resource()
      spi: Introduce spi_get_device_match_data() helper
      spi: pxa2xx: Consistently use dev variable in pxa2xx_spi_init_pdata()
      spi: pxa2xx: Switch from PM ifdeffery to pm_ptr()
      spi: pxa2xx: Validate the correctness of the SSP type
      spi: pxa2xx: Respect Intel SSP type given by a property
      spi: pxa2xx: Remove no more needed PCI ID table
      spi: pxa2xx: Move OF and ACPI ID tables closer to their user

Angel Iglesias (1):
      i2c: core: Introduce i2c_client_get_device_id helper function

Colin Ian King (1):
      spi: nxp-fspi: make const array ls1028a_soc_attr static

Geert Uytterhoeven (1):
      spi: Merge spi_controller.{slave,target}_abort()

Giulio Benetti (1):
      spi: fsl-cpm: substitute empty_zero_page with helper ZERO_PAGE(0)

Han Xu (2):
      spi: spi-fsl-lpspi: support multiple cs for lpspi
      spi: spi-fsl-lpspi: add num-cs binding for lpspi

Jean Delvare (1):
      spi: cadence: Drop obsolete dependency on COMPILE_TEST

Jiapeng Chong (1):
      spi: microchip-core: Remove the unused function mchp_corespi_enable()

Jonathan Neuschäfer (8):
      spi: nuvoton,npcm-fiu: Change spi-nor@0 name to flash@0
      spi: Update reference to struct spi_controller
      spi: hisi-sfc-v3xx: Fix a typo ("duall")
      spi: wpcm-fiu: Add driver for Nuvoton WPCM450 Flash Interface Unit (FIU)
      spi: wpcm-fiu: Add direct map support
      spi: Add Nuvoton WPCM450 Flash Interface Unit (FIU) bindings
      spi: dt-bindings: nuvoton,wpcm450-fiu: Fix error in example (bogus include)
      spi: dt-bindings: nuvoton,wpcm450-fiu: Fix warning in example (missing reg property)

Kris Bahnsen (1):
      spi: spi-gpio: Don't set MOSI as an input if not 3WIRE mode

Kunihiko Hayashi (2):
      spi: Add Socionext F_OSPI SPI flash controller driver
      spi: Add Socionext F_OSPI controller bindings

Marc Kleine-Budde (1):
      spi: spi-imx: remove unused struct spi_imx_devtype_data::disable_dma callback

Mark Brown (9):
      Merge existing fixes from spi/for-6.1 into new branch
      spi: spi-zyqnmp-gqspi: Add tap delay and Versal platform support
      spi: pxa2xx: Minor cleanups
      spi: amlogic: meson-spicc: Use pinctrl to drive CLK line when idle
      spi: pxa2xx: Pass the SSP type via device property
      Merge branch 'i2c/client_device_id_helper-immutable' of https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux into spi-6.2
      Introduce Socionext F_OSPI SPI flash controller
      Nuvoton WPCM450 FIU SPI flash controller
      Merge tag 'v6.1-rc4' into spi-6.2

Mika Westerberg (4):
      spi: intel: Use ->replacement_op in intel_spi_hw_cycle()
      spi: intel: Implement adjust_op_size()
      spi: intel: Take possible chip address into account in intel_spi_read/write_reg()
      spi: intel: Add support for SFDP opcode

Naga Sureshkumar Relli (1):
      spi: spi-zynqmp-gqspi: Add tap delay support for ZynqMP GQSPI Controller

Nathan Barrett-Morrison (1):
      spi: cadence-quadspi: Add minimum operable clock rate warning to baudrate divisor calculation

Radu Pirea (NXP OSS) (1):
      spi: fsl-dspi: add cs-gpios support

Rajan Vaja (1):
      firmware: xilinx: Add qspi firmware interface

Ricardo Ribalda (1):
      spi: mediatek: Enable irq when pdata is ready

Rob Herring (1):
      spi: dt-bindings: Convert Synquacer SPI to DT schema

Tharun Kumar P (2):
      spi: microchip: pci1xxxx: Add driver for SPI controller of PCI1XXXX PCIe switch
      spi: microchip: pci1xxxx: Add suspend and resume support for PCI1XXXX SPI driver

Thomas Gleixner (1):
      spi: Remove the obsolte u64_stats_fetch_*_irq() users.

Tudor Ambarus (4):
      spi: dt-bindings: Introduce spi-cs-setup-ns property
      spi: Introduce spi-cs-setup-ns property
      spi: Reintroduce spi_set_cs_timing()
      spi: atmel-quadspi: Add support for configuring CS timing

Uwe Kleine-König (3):
      spi: bcm-qspi: Make bcm_qspi_remove() return void
      spi: sc18is602: Convert to i2c's .probe_new()
      spi: xcomm: Convert to i2c's .probe_new()

Xiangsheng Hou (1):
      spi: mtk-snfi: Add snfi support for MT7986 IC

Yang Yingliang (7):
      spi: bcm63xx: Use devm_platform_get_and_ioremap_resource()
      spi: cadence-quadspi: Use devm_platform_{get_and_}ioremap_resource()
      spi: img-spfi: Use devm_platform_get_and_ioremap_resource()
      spi: aspeed: Use devm_platform_{get_and_}ioremap_resource()
      spi: npcm-fiu: Use devm_platform_ioremap_resource_byname()
      spi: mxic: Use devm_platform_ioremap_resource_byname()
      spi: introduce new helpers with using modern naming

bayi cheng (3):
      spi: spi-mtk-nor: Optimize timeout for dma read
      spi: spi-mtk-nor: Unify write buffer on/off
      spi: spi-mtk-nor: Add recovery mechanism for dma read timeout

 .../bindings/spi/amlogic,meson-gx-spicc.yaml       |  75 ++-
 .../devicetree/bindings/spi/nuvoton,npcm-fiu.txt   |   2 +-
 .../bindings/spi/nuvoton,wpcm450-fiu.yaml          |  66 ++
 .../devicetree/bindings/spi/socionext,f-ospi.yaml  |  57 ++
 .../bindings/spi/socionext,synquacer-spi.yaml      |  73 +++
 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     |   8 +
 .../bindings/spi/spi-peripheral-props.yaml         |   5 +
 .../devicetree/bindings/spi/spi-synquacer.txt      |  27 -
 .../devicetree/bindings/spi/spi-zynqmp-qspi.yaml   |   4 +-
 Documentation/driver-api/spi.rst                   |   4 +-
 MAINTAINERS                                        |   2 +-
 drivers/firmware/xilinx/zynqmp.c                   |   7 +
 drivers/i2c/i2c-core-base.c                        |  14 +
 drivers/spi/Kconfig                                |  31 +-
 drivers/spi/Makefile                               |   3 +
 drivers/spi/atmel-quadspi.c                        |  34 +
 drivers/spi/spi-aspeed-smc.c                       |   6 +-
 drivers/spi/spi-bcm-qspi.c                         |   5 +-
 drivers/spi/spi-bcm-qspi.h                         |   2 +-
 drivers/spi/spi-bcm63xx.c                          |   3 +-
 drivers/spi/spi-brcmstb-qspi.c                     |   4 +-
 drivers/spi/spi-cadence-quadspi.c                  |  15 +-
 drivers/spi/spi-cadence-xspi.c                     |   4 -
 drivers/spi/spi-fsl-cpm.c                          |   2 +-
 drivers/spi/spi-fsl-dspi.c                         |  36 +-
 drivers/spi/spi-fsl-lpspi.c                        |   5 +
 drivers/spi/spi-gpio.c                             |  16 +-
 drivers/spi/spi-hisi-sfc-v3xx.c                    |   2 +-
 drivers/spi/spi-img-spfi.c                         |   3 +-
 drivers/spi/spi-imx.c                              |   8 -
 drivers/spi/spi-intel.c                            |  78 +--
 drivers/spi/spi-iproc-qspi.c                       |   4 +-
 drivers/spi/spi-meson-spicc.c                      |  39 +-
 drivers/spi/spi-microchip-core.c                   |   9 -
 drivers/spi/spi-mt65xx.c                           |  12 +-
 drivers/spi/spi-mtk-nor.c                          |  69 +-
 drivers/spi/spi-mtk-snfi.c                         |  29 +-
 drivers/spi/spi-mxic.c                             |   3 +-
 drivers/spi/spi-npcm-fiu.c                         |   4 +-
 drivers/spi/spi-nxp-fspi.c                         |   2 +-
 drivers/spi/spi-pci1xxxx.c                         | 475 ++++++++++++++
 drivers/spi/spi-pxa2xx.c                           | 195 ++----
 drivers/spi/spi-sc18is602.c                        |   6 +-
 drivers/spi/spi-sn-f-ospi.c                        | 703 +++++++++++++++++++++
 drivers/spi/spi-wpcm-fiu.c                         | 508 +++++++++++++++
 drivers/spi/spi-xcomm.c                            |   5 +-
 drivers/spi/spi-zynqmp-gqspi.c                     | 191 ++++--
 drivers/spi/spi.c                                  |  70 +-
 drivers/spi/spidev.c                               |  21 +-
 include/linux/firmware/xlnx-zynqmp.h               |  19 +
 include/linux/i2c.h                                |   1 +
 include/linux/pxa2xx_ssp.h                         |   1 +
 include/linux/spi/spi.h                            |  54 +-
 53 files changed, 2631 insertions(+), 390 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/socionext,f-ospi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/socionext,synquacer-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-synquacer.txt
 create mode 100644 drivers/spi/spi-pci1xxxx.c
 create mode 100644 drivers/spi/spi-sn-f-ospi.c
 create mode 100644 drivers/spi/spi-wpcm-fiu.c
