Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C98573E0B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjFZNdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFZNdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:33:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC84E60;
        Mon, 26 Jun 2023 06:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEED760EAB;
        Mon, 26 Jun 2023 13:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F90C433C8;
        Mon, 26 Jun 2023 13:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687786423;
        bh=0mpOTHZyMM5CXUT/HTigyooJXwExSL5gS9PQQUSE2sE=;
        h=From:To:Cc:Subject:Date:From;
        b=hihqC0SeJ8LSDV6fwlmcXJEFCwACb4Zykw9qoqe8Fb9iBFLTrulgk7/8P4f/iWXF6
         3F8vpe52bDkD+/HXvtMS7bK09mDrhLozyGNnlAYaHrMuq4yT1ETFpaCp5sIKUIWkpb
         LCIJiaPsvL3jztIGuW4v/Vy5481OBCeAKyct+xySH6xztW6s0ChSCFSu852fVTk/9l
         Q3hLcVdj49aYroZwis8NSs/h9jOckd13xd+Hlxo1oVVhAS+RQ60R2Jv0tQvK+66XSq
         hejxoH6MDhrov4LOQP0lHKwXCG3OFwmVYdyts7Tjhepp0ZbKmXCpcjHR9IG9iq2Oln
         gF4qcYREGvYqA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.5
