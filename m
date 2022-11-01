Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814226153BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKAVFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKAVFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:05:51 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B51F1DA6C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:05:49 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id pyS5o8FnJTLjwpyS5ozMvH; Tue, 01 Nov 2022 22:05:48 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 22:05:48 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        senozhatsky@chromium.org, wangkefeng.wang@huawei.com,
        axboe@kernel.dk, kbusch@kernel.org, sfr@canb.auug.org.au,
        mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 00/30] Remove strtobool()
Date:   Tue,  1 Nov 2022 22:05:37 +0100
Message-Id: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)


Each patch can be applied independently from the other ones.
The last patch of the serie removes the definition of strtobool().

All patches have been compile tested, except the ones against
arm64, s390 and irq-gic.


Finally, this gives the opportunity to remove some <linux/kernel.h> from
a few drivers. This will be addressed later when/if the serie is applied.


Christophe JAILLET (30):
  net: usb: Use kstrtobool() instead of strtobool()
  wifi: Use kstrtobool() instead of strtobool()
  irqchip: Use kstrtobool() instead of strtobool()
  scsi: target: Use kstrtobool() instead of strtobool()
  nvdimm: Use kstrtobool() instead of strtobool()
  nvme: Use kstrtobool() instead of strtobool()
  usb: core: Use kstrtobool() instead of strtobool()
  usb: gadget: Use kstrtobool() instead of strtobool()
  ACPI: sysfs: Use kstrtobool() instead of strtobool()
  clocksource/drivers/arm_arch_timer: Use kstrtobool() instead of
    strtobool()
  greybus: svc: Use kstrtobool() instead of strtobool()
  input: Use kstrtobool() instead of strtobool()
  platform/chrome: Use kstrtobool() instead of strtobool()
  powercap: Use kstrtobool() instead of strtobool()
  video: fbdev: omapfb: Use kstrtobool() instead of strtobool()
  cifs: Use kstrtobool() instead of strtobool()
  initramfs: Use kstrtobool() instead of strtobool()
  module: Use kstrtobool() instead of strtobool()
  kernel/params.c: Use kstrtobool() instead of strtobool()
  mm/damon: Use kstrtobool() instead of strtobool()
  mm: Use kstrtobool() instead of strtobool()
  Bluetooth: hci_debugfs:: Use kstrtobool() instead of strtobool()
  test_firmware: Use kstrtobool() instead of strtobool()
  arm64: cpufeature: Use kstrtobool() instead of strtobool()
  KVM: arm64: vgic-v3: Use kstrtobool() instead of strtobool()
  s390/ipl: Use kstrtobool() instead of strtobool()
  KVM: x86/mmu: Use kstrtobool() instead of strtobool()
  x86/xen: Use kstrtobool() instead of strtobool()
  driver core: Use kstrtobool() instead of strtobool()
  kstrtox: Remove strtobool()

 arch/arm64/kernel/cpufeature.c                |  5 ++--
 arch/arm64/kvm/vgic/vgic-v3.c                 |  9 +++---
 arch/s390/kernel/ipl.c                        |  7 +++--
 arch/x86/kvm/mmu/mmu.c                        |  3 +-
 arch/x86/xen/enlighten_pv.c                   |  3 +-
 arch/x86/xen/setup.c                          |  3 +-
 drivers/acpi/sysfs.c                          |  3 +-
 drivers/base/core.c                           |  7 +++--
 drivers/clocksource/arm_arch_timer.c          |  3 +-
 drivers/greybus/svc.c                         |  3 +-
 drivers/input/input.c                         |  3 +-
 drivers/irqchip/irq-gic-v3.c                  |  3 +-
 drivers/irqchip/irq-gic.c                     |  3 +-
 drivers/net/usb/cdc_ncm.c                     |  3 +-
 drivers/net/usb/qmi_wwan.c                    |  5 ++--
 drivers/net/wireless/ath/ath10k/debug.c       |  5 ++--
 drivers/net/wireless/ath/ath9k/ath9k.h        |  1 +
 drivers/net/wireless/ath/ath9k/tx99.c         |  2 +-
 .../net/wireless/marvell/mwifiex/debugfs.c    |  2 +-
 drivers/net/wireless/marvell/mwifiex/main.h   |  1 +
 drivers/nvdimm/namespace_devs.c               |  3 +-
 drivers/nvdimm/pmem.c                         |  3 +-
 drivers/nvdimm/region_devs.c                  |  5 ++--
 drivers/nvme/host/pci.c                       |  3 +-
 drivers/nvme/target/configfs.c                | 17 ++++++-----
 drivers/platform/chrome/cros_ec_lightbar.c    |  3 +-
 drivers/powercap/powercap_sys.c               |  3 +-
 drivers/target/target_core_configfs.c         | 29 ++++++++++---------
 drivers/target/target_core_fabric_configfs.c  |  3 +-
 drivers/usb/core/port.c                       |  3 +-
 drivers/usb/core/sysfs.c                      |  7 +++--
 drivers/usb/gadget/configfs.c                 |  3 +-
 drivers/usb/gadget/function/f_mass_storage.c  |  3 +-
 drivers/usb/gadget/function/storage_common.c  |  9 +++---
 drivers/usb/gadget/function/u_serial.c        |  3 +-
 drivers/usb/gadget/legacy/serial.c            |  3 +-
 .../fbdev/omap2/omapfb/dss/display-sysfs.c    |  7 +++--
 .../fbdev/omap2/omapfb/dss/manager-sysfs.c    |  7 +++--
 .../fbdev/omap2/omapfb/dss/overlay-sysfs.c    |  3 +-
 .../video/fbdev/omap2/omapfb/omapfb-sysfs.c   |  3 +-
 fs/cifs/cifs_debug.c                          |  5 ++--
 include/linux/kernel.h                        |  2 +-
 init/initramfs.c                              |  8 ++++-
 kernel/module/main.c                          |  3 +-
 kernel/params.c                               |  3 +-
 lib/test_firmware.c                           |  3 +-
 mm/damon/lru_sort.c                           |  3 +-
 mm/damon/reclaim.c                            |  3 +-
 mm/page_table_check.c                         |  3 +-
 mm/usercopy.c                                 |  3 +-
 net/bluetooth/hci_debugfs.c                   |  3 +-
 51 files changed, 143 insertions(+), 90 deletions(-)

-- 
2.34.1

