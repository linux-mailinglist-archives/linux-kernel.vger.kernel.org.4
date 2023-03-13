Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9476B803D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjCMSTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjCMSTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:19:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509B15D475
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:19:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C537361463
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D86C433D2;
        Mon, 13 Mar 2023 18:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678731549;
        bh=czZV4OM3yE+GyGDGY2BFwpMIWGgViaLO35+n57lzyFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g4El4Cy+90qoASyafVg/DrR2opn1G/CXqRGGRfvihMiuXaicoYikaXZYO9eSll9dP
         kfUdkQLlp86K2W3pkoG/mO/hkJGiq7o9mqqqG3hCXcjLBEOzT7vdGjLmVUehoSCdCf
         HTfgu7L+yDXna3/a4IsiTlyVRI5PM9+CaqqiQBDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 04/12] driver core: class: remove module * from class_create()
Date:   Mon, 13 Mar 2023 19:18:35 +0100
Message-Id: <20230313181843.1207845-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
References: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=77600; i=gregkh@linuxfoundation.org; h=from:subject; bh=czZV4OM3yE+GyGDGY2BFwpMIWGgViaLO35+n57lzyFY=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn8mYz+fx6+Ef9lIbSv2E75VkaTsciJtTmLC13+hjZaB l/hnPy2I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZyehvDPKU3pt9y1ym8KM+e dWOdy1sR+e2RHQzzvS3s13GcPDz51mGuljke5RMfyNZ9AAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module pointer in class_create() never actually did anything, and it
shouldn't have been requred to be set as a parameter even if it did
something.  So just remove it and fix up all callers of the function in
the kernel tree at the same time.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/mips-mt.c                       | 2 +-
 arch/mips/sibyte/common/sb_tbprof.c              | 2 +-
 arch/powerpc/platforms/book3s/vas-api.c          | 2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c        | 2 +-
 arch/x86/kernel/cpuid.c                          | 2 +-
 arch/x86/kernel/msr.c                            | 2 +-
 block/bsg.c                                      | 2 +-
 drivers/accel/drm_accel.c                        | 2 +-
 drivers/accel/habanalabs/common/habanalabs_drv.c | 2 +-
 drivers/base/power/wakeup_stats.c                | 2 +-
 drivers/block/aoe/aoechr.c                       | 2 +-
 drivers/block/rnbd/rnbd-clt-sysfs.c              | 2 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c              | 2 +-
 drivers/block/ublk_drv.c                         | 2 +-
 drivers/char/bsr.c                               | 2 +-
 drivers/char/dsp56k.c                            | 2 +-
 drivers/char/ipmi/ipmi_devintf.c                 | 2 +-
 drivers/char/lp.c                                | 2 +-
 drivers/char/mem.c                               | 2 +-
 drivers/char/misc.c                              | 2 +-
 drivers/char/pcmcia/cm4000_cs.c                  | 2 +-
 drivers/char/pcmcia/cm4040_cs.c                  | 2 +-
 drivers/char/pcmcia/scr24x_cs.c                  | 2 +-
 drivers/char/ppdev.c                             | 2 +-
 drivers/char/tpm/tpm-interface.c                 | 4 ++--
 drivers/char/virtio_console.c                    | 2 +-
 drivers/char/xilinx_hwicap/xilinx_hwicap.c       | 2 +-
 drivers/char/xillybus/xillybus_class.c           | 2 +-
 drivers/comedi/comedi_fops.c                     | 2 +-
 drivers/comedi/drivers/comedi_test.c             | 2 +-
 drivers/crypto/qat/qat_common/adf_ctl_drv.c      | 2 +-
 drivers/dca/dca-sysfs.c                          | 2 +-
 drivers/devfreq/devfreq-event.c                  | 2 +-
 drivers/devfreq/devfreq.c                        | 2 +-
 drivers/dma-buf/dma-heap.c                       | 2 +-
 drivers/extcon/extcon.c                          | 2 +-
 drivers/fpga/fpga-bridge.c                       | 2 +-
 drivers/fpga/fpga-mgr.c                          | 2 +-
 drivers/fpga/fpga-region.c                       | 2 +-
 drivers/gnss/core.c                              | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c         | 2 +-
 drivers/gpu/drm/display/drm_dp_aux_dev.c         | 2 +-
 drivers/gpu/drm/drm_sysfs.c                      | 2 +-
 drivers/hid/hid-roccat-arvo.c                    | 2 +-
 drivers/hid/hid-roccat-isku.c                    | 2 +-
 drivers/hid/hid-roccat-kone.c                    | 2 +-
 drivers/hid/hid-roccat-koneplus.c                | 2 +-
 drivers/hid/hid-roccat-konepure.c                | 2 +-
 drivers/hid/hid-roccat-kovaplus.c                | 2 +-
 drivers/hid/hid-roccat-pyra.c                    | 2 +-
 drivers/hid/hid-roccat-ryos.c                    | 2 +-
 drivers/hid/hid-roccat-savu.c                    | 2 +-
 drivers/hid/hidraw.c                             | 2 +-
 drivers/i2c/i2c-dev.c                            | 2 +-
 drivers/infiniband/core/uverbs_main.c            | 2 +-
 drivers/infiniband/hw/hfi1/device.c              | 4 ++--
 drivers/infiniband/hw/qib/qib_file_ops.c         | 2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c           | 2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c           | 2 +-
 drivers/isdn/capi/capi.c                         | 2 +-
 drivers/isdn/mISDN/dsp_pipeline.c                | 2 +-
 drivers/leds/led-class.c                         | 2 +-
 drivers/macintosh/adb.c                          | 2 +-
 drivers/media/dvb-core/dvbdev.c                  | 2 +-
 drivers/media/rc/lirc_dev.c                      | 2 +-
 drivers/misc/c2port/core.c                       | 2 +-
 drivers/misc/cxl/file.c                          | 2 +-
 drivers/misc/genwqe/card_base.c                  | 2 +-
 drivers/misc/hpilo.c                             | 2 +-
 drivers/misc/mei/main.c                          | 2 +-
 drivers/misc/ocxl/file.c                         | 2 +-
 drivers/misc/phantom.c                           | 2 +-
 drivers/misc/uacce/uacce.c                       | 2 +-
 drivers/most/most_cdev.c                         | 2 +-
 drivers/net/ethernet/hisilicon/hns/hnae.c        | 2 +-
 drivers/net/ppp/ppp_generic.c                    | 2 +-
 drivers/net/wireless/mac80211_hwsim.c            | 2 +-
 drivers/net/wwan/wwan_core.c                     | 2 +-
 drivers/net/wwan/wwan_hwsim.c                    | 2 +-
 drivers/nvdimm/bus.c                             | 2 +-
 drivers/nvme/host/core.c                         | 6 +++---
 drivers/nvme/host/fabrics.c                      | 2 +-
 drivers/nvme/target/fcloop.c                     | 2 +-
 drivers/pci/endpoint/pci-epc-core.c              | 2 +-
 drivers/pci/switch/switchtec.c                   | 2 +-
 drivers/phy/phy-core.c                           | 2 +-
 drivers/power/supply/power_supply_core.c         | 2 +-
 drivers/pps/pps.c                                | 2 +-
 drivers/ptp/ptp_clock.c                          | 2 +-
 drivers/rapidio/devices/rio_mport_cdev.c         | 2 +-
 drivers/rapidio/rio_cm.c                         | 2 +-
 drivers/rpmsg/rpmsg_core.c                       | 2 +-
 drivers/rtc/class.c                              | 2 +-
 drivers/s390/char/hmcdrv_dev.c                   | 2 +-
 drivers/s390/char/raw3270.c                      | 2 +-
 drivers/s390/char/tape_class.c                   | 2 +-
 drivers/s390/char/vmlogrdr.c                     | 2 +-
 drivers/s390/char/vmur.c                         | 2 +-
 drivers/s390/crypto/zcrypt_api.c                 | 2 +-
 drivers/sbus/char/oradax.c                       | 2 +-
 drivers/scsi/ch.c                                | 2 +-
 drivers/scsi/cxlflash/main.c                     | 2 +-
 drivers/scsi/pmcraid.c                           | 2 +-
 drivers/scsi/sg.c                                | 2 +-
 drivers/spi/spidev.c                             | 2 +-
 drivers/staging/fieldbus/anybuss/arcx-anybus.c   | 2 +-
 drivers/staging/greybus/authentication.c         | 2 +-
 drivers/staging/greybus/fw-management.c          | 2 +-
 drivers/staging/greybus/raw.c                    | 2 +-
 drivers/staging/pi433/pi433_if.c                 | 2 +-
 drivers/staging/vme_user/vme_user.c              | 2 +-
 drivers/tee/tee_core.c                           | 2 +-
 drivers/tty/tty_io.c                             | 2 +-
 drivers/tty/vt/vc_screen.c                       | 2 +-
 drivers/tty/vt/vt.c                              | 2 +-
 drivers/usb/core/file.c                          | 2 +-
 drivers/usb/gadget/function/f_hid.c              | 2 +-
 drivers/usb/gadget/function/f_printer.c          | 2 +-
 drivers/usb/gadget/udc/core.c                    | 2 +-
 drivers/usb/mon/mon_bin.c                        | 2 +-
 drivers/usb/roles/class.c                        | 2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c               | 2 +-
 drivers/vfio/group.c                             | 2 +-
 drivers/vfio/vfio_main.c                         | 2 +-
 drivers/video/backlight/backlight.c              | 2 +-
 drivers/video/backlight/lcd.c                    | 2 +-
 drivers/video/fbdev/core/fbmem.c                 | 2 +-
 fs/coda/psdev.c                                  | 2 +-
 fs/fuse/cuse.c                                   | 2 +-
 fs/pstore/pmsg.c                                 | 2 +-
 include/linux/device/class.h                     | 3 +--
 mm/backing-dev.c                                 | 2 +-
 net/bluetooth/hci_sysfs.c                        | 2 +-
 net/netfilter/xt_IDLETIMER.c                     | 2 +-
 samples/vfio-mdev/mbochs.c                       | 2 +-
 samples/vfio-mdev/mdpy.c                         | 2 +-
 samples/vfio-mdev/mtty.c                         | 2 +-
 sound/sound_core.c                               | 2 +-
 tools/testing/nvdimm/test/ndtest.c               | 2 +-
 tools/testing/nvdimm/test/nfit.c                 | 2 +-
 140 files changed, 144 insertions(+), 145 deletions(-)

