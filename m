Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81385731A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344068AbjFONfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344578AbjFONfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:35:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218D030EF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:34:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAFE963723
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C93AC433C0;
        Thu, 15 Jun 2023 13:34:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9n78-000Tki-2g;
        Thu, 15 Jun 2023 09:34:14 -0400
Message-ID: <20230615130531.200384328@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Jun 2023 09:05:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 00/15] tracing: Updates for 6.4
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing fixes for 6.4:

 - Fix MAINTAINERS file to point to proper mailing list for rtla and rv
    The mailing list pointed to linux-trace-devel instead of
    linux-trace-kernel. The former is for the tracing libraries
    and the latter is for anything in the Linux kernel tree.
    The wrong mailing list was used because linux-trace-kernel did not
    exist when rtla and rv were created.

 - User events:
   . Fix matching of dynamic events to their user events
     When user writes to dynamic_events file, a lookup of the
     registered dynamic events are made, but there were some cases
     that a match could be incorrectly made.

   . Add auto cleanup of user events
     Have the user events automatically get removed when the last
     reference (file descriptor) is closed. This was asked for to
     prevent leaks of user events hanging around needing admins
     to clean them up.

   . Add persistent logic (but not let user space use it yet)
     In some cases, having a persistent user event (one that does not
     get cleaned up automatically) is useful. But there's still
     debates about how to expose this to user space. The infrastructure
     is added, but the API is not.

   . Update the selftests
     Update the user event selftests to reflect the above changes.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 0113d4615dbf053ae9a7a1e0acbc6652713af01f


Beau Belgrave (7):
      tracing/user_events: Remove user_ns walk for groups
      tracing/user_events: Store register flags on events
      tracing/user_events: Track refcount consistently via put/get
      tracing/user_events: Add auto cleanup and future persist flag
      selftests/user_events: Ensure auto cleanup works as expected
      selftests/user_events: Adapt dyn_test to non-persist events
      tracing/user_events: Document auto-cleanup and remove dyn_event refs

Steven Rostedt (Google) (1):
      tracing/rv/rtla: Update MAINTAINERS file to point to proper mailing list

sunliming (7):
      tracing/user_events: Prevent same name but different args event
      tracing/user_events: Handle matching arguments that is null from dyn_events
      tracing: Modify print_fields() for fields output order
      tracing/user_events: Fix the incorrect trace record for empty arguments events
      selftests/user_events: Add ftrace self-test for empty arguments events
      selftests/user_events: Clear the events after perf self-test
      selftests/user_events: Add perf self-test for empty arguments events

