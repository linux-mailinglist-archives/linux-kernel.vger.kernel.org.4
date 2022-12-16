Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE30364E86A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 10:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLPJCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 04:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLPJCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 04:02:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201C51EACE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 01:02:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0E42B81D38
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 09:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399F5C433D2;
        Fri, 16 Dec 2022 09:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671181346;
        bh=Eg71rZefC9jYkuI9CaOy5RR0663HTaMCY7HTzOJprmA=;
        h=Date:From:To:Cc:Subject:From;
        b=nM4QHC39NBefp/Mz+Bdm1HRLHrpeTybuhBMhT4ABkE/HADX6C7B5BcO0PSJ+0WzEH
         QOHjBUlUK/ppu6wKrzp+NlUBmpQs0UPmkoiiziDq7oPNypa9+IGU5ZB26/Eaei7xTd
         Xh9mbONUYZtMiIv3m52UAS94dOqeTfSEV9g1lhzU=
Date:   Fri, 16 Dec 2022 10:02:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 6.2-rc1
Message-ID: <Y5w0IMxCYe2wyD1O@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.2-rc1

for you to fetch changes up to f18caf261398a7f2de4fa3f600deb87072fe7b8d:

  device property: Fix documentation for fwnode_get_next_parent() (2022-12-07 17:22:44 +0100)

----------------------------------------------------------------
Driver Core changes for 6.2-rc1

Here is the set of driver core and kernfs changes for 6.2-rc1.

The "big" change in here is the addition of a new macro,
container_of_const() that will preserve the "const-ness" of a pointer
passed into it.

The "problem" of the current container_of() macro is that if you pass in
a "const *", out of it can comes a non-const pointer unless you
specifically ask for it.  For many usages, we want to preserve the
"const" attribute by using the same call.  For a specific example, this
series changes the kobj_to_dev() macro to use it, allowing it to be used
no matter what the const value is.  This prevents every subsystem from
having to declare 2 different individual macros (i.e.
kobj_const_to_dev() and kobj_to_dev()) and having the compiler enforce
the const value at build time, which having 2 macros would not do
either.

The driver for all of this have been discussions with the Rust kernel
developers as to how to properly mark driver core, and kobject, objects
as being "non-mutable".  The changes to the kobject and driver core in
this pull request are the result of that, as there are lots of paths
where kobjects and device pointers are not modified at all, so marking
them as "const" allows the compiler to enforce this.

So, a nice side affect of the Rust development effort has been already
to clean up the driver core code to be more obvious about object rules.

All of this has been bike-shedded in quite a lot of detail on lkml with
different names and implementations resulting in the tiny version we
have in here, much better than my original proposal.  Lots of subsystem
maintainers have acked the changes as well.

Other than this change, included in here are smaller stuff like:
  - kernfs fixes and updates to handle lock contention better
  - vmlinux.lds.h fixes and updates
  - sysfs and debugfs documentation updates
  - device property updates

All of these have been in the linux-next tree for quite a while with no
problems, OTHER than some merge issues with other trees that should be
obvious when you hit them (block tree deletes a driver that this tree
modifies, iommufd tree modifies code that this tree also touches).  If
there are merge problems with these trees, please let me know.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (12):
      device property: Allow const parameter to dev_fwnode()
      device property: Constify fwnode connection match APIs
      device property: Constify parameter in fwnode_graph_is_endpoint()
      device property: Constify device child node APIs
      device property: Constify parameter in device_dma_supported() and device_get_dma_attr()
      resource: Replace printk(KERN_WARNING) by pr_warn(), printk() by pr_info()
      resource: Convert DEFINE_RES_NAMED() to be compound literal
      mfd: vexpress-sysreg: Fix resource compound literal assignments
      device property: Get rid of __PROPERTY_ENTRY_ARRAY_EL*SIZE*()
      device property: Move PROPERTY_ENTRY_BOOL() a bit down
      device property: Rename goto label to be more precise
      device property: Add a blank line in Kconfig of tests

Christoph Hellwig (1):
      driver core: mark driver_allows_async_probing static

Christophe JAILLET (1):
      driver core: Use kstrtobool() instead of strtobool()

