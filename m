Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854036A1C73
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjBXMwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjBXMwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:52:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C5B686A2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:52:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40F67B81B2C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB4DC433D2;
        Fri, 24 Feb 2023 12:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677243130;
        bh=8LlodR7ZO/ZzUF7krerukAVV/jEo1WyhWBygJgVh7es=;
        h=Date:From:To:Cc:Subject:From;
        b=pXme//nzvDNYQS/0ORjlCMBonJny9a8WirEWTqgT8ll62l37COD6n2C6063wPoMI9
         MHo3x8ZWb2CvVcUN24r6abQx2kMyyMfxh74E/Enazz+p0Tm8FFDYCd2PVkn2t/FNaz
         BY7wCzOgXEU+K6Rjl4hmDs6Tsn6iiXY01+5tXPVc=
Date:   Fri, 24 Feb 2023 13:52:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core updates for 6.3-rc1
Message-ID: <Y/iy9+Kn0SgzngDC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.3-rc1

for you to fetch changes up to 88cd618dcc7b63baa1478730b02eaba3e3148467:

  debugfs: drop inline constant formatting for ERR_PTR(-ERROR) (2023-02-20 14:14:56 +0100)

----------------------------------------------------------------
Driver core changes for 6.3-rc1

Here is the large set of driver core changes for 6.3-rc1.

There's a lot of changes this development cycle, most of the work falls
into two different categories:
  - fw_devlink fixes and updates.  This has gone through numerous review
    cycles and lots of review and testing by lots of different devices.
    Hopefully all should be good now, and Saravana will be keeping a
    watch for any potential regression on odd embedded systems.
  - driver core changes to work to make struct bus_type able to be moved
    into read-only memory (i.e. const)  The recent work with Rust has
    pointed out a number of areas in the driver core where we are
    passing around and working with structures that really do not have
    to be dynamic at all, and they should be able to be read-only making
    things safer overall.  This is the contuation of that work (started
    last release with kobject changes) in moving struct bus_type to be
    constant.  We didn't quite make it for this release, but the
    remaining patches will be finished up for the release after this
    one, but the groundwork has been laid for this effort.

Other than that we have in here:
  - debugfs memory leak fixes in some subsystems
  - error path cleanups and fixes for some never-able-to-be-hit
    codepaths.
  - cacheinfo rework and fixes
  - Other tiny fixes, full details are in the shortlog

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (6):
      media: ipu3-cio2: Don't dereference fwnode handle
      media: ipu3-cio2: Convert to use software_node_register_node_group()
      software node: Switch property entry test to a new API
      software node: Remove unused APIs
      device property: Make fwnode_graph_for_each_endpoint() consistent
      container_of: Update header inclusions

Bagas Sanjaya (1):
      debugfs: drop inline constant formatting for ERR_PTR(-ERROR)

Christophe JAILLET (1):
      test_firmware: Use kstrtobool() instead of strtobool()

Gavin Shan (1):
      drivers/base/memory: Fix comments for phys_index_show()

