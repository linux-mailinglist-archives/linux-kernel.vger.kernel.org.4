Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F55665A23
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjAKLas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjAKLae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:30:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFFF6429
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:30:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 160C161C52
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D41C433D2;
        Wed, 11 Jan 2023 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673436631;
        bh=Ti9f/EP8DXRKqcZL/g8DJA3XQkPNMwEVy2Ac/5zfyLI=;
        h=From:To:Cc:Subject:Date:From;
        b=dKNrkNoYMxMGEEE3SKXhrZFzExjnCsoUMjgOus39CxG2LffpSijy6JuRJaRljzxoL
         C5+ccQwPocihrGX8gSPF9XVsJEhfuAiEgrPsqEJiqD7C73bOcJ9/QAR2RR3Fiy7HZK
         XMGd1FZ3SHFs2UwPCFm8HVgS99x9I8dJUqcbgRjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 00/16] driver core: make more things const!
Date:   Wed, 11 Jan 2023 12:30:02 +0100
Message-Id: <20230111113018.459199-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9856; i=gregkh@linuxfoundation.org; h=from:subject; bh=Ti9f/EP8DXRKqcZL/g8DJA3XQkPNMwEVy2Ac/5zfyLI=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn75h4Rb7l/bDvbBL3H0wVXxM5NMMl2vPnMNH8Kd52fvZ+o p1VoRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEyEP4hhfvTaZSrr1G+YPF3lnKa7a/ mnn1P/zGeYn7jPlCFlY/xRft7CB2c4zt9Yvid3IQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an updated version of this original series:
	https://lore.kernel.org/all/20221123122523.1332370-1-gregkh@linuxfoundation.org/
that has the goal of making more functions in the driver core take const
pointers as they do not actually modify anything.  This work is an
outgrowth of some conversations I had with the Linux Rust developers
talking about the mutability of many of the driver model pointers.

A small subset of the original submission is now in 6.2-rc1 and this
series is an outgrown of the original submission in that many things are
now changed and a bit more explicit than before.

I can take all of these through the driver-core git tree as they depend
on each other.  0-day has been passing on this series for quite a while,
so all should be good unless some subsystem trees have added new busses
without me noticing.

Bonus for all of this work, the overall code size of the kernel actually
decreased a tiny bit:
 126 files changed, 283 insertions(+), 309 deletions(-)
while adding a lot more type-safeness to the system.

Changes from v1:
  - rebased on 6.2-rc1 and dropped accepted patches already in there.
  - container_of_const() is now in 6.2-rc1 so use that in many
    individual subsystems to make the follow-on changes in the driver
    core more obvious.
  - collected some Reviewed-by
  - of_device_uevent_modalias was being "abused" by many different
    subsystems in using it instead of a local bus function which played
    havoc when enabling stricter type-checking.  Move that out into a
    new function for the busses that were doing this to make it more
    obvious what they need here.

