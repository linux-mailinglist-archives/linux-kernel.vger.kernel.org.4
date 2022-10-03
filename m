Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC985F306E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 14:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJCMrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 08:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJCMrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AA720358;
        Mon,  3 Oct 2022 05:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 114646104A;
        Mon,  3 Oct 2022 12:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A30C433D6;
        Mon,  3 Oct 2022 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664801233;
        bh=keNr9g0gFrAYQ0FEhkmBmaa6oUOtnAu9nTjfWKPwZO4=;
        h=From:To:Cc:Subject:Date:From;
        b=SACFOd+E/1RGmjghfgmofvjC0dKU54ADXSBylS4xk09a/hNP2qmARaQDv3PPNSFLT
         crDGiC1eHFHetRhQMnLZ2xm5bkDaO1CB11oIJYHs7+C5KaPgcZOUVPcxFlcqmN8Yof
         LBpMnuHEds1MO280whDas7QqPn92gM+txPQV8NJCT2h5s/2Mqz5V+0aACbCgCbwjoO
         Pv5GNI18KSVxDpIRnHIZ4dzUcpkFMSfoDGpMTAK7edA0vCATmF8IPrLxOIfrLRj5o+
         qidsdFyeSQxfvaHw10BLl0ldIhl9xBgpeCYwZvVtH4atXDn/RLYRXvz7c+8fep37IX
         WJnjl+LaLJHfw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.1
Date:   Mon, 03 Oct 2022 13:47:03 +0100
Message-Id: <20221003124713.15A30C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.1

for you to fetch changes up to 8e9204cddcc3fea9affcfa411715ba4f66e97587:

  spi: Ensure that sg_table won't be used after being freed (2022-09-30 12:56:29 +0100)

----------------------------------------------------------------
spi: Updates for v6.1

With the exception of some refactoring to fix long standing issues
where we weren't handling cache syncs properly for messages which had
PIO and DMA transfers going to the same page correctly there has been o
work on the core this time around, and it's also been quite a quiet
release for the drivers too:

 - Fix cache syncs for cases where we have DMA and PIO transfers in the
   same message going to the same page.
 - Update the fsl_spi driver to use transfer_one() rather than a custom
   transfer function.
 - Support for configuring transfer speeds with the AMD SPI controller.
 - Support for a second chip select and 64K erase on Intel SPI.
 - Support for Microchip coreQSPI, Nuvoton NPCM845, NXP i.MX93, and
   Rockchip RK3128 and RK3588.

----------------------------------------------------------------
Andy Shevchenko (5):
      spi: stm32-qspi: Replace of_gpio_named_count() by gpiod_count()
      spi: stm32-qspi: Refactor dual flash mode enable check in ->setup()
      spi: nxp-fspi: Do not dereference fwnode in struct device
      spi: Group cs_change and cs_off flags together in struct spi_transfer
      spi: mpc52xx: Replace of_gpio_count() by gpiod_count()

Chanho Park (1):
      spi: s3c64xx: correct dma_chan pointer initialization

Christophe JAILLET (6):
      spi: microchip-core: Simplify some error message
      spi: lpspi: Simplify some error message
      spi: mt7621: Fix an error message in mt7621_spi_probe()
      spi: mt7621: Use the devm_clk_get_enabled() helper to simplify error handling
      spi: mt7621: Use devm_spi_register_controller()
      spi: mt7621: Remove 'clk' from 'struct mt7621_spi'

Christophe Leroy (2):
      spi: Add capability to perform some transfer with chipselect off
      spi: fsl_spi: Convert to transfer_one

Cristian Ciocaltea (1):
      spi: amd: Setup all xfers before opcode execution

Dan Carpenter (1):
      spi: omap2-mcspi: Fix probe so driver works again

Dmitry Torokhov (1):
      spi: spi-mpc52xx: switch to using gpiod API

Geert Uytterhoeven (1):
      spi: renesas,sh-msiof: Add r8a779g0 support

Johan Jonker (2):
      rockchip: add rockchip,rk3128-spi
      spi: rockchip: add power-domains property