Greg Kroah-Hartman (66):
      driver core: make bus_get_device_klist() static
      driver core: remove subsys_find_device_by_id()
      driver core: make subsys_dev_iter_init() static
      driver core: make subsys_dev_iter_next() static
      driver core: make subsys_dev_iter_exit() static
      driver core: move struct subsys_dev_iter to a local file
      driver core: change to_subsys_private() to use container_of_const()
      driver core: bus.h: document bus notifiers better
      driver core: bus: move bus notifier logic into bus.c
      Merge tag 'archtopo-cacheinfo-updates-6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into driver-core-next
      Merge 6.2-rc5 into driver-core-next
      of: device: make of_device_uevent_modalias() take a const device *
      i3c: move dev_to_i3cdev() to use container_of_const()
      platform/surface: aggregator: move to_ssam_device() to use container_of_const()
      firewire: move fw_device() and fw_unit() to use container_of_const()
      driver core: make struct device_type.uevent() take a const *
      driver core: make struct device_type.devnode() take a const *
      driver core: device_get_devnode() should take a const *
      vio: move to_vio_dev() to use container_of_const()
      platform/x86: wmi: move dev_to_wblock() and dev_to_wdev to use container_of_const()
      drivers: hv: move device_to_hv_device to use container_of_const()
      virtio: move dev_to_virtio() to use container_of_const()
      drm/mipi-dsi: move to_mipi_dsi_device() to use container_of_const()
      mcb: move to_mcb_device() to use container_of_const()
      xen/xenbus: move to_xenbus_device() to use container_of_const()
      driver core: make struct bus_type.uevent() take a const *
      kobject: kset_uevent_ops: make uevent() callback take a const *
      driver core: soc: remove layering violation for the soc_bus
      maple: remove unneeded maple_bus_uevent() callback.
      driver core: platform: removed unneeded variable from __platform_driver_probe()
      driver core: platform: simplify __platform_driver_probe()
      driver core: bus: move lock_class_key into dynamic structure
      drivers: base: component: fix memory leak with using debugfs_lookup()
      drivers: base: dd: fix memory leak with using debugfs_lookup()
      kernel/time/test_udelay.c: fix memory leak with using debugfs_lookup()
      kernel/power/energy_model.c: fix memory leak with using debugfs_lookup()
      kernel/fail_function: fix memory leak with using debugfs_lookup()
      driver core: add local subsys_get and subsys_put functions
      driver core: bus: implement bus_get/put() without the private pointer
      driver core: bus: constantify the bus_find_* functions
      driver core: bus: convert bus_create/remove_file to be constant
      driver core: bus: sysfs function cleanups
      driver core: bus: bus_add/probe/remove_device() cleanups
      driver core: bus: bus_register/unregister() cleanups
      driver core: bus: subsys_interface_register/unregister() cleanups
      driver core: bus: bus_get_kset() cleanup
      driver core: bus: bus_register/unregister_notifier() cleanups
      driver core: bus: bus_add/remove_driver() cleanups
      driver core: bus: bus iterator cleanups
      driver core: bus: clean up bus_sort_breadthfirst()
      driver core: move driver_find() to bus.c
      driver core: bus: clean up driver_find()
      driver core: create bus_is_registered()
      driver core: remove private pointer from struct bus_type
      driver core: bus: constify bus_register/unregister_notifier()
      driver core: bus: constify bus_get_kset()
      driver core: bus: constify some internal functions
      driver core: bus: constify bus_unregister()
      driver core: bus: add bus_get_dev_root() function
      driver core: bus: update my copyright notice
      driver core: cpu: don't hand-override the uevent bus_type callback.
      Revert "devtmpfs: remove return value of devtmpfs_delete_node()"
      Revert "devtmpfs: add debug info to handle()"
      Revert "driver core: add error handling for devtmpfs_create_node()"
      driver core: class: move EXPORT_SYMBOL_GPL() lines to the correct place
      dma-mapping: no need to pass a bus_type into get_arch_dma_ops()

Hanjun Guo (1):
      driver core: location: Free struct acpi_pld_info *pld before return false

Javier Martinez Canillas (1):
      driver core: Make driver_deferred_probe_timeout a static variable

Longlong Xia (4):
      devtmpfs: convert to pr_fmt
      driver core: add error handling for devtmpfs_create_node()
      devtmpfs: add debug info to handle()
      devtmpfs: remove return value of devtmpfs_delete_node()

Luis Chamberlain (1):
      docs: embargoed-hardware-issues: add embargoed HW contact for Samsung

Pierre Gondois (9):
      cacheinfo: Use RISC-V's init_cache_level() as generic OF implementation
      cacheinfo: Return error code in init_of_cache_level()
      cacheinfo: Check 'cache-unified' property to count cache leaves
      ACPI: PPTT: Remove acpi_find_cache_levels()
      ACPI: PPTT: Update acpi_find_last_cache_level() to acpi_get_cache_info()
      arch_topology: Build cacheinfo from primary CPU
      cacheinfo: Initialize variables in fetch_cache_info()
      cacheinfo: Make default acpi_get_cache_info() return an error
      cacheinfo: Remove unused check in init_cache_level()

Qi Zheng (2):
      debugfs: update comment of debugfs_rename()
      OPP: fix error checking in opp_migrate_dentry()

Rafael J. Wysocki (1):
      driver core: class: Clear private pointer on registration failures

Randy Dunlap (2):
      test_firmware: use kernel-doc struct notation
      i3c: fix device.h kernel-doc warnings