Greg Kroah-Hartman (16):
  of: device: make of_device_uevent_modalias() take a const device *
  i3c: move dev_to_i3cdev() to use container_of_const()
  platform/surface: aggregator: move to_ssam_device() to use
    container_of_const()
  firewire: move fw_device() and fw_unit() to use container_of_const()
  driver core: make struct device_type.uevent() take a const *
  driver core: make struct device_type.devnode() take a const *
  driver core: device_get_devnode() should take a const *
  vio: move to_vio_dev() to use container_of_const()
  platform/x86: wmi: move dev_to_wblock() and dev_to_wdev to use
    container_of_const()
  drivers: hv: move device_to_hv_device to use container_of_const()
  virtio: move dev_to_virtio() to use container_of_const()
  drm/mipi-dsi: move to_mipi_dsi_device() to use container_of_const()
  mcb: move to_mcb_device() to use container_of_const()
  xen/xenbus: move to_xenbus_device() to use container_of_const()
  driver core: make struct bus_type.uevent() take a const *
  kobject: kset_uevent_ops: make uevent() callback take a const *

 arch/mips/sgi-ip22/ip22-gio.c              |  4 ++--
 arch/parisc/kernel/drivers.c               |  4 ++--
 arch/powerpc/include/asm/vio.h             |  5 +----
 arch/powerpc/platforms/pseries/ibmebus.c   |  7 ++++++-
 arch/powerpc/platforms/pseries/vio.c       |  4 ++--
 arch/sparc/include/asm/vio.h               |  5 +----
 arch/sparc/kernel/vio.c                    |  2 +-
 block/genhd.c                              |  2 +-
 block/partitions/core.c                    |  4 ++--
 drivers/acpi/bus.c                         |  2 +-
 drivers/acpi/device_sysfs.c                |  8 ++++----
 drivers/acpi/internal.h                    |  2 +-
 drivers/amba/bus.c                         |  4 ++--
 drivers/base/auxiliary.c                   |  2 +-
 drivers/base/base.h                        |  2 ++
 drivers/base/core.c                        |  6 +++---
 drivers/base/cpu.c                         |  2 +-
 drivers/base/platform.c                    |  4 ++--
 drivers/bcma/main.c                        |  6 +++---
 drivers/bus/fsl-mc/fsl-mc-bus.c            |  4 ++--
 drivers/bus/mhi/ep/main.c                  |  4 ++--
 drivers/bus/mhi/host/init.c                |  4 ++--
 drivers/bus/mips_cdmm.c                    |  4 ++--
 drivers/bus/sunxi-rsb.c                    |  7 ++++++-
 drivers/cxl/core/memdev.c                  |  4 ++--
 drivers/cxl/core/port.c                    |  8 ++++----
 drivers/cxl/cxl.h                          |  4 ++--
 drivers/cxl/cxlmem.h                       |  2 +-
 drivers/dax/bus.c                          |  2 +-
 drivers/eisa/eisa-bus.c                    |  4 ++--
 drivers/firewire/core-device.c             |  8 ++++----
 drivers/firmware/arm_ffa/bus.c             |  4 ++--
 drivers/fpga/dfl.c                         |  4 ++--
 drivers/fsi/fsi-core.c                     |  6 +++---
 drivers/gpu/drm/display/drm_dp_aux_bus.c   |  7 ++++++-
 drivers/gpu/drm/drm_mipi_dsi.c             |  4 ++--
 drivers/gpu/host1x/bus.c                   |  2 +-
 drivers/greybus/core.c                     | 14 +++++++-------
 drivers/hid/hid-core.c                     |  4 ++--
 drivers/hid/intel-ish-hid/ishtp/bus.c      |  2 +-
 drivers/hsi/hsi_core.c                     |  2 +-
 drivers/hv/vmbus_drv.c                     |  4 ++--
 drivers/hwtracing/intel_th/core.c          |  6 +++---
 drivers/hwtracing/intel_th/intel_th.h      |  4 ++--
 drivers/i2c/i2c-core-base.c                |  4 ++--
 drivers/i3c/device.c                       | 14 +-------------
 drivers/i3c/master.c                       |  4 ++--
 drivers/input/input.c                      | 16 ++++++++--------
 drivers/input/serio/serio.c                |  4 ++--
 drivers/ipack/ipack.c                      |  4 ++--
 drivers/macintosh/macio_asic.c             |  7 ++++++-
 drivers/mcb/mcb-core.c                     |  4 ++--
 drivers/media/rc/rc-main.c                 |  2 +-
 drivers/memstick/core/memstick.c           |  6 +++---
 drivers/misc/mei/bus.c                     |  4 ++--
 drivers/misc/tifm_core.c                   |  4 ++--
 drivers/mmc/core/bus.c                     |  4 ++--
 drivers/mmc/core/sdio_bus.c                |  4 ++--
 drivers/net/phy/mdio_bus.c                 |  2 +-
 drivers/net/xen-netback/xenbus.c           |  2 +-
 drivers/nvdimm/bus.c                       |  4 ++--
 drivers/nvdimm/dax_devs.c                  |  2 +-
 drivers/nvdimm/dimm_devs.c                 |  2 +-
 drivers/nvdimm/nd-core.h                   | 10 +++++-----
 drivers/nvdimm/nd.h                        |  4 ++--
 drivers/nvdimm/region_devs.c               |  4 ++--
 drivers/of/device.c                        |  4 ++--
 drivers/pci/pci-driver.c                   |  4 ++--
 drivers/pcmcia/ds.c                        |  4 ++--
 drivers/platform/surface/aggregator/bus.c  |  4 ++--
 drivers/platform/x86/wmi.c                 | 15 ++++-----------
 drivers/rapidio/rio-driver.c               |  4 ++--
 drivers/rpmsg/rpmsg_core.c                 |  4 ++--
 drivers/s390/cio/css.c                     |  4 ++--
 drivers/s390/cio/device.c                  |  8 ++++----
 drivers/s390/cio/scm.c                     |  2 +-
 drivers/s390/crypto/ap_bus.c               |  4 ++--
 drivers/scsi/scsi_sysfs.c                  |  4 ++--
 drivers/slimbus/core.c                     |  4 ++--
 drivers/soc/qcom/apr.c                     |  4 ++--
 drivers/soundwire/bus_type.c               |  4 ++--
 drivers/spi/spi.c                          |  2 +-
 drivers/spmi/spmi.c                        |  2 +-
 drivers/ssb/main.c                         |  4 ++--
 drivers/staging/greybus/gbphy.c            | 14 +++++++-------
 drivers/tee/tee_core.c                     |  2 +-
 drivers/thunderbolt/switch.c               |  4 ++--
 drivers/thunderbolt/tb.h                   |  2 +-
 drivers/thunderbolt/xdomain.c              |  6 +++---
 drivers/tty/serdev/core.c                  |  2 +-
 drivers/usb/common/ulpi.c                  |  4 ++--
 drivers/usb/core/driver.c                  |  6 +++---
 drivers/usb/core/message.c                 |  8 ++++----
 drivers/usb/core/usb.c                     |  8 ++++----
 drivers/usb/phy/phy.c                      |  6 +++---
 drivers/usb/roles/class.c                  |  3 +--
 drivers/usb/typec/bus.c                    |  4 ++--
 drivers/usb/typec/class.c                  |  2 +-
 drivers/virtio/virtio.c                    |  4 ++--
 drivers/w1/w1.c                            | 10 +++++-----
 drivers/xen/pvcalls-back.c                 |  2 +-
 drivers/xen/xenbus/xenbus_probe_backend.c  |  8 ++++----
 drivers/xen/xenbus/xenbus_probe_frontend.c |  4 ++--
 drivers/zorro/zorro-driver.c               |  4 ++--
 fs/dlm/lockspace.c                         |  4 ++--
 fs/gfs2/sys.c                              |  6 +++---
 include/drm/drm_mipi_dsi.h                 |  5 +----
 include/linux/acpi.h                       |  4 ++--
 include/linux/device.h                     |  6 ++----
 include/linux/device/bus.h                 |  2 +-
 include/linux/firewire.h                   | 15 +++------------
 include/linux/hyperv.h                     |  5 +----
 include/linux/i3c/device.h                 | 11 +++++++++--
 include/linux/kobject.h                    |  2 +-
 include/linux/mcb.h                        |  5 +----
 include/linux/of_device.h                  |  4 ++--
 include/linux/soundwire/sdw_type.h         |  2 +-
 include/linux/spi/spi.h                    |  2 +-
 include/linux/ssb/ssb.h                    |  2 +-
 include/linux/surface_aggregator/device.h  |  5 +----
 include/linux/virtio.h                     |  5 +----
 include/sound/hdaudio.h                    |  2 +-
 include/xen/xenbus.h                       |  7 ++-----
 sound/aoa/soundbus/core.c                  |  6 +++---
 sound/hda/hda_bus_type.c                   |  2 +-
 sound/hda/hdac_device.c                    |  2 +-
 126 files changed, 283 insertions(+), 309 deletions(-)

-- 
2.39.0

