Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050916F0731
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243991AbjD0OWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244007AbjD0OVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:21:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B285BBF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:21:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9196F63DA0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 14:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80214C433D2;
        Thu, 27 Apr 2023 14:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682605258;
        bh=IQjmWOB0z5ugd+m9sI8PLn4RC3D+MZidIn4pLt6aT0s=;
        h=Date:From:To:Cc:Subject:From;
        b=kdTNzC4i+61upzIYb3tHjzGayKOz0QlK7PH8Yrcs4yLllTj2se0QxTqSoREaueCLV
         FRhrez4gsTuTjT1ADPcbXeyzp2hjwV1FFIJrItnhbNSXw1mY9SuW/WbjBmUxgEBHQh
         ui5dEjEWk/oSt6XXFe4hJWi2uH7Rr0NcTp37EfR4=
Date:   Thu, 27 Apr 2023 16:20:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core updates for 6.4-rc1
Message-ID: <ZEqEx7C2iuApvrvt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e364e56293bb98cae1b55fd835f5991c4e96e7d:

  Linux 6.3-rc5 (2023-04-02 14:29:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.4-rc1

for you to fetch changes up to 046b6a171009e1ed9ede02194025e9ccd709beb2:

  device property: make device_property functions take const device * (2023-04-20 14:25:07 +0200)

----------------------------------------------------------------
Driver core changes for 6.4-rc1

Here is the large set of driver core changes for 6.4-rc1.

Once again, a busy development cycle, with lots of changes happening in
the driver core in the quest to be able to move "struct bus" and "struct
class" into read-only memory, a task now complete with these changes.

This will make the future rust interactions with the driver core more
"provably correct" as well as providing more obvious lifetime rules for
all busses and classes in the kernel.

The changes required for this did touch many individual classes and
busses as many callbacks were changed to take const * parameters
instead.  All of these changes have been submitted to the various
subsystem maintainers, giving them plenty of time to review, and most of
them actually did so.

Other than those changes, included in here are a small set of other
things:
  - kobject logging improvements
  - cacheinfo improvements and updates
  - obligatory fw_devlink updates and fixes
  - documentation updates
  - device property cleanups and const * changes
  - firwmare loader dependency fixes.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Amadeusz Sławiński (1):
      firmware_loader: Add debug message with checksum for FW file

Andy Shevchenko (7):
      device property: Clarify description of returned value in some functions
      devres: Pass unique name of the resource to devm_add_action()
      devres: Pass unique name of the resource to devm_add_action_or_reset()
      device property: Constify a few fwnode APIs
      device property: Add headers to the Driver Core entry in MAINTAINERS
      device property: Remove unused struct net_device forward declaration
      driver core: Add a comment to set_primary_fwnode() on nullifying

Arnd Bergmann (1):
      firmware_loader: rework crypto dependencies

Conor Dooley (1):
      docs: driver-api: firmware_loader: fix missing argument in usage example

Florian Fainelli (1):
      firmware_loader: Strip off \n from customized path

Greg Kroah-Hartman (87):
      driver core: remove CONFIG_SYSFS_DEPRECATED and CONFIG_SYSFS_DEPRECATED_V2
      driver core: class: fix block class problem when removing CONFIG_SYSFS_DEPRECATED*
      driver core: class: specify the module owner in __class_register()
      drivers: remove struct module * setting from struct class
      driver core: class: remove struct module owner out of struct class
      driver core: class: remove module * from class_create()
      driver core: class: make class_dev_iter_init() options const
      driver core: class: make class_for_each_device() options const
      driver core: class: make class_find_device*() options const
      driver core: class: make class_create/remove_file*() options const
      driver core: device: make device_destroy() take a const class *
      tpm: fix up the tpm_class shutdown_pre pointer when created
      driver core: device: mark struct class in struct device as constant
      driver core: device: make device_create*() take a const struct class *
      cpufreq: move to use bus_get_dev_root()
      platform/x86: ibm_rtl: move to use bus_get_dev_root()
      platform/x86: intel-uncore-freq: move to use bus_get_dev_root()
      cpu/hotplug: move to use bus_get_dev_root()
      workqueue: move to use bus_get_dev_root()
      x86/microcode: move to use bus_get_dev_root()
      x86/umwait: move to use bus_get_dev_root()
      arm64: cpufeature: move to use bus_get_dev_root()
      powerpc/sysfs: move to use bus_get_dev_root()
      powerpc/powernv: move to use bus_get_dev_root()
      powerpc/pseries: move to use bus_get_dev_root()
      powerpc/fsl: move to use bus_get_dev_root()
      sh: dma-sysfs: move to use bus_get_dev_root()
      sh: intc: move to use bus_get_dev_root()
      s390/topology: move to use bus_get_dev_root()
      s390/smp: move to use bus_get_dev_root()
      cpufreq: amd-pstate: move to use bus_get_dev_root()
      irqchip/mbigen: move to use bus_get_dev_root()
      EDAC/sysfs: move to use bus_get_dev_root()
      ACPI: LPIT: move to use bus_get_dev_root()
      cpuidle: move to use bus_get_dev_root()
      driver core: bus: move dev_root out of struct bus_type
      driver core: bus: mark the struct bus_type for sysfs callbacks as constant
      driver core: bus: constantify bus_register()
      driver core: bus: constify bus_rescan_devices()
      driver core: bus: constify driver_find()
      driver core: bus: constify bus_get()
      driver core: make the bus_type in struct device_driver constant
      crypto: hisilicon/qm - make struct bus_type * const
      drm/i915/huc: use const struct bus_type pointers
      vhost-vdpa: vhost_vdpa_alloc_domain() should be using a const struct bus_type *
      dmaengine: idxd: use const struct bus_type *
      ARM/dma-mapping: const a pointer to bus_type in arm_iommu_create_mapping()
      iommu: make the pointer to struct bus_type constant
      driver core: device.h: make struct bus_type a const *
      USB: mark all struct bus_type as const
      driver core: class: use lock_class_key already present in struct subsys_private
      driver core: class.h: remove extern from function prototypes
      driver core: device.h: remove extern from function prototypes
      driver core: bus.h: remove extern from function prototypes
      driver core: driver.h: remove extern from function prototypes
      driver core: base.h: remove extern from function prototypes
      driver core: physical_location.h remove extern from function prototypes
      kobject.h remove extern from function prototypes
      driver core: bus: move documentation for lock_key to proper location.
      driver core: class: fix documentation for class_create()
      driver core: move sysfs_dev_char_kobj out of class.h
      powerpc/fsl: fix compiler warning in fsl_wakeup_sys_init()
      driver core: bus: constify class_unregister/destroy()
      driver core: class: mark the struct class for sysfs callbacks as constant
      driver core: class: implement class_get/put without the private pointer.
      driver core: class.c: convert to only use class_to_subsys
      mISDN: remove unneeded mISDN_class_release()
      media: pvrusb2: clean up unneeded complexity in pvrusb2 class logic
      driver core: core: move to use class_to_subsys()
      driver core: create class_is_registered()
      driver core: class: remove subsystem private pointer from struct class
      driver core: clean up the logic to determine which /sys/dev/ directory to use
      driver core: class: remove dev_kobj from struct class
      driver core: make sysfs_dev_block_kobj static
      driver core: make sysfs_dev_char_kobj static
      driver core: class: fix slab-use-after-free Read in class_register()
      pktcdvd: simplify the class_pktcdvd logic
      Merge 6.3-rc5 into driver-core-next
      MIPS: vpe-cmp: remove module owner pointer from struct class usage.
      driver core: remove incorrect comment for device_create*
      driver core: class: mark class_release() as taking a const *
      driver core: class: make class_register() take a const *
      driver core: class: mark the struct class in struct class_interface constant
      driver core: class: remove struct class_interface * from callbacks
      tty: make tty_class a static const structure
      zram: fix up permission for the hot_add sysfs file
      Merge tag 'cacheinfo-updates-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into driver-core-next

Guenter Roeck (1):
      device property: make device_property functions take const device *

Harshit Mogalapalli (1):
      tpm: Fix a possible dereference of ERR_PTR in tpm_init()

Heiner Kallweit (2):
      base: soc: populate machine name in soc_device_register if empty
      soc: amlogic: meson-gx-socinfo: use new soc_device_register functionality to populate machine name

Imran Khan (3):
      kernfs: Introduce separate rwsem to protect inode attributes.
      kernfs: Use a per-fs rwsem to protect per-fs list of kernfs_super_info.
      kernfs: change kernfs_rename_lock into a read-write lock.

Phil Auld (1):
      sched/debug: Put sched/domains files under the verbose flag

Pierre Gondois (4):
      cacheinfo: Check sib_leaf in cache_leaves_are_shared()
      cacheinfo: Check cache properties are present in DT
      arch_topology: Remove early cacheinfo error message if -ENOENT
      cacheinfo: Add use_arch[|_cache]_info field/function

Radu Rendec (3):
      cacheinfo: Add arch specific early level initializer
      cacheinfo: Add arm64 early level initializer implementation
      cacheinfo: Allow early level detection when DT/ACPI info is missing/broken

Russell King (1):
      device property: constify fwnode_get_phy_mode() argument

Saravana Kannan (3):
      driver core: Add fw_devlink.sync_state command line param
      driver core: Make state_synced device attribute writeable
      driver core: Add CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT

Stephen Boyd (1):
      driver core: Don't require dynamic_debug for initcall_debug probe timing

Thomas Weißschuh (3):
      kobject: define common logging prefix
      kobject: align stacktrace levels to logging message
      kernel/ksysfs.c: use sysfs_emit for sysfs show handlers

Wedson Almeida Filho (1):
      driver core: update comments in device_rename()

 .../ABI/testing/sysfs-devices-state_synced         |   5 +
 Documentation/admin-guide/kernel-parameters.txt    |  23 +-
 Documentation/driver-api/driver-model/bus.rst      |   4 +-
 Documentation/driver-api/firmware/fw_upload.rst    |   3 +-
 Documentation/filesystems/sysfs.rst                |   4 +-
 .../translations/zh_CN/filesystems/sysfs.txt       |   4 +-
 .../translations/zh_TW/filesystems/sysfs.txt       |   4 +-
 MAINTAINERS                                        |   2 +
 arch/arm/include/asm/dma-iommu.h                   |   2 +-
 arch/arm/mm/dma-mapping.c                          |   2 +-
 arch/arm64/kernel/cacheinfo.c                      |  25 +-
 arch/arm64/kernel/cpufeature.c                     |  10 +-
 arch/mips/kernel/mips-mt.c                         |   2 +-
 arch/mips/kernel/vpe-cmp.c                         |   1 -
 arch/mips/kernel/vpe-mt.c                          |   1 -
 arch/mips/sibyte/common/sb_tbprof.c                |   2 +-
 arch/powerpc/kernel/sysfs.c                        |  14 +-
 arch/powerpc/platforms/book3s/vas-api.c            |   2 +-
 arch/powerpc/platforms/powernv/idle.c              |   9 +-
 arch/powerpc/platforms/powernv/subcore.c           |  10 +-
 arch/powerpc/platforms/pseries/dlpar.c             |   4 +-
 arch/powerpc/platforms/pseries/ibmebus.c           |   4 +-
 arch/powerpc/platforms/pseries/mobility.c          |   4 +-
 arch/powerpc/platforms/pseries/pseries_energy.c    |  28 +-
 arch/powerpc/platforms/pseries/suspend.c           |  10 +-
 arch/powerpc/platforms/pseries/vio.c               |   8 +-
 arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c        |  21 +-
 arch/s390/kernel/smp.c                             |  12 +-
 arch/s390/kernel/topology.c                        |  11 +-
 arch/sh/drivers/dma/dma-sysfs.c                    |   8 +-
 arch/x86/kernel/cpu/microcode/core.c               |  13 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c          |   2 +-
 arch/x86/kernel/cpu/umwait.c                       |   8 +-
 arch/x86/kernel/cpuid.c                            |   2 +-
 arch/x86/kernel/msr.c                              |   2 +-
 block/bsg.c                                        |   2 +-
 block/genhd.c                                      |  20 +-
 drivers/accel/drm_accel.c                          |   2 +-
 drivers/accel/habanalabs/common/habanalabs_drv.c   |   2 +-
 drivers/acpi/acpi_lpit.c                           |  16 +-
 drivers/ata/pata_parport/pata_parport.c            |   6 +-
 drivers/base/Kconfig                               |  12 +
 drivers/base/arch_topology.c                       |  11 +-
 drivers/base/base.h                                | 114 ++++----
 drivers/base/bus.c                                 |  48 ++--
 drivers/base/cacheinfo.c                           | 124 ++++++--
 drivers/base/class.c                               | 247 ++++++++++------
 drivers/base/core.c                                | 313 ++++++++++++---------
 drivers/base/dd.c                                  |  36 ++-
 drivers/base/devcoredump.c                         |   5 +-
 drivers/base/devres.c                              |  11 +-
 drivers/base/devtmpfs.c                            |   9 -
 drivers/base/firmware_loader/Kconfig               |  13 +
 drivers/base/firmware_loader/main.c                |  65 ++++-
 drivers/base/firmware_loader/sysfs.c               |   4 +-
 drivers/base/physical_location.h                   |   2 +-
 drivers/base/power/wakeup_stats.c                  |   2 +-
 drivers/base/property.c                            | 148 +++++++---
 drivers/base/soc.c                                 |  15 +
 drivers/block/aoe/aoechr.c                         |   2 +-
 drivers/block/pktcdvd.c                            |  47 +---
 drivers/block/rbd.c                                |  34 +--
 drivers/block/rnbd/rnbd-clt-sysfs.c                |   2 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c                |   2 +-
 drivers/block/ublk_drv.c                           |   2 +-
 drivers/block/zram/zram_drv.c                      |  10 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |   6 +-
 drivers/char/bsr.c                                 |   2 +-
 drivers/char/dsp56k.c                              |   2 +-
 drivers/char/ipmi/ipmi_devintf.c                   |   2 +-
 drivers/char/lp.c                                  |   2 +-
 drivers/char/mem.c                                 |   2 +-
 drivers/char/misc.c                                |   2 +-
 drivers/char/pcmcia/cm4000_cs.c                    |   2 +-
 drivers/char/pcmcia/cm4040_cs.c                    |   2 +-
 drivers/char/pcmcia/scr24x_cs.c                    |   2 +-
 drivers/char/ppdev.c                               |   2 +-
 drivers/char/tpm/tpm-chip.c                        |   3 +-
 drivers/char/tpm/tpm-interface.c                   |   6 +-
 drivers/char/tpm/tpm.h                             |   1 +
 drivers/char/virtio_console.c                      |   2 +-
 drivers/char/xilinx_hwicap/xilinx_hwicap.c         |   2 +-
 drivers/char/xillybus/xillybus_class.c             |   2 +-
 drivers/comedi/comedi_fops.c                       |   2 +-
 drivers/comedi/drivers/comedi_test.c               |   2 +-
 drivers/cpufreq/amd-pstate.c                       |  24 +-
 drivers/cpufreq/cpufreq.c                          |   7 +-
 drivers/cpufreq/intel_pstate.c                     |   7 +-
 drivers/cpuidle/cpuidle.c                          |   2 +-
 drivers/cpuidle/cpuidle.h                          |   2 +-
 drivers/cpuidle/sysfs.c                            |  13 +-
 drivers/crypto/hisilicon/qm.c                      |   2 +-
 drivers/crypto/qat/qat_common/adf_ctl_drv.c        |   2 +-
 drivers/cxl/core/port.c                            |   2 +-
 drivers/dca/dca-sysfs.c                            |   2 +-
 drivers/devfreq/devfreq-event.c                    |   2 +-
 drivers/devfreq/devfreq.c                          |   2 +-
 drivers/dma-buf/dma-heap.c                         |   2 +-
 drivers/dma/idxd/compat.c                          |   4 +-
 drivers/edac/edac_device_sysfs.c                   |  16 +-
 drivers/edac/edac_pci_sysfs.c                      |  14 +-
 drivers/extcon/extcon.c                            |   2 +-
 drivers/fpga/fpga-bridge.c                         |   2 +-
 drivers/fpga/fpga-mgr.c                            |   2 +-
 drivers/fpga/fpga-region.c                         |   2 +-
 drivers/gnss/core.c                                |   2 +-
 drivers/gpio/gpiolib-sysfs.c                       |  14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   2 +-
 drivers/gpu/drm/display/drm_dp_aux_dev.c           |   2 +-
 drivers/gpu/drm/drm_sysfs.c                        |   2 +-
 drivers/gpu/drm/i915/gt/uc/intel_huc.c             |   4 +-
 drivers/gpu/drm/i915/gt/uc/intel_huc.h             |   4 +-
 drivers/hid/hid-roccat-arvo.c                      |   2 +-
 drivers/hid/hid-roccat-isku.c                      |   2 +-
 drivers/hid/hid-roccat-kone.c                      |   2 +-
 drivers/hid/hid-roccat-koneplus.c                  |   2 +-
 drivers/hid/hid-roccat-konepure.c                  |   2 +-
 drivers/hid/hid-roccat-kovaplus.c                  |   2 +-
 drivers/hid/hid-roccat-pyra.c                      |   2 +-
 drivers/hid/hid-roccat-ryos.c                      |   2 +-
 drivers/hid/hid-roccat-savu.c                      |   2 +-
 drivers/hid/hidraw.c                               |   2 +-
 drivers/hv/vmbus_drv.c                             |   2 +-
 drivers/hwmon/drivetemp.c                          |   4 +-
 drivers/hwmon/hwmon.c                              |   1 -
 drivers/i2c/i2c-dev.c                              |   2 +-
 drivers/infiniband/core/user_mad.c                 |   4 +-
 drivers/infiniband/core/uverbs_main.c              |   2 +-
 drivers/infiniband/hw/hfi1/device.c                |   4 +-
 drivers/infiniband/hw/qib/qib_file_ops.c           |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |   2 +-
 drivers/iommu/iommu.c                              |  14 +-
 drivers/irqchip/irq-mbigen.c                       |  13 +-
 drivers/isdn/capi/capi.c                           |   2 +-
 drivers/isdn/mISDN/core.c                          |   7 -
 drivers/isdn/mISDN/dsp_pipeline.c                  |   2 +-
 drivers/leds/led-class.c                           |   2 +-
 drivers/macintosh/adb.c                            |   2 +-
 drivers/media/dvb-core/dvbdev.c                    |   2 +-
 drivers/media/pci/ddbridge/ddbridge-core.c         |   1 -
 drivers/media/rc/lirc_dev.c                        |   2 +-
 drivers/media/usb/pvrusb2/pvrusb2-main.c           |  18 +-
 drivers/media/usb/pvrusb2/pvrusb2-sysfs.c          |  59 ++--
 drivers/media/usb/pvrusb2/pvrusb2-sysfs.h          |  16 +-
 drivers/mfd/cros_ec_dev.c                          |   1 -
 drivers/misc/c2port/core.c                         |   2 +-
 drivers/misc/cxl/file.c                            |   2 +-
 drivers/misc/enclosure.c                           |   1 -
 drivers/misc/genwqe/card_base.c                    |   2 +-
 drivers/misc/hpilo.c                               |   2 +-
 drivers/misc/mei/main.c                            |   2 +-
 drivers/misc/ocxl/file.c                           |   2 +-
 drivers/misc/phantom.c                             |   2 +-
 drivers/misc/uacce/uacce.c                         |   2 +-
 drivers/most/most_cdev.c                           |   2 +-
 drivers/mtd/mtdcore.c                              |   1 -
 drivers/mtd/ubi/build.c                            |   3 +-
 drivers/mux/core.c                                 |   1 -
 drivers/net/bonding/bond_sysfs.c                   |  18 +-
 drivers/net/ethernet/hisilicon/hns/hnae.c          |   2 +-
 drivers/net/ipvlan/ipvtap.c                        |   1 -
 drivers/net/macvtap.c                              |   1 -
 drivers/net/netdevsim/bus.c                        |   4 +-
 drivers/net/ppp/ppp_generic.c                      |   2 +-
 drivers/net/rionet.c                               |   3 +-
 drivers/net/wireless/mac80211_hwsim.c              |   2 +-
 drivers/net/wwan/wwan_core.c                       |   2 +-
 drivers/net/wwan/wwan_hwsim.c                      |   2 +-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c             |   6 +-
 drivers/nvdimm/bus.c                               |   2 +-
 drivers/nvme/host/core.c                           |   6 +-
 drivers/nvme/host/fabrics.c                        |   2 +-
 drivers/nvme/host/fc.c                             |   1 -
 drivers/nvme/target/fcloop.c                       |   2 +-
 drivers/pci/endpoint/pci-epc-core.c                |   2 +-
 drivers/pci/pci-sysfs.c                            |   2 +-
 drivers/pci/pci.c                                  |   4 +-
 drivers/pci/switch/switchtec.c                     |   2 +-
 drivers/pcmcia/cs.c                                |   2 +-
 drivers/pcmcia/ds.c                                |   6 +-
 drivers/pcmcia/rsrc_nonstatic.c                    |   6 +-
 drivers/peci/sysfs.c                               |   2 +-
 drivers/phy/phy-core.c                             |   2 +-
 drivers/platform/chrome/wilco_ec/event.c           |   1 -
 drivers/platform/chrome/wilco_ec/telemetry.c       |   1 -
 drivers/platform/x86/ibm_rtl.c                     |  18 +-
 drivers/platform/x86/intel/pmt/class.c             |   1 -
 .../uncore-frequency/uncore-frequency-common.c     |  12 +-
 drivers/platform/x86/intel_scu_ipc.c               |   1 -
 drivers/power/supply/power_supply_core.c           |   2 +-
 drivers/pps/pps.c                                  |   2 +-
 drivers/ptp/ptp_clock.c                            |   2 +-
 drivers/ptp/ptp_ocp.c                              |   1 -
 drivers/pwm/sysfs.c                                |   1 -
 drivers/rapidio/devices/rio_mport_cdev.c           |   9 +-
 drivers/rapidio/rio-driver.c                       |   1 -
 drivers/rapidio/rio-sysfs.c                        |   2 +-
 drivers/rapidio/rio_cm.c                           |  10 +-
 drivers/rpmsg/rpmsg_core.c                         |   2 +-
 drivers/rtc/class.c                                |   2 +-
 drivers/s390/char/hmcdrv_dev.c                     |   2 +-
 drivers/s390/char/raw3270.c                        |   2 +-
 drivers/s390/char/tape_class.c                     |   2 +-
 drivers/s390/char/vmlogrdr.c                       |   2 +-
 drivers/s390/char/vmur.c                           |   2 +-
 drivers/s390/crypto/ap_bus.c                       |  42 +--
 drivers/s390/crypto/zcrypt_api.c                   |  10 +-
 drivers/sbus/char/oradax.c                         |   2 +-
 drivers/scsi/ch.c                                  |   2 +-
 drivers/scsi/cxlflash/main.c                       |   2 +-
 drivers/scsi/fcoe/fcoe_sysfs.c                     |   8 +-
 drivers/scsi/fcoe/fcoe_transport.c                 |   6 +-
 drivers/scsi/pmcraid.c                             |   2 +-
 drivers/scsi/sd.c                                  |   1 -
 drivers/scsi/ses.c                                 |   6 +-
 drivers/scsi/sg.c                                  |  10 +-
 drivers/sh/intc/userimask.c                        |  10 +-
 drivers/soc/amlogic/meson-gx-socinfo.c             |   5 -
 drivers/soc/qcom/rmtfs_mem.c                       |   1 -
 drivers/spi/spi.c                                  |   2 -
 drivers/spi/spidev.c                               |   2 +-
 drivers/staging/fieldbus/anybuss/arcx-anybus.c     |   2 +-
 drivers/staging/fieldbus/dev_core.c                |   1 -
 drivers/staging/greybus/authentication.c           |   2 +-
 drivers/staging/greybus/fw-management.c            |   2 +-
 drivers/staging/greybus/loopback.c                 |   1 -
 drivers/staging/greybus/raw.c                      |   2 +-
 drivers/staging/greybus/vibrator.c                 |   1 -
 drivers/staging/pi433/pi433_if.c                   |   2 +-
 drivers/staging/vme_user/vme_user.c                |   2 +-
 drivers/tee/tee_core.c                             |   2 +-
 drivers/tty/pty.c                                  |   2 +-
 drivers/tty/tty_io.c                               |  24 +-
 drivers/tty/vt/vc_screen.c                         |   2 +-
 drivers/tty/vt/vt.c                                |   4 +-
 drivers/usb/common/ulpi.c                          |   2 +-
 drivers/usb/core/driver.c                          |   2 +-
 drivers/usb/core/file.c                            |   2 +-
 drivers/usb/core/usb.h                             |   2 +-
 drivers/usb/gadget/function/f_hid.c                |   2 +-
 drivers/usb/gadget/function/f_printer.c            |   2 +-
 drivers/usb/gadget/udc/core.c                      |   6 +-
 drivers/usb/mon/mon_bin.c                          |   2 +-
 drivers/usb/roles/class.c                          |   2 +-
 drivers/usb/serial/bus.c                           |   2 +-
 drivers/usb/typec/bus.c                            |   2 +-
 drivers/usb/typec/bus.h                            |   2 +-
 drivers/usb/typec/class.c                          |   1 -
 drivers/usb/typec/mux.c                            |   1 -
 drivers/usb/typec/pd.c                             |   1 -
 drivers/usb/typec/retimer.c                        |   1 -
 drivers/vdpa/vdpa_user/vduse_dev.c                 |   2 +-
 drivers/vfio/group.c                               |   2 +-
 drivers/vfio/vfio_main.c                           |   2 +-
 drivers/vhost/vdpa.c                               |   2 +-
 drivers/video/backlight/backlight.c                |   2 +-
 drivers/video/backlight/lcd.c                      |   2 +-
 drivers/video/fbdev/core/fbmem.c                   |   2 +-
 drivers/watchdog/watchdog_dev.c                    |   1 -
 fs/coda/psdev.c                                    |   2 +-
 fs/fuse/cuse.c                                     |   2 +-
 fs/kernfs/dir.c                                    |  26 +-
 fs/kernfs/file.c                                   |   4 +-
 fs/kernfs/inode.c                                  |  16 +-
 fs/kernfs/kernfs-internal.h                        |   2 +
 fs/kernfs/mount.c                                  |   8 +-
 fs/ksmbd/server.c                                  |  11 +-
 fs/pstore/pmsg.c                                   |   2 +-
 include/linux/cacheinfo.h                          |   8 +
 include/linux/device.h                             |  32 +--
 include/linux/device/bus.h                         |  21 +-
 include/linux/device/class.h                       | 130 +++------
 include/linux/device/driver.h                      |  28 +-
 include/linux/iommu.h                              |  10 +-
 include/linux/kobject.h                            |  59 ++--
 include/linux/property.h                           |  45 ++-
 include/linux/tty.h                                |   2 +-
 include/linux/usb/serial.h                         |   2 +-
 include/scsi/libfcoe.h                             |   6 +-
 init/Kconfig                                       |  38 ---
 kernel/cpu.c                                       |  23 +-
 kernel/ksysfs.c                                    |  22 +-
 kernel/sched/debug.c                               |  52 +++-
 kernel/time/alarmtimer.c                           |   3 +-
 kernel/workqueue.c                                 |   8 +-
 lib/kobject.c                                      |  34 +--
 mm/backing-dev.c                                   |   2 +-
 net/bluetooth/hci_sysfs.c                          |   2 +-
 net/netfilter/xt_IDLETIMER.c                       |   2 +-
 net/wireless/sysfs.c                               |   1 -
 samples/vfio-mdev/mbochs.c                         |   2 +-
 samples/vfio-mdev/mdpy.c                           |   2 +-
 samples/vfio-mdev/mtty.c                           |   2 +-
 sound/sound_core.c                                 |   2 +-
 tools/testing/nvdimm/test/ndtest.c                 |   2 +-
 tools/testing/nvdimm/test/nfit.c                   |   2 +-
 297 files changed, 1684 insertions(+), 1289 deletions(-)