Greg Kroah-Hartman (23):
      driver core: allow kobj_to_dev() to take a const pointer
      USB: allow some usb functions to take a const pointer.
      USB: make devnode() callback in usb_class_driver take a const *
      kobject: modify kobject_get_path() to take a const *
      kobject: make get_ktype() take a const pointer
      container_of: remove container_of_safe()
      driver core: class: make namespace and get_ownership take const *
      blkdev: make struct block_device_operations.devnode() take a const *
      driver core: remove devm_device_remove_groups()
      driver core: remove devm_device_remove_group()
      Merge 6.1-rc6 into driver-core-next
      kobject: make kobject_get_ownership() take a constant kobject *
      kobject: make kobject_namespace take a const *
      kobject: kset_uevent_ops: make filter() callback take a const *
      kobject: kset_uevent_ops: make name() callback take a const *
      driver core: pass a const * into of_device_uevent()
      driver core: make struct class.dev_uevent() take a const *
      driver core: make struct class.devnode() take a const *
      driver core: fix up some missing class.devnode() conversions.
      container_of: add container_of_const() that preserves const-ness of the pointer
      device.h: move kobj_to_dev() to use container_of_const()
      usb.h: take advantage of container_of_const()
      firmware_loader: fix up to_fw_sysfs() to preserve const

Ian Kent (2):
      kernfs: dont take i_lock on inode attr read
      kernfs: dont take i_lock on revalidate

Isaac J. Manjarres (1):
      driver core: Fix bus_type.match() error handling in __driver_attach()

Jim Cromie (4):
      vmlinux.lds.h: add BOUNDED_SECTION* macros
      vmlinux.lds.h: place optional header space in BOUNDED_SECTION
      vmlinux.lds.h: fix BOUNDED_SECTION_(PRE|POST)_LABEL macros
      vmlinux.lds.h: add HEADERED_SECTION_* macros

Kees Cook (1):
      devres: Use kmalloc_size_roundup() to match ksize() usage

Miaoqian Lin (1):
      device property: Fix documentation for fwnode_get_next_parent()

Pierre Gondois (2):
      cacheinfo: Decrement refcount in cache_setup_of_node()
      cacheinfo: Remove of_node_put() for fw_token

Randy Dunlap (3):
      debugfs: small Documentation cleaning
      sysfs: update Documentation
      kernfs: fix all kernel-doc warnings and multiple typos

Sakari Ailus (1):
      linux/container_of.h: Warn about loss of constness

Soha Jin (1):
      platform: use fwnode_irq_get_byname instead of of_irq_get_byname to get irq

Stephen Rothwell (2):
      driver core: fix up missed scsi/cxlflash class.devnode() conversion.
      driver core: fix up missed drivers/s390/char/hmcdrv_dev.c class.devnode() conversion.

Thomas Weiﬂschuh (1):
      kernel/ksysfs.c: export kernel cpu byteorder

