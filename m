Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5093699542
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBPNLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBPNL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:11:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE264DE12;
        Thu, 16 Feb 2023 05:11:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A014261F93;
        Thu, 16 Feb 2023 13:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6FAC433D2;
        Thu, 16 Feb 2023 13:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676553086;
        bh=8HP84T5xzTRr9arAoHmnKo6b5R2ydrxAxiMz5UoJk48=;
        h=From:To:Cc:Subject:Date:From;
        b=nsgN+DylRHOeYfbNBL3d5LynFqrvEDtAq+9S+91FueoLIL66qy/mlTIHSrEl8vBY1
         Y9xLSi6+OrTVpzjfSO5WTjTuaNsO0sUhHqHtfFKoz/TfqP8PiiRhX8JlpuSFZxP1d8
         gFU3jPbo1M1F+8Z3PJXIDKfvfZMFUztHJMCu21DntDRE/ezqpFuf0PI+vXt7/4dNYp
         fo1DvKAL2rELShnba2yLTbnfCfmbhTBfxCl5OegC0cMfdR7PW+766nLcXWR+pii/2w
         KmIjkvFnofwqwemLIPCZdkEtnx3rrV0HULr2OvSZ7d0nw73SFGMd92TOlc46jZ1KdN
         mSjdLGNgtICFA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.2-rc8-abi
Date:   Thu, 16 Feb 2023 13:11:08 +0000
Message-Id: <20230216131125.4A6FAC433D2@smtp.kernel.org>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.2-rc8-abi

for you to fetch changes up to 80323599e33f9c19287a1a3707481fb157b27052:

  MAINTAINERS: Add entry for Broadcom Broadband SoC HS SPI drivers (2023-02-10 21:36:45 +0000)

----------------------------------------------------------------
spi: Update for v6.2

One more last minute patch for v6.2 updating the parsing of the
newly added spi-cs-setup-delay-ns - it's been pointed out that
due to the way DT parsing works the change in property size is
ABI visible so let's not let a release go out without it being
fixed.  The change got split from some earlier ABI related fixes
to the property since the first version sent had a build error.

----------------------------------------------------------------
Amit Kumar Mahapatra (1):
      spi: Add APIs in spi core to set/get spi->chip_select and spi->cs_gpiod

Arnd Bergmann (1):
      spi: dw_bt1: fix MUX_MMIO dependencies

Bartosz Golaszewski (2):
      spi: spidev: fix a race condition when accessing spidev->spi
      spi: spidev: remove debug messages that access spidev->spi without locking

Dan Carpenter (1):
      spi: spidev: Fix double unlock in spidev_sync()

Geert Uytterhoeven (1):
      dt-bindings: trivial-devices: Remove trailing whitespace

Janne Grunau (3):
      spi: Use a 32-bit DT property for spi-cs-setup-delay-ns
      spi: dt-bindings: Add hold/inactive CS delay peripheral properties
      spi: Parse hold/inactive CS delay values from the DT

Krzysztof Kozlowski (4):
      spi: spidev: order compatibles alphabetically
      dt-bindings: trivial-devices: document SPI dev compatibles
      spi: dt-bindings: drop unneeded quotes
      spi: dt-bindings: cleanup examples - indentation, lowercase hex

Mark Brown (9):
      spi: switch to use modern name
      spi: SPI core CS delay property rename From: Hector Martin <marcan@marcan.st> Date: Wed, 04 Jan 2023 18:36:26 +0900 Message-Id: <20230104093631.15611-1-marcan@marcan.st> MIME-Version: 1.0 Content-Type: text/plain; charset="utf-8" Content-Transfer-Encoding: 7bit
      SPI core CS delay fixes and additions
      spi: SPI core CS delay fixes and additions
      spi: atmel: switch to use modern name
      Merge remote-tracking branch 'spi/for-6.2' into spi-6.2
      spi: Abstract access to chip selects
      spi: Merge fixes
      Add MediaTek MT7986 SPI NAND support

Mauro Lima (4):
      spi: intel: Fix device private data and PR_NUM for Broxton controllers
      spi: intel: Add support for controllers
      spi: intel: Remove DANGEROUS tag from pci driver
      spi: intel: Update help text of PCI and Platform drivers

Randy Dunlap (2):
      spi: Kconfig: fix a spelling mistake & hyphenation
      spi: correct spelling

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

William Zhang (13):
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
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           |   6 +-
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
 .../bindings/spi/spi-sunplus-sp7021.yaml           |   6 +-
 .../devicetree/bindings/spi/spi-xilinx.yaml        |   2 +-
 .../devicetree/bindings/spi/spi-zynqmp-qspi.yaml   |   2 +-
 .../devicetree/bindings/spi/sprd,spi-adi.yaml      |   5 +-
 .../devicetree/bindings/spi/st,stm32-qspi.yaml     |   2 +-
 .../devicetree/bindings/spi/st,stm32-spi.yaml      |  25 +-
 .../devicetree/bindings/spi/xlnx,zynq-qspi.yaml    |   2 +-
 .../devicetree/bindings/trivial-devices.yaml       |  14 +
 Documentation/spi/pxa2xx.rst                       |  12 +-
 Documentation/spi/spi-lm70llp.rst                  |   2 +-
 Documentation/spi/spi-summary.rst                  |   2 +-
 MAINTAINERS                                        |  12 +
 drivers/spi/Kconfig                                |  35 +-
 drivers/spi/Makefile                               |   1 +
 drivers/spi/atmel-quadspi.c                        |   8 +-
 drivers/spi/spi-altera-core.c                      |  30 +-
 drivers/spi/spi-altera-dfl.c                       |  36 +-
 drivers/spi/spi-altera-platform.c                  |  36 +-
 drivers/spi/spi-ar934x.c                           |  10 +-
 drivers/spi/spi-armada-3700.c                      |  98 ++--
 drivers/spi/spi-at91-usart.c                       |  40 +-
 drivers/spi/spi-ath79.c                            |  40 +-
 drivers/spi/spi-atmel.c                            | 254 ++++----
 drivers/spi/spi-bcm63xx-hsspi.c                    | 488 +++++++++++++--
 drivers/spi/spi-bcmbca-hsspi.c                     | 651 +++++++++++++++++++++
 drivers/spi/spi-geni-qcom.c                        | 211 +++++--
 drivers/spi/spi-intel-pci.c                        |  13 +-
 drivers/spi/spi-intel.c                            |   2 +-
 drivers/spi/spi-loopback-test.c                    |   8 +-
 drivers/spi/spi-mem.c                              |   2 +-
 drivers/spi/spi-mtk-snfi.c                         |  41 +-
 drivers/spi/spi-pl022.c                            |   1 -
 drivers/spi/spi.c                                  |  90 +--
 drivers/spi/spidev.c                               |  13 +-
 include/linux/spi/altera.h                         |   4 +-
 include/linux/spi/spi.h                            |  23 +-
 68 files changed, 2162 insertions(+), 708 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
 create mode 100644 drivers/spi/spi-bcmbca-hsspi.c
