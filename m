Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229206EF442
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbjDZM2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbjDZM2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:28:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059D23C11;
        Wed, 26 Apr 2023 05:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86B0A62EFC;
        Wed, 26 Apr 2023 12:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1D0C433EF;
        Wed, 26 Apr 2023 12:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682512082;
        bh=NMSod/a0aC08JUVIAXiY6jzbWB70G6qu4B/J8iaymoc=;
        h=From:To:Cc:Subject:Date:From;
        b=UvcOJ7vUV318LbySU9FSlIstrtbeVZQ3XSfPdG1M+hbNVpoorPEzR3hnMLy8bGsKt
         Hi4Kc0uk6TquBOX4gazjMV1IbcQxtp1aC6AOEjhv2W8yIICkuu8i5V6GTooPy+Bg0N
         R4hKw83/0daFemtnYzrdMf81QT8GFWfTWAPt1bXQK3gvWitvKWS/IpmY+u1iLGxAJE
         cen99o4J15itrGbhMGsxegNiLokgF/WlwqkXKt5aeQznySw7r9AkuG8A8DxoCuSwch
         xL3i0B9EoePrCgNxkqAGwYNhBJ0lS6JB36NdtbL+RfTHeZ276UHmc4MQCw4ibCCxeE
         yBHtA0UGZx+tw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.4
Date:   Wed, 26 Apr 2023 13:27:51 +0100
Message-Id: <20230426122801.5B1D0C433EF@smtp.kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.4

for you to fetch changes up to cc5f6fa4f6590e3b9eb8d34302ea43af4a3cfed7:

  spi: bcm63xx: use macro DEFINE_SIMPLE_DEV_PM_OPS (2023-04-25 16:55:45 +0100)

----------------------------------------------------------------
spi: Updates for v6.4

A fairly standard release for SPI with the exception of a change to the
API for specifying chip selects done in preparation for supporting
devices with more than one chip select, this required some mechanical
changes throughout the tree which have been cooking in -next happily for
a while.  There's also a new API to allow us to TPM chips on half duplex
controllers.

There's three commits in here that were mangled by a bad interaction
between the alsa-devel mailing list software and b4, I didn't notice
until there were merges on top with it being SPI not ALSA.  It seemed
clear enough to not be worth going back and fixing.

 - Refactoring in preparation for supporting multiple chip selects for a
   single device, needed by some flash devices, which required a change
   in the SPI device API visible throughout the tree.
 - Support for hardware assisted interaction with SPI TPMs on half
   duplex controllers, implemented on nVidia Tedra210 QuadSPI.
 - Optimisation for large transfers on fsl-cpm devices.
 - Cleanups around device property use which fix some sisues with
   fwnode.
 - Use of both void remove() and devm_platform_.*ioremap_resource().
 - Support for AMD Pensando Elba, Amlogic A1, Cadence device mode,
   Intel MetorLake-S and StarFive J7110 QuadSPI.

The final commit converting to DEV_PM_OPS() was applied late to fix a
warning that was introduced by some of the earlier work.

----------------------------------------------------------------
Alexander Stein (1):
      spi: nxp-flexspi: Add i.MX platform dependency

Amit Kumar Mahapatra (5):
      net: Replace all spi->chip_select and spi->cs_gpiod references with function call
      iio: imu: Replace all spi->chip_select and spi->cs_gpiod references with function call
      staging: Replace all spi->chip_select and spi->cs_gpiod references with function call
      powerpc/83xx/mpc832x_rdb: Replace all spi->chip_select references with function call
      ALSA: hda: cs35l41: Replace all spi->chip_select references with function call

Amit Kumar Mahapatra via Alsa-devel (3):
      spi: Replace all spi->chip_select and spi->cs_gpiod references with function call
      mtd: devices: Replace all spi->chip_select and spi->cs_gpiod references with function call
      platform/x86: serial-multi-instantiate: Replace all spi->chip_select and spi->cs_gpiod references with function call