diff --git a/arch/mips/kernel/mips-mt.c b/arch/mips/kernel/mips-mt.c
index dc023a979803..f88b7919f11f 100644
--- a/arch/mips/kernel/mips-mt.c
+++ b/arch/mips/kernel/mips-mt.c
@@ -234,7 +234,7 @@ static int __init mips_mt_init(void)
 {
 	struct class *mtc;
 
-	mtc = class_create(THIS_MODULE, "mt");
+	mtc = class_create("mt");
 	if (IS_ERR(mtc))
 		return PTR_ERR(mtc);
 
diff --git a/arch/mips/sibyte/common/sb_tbprof.c b/arch/mips/sibyte/common/sb_tbprof.c
index bc47681e825a..ac376dfb4e7c 100644
--- a/arch/mips/sibyte/common/sb_tbprof.c
+++ b/arch/mips/sibyte/common/sb_tbprof.c
@@ -550,7 +550,7 @@ static int __init sbprof_tb_init(void)
 		return -EIO;
 	}
 
-	tbc = class_create(THIS_MODULE, "sb_tracebuffer");
+	tbc = class_create("sb_tracebuffer");
 	if (IS_ERR(tbc)) {
 		err = PTR_ERR(tbc);
 		goto out_chrdev;
diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
index 36c21648d19a..77ea9335fd04 100644
--- a/arch/powerpc/platforms/book3s/vas-api.c
+++ b/arch/powerpc/platforms/book3s/vas-api.c
@@ -581,7 +581,7 @@ int vas_register_coproc_api(struct module *mod, enum vas_cop_type cop_type,
 	pr_devel("%s device allocated, dev [%i,%i]\n", name,
 			MAJOR(coproc_device.devt), MINOR(coproc_device.devt));
 
-	coproc_device.class = class_create(mod, name);
+	coproc_device.class = class_create(name);
 	if (IS_ERR(coproc_device.class)) {
 		rc = PTR_ERR(coproc_device.class);
 		pr_err("Unable to create %s class %d\n", name, rc);
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 524f8ff3e69c..458cb7419502 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -1580,7 +1580,7 @@ int rdt_pseudo_lock_init(void)
 
 	pseudo_lock_major = ret;
 
-	pseudo_lock_class = class_create(THIS_MODULE, "pseudo_lock");
+	pseudo_lock_class = class_create("pseudo_lock");
 	if (IS_ERR(pseudo_lock_class)) {
 		ret = PTR_ERR(pseudo_lock_class);
 		unregister_chrdev(pseudo_lock_major, "pseudo_lock");
diff --git a/arch/x86/kernel/cpuid.c b/arch/x86/kernel/cpuid.c
index 621ba9c0f17a..bdc0d5539b57 100644
--- a/arch/x86/kernel/cpuid.c
+++ b/arch/x86/kernel/cpuid.c
@@ -154,7 +154,7 @@ static int __init cpuid_init(void)
 		       CPUID_MAJOR);
 		return -EBUSY;
 	}
-	cpuid_class = class_create(THIS_MODULE, "cpuid");
+	cpuid_class = class_create("cpuid");
 	if (IS_ERR(cpuid_class)) {
 		err = PTR_ERR(cpuid_class);
 		goto out_chrdev;
diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 708751311786..7bb17d37db01 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -263,7 +263,7 @@ static int __init msr_init(void)
 		pr_err("unable to get major %d for msr\n", MSR_MAJOR);
 		return -EBUSY;
 	}
-	msr_class = class_create(THIS_MODULE, "msr");
+	msr_class = class_create("msr");
 	if (IS_ERR(msr_class)) {
 		err = PTR_ERR(msr_class);
 		goto out_chrdev;
diff --git a/block/bsg.c b/block/bsg.c
index 30fcc865ef4f..7eca43f33d7f 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -245,7 +245,7 @@ static int __init bsg_init(void)
 	dev_t devid;
 	int ret;
 
-	bsg_class = class_create(THIS_MODULE, "bsg");
+	bsg_class = class_create("bsg");
 	if (IS_ERR(bsg_class))
 		return PTR_ERR(bsg_class);
 	bsg_class->devnode = bsg_devnode;
diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
index 1b69824286fd..4a9baf02439e 100644
--- a/drivers/accel/drm_accel.c
+++ b/drivers/accel/drm_accel.c
@@ -34,7 +34,7 @@ static char *accel_devnode(const struct device *dev, umode_t *mode)
 
 static int accel_sysfs_init(void)
 {
-	accel_class = class_create(THIS_MODULE, "accel");
+	accel_class = class_create("accel");
 	if (IS_ERR(accel_class))
 		return PTR_ERR(accel_class);
 
diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index 03dae57dc838..3538e89e4e5e 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -702,7 +702,7 @@ static int __init hl_init(void)
 
 	hl_major = MAJOR(dev);
 
-	hl_class = class_create(THIS_MODULE, HL_NAME);
+	hl_class = class_create(HL_NAME);
 	if (IS_ERR(hl_class)) {
 		pr_err("failed to allocate class\n");
 		rc = PTR_ERR(hl_class);
diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
index 924fac493c4f..6732ed2869f9 100644
--- a/drivers/base/power/wakeup_stats.c
+++ b/drivers/base/power/wakeup_stats.c
@@ -210,7 +210,7 @@ void wakeup_source_sysfs_remove(struct wakeup_source *ws)
 
 static int __init wakeup_sources_sysfs_init(void)
 {
-	wakeup_class = class_create(THIS_MODULE, "wakeup");
+	wakeup_class = class_create("wakeup");
 
 	return PTR_ERR_OR_ZERO(wakeup_class);
 }
diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
index 7a368c90467d..4c666f72203f 100644
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -290,7 +290,7 @@ aoechr_init(void)
 	}
 	init_completion(&emsgs_comp);
 	spin_lock_init(&emsgs_lock);
-	aoe_class = class_create(THIS_MODULE, "aoe");
+	aoe_class = class_create("aoe");
 	if (IS_ERR(aoe_class)) {
 		unregister_chrdev(AOE_MAJOR, "aoechr");
 		return PTR_ERR(aoe_class);
diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index e7c7d9a68168..8c6087949794 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -646,7 +646,7 @@ int rnbd_clt_create_sysfs_files(void)
 {
 	int err;
 
-	rnbd_dev_class = class_create(THIS_MODULE, "rnbd-client");
+	rnbd_dev_class = class_create("rnbd-client");
 	if (IS_ERR(rnbd_dev_class))
 		return PTR_ERR(rnbd_dev_class);
 
diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index 297a6924ff4e..d5d9267e1fa5 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -215,7 +215,7 @@ int rnbd_srv_create_sysfs_files(void)
 {
 	int err;
 
-	rnbd_dev_class = class_create(THIS_MODULE, "rnbd-server");
+	rnbd_dev_class = class_create("rnbd-server");
 	if (IS_ERR(rnbd_dev_class))
 		return PTR_ERR(rnbd_dev_class);
 
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d1d1c8d606c8..2eb46419562b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2266,7 +2266,7 @@ static int __init ublk_init(void)
 	if (ret)
 		goto unregister_mis;
 
-	ublk_chr_class = class_create(THIS_MODULE, "ublk-char");
+	ublk_chr_class = class_create("ublk-char");
 	if (IS_ERR(ublk_chr_class)) {
 		ret = PTR_ERR(ublk_chr_class);
 		goto free_chrdev_region;
diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
index d5f943938427..ff429ba02fa4 100644
--- a/drivers/char/bsr.c
+++ b/drivers/char/bsr.c
@@ -293,7 +293,7 @@ static int __init bsr_init(void)
 	if (!np)
 		goto out_err;
 
-	bsr_class = class_create(THIS_MODULE, "bsr");
+	bsr_class = class_create("bsr");
 	if (IS_ERR(bsr_class)) {
 		printk(KERN_ERR "class_create() failed for bsr_class\n");
 		ret = PTR_ERR(bsr_class);
diff --git a/drivers/char/dsp56k.c b/drivers/char/dsp56k.c
index 06749e295ada..b3eaf3e5ef2e 100644
--- a/drivers/char/dsp56k.c
+++ b/drivers/char/dsp56k.c
@@ -504,7 +504,7 @@ static int __init dsp56k_init_driver(void)
 		printk("DSP56k driver: Unable to register driver\n");
 		return -ENODEV;
 	}
-	dsp56k_class = class_create(THIS_MODULE, "dsp56k");
+	dsp56k_class = class_create("dsp56k");
 	if (IS_ERR(dsp56k_class)) {
 		err = PTR_ERR(dsp56k_class);
 		goto out_chrdev;
diff --git a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
index d160fa4c73fe..73e5a9e28f85 100644
--- a/drivers/char/ipmi/ipmi_devintf.c
+++ b/drivers/char/ipmi/ipmi_devintf.c
@@ -860,7 +860,7 @@ static int __init init_ipmi_devintf(void)
 
 	pr_info("ipmi device interface\n");
 
-	ipmi_class = class_create(THIS_MODULE, "ipmi");
+	ipmi_class = class_create("ipmi");
 	if (IS_ERR(ipmi_class)) {
 		pr_err("ipmi: can't register device class\n");
 		return PTR_ERR(ipmi_class);
diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 38aad99ebb61..70cfc5140c2c 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -1049,7 +1049,7 @@ static int __init lp_init(void)
 		return -EIO;
 	}
 
-	lp_class = class_create(THIS_MODULE, "printer");
+	lp_class = class_create("printer");
 	if (IS_ERR(lp_class)) {
 		err = PTR_ERR(lp_class);
 		goto out_reg;
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index ffb101d349f0..f494d31f2b98 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -762,7 +762,7 @@ static int __init chr_dev_init(void)
 	if (register_chrdev(MEM_MAJOR, "mem", &memory_fops))
 		printk("unable to get major %d for memory devs\n", MEM_MAJOR);
 
-	mem_class = class_create(THIS_MODULE, "mem");
+	mem_class = class_create("mem");
 	if (IS_ERR(mem_class))
 		return PTR_ERR(mem_class);
 
diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 7a1388b0572b..1c44c29a666e 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -286,7 +286,7 @@ static int __init misc_init(void)
 	struct proc_dir_entry *ret;
 
 	ret = proc_create_seq("misc", 0, NULL, &misc_seq_ops);
-	misc_class = class_create(THIS_MODULE, "misc");
+	misc_class = class_create("misc");
 	err = PTR_ERR(misc_class);
 	if (IS_ERR(misc_class))
 		goto fail_remove;
diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index e656f42a28ac..7f96d8571a53 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1878,7 +1878,7 @@ static int __init cmm_init(void)
 {
 	int rc;
 
-	cmm_class = class_create(THIS_MODULE, "cardman_4000");
+	cmm_class = class_create("cardman_4000");
 	if (IS_ERR(cmm_class))
 		return PTR_ERR(cmm_class);
 
diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
index 827711911da4..11ff59e2b963 100644
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -650,7 +650,7 @@ static int __init cm4040_init(void)
 {
 	int rc;
 
-	cmx_class = class_create(THIS_MODULE, "cardman_4040");
+	cmx_class = class_create("cardman_4040");
 	if (IS_ERR(cmx_class))
 		return PTR_ERR(cmx_class);
 
diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
index 1bdce08fae3d..870781f5a08c 100644
--- a/drivers/char/pcmcia/scr24x_cs.c
+++ b/drivers/char/pcmcia/scr24x_cs.c
@@ -325,7 +325,7 @@ static int __init scr24x_init(void)
 {
 	int ret;
 
-	scr24x_class = class_create(THIS_MODULE, "scr24x");
+	scr24x_class = class_create("scr24x");
 	if (IS_ERR(scr24x_class))
 		return PTR_ERR(scr24x_class);
 
diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 38b46c7d1737..81ed58157b15 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -841,7 +841,7 @@ static int __init ppdev_init(void)
 		pr_warn(CHRDEV ": unable to get major %d\n", PP_MAJOR);
 		return -EIO;
 	}
-	ppdev_class = class_create(THIS_MODULE, CHRDEV);
+	ppdev_class = class_create(CHRDEV);
 	if (IS_ERR(ppdev_class)) {
 		err = PTR_ERR(ppdev_class);
 		goto out_chrdev;
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 7e513b771832..8763c820d1f8 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -466,13 +466,13 @@ static int __init tpm_init(void)
 {
 	int rc;
 
-	tpm_class = class_create(THIS_MODULE, "tpm");
+	tpm_class = class_create("tpm");
 	if (IS_ERR(tpm_class)) {
 		pr_err("couldn't create tpm class\n");
 		return PTR_ERR(tpm_class);
 	}
 
-	tpmrm_class = class_create(THIS_MODULE, "tpmrm");
+	tpmrm_class = class_create("tpmrm");
 	if (IS_ERR(tpmrm_class)) {
 		pr_err("couldn't create tpmrm class\n");
 		rc = PTR_ERR(tpmrm_class);
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index d5ac4d955bc8..b65c809a4e97 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2244,7 +2244,7 @@ static int __init virtio_console_init(void)
 {
 	int err;
 
-	pdrvdata.class = class_create(THIS_MODULE, "virtio-ports");
+	pdrvdata.class = class_create("virtio-ports");
 	if (IS_ERR(pdrvdata.class)) {
 		err = PTR_ERR(pdrvdata.class);
 		pr_err("Error %d creating virtio-ports class\n", err);
diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index 74a4928aea1d..a46f637da959 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -856,7 +856,7 @@ static int __init hwicap_module_init(void)
 	dev_t devt;
 	int retval;
 
-	icap_class = class_create(THIS_MODULE, "xilinx_config");
+	icap_class = class_create("xilinx_config");
 	mutex_init(&icap_sem);
 
 	devt = MKDEV(XHWICAP_MAJOR, XHWICAP_MINOR);
diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
index e9a288e61c15..89926fe9d813 100644
--- a/drivers/char/xillybus/xillybus_class.c
+++ b/drivers/char/xillybus/xillybus_class.c
@@ -242,7 +242,7 @@ EXPORT_SYMBOL(xillybus_find_inode);
 
 static int __init xillybus_class_init(void)
 {
-	xillybus_class = class_create(THIS_MODULE, "xillybus");
+	xillybus_class = class_create("xillybus");
 
 	if (IS_ERR(xillybus_class)) {
 		pr_warn("Failed to register xillybus class\n");
diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index b982903aaa46..8e43918d38c4 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -3383,7 +3383,7 @@ static int __init comedi_init(void)
 	if (retval)
 		goto out_unregister_chrdev_region;
 
-	comedi_class = class_create(THIS_MODULE, "comedi");
+	comedi_class = class_create("comedi");
 	if (IS_ERR(comedi_class)) {
 		retval = PTR_ERR(comedi_class);
 		pr_err("failed to create class\n");
diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index 0b5c0af1cebf..c02dc19a679b 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -795,7 +795,7 @@ static int __init comedi_test_init(void)
 	}
 
 	if (!config_mode) {
-		ctcls = class_create(THIS_MODULE, CLASS_NAME);
+		ctcls = class_create(CLASS_NAME);
 		if (IS_ERR(ctcls)) {
 			pr_warn("comedi_test: unable to create class\n");
 			goto clean3;
diff --git a/drivers/crypto/qat/qat_common/adf_ctl_drv.c b/drivers/crypto/qat/qat_common/adf_ctl_drv.c
index 9190532b27eb..75a50fde5644 100644
--- a/drivers/crypto/qat/qat_common/adf_ctl_drv.c
+++ b/drivers/crypto/qat/qat_common/adf_ctl_drv.c
@@ -56,7 +56,7 @@ static int adf_chr_drv_create(void)
 		return -EFAULT;
 	}
 
-	adf_ctl_drv.drv_class = class_create(THIS_MODULE, DEVICE_NAME);
+	adf_ctl_drv.drv_class = class_create(DEVICE_NAME);
 	if (IS_ERR(adf_ctl_drv.drv_class)) {
 		pr_err("QAT: class_create failed for adf_ctl\n");
 		goto err_chrdev_unreg;
diff --git a/drivers/dca/dca-sysfs.c b/drivers/dca/dca-sysfs.c
index 21ebd0af268b..fcc83ede0909 100644
--- a/drivers/dca/dca-sysfs.c
+++ b/drivers/dca/dca-sysfs.c
@@ -74,7 +74,7 @@ int __init dca_sysfs_init(void)
 	idr_init(&dca_idr);
 	spin_lock_init(&dca_idr_lock);
 
-	dca_class = class_create(THIS_MODULE, "dca");
+	dca_class = class_create("dca");
 	if (IS_ERR(dca_class)) {
 		idr_destroy(&dca_idr);
 		return PTR_ERR(dca_class);
diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index f041edccd107..3ebac2496679 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -469,7 +469,7 @@ ATTRIBUTE_GROUPS(devfreq_event);
 
 static int __init devfreq_event_init(void)
 {
-	devfreq_event_class = class_create(THIS_MODULE, "devfreq-event");
+	devfreq_event_class = class_create("devfreq-event");
 	if (IS_ERR(devfreq_event_class)) {
 		pr_err("%s: couldn't create class\n", __FILE__);
 		return PTR_ERR(devfreq_event_class);
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 817c71da391a..e36cbb920ec8 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1988,7 +1988,7 @@ DEFINE_SHOW_ATTRIBUTE(devfreq_summary);
 
 static int __init devfreq_init(void)
 {
-	devfreq_class = class_create(THIS_MODULE, "devfreq");
+	devfreq_class = class_create("devfreq");
 	if (IS_ERR(devfreq_class)) {
 		pr_err("%s: couldn't create class\n", __FILE__);
 		return PTR_ERR(devfreq_class);
diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index c9e41e8a9e27..84ae708fafe7 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -314,7 +314,7 @@ static int dma_heap_init(void)
 	if (ret)
 		return ret;
 
-	dma_heap_class = class_create(THIS_MODULE, DEVNAME);
+	dma_heap_class = class_create(DEVNAME);
 	if (IS_ERR(dma_heap_class)) {
 		unregister_chrdev_region(dma_heap_devt, NUM_HEAP_MINORS);
 		return PTR_ERR(dma_heap_class);
diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e1c71359b605..d43ba8e7260d 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1013,7 +1013,7 @@ ATTRIBUTE_GROUPS(extcon);
 static int create_extcon_class(void)
 {
 	if (!extcon_class) {
-		extcon_class = class_create(THIS_MODULE, "extcon");
+		extcon_class = class_create("extcon");
 		if (IS_ERR(extcon_class))
 			return PTR_ERR(extcon_class);
 		extcon_class->dev_groups = extcon_groups;
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 5cd40acab5bf..6a521c83a1ed 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -416,7 +416,7 @@ static void fpga_bridge_dev_release(struct device *dev)
 
 static int __init fpga_bridge_dev_init(void)
 {
-	fpga_bridge_class = class_create(THIS_MODULE, "fpga_bridge");
+	fpga_bridge_class = class_create("fpga_bridge");
 	if (IS_ERR(fpga_bridge_class))
 		return PTR_ERR(fpga_bridge_class);
 
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 8efa67620e21..eb583f86a0b9 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -971,7 +971,7 @@ static int __init fpga_mgr_class_init(void)
 {
 	pr_info("FPGA manager framework\n");
 
-	fpga_mgr_class = class_create(THIS_MODULE, "fpga_manager");
+	fpga_mgr_class = class_create("fpga_manager");
 	if (IS_ERR(fpga_mgr_class))
 		return PTR_ERR(fpga_mgr_class);
 
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 27ff9dea04ae..ccf6fdab1360 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -293,7 +293,7 @@ static void fpga_region_dev_release(struct device *dev)
  */
 static int __init fpga_region_init(void)
 {
-	fpga_region_class = class_create(THIS_MODULE, "fpga_region");
+	fpga_region_class = class_create("fpga_region");
 	if (IS_ERR(fpga_region_class))
 		return PTR_ERR(fpga_region_class);
 
diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index 77a4b280c552..48f2ee0f78c4 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -387,7 +387,7 @@ static int __init gnss_module_init(void)
 		return ret;
 	}
 
-	gnss_class = class_create(THIS_MODULE, "gnss");
+	gnss_class = class_create("gnss");
 	if (IS_ERR(gnss_class)) {
 		ret = PTR_ERR(gnss_class);
 		pr_err("failed to create class: %d\n", ret);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index a0e30f21e12e..20e75bd74bed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -93,7 +93,7 @@ int kfd_chardev_init(void)
 	if (err < 0)
 		goto err_register_chrdev;
 
-	kfd_class = class_create(THIS_MODULE, kfd_dev_name);
+	kfd_class = class_create(kfd_dev_name);
 	err = PTR_ERR(kfd_class);
 	if (IS_ERR(kfd_class))
 		goto err_class_create;
diff --git a/drivers/gpu/drm/display/drm_dp_aux_dev.c b/drivers/gpu/drm/display/drm_dp_aux_dev.c
index 098e482e65a2..29555b9f03c8 100644
--- a/drivers/gpu/drm/display/drm_dp_aux_dev.c
+++ b/drivers/gpu/drm/display/drm_dp_aux_dev.c
@@ -330,7 +330,7 @@ int drm_dp_aux_dev_init(void)
 {
 	int res;
 
-	drm_dp_aux_dev_class = class_create(THIS_MODULE, "drm_dp_aux_dev");
+	drm_dp_aux_dev_class = class_create("drm_dp_aux_dev");
 	if (IS_ERR(drm_dp_aux_dev_class)) {
 		return PTR_ERR(drm_dp_aux_dev_class);
 	}
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 183130355997..3c22a803201d 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -112,7 +112,7 @@ int drm_sysfs_init(void)
 {
 	int err;
 
-	drm_class = class_create(THIS_MODULE, "drm");
+	drm_class = class_create("drm");
 	if (IS_ERR(drm_class))
 		return PTR_ERR(drm_class);
 
diff --git a/drivers/hid/hid-roccat-arvo.c b/drivers/hid/hid-roccat-arvo.c
index d94ee0539421..ea6b79b3aeeb 100644
--- a/drivers/hid/hid-roccat-arvo.c
+++ b/drivers/hid/hid-roccat-arvo.c
@@ -433,7 +433,7 @@ static int __init arvo_init(void)
 {
 	int retval;
 
-	arvo_class = class_create(THIS_MODULE, "arvo");
+	arvo_class = class_create("arvo");
 	if (IS_ERR(arvo_class))
 		return PTR_ERR(arvo_class);
 	arvo_class->dev_groups = arvo_groups;
diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index e95d59cd8d07..3903a2cea00c 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -435,7 +435,7 @@ static struct hid_driver isku_driver = {
 static int __init isku_init(void)
 {
 	int retval;
-	isku_class = class_create(THIS_MODULE, "isku");
+	isku_class = class_create("isku");
 	if (IS_ERR(isku_class))
 		return PTR_ERR(isku_class);
 	isku_class->dev_groups = isku_groups;
diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 76da04801ca9..945ae236fb45 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -890,7 +890,7 @@ static int __init kone_init(void)
 	int retval;
 
 	/* class name has to be same as driver name */
-	kone_class = class_create(THIS_MODULE, "kone");
+	kone_class = class_create("kone");
 	if (IS_ERR(kone_class))
 		return PTR_ERR(kone_class);
 	kone_class->dev_groups = kone_groups;
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index 1896c69ea512..97b83b6f53dd 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -549,7 +549,7 @@ static int __init koneplus_init(void)
 	int retval;
 
 	/* class name has to be same as driver name */
-	koneplus_class = class_create(THIS_MODULE, "koneplus");
+	koneplus_class = class_create("koneplus");
 	if (IS_ERR(koneplus_class))
 		return PTR_ERR(koneplus_class);
 	koneplus_class->dev_groups = koneplus_groups;
diff --git a/drivers/hid/hid-roccat-konepure.c b/drivers/hid/hid-roccat-konepure.c
index cf8eeb33a125..a297756f2410 100644
--- a/drivers/hid/hid-roccat-konepure.c
+++ b/drivers/hid/hid-roccat-konepure.c
@@ -207,7 +207,7 @@ static int __init konepure_init(void)
 {
 	int retval;
 
-	konepure_class = class_create(THIS_MODULE, "konepure");
+	konepure_class = class_create("konepure");
 	if (IS_ERR(konepure_class))
 		return PTR_ERR(konepure_class);
 	konepure_class->dev_groups = konepure_groups;
diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 6fb9b9563769..1a1d96e11683 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -638,7 +638,7 @@ static int __init kovaplus_init(void)
 {
 	int retval;
 
-	kovaplus_class = class_create(THIS_MODULE, "kovaplus");
+	kovaplus_class = class_create("kovaplus");
 	if (IS_ERR(kovaplus_class))
 		return PTR_ERR(kovaplus_class);
 	kovaplus_class->dev_groups = kovaplus_groups;
diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 4fcc8e7d276f..15528c3b013c 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -585,7 +585,7 @@ static int __init pyra_init(void)
 	int retval;
 
 	/* class name has to be same as driver name */
-	pyra_class = class_create(THIS_MODULE, "pyra");
+	pyra_class = class_create("pyra");
 	if (IS_ERR(pyra_class))
 		return PTR_ERR(pyra_class);
 	pyra_class->dev_groups = pyra_groups;
diff --git a/drivers/hid/hid-roccat-ryos.c b/drivers/hid/hid-roccat-ryos.c
index 5bf1971a2b14..0eb17a3b925d 100644
--- a/drivers/hid/hid-roccat-ryos.c
+++ b/drivers/hid/hid-roccat-ryos.c
@@ -216,7 +216,7 @@ static int __init ryos_init(void)
 {
 	int retval;
 
-	ryos_class = class_create(THIS_MODULE, "ryos");
+	ryos_class = class_create("ryos");
 	if (IS_ERR(ryos_class))
 		return PTR_ERR(ryos_class);
 	ryos_class->dev_groups = ryos_groups;
diff --git a/drivers/hid/hid-roccat-savu.c b/drivers/hid/hid-roccat-savu.c
index a784bb4ee651..93be7acef673 100644
--- a/drivers/hid/hid-roccat-savu.c
+++ b/drivers/hid/hid-roccat-savu.c
@@ -204,7 +204,7 @@ static int __init savu_init(void)
 {
 	int retval;
 
-	savu_class = class_create(THIS_MODULE, "savu");
+	savu_class = class_create("savu");
 	if (IS_ERR(savu_class))
 		return PTR_ERR(savu_class);
 	savu_class->dev_groups = savu_groups;
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 197b1e7bf029..93e62b161501 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -618,7 +618,7 @@ int __init hidraw_init(void)
 
 	hidraw_major = MAJOR(dev_id);
 
-	hidraw_class = class_create(THIS_MODULE, "hidraw");
+	hidraw_class = class_create("hidraw");
 	if (IS_ERR(hidraw_class)) {
 		result = PTR_ERR(hidraw_class);
 		goto error_cdev;
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 107623c4cc14..ef93064cfdb3 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -739,7 +739,7 @@ static int __init i2c_dev_init(void)
 	if (res)
 		goto out;
 
-	i2c_dev_class = class_create(THIS_MODULE, "i2c-dev");
+	i2c_dev_class = class_create("i2c-dev");
 	if (IS_ERR(i2c_dev_class)) {
 		res = PTR_ERR(i2c_dev_class);
 		goto out_unreg_chrdev;
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index bdb179a09d77..fbace69672ca 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -1264,7 +1264,7 @@ static int __init ib_uverbs_init(void)
 		goto out_alloc;
 	}
 
-	uverbs_class = class_create(THIS_MODULE, "infiniband_verbs");
+	uverbs_class = class_create("infiniband_verbs");
 	if (IS_ERR(uverbs_class)) {
 		ret = PTR_ERR(uverbs_class);
 		pr_err("user_verbs: couldn't create class infiniband_verbs\n");
diff --git a/drivers/infiniband/hw/hfi1/device.c b/drivers/infiniband/hw/hfi1/device.c
index 1f4496032170..05be0d119f79 100644
--- a/drivers/infiniband/hw/hfi1/device.c
+++ b/drivers/infiniband/hw/hfi1/device.c
@@ -102,7 +102,7 @@ int __init dev_init(void)
 		goto done;
 	}
 
-	class = class_create(THIS_MODULE, class_name());
+	class = class_create(class_name());
 	if (IS_ERR(class)) {
 		ret = PTR_ERR(class);
 		pr_err("Could not create device class (err %d)\n", -ret);
@@ -111,7 +111,7 @@ int __init dev_init(void)
 	}
 	class->devnode = hfi1_devnode;
 
-	user_class = class_create(THIS_MODULE, class_name_user());
+	user_class = class_create(class_name_user());
 	if (IS_ERR(user_class)) {
 		ret = PTR_ERR(user_class);
 		pr_err("Could not create device class for user accessible files (err %d)\n",
diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index 80fe92a21f96..c07c95fd3cfa 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -2326,7 +2326,7 @@ int __init qib_dev_init(void)
 		goto done;
 	}
 
-	qib_class = class_create(THIS_MODULE, "ipath");
+	qib_class = class_create("ipath");
 	if (IS_ERR(qib_class)) {
 		ret = PTR_ERR(qib_class);
 		pr_err("Could not create device class (err %d)\n", -ret);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 80abf45a197a..edb2e3a25880 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -3163,7 +3163,7 @@ static int __init rtrs_client_init(void)
 {
 	rtrs_rdma_dev_pd_init(0, &dev_pd);
 
-	rtrs_clt_dev_class = class_create(THIS_MODULE, "rtrs-client");
+	rtrs_clt_dev_class = class_create("rtrs-client");
 	if (IS_ERR(rtrs_clt_dev_class)) {
 		pr_err("Failed to create rtrs-client dev class\n");
 		return PTR_ERR(rtrs_clt_dev_class);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index d1703e2c0b82..c38901e2c8f4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -2253,7 +2253,7 @@ static int __init rtrs_server_init(void)
 		       err);
 		return err;
 	}
-	rtrs_dev_class = class_create(THIS_MODULE, "rtrs-server");
+	rtrs_dev_class = class_create("rtrs-server");
 	if (IS_ERR(rtrs_dev_class)) {
 		err = PTR_ERR(rtrs_dev_class);
 		goto out_err;
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 0f00be62438d..45a4043c5042 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1393,7 +1393,7 @@ static int __init capi_init(void)
 		kcapi_exit();
 		return major_ret;
 	}
-	capi_class = class_create(THIS_MODULE, "capi");
+	capi_class = class_create("capi");
 	if (IS_ERR(capi_class)) {
 		unregister_chrdev(capi_major, "capi20");
 		kcapi_exit();
diff --git a/drivers/isdn/mISDN/dsp_pipeline.c b/drivers/isdn/mISDN/dsp_pipeline.c
index cfbcd9e973c2..09b72f14d4b7 100644
--- a/drivers/isdn/mISDN/dsp_pipeline.c
+++ b/drivers/isdn/mISDN/dsp_pipeline.c
@@ -131,7 +131,7 @@ EXPORT_SYMBOL(mISDN_dsp_element_unregister);
 
 int dsp_pipeline_module_init(void)
 {
-	elements_class = class_create(THIS_MODULE, "dsp_pipeline");
+	elements_class = class_create("dsp_pipeline");
 	if (IS_ERR(elements_class))
 		return PTR_ERR(elements_class);
 
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index a6b3adcd044a..9255bc11f99d 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -626,7 +626,7 @@ EXPORT_SYMBOL_GPL(devm_led_classdev_unregister);
 
 static int __init leds_init(void)
 {
-	leds_class = class_create(THIS_MODULE, "leds");
+	leds_class = class_create("leds");
 	if (IS_ERR(leds_class))
 		return PTR_ERR(leds_class);
 	leds_class->pm = &leds_class_dev_pm_ops;
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 23bd0c77ac1a..57e987cf84b2 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -888,7 +888,7 @@ adbdev_init(void)
 		return;
 	}
 
-	adb_dev_class = class_create(THIS_MODULE, "adb");
+	adb_dev_class = class_create("adb");
 	if (IS_ERR(adb_dev_class))
 		return;
 	device_create(adb_dev_class, NULL, MKDEV(ADB_MAJOR, 0), NULL, "adb");
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 0ed087caf7f3..e9b3ce09e534 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -1063,7 +1063,7 @@ static int __init init_dvbdev(void)
 		goto error;
 	}
 
-	dvb_class = class_create(THIS_MODULE, "dvb");
+	dvb_class = class_create("dvb");
 	if (IS_ERR(dvb_class)) {
 		retval = PTR_ERR(dvb_class);
 		goto error;
diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index 25ab61dae126..043d23aaa3cb 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -785,7 +785,7 @@ int __init lirc_dev_init(void)
 {
 	int retval;
 
-	lirc_class = class_create(THIS_MODULE, "lirc");
+	lirc_class = class_create("lirc");
 	if (IS_ERR(lirc_class)) {
 		pr_err("class_create failed\n");
 		return PTR_ERR(lirc_class);
diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
index fb9a1b49ff6d..f574c83b82cf 100644
--- a/drivers/misc/c2port/core.c
+++ b/drivers/misc/c2port/core.c
@@ -977,7 +977,7 @@ static int __init c2port_init(void)
 	printk(KERN_INFO "Silicon Labs C2 port support v. " DRIVER_VERSION
 		" - (C) 2007 Rodolfo Giometti\n");
 
-	c2port_class = class_create(THIS_MODULE, "c2port");
+	c2port_class = class_create("c2port");
 	if (IS_ERR(c2port_class)) {
 		printk(KERN_ERR "c2port: failed to allocate class\n");
 		return PTR_ERR(c2port_class);
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 5878329b011a..144d1f2d78ce 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -678,7 +678,7 @@ int __init cxl_file_init(void)
 
 	pr_devel("CXL device allocated, MAJOR %i\n", MAJOR(cxl_dev));
 
-	cxl_class = class_create(THIS_MODULE, "cxl");
+	cxl_class = class_create("cxl");
 	if (IS_ERR(cxl_class)) {
 		pr_err("Unable to create CXL class\n");
 		rc = PTR_ERR(cxl_class);
diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index 5b63d179b24e..02628288cd0f 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -1363,7 +1363,7 @@ static int __init genwqe_init_module(void)
 {
 	int rc;
 
-	class_genwqe = class_create(THIS_MODULE, GENWQE_DEVNAME);
+	class_genwqe = class_create(GENWQE_DEVNAME);
 	if (IS_ERR(class_genwqe)) {
 		pr_err("[%s] create class failed\n", __func__);
 		return -ENOMEM;
diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index 8d00df9243c4..2c3a991d6e88 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -888,7 +888,7 @@ static int __init ilo_init(void)
 	int error;
 	dev_t dev;
 
-	ilo_class = class_create(THIS_MODULE, "iLO");
+	ilo_class = class_create("iLO");
 	if (IS_ERR(ilo_class)) {
 		error = PTR_ERR(ilo_class);
 		goto out;
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 632d4ae21e46..76c771a424f7 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -1275,7 +1275,7 @@ static int __init mei_init(void)
 {
 	int ret;
 
-	mei_class = class_create(THIS_MODULE, "mei");
+	mei_class = class_create("mei");
 	if (IS_ERR(mei_class)) {
 		pr_err("couldn't create class\n");
 		ret = PTR_ERR(mei_class);
diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index 3b058654b45b..6e63f060e4cc 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -601,7 +601,7 @@ int ocxl_file_init(void)
 		return rc;
 	}
 
-	ocxl_class = class_create(THIS_MODULE, "ocxl");
+	ocxl_class = class_create("ocxl");
 	if (IS_ERR(ocxl_class)) {
 		pr_err("Unable to create ocxl class\n");
 		unregister_chrdev_region(ocxl_dev, OCXL_NUM_MINORS);
diff --git a/drivers/misc/phantom.c b/drivers/misc/phantom.c
index ce72e46a2e73..7966a6b8b5b3 100644
--- a/drivers/misc/phantom.c
+++ b/drivers/misc/phantom.c
@@ -503,7 +503,7 @@ static int __init phantom_init(void)
 	int retval;
 	dev_t dev;
 
-	phantom_class = class_create(THIS_MODULE, "phantom");
+	phantom_class = class_create("phantom");
 	if (IS_ERR(phantom_class)) {
 		retval = PTR_ERR(phantom_class);
 		printk(KERN_ERR "phantom: can't register phantom class\n");
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 07023397afc7..346bd7cf2e94 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -620,7 +620,7 @@ static int __init uacce_init(void)
 {
 	int ret;
 
-	uacce_class = class_create(THIS_MODULE, UACCE_NAME);
+	uacce_class = class_create(UACCE_NAME);
 	if (IS_ERR(uacce_class))
 		return PTR_ERR(uacce_class);
 
diff --git a/drivers/most/most_cdev.c b/drivers/most/most_cdev.c
index 4ee536980f71..3ed8f461e01e 100644
--- a/drivers/most/most_cdev.c
+++ b/drivers/most/most_cdev.c
@@ -491,7 +491,7 @@ static int __init most_cdev_init(void)
 {
 	int err;
 
-	comp.class = class_create(THIS_MODULE, "most_cdev");
+	comp.class = class_create("most_cdev");
 	if (IS_ERR(comp.class))
 		return PTR_ERR(comp.class);
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.c b/drivers/net/ethernet/hisilicon/hns/hnae.c
index 9b26f0f2c748..8a1027ad340d 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.c
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.c
@@ -448,7 +448,7 @@ EXPORT_SYMBOL(hnae_ae_unregister);
 
 static int __init hnae_init(void)
 {
-	hnae_class = class_create(THIS_MODULE, "hnae");
+	hnae_class = class_create("hnae");
 	return PTR_ERR_OR_ZERO(hnae_class);
 }
 
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 1d71f5276241..a9beacd552cf 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1394,7 +1394,7 @@ static int __init ppp_init(void)
 		goto out_net;
 	}
 
-	ppp_class = class_create(THIS_MODULE, "ppp");
+	ppp_class = class_create("ppp");
 	if (IS_ERR(ppp_class)) {
 		err = PTR_ERR(ppp_class);
 		goto out_chrdev;
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 4cc4eaf80b14..68a7e09a195e 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -5748,7 +5748,7 @@ static int __init init_mac80211_hwsim(void)
 	if (err)
 		goto out_exit_netlink;
 
-	hwsim_class = class_create(THIS_MODULE, "mac80211_hwsim");
+	hwsim_class = class_create("mac80211_hwsim");
 	if (IS_ERR(hwsim_class)) {
 		err = PTR_ERR(hwsim_class);
 		goto out_exit_virtio;
diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 966d0ccd2276..51bbd6bb74b5 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -1174,7 +1174,7 @@ static int __init wwan_init(void)
 	if (err)
 		return err;
 
-	wwan_class = class_create(THIS_MODULE, "wwan");
+	wwan_class = class_create("wwan");
 	if (IS_ERR(wwan_class)) {
 		err = PTR_ERR(wwan_class);
 		goto unregister;
diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.c
index 2397a903d8f5..edb5fc803211 100644
--- a/drivers/net/wwan/wwan_hwsim.c
+++ b/drivers/net/wwan/wwan_hwsim.c
@@ -511,7 +511,7 @@ static int __init wwan_hwsim_init(void)
 	if (!wwan_wq)
 		return -ENOMEM;
 
-	wwan_hwsim_class = class_create(THIS_MODULE, "wwan_hwsim");
+	wwan_hwsim_class = class_create("wwan_hwsim");
 	if (IS_ERR(wwan_hwsim_class)) {
 		err = PTR_ERR(wwan_hwsim_class);
 		goto err_wq_destroy;
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 4976a0069e9c..954dbc105fc8 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -1320,7 +1320,7 @@ int __init nvdimm_bus_init(void)
 		goto err_dimm_chrdev;
 	nvdimm_major = rc;
 
-	nd_class = class_create(THIS_MODULE, "nd");
+	nd_class = class_create("nd");
 	if (IS_ERR(nd_class)) {
 		rc = PTR_ERR(nd_class);
 		goto err_class;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2730b116dc6..877a61fbd78b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5381,14 +5381,14 @@ static int __init nvme_core_init(void)
 	if (result < 0)
 		goto destroy_delete_wq;
 
-	nvme_class = class_create(THIS_MODULE, "nvme");
+	nvme_class = class_create("nvme");
 	if (IS_ERR(nvme_class)) {
 		result = PTR_ERR(nvme_class);
 		goto unregister_chrdev;
 	}
 	nvme_class->dev_uevent = nvme_class_uevent;
 
-	nvme_subsys_class = class_create(THIS_MODULE, "nvme-subsystem");
+	nvme_subsys_class = class_create("nvme-subsystem");
 	if (IS_ERR(nvme_subsys_class)) {
 		result = PTR_ERR(nvme_subsys_class);
 		goto destroy_class;
@@ -5399,7 +5399,7 @@ static int __init nvme_core_init(void)
 	if (result < 0)
 		goto destroy_subsys_class;
 
-	nvme_ns_chr_class = class_create(THIS_MODULE, "nvme-generic");
+	nvme_ns_chr_class = class_create("nvme-generic");
 	if (IS_ERR(nvme_ns_chr_class)) {
 		result = PTR_ERR(nvme_ns_chr_class);
 		goto unregister_generic_ns;
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index bbaa04a0c502..0069ebff85df 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1254,7 +1254,7 @@ static int __init nvmf_init(void)
 	if (!nvmf_default_host)
 		return -ENOMEM;
 
-	nvmf_class = class_create(THIS_MODULE, "nvme-fabrics");
+	nvmf_class = class_create("nvme-fabrics");
 	if (IS_ERR(nvmf_class)) {
 		pr_err("couldn't register class nvme-fabrics\n");
 		ret = PTR_ERR(nvmf_class);
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 5c16372f3b53..af0d01797e5e 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1562,7 +1562,7 @@ static int __init fcloop_init(void)
 {
 	int ret;
 
-	fcloop_class = class_create(THIS_MODULE, "fcloop");
+	fcloop_class = class_create("fcloop");
 	if (IS_ERR(fcloop_class)) {
 		pr_err("couldn't register class fcloop\n");
 		ret = PTR_ERR(fcloop_class);
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 9440d9811eea..46c9a5c3ca14 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -860,7 +860,7 @@ EXPORT_SYMBOL_GPL(__devm_pci_epc_create);
 
 static int __init pci_epc_init(void)
 {
-	pci_epc_class = class_create(THIS_MODULE, "pci_epc");
+	pci_epc_class = class_create("pci_epc");
 	if (IS_ERR(pci_epc_class)) {
 		pr_err("failed to create pci epc class --> %ld\n",
 		       PTR_ERR(pci_epc_class));
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 3d6f17ff2429..d837da055921 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1804,7 +1804,7 @@ static int __init switchtec_init(void)
 	if (rc)
 		return rc;
 
-	switchtec_class = class_create(THIS_MODULE, "switchtec");
+	switchtec_class = class_create("switchtec");
 	if (IS_ERR(switchtec_class)) {
 		rc = PTR_ERR(switchtec_class);
 		goto err_create_class;
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 9951efc03eaa..6464dcb56d56 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -1233,7 +1233,7 @@ static void phy_release(struct device *dev)
 
 static int __init phy_core_init(void)
 {
-	phy_class = class_create(THIS_MODULE, "phy");
+	phy_class = class_create("phy");
 	if (IS_ERR(phy_class)) {
 		pr_err("failed to create phy class --> %ld\n",
 			PTR_ERR(phy_class));
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index f3d7c1da299f..1bf393239d40 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1462,7 +1462,7 @@ EXPORT_SYMBOL_GPL(power_supply_get_drvdata);
 
 static int __init power_supply_class_init(void)
 {
-	power_supply_class = class_create(THIS_MODULE, "power_supply");
+	power_supply_class = class_create("power_supply");
 
 	if (IS_ERR(power_supply_class))
 		return PTR_ERR(power_supply_class);
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 22a65ad4e46e..5d19baae6a38 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -456,7 +456,7 @@ static int __init pps_init(void)
 {
 	int err;
 
-	pps_class = class_create(THIS_MODULE, "pps");
+	pps_class = class_create("pps");
 	if (IS_ERR(pps_class)) {
 		pr_err("failed to allocate class\n");
 		return PTR_ERR(pps_class);
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 62d4d29e7c05..790f9250b381 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -460,7 +460,7 @@ static int __init ptp_init(void)
 {
 	int err;
 
-	ptp_class = class_create(THIS_MODULE, "ptp");
+	ptp_class = class_create("ptp");
 	if (IS_ERR(ptp_class)) {
 		pr_err("ptp: failed to allocate class\n");
 		return PTR_ERR(ptp_class);
diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 43db495f1986..deb96c3160a7 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -2603,7 +2603,7 @@ static int __init mport_init(void)
 	int ret;
 
 	/* Create device class needed by udev */
-	dev_class = class_create(THIS_MODULE, DRV_NAME);
+	dev_class = class_create(DRV_NAME);
 	if (IS_ERR(dev_class)) {
 		rmcd_error("Unable to create " DRV_NAME " class");
 		return PTR_ERR(dev_class);
diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index db4c265287ae..acaf9cda014c 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -2297,7 +2297,7 @@ static int __init riocm_init(void)
 	int ret;
 
 	/* Create device class needed by udev */
-	dev_class = class_create(THIS_MODULE, DRV_NAME);
+	dev_class = class_create(DRV_NAME);
 	if (IS_ERR(dev_class)) {
 		riocm_error("Cannot create " DRV_NAME " class");
 		return PTR_ERR(dev_class);
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index a2207c0cf432..5039df757127 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -694,7 +694,7 @@ static int __init rpmsg_init(void)
 {
 	int ret;
 
-	rpmsg_class = class_create(THIS_MODULE, "rpmsg");
+	rpmsg_class = class_create("rpmsg");
 	if (IS_ERR(rpmsg_class)) {
 		pr_err("failed to create rpmsg class\n");
 		return PTR_ERR(rpmsg_class);
diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index e5b7b48cffac..edfd942f8c54 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -475,7 +475,7 @@ EXPORT_SYMBOL_GPL(devm_rtc_device_register);
 
 static int __init rtc_init(void)
 {
-	rtc_class = class_create(THIS_MODULE, "rtc");
+	rtc_class = class_create("rtc");
 	if (IS_ERR(rtc_class)) {
 		pr_err("couldn't create class\n");
 		return PTR_ERR(rtc_class);
diff --git a/drivers/s390/char/hmcdrv_dev.c b/drivers/s390/char/hmcdrv_dev.c
index cb8fdf057eca..8d50c894711f 100644
--- a/drivers/s390/char/hmcdrv_dev.c
+++ b/drivers/s390/char/hmcdrv_dev.c
@@ -308,7 +308,7 @@ int hmcdrv_dev_init(void)
 	 * /proc/devices), but not under /dev nor /sys/devices/virtual. So
 	 * we have to create an associated class (see /sys/class).
 	 */
-	hmcdrv_dev_class = class_create(THIS_MODULE, HMCDRV_DEV_CLASS);
+	hmcdrv_dev_class = class_create(HMCDRV_DEV_CLASS);
 
 	if (IS_ERR(hmcdrv_dev_class)) {
 		rc = PTR_ERR(hmcdrv_dev_class);
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 09d7570d3b7d..7115c0f85650 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -1319,7 +1319,7 @@ static int raw3270_init(void)
 	if (rc == 0) {
 		/* Create attributes for early (= console) device. */
 		mutex_lock(&raw3270_mutex);
-		class3270 = class_create(THIS_MODULE, "3270");
+		class3270 = class_create("3270");
 		list_for_each_entry(rp, &raw3270_devices, list) {
 			get_device(&rp->cdev->dev);
 			raw3270_create_attributes(rp);
diff --git a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
index c21dc68e05a0..277a0f903d11 100644
--- a/drivers/s390/char/tape_class.c
+++ b/drivers/s390/char/tape_class.c
@@ -117,7 +117,7 @@ EXPORT_SYMBOL(unregister_tape_dev);
 
 static int __init tape_init(void)
 {
-	tape_class = class_create(THIS_MODULE, "tape390");
+	tape_class = class_create("tape390");
 
 	return 0;
 }
diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index ed970ecfafdf..6946ba9a9de2 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -699,7 +699,7 @@ static int vmlogrdr_register_driver(void)
 	if (ret)
 		goto out_iucv;
 
-	vmlogrdr_class = class_create(THIS_MODULE, "vmlogrdr");
+	vmlogrdr_class = class_create("vmlogrdr");
 	if (IS_ERR(vmlogrdr_class)) {
 		ret = PTR_ERR(vmlogrdr_class);
 		vmlogrdr_class = NULL;
diff --git a/drivers/s390/char/vmur.c b/drivers/s390/char/vmur.c
index 131293f7f152..82efdd20ad01 100644
--- a/drivers/s390/char/vmur.c
+++ b/drivers/s390/char/vmur.c
@@ -1022,7 +1022,7 @@ static int __init ur_init(void)
 
 	debug_set_level(vmur_dbf, 6);
 
-	vmur_class = class_create(THIS_MODULE, "vmur");
+	vmur_class = class_create("vmur");
 	if (IS_ERR(vmur_class)) {
 		rc = PTR_ERR(vmur_class);
 		goto fail_free_dbf;
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 6fe05bb82c77..582ac301d315 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -2171,7 +2171,7 @@ static int __init zcdn_init(void)
 	int rc;
 
 	/* create a new class 'zcrypt' */
-	zcrypt_class = class_create(THIS_MODULE, ZCRYPT_NAME);
+	zcrypt_class = class_create(ZCRYPT_NAME);
 	if (IS_ERR(zcrypt_class)) {
 		rc = PTR_ERR(zcrypt_class);
 		goto out_class_create_failed;
diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
index e300cf26bc2a..75701b165e91 100644
--- a/drivers/sbus/char/oradax.c
+++ b/drivers/sbus/char/oradax.c
@@ -323,7 +323,7 @@ static int __init dax_attach(void)
 		goto done;
 	}
 
-	cl = class_create(THIS_MODULE, DAX_NAME);
+	cl = class_create(DAX_NAME);
 	if (IS_ERR(cl)) {
 		dax_err("class_create failed");
 		ret = PTR_ERR(cl);
diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index 72fe6df78bc5..ac648bb8f7e7 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -995,7 +995,7 @@ static int __init init_ch_module(void)
 	int rc;
 
 	printk(KERN_INFO "SCSI Media Changer driver v" VERSION " \n");
-        ch_sysfs_class = class_create(THIS_MODULE, "scsi_changer");
+        ch_sysfs_class = class_create("scsi_changer");
         if (IS_ERR(ch_sysfs_class)) {
 		rc = PTR_ERR(ch_sysfs_class);
 		return rc;
diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 395b00b942f7..debd36974119 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -3880,7 +3880,7 @@ static int cxlflash_class_init(void)
 
 	cxlflash_major = MAJOR(devno);
 
-	cxlflash_class = class_create(THIS_MODULE, "cxlflash");
+	cxlflash_class = class_create("cxlflash");
 	if (IS_ERR(cxlflash_class)) {
 		rc = PTR_ERR(cxlflash_class);
 		pr_err("%s: class_create failed rc=%d\n", __func__, rc);
diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 836ddc476764..7d57cc92532c 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -5346,7 +5346,7 @@ static int __init pmcraid_init(void)
 	}
 
 	pmcraid_major = MAJOR(dev);
-	pmcraid_class = class_create(THIS_MODULE, PMCRAID_DEVFILE);
+	pmcraid_class = class_create(PMCRAID_DEVFILE);
 
 	if (IS_ERR(pmcraid_class)) {
 		error = PTR_ERR(pmcraid_class);
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index a91049213203..4997f880d4a4 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1677,7 +1677,7 @@ init_sg(void)
 				    SG_MAX_DEVS, "sg");
 	if (rc)
 		return rc;
-        sg_sysfs_class = class_create(THIS_MODULE, "scsi_generic");
+        sg_sysfs_class = class_create("scsi_generic");
         if ( IS_ERR(sg_sysfs_class) ) {
 		rc = PTR_ERR(sg_sysfs_class);
 		goto err_out;
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 5a038c667401..539e70c7daed 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -877,7 +877,7 @@ static int __init spidev_init(void)
 	if (status < 0)
 		return status;
 
-	spidev_class = class_create(THIS_MODULE, "spidev");
+	spidev_class = class_create("spidev");
 	if (IS_ERR(spidev_class)) {
 		unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
 		return PTR_ERR(spidev_class);
diff --git a/drivers/staging/fieldbus/anybuss/arcx-anybus.c b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
index 9af2e63050d1..369400ec30d8 100644
--- a/drivers/staging/fieldbus/anybuss/arcx-anybus.c
+++ b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
@@ -352,7 +352,7 @@ static int __init controller_init(void)
 {
 	int err;
 
-	controller_class = class_create(THIS_MODULE, "arcx_anybus_controller");
+	controller_class = class_create("arcx_anybus_controller");
 	if (IS_ERR(controller_class))
 		return PTR_ERR(controller_class);
 	err = platform_driver_register(&controller_driver);
diff --git a/drivers/staging/greybus/authentication.c b/drivers/staging/greybus/authentication.c
index 297e69f011c7..7e01790a4659 100644
--- a/drivers/staging/greybus/authentication.c
+++ b/drivers/staging/greybus/authentication.c
@@ -402,7 +402,7 @@ int cap_init(void)
 {
 	int ret;
 
-	cap_class = class_create(THIS_MODULE, "gb_authenticate");
+	cap_class = class_create("gb_authenticate");
 	if (IS_ERR(cap_class))
 		return PTR_ERR(cap_class);
 
diff --git a/drivers/staging/greybus/fw-management.c b/drivers/staging/greybus/fw-management.c
index 3342b84597da..cd9141e4b794 100644
--- a/drivers/staging/greybus/fw-management.c
+++ b/drivers/staging/greybus/fw-management.c
@@ -696,7 +696,7 @@ int fw_mgmt_init(void)
 {
 	int ret;
 
-	fw_mgmt_class = class_create(THIS_MODULE, "gb_fw_mgmt");
+	fw_mgmt_class = class_create("gb_fw_mgmt");
 	if (IS_ERR(fw_mgmt_class))
 		return PTR_ERR(fw_mgmt_class);
 
diff --git a/drivers/staging/greybus/raw.c b/drivers/staging/greybus/raw.c
index 2a375f407d38..8bca8cb12cc6 100644
--- a/drivers/staging/greybus/raw.c
+++ b/drivers/staging/greybus/raw.c
@@ -340,7 +340,7 @@ static int raw_init(void)
 	dev_t dev;
 	int retval;
 
-	raw_class = class_create(THIS_MODULE, "gb_raw");
+	raw_class = class_create("gb_raw");
 	if (IS_ERR(raw_class)) {
 		retval = PTR_ERR(raw_class);
 		goto error_class;
diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index b59f6a4cb611..f08fdf06d566 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1400,7 +1400,7 @@ static int __init pi433_init(void)
 	if (status < 0)
 		return status;
 
-	pi433_class = class_create(THIS_MODULE, "pi433");
+	pi433_class = class_create("pi433");
 	if (IS_ERR(pi433_class)) {
 		unregister_chrdev(MAJOR(pi433_dev),
 				  pi433_spi_driver.driver.name);
diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
index 4e533c0bfe6d..b9367b575d00 100644
--- a/drivers/staging/vme_user/vme_user.c
+++ b/drivers/staging/vme_user/vme_user.c
@@ -614,7 +614,7 @@ static int vme_user_probe(struct vme_dev *vdev)
 	}
 
 	/* Create sysfs entries - on udev systems this creates the dev files */
-	vme_user_sysfs_class = class_create(THIS_MODULE, driver_name);
+	vme_user_sysfs_class = class_create(driver_name);
 	if (IS_ERR(vme_user_sysfs_class)) {
 		dev_err(&vdev->dev, "Error creating vme_user class.\n");
 		err = PTR_ERR(vme_user_sysfs_class);
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 452cbb8ad484..0eb342de0b00 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1226,7 +1226,7 @@ static int __init tee_init(void)
 {
 	int rc;
 
-	tee_class = class_create(THIS_MODULE, "tee");
+	tee_class = class_create("tee");
 	if (IS_ERR(tee_class)) {
 		pr_err("couldn't create class\n");
 		return PTR_ERR(tee_class);
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 36fb945fdad4..1382d9050ce8 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3512,7 +3512,7 @@ static char *tty_devnode(const struct device *dev, umode_t *mode)
 
 static int __init tty_class_init(void)
 {
-	tty_class = class_create(THIS_MODULE, "tty");
+	tty_class = class_create("tty");
 	if (IS_ERR(tty_class))
 		return PTR_ERR(tty_class);
 	tty_class->devnode = tty_devnode;
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 1dc07f9214d5..498ba9c0ee93 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -804,7 +804,7 @@ int __init vcs_init(void)
 
 	if (register_chrdev(VCS_MAJOR, "vcs", &vcs_fops))
 		panic("unable to get major %d for vcs device", VCS_MAJOR);
-	vc_class = class_create(THIS_MODULE, "vc");
+	vc_class = class_create("vc");
 
 	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 0), NULL, "vcs");
 	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 64), NULL, "vcsu");
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 57a5c23b51d4..5496bf4b76ec 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4241,7 +4241,7 @@ static int __init vtconsole_class_init(void)
 {
 	int i;
 
-	vtconsole_class = class_create(THIS_MODULE, "vtconsole");
+	vtconsole_class = class_create("vtconsole");
 	if (IS_ERR(vtconsole_class)) {
 		pr_warn("Unable to create vt console class; errno = %ld\n",
 			PTR_ERR(vtconsole_class));
diff --git a/drivers/usb/core/file.c b/drivers/usb/core/file.c
index da7d88e069e6..c4ed3310e069 100644
--- a/drivers/usb/core/file.c
+++ b/drivers/usb/core/file.c
@@ -88,7 +88,7 @@ static int init_usb_class(void)
 	}
 
 	kref_init(&usb_class->kref);
-	usb_class->class = class_create(THIS_MODULE, "usbmisc");
+	usb_class->class = class_create("usbmisc");
 	if (IS_ERR(usb_class->class)) {
 		result = PTR_ERR(usb_class->class);
 		printk(KERN_ERR "class_create failed for usb devices\n");
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index a8da3b4a2855..9f6b10134121 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1325,7 +1325,7 @@ int ghid_setup(struct usb_gadget *g, int count)
 	int status;
 	dev_t dev;
 
-	hidg_class = class_create(THIS_MODULE, "hidg");
+	hidg_class = class_create("hidg");
 	if (IS_ERR(hidg_class)) {
 		status = PTR_ERR(hidg_class);
 		hidg_class = NULL;
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 4903d761a872..28db3e336e7d 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -1512,7 +1512,7 @@ static int gprinter_setup(int count)
 	int status;
 	dev_t devt;
 
-	usb_gadget_class = class_create(THIS_MODULE, "usb_printer_gadget");
+	usb_gadget_class = class_create("usb_printer_gadget");
 	if (IS_ERR(usb_gadget_class)) {
 		status = PTR_ERR(usb_gadget_class);
 		usb_gadget_class = NULL;
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 23b0629a8774..df930b041c33 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1758,7 +1758,7 @@ static int __init usb_udc_init(void)
 {
 	int rc;
 
-	udc_class = class_create(THIS_MODULE, "udc");
+	udc_class = class_create("udc");
 	if (IS_ERR(udc_class)) {
 		pr_err("failed to create udc class --> %ld\n",
 				PTR_ERR(udc_class));
diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index abb1cd35d8a6..952c56789258 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -1379,7 +1379,7 @@ int __init mon_bin_init(void)
 {
 	int rc;
 
-	mon_bin_class = class_create(THIS_MODULE, "usbmon");
+	mon_bin_class = class_create("usbmon");
 	if (IS_ERR(mon_bin_class)) {
 		rc = PTR_ERR(mon_bin_class);
 		goto err_class;
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 56814ef80c24..0395bd5dbd3e 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -392,7 +392,7 @@ EXPORT_SYMBOL_GPL(usb_role_switch_get_drvdata);
 
 static int __init usb_roles_init(void)
 {
-	role_class = class_create(THIS_MODULE, "usb_role");
+	role_class = class_create("usb_role");
 	return PTR_ERR_OR_ZERO(role_class);
 }
 subsys_initcall(usb_roles_init);
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0c3b48616a9f..c421b83f6fa2 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1793,7 +1793,7 @@ static int vduse_init(void)
 	int ret;
 	struct device *dev;
 
-	vduse_class = class_create(THIS_MODULE, "vduse");
+	vduse_class = class_create("vduse");
 	if (IS_ERR(vduse_class))
 		return PTR_ERR(vduse_class);
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 27d5ba7cf9dc..fc75c1000d74 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -878,7 +878,7 @@ int __init vfio_group_init(void)
 		return ret;
 
 	/* /dev/vfio/$GROUP */
-	vfio.class = class_create(THIS_MODULE, "vfio");
+	vfio.class = class_create("vfio");
 	if (IS_ERR(vfio.class)) {
 		ret = PTR_ERR(vfio.class);
 		goto err_group_class;
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 43bd6b76e2b6..9ae671b98592 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1408,7 +1408,7 @@ static int __init vfio_init(void)
 		goto err_virqfd;
 
 	/* /sys/class/vfio-dev/vfioX */
-	vfio.device_class = class_create(THIS_MODULE, "vfio-dev");
+	vfio.device_class = class_create("vfio-dev");
 	if (IS_ERR(vfio.device_class)) {
 		ret = PTR_ERR(vfio.device_class);
 		goto err_dev_class;
diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 6eea72aa8dbf..9a885d398c22 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -751,7 +751,7 @@ static void __exit backlight_class_exit(void)
 
 static int __init backlight_class_init(void)
 {
-	backlight_class = class_create(THIS_MODULE, "backlight");
+	backlight_class = class_create("backlight");
 	if (IS_ERR(backlight_class)) {
 		pr_warn("Unable to create backlight class; errno = %ld\n",
 			PTR_ERR(backlight_class));
diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index db56e465aaff..77c5cb2a44e2 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -323,7 +323,7 @@ static void __exit lcd_class_exit(void)
 
 static int __init lcd_class_init(void)
 {
-	lcd_class = class_create(THIS_MODULE, "lcd");
+	lcd_class = class_create("lcd");
 	if (IS_ERR(lcd_class)) {
 		pr_warn("Unable to create backlight class; errno = %ld\n",
 			PTR_ERR(lcd_class));
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 875541ff185b..b073795d99d0 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1749,7 +1749,7 @@ fbmem_init(void)
 		goto err_chrdev;
 	}
 
-	fb_class = class_create(THIS_MODULE, "graphics");
+	fb_class = class_create("graphics");
 	if (IS_ERR(fb_class)) {
 		ret = PTR_ERR(fb_class);
 		pr_warn("Unable to create fb class; errno = %d\n", ret);
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index b39580ad4ce5..3c3148588491 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -361,7 +361,7 @@ static int __init init_coda_psdev(void)
 		       __func__, CODA_PSDEV_MAJOR);
 		return -EIO;
 	}
-	coda_psdev_class = class_create(THIS_MODULE, "coda");
+	coda_psdev_class = class_create("coda");
 	if (IS_ERR(coda_psdev_class)) {
 		err = PTR_ERR(coda_psdev_class);
 		goto out_chrdev;
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 179a5c5e28fd..91e89e68177e 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -623,7 +623,7 @@ static int __init cuse_init(void)
 	/* CUSE is not prepared for FUSE_DEV_IOC_CLONE */
 	cuse_channel_fops.unlocked_ioctl	= NULL;
 
-	cuse_class = class_create(THIS_MODULE, "cuse");
+	cuse_class = class_create("cuse");
 	if (IS_ERR(cuse_class))
 		return PTR_ERR(cuse_class);
 
diff --git a/fs/pstore/pmsg.c b/fs/pstore/pmsg.c
index ab82e5f05346..aa178304bc03 100644
--- a/fs/pstore/pmsg.c
+++ b/fs/pstore/pmsg.c
@@ -64,7 +64,7 @@ void pstore_register_pmsg(void)
 		goto err;
 	}
 
-	pmsg_class = class_create(THIS_MODULE, PMSG_NAME);
+	pmsg_class = class_create(PMSG_NAME);
 	if (IS_ERR(pmsg_class)) {
 		pr_err("device class file already in use\n");
 		goto err_class;
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index bf736f14f0c1..cda598fc5fa0 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -256,7 +256,6 @@ extern void class_destroy(struct class *cls);
 
 /**
  * class_create - create a struct class structure
- * @owner: dummy pointer, does nothing, will be removed soon.
  * @name: pointer to a string for the name of this class.
  *
  * This is used to create a struct class pointer that can then be used
@@ -267,7 +266,7 @@ extern void class_destroy(struct class *cls);
  * Note, the pointer created here is to be destroyed when finished by
  * making a call to class_destroy().
  */
-#define class_create(owner, name)		\
+#define class_create(name)			\
 ({						\
 	static struct lock_class_key __key;	\
 	__class_create(name, &__key);		\
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index a53b9360b72e..ad011308cebe 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -347,7 +347,7 @@ ATTRIBUTE_GROUPS(bdi_dev);
 
 static __init int bdi_class_init(void)
 {
-	bdi_class = class_create(THIS_MODULE, "bdi");
+	bdi_class = class_create("bdi");
 	if (IS_ERR(bdi_class))
 		return PTR_ERR(bdi_class);
 
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 08542dfc2dc5..2934d7f4d564 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -112,7 +112,7 @@ void hci_init_sysfs(struct hci_dev *hdev)
 
 int __init bt_sysfs_init(void)
 {
-	bt_class = class_create(THIS_MODULE, "bluetooth");
+	bt_class = class_create("bluetooth");
 
 	return PTR_ERR_OR_ZERO(bt_class);
 }
diff --git a/net/netfilter/xt_IDLETIMER.c b/net/netfilter/xt_IDLETIMER.c
index 8d36303f3935..db720efa811d 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -490,7 +490,7 @@ static int __init idletimer_tg_init(void)
 {
 	int err;
 
-	idletimer_tg_class = class_create(THIS_MODULE, "xt_idletimer");
+	idletimer_tg_class = class_create("xt_idletimer");
 	err = PTR_ERR(idletimer_tg_class);
 	if (IS_ERR(idletimer_tg_class)) {
 		pr_debug("couldn't register device class\n");
diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index e54eb752e1ba..a3d3249639d0 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -1418,7 +1418,7 @@ static int __init mbochs_dev_init(void)
 	if (ret)
 		goto err_cdev;
 
-	mbochs_class = class_create(THIS_MODULE, MBOCHS_CLASS_NAME);
+	mbochs_class = class_create(MBOCHS_CLASS_NAME);
 	if (IS_ERR(mbochs_class)) {
 		pr_err("Error: failed to register mbochs_dev class\n");
 		ret = PTR_ERR(mbochs_class);
diff --git a/samples/vfio-mdev/mdpy.c b/samples/vfio-mdev/mdpy.c
index e8400fdab71d..ef1630fc5a91 100644
--- a/samples/vfio-mdev/mdpy.c
+++ b/samples/vfio-mdev/mdpy.c
@@ -705,7 +705,7 @@ static int __init mdpy_dev_init(void)
 	if (ret)
 		goto err_cdev;
 
-	mdpy_class = class_create(THIS_MODULE, MDPY_CLASS_NAME);
+	mdpy_class = class_create(MDPY_CLASS_NAME);
 	if (IS_ERR(mdpy_class)) {
 		pr_err("Error: failed to register mdpy_dev class\n");
 		ret = PTR_ERR(mdpy_class);
diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
index e887de672c52..0b6c386e620d 100644
--- a/samples/vfio-mdev/mtty.c
+++ b/samples/vfio-mdev/mtty.c
@@ -1316,7 +1316,7 @@ static int __init mtty_dev_init(void)
 	if (ret)
 		goto err_cdev;
 
-	mtty_dev.vd_class = class_create(THIS_MODULE, MTTY_CLASS_NAME);
+	mtty_dev.vd_class = class_create(MTTY_CLASS_NAME);
 
 	if (IS_ERR(mtty_dev.vd_class)) {
 		pr_err("Error: failed to register mtty_dev class\n");
diff --git a/sound/sound_core.c b/sound/sound_core.c
index 3e7dd6fcb7cf..4f6911274d56 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -45,7 +45,7 @@ static int __init init_soundcore(void)
 	if (rc)
 		return rc;
 
-	sound_class = class_create(THIS_MODULE, "sound");
+	sound_class = class_create("sound");
 	if (IS_ERR(sound_class)) {
 		cleanup_oss_soundcore();
 		return PTR_ERR(sound_class);
diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 01ceb98c15a0..3eba10c1e3e8 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -921,7 +921,7 @@ static __init int ndtest_init(void)
 
 	nfit_test_setup(ndtest_resource_lookup, NULL);
 
-	ndtest_dimm_class = class_create(THIS_MODULE, "nfit_test_dimm");
+	ndtest_dimm_class = class_create("nfit_test_dimm");
 	if (IS_ERR(ndtest_dimm_class)) {
 		rc = PTR_ERR(ndtest_dimm_class);
 		goto err_register;
diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index c75abb497a1a..45b1c072e349 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -3282,7 +3282,7 @@ static __init int nfit_test_init(void)
 	if (!nfit_wq)
 		return -ENOMEM;
 
-	nfit_test_dimm = class_create(THIS_MODULE, "nfit_test_dimm");
+	nfit_test_dimm = class_create("nfit_test_dimm");
 	if (IS_ERR(nfit_test_dimm)) {
 		rc = PTR_ERR(nfit_test_dimm);
 		goto err_register;
-- 
2.39.2