Date:   Mon, 26 Jun 2023 14:33:33 +0100
Message-Id: <20230626133342.B7F90C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0c331fd1dccfba657129380ee084b95c1cedfbef:

  spi: qup: Request DMA before enabling clocks (2023-05-30 13:43:31 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.5

for you to fetch changes up to e884a133340a470070b2c59833c9ff87aa6517ba:

  spi: dt-bindings: atmel,at91rm9200-spi: fix broken sam9x7 compatible (2023-06-24 12:25:34 +0100)

----------------------------------------------------------------
spi: Updates for v6.5

One small core feature this time around but mostly driver improvements
and additions for SPI:

 - Add support for controlling the idle state of MOSI, some systems can
   support this and depending on the system integration may need it to
   avoid glitching in some situations.
 - Support for polling mode in the S3C64xx driver and DMA on the
   Qualcomm QSPI driver.
 - Support for several Allwinner SoCs, AMD Pensando Elba, Intel Mount
   Evans, Renesas RZ/V2M, and ST STM32H7.

----------------------------------------------------------------
Abe Kohandel (3):
      spi: dw: Add compatible for Intel Mount Evans SoC
      spi: dt-bindings: snps,dw-apb-ssi: Add compatible for Intel Mount Evans SoC
      spi: dw: Remove misleading comment for Mount Evans SoC

Alain Volmat (3):
      spi: stm32: renaming of spi_master into spi_controller
      spi: stm32: use dmaengine_terminate_{a}sync instead of _all
      spi: stm32: disable spi-slave property for stm32f4-f7

Alexander Stein (1):
      spi: spi-fsl-lpspi: downgrade log level for pio mode

Andi Shyti (3):
      spi: s3c64xx: Use devm_clk_get_enabled()
      spi: s3c64xx: Use the managed spi master allocation function
      spi: s3c64xx: Use dev_err_probe()

Boerge Struempfel (5):
      spi: add SPI_MOSI_IDLE_LOW mode bit
      spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
      spi: spidev: add two new spi mode bits
      spi: spidev_test: Sorted the options into logical groups
      spi: spidev_test Add three missing spi mode bits

Brad Larson (2):
      spi: cadence-quadspi: Add compatible for AMD Pensando Elba SoC
      spi: cdns: Add compatible for AMD Pensando Elba SoC

Charles Keepax (1):
      spi: spi-cadence: Add missing kernel doc for clk_rate in cdns_spi

Clark Wang (1):
      spi: lpspi: run transfer speed_hz sanity check

Douglas Anderson (1):
      spi: spi-qcom-qspi: Add newline to PIO fallback warning

Fabrizio Castro (2):
      spi: dt-bindings: Add bindings for RZ/V2M CSI
      spi: Add support for Renesas CSI

Icenowy Zheng (1):
      spi: sun6i: change OF match data to a struct

Jaewon Kim (4):
      spi: s3c64xx: change polling mode to optional
      spi: s3c64xx: add sleep during transfer
      spi: s3c64xx: support interrupt based pio mode
      spi: s3c64xx: Disable IRQ mode when using DMA

Joy Chakraborty (5):
      spi: dw: Add 32 bpw support to SPI DW DMA driver
      spi: dw: Move dw_spi_can_dma()
      spi: dw: Add DMA directional capability check
      spi: dw: Add DMA address widths capability check
      spi: dw: Round of n_bytes to power of 2

Krzysztof Kozlowski (5):
      spi: dt-bindings: restrict node name suffixes
      spi: dt-bindings: allwinner: simplify with unevaluatedProperties
      spi: dt-bindings: samsung: drop cs-gpios
      spi: dt-bindings: socionext,uniphier: drop address/size-cells
      spi: dt-bindings: atmel,at91rm9200-spi: fix broken sam9x7 compatible

Lars-Peter Clausen (3):
      spi: spi-sn-f-ospi: Use devm_clk_get_enabled()
      spi: spi-sn-f-ospi: Use min_t instead of opencoding it
      spi: spi-sn-f-ospi: Make read-only array `width_available` static const

Maksim Kiselev (3):
      spi: sun6i: add quirk for in-controller clock divider
      spi: sun6i: add support for R329/D1/R528/T113s SPI controllers
      spi: sun6i: add DT bindings for Allwinner R329/D1/R528/T113s SPI

Mark Brown (9):
      Improve polling mode of s3c64xx driver
      spi: Add DMA mode support to spi-qcom-qspi
      spi: dw: DW SPI DMA Driver updates
      spi: Merge up v6.4-rc3
      spi: mt65xx: Convert to platform remove callback
      spi: add SPI_MOSI_IDLE_LOW mode bit
      spi: Merge up fixes to help CI
      spi: s3c64xx: Cleanups
      spi: Helper for deriving timeout values

Michal Simek (1):
      dt-bindings: spi: zynqmp-qspi: Add power-domains and iommus properties

Miquel Raynal (3):
      spi: Create a helper to derive adaptive timeouts
      spi: atmel: Prevent false timeouts on long transfers
      spi: sun6i: Use the new helper to derive the xfer timeout value

Mårten Lindahl (1):
      spi: spl022: Probe defer is no error

Neil Armstrong (1):
      spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from dma_request_chan()

Osama Muhammad (1):
      spi-dw-core.c: Fix error checking for debugfs_create_dir

Qii Wang (1):
      spi: mediatek: advertise the availability of Dual and Quad mode

Rasmus Villemoes (3):
      spi: spi-imx: use "controller" variable consistently in spi_imx_probe()
      spi: spi-imx: set max_native_cs for imx51/imx53/imx6 variants
      spi: spi-imx: fix mixing of native and gpio chipselects for imx51/imx53/imx6 variants

Serge Semin (1):
      spi: dw: Drop empty line from DebugFS init function

Uwe Kleine-König (4):
      spi: Switch i2c drivers back to use .probe()
      spi: mt65xx: Properly handle failures in .remove()
      spi: mt65xx: Convert to platform remove callback returning void
      spi: mt65xx: Don't disguise a "return 0" as "return ret"

Valentin Caron (2):
      spi: stm32: introduction of stm32h7 SPI device mode support
      spi: dt-bindings: stm32: do not disable spi-slave property for stm32f4-f7

Varshini Rajendran (1):
      spi: dt-bindings: atmel,at91rm9200-spi: add sam9x7 compatible

Vijaya Krishna Nivarthi (3):
      spi: dt-bindings: qcom,spi-qcom-qspi: Add iommus
      spi: spi-qcom-qspi: Add DMA mode support
      spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG

Yeqi Fu (1):
      spi: hisi-kunpeng: Fix error checking

 .mailmap                                           |    5 +
 CREDITS                                            |    4 +
 .../admin-guide/quickly-build-trimmed-linux.rst    |   49 +-
 Documentation/block/index.rst                      |    1 -
 Documentation/block/request.rst                    |   99 -
 Documentation/cdrom/index.rst                      |    6 +-
 .../devicetree/bindings/ata/ceva,ahci-1v84.yaml    |    2 +-
 .../bindings/display/msm/dsi-controller-main.yaml  |   12 +
 .../devicetree/bindings/media/i2c/ovti,ov2685.yaml |    1 +
 .../bindings/net/can/st,stm32-bxcan.yaml           |   19 +-
 .../bindings/pci/fsl,imx6q-pcie-common.yaml        |   13 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml |   38 +
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   77 +
 .../devicetree/bindings/sound/tas2562.yaml         |    6 +-
 .../devicetree/bindings/sound/tas2770.yaml         |    6 +-
 .../devicetree/bindings/sound/tas27xx.yaml         |    6 +-
 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |    8 +-
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |   18 +-
 .../bindings/spi/atmel,at91rm9200-spi.yaml         |    4 +
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |   18 +-
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           |    3 +
 .../devicetree/bindings/spi/renesas,rzv2m-csi.yaml |   70 +
 .../devicetree/bindings/spi/samsung,spi.yaml       |    2 -
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |    2 +
 .../bindings/spi/socionext,uniphier-spi.yaml       |    3 -
 .../devicetree/bindings/spi/spi-controller.yaml    |    2 +-
 .../devicetree/bindings/spi/spi-zynqmp-qspi.yaml   |    6 +
 .../filesystems/ramfs-rootfs-initramfs.rst         |    3 +-
 Documentation/filesystems/sharedsubtree.rst        |    4 +
 Documentation/fpga/index.rst                       |    2 +-
 Documentation/locking/index.rst                    |    2 +-
 Documentation/networking/bonding.rst               |    9 +-
 Documentation/networking/index.rst                 |    2 +-
 Documentation/networking/x25-iface.rst             |    3 +-
 Documentation/pcmcia/index.rst                     |    2 +-
 Documentation/s390/vfio-ap.rst                     |    1 -
 Documentation/staging/crc32.rst                    |    2 +-
 Documentation/timers/index.rst                     |    2 +-
 MAINTAINERS                                        | 2324 ++++++++++----------
 Makefile                                           |    2 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |    1 +
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi             |   82 +
 arch/arm/include/asm/arm_pmuv3.h                   |    6 +-
 arch/arm/kernel/unwind.c                           |   25 +-
 arch/arm/mach-sa1100/jornada720_ssp.c              |    5 +-
 arch/arm/vfp/entry.S                               |    7 +-
 arch/arm/vfp/vfphw.S                               |    6 +-
 arch/arm64/include/asm/arm_pmuv3.h                 |    6 +-
 arch/arm64/include/asm/cputype.h                   |    8 +
 arch/arm64/include/asm/kvm_pgtable.h               |    1 +
 arch/arm64/kernel/mte.c                            |    7 +-
 arch/arm64/kernel/vdso.c                           |    2 +-
 arch/arm64/kvm/fpsimd.c                            |   26 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |   12 +-
 arch/arm64/kvm/hyp/pgtable.c                       |   41 +-
 arch/arm64/kvm/inject_fault.c                      |    2 +-
 arch/arm64/kvm/vgic/vgic-v3.c                      |    4 +
 arch/arm64/kvm/vmid.c                              |    7 +-
 arch/arm64/mm/copypage.c                           |    5 +-
 arch/arm64/mm/fault.c                              |    4 +-
 arch/parisc/include/asm/pgtable.h                  |    8 +-
 arch/parisc/kernel/kexec.c                         |    2 +
 arch/powerpc/boot/Makefile                         |    6 +-
 arch/powerpc/crypto/Kconfig                        |    2 +-
 arch/powerpc/include/asm/iommu.h                   |    5 -
 arch/powerpc/kernel/dma-iommu.c                    |    4 +-
 arch/powerpc/kernel/iommu.c                        |   28 +-
 arch/powerpc/kernel/isa-bridge.c                   |    5 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c           |    4 +-
 arch/powerpc/net/bpf_jit_comp.c                    |    2 +
 arch/powerpc/platforms/Kconfig                     |    1 +
 arch/powerpc/platforms/powernv/pci.c               |   25 -
 arch/powerpc/platforms/pseries/iommu.c             |   38 +-
 arch/riscv/kernel/pi/Makefile                      |    2 +-
 arch/riscv/kernel/probes/Makefile                  |    2 +
 arch/riscv/kernel/vmlinux.lds.S                    |    7 +-
 arch/s390/Kconfig                                  |   11 +-
 arch/s390/configs/debug_defconfig                  |    3 +-
 arch/s390/configs/defconfig                        |    3 +-
 arch/s390/configs/zfcpdump_defconfig               |    1 +
 arch/s390/crypto/chacha-glue.c                     |    2 +-
 arch/s390/include/asm/compat.h                     |    2 +-
 arch/s390/include/uapi/asm/statfs.h                |    4 +-
 arch/s390/kernel/Makefile                          |    1 +
 arch/s390/kernel/ipl.c                             |    3 +-
 arch/s390/kernel/topology.c                        |   32 +-
 arch/um/drivers/Makefile                           |    4 +-
 arch/um/drivers/harddog.h                          |    9 +
 arch/um/drivers/harddog_kern.c                     |    7 +-
 arch/um/drivers/harddog_user.c                     |    1 +
 arch/um/drivers/harddog_user_exp.c                 |    9 +
 arch/x86/events/core.c                             |    6 +-
 arch/x86/events/intel/ds.c                         |   56 +-
 arch/x86/include/asm/perf_event.h                  |    3 +
 arch/x86/include/asm/vmx.h                         |    2 +
 arch/x86/kernel/Makefile                           |    1 +
 arch/x86/kernel/amd_nb.c                           |    2 +
 arch/x86/kvm/cpuid.c                               |   16 -
 arch/x86/kvm/vmx/sgx.c                             |   11 +-
 arch/x86/kvm/x86.c                                 |    6 +-
 arch/x86/lib/retpoline.S                           |    4 +-
 block/fops.c                                       |   12 +-
 drivers/acpi/resource.c                            |   12 +
 drivers/base/class.c                               |    2 +
 drivers/block/nbd.c                                |    4 +-
 drivers/block/rnbd/rnbd-proto.h                    |    2 +-
 drivers/block/ublk_drv.c                           |   11 +-
 drivers/char/tpm/tpm-chip.c                        |    4 +
 drivers/char/tpm/tpm-interface.c                   |   10 +
 drivers/char/tpm/tpm_tis.c                         |   16 +
 drivers/char/tpm/tpm_tis_core.c                    |   43 +-
 drivers/cpufreq/acpi-cpufreq.c                     |    2 +-
 drivers/cpufreq/pcc-cpufreq.c                      |    2 +-
 drivers/cxl/core/pci.c                             |    1 +
 drivers/firewire/net.c                             |   21 +-
 drivers/firmware/sysfb_simplefb.c                  |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |    8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   65 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   36 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |   21 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |    1 +
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   22 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |    8 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |    2 +-
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c   |   65 +
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h   |    2 +
 .../gpu/drm/amd/display/dc/dcn314/dcn314_init.c    |    2 +-
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.c |    5 +-
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.h |    1 +
 .../gpu/drm/amd/display/dc/link/link_validation.c  |    3 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |   25 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   18 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |   20 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |    1 +
 drivers/gpu/drm/ast/ast_main.c                     |    9 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   16 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |    2 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.h            |    4 +-
 drivers/gpu/drm/i915/Kconfig                       |   12 +-
 drivers/gpu/drm/i915/display/intel_atomic_plane.c  |    4 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |    5 +
 drivers/gpu/drm/i915/display/intel_hdcp.c          |   10 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c     |    7 +-
 drivers/gpu/drm/i915/i915_pci.c                    |    6 +
 .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    |   16 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h |    4 +-
 .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |    4 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h |    4 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h |    4 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h |    1 -
 .../drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h    |    1 -
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h |   12 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |    8 +-
 .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |   24 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |   16 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |   16 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   17 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  |   23 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |    5 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c          |    1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hwio.h           |    3 -
 drivers/gpu/drm/msm/dp/dp_audio.c                  |   12 +
 drivers/gpu/drm/msm/dp/dp_audio.h                  |    2 +
 drivers/gpu/drm/msm/dp/dp_display.c                |    1 +
 drivers/gpu/drm/msm/msm_atomic.c                   |    2 +
 drivers/gpu/drm/msm/msm_gem.c                      |   22 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |   25 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |    9 +-
 drivers/gpu/drm/nouveau/include/nvif/if0012.h      |    4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h    |    3 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c   |    2 +-
 drivers/gpu/drm/scheduler/sched_main.c             |    2 +-
 drivers/hwmon/k10temp.c                            |    1 +
 drivers/iommu/Kconfig                              |   16 -
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   10 +
 drivers/media/dvb-core/dvb_ca_en50221.c            |   49 +-
 drivers/media/dvb-core/dvb_demux.c                 |    4 +-
 drivers/media/dvb-core/dvb_frontend.c              |   69 +-
 drivers/media/dvb-core/dvb_net.c                   |   38 +-
 drivers/media/dvb-core/dvbdev.c                    |   84 +-
 drivers/media/dvb-frontends/mn88443x.c             |    2 +-
 drivers/media/pci/netup_unidvb/netup_unidvb_core.c |   19 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.c   |    3 +-
 .../media/platform/nxp/imx8-isi/imx8-isi-core.c    |    6 +-
 drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c  |   41 +-
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c |   21 +-
 drivers/media/usb/dvb-usb-v2/ce6230.c              |    8 +
 drivers/media/usb/dvb-usb-v2/ec168.c               |   12 +
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c            |   20 +
 drivers/media/usb/dvb-usb/az6027.c                 |   12 +
 drivers/media/usb/dvb-usb/digitv.c                 |    4 +
 drivers/media/usb/dvb-usb/dw2102.c                 |    2 +-
 drivers/media/usb/pvrusb2/Kconfig                  |    1 +
 drivers/media/usb/ttusb-dec/ttusb_dec.c            |    3 +-
 drivers/net/bonding/bond_netlink.c                 |    7 +-
 drivers/net/bonding/bond_options.c                 |    8 +-
 drivers/net/can/Kconfig                            |    2 +-
 drivers/net/can/bxcan.c                            |   34 +-
 drivers/net/can/dev/skb.c                          |    3 +-
 drivers/net/can/kvaser_pciefd.c                    |   51 +-
 drivers/net/dsa/mv88e6xxx/port.h                   |    2 +-
 drivers/net/dsa/rzn1_a5psw.c                       |   83 +-
 drivers/net/dsa/rzn1_a5psw.h                       |    3 +-
 drivers/net/ethernet/3com/3c515.c                  |    4 +-
 drivers/net/ethernet/8390/ne.c                     |    1 +
 drivers/net/ethernet/8390/smc-ultra.c              |    1 +
 drivers/net/ethernet/8390/wd.c                     |    1 +
 drivers/net/ethernet/amd/lance.c                   |    1 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |    8 +-
 drivers/net/ethernet/cirrus/cs89x0.c               |    2 +
 drivers/net/ethernet/freescale/fec_main.c          |   16 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   13 -
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.c    |   25 +-
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.h    |    8 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |    2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.h |    1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   15 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |    4 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |    5 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |    5 +-
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |    5 -
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c       |    5 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |    5 +
 drivers/net/ethernet/intel/ice/ice_sriov.c         |    8 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |    8 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h          |    9 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |   19 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |    1 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |    1 +
 drivers/net/ethernet/intel/igb/e1000_mac.c         |    4 +-
 drivers/net/ethernet/mediatek/mtk_wed.c            |    2 +-
 drivers/net/ethernet/mscc/vsc7514_regs.c           |   18 +-
 drivers/net/ethernet/netronome/nfp/nic/main.h      |    2 +-
 drivers/net/ethernet/sfc/ef100_netdev.c            |    4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |    1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |    5 +
 drivers/net/ethernet/sun/cassini.c                 |    2 +
 drivers/net/ipvlan/ipvlan_core.c                   |    6 +
 drivers/net/mdio/mdio-i2c.c                        |   15 +-
 drivers/net/mdio/mdio-mvusb.c                      |   11 +-
 drivers/net/pcs/pcs-xpcs.c                         |    4 +-
 drivers/net/phy/bcm-phy-lib.h                      |    5 +
 drivers/net/phy/bcm7xxx.c                          |    2 +-
 drivers/net/phy/dp83867.c                          |   22 +-
 drivers/net/phy/phylink.c                          |    8 +-
 drivers/net/tap.c                                  |    4 +-
 drivers/net/tun.c                                  |   15 +
 drivers/net/virtio_net.c                           |   61 +-
 drivers/net/wireless/broadcom/b43/b43.h            |    2 +-
 .../net/wireless/broadcom/b43legacy/b43legacy.h    |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |    5 +
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   11 +
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |   11 +
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   19 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |    5 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   55 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    1 +
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |   10 +
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c       |   16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |    3 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |    2 +-
 .../net/wireless/mediatek/mt76/mt76_connac2_mac.h  |    2 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |    2 +-
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |    1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |    4 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/main.c          |   15 +
 drivers/net/wireless/realtek/rtw88/main.h          |    3 +
 drivers/net/wireless/realtek/rtw88/sdio.c          |    8 -
 drivers/net/wireless/realtek/rtw88/usb.h           |    2 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |    4 +
 drivers/net/wireless/realtek/rtw89/mac.h           |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   28 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |    3 +-
 drivers/net/wwan/iosm/iosm_ipc_imem.c              |   27 +-
 drivers/net/wwan/iosm/iosm_ipc_imem_ops.c          |   12 +-
 drivers/net/wwan/iosm/iosm_ipc_imem_ops.h          |    6 +-
 drivers/net/wwan/t7xx/t7xx_pci.c                   |   18 +
 drivers/net/wwan/t7xx/t7xx_pci.h                   |    1 +
 drivers/nvme/host/core.c                           |    6 +-
 drivers/nvme/host/hwmon.c                          |    4 +-
 drivers/nvme/host/multipath.c                      |    1 -
 drivers/nvme/host/nvme.h                           |    5 +
 drivers/nvme/host/pci.c                            |    8 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c           |   11 +-
 drivers/platform/x86/hp/hp-wmi.c                   |    1 +
 .../uncore-frequency/uncore-frequency-common.c     |    6 +-
 drivers/platform/x86/intel_scu_pcidrv.c            |    1 +
 drivers/platform/x86/thinkpad_acpi.c               |   24 +-
 drivers/platform/x86/touchscreen_dmi.c             |   41 +
 drivers/s390/block/dasd_eckd.c                     |   33 +-
 drivers/s390/cio/device.c                          |    2 +
 drivers/s390/cio/qdio.h                            |    2 +-
 drivers/s390/crypto/pkey_api.c                     |    3 +
 drivers/scsi/scsi_lib.c                            |    5 +-
 drivers/scsi/storvsc_drv.c                         |    8 +-
 drivers/spi/Kconfig                                |    7 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-atmel.c                            |   18 +-
 drivers/spi/spi-cadence-quadspi.c                  |   19 +
 drivers/spi/spi-cadence.c                          |    1 +
 drivers/spi/spi-dw-core.c                          |   14 +-
 drivers/spi/spi-dw-dma.c                           |   76 +-
 drivers/spi/spi-dw-mmio.c                          |   22 +
 drivers/spi/spi-dw.h                               |    1 +
 drivers/spi/spi-fsl-lpspi.c                        |    8 +-
 drivers/spi/spi-geni-qcom.c                        |    4 +-
 drivers/spi/spi-hisi-kunpeng.c                     |    2 +-
 drivers/spi/spi-imx.c                              |   63 +-
 drivers/spi/spi-mt65xx.c                           |   33 +-
 drivers/spi/spi-pl022.c                            |    4 +-
 drivers/spi/spi-qcom-qspi.c                        |  218 +-
 drivers/spi/spi-rzv2m-csi.c                        |  667 ++++++
 drivers/spi/spi-s3c64xx.c                          |  197 +-
 drivers/spi/spi-sc18is602.c                        |    2 +-
 drivers/spi/spi-sn-f-ospi.c                        |   17 +-
 drivers/spi/spi-stm32.c                            |  274 ++-
 drivers/spi/spi-sun6i.c                            |  133 +-
 drivers/spi/spi-xcomm.c                            |    2 +-
 drivers/spi/spidev.c                               |    3 +-
 drivers/thunderbolt/nhi.c                          |   29 +-
 drivers/thunderbolt/nhi_regs.h                     |    2 +
 drivers/tty/serial/8250/8250_bcm7271.c             |    7 +-
 drivers/tty/serial/8250/8250_exar.c                |   17 +
 drivers/tty/serial/8250/8250_pci.c                 |    5 +
 drivers/tty/serial/8250/8250_port.c                |    1 +
 drivers/tty/serial/arc_uart.c                      |    7 +-
 drivers/tty/serial/qcom_geni_serial.c              |    9 +-
 drivers/tty/vt/vc_screen.c                         |   11 +-
 drivers/ufs/core/ufs-mcq.c                         |    5 +-
 drivers/ufs/core/ufshcd.c                          |   20 +-
 drivers/usb/class/usbtmc.c                         |    2 +
 drivers/usb/dwc3/core.c                            |    2 +-
 drivers/usb/dwc3/core.h                            |    2 +
 drivers/usb/dwc3/debugfs.c                         |  109 +
 drivers/usb/dwc3/gadget.c                          |   79 +-
 drivers/usb/gadget/function/u_ether.c              |    3 +
 drivers/usb/gadget/udc/core.c                      |  151 +-
 drivers/usb/host/uhci-pci.c                        |   10 +-
 drivers/usb/host/xhci-pci.c                        |   12 +-
 drivers/usb/host/xhci-ring.c                       |   29 +-
 drivers/usb/host/xhci.h                            |    2 +-
 drivers/usb/storage/scsiglue.c                     |   28 +-
 drivers/usb/typec/altmodes/displayport.c           |    4 +
 drivers/usb/typec/tipd/core.c                      |    3 +
 drivers/video/fbdev/68328fb.c                      |   12 +-
 drivers/video/fbdev/Kconfig                        |    2 +-
 drivers/video/fbdev/arcfb.c                        |   15 +-
 drivers/video/fbdev/atmel_lcdfb.c                  |    2 +-
 drivers/video/fbdev/aty/atyfb_base.c               |    5 -
 drivers/video/fbdev/cg14.c                         |    2 +-
 drivers/video/fbdev/controlfb.c                    |   34 +-
 drivers/video/fbdev/core/fbmem.c                   |    2 +-
 drivers/video/fbdev/core/modedb.c                  |    5 +
 drivers/video/fbdev/g364fb.c                       |    6 +-
 drivers/video/fbdev/hgafb.c                        |   36 +-
 drivers/video/fbdev/hpfb.c                         |    8 +-
 drivers/video/fbdev/i810/i810_dvt.c                |    3 +-
 drivers/video/fbdev/imsttfb.c                      |   15 +-
 drivers/video/fbdev/macfb.c                        |   10 +-
 drivers/video/fbdev/maxinefb.c                     |    2 +-
 .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   |    3 +-
 drivers/video/fbdev/p9100.c                        |    4 +-
 drivers/video/fbdev/platinumfb.c                   |   30 +-
 drivers/video/fbdev/sa1100fb.c                     |   32 +-
 drivers/video/fbdev/stifb.c                        |  157 +-
 drivers/video/fbdev/udlfb.c                        |   27 +-
 drivers/video/fbdev/valkyriefb.c                   |   14 +-
 drivers/video/fbdev/vfb.c                          |   10 +-
 fs/btrfs/backref.c                                 |   19 +-
 fs/btrfs/backref.h                                 |    6 +
 fs/btrfs/block-rsv.c                               |    3 +-
 fs/btrfs/ctree.c                                   |   38 +-
 fs/btrfs/disk-io.c                                 |   25 +-
 fs/btrfs/file-item.c                               |    5 +-
 fs/btrfs/free-space-cache.c                        |    7 +-
 fs/btrfs/free-space-tree.c                         |   50 +-
 fs/btrfs/free-space-tree.h                         |    3 +-
 fs/btrfs/inode.c                                   |    3 +
 fs/btrfs/ioctl.c                                   |    4 +-
 fs/btrfs/print-tree.c                              |    6 +-
 fs/btrfs/relocation.c                              |    2 +-
 fs/btrfs/super.c                                   |    6 +-
 fs/btrfs/volumes.c                                 |    1 +
 fs/btrfs/zoned.c                                   |   17 +-
 fs/ceph/mds_client.c                               |    3 +-
 fs/ceph/snap.c                                     |   13 +
 fs/cifs/cifsfs.c                                   |   18 +-
 fs/cifs/cifsglob.h                                 |    4 +-
 fs/cifs/connect.c                                  |    7 +
 fs/cifs/file.c                                     |   26 +-
 fs/cifs/smb1ops.c                                  |    9 +-
 fs/cifs/smb2ops.c                                  |    9 +-
 fs/cifs/smb2pdu.c                                  |    3 +
 fs/ext4/balloc.c                                   |   43 +-
 fs/ext4/ext4.h                                     |   39 +-
 fs/ext4/extents_status.c                           |   30 +-
 fs/ext4/hash.c                                     |    6 +-
 fs/ext4/ialloc.c                                   |   12 +-
 fs/ext4/inline.c                                   |   17 +-
 fs/ext4/inode.c                                    |   20 +-
 fs/ext4/mballoc.c                                  |   70 +-
 fs/ext4/migrate.c                                  |   11 +-
 fs/ext4/mmp.c                                      |   30 +-
 fs/ext4/namei.c                                    |   53 +-
 fs/ext4/super.c                                    |   37 +-
 fs/ext4/xattr.c                                    |    5 +-
 fs/gfs2/super.c                                    |    8 +
 fs/ksmbd/connection.c                              |    3 +-
 fs/ksmbd/oplock.c                                  |    5 +-
 fs/ksmbd/oplock.h                                  |    2 +-
 fs/ksmbd/smb2misc.c                                |    5 +-
 fs/ksmbd/smb2pdu.c                                 |   19 +-
 fs/lockd/svc.c                                     |    2 +-
 fs/nfs/dir.c                                       |    2 +-
 fs/nfsd/nfsctl.c                                   |   25 +-
 fs/nfsd/trace.h                                    |    6 +-
 fs/nilfs2/inode.c                                  |   18 +
 fs/notify/inotify/inotify_fsnotify.c               |   11 +-
 fs/pipe.c                                          |    6 +-
 fs/statfs.c                                        |    4 +-
 fs/xfs/libxfs/xfs_ag.c                             |   19 +-
 fs/xfs/libxfs/xfs_bmap.c                           |    5 +-
 fs/xfs/scrub/bmap.c                                |    4 +-
 fs/xfs/scrub/common.c                              |   26 -
 fs/xfs/scrub/common.h                              |    2 -
 fs/xfs/scrub/fscounters.c                          |   13 +-
 fs/xfs/scrub/scrub.c                               |    2 -
 fs/xfs/scrub/scrub.h                               |    1 -
 fs/xfs/scrub/trace.h                               |    1 -
 fs/xfs/xfs_bmap_util.c                             |    4 +-
 fs/xfs/xfs_icache.c                                |   40 +-
 fs/xfs/xfs_iomap.c                                 |    5 +-
 fs/xfs/xfs_mount.h                                 |    3 +
 fs/xfs/xfs_super.c                                 |    3 +
 include/drm/display/drm_dp.h                       |    5 +-
 include/drm/display/drm_dp_helper.h                |    5 +-
 include/linux/blkdev.h                             |    2 -
 include/linux/compiler.h                           |    5 +-
 include/linux/device/class.h                       |    1 +
 include/linux/dim.h                                |    3 +-
 include/linux/if_vlan.h                            |   17 +
 include/linux/io_uring.h                           |   10 +-
 include/linux/pci_ids.h                            |    1 +
 include/linux/phy.h                                |    2 -
 include/linux/platform_data/spi-s3c64xx.h          |    1 +
 include/linux/shrinker.h                           |   13 +-
 include/linux/spi/spi.h                            |   17 +
 include/linux/sunrpc/svc_rdma.h                    |    2 +-
 include/linux/sunrpc/svc_xprt.h                    |    2 +-
 include/linux/tpm.h                                |    1 +
 include/linux/usb/composite.h                      |    2 +-
 include/media/dvb_frontend.h                       |    6 +-
 include/media/dvb_net.h                            |    4 +
 include/media/dvbdev.h                             |   15 +
 include/net/bonding.h                              |    2 +-
 include/net/nexthop.h                              |   23 -
 include/net/sock.h                                 |    2 +-
 include/sound/hda-mlink.h                          |   14 +
 include/uapi/linux/spi/spi.h                       |    3 +-
 include/uapi/sound/sof/tokens.h                    |    3 +-
 include/ufs/ufshcd.h                               |    2 +-
 kernel/events/core.c                               |   14 +-
 kernel/locking/rwsem.c                             |    8 +-
 kernel/sched/core.c                                |    4 +-
 kernel/time/tick-broadcast.c                       |  120 +-
 kernel/trace/fprobe.c                              |   73 +-
 kernel/trace/rethook.c                             |    4 +-
 lib/dim/dim.c                                      |    5 +-
 lib/dim/net_dim.c                                  |    3 +-
 lib/dim/rdma_dim.c                                 |    3 +-
 lib/maple_tree.c                                   |   12 +-
 mm/kfence/kfence.h                                 |    2 +-
 mm/shrinker_debug.c                                |   15 +-
 mm/vmscan.c                                        |    5 +-
 mm/zsmalloc.c                                      |   36 +-
 mm/zswap.c                                         |   16 +
 net/8021q/vlan_dev.c                               |    4 +-
 net/atm/resources.c                                |    2 +
 net/bridge/br_forward.c                            |    2 +-
 net/bridge/br_private_tunnel.h                     |    8 +-
 net/can/isotp.c                                    |    2 +-
 net/can/j1939/socket.c                             |    2 +-
 net/core/datagram.c                                |   15 +-
 net/core/dev.c                                     |    2 +-
 net/core/skbuff.c                                  |    4 +-
 net/core/stream.c                                  |   12 +-
 net/devlink/core.c                                 |   16 +-
 net/devlink/devl_internal.h                        |    1 -
 net/devlink/leftover.c                             |    5 +-
 net/ipv4/af_inet.c                                 |    2 +-
 net/ipv4/tcp.c                                     |   14 +-
 net/ipv4/tcp_bpf.c                                 |    2 +-
 net/ipv4/tcp_input.c                               |    4 +-
 net/ipv4/tcp_ipv4.c                                |    5 +-
 net/ipv6/ip6_fib.c                                 |   16 +-
 net/ipv6/ip6_gre.c                                 |   13 +-
 net/key/af_key.c                                   |   12 +-
 net/llc/af_llc.c                                   |    8 +-
 net/mac80211/cfg.c                                 |    7 +-
 net/mac80211/chan.c                                |   75 +-
 net/mac80211/ieee80211_i.h                         |    3 +-
 net/mac80211/trace.h                               |    2 +-
 net/mac80211/tx.c                                  |    5 +-
 net/mac80211/util.c                                |    2 +-
 net/netfilter/core.c                               |    6 +-
 net/netfilter/nf_conntrack_netlink.c               |    4 +
 net/netfilter/nf_conntrack_standalone.c            |    3 +-
 net/netfilter/nf_tables_api.c                      |    4 +-
 net/netfilter/nft_chain_filter.c                   |    9 +-
 net/netfilter/nft_set_rbtree.c                     |   20 +-
 net/netlink/af_netlink.c                           |    8 +-
 net/nsh/nsh.c                                      |    8 +-
 net/packet/af_packet.c                             |    6 +-
 net/smc/smc_close.c                                |    4 +-
 net/smc/smc_rx.c                                   |    4 +-
 net/smc/smc_tx.c                                   |    4 +-
 net/socket.c                                       |    2 +-
 net/sunrpc/auth_gss/gss_krb5_crypto.c              |   10 +
 net/sunrpc/svc.c                                   |   19 +-
 net/sunrpc/svc_xprt.c                              |   24 +-
 net/sunrpc/svcsock.c                               |   46 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c            |   11 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c           |    2 +-
 net/tipc/bearer.c                                  |   17 +-
 net/tipc/bearer.h                                  |    3 +
 net/tipc/link.c                                    |    9 +-
 net/tipc/socket.c                                  |    4 +-
 net/tipc/udp_media.c                               |    5 +-
 net/tls/tls_main.c                                 |    3 +-
 net/unix/af_unix.c                                 |   22 +-
 net/vmw_vsock/af_vsock.c                           |    2 +-
 net/wireless/scan.c                                |    6 +-
 net/xfrm/xfrm_device.c                             |    2 +-
 net/xfrm/xfrm_interface_core.c                     |   54 +-
 net/xfrm/xfrm_policy.c                             |   20 +-
 net/xfrm/xfrm_user.c                               |   15 +-
 sound/core/oss/pcm_plugin.h                        |   16 +-
 sound/firewire/digi00x/digi00x-stream.c            |    4 +-
 sound/pci/cs46xx/cs46xx_lib.c                      |    2 +-
 sound/pci/hda/hda_generic.c                        |    7 +-
 sound/pci/hda/patch_hdmi.c                         |    5 +
 sound/pci/hda/patch_realtek.c                      |   34 +-
 sound/soc/amd/yc/acp6x-mach.c                      |    7 +
 sound/soc/codecs/cs35l56.c                         |    3 +-
 sound/soc/codecs/ssm2602.c                         |   15 +
 sound/soc/dwc/dwc-i2s.c                            |    4 +-
 sound/soc/fsl/fsl_micfil.c                         |   14 +-
 sound/soc/jz4740/jz4740-i2s.c                      |   54 +-
 sound/soc/mediatek/mt8186/mt8186-afe-clk.c         |    6 -
 sound/soc/mediatek/mt8186/mt8186-afe-clk.h         |    1 -
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c         |    4 -
 sound/soc/mediatek/mt8186/mt8186-audsys-clk.c      |   46 +-
 sound/soc/mediatek/mt8186/mt8186-audsys-clk.h      |    1 -
 sound/soc/sof/amd/acp-ipc.c                        |    7 +-
 sound/soc/sof/debug.c                              |    4 +-
 sound/soc/sof/intel/hda-mlink.c                    |   96 +-
 sound/soc/sof/ipc3-topology.c                      |    7 +-
 sound/soc/sof/ipc4-topology.c                      |    4 +-
 sound/soc/sof/pcm.c                                |   11 +-
 sound/soc/sof/pm.c                                 |   14 +-
 sound/soc/sof/sof-client-probes.c                  |   14 +-
 sound/soc/sof/topology.c                           |    6 +-
 sound/usb/format.c                                 |    1 +
 tools/arch/arm64/include/uapi/asm/kvm.h            |   36 +
 tools/arch/x86/include/asm/cpufeatures.h           |   26 +-
 tools/arch/x86/include/asm/disabled-features.h     |    8 +-
 tools/arch/x86/include/asm/msr-index.h             |    2 +
 tools/arch/x86/include/uapi/asm/kvm.h              |    3 +
 tools/arch/x86/include/uapi/asm/prctl.h            |    8 +
 tools/arch/x86/include/uapi/asm/unistd_32.h        |    3 +
 tools/arch/x86/lib/memcpy_64.S                     |   34 +-
 tools/arch/x86/lib/memset_64.S                     |   47 +-
 tools/include/asm/alternative.h                    |    3 +-
 tools/include/uapi/drm/drm.h                       |   57 +-
 tools/include/uapi/drm/i915_drm.h                  |   25 +-
 tools/include/uapi/linux/const.h                   |    2 +-
 tools/include/uapi/linux/in.h                      |    1 +
 tools/include/uapi/linux/kvm.h                     |   12 +-
 tools/include/uapi/linux/prctl.h                   |    2 +
 tools/include/uapi/sound/asound.h                  |   14 +-
 tools/perf/Makefile.config                         |    6 +
 tools/perf/Makefile.perf                           |   22 +-
 tools/perf/arch/arm/util/cs-etm.c                  |    9 +-
 tools/perf/arch/arm64/util/header.c                |    4 +-
 tools/perf/arch/arm64/util/pmu.c                   |    2 +-
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |    2 +-
 tools/perf/bench/mem-memcpy-x86-64-asm-def.h       |    4 -
 tools/perf/bench/mem-memcpy-x86-64-asm.S           |    2 +-
 tools/perf/bench/mem-memset-x86-64-asm-def.h       |    4 -
 tools/perf/bench/mem-memset-x86-64-asm.S           |    2 +-
 tools/perf/builtin-script.c                        |    7 +
 tools/perf/builtin-stat.c                          |   38 +-
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |   26 +
 .../arch/x86/alderlaken/adln-metrics.json          |   14 +
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |   12 +
 .../arch/x86/broadwellde/bdwde-metrics.json        |   12 +
 .../arch/x86/broadwellx/bdx-metrics.json           |   12 +
 .../arch/x86/cascadelakex/clx-metrics.json         |   12 +
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |   12 +
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |   12 +
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |   12 +
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |   12 +
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |   12 +
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |   12 +
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |   12 +
 .../arch/x86/sandybridge/snb-metrics.json          |   12 +
 .../arch/x86/sapphirerapids/spr-metrics.json       |   12 +
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |   12 +
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   12 +
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |   12 +
 tools/perf/pmu-events/jevents.py                   |    4 +-
 tools/perf/pmu-events/pmu-events.h                 |    1 +
 tools/perf/tests/attr.py                           |    6 +-
 tools/perf/tests/attr/base-stat                    |    2 +-
 tools/perf/tests/attr/test-stat-default            |   80 +-
 tools/perf/tests/attr/test-stat-detailed-1         |   95 +-
 tools/perf/tests/attr/test-stat-detailed-2         |  119 +-
 tools/perf/tests/attr/test-stat-detailed-3         |  127 +-
 tools/perf/tests/expr.c                            |    3 +-
 tools/perf/tests/parse-metric.c                    |    1 +
 tools/perf/tests/shell/stat.sh                     |   13 +
 tools/perf/tests/shell/test_intel_pt.sh            |    7 +
 tools/perf/tests/shell/test_java_symbol.sh         |    2 +-
 tools/perf/trace/beauty/arch_prctl.c               |    2 +
 tools/perf/trace/beauty/x86_arch_prctl.sh          |    1 +
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |    2 +
 tools/perf/util/bpf_skel/vmlinux.h                 |    1 +
 tools/perf/util/evsel.c                            |   37 +-
 tools/perf/util/evsel.h                            |    1 +
 tools/perf/util/expr.y                             |    6 +-
 tools/perf/util/metricgroup.c                      |   10 +-
 tools/perf/util/parse-events.c                     |   23 +-
 tools/perf/util/stat-display.c                     |    2 +-
 tools/perf/util/stat-shadow.c                      |   25 +-
 tools/power/cpupower/lib/powercap.c                |   23 +-
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |   31 +-
 tools/spi/spidev_test.c                            |  107 +-
 tools/testing/cxl/test/mock.c                      |    2 +-
 .../selftests/drivers/net/bonding/bond_options.sh  |   50 +
 .../drivers/net/bonding/bond_topo_3d1c.sh          |    2 +
 tools/testing/selftests/ftrace/Makefile            |    3 +-
 tools/testing/selftests/ftrace/ftracetest          |   63 +-
 tools/testing/selftests/ftrace/ftracetest-ktap     |    8 +
 tools/testing/selftests/net/fib_nexthops.sh        |    2 +-
 tools/testing/selftests/net/forwarding/lib.sh      |    3 +-
 .../selftests/net/srv6_end_dt4_l3vpn_test.sh       |   17 +-
 tools/testing/selftests/netfilter/nft_flowtable.sh |  145 +-
 tools/testing/selftests/sgx/Makefile               |    1 +
 virt/kvm/kvm_main.c                                |   59 +-
 661 files changed, 8316 insertions(+), 4252 deletions(-)
 delete mode 100644 Documentation/block/request.rst
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzv2m-csi.yaml
 create mode 100644 arch/um/drivers/harddog.h
 create mode 100644 arch/um/drivers/harddog_user_exp.c
 create mode 100644 drivers/spi/spi-rzv2m-csi.c
 create mode 100755 tools/testing/selftests/ftrace/ftracetest-ktap