Andi Shyti (1):
      MAINTAINERS: update Andi's e-mail to @kernel.org

Andy Shevchenko (7):
      spi: Propagate firmware node
      spi: mpc5xxx-psc: Correct error check for devm_platform_get_and_ioremap_resource()
      spi: mpc5xxx-psc: Return immediately if IRQ resource is unavailable
      spi: mpc5xxx-psc: use devm_clk_get_enabled() for core clock
      spi: mpc5xxx-psc: Propagate firmware node
      spi: mpc5xxx-psc: Consistently use device property APIs
      spi: mpc5xxx-psc: Remove goto to the unexisted label

Arnd Bergmann (1):
      spi: fsi: restore CONFIG_FSI dependency

Brad Larson (2):
      spi: dw: Add AMD Pensando Elba SoC SPI Controller
      spi: dw: Add support for AMD Pensando Elba SoC

Christophe JAILLET (1):
      spi: Reorder fields in 'struct spi_message'

Christophe Leroy (5):
      spi: fsl-spi: Fix CPM/QE mode Litte Endian
      spi: fsl-spi: Re-organise transfer bits_per_word adaptation
      spi: fsl-cpm: Use 16 bit mode for large transfers with even size
      spi: fsl-spi: Change mspi_apply_cpu_mode_quirks() to void
      spi: fsl-spi: No need to check transfer length versus word size

Dhruva Gole (4):
      spi: cadence-quadspi: fix suspend-resume implementations
      spi: cadence-quadspi: use macro DEFINE_SIMPLE_DEV_PM_OPS
      spi: bcm63xx: remove PM_SLEEP based conditional compilation
      spi: bcm63xx: use macro DEFINE_SIMPLE_DEV_PM_OPS

Douglas Anderson (1):
      spi: spi-qcom-qspi: Support pinctrl sleep states

Geert Uytterhoeven (7):
      spi: Replace spi_pcpu_stats_totalize() macro by a C function
      spi: fsl-dspi: Remove unneeded cast to same type
      spi: Constify spi_get_ctldata()'s spi parameter
      spi: Constify spi_get_drvdata()'s spi parameter
      spi: Constify spi parameters of chip select APIs
      spi: sh-msiof: Remove casts to drop constness
      spi: renesas,sh-msiof: Miscellaneous improvements

Haibo Chen (2):
      spi: spi-nxp-fspi: correct the comment for the DLL config
      spi: spi-nxp-fspi: use DLL calibration when clock rate > 100MHz

Jaewon Kim (1):
      spi: s3c64xx: add no_cs description

Jiapeng Chong (1):
      spi/bcm63xx: Remove the unused function bcm_spi_readw()

Kevin Groeneveld (1):
      spi: spi-imx: fix MX51_ECSPI_* macros when cs > 3

Krishna Yarlagadda (2):
      spi: Add TPM HW flow flag
      spi: tegra210-quad: Enable TPM wait polling

Krzysztof Kozlowski (5):
      spi: pxa2xx: Mark OF related data as maybe unused
      spi: bcm-qspi: Mark OF related data as maybe unused
      spi: sh-msiof: Mark OF related data as maybe unused
      spi: sc18is602: Mark OF related data as maybe unused
      spi: rspi: Mark OF related data as maybe unused

Kunihiko Hayashi (1):
      spi: f_ospi: Add missing spi_mem_default_supports_op() helper

Leonard Göhrs (2):
      spi: core: add spi_split_transfers_maxwords
      spi: stm32: split large transfers based on word size instead of bytes

Lizhe (2):
      drivers/spi-rockchip.c : Use devm_platform_get_and_ioremap_resource makes code better
      drivers/spi-rockchip.c : Remove redundant variable slave

Lukas Bulwahn (1):
      spi: docs: adjust summary to CONFIG_SYSFS_DEPRECATED removal