Yang Yingliang (3):
      kset: fix memory leak when kset_register() returns error
      class: fix possible memory leak in __class_register()
      Documentation: devres: add missing MEM helper

 .../ABI/testing/sysfs-kernel-cpu_byteorder         |  12 ++
 Documentation/driver-api/driver-model/devres.rst   |   1 +
 Documentation/filesystems/debugfs.rst              |   8 +-
 Documentation/filesystems/sysfs.rst                |  41 ++--
 arch/powerpc/platforms/book3s/vas-api.c            |   2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c          |   4 +-
 arch/x86/kernel/cpuid.c                            |   2 +-
 arch/x86/kernel/msr.c                              |   2 +-
 block/bsg.c                                        |   2 +-
 block/genhd.c                                      |   4 +-
 drivers/base/base.h                                |   1 -
 drivers/base/bus.c                                 |   2 +-
 drivers/base/cacheinfo.c                           |  19 +-
 drivers/base/class.c                               |   7 +-
 drivers/base/core.c                                |  66 ++----
 drivers/base/dd.c                                  |   8 +-
 drivers/base/devres.c                              |   3 +
 drivers/base/firmware_loader/sysfs.c               |   6 +-
 drivers/base/firmware_loader/sysfs.h               |   6 +-
 drivers/base/platform.c                            |   4 +-
 drivers/base/property.c                            |  36 ++--
 drivers/base/test/Kconfig                          |   1 +
 drivers/block/aoe/aoechr.c                         |   2 +-
 drivers/block/pktcdvd.c                            |   2 +-
 drivers/char/mem.c                                 |   2 +-
 drivers/char/misc.c                                |   4 +-
 drivers/dma-buf/dma-buf-sysfs-stats.c              |   2 +-
 drivers/dma-buf/dma-heap.c                         |   2 +-
 drivers/firmware/dmi-id.c                          |   2 +-
 drivers/gnss/core.c                                |   6 +-
 drivers/gpu/drm/drm_sysfs.c                        |   2 +-
 drivers/hid/usbhid/hiddev.c                        |   2 +-
 drivers/infiniband/core/device.c                   |   6 +-
 drivers/infiniband/core/user_mad.c                 |   2 +-
 drivers/infiniband/core/uverbs_main.c              |   2 +-
 drivers/infiniband/hw/hfi1/device.c                |   4 +-
 drivers/input/input.c                              |   2 +-
 drivers/isdn/mISDN/core.c                          |   4 +-
 drivers/media/dvb-core/dvbdev.c                    |   8 +-
 drivers/media/pci/ddbridge/ddbridge-core.c         |   4 +-
 drivers/media/rc/rc-main.c                         |   2 +-
 drivers/mfd/vexpress-sysreg.c                      |  16 +-
 drivers/misc/cxl/file.c                            |   2 +-
 drivers/misc/genwqe/card_base.c                    |   2 +-
 drivers/misc/ocxl/file.c                           |   2 +-
 drivers/net/ipvlan/ipvtap.c                        |   4 +-
 drivers/net/macvtap.c                              |   4 +-
 drivers/nvme/host/core.c                           |   4 +-
 drivers/of/device.c                                |   6 +-
 drivers/pcmcia/cs.c                                |   4 +-
 drivers/power/supply/power_supply.h                |   2 +-
 drivers/power/supply/power_supply_sysfs.c          |   8 +-
 drivers/s390/char/hmcdrv_dev.c                     |   2 +-
 drivers/scsi/cxlflash/main.c                       |   2 +-
 drivers/tty/tty_io.c                               |   2 +-
 drivers/usb/class/usblp.c                          |   2 +-
 drivers/usb/core/file.c                            |   2 +-
 drivers/usb/gadget/udc/core.c                      |   4 +-
 drivers/usb/misc/iowarrior.c                       |   2 +-
 drivers/usb/misc/legousbtower.c                    |   2 +-
 drivers/usb/roles/class.c                          |   2 +-
 drivers/usb/typec/mux.c                            |   8 +-
 drivers/usb/typec/retimer.c                        |   2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c                 |   2 +-
 drivers/vfio/vfio_main.c                           |   2 +-
 fs/kernfs/dir.c                                    | 106 ++++++----
 fs/kernfs/file.c                                   |  18 +-
 fs/kernfs/inode.c                                  |  12 +-
 fs/kernfs/kernfs-internal.h                        |   2 +-
 fs/kernfs/mount.c                                  |  10 +-
 fs/kernfs/symlink.c                                |   2 +-
 fs/nfs/sysfs.c                                     |   4 +-
 fs/pstore/pmsg.c                                   |   2 +-
 include/asm-generic/vmlinux.lds.h                  | 234 +++++++++------------
 include/linux/blkdev.h                             |   2 +-
 include/linux/container_of.h                       |  24 +--
 include/linux/device.h                             |   9 +-
 include/linux/device/class.h                       |   8 +-
 include/linux/ioport.h                             |   2 +-
 include/linux/kobject.h                            |  18 +-
 include/linux/kobject_ns.h                         |   4 +-
 include/linux/mISDNif.h                            |   2 +-
 include/linux/of_device.h                          |   4 +-
 include/linux/property.h                           |  84 ++++----
 include/linux/usb.h                                |  19 +-
 kernel/ksysfs.c                                    |  18 ++
 kernel/params.c                                    |   2 +-
 kernel/resource.c                                  |  17 +-
 lib/kobject.c                                      |  29 ++-
 net/atm/atm_sysfs.c                                |   4 +-
 net/bridge/br_if.c                                 |   2 +-
 net/core/net-sysfs.c                               |  20 +-
 net/rfkill/core.c                                  |   2 +-
 net/sunrpc/sysfs.c                                 |   8 +-
 net/wireless/sysfs.c                               |   2 +-
 sound/sound_core.c                                 |   2 +-
 96 files changed, 529 insertions(+), 528 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-cpu_byteorder