Saravana Kannan (12):
      driver core: fw_devlink: Don't purge child fwnode's consumer links
      driver core: fw_devlink: Improve check for fwnode with no device/driver
      soc: renesas: Move away from using OF_POPULATED for fw_devlink
      gpiolib: Clear the gpio_device's fwnode initialized flag before adding
      driver core: fw_devlink: Add DL_FLAG_CYCLE support to device links
      driver core: fw_devlink: Allow marking a fwnode link as being part of a cycle
      driver core: fw_devlink: Consolidate device link flag computation
      driver core: fw_devlink: Make cycle detection more robust
      of: property: Simplify of_link_to_phandle()
      irqchip/irq-imx-gpcv2: Mark fwnode device as not initialized
      firmware: arm_scmi: Set fwnode for the scmi_device
      mtd: mtdpart: Don't create platform device that'll never probe

Soha Jin (1):
      platform: remove useless if-branch in __platform_get_irq_byname()

Stephen Rothwell (1):
      driver core: fixup for "driver core: make struct bus_type.uevent() take a const *"

Thomas Weißschuh (5):
      kernels/ksysfs.c: export kernel address bits
      const_structs.checkpatch.pl: add kobj_type
      kobject: make dynamic_kobj_ktype and kset_ktype const
      driver core: make kobj_type structures constant
      samples/kobject: make kobj_type structure constant

Umang Jain (1):
      platform: Document platform_add_devices() return value

Uwe Kleine-König (3):
      platform: Provide a remove callback that returns no value
      staging: greybus: codecs: Drop empty platform remove function
      serial: arc_uart: Drop empty platform remove function

Wang Hai (1):
      kobject: Fix slab-out-of-bounds in fill_kobj_path()

Yang Yingliang (3):
      driver core: fix potential null-ptr-deref in device_add()
      drivers: base: transport_class: fix possible memory leak
      drivers: base: transport_class: fix resource leak when transport_add_device() fails

Yong-Xuan Wang (1):
      cacheinfo: Fix shared_cpu_map to handle shared caches at different levels

Zhen Lei (1):
      kernfs: remove an unused if statement in kernfs_path_from_node_locked()