Mark Brown (21):
      spi: rockchip: Add architecture dependency
      spi: nxp-flexspi: Fix ARCH_LAYERSCAPE dependency
      spi: davinci: Make available for build test
      spi: fsi: Make available for build test
      spi: qcom-qspi: Make available for build test
      spi: mpc52xx-psc: Modernize probe
      spi: Build coverage cleanups and improvements
      Add Quad SPI driver for StarFive JH7110 SoC
      spi: Convert to platform remove callback returning
      spi: mpc5xxx-psc: Clean up even more and fix
      Add support for stacked/parallel memories
      Merge tag 'v6.3-rc2' into spi-6.4 to fix clock related boot issues
      spi: struct spi_device constification
      spi: atmel-quadspi: Convert to platform remove
      spi: imx: Fix cleanup in remove and convert to
      spi: sprd: Convert to platform remove callback
      spi: qup: Convert to platform remove callback
      spi: mchp-pci1xxxx: Fix minor bugs in spi-pci1xxxx
      spi: cadence-quadspi: Fix random issues with Xilinx
      spi: spi-cadence: Add Slave mode support
      Tegra TPM driver with HW flow control

Martin Kurbanov (2):
      dt-bindings: spi: add Amlogic A1 SPI controller
      spi: add support for Amlogic A1 SPI Flash Controller

Md Sadre Alam (1):
      spi: qup: Use devm_platform_get_and_ioremap_resource()

Mika Westerberg (1):
      spi: intel-pci: Add support for Meteor Lake-S SPI serial flash

Rob Herring (4):
      spi: mpc5xxx-psc: Remove unused platform_data
      spi: mpc5xxx-psc: Convert probe to use devres functions
      spi: mpc5xxx-psc: Use platform resources instead of parsing DT properties
      spi: omap2-mcspi: Use of_property_read_bool() for boolean properties

Rohit Ner (1):
      spi: spi-loopback-test: Add module param for iteration length

Sai Krishna Potthuri (2):
      spi: cadence-quadspi: Update the read timeout based on the length
      spi: cadence-quadspi: Disable the SPI before reconfiguring

Srinivas Goud (2):
      spi: spi-cadence: Switch to spi_controller structure
      spi: spi-cadence: Add support for Slave mode

Tharun Kumar P (3):
      spi: mchp-pci1xxxx: Fix length of SPI transactions not set properly in driver
      spi: mchp-pci1xxxx: Fix SPI transactions not working after suspend and resume
      spi: mchp-pci1xxxx: Fix improper implementation of disabling chip select lines

