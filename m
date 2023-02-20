Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3ED69CF7D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjBTOeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjBTOeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:34:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3111633E;
        Mon, 20 Feb 2023 06:34:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29F22B80B9A;
        Mon, 20 Feb 2023 14:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882B2C433EF;
        Mon, 20 Feb 2023 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676903655;
        bh=MRUurjcSRVJWFvlzNKFqFxKq3UkkeD0S4/mguQn8UKM=;
        h=From:To:Cc:Subject:Date:From;
        b=lcWt7aPmUOJKrWJiTGt1rHbCxKriR6awRwy5cC2MKzj9oPBh1jrivXXRBaHBY/qtJ
         BDnK28QwckIu1LfYBWEc1atIf9DZpgq77sHuwJ6Ur1pT1/3USx4+v9YDyeDaudPtrP
         uD4LW25izy7WevV0+rFhXif8I5hPZrhA4VvlBMxv3JUcEL/AnlIJvS83MBFKYRaFlK
         qKzxWduYB2j3df5gwLj900P+xZ9Ln2YFjXmrT6An70u1SrANddqxYbiSgojrv1hD4g
         XrELhYAPYxXePq5sgR33TMPbz0/IKas+/aJLc+hyCrCo8smFFMzsbl5XaIEtrOB3hU
         NvRU3seUVks3g==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.3