Krzysztof Kozlowski (3):
      spi: dt-bindings: nvidia,tegra210-quad-peripheral-props: correct additional properties
      spi/panel: dt-bindings: drop 3-wire from common properties
      spi: dt-bindings: snps,dw-apb-ssi: drop ref from reg-io-width

Lad Prabhakar (1):
      spi: renesas,sh-msiof: Fix 'unevaluatedProperties' warnings

Lucas Tanure (1):
      spi: amd: Configure device speed

Marek Szyprowski (1):
      spi: Ensure that sg_table won't be used after being freed

Mark Brown (8):
      Merge remote-tracking branch 'spi/for-5.20' into spi-6.0
      Add support for Microchip QSPI controller
      spi: npcm-pspi: add Arbel NPCM8XX support
      spi: stm32_qspi: use QSPI bus as 8 lines communication channel
      spi: add generic R-Car Gen4 and specific r8a779f0 support
      spi: mt7621: Fix an erroneous message + clean-ups
      spi: Merge tag 'v6.0-rc4' into spi-6.1
      Fix PM disable depth imbalance in probe

Mika Westerberg (2):
      spi: intel: Add support for second flash chip
      spi: intel: 64k erase is supported from Canon Lake and beyond

Naga Sureshkumar Relli (4):
      spi: dt-binding: document microchip coreQSPI
      spi: dt-binding: add coreqspi as a fallback for mpfs-qspi
      spi: microchip-core-qspi: Add support for microchip fpga qspi controllers
      MAINTAINERS: add qspi to Polarfire SoC entry

Neil Armstrong (1):
      spi: meson-spicc: do not rely on busy flag in pow2 clk ops

Patrice Chotard (3):
      spi: stm32_qspi: Add transfer_one_message() spi callback
      spi: stm32-qspi: Fix stm32_qspi_transfer_one_message() error path
      spi: stm32-qspi: Fix pm_runtime management in stm32_qspi_transfer_one_message()

Peng Fan (2):
      spi: dt-bindings: lpspi: add i.MX93 compatible
      spi: lpspi: add dmas property

Sebastian Reichel (1):
      spi: spi-rockchip: Add rk3588-spi compatible

Serge Semin (1):
      spi: dw: Quite logging on deferred controller registration

Sergio Paracuellos (1):
      spi: migrate mt7621 text bindings to YAML

Shang XiaoJing (2):
      spi: cadence: Remove redundant dev_err call
      spi: aspeed: Remove redundant dev_err call

Shreeya Patel (1):
      spi: amd: Fix speed selection

Tomer Maimon (2):
      dt-binding: spi: npcm-pspi: Add npcm845 compatible
      spi: npcm-pspi: Add NPCM845 peripheral SPI support

Vincent Whitchurch (5):
      spi: spi-loopback-test: Add test to trigger DMA/PIO mixing
      spi: Save current RX and TX DMA devices
      spi: Fix cache corruption due to DMA/PIO overlap
      spi: Split transfers larger than max size
      spi: s3c64xx: Fix large transfers with DMA

Wei Yongjun (1):
      spi: meson-spicc: make symbol 'meson_spicc_pow2_clk_ops' static

Wolfram Sang (4):
      spi: move from strlcpy with unused retval to strscpy
      spi: renesas,sh-msiof: Add generic Gen4 and r8a779f0 support
      spi: sh-msiof: add generic Gen4 binding
      spi: renesas,sh-msiof: R-Car V3U is R-Car Gen4

Xu Qiang (2):
      spi: qup: add missing clk_disable_unprepare on error in spi_qup_resume()
      spi: qup: add missing clk_disable_unprepare on error in spi_qup_pm_resume_runtime()

Yang Yingliang (8):
      spi: omap2-mcspi: Switch to use dev_err_probe() helper
      spi: xtensa-xtfpga: Switch to use devm_spi_alloc_master()
      spi: xilinx: Switch to use devm_spi_alloc_master()
      spi: s3c24xx: Switch to use devm_spi_alloc_master()
      spi: spi-fsl-dspi: Use devm_platform_get_and_ioremap_resource()
      spi: spi-fsl-lpspi: Use devm_platform_get_and_ioremap_resource()
      spi: spi-fsl-qspi: Use devm_platform_ioremap_resource_byname()
      spi: spi-gxp: Use devm_platform_ioremap_resource()