Uwe Kleine-König (94):
      spi: ar934x: Convert to platform remove callback returning void
      spi: armada-3700: Convert to platform remove callback returning void
      spi: aspeed-smc: Convert to platform remove callback returning void
      spi: at91-usart: Convert to platform remove callback returning void
      spi: ath79: Convert to platform remove callback returning void
      spi: atmel: Convert to platform remove callback returning void
      spi: au1550: Convert to platform remove callback returning void
      spi: axi-spi-engine: Convert to platform remove callback returning void
      spi: bcm2835aux: Convert to platform remove callback returning void
      spi: bcm63xx-hsspi: Convert to platform remove callback returning void
      spi: bcm63xx: Convert to platform remove callback returning void
      spi: bcmbca-hsspi: Convert to platform remove callback returning void
      spi: brcmstb-qspi: Convert to platform remove callback returning void
      spi: cadence-quadspi: Convert to platform remove callback returning void
      spi: cadence: Convert to platform remove callback returning void
      spi: cavium-octeon: Convert to platform remove callback returning void
      spi: coldfire-qspi: Convert to platform remove callback returning void
      spi: davinci: Convert to platform remove callback returning void
      spi: dln2: Convert to platform remove callback returning void
      spi: dw-bt1: Convert to platform remove callback returning void
      spi: dw-mmio: Convert to platform remove callback returning void
      spi: ep93xx: Convert to platform remove callback returning void
      spi: fsl-dspi: Convert to platform remove callback returning void
      spi: fsl-espi: Convert to platform remove callback returning void
      spi: fsl-lpspi: Convert to platform remove callback returning void
      spi: fsl-qspi: Convert to platform remove callback returning void
      spi: fsl-spi: Convert to platform remove callback returning void
      spi: geni-qcom: Convert to platform remove callback returning void
      spi: hisi-kunpeng: Convert to platform remove callback returning void
      spi: img-spfi: Convert to platform remove callback returning void
      spi: iproc-qspi: Convert to platform remove callback returning void
      spi: lantiq-ssc: Convert to platform remove callback returning void
      spi: meson-spicc: Convert to platform remove callback returning void
      spi: meson-spifc: Convert to platform remove callback returning void
      spi: microchip-core-qspi: Convert to platform remove callback returning void
      spi: microchip-core: Convert to platform remove callback returning void
      spi: mpc52xx: Convert to platform remove callback returning void
      spi: mtk-nor: Convert to platform remove callback returning void
      spi: mtk-snfi: Convert to platform remove callback returning void
      spi: mxic: Convert to platform remove callback returning void
      spi: mxs: Convert to platform remove callback returning void
      spi: npcm-fiu: Convert to platform remove callback returning void
      spi: npcm-pspi: Convert to platform remove callback returning void
      spi: nxp-fspi: Convert to platform remove callback returning void
      spi: oc-tiny: Convert to platform remove callback returning void
      spi: omap-uwire: Convert to platform remove callback returning void
      spi: omap2-mcspi: Convert to platform remove callback returning void
      spi: orion: Convert to platform remove callback returning void
      spi: pic32-sqi: Convert to platform remove callback returning void
      spi: pic32: Convert to platform remove callback returning void
      spi: ppc4xx: Convert to platform remove callback returning void
      spi: pxa2xx: Convert to platform remove callback returning void
      spi: qcom-qspi: Convert to platform remove callback returning void
      spi: rb4xx: Convert to platform remove callback returning void
      spi: rockchip-sfc: Convert to platform remove callback returning void
      spi: rockchip: Convert to platform remove callback returning void
      spi: rpc-if: Convert to platform remove callback returning void
      spi: rspi: Convert to platform remove callback returning void
      spi: s3c64xx: Convert to platform remove callback returning void
      spi: sh-hspi: Convert to platform remove callback returning void
      spi: sh-msiof: Convert to platform remove callback returning void
      spi: sh-sci: Convert to platform remove callback returning void
      spi: sh: Convert to platform remove callback returning void
      spi: sifive: Convert to platform remove callback returning void
      spi: slave-mt27xx: Convert to platform remove callback returning void
      spi: sn-f-ospi: Convert to platform remove callback returning void
      spi: sprd-adi: Convert to platform remove callback returning void
      spi: st-ssc4: Convert to platform remove callback returning void
      spi: stm32-qspi: Convert to platform remove callback returning void
      spi: stm32: Convert to platform remove callback returning void
      spi: sun4i: Convert to platform remove callback returning void
      spi: sun6i: Convert to platform remove callback returning void
      spi: sunplus-sp7021: Convert to platform remove callback returning void
      spi: synquacer: Convert to platform remove callback returning void
      spi: tegra114: Convert to platform remove callback returning void
      spi: tegra20-sflash: Convert to platform remove callback returning void
      spi: tegra20-slink: Convert to platform remove callback returning void
      spi: tegra210-quad: Convert to platform remove callback returning void
      spi: topcliff-pch: Convert to platform remove callback returning void
      spi: uniphier: Convert to platform remove callback returning void
      spi: xilinx: Convert to platform remove callback returning void
      spi: xtensa-xtfpga: Convert to platform remove callback returning void
      spi: zynq-qspi: Convert to platform remove callback returning void
      spi: zynqmp-gqspi: Convert to platform remove callback returning void
      spi: atmel-quadspi: Don't leak clk enable count in pm resume
      spi: atmel-quadspi: Free resources even if runtime resume failed in .remove()
      spi: atmel-quadspi: Convert to platform remove callback returning void
      spi: sprd: Don't skip cleanup in remove's error path
      spi: sprd: Convert to platform remove callback returning void
      spi: imx: Don't skip cleanup in remove's error path
      spi: imx: Convert to platform remove callback returning void
      spi: bcm2835: Convert to platform remove callback returning void
      spi: qup: Don't skip cleanup in remove's error path
      spi: qup: Convert to platform remove callback returning void