Zhengchao Shao (1):
      driver core: fix resource leak in device_add()

 .../ABI/testing/sysfs-kernel-address_bits          |  10 +
 .../process/embargoed-hardware-issues.rst          |   1 +
 arch/alpha/include/asm/dma-mapping.h               |   2 +-
 arch/arm64/kernel/cacheinfo.c                      |  14 +-
 arch/ia64/include/asm/dma-mapping.h                |   2 +-
 arch/mips/include/asm/dma-mapping.h                |   2 +-
 arch/mips/sgi-ip22/ip22-gio.c                      |   4 +-
 arch/parisc/include/asm/dma-mapping.h              |   2 +-
 arch/parisc/kernel/drivers.c                       |   4 +-
 arch/powerpc/include/asm/ps3.h                     |   2 +-
 arch/powerpc/include/asm/vio.h                     |   5 +-
 arch/powerpc/platforms/ps3/system-bus.c            |   2 +-
 arch/powerpc/platforms/pseries/ibmebus.c           |   7 +-
 arch/powerpc/platforms/pseries/vio.c               |   4 +-
 arch/riscv/kernel/cacheinfo.c                      |  42 --
 arch/sparc/include/asm/dma-mapping.h               |   2 +-
 arch/sparc/include/asm/vio.h                       |   5 +-
 arch/sparc/kernel/vio.c                            |   2 +-
 arch/x86/include/asm/dma-mapping.h                 |   2 +-
 block/genhd.c                                      |   2 +-
 block/partitions/core.c                            |   4 +-
 drivers/acpi/bus.c                                 |   2 +-
 drivers/acpi/device_sysfs.c                        |   8 +-
 drivers/acpi/internal.h                            |   2 +-
 drivers/acpi/pptt.c                                |  93 ++--
 drivers/amba/bus.c                                 |   4 +-
 drivers/base/arch_topology.c                       |  12 +-
 drivers/base/auxiliary.c                           |   2 +-
 drivers/base/base.h                                |  21 +-
 drivers/base/bus.c                                 | 575 ++++++++++++++-------
 drivers/base/cacheinfo.c                           | 161 +++++-
 drivers/base/class.c                               |  34 +-
 drivers/base/component.c                           |   2 +-
 drivers/base/core.c                                | 489 ++++++++++++------
 drivers/base/cpu.c                                 |  40 +-
 drivers/base/dd.c                                  |  36 +-
 drivers/base/devtmpfs.c                            |  16 +-
 drivers/base/driver.c                              |  29 +-
 drivers/base/memory.c                              |   9 +-
 drivers/base/physical_location.c                   |   5 +-
 drivers/base/platform.c                            |  48 +-
 drivers/base/soc.c                                 |   4 +-
 drivers/base/swnode.c                              |  63 +--
 drivers/base/test/property-entry-test.c            |  30 +-
 drivers/base/transport_class.c                     |  17 +-
 drivers/bcma/main.c                                |   6 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |   4 +-
 drivers/bus/mhi/ep/main.c                          |   4 +-
 drivers/bus/mhi/host/init.c                        |   4 +-
 drivers/bus/mips_cdmm.c                            |   4 +-
 drivers/bus/sunxi-rsb.c                            |   7 +-
 drivers/cxl/core/memdev.c                          |   4 +-
 drivers/cxl/core/port.c                            |   8 +-
 drivers/cxl/cxl.h                                  |   4 +-
 drivers/cxl/cxlmem.h                               |   2 +-
 drivers/dax/bus.c                                  |   2 +-
 drivers/eisa/eisa-bus.c                            |   4 +-
 drivers/firewire/core-device.c                     |   8 +-
 drivers/firmware/arm_ffa/bus.c                     |   4 +-
 drivers/firmware/arm_scmi/bus.c                    |   3 +-
 drivers/fpga/dfl.c                                 |   4 +-
 drivers/fsi/fsi-core.c                             |   6 +-
 drivers/gpio/gpiolib.c                             |   7 +
 drivers/gpu/drm/display/drm_dp_aux_bus.c           |   7 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |   4 +-
 drivers/gpu/host1x/bus.c                           |   2 +-
 drivers/greybus/core.c                             |  14 +-
 drivers/hid/hid-core.c                             |   4 +-
 drivers/hid/intel-ish-hid/ishtp/bus.c              |   2 +-
 drivers/hsi/hsi_core.c                             |   2 +-
 drivers/hv/vmbus_drv.c                             |   4 +-
 drivers/hwtracing/intel_th/core.c                  |   6 +-
 drivers/hwtracing/intel_th/intel_th.h              |   4 +-
 drivers/i2c/i2c-core-base.c                        |   4 +-
 drivers/i3c/device.c                               |  14 +-
 drivers/i3c/master.c                               |   4 +-
 drivers/input/input.c                              |  16 +-
 drivers/input/serio/serio.c                        |   4 +-
 drivers/ipack/ipack.c                              |   4 +-
 drivers/irqchip/irq-imx-gpcv2.c                    |   1 +
 drivers/macintosh/macio_asic.c                     |   7 +-
 drivers/mcb/mcb-core.c                             |   4 +-
 drivers/media/pci/intel/ipu3/cio2-bridge.c         |  27 +-
 drivers/media/pci/intel/ipu3/cio2-bridge.h         |   5 +-
 drivers/media/rc/rc-main.c                         |   2 +-
 drivers/memstick/core/memstick.c                   |   6 +-
 drivers/misc/mei/bus.c                             |   4 +-
 drivers/misc/tifm_core.c                           |   4 +-
 drivers/mmc/core/bus.c                             |   4 +-
 drivers/mmc/core/sdio_bus.c                        |   4 +-
 drivers/mtd/mtdpart.c                              |  10 +
 drivers/net/phy/mdio_bus.c                         |   2 +-
 drivers/net/xen-netback/xenbus.c                   |   2 +-
 drivers/nvdimm/bus.c                               |   4 +-
 drivers/nvdimm/dax_devs.c                          |   2 +-
 drivers/nvdimm/dimm_devs.c                         |   2 +-
 drivers/nvdimm/nd-core.h                           |  10 +-
 drivers/nvdimm/nd.h                                |   4 +-
 drivers/nvdimm/region_devs.c                       |   4 +-
 drivers/of/device.c                                |   4 +-
 drivers/of/property.c                              |  84 +--
 drivers/opp/debugfs.c                              |   2 +-
 drivers/pci/pci-driver.c                           |   4 +-
 drivers/pcmcia/ds.c                                |   4 +-
 drivers/platform/surface/aggregator/bus.c          |   4 +-
 drivers/platform/x86/wmi.c                         |  15 +-
 drivers/rapidio/rio-driver.c                       |   4 +-
 drivers/rpmsg/rpmsg_core.c                         |   4 +-
 drivers/s390/cio/css.c                             |   4 +-
 drivers/s390/cio/device.c                          |   8 +-
 drivers/s390/cio/scm.c                             |   2 +-
 drivers/s390/crypto/ap_bus.c                       |   4 +-
 drivers/scsi/scsi_sysfs.c                          |   4 +-
 drivers/sh/maple/maple.c                           |   7 -
 drivers/slimbus/core.c                             |   4 +-
 drivers/soc/imx/gpcv2.c                            |   2 +-
 drivers/soc/qcom/apr.c                             |   4 +-
 drivers/soc/renesas/rcar-sysc.c                    |   2 +-
 drivers/soundwire/bus_type.c                       |   4 +-
 drivers/spi/spi.c                                  |   2 +-
 drivers/spmi/spmi.c                                |   2 +-
 drivers/ssb/main.c                                 |   4 +-
 drivers/staging/greybus/audio_codec.c              |   6 -
 drivers/staging/greybus/gbphy.c                    |  14 +-
 drivers/tee/tee_core.c                             |   2 +-
 drivers/thunderbolt/switch.c                       |   4 +-
 drivers/thunderbolt/tb.h                           |   2 +-
 drivers/thunderbolt/xdomain.c                      |   6 +-
 drivers/tty/serdev/core.c                          |   2 +-
 drivers/tty/serial/arc_uart.c                      |   7 -
 drivers/usb/common/ulpi.c                          |   4 +-
 drivers/usb/core/driver.c                          |   6 +-
 drivers/usb/core/message.c                         |   8 +-
 drivers/usb/core/usb.c                             |   8 +-
 drivers/usb/phy/phy.c                              |   6 +-
 drivers/usb/roles/class.c                          |   3 +-
 drivers/usb/typec/bus.c                            |   4 +-
 drivers/usb/typec/class.c                          |   2 +-
 drivers/virtio/virtio.c                            |   4 +-
 drivers/w1/w1.c                                    |  10 +-
 drivers/xen/pvcalls-back.c                         |   2 +-
 drivers/xen/xenbus/xenbus_probe_backend.c          |   8 +-
 drivers/xen/xenbus/xenbus_probe_frontend.c         |   4 +-
 drivers/zorro/zorro-driver.c                       |   4 +-
 fs/debugfs/inode.c                                 |   4 +-
 fs/dlm/lockspace.c                                 |   4 +-
 fs/gfs2/sys.c                                      |   6 +-
 fs/kernfs/dir.c                                    |   3 -
 include/asm-generic/dma-mapping.h                  |   2 +-
 include/drm/drm_mipi_dsi.h                         |   5 +-
 include/linux/acpi.h                               |   4 +-
 include/linux/cacheinfo.h                          |  13 +-
 include/linux/container_of.h                       |   2 +-
 include/linux/device.h                             |   7 +-
 include/linux/device/bus.h                         |  97 ++--
 include/linux/device/driver.h                      |   1 -
 include/linux/dma-map-ops.h                        |   2 +-
 include/linux/firewire.h                           |  15 +-
 include/linux/fwnode.h                             |  12 +-
 include/linux/hyperv.h                             |   5 +-
 include/linux/i3c/device.h                         |  22 +-
 include/linux/kobject.h                            |   2 +-
 include/linux/mcb.h                                |   5 +-
 include/linux/of_device.h                          |   4 +-
 include/linux/platform_device.h                    |  11 +
 include/linux/property.h                           |   9 +-
 include/linux/soundwire/sdw_type.h                 |   2 +-
 include/linux/spi/spi.h                            |   2 +-
 include/linux/ssb/ssb.h                            |   2 +-
 include/linux/surface_aggregator/device.h          |   5 +-
 include/linux/transport_class.h                    |   8 +-
 include/linux/virtio.h                             |   5 +-
 include/sound/hdaudio.h                            |   2 +-
 include/xen/xenbus.h                               |   7 +-
 kernel/fail_function.c                             |   5 +-
 kernel/ksysfs.c                                    |   9 +
 kernel/power/energy_model.c                        |   5 +-
 kernel/time/test_udelay.c                          |   2 +-
 lib/kobject.c                                      |  16 +-
 lib/test_firmware.c                                |   5 +-
 samples/kobject/kset-example.c                     |   2 +-
 scripts/const_structs.checkpatch                   |   1 +
 sound/aoa/soundbus/core.c                          |   6 +-
 sound/hda/hda_bus_type.c                           |   2 +-
 sound/hda/hdac_device.c                            |   2 +-
 185 files changed, 1535 insertions(+), 1192 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-address_bits