Zhang Qilong (4):
      spi: img-spfi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      spi: cadence-quadspi: Fix PM disable depth imbalance in cqspi_probe
      spi: dw: Fix PM disable depth imbalance in dw_spi_bt1_probe
      spi/omap100k:Fix PM disable depth imbalance in omap1_spi100k_probe

ye xingchen (2):
      spi: pxa2xx: Remove the unneeded result variable
      spi: lpspi: Remove the unneeded result variable

zhichao.liu (1):
      spi: mt65xx: Add dma max segment size declaration

 .../display/panel/kingdisplay,kd035g6-54nt.yaml    |   2 +
 .../display/panel/leadtek,ltk035c5444t.yaml        |   2 +
 .../bindings/display/panel/samsung,s6e63m0.yaml    |   4 +
 .../bindings/spi/microchip,mpfs-spi.yaml           |  15 +-
 .../devicetree/bindings/spi/nuvoton,npcm-pspi.txt  |   3 +-
 .../spi/nvidia,tegra210-quad-peripheral-props.yaml |   3 +-
 .../devicetree/bindings/spi/ralink,mt7621-spi.yaml |  61 +++
 .../devicetree/bindings/spi/renesas,sh-msiof.yaml  |  14 +-
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |   1 -
 .../devicetree/bindings/spi/spi-controller.yaml    |   5 +
 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     |  14 +-
 .../devicetree/bindings/spi/spi-mt7621.txt         |  26 -
 .../bindings/spi/spi-peripheral-props.yaml         |   5 -
 .../devicetree/bindings/spi/spi-rockchip.yaml      |   5 +
 MAINTAINERS                                        |   1 +
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-amd.c                              | 183 +++++--
 drivers/spi/spi-aspeed-smc.c                       |   4 +-
 drivers/spi/spi-cadence-quadspi.c                  |   3 +-
 drivers/spi/spi-cadence-xspi.c                     |   4 +-
 drivers/spi/spi-dw-bt1.c                           |   4 +-
 drivers/spi/spi-dw-core.c                          |   2 +-
 drivers/spi/spi-fsl-dspi.c                         |   3 +-
 drivers/spi/spi-fsl-lpspi.c                        |  10 +-
 drivers/spi/spi-fsl-qspi.c                         |   3 +-
 drivers/spi/spi-fsl-spi.c                          | 157 ++----
 drivers/spi/spi-gxp.c                              |  10 +-
 drivers/spi/spi-img-spfi.c                         |   6 +-
 drivers/spi/spi-intel.c                            | 164 +++++-
 drivers/spi/spi-loopback-test.c                    |  27 +
 drivers/spi/spi-meson-spicc.c                      |   8 +-
 drivers/spi/spi-microchip-core-qspi.c              | 600 +++++++++++++++++++++
 drivers/spi/spi-microchip-core.c                   |   4 +-
 drivers/spi/spi-mpc52xx.c                          |  35 +-
 drivers/spi/spi-mt65xx.c                           |   5 +
 drivers/spi/spi-mt7621.c                           |  42 +-
 drivers/spi/spi-npcm-pspi.c                        |   1 +
 drivers/spi/spi-nxp-fspi.c                         |   8 +-
 drivers/spi/spi-omap-100k.c                        |   1 +
 drivers/spi/spi-omap2-mcspi.c                      |   4 +-
 drivers/spi/spi-pxa2xx.c                           |   4 +-
 drivers/spi/spi-qup.c                              |  21 +-
 drivers/spi/spi-s3c24xx.c                          |  24 +-
 drivers/spi/spi-s3c64xx.c                          |  13 +-
 drivers/spi/spi-sh-msiof.c                         |   1 +
 drivers/spi/spi-stm32-qspi.c                       | 125 ++++-
 drivers/spi/spi-xilinx.c                           |  20 +-
 drivers/spi/spi-xtensa-xtfpga.c                    |  16 +-
 drivers/spi/spi.c                                  | 157 ++++--
 include/linux/spi/spi.h                            |   6 +
 51 files changed, 1430 insertions(+), 416 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/ralink,mt7621-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-mt7621.txt
 create mode 100644 drivers/spi/spi-microchip-core-qspi.c