William Qiu (2):
      dt-bindings: qspi: cdns,qspi-nor: constrain minItems/maxItems of resets
      spi: cadence-quadspi: Add support for StarFive JH7110 QSPI

William Zhang (1):
      spi: Fix cocci warnings

Yang Li (11):
      spi: omap2-mcspi: Use devm_platform_get_and_ioremap_resource()
      spi: orion: Use devm_platform_get_and_ioremap_resource()
      spi: pic32: Use devm_platform_get_and_ioremap_resource()
      spi: sprd-adi: Use devm_platform_get_and_ioremap_resource()
      spi: sprd: Use devm_platform_get_and_ioremap_resource()
      spi: xilinx: Use devm_platform_get_and_ioremap_resource()
      spi: rockchip-sfc: Use devm_platform_ioremap_resource()
      spi: imx: Use devm_platform_get_and_ioremap_resource()
      spi: stm32: Use devm_platform_get_and_ioremap_resource()
      spi: tegra114: Use devm_platform_get_and_ioremap_resource()
      spi: tegra210-quad: Use devm_platform_get_and_ioremap_resource()

 .../devicetree/bindings/spi/amlogic,a1-spifc.yaml  |  41 ++
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |  37 +-
 .../devicetree/bindings/spi/renesas,sh-msiof.yaml  |  23 +-
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |  19 +
 Documentation/spi/spi-summary.rst                  |  23 +-
 MAINTAINERS                                        |   2 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |   2 +-
 drivers/iio/imu/adis16400.c                        |   2 +-
 drivers/mtd/devices/mtd_dataflash.c                |   2 +-
 drivers/net/ethernet/adi/adin1110.c                |   2 +-
 drivers/net/ethernet/asix/ax88796c_main.c          |   2 +-
 drivers/net/ethernet/davicom/dm9051.c              |   2 +-
 drivers/net/ethernet/qualcomm/qca_debug.c          |   2 +-
 drivers/net/ieee802154/ca8210.c                    |   2 +-
 drivers/net/wan/slic_ds26522.c                     |   2 +-
 drivers/net/wireless/marvell/libertas/if_spi.c     |   2 +-
 drivers/net/wireless/silabs/wfx/bus_spi.c          |   2 +-
 drivers/net/wireless/st/cw1200/cw1200_spi.c        |   2 +-
 drivers/platform/x86/serial-multi-instantiate.c    |   3 +-
 drivers/spi/Kconfig                                |  17 +-
 drivers/spi/Makefile                               |   1 +
 drivers/spi/atmel-quadspi.c                        |  36 +-
 drivers/spi/spi-altera-core.c                      |   2 +-
 drivers/spi/spi-amd.c                              |   4 +-
 drivers/spi/spi-amlogic-spifc-a1.c                 | 456 +++++++++++++++++++++
 drivers/spi/spi-ar934x.c                           |   8 +-
 drivers/spi/spi-armada-3700.c                      |  10 +-
 drivers/spi/spi-aspeed-smc.c                       |  18 +-
 drivers/spi/spi-at91-usart.c                       |   8 +-
 drivers/spi/spi-ath79.c                            |  10 +-
 drivers/spi/spi-atmel.c                            |  32 +-
 drivers/spi/spi-au1550.c                           |   9 +-
 drivers/spi/spi-axi-spi-engine.c                   |   8 +-
 drivers/spi/spi-bcm-qspi.c                         |  12 +-
 drivers/spi/spi-bcm2835.c                          |  36 +-
 drivers/spi/spi-bcm2835aux.c                       |  10 +-
 drivers/spi/spi-bcm63xx-hsspi.c                    |  36 +-
 drivers/spi/spi-bcm63xx.c                          |  24 +-
 drivers/spi/spi-bcmbca-hsspi.c                     |  36 +-
 drivers/spi/spi-brcmstb-qspi.c                     |   6 +-
 drivers/spi/spi-cadence-quadspi.c                  | 104 +++--
 drivers/spi/spi-cadence-xspi.c                     |   4 +-
 drivers/spi/spi-cadence.c                          | 334 +++++++++------
 drivers/spi/spi-cavium-octeon.c                    |   6 +-
 drivers/spi/spi-cavium.c                           |   8 +-
 drivers/spi/spi-coldfire-qspi.c                    |  14 +-
 drivers/spi/spi-davinci.c                          |  23 +-
 drivers/spi/spi-dln2.c                             |  12 +-
 drivers/spi/spi-dw-bt1.c                           |   6 +-
 drivers/spi/spi-dw-core.c                          |   2 +-
 drivers/spi/spi-dw-mmio.c                          |  68 ++-
 drivers/spi/spi-ep93xx.c                           |   6 +-
 drivers/spi/spi-falcon.c                           |   2 +-
 drivers/spi/spi-fsi.c                              |   2 +-
 drivers/spi/spi-fsl-cpm.c                          |  23 ++
 drivers/spi/spi-fsl-dspi.c                         |  24 +-
 drivers/spi/spi-fsl-espi.c                         |  12 +-
 drivers/spi/spi-fsl-lpspi.c                        |   7 +-
 drivers/spi/spi-fsl-qspi.c                         |  12 +-
 drivers/spi/spi-fsl-spi.c                          |  92 ++---
 drivers/spi/spi-geni-qcom.c                        |  11 +-
 drivers/spi/spi-gpio.c                             |   4 +-
 drivers/spi/spi-gxp.c                              |   4 +-
 drivers/spi/spi-hisi-kunpeng.c                     |   6 +-
 drivers/spi/spi-hisi-sfc-v3xx.c                    |   2 +-
 drivers/spi/spi-img-spfi.c                         |  20 +-
 drivers/spi/spi-imx.c                              |  75 ++--
 drivers/spi/spi-ingenic.c                          |   4 +-
 drivers/spi/spi-intel-pci.c                        |   1 +
 drivers/spi/spi-intel.c                            |   2 +-
 drivers/spi/spi-iproc-qspi.c                       |   6 +-
 drivers/spi/spi-jcore.c                            |   4 +-
 drivers/spi/spi-lantiq-ssc.c                       |  12 +-
 drivers/spi/spi-loopback-test.c                    |   8 +
 drivers/spi/spi-mem.c                              |   4 +-
 drivers/spi/spi-meson-spicc.c                      |   8 +-
 drivers/spi/spi-meson-spifc.c                      |   6 +-
 drivers/spi/spi-microchip-core-qspi.c              |   6 +-
 drivers/spi/spi-microchip-core.c                   |  12 +-
 drivers/spi/spi-mpc512x-psc.c                      | 142 ++-----
 drivers/spi/spi-mpc52xx-psc.c                      | 145 ++-----
 drivers/spi/spi-mpc52xx.c                          |   8 +-
 drivers/spi/spi-mt65xx.c                           |   6 +-
 drivers/spi/spi-mt7621.c                           |   2 +-
 drivers/spi/spi-mtk-nor.c                          |   6 +-
 drivers/spi/spi-mtk-snfi.c                         |   5 +-
 drivers/spi/spi-mux.c                              |   8 +-
 drivers/spi/spi-mxic.c                             |  16 +-
 drivers/spi/spi-mxs.c                              |   8 +-
 drivers/spi/spi-npcm-fiu.c                         |  25 +-
 drivers/spi/spi-npcm-pspi.c                        |   6 +-
 drivers/spi/spi-nxp-fspi.c                         |  74 +++-
 drivers/spi/spi-oc-tiny.c                          |   5 +-
 drivers/spi/spi-omap-uwire.c                       |  13 +-
 drivers/spi/spi-omap2-mcspi.c                      |  35 +-
 drivers/spi/spi-orion.c                            |  13 +-
 drivers/spi/spi-pci1xxxx.c                         |  22 +-
 drivers/spi/spi-pic32-sqi.c                        |   8 +-
 drivers/spi/spi-pic32.c                            |  13 +-
 drivers/spi/spi-pl022.c                            |   4 +-
 drivers/spi/spi-ppc4xx.c                           |   5 +-
 drivers/spi/spi-pxa2xx.c                           |  14 +-
 drivers/spi/spi-qcom-qspi.c                        |  13 +-
 drivers/spi/spi-qup.c                              |  31 +-
 drivers/spi/spi-rb4xx.c                            |   8 +-
 drivers/spi/spi-rockchip-sfc.c                     |  12 +-
 drivers/spi/spi-rockchip.c                         |  36 +-
 drivers/spi/spi-rpc-if.c                           |   6 +-
 drivers/spi/spi-rspi.c                             |  24 +-
 drivers/spi/spi-s3c64xx.c                          |   8 +-
 drivers/spi/spi-sc18is602.c                        |   6 +-
 drivers/spi/spi-sh-hspi.c                          |   6 +-
 drivers/spi/spi-sh-msiof.c                         |  13 +-
 drivers/spi/spi-sh-sci.c                           |   7 +-
 drivers/spi/spi-sh.c                               |   6 +-
 drivers/spi/spi-sifive.c                           |  12 +-
 drivers/spi/spi-slave-mt27xx.c                     |   6 +-
 drivers/spi/spi-sn-f-ospi.c                        |  10 +-
 drivers/spi/spi-sprd-adi.c                         |   8 +-
 drivers/spi/spi-sprd.c                             |  23 +-
 drivers/spi/spi-st-ssc4.c                          |   8 +-
 drivers/spi/spi-stm32-qspi.c                       |  18 +-
 drivers/spi/spi-stm32.c                            |  15 +-
 drivers/spi/spi-sun4i.c                            |   8 +-
 drivers/spi/spi-sun6i.c                            |   7 +-
 drivers/spi/spi-sunplus-sp7021.c                   |   5 +-
 drivers/spi/spi-synquacer.c                        |  12 +-
 drivers/spi/spi-tegra114.c                         |  37 +-
 drivers/spi/spi-tegra20-sflash.c                   |   8 +-
 drivers/spi/spi-tegra20-slink.c                    |  11 +-
 drivers/spi/spi-tegra210-quad.c                    |  31 +-
 drivers/spi/spi-ti-qspi.c                          |  16 +-
 drivers/spi/spi-topcliff-pch.c                     |  10 +-
 drivers/spi/spi-uniphier.c                         |   6 +-
 drivers/spi/spi-wpcm-fiu.c                         |  12 +-
 drivers/spi/spi-xcomm.c                            |   2 +-
 drivers/spi/spi-xilinx.c                           |  15 +-
 drivers/spi/spi-xlp.c                              |   4 +-
 drivers/spi/spi-xtensa-xtfpga.c                    |   6 +-
 drivers/spi/spi-zynq-qspi.c                        |   8 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |   8 +-
 drivers/spi/spi.c                                  | 102 +++--
 drivers/spi/spidev.c                               |   6 +-
 drivers/staging/fbtft/fbtft-core.c                 |   2 +-
 drivers/staging/greybus/spilib.c                   |   2 +-
 include/linux/platform_data/spi-s3c64xx.h          |   1 +
 include/linux/spi/spi.h                            |  36 +-
 include/trace/events/spi.h                         |  10 +-
 sound/pci/hda/cs35l41_hda_spi.c                    |   2 +-
 149 files changed, 1845 insertions(+), 1288 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/amlogic,a1-spifc.yaml
 create mode 100644 drivers/spi/spi-amlogic-spifc-a1.c