----
 Documentation/admin-guide/cifs/changes.rst         |   4 +-
 Documentation/admin-guide/cifs/usage.rst           |   8 +-
 .../bindings/fpga/lattice,sysconfig.yaml           |   2 +-
 .../bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml  |   2 +-
 .../bindings/iio/adc/nxp,imx8qxp-adc.yaml          |   7 -
 .../bindings/iio/adc/renesas,rcar-gyroadc.yaml     |   2 +-
 .../bindings/interrupt-controller/arm,gic-v3.yaml  |   6 -
 .../devicetree/bindings/serial/8250_omap.yaml      |   1 -
 .../devicetree/bindings/sound/tlv320aic32x4.txt    |   2 +-
 .../devicetree/bindings/usb/cdns,usb3.yaml         |   2 +-
 .../devicetree/bindings/usb/snps,dwc3.yaml         |   2 +-
 .../filesystems/{smb => cifs}/cifsroot.rst         |   2 +-
 Documentation/filesystems/{smb => cifs}/index.rst  |   0
 Documentation/filesystems/{smb => cifs}/ksmbd.rst  |   0
 Documentation/filesystems/index.rst                |   2 +-
 Documentation/mm/page_table_check.rst              |  19 -
 Documentation/netlink/specs/ethtool.yaml           |  32 +-
 Documentation/netlink/specs/handshake.yaml         |   4 -
 .../ethernet/mellanox/mlx5/devlink.rst             |  60 ++--
 Documentation/networking/tls-handshake.rst         |   5 -
 Documentation/process/maintainer-netdev.rst        |  33 +-
 Documentation/trace/user_events.rst                |   7 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst |   2 +-
 MAINTAINERS                                        |  48 +--
 Makefile                                           |   2 +-
 arch/arm/boot/dts/imx6qdl-mba6.dtsi                |   1 -
 arch/arm/boot/dts/imx6ull-dhcor-som.dtsi           |   7 -
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |   1 -
 arch/arm64/boot/dts/arm/foundation-v8.dtsi         |   1 -
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts         |   1 -
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      |   1 -
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    |   1 -
 arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi  |   8 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi          |  28 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  25 +-
 .../boot/dts/freescale/imx8x-colibri-eval-v3.dtsi  |   6 -
 .../boot/dts/freescale/imx8x-colibri-iris.dtsi     |   3 +-
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi   |  14 +-
 arch/arm64/include/asm/kvm_pgtable.h               |   6 +-
 arch/arm64/include/asm/sysreg.h                    |   6 -
 arch/arm64/kvm/hyp/include/hyp/switch.h            |   8 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c              |  14 +-
 arch/arm64/kvm/hyp/nvhe/switch.c                   |   2 -
 arch/arm64/kvm/hyp/pgtable.c                       |  17 +-
 arch/arm64/kvm/hyp/vhe/switch.c                    |   1 -
 arch/arm64/kvm/pmu-emul.c                          |  58 +--
 arch/arm64/kvm/sys_regs.c                          |  19 -
 arch/arm64/kvm/vgic/vgic-init.c                    |  27 +-
 arch/arm64/kvm/vgic/vgic-its.c                     |  14 +-
 arch/arm64/kvm/vgic/vgic-kvm-device.c              |  10 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |  31 +-
 arch/arm64/kvm/vgic/vgic-mmio.c                    |   9 +-
 arch/arm64/kvm/vgic/vgic-v2.c                      |   6 +
 arch/arm64/kvm/vgic/vgic-v3.c                      |   7 +
 arch/arm64/kvm/vgic/vgic-v4.c                      |   3 +-
 arch/m68k/kernel/signal.c                          |  14 +-
 arch/mips/Kconfig                                  |   1 -
 arch/mips/alchemy/common/dbdma.c                   |  27 +-
 arch/mips/kernel/cpu-probe.c                       |   5 -
 arch/mips/kernel/setup.c                           |   9 +-
 arch/parisc/Kconfig                                |   4 -
 arch/parisc/Kconfig.debug                          |  11 -
 arch/parisc/include/asm/cacheflush.h               |   4 -
 arch/parisc/include/asm/spinlock.h                 |  39 +--
 arch/parisc/include/asm/spinlock_types.h           |   8 +-
 arch/parisc/kernel/alternative.c                   |   2 +-
 arch/parisc/kernel/cache.c                         |   5 +-
 arch/parisc/kernel/pci-dma.c                       |  18 +-
 arch/parisc/kernel/process.c                       |  11 +-
 arch/parisc/kernel/traps.c                         |  18 +-
 arch/powerpc/Kconfig                               |   6 -
 arch/powerpc/crypto/Makefile                       |  10 +-
 arch/powerpc/crypto/aes-gcm-p10-glue.c             |  18 +-
 .../powerpc/crypto/{aesp10-ppc.pl => aesp8-ppc.pl} |   2 +-
 .../crypto/{ghashp10-ppc.pl => ghashp8-ppc.pl}     |  12 +-
 arch/powerpc/platforms/pseries/iommu.c             |  13 +-
 arch/powerpc/xmon/xmon.c                           |   2 +-
 arch/riscv/Kconfig                                 |   5 +-
 arch/riscv/errata/Makefile                         |   4 -
 arch/riscv/include/asm/hugetlb.h                   |   3 -
 arch/riscv/include/asm/perf_event.h                |   7 -
 arch/riscv/kernel/Makefile                         |   4 -
 arch/riscv/mm/hugetlbpage.c                        |  30 +-
 arch/riscv/mm/init.c                               |   2 +-
 arch/x86/crypto/aria-aesni-avx-asm_64.S            |   2 +
 arch/x86/events/intel/core.c                       |   2 +-
 arch/x86/events/intel/uncore_snbep.c               |  11 -
 arch/x86/include/asm/fpu/sched.h                   |   2 +-
 arch/x86/kernel/cpu/topology.c                     |   5 +-
 arch/x86/kernel/dumpstack.c                        |   7 +-
 arch/x86/kernel/fpu/context.h                      |   2 +-
 arch/x86/kernel/fpu/core.c                         |   2 +-
 arch/x86/kvm/lapic.c                               |  20 +-
 arch/x86/kvm/mmu/mmu.c                             |   5 +-
 arch/x86/kvm/svm/svm.c                             |   2 +-
 arch/x86/kvm/x86.c                                 |   3 -
 arch/x86/lib/copy_user_64.S                        |  10 +-
 arch/x86/mm/init.c                                 |  25 --
 arch/x86/pci/xen.c                                 |   8 +-
 arch/xtensa/kernel/signal.c                        |  35 +-
 arch/xtensa/kernel/xtensa_ksyms.c                  |   4 -
 arch/xtensa/lib/Makefile                           |   2 +-
 arch/xtensa/lib/bswapdi2.S                         |  21 --
 arch/xtensa/lib/bswapsi2.S                         |  16 -
 block/blk-core.c                                   |   2 +-
 block/blk-map.c                                    |   2 +-
 block/blk-mq-tag.c                                 |  12 +-
 block/blk-settings.c                               |   3 +-
 block/blk-wbt.c                                    |  12 +-
 drivers/accel/qaic/qaic_control.c                  |  41 +--
 drivers/accel/qaic/qaic_data.c                     |  93 ++---
 drivers/accel/qaic/qaic_drv.c                      |   2 +-
 drivers/acpi/apei/apei-internal.h                  |   6 +
 drivers/acpi/apei/bert.c                           |   1 -
 drivers/android/binder.c                           |  28 +-
 drivers/android/binder_alloc.c                     |  64 ++--
 drivers/android/binder_alloc.h                     |   4 +-
 drivers/android/binder_alloc_selftest.c            |   2 +-
 drivers/ata/libata-scsi.c                          |  34 +-
 drivers/base/cacheinfo.c                           |  26 --
 drivers/base/firmware_loader/main.c                |   2 +-
 drivers/base/regmap/Kconfig                        |  13 +-
 drivers/base/regmap/regcache-maple.c               |   5 +-
 drivers/base/regmap/regmap-sdw.c                   |   4 -
 drivers/base/regmap/regmap.c                       |   6 +-
 drivers/block/xen-blkfront.c                       |   3 +-
 drivers/bluetooth/btnxpuart.c                      |   6 +-
 drivers/char/agp/parisc-agp.c                      |  15 +-
 drivers/char/tpm/tpm_tis.c                         |   7 -
 drivers/char/tpm/tpm_tis_core.h                    |   8 +-
 drivers/cpufreq/amd-pstate.c                       |  46 +--
 drivers/cxl/core/mbox.c                            |  12 +-
 drivers/cxl/core/pci.c                             | 112 +-----
 drivers/cxl/core/port.c                            |   7 +-
 drivers/cxl/cxl.h                                  |   1 -
 drivers/cxl/cxlmem.h                               |   2 -
 drivers/cxl/cxlpci.h                               |   2 -
 drivers/cxl/mem.c                                  |   3 -
 drivers/cxl/pci.c                                  |   6 -
 drivers/cxl/port.c                                 |  20 +-
 drivers/dma/at_hdmac.c                             |  17 +-
 drivers/dma/at_xdmac.c                             |   7 +-
 drivers/dma/idxd/cdev.c                            |   1 +
 drivers/dma/pl330.c                                |   8 +-
 drivers/dma/ti/k3-udma.c                           |   4 +-
 drivers/firmware/arm_ffa/bus.c                     |  19 +-
 drivers/firmware/arm_ffa/driver.c                  |   9 +-
 drivers/firmware/arm_scmi/raw_mode.c               |   2 +-
 drivers/firmware/efi/libstub/Makefile.zboot        |   3 +-
 drivers/firmware/efi/libstub/efistub.h             |   3 -
 drivers/gpio/Kconfig                               |   2 +-
 drivers/gpio/gpio-f7188x.c                         |  28 +-
 drivers/gpio/gpio-mockup.c                         |   2 +-
 drivers/gpio/gpiolib.c                             |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c           |  27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h           |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |   3 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |  28 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c             |  28 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |   8 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |  25 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |  36 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  25 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  16 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   9 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |  25 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  12 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  29 ++
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  10 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c   |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   1 -
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   |   5 +-
 drivers/gpu/drm/drm_managed.c                      |  22 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |   2 +-
 drivers/gpu/drm/i915/display/intel_display.c       |  12 +-
 drivers/gpu/drm/i915/i915_perf.c                   |  17 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |   5 -
 drivers/gpu/drm/pl111/pl111_display.c              |   2 +-
 drivers/gpu/drm/pl111/pl111_drm.h                  |   4 +-
 drivers/gpu/drm/pl111/pl111_drv.c                  |   8 +-
 drivers/gpu/drm/pl111/pl111_versatile.c            |  10 +-
 drivers/gpu/drm/radeon/radeon_irq_kms.c            |  10 -
 drivers/gpu/drm/scheduler/sched_main.c             |   3 +
 drivers/hid/hid-google-hammer.c                    |   2 -
 drivers/hid/hid-ids.h                              |   1 -
 drivers/hid/hid-logitech-hidpp.c                   |   1 -
 drivers/hid/wacom_sys.c                            |  21 +-
 drivers/hid/wacom_wac.c                            |   2 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   1 -
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |   2 +-
 drivers/iio/accel/kionix-kx022a.c                  |   2 +-
 drivers/iio/accel/st_accel_core.c                  |   4 +-
 drivers/iio/adc/ad4130.c                           |  12 +-
 drivers/iio/adc/ad7192.c                           |   8 +-
 drivers/iio/adc/ad_sigma_delta.c                   |   4 -
 drivers/iio/adc/imx93_adc.c                        |   7 +-
 drivers/iio/adc/mt6370-adc.c                       |  53 +--
 drivers/iio/adc/mxs-lradc-adc.c                    |  10 +-
 drivers/iio/adc/palmas_gpadc.c                     |  10 +-
 drivers/iio/adc/stm32-adc.c                        |  61 ++--
 drivers/iio/addac/ad74413r.c                       |   2 +-
 drivers/iio/dac/Makefile                           |   2 +-
 drivers/iio/dac/mcp4725.c                          |  16 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  10 +-
 drivers/iio/industrialio-gts-helper.c              |  42 +--
 drivers/iio/light/rohm-bu27034.c                   |  26 +-
 drivers/iio/light/vcnl4035.c                       |   3 -
 drivers/iio/magnetometer/tmag5273.c                |   5 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |   4 +-
 drivers/infiniband/hw/bnxt_re/main.c               |   4 -
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  11 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |  12 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   7 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  25 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   2 -
 drivers/infiniband/hw/hns/hns_roce_mr.c            |  43 ---
 drivers/infiniband/hw/irdma/verbs.c                |  12 +-
 drivers/infiniband/sw/rxe/rxe_comp.c               |  26 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |   7 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |  37 +-
 drivers/infiniband/sw/rxe/rxe_recv.c               |   9 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |  30 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |  14 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |  25 +-
 drivers/iommu/Kconfig                              |   1 -
 drivers/iommu/amd/amd_iommu.h                      |   4 +-
 drivers/iommu/amd/init.c                           |  24 --
 drivers/iommu/amd/iommu.c                          |  31 +-
 drivers/iommu/mtk_iommu.c                          |   3 +-
 drivers/iommu/rockchip-iommu.c                     |  14 +-
 drivers/irqchip/irq-gic-common.c                   |  10 +-
 drivers/irqchip/irq-gic-common.h                   |   1 -
 drivers/irqchip/irq-gic-v3.c                       |  20 --
 drivers/irqchip/irq-mbigen.c                       |  31 +-
 drivers/irqchip/irq-meson-gpio.c                   |   2 +-
 drivers/irqchip/irq-mips-gic.c                     |  32 +-
 drivers/leds/rgb/leds-qcom-lpg.c                   |   8 +-
 drivers/mailbox/mailbox-test.c                     |  10 +-
 drivers/md/raid5.c                                 |   2 +-
 drivers/media/cec/core/cec-adap.c                  |   8 +-
 drivers/media/cec/core/cec-core.c                  |   2 -
 drivers/media/cec/core/cec-priv.h                  |   1 -
 .../mediatek/vcodec/mtk_vcodec_dec_stateful.c      |   3 -
 drivers/media/platform/qcom/camss/camss-video.c    |   1 +
 drivers/media/platform/verisilicon/hantro_v4l2.c   |   6 +-
 drivers/media/usb/uvc/uvc_driver.c                 |  16 +-
 drivers/media/v4l2-core/v4l2-mc.c                  |   3 +-
 drivers/misc/fastrpc.c                             |  31 +-
 drivers/mmc/core/block.c                           |   5 -
 drivers/mmc/core/pwrseq_sd8787.c                   |  34 +-
 drivers/mmc/host/sdhci-cadence.c                   |   8 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  18 +-
 drivers/mmc/host/vub300.c                          |   3 -
 drivers/mtd/mtdchar.c                              |   8 +-
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h         |   8 +-
 drivers/mtd/nand/raw/marvell_nand.c                |  10 +-
 drivers/mtd/spi-nor/core.c                         |   5 +-
 drivers/mtd/spi-nor/spansion.c                     |   4 +-
 drivers/net/bonding/bond_main.c                    |   8 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   2 +-
 drivers/net/ethernet/3com/3c589_cs.c               |  11 +-
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  12 +-
 drivers/net/ethernet/freescale/fec_main.c          |  17 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |   4 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   3 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   1 -
 .../ethernet/mellanox/mlx5/core/en/port_buffer.c   |  46 +--
 .../ethernet/mellanox/mlx5/core/en/port_buffer.h   |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |   2 -
 .../ethernet/mellanox/mlx5/core/en/tc/act/act.c    |   7 +-
 .../ethernet/mellanox/mlx5/core/en/tc/act/act.h    |   2 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  | 124 +------
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.h  |   9 -
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h  |   2 -
 .../net/ethernet/mellanox/mlx5/core/en_common.c    |  11 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  69 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   6 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    | 152 +++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |  19 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c  |  16 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   5 -
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  16 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |  70 +---
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |   1 -
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  11 +-
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h |   1 -
 drivers/net/ethernet/mellanox/mlx5/core/mr.c       |  21 --
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |  53 +--
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |   1 -
 .../ethernet/mellanox/mlx5/core/steering/dr_cmd.c  |   4 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_ptrn.c |   3 -
 .../ethernet/mellanox/mlx5/core/steering/dr_ste.c  |   3 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |  13 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |  10 -
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  10 +
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |   2 +
 drivers/net/ethernet/nvidia/forcedeth.c            |   1 -
 drivers/net/ethernet/realtek/r8169_main.c          |  44 +--
 drivers/net/ethernet/renesas/rswitch.c             |   2 +-
 drivers/net/ethernet/sfc/efx_devlink.c             |  95 ++---
 drivers/net/ethernet/sfc/tc.c                      |  27 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c   |   6 -
 drivers/net/ipa/ipa_endpoint.c                     |   2 +-
 drivers/net/phy/mscc/mscc.h                        |   2 -
 drivers/net/phy/mscc/mscc_main.c                   |  82 ++---
 drivers/net/phy/mxl-gpy.c                          |  16 +-
 drivers/net/team/team.c                            |   7 +-
 drivers/net/usb/cdc_ncm.c                          |  24 +-
 drivers/net/usb/qmi_wwan.c                         |   2 +-
 drivers/nfc/nfcsim.c                               |   4 +
 drivers/nvme/host/constants.c                      |   2 +-
 drivers/nvme/host/core.c                           |  52 +--
 drivers/nvme/host/ioctl.c                          |   2 +-
 drivers/nvme/host/nvme.h                           |   3 +-
 drivers/nvme/host/pci.c                            |   2 -
 drivers/nvme/target/passthru.c                     |   2 +-
 drivers/pci/quirks.c                               |   9 +-
 .../phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c  |   2 +-
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c         |  10 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |   5 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c   |   5 +-
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      |   2 +-
 drivers/platform/mellanox/mlxbf-pmc.c              |   5 +-
 drivers/platform/x86/amd/pmf/core.c                |  32 +-
 drivers/platform/x86/asus-nb-wmi.c                 |   2 -
 drivers/platform/x86/intel/ifs/load.c              |   2 +-
 .../x86/intel/speed_select_if/isst_if_common.c     |  12 +-
 drivers/power/supply/ab8500_btemp.c                |   6 +-
 drivers/power/supply/ab8500_fg.c                   |   6 +-
 drivers/power/supply/axp288_fuel_gauge.c           |   2 +-
 drivers/power/supply/bq24190_charger.c             |   1 -
 drivers/power/supply/bq25890_charger.c             |   5 +-
 drivers/power/supply/bq27xxx_battery.c             | 181 +++++-----
 drivers/power/supply/bq27xxx_battery_i2c.c         |   3 +-
 drivers/power/supply/mt6360_charger.c              |   4 +-
 drivers/power/supply/power_supply_core.c           |  15 +-
 drivers/power/supply/power_supply_leds.c           |   5 +-
 drivers/power/supply/power_supply_sysfs.c          |   3 +-
 drivers/power/supply/rt9467-charger.c              |   2 +-
 drivers/power/supply/sbs-charger.c                 |   2 +-
 drivers/power/supply/sc27xx_fuel_gauge.c           |   9 +-
 drivers/regulator/core.c                           |   4 +-
 drivers/regulator/mt6359-regulator.c               |   7 +-
 drivers/regulator/pca9450-regulator.c              |   4 +-
 drivers/scsi/qla2xxx/qla_def.h                     |   1 -
 drivers/scsi/qla2xxx/qla_init.c                    |   3 -
 drivers/scsi/qla2xxx/qla_inline.h                  |   3 -
 drivers/scsi/qla2xxx/qla_isr.c                     |   3 -
 drivers/scsi/stex.c                                |   4 -
 drivers/soc/fsl/qe/Kconfig                         |   4 +-
 drivers/spi/spi-cadence.c                          | 105 +++---
 drivers/spi/spi-dw-mmio.c                          |   8 +-
 drivers/spi/spi-geni-qcom.c                        |   2 -
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c |   4 +-
 drivers/staging/media/imx/imx8mq-mipi-csi2.c       |   2 +-
 drivers/target/iscsi/iscsi_target.c                |   2 +
 drivers/target/iscsi/iscsi_target_login.c          |  63 +++-
 drivers/target/iscsi/iscsi_target_nego.c           |  74 ++--
 drivers/target/iscsi/iscsi_target_util.c           |  51 ---
 drivers/target/iscsi/iscsi_target_util.h           |   4 -
 drivers/tee/optee/smc_abi.c                        |   4 +-
 .../intel/int340x_thermal/int3400_thermal.c        |   4 +-
 drivers/tty/serial/8250/8250_tegra.c               |   4 +-
 drivers/tty/serial/Kconfig                         |   2 +-
 drivers/tty/serial/cpm_uart/cpm_uart.h             |   2 +
 drivers/tty/serial/fsl_lpuart.c                    |  44 ++-
 drivers/usb/cdns3/cdns3-gadget.c                   |  13 -
 drivers/usb/core/buffer.c                          |  41 ---
 drivers/usb/core/devio.c                           |  20 +-
 drivers/usb/gadget/function/f_fs.c                 |   2 +-
 drivers/usb/gadget/udc/amd5536udc_pci.c            |   3 -
 drivers/usb/typec/tipd/core.c                      |   2 +-
 drivers/vfio/vfio_iommu_type1.c                    |   5 -
 drivers/vhost/vhost.c                              |  22 +-
 drivers/video/fbdev/arcfb.c                        |   5 +-
 drivers/video/fbdev/au1100fb.c                     |  11 +-
 drivers/video/fbdev/au1200fb.c                     |   6 +-
 drivers/video/fbdev/broadsheetfb.c                 |   5 +-
 drivers/video/fbdev/bw2.c                          |   6 +-
 drivers/video/fbdev/core/bitblit.c                 |   3 -
 drivers/video/fbdev/imsttfb.c                      |  12 +-
 drivers/video/fbdev/matrox/matroxfb_maven.c        |   2 +-
 drivers/video/fbdev/ssd1307fb.c                    |   2 +-
 drivers/xen/pvcalls-back.c                         |   9 +-
 fs/Kconfig                                         |   9 +-
 fs/Makefile                                        |   4 +-
 fs/btrfs/bio.c                                     |   6 +-
 fs/btrfs/block-group.c                             |  14 +-
 fs/btrfs/disk-io.c                                 |  11 +-
 fs/btrfs/file-item.c                               |   4 +-
 fs/btrfs/scrub.c                                   |  57 +--
 fs/btrfs/tree-log.c                                |   2 +-
 fs/{smb/client => cifs}/Kconfig                    |   0
 fs/{smb/client => cifs}/Makefile                   |   0
 fs/{smb/client => cifs}/asn1.c                     |   0
 fs/{smb/client => cifs}/cached_dir.c               |   0
 fs/{smb/client => cifs}/cached_dir.h               |   0
 fs/{smb/client => cifs}/cifs_debug.c               |   8 +-
 fs/{smb/client => cifs}/cifs_debug.h               |   0
 fs/{smb/client => cifs}/cifs_dfs_ref.c             |   0
 fs/{smb/client => cifs}/cifs_fs_sb.h               |   0
 fs/{smb/client => cifs}/cifs_ioctl.h               |   0
 fs/{smb/client => cifs}/cifs_spnego.c              |   0
 fs/{smb/client => cifs}/cifs_spnego.h              |   0
 .../client => cifs}/cifs_spnego_negtokeninit.asn1  |   0
 fs/{smb/client => cifs}/cifs_swn.c                 |   0
 fs/{smb/client => cifs}/cifs_swn.h                 |   0
 fs/{smb/client => cifs}/cifs_unicode.c             |   0
 fs/{smb/client => cifs}/cifs_unicode.h             |   0
 fs/{smb/client => cifs}/cifs_uniupr.h              |   0
 fs/{smb/client => cifs}/cifsacl.c                  |   0
 fs/{smb/client => cifs}/cifsacl.h                  |   0
 fs/{smb/client => cifs}/cifsencrypt.c              |   2 +-
 fs/{smb/client => cifs}/cifsfs.c                   |   0
 fs/{smb/client => cifs}/cifsfs.h                   |   0
 fs/{smb/client => cifs}/cifsglob.h                 |   2 +-
 fs/{smb/client => cifs}/cifspdu.h                  |   2 +-
 fs/{smb/client => cifs}/cifsproto.h                |   0
 fs/{smb/client => cifs}/cifsroot.c                 |   0
 fs/{smb/client => cifs}/cifssmb.c                  |   0
 fs/{smb/client => cifs}/connect.c                  |   0
 fs/{smb/client => cifs}/dfs.c                      |   2 +-
 fs/{smb/client => cifs}/dfs.h                      |   0
 fs/{smb/client => cifs}/dfs_cache.c                |   0
 fs/{smb/client => cifs}/dfs_cache.h                |   0
 fs/{smb/client => cifs}/dir.c                      |   0
 fs/{smb/client => cifs}/dns_resolve.c              |   0
 fs/{smb/client => cifs}/dns_resolve.h              |   0
 fs/{smb/client => cifs}/export.c                   |   0
 fs/{smb/client => cifs}/file.c                     |   3 +-
 fs/{smb/client => cifs}/fs_context.c               |   8 -
 fs/{smb/client => cifs}/fs_context.h               |   0
 fs/{smb/client => cifs}/fscache.c                  |   0
 fs/{smb/client => cifs}/fscache.h                  |   0
 fs/{smb/client => cifs}/inode.c                    |   0
 fs/{smb/client => cifs}/ioctl.c                    |   6 +-
 fs/{smb/client => cifs}/link.c                     |   0
 fs/{smb/client => cifs}/misc.c                     |   0
 fs/{smb/client => cifs}/netlink.c                  |   0
 fs/{smb/client => cifs}/netlink.h                  |   0
 fs/{smb/client => cifs}/netmisc.c                  |   0
 fs/{smb/client => cifs}/nterr.c                    |   0
 fs/{smb/client => cifs}/nterr.h                    |   0
 fs/{smb/client => cifs}/ntlmssp.h                  |   0
 fs/{smb/client => cifs}/readdir.c                  |   0
 fs/{smb/client => cifs}/rfc1002pdu.h               |   0
 fs/{smb/client => cifs}/sess.c                     |   0
 fs/{smb/client => cifs}/smb1ops.c                  |   0
 fs/{smb/client => cifs}/smb2file.c                 |   0
 fs/{smb/client => cifs}/smb2glob.h                 |   0
 fs/{smb/client => cifs}/smb2inode.c                |   0
 fs/{smb/client => cifs}/smb2maperror.c             |   0
 fs/{smb/client => cifs}/smb2misc.c                 |   0
 fs/{smb/client => cifs}/smb2ops.c                  |   1 +
 fs/{smb/client => cifs}/smb2pdu.c                  |   2 +-
 fs/{smb/client => cifs}/smb2pdu.h                  |   0
 fs/{smb/client => cifs}/smb2proto.h                |   0
 fs/{smb/client => cifs}/smb2status.h               |   0
 fs/{smb/client => cifs}/smb2transport.c            |   0
 fs/{smb/client => cifs}/smbdirect.c                |   0
 fs/{smb/client => cifs}/smbdirect.h                |   0
 fs/{smb/client => cifs}/smbencrypt.c               |   2 +-
 fs/{smb/client => cifs}/smberr.h                   |   0
 fs/{smb/client => cifs}/trace.c                    |   0
 fs/{smb/client => cifs}/trace.h                    |   0
 fs/{smb/client => cifs}/transport.c                |   0
 fs/{smb/client => cifs}/unc.c                      |   0
 fs/{smb/client => cifs}/winucase.c                 |   0
 fs/{smb/client => cifs}/xattr.c                    |   0
 fs/coredump.c                                      |   4 +-
 fs/erofs/Kconfig                                   |   1 -
 fs/erofs/Makefile                                  |   4 +-
 fs/erofs/internal.h                                |  13 +-
 fs/erofs/xattr.c                                   |   2 +-
 fs/erofs/zdata.c                                   |   2 +
 fs/ext4/ext4.h                                     |   5 +-
 fs/ext4/fsync.c                                    |   7 -
 fs/ext4/inode.c                                    |  34 +-
 fs/ext4/mballoc.c                                  |  16 +-
 fs/ext4/super.c                                    |  24 +-
 fs/ext4/xattr.c                                    |  41 ++-
 fs/{smb/server => ksmbd}/Kconfig                   |   0
 fs/{smb/server => ksmbd}/Makefile                  |   0
 fs/{smb/server => ksmbd}/asn1.c                    |   0
 fs/{smb/server => ksmbd}/asn1.h                    |   0
 fs/{smb/server => ksmbd}/auth.c                    |   2 +-
 fs/{smb/server => ksmbd}/auth.h                    |   0
 fs/{smb/server => ksmbd}/connection.c              |   0
 fs/{smb/server => ksmbd}/connection.h              |   0
 fs/{smb/server => ksmbd}/crypto_ctx.c              |   0
 fs/{smb/server => ksmbd}/crypto_ctx.h              |   0
 fs/{smb/server => ksmbd}/glob.h                    |   0
 fs/{smb/server => ksmbd}/ksmbd_netlink.h           |   0
 .../ksmbd_spnego_negtokeninit.asn1                 |   0
 .../ksmbd_spnego_negtokentarg.asn1                 |   0
 fs/{smb/server => ksmbd}/ksmbd_work.c              |   0
 fs/{smb/server => ksmbd}/ksmbd_work.h              |   0
 fs/{smb/server => ksmbd}/mgmt/ksmbd_ida.c          |   0
 fs/{smb/server => ksmbd}/mgmt/ksmbd_ida.h          |   0
 fs/{smb/server => ksmbd}/mgmt/share_config.c       |   0
 fs/{smb/server => ksmbd}/mgmt/share_config.h       |   0
 fs/{smb/server => ksmbd}/mgmt/tree_connect.c       |   0
 fs/{smb/server => ksmbd}/mgmt/tree_connect.h       |   0
 fs/{smb/server => ksmbd}/mgmt/user_config.c        |   0
 fs/{smb/server => ksmbd}/mgmt/user_config.h        |   0
 fs/{smb/server => ksmbd}/mgmt/user_session.c       |   0
 fs/{smb/server => ksmbd}/mgmt/user_session.h       |   0
 fs/{smb/server => ksmbd}/misc.c                    |   0
 fs/{smb/server => ksmbd}/misc.h                    |   0
 fs/{smb/server => ksmbd}/ndr.c                     |   0
 fs/{smb/server => ksmbd}/ndr.h                     |   0
 fs/{smb/server => ksmbd}/nterr.h                   |   0
 fs/{smb/server => ksmbd}/ntlmssp.h                 |   0
 fs/{smb/server => ksmbd}/oplock.c                  |  72 ++--
 fs/{smb/server => ksmbd}/oplock.h                  |   0
 fs/{smb/server => ksmbd}/server.c                  |   0
 fs/{smb/server => ksmbd}/server.h                  |   0
 fs/{smb/server => ksmbd}/smb2misc.c                |   0
 fs/{smb/server => ksmbd}/smb2ops.c                 |   0
 fs/{smb/server => ksmbd}/smb2pdu.c                 |  96 ++---
 fs/{smb/server => ksmbd}/smb2pdu.h                 |   0
 fs/{smb/server => ksmbd}/smb_common.c              |   0
 fs/{smb/server => ksmbd}/smb_common.h              |   2 +-
 fs/{smb/server => ksmbd}/smbacl.c                  |   0
 fs/{smb/server => ksmbd}/smbacl.h                  |   0
 fs/{smb/server => ksmbd}/smbfsctl.h                |   2 +-
 fs/{smb/server => ksmbd}/smbstatus.h               |   2 +-
 fs/{smb/server => ksmbd}/transport_ipc.c           |   0
 fs/{smb/server => ksmbd}/transport_ipc.h           |   0
 fs/{smb/server => ksmbd}/transport_rdma.c          |   0
 fs/{smb/server => ksmbd}/transport_rdma.h          |   0
 fs/{smb/server => ksmbd}/transport_tcp.c           |   0
 fs/{smb/server => ksmbd}/transport_tcp.h           |   0
 fs/{smb/server => ksmbd}/unicode.c                 |   0
 fs/{smb/server => ksmbd}/unicode.h                 |   0
 fs/{smb/server => ksmbd}/uniupr.h                  |   0
 fs/{smb/server => ksmbd}/vfs.c                     |   9 +-
 fs/{smb/server => ksmbd}/vfs.h                     |   0
 fs/{smb/server => ksmbd}/vfs_cache.c               |   0
 fs/{smb/server => ksmbd}/vfs_cache.h               |   0
 fs/{smb/server => ksmbd}/xattr.h                   |   0
 fs/nfs/dir.c                                       |   4 +-
 fs/nfs/nfs4proc.c                                  |  12 +-
 fs/nfsd/nfsctl.c                                   |   7 +-
 fs/nfsd/vfs.c                                      |  10 +-
 fs/smb/Kconfig                                     |  11 -
 fs/smb/Makefile                                    |   5 -
 fs/{smb/common => smbfs_common}/Makefile           |   4 +-
 fs/{smb/common => smbfs_common}/arc4.h             |   0
 fs/{smb/common => smbfs_common}/cifs_arc4.c        |   0
 fs/{smb/common => smbfs_common}/cifs_md4.c         |   0
 fs/{smb/common => smbfs_common}/md4.h              |   0
 fs/{smb/common => smbfs_common}/smb2pdu.h          |   0
 fs/{smb/common => smbfs_common}/smbfsctl.h         |   0
 fs/xattr.c                                         |  15 +-
 include/asm-generic/vmlinux.lds.h                  |   9 +-
 include/drm/drm_managed.h                          |  18 +-
 include/linux/arm_ffa.h                            |   1 -
 include/linux/cper.h                               |   6 -
 include/linux/efi.h                                |   2 -
 include/linux/firewire.h                           |   2 +-
 include/linux/fs.h                                 |  42 +--
 include/linux/if_team.h                            |   1 -
 include/linux/iio/iio-gts-helper.h                 |   2 +-
 include/linux/lockdep.h                            |  14 -
 include/linux/lockdep_types.h                      |   1 -
 include/linux/mlx5/driver.h                        |   1 -
 include/linux/mlx5/mlx5_ifc.h                      |   4 +-
 include/linux/msi.h                                |   9 +-
 include/linux/page-flags.h                         |   6 -
 include/linux/pe.h                                 |  25 +-
 include/linux/power/bq27xxx_battery.h              |   4 -
 include/linux/sched/task.h                         |   1 +
 include/linux/sched/vhost_task.h                   |  15 +-
 include/linux/skbuff.h                             |  10 -
 include/linux/skmsg.h                              |   3 +-
 include/linux/sunrpc/svcsock.h                     |   7 +-
 include/linux/usb/hcd.h                            |   5 -
 include/media/v4l2-subdev.h                        |   1 -
 include/net/bluetooth/hci_core.h                   |   2 +-
 include/net/bonding.h                              |   1 -
 include/net/handshake.h                            |   1 -
 include/net/ip.h                                   |   2 -
 include/net/mana/mana.h                            |   2 +
 include/net/page_pool.h                            |  18 +
 include/net/sock.h                                 |   4 -
 include/net/tcp.h                                  |  11 -
 include/net/tls.h                                  |   1 -
 include/sound/soc-acpi.h                           |   1 -
 include/sound/soc-dpcm.h                           |   4 -
 include/target/iscsi/iscsi_target_core.h           |   7 +-
 include/uapi/linux/handshake.h                     |   1 -
 include/uapi/linux/in.h                            |   1 -
 include/uapi/sound/skl-tplg-interface.h            |   3 +-
 io_uring/epoll.c                                   |   4 +
 io_uring/sqpoll.c                                  |   6 +-
 kernel/bpf/hashtab.c                               |   6 +-
 kernel/bpf/offload.c                               |   2 +-
 kernel/bpf/verifier.c                              |   2 +-
 kernel/exit.c                                      |   5 +-
 kernel/fork.c                                      |  13 +-
 kernel/irq/msi.c                                   |   4 +-
 kernel/locking/lockdep.c                           |  28 +-
 kernel/module/decompress.c                         |   2 +-
 kernel/module/main.c                               |   4 +-
 kernel/module/stats.c                              |   4 +-
 kernel/signal.c                                    |   8 +-
 kernel/trace/trace_events_user.c                   | 290 ++++++++++-----
 kernel/trace/trace_output.c                        |   2 +-
 kernel/trace/trace_probe.h                         |   2 +-
 kernel/vhost_task.c                                |  92 ++---
 lib/debugobjects.c                                 |  17 +-
 lib/test_firmware.c                                |  81 +----
 mm/Kconfig.debug                                   |   1 -
 mm/page_table_check.c                              |   6 -
 net/bluetooth/hci_conn.c                           |  77 ++--
 net/core/page_pool.c                               |  28 +-
 net/core/rtnetlink.c                               |  54 +--
 net/core/skbuff.c                                  |   4 +-
 net/core/skmsg.c                                   |  81 +++--
 net/core/sock.c                                    |   2 +-
 net/core/sock_map.c                                |   3 +-
 net/handshake/handshake-test.c                     |  44 +--
 net/handshake/handshake.h                          |   1 -
 net/handshake/netlink.c                            |  12 +-
 net/handshake/request.c                            |   4 -
 net/handshake/tlshd.c                              |   8 -
 net/ipv4/af_inet.c                                 |   2 -
 net/ipv4/inet_connection_sock.c                    |   1 -
 net/ipv4/ip_sockglue.c                             |  12 +-
 net/ipv4/raw.c                                     |   5 +-
 net/ipv4/tcp.c                                     |  20 +-
 net/ipv4/tcp_bpf.c                                 |  79 +----
 net/ipv4/tcp_input.c                               |   2 +-
 net/ipv4/tcp_timer.c                               |  16 +-
 net/ipv4/udp.c                                     |   7 +-
 net/ipv4/udplite.c                                 |   2 -
 net/ipv6/exthdrs_core.c                            |   2 -
 net/ipv6/raw.c                                     |   3 +-
 net/ipv6/udplite.c                                 |   2 -
 net/mptcp/protocol.c                               | 140 ++++----
 net/mptcp/protocol.h                               |  15 +-
 net/mptcp/subflow.c                                |  28 +-
 net/netlink/af_netlink.c                           |   2 +-
 net/netrom/nr_subr.c                               |   7 +-
 net/packet/af_packet.c                             |   8 +-
 net/packet/diag.c                                  |   2 +-
 net/rxrpc/af_rxrpc.c                               |   1 -
 net/rxrpc/ar-internal.h                            |   1 -
 net/rxrpc/local_event.c                            |  11 +-
 net/sched/cls_flower.c                             |   3 -
 net/sched/sch_api.c                                |  16 +-
 net/sched/sch_ingress.c                            |  16 +-
 net/sctp/transport.c                               |  11 +-
 net/smc/af_smc.c                                   |   9 +-
 net/smc/smc_core.c                                 |   1 -
 net/smc/smc_llc.c                                  |   9 +-
 net/sunrpc/sched.c                                 |   5 +-
 net/sunrpc/svcsock.c                               |  24 +-
 net/tls/tls.h                                      |   5 -
 net/tls/tls_device.c                               |  22 +-
 net/tls/tls_strp.c                                 | 189 ++--------
 net/tls/tls_sw.c                                   |   8 +-
 net/unix/af_unix.c                                 |   7 +-
 net/vmw_vsock/virtio_transport_common.c            |   5 +-
 samples/bpf/hbm.c                                  |   1 +
 security/selinux/Makefile                          |   6 +-
 sound/hda/hdac_device.c                            |   2 +-
 sound/pci/hda/patch_ca0132.c                       |   1 -
 sound/pci/hda/patch_realtek.c                      |   2 -
 sound/soc/codecs/cs35l41-lib.c                     |   6 +-
 sound/soc/codecs/lpass-tx-macro.c                  |   5 -
 sound/soc/codecs/rt5682-i2c.c                      |   4 +-
 sound/soc/codecs/rt5682.c                          |   6 -
 sound/soc/codecs/rt5682.h                          |   1 -
 sound/soc/dwc/dwc-i2s.c                            |  41 ++-
 sound/soc/intel/avs/apl.c                          |   6 +-
 sound/soc/intel/avs/avs.h                          |   4 +-
 sound/soc/intel/avs/board_selection.c              |   2 +-
 sound/soc/intel/avs/control.c                      |  22 +-
 sound/soc/intel/avs/dsp.c                          |   4 +-
 sound/soc/intel/avs/messages.h                     |   2 +-
 sound/soc/intel/avs/path.h                         |   2 +-
 sound/soc/intel/avs/pcm.c                          |  23 +-
 sound/soc/intel/avs/probes.c                       |   2 +-
 sound/soc/soc-pcm.c                                |  20 --
 tools/gpio/lsgpio.c                                |   2 +-
 tools/include/linux/coresight-pmu.h                |  13 +
 tools/include/uapi/linux/in.h                      |   1 -
 tools/net/ynl/lib/ynl.py                           |   5 +-
 tools/perf/Makefile.config                         |   1 -
 tools/perf/Makefile.perf                           |   3 +-
 tools/perf/arch/arm/util/pmu.c                     |   2 +-
 tools/perf/builtin-ftrace.c                        |   2 +-
 tools/perf/util/Build                              |   2 +-
 tools/perf/util/bpf_skel/sample_filter.bpf.c       |   4 +-
 tools/perf/util/cs-etm.h                           |  13 -
 tools/perf/util/evsel.c                            |   1 -
 tools/perf/util/evsel.h                            |   6 +-
 tools/perf/util/symbol-elf.c                       |  27 --
 tools/testing/cxl/Kbuild                           |   1 -
 tools/testing/cxl/test/mem.c                       |   1 -
 tools/testing/cxl/test/mock.c                      |  15 -
 tools/testing/selftests/bpf/Makefile               |   2 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 131 -------
 .../selftests/bpf/prog_tests/sockmap_helpers.h     | 390 ---------------------
 .../selftests/bpf/prog_tests/sockmap_listen.c      | 370 ++++++++++++++++++-
 .../selftests/bpf/progs/test_sockmap_drop_prog.c   |  32 --
 .../selftests/bpf/progs/test_sockmap_kern.h        |  12 +-
 .../selftests/bpf/progs/test_sockmap_pass_prog.c   |  32 --
 .../ftrace/test.d/filter/event-filter-function.tc  |  45 +--
 tools/testing/selftests/gpio/gpio-sim.sh           |   3 -
 tools/testing/selftests/kvm/Makefile               |   1 -
 .../selftests/kvm/x86_64/recalc_apic_map_test.c    |  74 ----
 tools/testing/selftests/net/fib_tests.sh           |   2 +-
 tools/testing/selftests/net/mptcp/Makefile         |   2 +-
 tools/testing/selftests/net/mptcp/diag.sh          |   4 -
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   4 -
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  17 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  40 ---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |   4 -
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |   4 -
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   4 -
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |   4 -
 tools/testing/selftests/user_events/dyn_test.c     | 177 +++++++---
 tools/testing/selftests/user_events/ftrace_test.c  |  88 ++++-
 tools/testing/selftests/user_events/perf_test.c    |  82 +++++
 740 files changed, 3557 insertions(+), 5855 deletions(-)
 rename Documentation/filesystems/{smb => cifs}/cifsroot.rst (97%)
 rename Documentation/filesystems/{smb => cifs}/index.rst (100%)
 rename Documentation/filesystems/{smb => cifs}/ksmbd.rst (100%)
 rename arch/powerpc/crypto/{aesp10-ppc.pl => aesp8-ppc.pl} (99%)
 rename arch/powerpc/crypto/{ghashp10-ppc.pl => ghashp8-ppc.pl} (97%)
 delete mode 100644 arch/xtensa/lib/bswapdi2.S
 delete mode 100644 arch/xtensa/lib/bswapsi2.S
 rename fs/{smb/client => cifs}/Kconfig (100%)
 rename fs/{smb/client => cifs}/Makefile (100%)
 rename fs/{smb/client => cifs}/asn1.c (100%)
 rename fs/{smb/client => cifs}/cached_dir.c (100%)
 rename fs/{smb/client => cifs}/cached_dir.h (100%)
 rename fs/{smb/client => cifs}/cifs_debug.c (99%)
 rename fs/{smb/client => cifs}/cifs_debug.h (100%)
 rename fs/{smb/client => cifs}/cifs_dfs_ref.c (100%)
 rename fs/{smb/client => cifs}/cifs_fs_sb.h (100%)
 rename fs/{smb/client => cifs}/cifs_ioctl.h (100%)
 rename fs/{smb/client => cifs}/cifs_spnego.c (100%)
 rename fs/{smb/client => cifs}/cifs_spnego.h (100%)
 rename fs/{smb/client => cifs}/cifs_spnego_negtokeninit.asn1 (100%)
 rename fs/{smb/client => cifs}/cifs_swn.c (100%)
 rename fs/{smb/client => cifs}/cifs_swn.h (100%)
 rename fs/{smb/client => cifs}/cifs_unicode.c (100%)
 rename fs/{smb/client => cifs}/cifs_unicode.h (100%)
 rename fs/{smb/client => cifs}/cifs_uniupr.h (100%)
 rename fs/{smb/client => cifs}/cifsacl.c (100%)
 rename fs/{smb/client => cifs}/cifsacl.h (100%)
 rename fs/{smb/client => cifs}/cifsencrypt.c (99%)
 rename fs/{smb/client => cifs}/cifsfs.c (100%)
 rename fs/{smb/client => cifs}/cifsfs.h (100%)
 rename fs/{smb/client => cifs}/cifsglob.h (99%)
 rename fs/{smb/client => cifs}/cifspdu.h (99%)
 rename fs/{smb/client => cifs}/cifsproto.h (100%)
 rename fs/{smb/client => cifs}/cifsroot.c (100%)
 rename fs/{smb/client => cifs}/cifssmb.c (100%)
 rename fs/{smb/client => cifs}/connect.c (100%)
 rename fs/{smb/client => cifs}/dfs.c (99%)
 rename fs/{smb/client => cifs}/dfs.h (100%)
 rename fs/{smb/client => cifs}/dfs_cache.c (100%)
 rename fs/{smb/client => cifs}/dfs_cache.h (100%)
 rename fs/{smb/client => cifs}/dir.c (100%)
 rename fs/{smb/client => cifs}/dns_resolve.c (100%)
 rename fs/{smb/client => cifs}/dns_resolve.h (100%)
 rename fs/{smb/client => cifs}/export.c (100%)
 rename fs/{smb/client => cifs}/file.c (99%)
 rename fs/{smb/client => cifs}/fs_context.c (99%)
 rename fs/{smb/client => cifs}/fs_context.h (100%)
 rename fs/{smb/client => cifs}/fscache.c (100%)
 rename fs/{smb/client => cifs}/fscache.h (100%)
 rename fs/{smb/client => cifs}/inode.c (100%)
 rename fs/{smb/client => cifs}/ioctl.c (98%)
 rename fs/{smb/client => cifs}/link.c (100%)
 rename fs/{smb/client => cifs}/misc.c (100%)
 rename fs/{smb/client => cifs}/netlink.c (100%)
 rename fs/{smb/client => cifs}/netlink.h (100%)
 rename fs/{smb/client => cifs}/netmisc.c (100%)
 rename fs/{smb/client => cifs}/nterr.c (100%)
 rename fs/{smb/client => cifs}/nterr.h (100%)
 rename fs/{smb/client => cifs}/ntlmssp.h (100%)
 rename fs/{smb/client => cifs}/readdir.c (100%)
 rename fs/{smb/client => cifs}/rfc1002pdu.h (100%)
 rename fs/{smb/client => cifs}/sess.c (100%)
 rename fs/{smb/client => cifs}/smb1ops.c (100%)
 rename fs/{smb/client => cifs}/smb2file.c (100%)
 rename fs/{smb/client => cifs}/smb2glob.h (100%)
 rename fs/{smb/client => cifs}/smb2inode.c (100%)
 rename fs/{smb/client => cifs}/smb2maperror.c (100%)
 rename fs/{smb/client => cifs}/smb2misc.c (100%)
 rename fs/{smb/client => cifs}/smb2ops.c (99%)
 rename fs/{smb/client => cifs}/smb2pdu.c (99%)
 rename fs/{smb/client => cifs}/smb2pdu.h (100%)
 rename fs/{smb/client => cifs}/smb2proto.h (100%)
 rename fs/{smb/client => cifs}/smb2status.h (100%)
 rename fs/{smb/client => cifs}/smb2transport.c (100%)
 rename fs/{smb/client => cifs}/smbdirect.c (100%)
 rename fs/{smb/client => cifs}/smbdirect.h (100%)
 rename fs/{smb/client => cifs}/smbencrypt.c (98%)
 rename fs/{smb/client => cifs}/smberr.h (100%)
 rename fs/{smb/client => cifs}/trace.c (100%)
 rename fs/{smb/client => cifs}/trace.h (100%)
 rename fs/{smb/client => cifs}/transport.c (100%)
 rename fs/{smb/client => cifs}/unc.c (100%)
 rename fs/{smb/client => cifs}/winucase.c (100%)
 rename fs/{smb/client => cifs}/xattr.c (100%)
 rename fs/{smb/server => ksmbd}/Kconfig (100%)
 rename fs/{smb/server => ksmbd}/Makefile (100%)
 rename fs/{smb/server => ksmbd}/asn1.c (100%)
 rename fs/{smb/server => ksmbd}/asn1.h (100%)
 rename fs/{smb/server => ksmbd}/auth.c (99%)
 rename fs/{smb/server => ksmbd}/auth.h (100%)
 rename fs/{smb/server => ksmbd}/connection.c (100%)
 rename fs/{smb/server => ksmbd}/connection.h (100%)
 rename fs/{smb/server => ksmbd}/crypto_ctx.c (100%)
 rename fs/{smb/server => ksmbd}/crypto_ctx.h (100%)
 rename fs/{smb/server => ksmbd}/glob.h (100%)
 rename fs/{smb/server => ksmbd}/ksmbd_netlink.h (100%)
 rename fs/{smb/server => ksmbd}/ksmbd_spnego_negtokeninit.asn1 (100%)
 rename fs/{smb/server => ksmbd}/ksmbd_spnego_negtokentarg.asn1 (100%)
 rename fs/{smb/server => ksmbd}/ksmbd_work.c (100%)
 rename fs/{smb/server => ksmbd}/ksmbd_work.h (100%)
 rename fs/{smb/server => ksmbd}/mgmt/ksmbd_ida.c (100%)
 rename fs/{smb/server => ksmbd}/mgmt/ksmbd_ida.h (100%)
 rename fs/{smb/server => ksmbd}/mgmt/share_config.c (100%)
 rename fs/{smb/server => ksmbd}/mgmt/share_config.h (100%)
 rename fs/{smb/server => ksmbd}/mgmt/tree_connect.c (100%)
 rename fs/{smb/server => ksmbd}/mgmt/tree_connect.h (100%)
 rename fs/{smb/server => ksmbd}/mgmt/user_config.c (100%)
 rename fs/{smb/server => ksmbd}/mgmt/user_config.h (100%)
 rename fs/{smb/server => ksmbd}/mgmt/user_session.c (100%)
 rename fs/{smb/server => ksmbd}/mgmt/user_session.h (100%)
 rename fs/{smb/server => ksmbd}/misc.c (100%)
 rename fs/{smb/server => ksmbd}/misc.h (100%)
 rename fs/{smb/server => ksmbd}/ndr.c (100%)
 rename fs/{smb/server => ksmbd}/ndr.h (100%)
 rename fs/{smb/server => ksmbd}/nterr.h (100%)
 rename fs/{smb/server => ksmbd}/ntlmssp.h (100%)
 rename fs/{smb/server => ksmbd}/oplock.c (98%)
 rename fs/{smb/server => ksmbd}/oplock.h (100%)
 rename fs/{smb/server => ksmbd}/server.c (100%)
 rename fs/{smb/server => ksmbd}/server.h (100%)
 rename fs/{smb/server => ksmbd}/smb2misc.c (100%)
 rename fs/{smb/server => ksmbd}/smb2ops.c (100%)
 rename fs/{smb/server => ksmbd}/smb2pdu.c (99%)
 rename fs/{smb/server => ksmbd}/smb2pdu.h (100%)
 rename fs/{smb/server => ksmbd}/smb_common.c (100%)
 rename fs/{smb/server => ksmbd}/smb_common.h (99%)
 rename fs/{smb/server => ksmbd}/smbacl.c (100%)
 rename fs/{smb/server => ksmbd}/smbacl.h (100%)
 rename fs/{smb/server => ksmbd}/smbfsctl.h (98%)
 rename fs/{smb/server => ksmbd}/smbstatus.h (99%)
 rename fs/{smb/server => ksmbd}/transport_ipc.c (100%)
 rename fs/{smb/server => ksmbd}/transport_ipc.h (100%)
 rename fs/{smb/server => ksmbd}/transport_rdma.c (100%)
 rename fs/{smb/server => ksmbd}/transport_rdma.h (100%)
 rename fs/{smb/server => ksmbd}/transport_tcp.c (100%)
 rename fs/{smb/server => ksmbd}/transport_tcp.h (100%)
 rename fs/{smb/server => ksmbd}/unicode.c (100%)
 rename fs/{smb/server => ksmbd}/unicode.h (100%)
 rename fs/{smb/server => ksmbd}/uniupr.h (100%)
 rename fs/{smb/server => ksmbd}/vfs.c (99%)
 rename fs/{smb/server => ksmbd}/vfs.h (100%)
 rename fs/{smb/server => ksmbd}/vfs_cache.c (100%)
 rename fs/{smb/server => ksmbd}/vfs_cache.h (100%)
 rename fs/{smb/server => ksmbd}/xattr.h (100%)
 delete mode 100644 fs/smb/Kconfig
 delete mode 100644 fs/smb/Makefile
 rename fs/{smb/common => smbfs_common}/Makefile (59%)
 rename fs/{smb/common => smbfs_common}/arc4.h (100%)
 rename fs/{smb/common => smbfs_common}/cifs_arc4.c (100%)
 rename fs/{smb/common => smbfs_common}/cifs_md4.c (100%)
 rename fs/{smb/common => smbfs_common}/md4.h (100%)
 rename fs/{smb/common => smbfs_common}/smb2pdu.h (100%)
 rename fs/{smb/common => smbfs_common}/smbfsctl.h (100%)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
 delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_drop_prog.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_pass_prog.c
 delete mode 100644 tools/testing/selftests/kvm/x86_64/recalc_apic_map_test.c
 delete mode 100644 tools/testing/selftests/net/mptcp/mptcp_lib.sh