Date:   Mon, 20 Feb 2023 14:34:04 +0000
Message-Id: <20230220143415.882B2C433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit eede42c9459b58b71edc99303dad65216a655810:

  spi: spidev: fix a recursive locking error (2023-01-27 16:38:05 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.3

for you to fetch changes up to de82c25dab9ac0fa01c95b8914bde8d9ce528e93:

  Merge remote-tracking branch 'spi/for-6.3' into spi-next (2023-02-17 22:05:55 +0000)

----------------------------------------------------------------
spi: Updates for v6.3

This has been a fairly quiet release for SPI, though it is likely that
the next release will have some big changes as there's some preparatory
work for multiple chip select support gone in - the rest of the code is
on the list but will need to be rebased onto -rc1.  Otherwise there's a couple
of new tunables for chip select timings, some new devices and smaller
device specific updates and fixes.

 - Support for configuring the hold and minimum inactive times for chip
   selects.
 - Beginnings of support for supporting devices which have multiple chip
   selects on a single device.
 - Support for newer Broadcom HSSPI and Intel controllers, Silicon Labs
   EM3581 and SI3210.

There is a simple add/add conflict in MAINTAINERS with the I2C tree.

----------------------------------------------------------------
Alain Volmat (1):
      spi: spi-st-ssc: convert to DT schema

Amit Kumar Mahapatra (1):
      spi: Add APIs in spi core to set/get spi->chip_select and spi->cs_gpiod

Arnd Bergmann (1):
      spi: dw_bt1: fix MUX_MMIO dependencies

Bartosz Golaszewski (3):
      spi: spidev: fix a race condition when accessing spidev->spi
      spi: spidev: remove debug messages that access spidev->spi without locking
      spi: spidev: drop the incorrect notice from Kconfig

Christophe JAILLET (2):
      spi: Reorder fields in 'struct spi_transfer'
      spi: synquacer: Fix timeout handling in synquacer_spi_transfer_one()

Dan Carpenter (3):
      spi: spidev: Fix double unlock in spidev_sync()
      spi: bcmbca-hsspi: Fix error code in probe() function
      spi: bcm63xx-hsspi: fix error code in probe

Dhruva Gole (4):
      spi: cadence-quadspi: Reset CMD_CTRL Reg on cmd r/w completion
      spi: cadence-quadspi: Add flag for direct mode writes
      spi: cadence-quadspi: setup ADDR Bits in cmd reads
      spi: cadence-quadspi: use STIG mode for small reads

Geert Uytterhoeven (1):
      dt-bindings: trivial-devices: Remove trailing whitespace

Janne Grunau (2):
      spi: dt-bindings: Add hold/inactive CS delay peripheral properties
      spi: Parse hold/inactive CS delay values from the DT

Krzysztof Kozlowski (5):
      spi: spidev: order compatibles alphabetically
      dt-bindings: trivial-devices: document SPI dev compatibles
      spi: dt-bindings: drop unneeded quotes
      spi: dt-bindings: cleanup examples - indentation, lowercase hex
      spi: dt-bindings: qcom,spi-qcom-qspi: document OPP and power-domains

Mark Brown (11):
      spi: switch to use modern name
      spi: SPI core CS delay property rename From: Hector Martin <marcan@marcan.st> Date: Wed, 04 Jan 2023 18:36:26 +0900 Message-Id: <20230104093631.15611-1-marcan@marcan.st> MIME-Version: 1.0 Content-Type: text/plain; charset="utf-8" Content-Transfer-Encoding: 7bit
      SPI core CS delay fixes and additions
      spi: SPI core CS delay fixes and additions
      spi: atmel: switch to use modern name
      Merge remote-tracking branch 'spi/for-6.2' into spi-6.2
      spi: Abstract access to chip selects
      spi: Merge fixes
      Add MediaTek MT7986 SPI NAND support
      spi: STIG Mode Fixes for spi-cadence-qspi driver
      Merge remote-tracking branch 'spi/for-6.3' into spi-next

Mauro Lima (4):
      spi: intel: Fix device private data and PR_NUM for Broxton controllers
      spi: intel: Add support for controllers
      spi: intel: Remove DANGEROUS tag from pci driver
      spi: intel: Update help text of PCI and Platform drivers

Mika Westerberg (1):
      spi: intel: Check number of chip selects after reading the descriptor

Randy Dunlap (2):
      spi: Kconfig: fix a spelling mistake & hyphenation
      spi: correct spelling

Vadim Fedorenko (1):
      spi: xilinx: add force_irq for QSPI mode

Vijaya Krishna Nivarthi (1):
      spi: spi-geni-qcom: Add support for SE DMA mode

Vincent Tremblay (4):
      dt-bindings: trivial-devices: Add silabs,em3581
      spidev: Add Silicon Labs EM3581 device compatible
      dt-bindings: trivial-devices: Add silabs,si3210
      spidev: Add Silicon Labs SI3210 device compatible

Vincent Whitchurch (2):
      spi: pl022: Only use DT-specified DMA channels
      spi: spi-loopback-test: Allow skipping delays

William Zhang (15):
      spi: Convert bcm63xx-hsspi bindings to json-schema
      spi: Add bcmbca-hsspi controller bindings
      spi: bcm63xx-hsspi: Add new compatible string support
      spi: bcm63xx-hsspi: Endianness fix for ARM based SoC
      spi: bcm63xx-hsspi: Add polling mode support
      spi: export spi_transfer_cs_change_delay_exec function
      spi: bcm63xx-hsspi: Handle cs_change correctly
      spi: bcm63xx-hsspi: Fix multi-bit mode setting
      spi: bcm63xx-hsspi: Add prepend mode support
      spi: spi-mem: Allow controller supporting mem_ops without exec_op
      spi: bcm63xx-hsspi: Disable spi mem dual io read op support
      spi: bcmbca-hsspi: Add driver for newer HSSPI controller
      MAINTAINERS: Add entry for Broadcom Broadband SoC HS SPI drivers
      spi: bcm63xx-hsspi: bcmbca-hsspi: fix _be16 type usage
      MAINTAINERS: Remove file reference for Broadcom Broadband SoC HS SPI driver entry

Xiangsheng Hou (5):
      spi: mtk-snfi: Change default page format to setup default setting
      spi: mtk-snfi: Add optional nfi_hclk which is needed for MT7986
      spi: mtk-snfi: Add snfi sample delay and read latency adjustment
      spi: dt-bindings: mtk-snfi: Add compatible for MT7986
      spi: dt-bindings: mtk-snfi: Add read latch latency property

Yang Yingliang (9):
      spi: altera: switch to use modern name
      spi: spi-altera-dfl: switch to use modern name
      spi: spi-altera-platform: switch to use modern name
      spi: ath79: switch to use modern name
      spi: a3700: switch to use modern name
      spi: ar934x: switch to use modern name
      spi: atmel: switch to use modern name
      spi: at91-usart: switch to use modern name
      spi: atmel-quadspi: switch to use modern name

 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |   2 +-
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |   2 +-
 .../bindings/spi/amlogic,meson-gx-spicc.yaml       |  32 +-
 .../bindings/spi/amlogic,meson6-spifc.yaml         |  28 +-
 .../bindings/spi/aspeed,ast2600-fmc.yaml           |  26 +-
 .../bindings/spi/brcm,bcm63xx-hsspi.yaml           | 134 +++++
 .../devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml | 156 ++---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |  36 +-
 .../devicetree/bindings/spi/cdns,xspi.yaml         |   6 +-
 .../devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml  |   2 +-
 .../devicetree/bindings/spi/fsl-imx-cspi.yaml      |   2 +-
 .../bindings/spi/mediatek,spi-mt65xx.yaml          |   2 +-
 .../bindings/spi/mediatek,spi-mtk-snfi.yaml        |  54 +-
 .../bindings/spi/mediatek,spi-slave-mt27xx.yaml    |   2 +-
 .../bindings/spi/mikrotik,rb4xx-spi.yaml           |   2 +-
 .../devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml |   2 +-
 Documentation/devicetree/bindings/spi/mxs-spi.yaml |   2 +-
 .../bindings/spi/nvidia,tegra210-quad.yaml         |  44 +-
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           |  11 +-
 .../devicetree/bindings/spi/realtek,rtl-spi.yaml   |   2 +-
 .../devicetree/bindings/spi/renesas,rspi.yaml      |  22 +-
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |   2 +-
 .../devicetree/bindings/spi/spi-bcm63xx-hsspi.txt  |  33 --
 .../devicetree/bindings/spi/spi-cadence.yaml       |   2 +-
 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     |   2 +-
 .../devicetree/bindings/spi/spi-gpio.yaml          |   4 +-
 Documentation/devicetree/bindings/spi/spi-mux.yaml |   4 +-
 .../devicetree/bindings/spi/spi-nxp-fspi.yaml      |   2 +-
 .../bindings/spi/spi-peripheral-props.yaml         |  10 +
 .../devicetree/bindings/spi/spi-pl022.yaml         |  18 +-
 .../devicetree/bindings/spi/spi-rockchip.yaml      |   2 +-
 .../devicetree/bindings/spi/spi-sifive.yaml        |   6 +-
 .../devicetree/bindings/spi/spi-st-ssc.txt         |  40 --
 .../bindings/spi/spi-sunplus-sp7021.yaml           |   6 +-
 .../devicetree/bindings/spi/spi-xilinx.yaml        |   2 +-
 .../devicetree/bindings/spi/spi-zynqmp-qspi.yaml   |   2 +-
 .../devicetree/bindings/spi/sprd,spi-adi.yaml      |   5 +-
 .../devicetree/bindings/spi/st,ssc-spi.yaml        |  61 ++
 .../devicetree/bindings/spi/st,stm32-qspi.yaml     |   2 +-
 .../devicetree/bindings/spi/st,stm32-spi.yaml      |  25 +-
 .../devicetree/bindings/spi/xlnx,zynq-qspi.yaml    |   2 +-
 .../devicetree/bindings/trivial-devices.yaml       |  14 +
 Documentation/spi/pxa2xx.rst                       |  12 +-
 Documentation/spi/spi-lm70llp.rst                  |   2 +-
 Documentation/spi/spi-summary.rst                  |   2 +-
 MAINTAINERS                                        |  12 +
 drivers/spi/Kconfig                                |  38 +-
 drivers/spi/Makefile                               |   1 +
 drivers/spi/atmel-quadspi.c                        |   8 +-
 drivers/spi/spi-altera-core.c                      |  30 +-
 drivers/spi/spi-altera-dfl.c                       |  36 +-
 drivers/spi/spi-altera-platform.c                  |  36 +-
 drivers/spi/spi-ar934x.c                           |  10 +-
 drivers/spi/spi-armada-3700.c                      |  98 +--
 drivers/spi/spi-at91-usart.c                       |  40 +-
 drivers/spi/spi-ath79.c                            |  40 +-
 drivers/spi/spi-atmel.c                            | 254 ++++----
 drivers/spi/spi-bcm63xx-hsspi.c                    | 493 ++++++++++++++--
 drivers/spi/spi-bcmbca-hsspi.c                     | 654 +++++++++++++++++++++
 drivers/spi/spi-cadence-quadspi.c                  |  42 +-
 drivers/spi/spi-geni-qcom.c                        | 211 +++++--
 drivers/spi/spi-intel-pci.c                        |  13 +-
 drivers/spi/spi-intel.c                            |  10 +-
 drivers/spi/spi-loopback-test.c                    |   8 +-
 drivers/spi/spi-mem.c                              |   2 +-
 drivers/spi/spi-mtk-snfi.c                         |  41 +-
 drivers/spi/spi-pl022.c                            |   1 -
 drivers/spi/spi-synquacer.c                        |   7 +-
 drivers/spi/spi-xilinx.c                           |   9 +-
 drivers/spi/spi.c                                  |  92 +--
 drivers/spi/spidev.c                               |  13 +-
 include/linux/spi/altera.h                         |   4 +-
 include/linux/spi/spi.h                            |  32 +-
 include/linux/spi/xilinx_spi.h                     |   1 +
 74 files changed, 2293 insertions(+), 772 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-st-ssc.txt
 create mode 100644 Documentation/devicetree/bindings/spi/st,ssc-spi.yaml
 create mode 100644 drivers/spi/spi-bcmbca-hsspi.c
