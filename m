Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D9F665A34
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjAKLbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjAKLbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:31:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560E02DD6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:30:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A883BB81BAC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1B2C433F2;
        Wed, 11 Jan 2023 11:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673436654;
        bh=mu40IxMVys50I0/6KPva+nmYVDWIWyHFe3QS+j23eUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/atS/QMoFwWv/9OvcPxYo4p0MLKktpz2E7P7qvNIGc3OjVfqfx6f0zQVj2NFCydH
         dX+CfOS9bB8f8xbgwx9DNRYj5IcO3+526BO8LjY4r5BD7s9vUhCOx8h+egvizHUNAy
         t/pW52gTNrlbE4S535EyEKhSbTdhzs20fReB+ALU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 15/16] driver core: make struct bus_type.uevent() take a const *
Date:   Wed, 11 Jan 2023 12:30:17 +0100
Message-Id: <20230111113018.459199-16-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111113018.459199-1-gregkh@linuxfoundation.org>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=57412; i=gregkh@linuxfoundation.org; h=from:subject; bh=mu40IxMVys50I0/6KPva+nmYVDWIWyHFe3QS+j23eUg=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn75p7qcC+SbtJ/ceeEac8zH/MTu1UjOzm5Zk7L/aRqUqB0 ZUZERywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEykXZdhQZO51cyIaPZvjy+eMjPyje 2+ljtBjmFBW9rqp/bX+T7LnCi96NB4+A7L9ohLAA==
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

The uevent() callback in struct bus_type should not be modifying the
device that is passed into it, so mark it as a const * and propagate the
function signature changes out into all relevant subsystems that use
this callback.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/sgi-ip22/ip22-gio.c              |  4 ++--
 arch/parisc/kernel/drivers.c               |  4 ++--
 arch/powerpc/platforms/pseries/vio.c       |  4 ++--
 arch/sparc/kernel/vio.c                    |  2 +-
 drivers/acpi/bus.c                         |  2 +-
 drivers/amba/bus.c                         |  4 ++--
 drivers/base/auxiliary.c                   |  2 +-
 drivers/base/cpu.c                         |  2 +-
 drivers/base/platform.c                    |  4 ++--
 drivers/bcma/main.c                        |  6 +++---
 drivers/bus/fsl-mc/fsl-mc-bus.c            |  4 ++--
 drivers/bus/mhi/ep/main.c                  |  4 ++--
 drivers/bus/mhi/host/init.c                |  4 ++--
 drivers/bus/mips_cdmm.c                    |  4 ++--
 drivers/bus/sunxi-rsb.c                    |  2 +-
 drivers/cxl/core/memdev.c                  |  2 +-
 drivers/cxl/core/port.c                    |  8 ++++----
 drivers/cxl/cxl.h                          |  4 ++--
 drivers/cxl/cxlmem.h                       |  2 +-
 drivers/dax/bus.c                          |  2 +-
 drivers/eisa/eisa-bus.c                    |  4 ++--
 drivers/firmware/arm_ffa/bus.c             |  4 ++--
 drivers/fpga/dfl.c                         |  4 ++--
 drivers/gpu/drm/drm_mipi_dsi.c             |  4 ++--
 drivers/gpu/host1x/bus.c                   |  2 +-
 drivers/greybus/core.c                     | 14 +++++++-------
 drivers/hid/hid-core.c                     |  4 ++--
 drivers/hid/intel-ish-hid/ishtp/bus.c      |  2 +-
 drivers/hsi/hsi_core.c                     |  2 +-
 drivers/hv/vmbus_drv.c                     |  4 ++--
 drivers/input/serio/serio.c                |  4 ++--
 drivers/ipack/ipack.c                      |  4 ++--
 drivers/macintosh/macio_asic.c             |  2 +-
 drivers/mcb/mcb-core.c                     |  4 ++--
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
 drivers/pci/pci-driver.c                   |  4 ++--
 drivers/pcmcia/ds.c                        |  4 ++--
 drivers/platform/x86/wmi.c                 |  4 ++--
 drivers/rapidio/rio-driver.c               |  4 ++--
 drivers/rpmsg/rpmsg_core.c                 |  4 ++--
 drivers/s390/cio/css.c                     |  4 ++--
 drivers/s390/cio/device.c                  |  8 ++++----
 drivers/s390/cio/scm.c                     |  2 +-
 drivers/s390/crypto/ap_bus.c               |  4 ++--
 drivers/scsi/scsi_sysfs.c                  |  4 ++--
 drivers/slimbus/core.c                     |  4 ++--
 drivers/soc/qcom/apr.c                     |  4 ++--
 drivers/spi/spi.c                          |  2 +-
 drivers/spmi/spmi.c                        |  2 +-
 drivers/ssb/main.c                         |  4 ++--
 drivers/staging/greybus/gbphy.c            | 14 +++++++-------
 drivers/tee/tee_core.c                     |  2 +-
 drivers/usb/common/ulpi.c                  |  4 ++--
 drivers/usb/core/driver.c                  |  6 +++---
 drivers/usb/typec/bus.c                    |  4 ++--
 drivers/virtio/virtio.c                    |  4 ++--
 drivers/w1/w1.c                            | 10 +++++-----
 drivers/xen/pvcalls-back.c                 |  2 +-
 drivers/xen/xenbus/xenbus_probe_backend.c  |  8 ++++----
 drivers/xen/xenbus/xenbus_probe_frontend.c |  4 ++--
 drivers/zorro/zorro-driver.c               |  4 ++--
 include/linux/device/bus.h                 |  2 +-
 include/linux/spi/spi.h                    |  2 +-
 include/linux/ssb/ssb.h                    |  2 +-
 include/sound/hdaudio.h                    |  2 +-
 include/xen/xenbus.h                       |  2 +-
 sound/aoa/soundbus/core.c                  |  6 +++---
 sound/hda/hda_bus_type.c                   |  2 +-
 sound/hda/hdac_device.c                    |  2 +-
 81 files changed, 160 insertions(+), 160 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index 8686e8c1c4e5..81c9f0a8880b 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -199,9 +199,9 @@ static struct attribute *gio_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(gio_dev);
 
-static int gio_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int gio_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct gio_device *gio_dev = to_gio_device(dev);
+	const struct gio_device *gio_dev = to_gio_device(dev);
 
 	add_uevent_var(env, "MODALIAS=gio:%x", gio_dev->id.id);
 	return 0;
diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index e7ee0c0c91d3..28f47285d448 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -552,7 +552,7 @@ static int parisc_generic_match(struct device *dev, struct device_driver *drv)
 	return match_device(to_parisc_driver(drv), to_parisc_device(dev));
 }
 
-static ssize_t make_modalias(struct device *dev, char *buf)
+static ssize_t make_modalias(const struct device *dev, char *buf)
 {
 	const struct parisc_device *padev = to_parisc_device(dev);
 	const struct parisc_device_id *id = &padev->id;
@@ -562,7 +562,7 @@ static ssize_t make_modalias(struct device *dev, char *buf)
 		(u32)id->sversion);
 }
 
-static int parisc_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int parisc_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	const struct parisc_device *padev;
 	char modalias[40];
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 00ecac2c205b..770df9351aaa 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -1609,10 +1609,10 @@ static int vio_bus_match(struct device *dev, struct device_driver *drv)
 	return (ids != NULL) && (vio_match_device(ids, vio_dev) != NULL);
 }
 
-static int vio_hotplug(struct device *dev, struct kobj_uevent_env *env)
+static int vio_hotplug(const struct device *dev, struct kobj_uevent_env *env)
 {
 	const struct vio_dev *vio_dev = to_vio_dev(dev);
-	struct device_node *dn;
+	const struct device_node *dn;
 	const char *cp;
 
 	dn = dev->of_node;
diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 01122a208f94..b78df3a15a72 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -46,7 +46,7 @@ static const struct vio_device_id *vio_match_device(
 	return NULL;
 }
 
-static int vio_hotplug(struct device *dev, struct kobj_uevent_env *env)
+static int vio_hotplug(const struct device *dev, struct kobj_uevent_env *env)
 {
 	const struct vio_dev *vio_dev = to_vio_dev(dev);
 
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 0c05ccde1f7a..9531dd0fef50 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1014,7 +1014,7 @@ static int acpi_bus_match(struct device *dev, struct device_driver *drv)
 		&& !acpi_match_device_ids(acpi_dev, acpi_drv->ids);
 }
 
-static int acpi_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int acpi_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	return __acpi_device_uevent_modalias(to_acpi_device(dev), env);
 }
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index ff7454a38058..ce88af9eb562 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -235,9 +235,9 @@ static int amba_match(struct device *dev, struct device_driver *drv)
 	return amba_lookup(pcdrv->id_table, pcdev) != NULL;
 }
 
-static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int amba_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct amba_device *pcdev = to_amba_device(dev);
+	const struct amba_device *pcdev = to_amba_device(dev);
 	int retval = 0;
 
 	retval = add_uevent_var(env, "AMBA_ID=%08x", pcdev->periphid);
diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 8c5e65930617..4d4c2c8d26c4 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -185,7 +185,7 @@ static int auxiliary_match(struct device *dev, struct device_driver *drv)
 	return !!auxiliary_match_id(auxdrv->id_table, auxdev);
 }
 
-static int auxiliary_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int auxiliary_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	const char *name, *p;
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c98849577d4..441eb5bdec7d 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -336,7 +336,7 @@ static ssize_t print_cpu_modalias(struct device *dev,
 	return len;
 }
 
-static int cpu_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int cpu_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	char *buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (buf) {
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 968f3d71eeab..d7605e048bd2 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1353,9 +1353,9 @@ static int platform_match(struct device *dev, struct device_driver *drv)
 	return (strcmp(pdev->name, drv->name) == 0);
 }
 
-static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int platform_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
+	const struct platform_device *pdev = to_platform_device(dev);
 	int rc;
 
 	/* Some devices have extra OF data and an OF-style MODALIAS */
diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 0a8469e0b13a..7b39f010bbb3 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -28,7 +28,7 @@ static DEFINE_MUTEX(bcma_buses_mutex);
 static int bcma_bus_match(struct device *dev, struct device_driver *drv);
 static int bcma_device_probe(struct device *dev);
 static void bcma_device_remove(struct device *dev);
-static int bcma_device_uevent(struct device *dev, struct kobj_uevent_env *env);
+static int bcma_device_uevent(const struct device *dev, struct kobj_uevent_env *env);
 
 static ssize_t manuf_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -627,9 +627,9 @@ static void bcma_device_remove(struct device *dev)
 	put_device(dev);
 }
 
-static int bcma_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int bcma_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct bcma_device *core = container_of(dev, struct bcma_device, dev);
+	const struct bcma_device *core = container_of_const(dev, struct bcma_device, dev);
 
 	return add_uevent_var(env,
 			      "MODALIAS=bcma:m%04Xid%04Xrev%02Xcl%02X",
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 774f307844b4..36cb091a33b4 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -124,9 +124,9 @@ static int fsl_mc_bus_match(struct device *dev, struct device_driver *drv)
 /*
  * fsl_mc_bus_uevent - callback invoked when a device is added
  */
-static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int fsl_mc_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	const struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
 	if (add_uevent_var(env, "MODALIAS=fsl-mc:v%08Xd%s",
 			   mc_dev->obj_desc.vendor,
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 1dc8a3557a46..4819369faa8b 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -1543,9 +1543,9 @@ void mhi_ep_driver_unregister(struct mhi_ep_driver *mhi_drv)
 }
 EXPORT_SYMBOL_GPL(mhi_ep_driver_unregister);
 
-static int mhi_ep_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int mhi_ep_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
+	const struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);
 
 	return add_uevent_var(env, "MODALIAS=" MHI_EP_DEVICE_MODALIAS_FMT,
 					mhi_dev->name);
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index bf672de35131..770fc81b7e96 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -1395,9 +1395,9 @@ void mhi_driver_unregister(struct mhi_driver *mhi_drv)
 }
 EXPORT_SYMBOL_GPL(mhi_driver_unregister);
 
-static int mhi_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int mhi_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	const struct mhi_device *mhi_dev = to_mhi_device(dev);
 
 	return add_uevent_var(env, "MODALIAS=" MHI_DEVICE_MODALIAS_FMT,
 					mhi_dev->name);
diff --git a/drivers/bus/mips_cdmm.c b/drivers/bus/mips_cdmm.c
index fca0d0669aa9..554e1992edd4 100644
--- a/drivers/bus/mips_cdmm.c
+++ b/drivers/bus/mips_cdmm.c
@@ -67,9 +67,9 @@ static int mips_cdmm_match(struct device *dev, struct device_driver *drv)
 	return mips_cdmm_lookup(cdrv->id_table, cdev) != NULL;
 }
 
-static int mips_cdmm_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int mips_cdmm_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct mips_cdmm_device *cdev = to_mips_cdmm_device(dev);
+	const struct mips_cdmm_device *cdev = to_mips_cdmm_device(dev);
 	int retval = 0;
 
 	retval = add_uevent_var(env, "CDMM_CPU=%u", cdev->cpu);
diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index a180af11e034..9aa99c369e48 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -172,7 +172,7 @@ static void sunxi_rsb_device_remove(struct device *dev)
 	drv->remove(to_sunxi_rsb_device(dev));
 }
 
-static int sunxi_rsb_device_modalias(struct device *dev, struct kobj_uevent_env *env)
+static int sunxi_rsb_device_modalias(const struct device *dev, struct kobj_uevent_env *env)
 {
 	return of_device_uevent_modalias(dev, env);
 }
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a38a0cc20d47..b75dd77df7ce 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -162,7 +162,7 @@ static const struct device_type cxl_memdev_type = {
 	.groups = cxl_memdev_attribute_groups,
 };
 
-bool is_cxl_memdev(struct device *dev)
+bool is_cxl_memdev(const struct device *dev)
 {
 	return dev->type == &cxl_memdev_type;
 }
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b631a0520456..3f02dc135a12 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -38,7 +38,7 @@ static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(devtype);
 
-static int cxl_device_id(struct device *dev)
+static int cxl_device_id(const struct device *dev)
 {
 	if (dev->type == &cxl_nvdimm_bridge_type)
 		return CXL_DEVICE_NVDIMM_BRIDGE;
@@ -523,13 +523,13 @@ static const struct device_type cxl_port_type = {
 	.groups = cxl_port_attribute_groups,
 };
 
-bool is_cxl_port(struct device *dev)
+bool is_cxl_port(const struct device *dev)
 {
 	return dev->type == &cxl_port_type;
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_port, CXL);
 
-struct cxl_port *to_cxl_port(struct device *dev)
+struct cxl_port *to_cxl_port(const struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, dev->type != &cxl_port_type,
 			  "not a cxl_port device\n"))
@@ -1826,7 +1826,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_driver_unregister, CXL);
 
-static int cxl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int cxl_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	return add_uevent_var(env, "MODALIAS=" CXL_MODALIAS_FMT,
 			      cxl_device_id(dev));
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1b1cf459ac77..c9e1b48a1a53 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -588,8 +588,8 @@ static inline bool is_cxl_root(struct cxl_port *port)
 	return port->uport == port->dev.parent;
 }
 
-bool is_cxl_port(struct device *dev);
-struct cxl_port *to_cxl_port(struct device *dev);
+bool is_cxl_port(const struct device *dev);
+struct cxl_port *to_cxl_port(const struct device *dev);
 struct pci_bus;
 int devm_cxl_register_pci_bus(struct device *host, struct device *uport,
 			      struct pci_bus *bus);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ab138004f644..6749f2afb1b7 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -72,7 +72,7 @@ cxled_to_memdev(struct cxl_endpoint_decoder *cxled)
 	return to_cxl_memdev(port->uport);
 }
 
-bool is_cxl_memdev(struct device *dev);
+bool is_cxl_memdev(const struct device *dev);
 static inline bool is_cxl_endpoint(struct cxl_port *port)
 {
 	return is_cxl_memdev(port->uport);
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 1dad813ee4a6..e3a384182fe7 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -18,7 +18,7 @@ struct dax_id {
 	char dev_name[DAX_NAME_LEN];
 };
 
-static int dax_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int dax_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	/*
 	 * We only ever expect to handle device-dax instances, i.e. the
diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
index 65bffde137e3..713582cc27d1 100644
--- a/drivers/eisa/eisa-bus.c
+++ b/drivers/eisa/eisa-bus.c
@@ -127,9 +127,9 @@ static int eisa_bus_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
-static int eisa_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int eisa_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct eisa_device *edev = to_eisa_device(dev);
+	const struct eisa_device *edev = to_eisa_device(dev);
 
 	add_uevent_var(env, "MODALIAS=" EISA_DEVICE_MODALIAS_FMT, edev->id.sig);
 	return 0;
diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 99d439480612..f29d77ecf72d 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -56,9 +56,9 @@ static void ffa_device_remove(struct device *dev)
 	ffa_drv->remove(to_ffa_dev(dev));
 }
 
-static int ffa_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int ffa_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct ffa_device *ffa_dev = to_ffa_dev(dev);
+	const struct ffa_device *ffa_dev = to_ffa_dev(dev);
 
 	return add_uevent_var(env, "MODALIAS=arm_ffa:%04x:%pUb",
 			      ffa_dev->vm_id, &ffa_dev->uuid);
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index b9aae85ba930..4d32c98c82fc 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -293,9 +293,9 @@ static void dfl_bus_remove(struct device *dev)
 		ddrv->remove(ddev);
 }
 
-static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int dfl_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct dfl_device *ddev = to_dfl_dev(dev);
+	const struct dfl_device *ddev = to_dfl_dev(dev);
 
 	return add_uevent_var(env, "MODALIAS=dfl:t%04Xf%04X",
 			      ddev->type, ddev->feature_id);
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 497ef4b6a90a..36c24c2b0899 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -62,9 +62,9 @@ static int mipi_dsi_device_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
-static int mipi_dsi_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int mipi_dsi_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
+	const struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
 	int err;
 
 	err = of_device_uevent_modalias(dev, env);
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index bdee16a0bb8e..bc7271a00a94 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -338,7 +338,7 @@ static int host1x_device_match(struct device *dev, struct device_driver *drv)
 	return strcmp(dev_name(dev), drv->name) == 0;
 }
 
-static int host1x_device_uevent(struct device *dev,
+static int host1x_device_uevent(const struct device *dev,
 				struct kobj_uevent_env *env)
 {
 	struct device_node *np = dev->parent->of_node;
diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
index e546c6431877..5714be740470 100644
--- a/drivers/greybus/core.c
+++ b/drivers/greybus/core.c
@@ -78,14 +78,14 @@ static int greybus_match_device(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
-static int greybus_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int greybus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct gb_host_device *hd;
-	struct gb_module *module = NULL;
-	struct gb_interface *intf = NULL;
-	struct gb_control *control = NULL;
-	struct gb_bundle *bundle = NULL;
-	struct gb_svc *svc = NULL;
+	const struct gb_host_device *hd;
+	const struct gb_module *module = NULL;
+	const struct gb_interface *intf = NULL;
+	const struct gb_control *control = NULL;
+	const struct gb_bundle *bundle = NULL;
+	const struct gb_svc *svc = NULL;
 
 	if (is_gb_host_device(dev)) {
 		hd = to_gb_host_device(dev);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bd47628da6be..298a5ca349b1 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2664,9 +2664,9 @@ static const struct attribute_group hid_dev_group = {
 };
 __ATTRIBUTE_GROUPS(hid_dev);
 
-static int hid_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int hid_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct hid_device *hdev = to_hid_device(dev);
+	const struct hid_device *hdev = to_hid_device(dev);
 
 	if (add_uevent_var(env, "HID_ID=%04X:%08X:%08X",
 			hdev->bus, hdev->vendor, hdev->product))
diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index f68aba8794fe..81385ab37fa9 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -361,7 +361,7 @@ static struct attribute *ishtp_cl_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(ishtp_cl_dev);
 
-static int ishtp_cl_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int ishtp_cl_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	if (add_uevent_var(env, "MODALIAS=" ISHTP_MODULE_PREFIX "%s", dev_name(dev)))
 		return -ENOMEM;
diff --git a/drivers/hsi/hsi_core.c b/drivers/hsi/hsi_core.c
index 884066109699..8fda8f1d064d 100644
--- a/drivers/hsi/hsi_core.c
+++ b/drivers/hsi/hsi_core.c
@@ -30,7 +30,7 @@ static struct attribute *hsi_bus_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(hsi_bus_dev);
 
-static int hsi_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int hsi_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	add_uevent_var(env, "MODALIAS=hsi:%s", dev_name(dev));
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 3146710d4ac6..f50aaa189df6 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -711,9 +711,9 @@ __ATTRIBUTE_GROUPS(vmbus_bus);
  * representation of the device guid (each byte of the guid will be
  * represented with two hex characters.
  */
-static int vmbus_uevent(struct device *device, struct kobj_uevent_env *env)
+static int vmbus_uevent(const struct device *device, struct kobj_uevent_env *env)
 {
-	struct hv_device *dev = device_to_hv_device(device);
+	const struct hv_device *dev = device_to_hv_device(device);
 	const char *format = "MODALIAS=vmbus:%*phN";
 
 	return add_uevent_var(env, format, UUID_SIZE, &dev->dev_type);
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 15ce3202322f..767fc9efb4a8 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -895,9 +895,9 @@ static int serio_bus_match(struct device *dev, struct device_driver *drv)
 			return err;					\
 	} while (0)
 
-static int serio_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int serio_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct serio *serio;
+	const struct serio *serio;
 
 	if (!dev)
 		return -ENODEV;
diff --git a/drivers/ipack/ipack.c b/drivers/ipack/ipack.c
index 74d449858a61..cc1ecfd49928 100644
--- a/drivers/ipack/ipack.c
+++ b/drivers/ipack/ipack.c
@@ -76,9 +76,9 @@ static void ipack_bus_remove(struct device *device)
 		drv->ops->remove(dev);
 }
 
-static int ipack_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int ipack_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct ipack_device *idev;
+	const struct ipack_device *idev;
 
 	if (!dev)
 		return -ENODEV;
diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 7f2b0107c733..211ed9aa9edc 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -128,7 +128,7 @@ static int macio_device_resume(struct device * dev)
 	return 0;
 }
 
-static int macio_device_modalias(struct device *dev, struct kobj_uevent_env *env)
+static int macio_device_modalias(const struct device *dev, struct kobj_uevent_env *env)
 {
 	return of_device_uevent_modalias(dev, env);
 }
diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index b8ad4f16b4ac..978fdfc19a06 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -41,9 +41,9 @@ static int mcb_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
-static int mcb_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int mcb_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct mcb_device *mdev = to_mcb_device(dev);
+	const struct mcb_device *mdev = to_mcb_device(dev);
 	int ret;
 
 	ret = add_uevent_var(env, "MODALIAS=mcb:16z%03d", mdev->id);
diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 660df7d269fa..bf7667845459 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -57,10 +57,10 @@ static int memstick_bus_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
-static int memstick_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int memstick_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct memstick_dev *card = container_of(dev, struct memstick_dev,
-						  dev);
+	const struct memstick_dev *card = container_of_const(dev, struct memstick_dev,
+							     dev);
 
 	if (add_uevent_var(env, "MEMSTICK_TYPE=%02X", card->id.type))
 		return -ENOMEM;
diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 4a08b624910a..096eee478e2e 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -1222,9 +1222,9 @@ ATTRIBUTE_GROUPS(mei_cldev);
  *
  * Return: 0 on success -ENOMEM on when add_uevent_var fails
  */
-static int mei_cl_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int mei_cl_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct mei_cl_device *cldev = to_mei_cl_device(dev);
+	const struct mei_cl_device *cldev = to_mei_cl_device(dev);
 	const uuid_le *uuid = mei_me_cl_uuid(cldev->me_cl);
 	u8 version = mei_me_cl_ver(cldev->me_cl);
 
diff --git a/drivers/misc/tifm_core.c b/drivers/misc/tifm_core.c
index a3098fea3bf7..eee9b6581604 100644
--- a/drivers/misc/tifm_core.c
+++ b/drivers/misc/tifm_core.c
@@ -55,9 +55,9 @@ static int tifm_bus_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
-static int tifm_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int tifm_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct tifm_dev *sock = container_of(dev, struct tifm_dev, dev);
+	const struct tifm_dev *sock = container_of_const(dev, struct tifm_dev, dev);
 
 	if (add_uevent_var(env, "TIFM_CARD_TYPE=%s", tifm_media_type_name(sock->type, 1)))
 		return -ENOMEM;
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 36679f4e9acc..2c3074a605fc 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -55,9 +55,9 @@ static struct attribute *mmc_dev_attrs[] = {
 ATTRIBUTE_GROUPS(mmc_dev);
 
 static int
-mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
+mmc_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct mmc_card *card = mmc_dev_to_card(dev);
+	const struct mmc_card *card = mmc_dev_to_card(dev);
 	const char *type;
 	unsigned int i;
 	int retval = 0;
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index babf21a0adeb..5ec4e4ca52f0 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -120,9 +120,9 @@ static int sdio_bus_match(struct device *dev, struct device_driver *drv)
 }
 
 static int
-sdio_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
+sdio_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct sdio_func *func = dev_to_sdio_func(dev);
+	const struct sdio_func *func = dev_to_sdio_func(dev);
 	unsigned int i;
 
 	if (add_uevent_var(env,
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 1cd604cd1fa1..bca7012b03c1 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -995,7 +995,7 @@ static int mdio_bus_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
-static int mdio_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int mdio_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	int rc;
 
diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index c1ba4294f364..4638bb3664c4 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -200,7 +200,7 @@ static void xenvif_debugfs_delif(struct xenvif *vif)
  * and vif variables to the environment, for the benefit of the vif-* hotplug
  * scripts.
  */
-static int netback_uevent(struct xenbus_device *xdev,
+static int netback_uevent(const struct xenbus_device *xdev,
 			  struct kobj_uevent_env *env)
 {
 	struct backend_info *be = dev_get_drvdata(&xdev->dev);
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index b38d0355b0ac..92ce92fc9932 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -28,7 +28,7 @@ static int nvdimm_bus_major;
 struct class *nd_class;
 static DEFINE_IDA(nd_ida);
 
-static int to_nd_device_type(struct device *dev)
+static int to_nd_device_type(const struct device *dev)
 {
 	if (is_nvdimm(dev))
 		return ND_DEVICE_DIMM;
@@ -42,7 +42,7 @@ static int to_nd_device_type(struct device *dev)
 	return 0;
 }
 
-static int nvdimm_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int nvdimm_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	return add_uevent_var(env, "MODALIAS=" ND_DEVICE_MODALIAS_FMT,
 			to_nd_device_type(dev));
diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
index 7f4a9d28b670..3bd61f245788 100644
--- a/drivers/nvdimm/dax_devs.c
+++ b/drivers/nvdimm/dax_devs.c
@@ -38,7 +38,7 @@ static const struct device_type nd_dax_device_type = {
 	.groups = nd_pfn_attribute_groups,
 };
 
-bool is_nd_dax(struct device *dev)
+bool is_nd_dax(const struct device *dev)
 {
 	return dev ? dev->type == &nd_dax_device_type : false;
 }
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 1fc081dcf631..fb571666d33b 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -572,7 +572,7 @@ static const struct device_type nvdimm_device_type = {
 	.groups = nvdimm_attribute_groups,
 };
 
-bool is_nvdimm(struct device *dev)
+bool is_nvdimm(const struct device *dev)
 {
 	return dev->type == &nvdimm_device_type;
 }
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index cc86ee09d7c0..ca2bbc57e755 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -82,14 +82,14 @@ static inline void nvdimm_security_overwrite_query(struct work_struct *work)
 }
 #endif
 
-bool is_nvdimm(struct device *dev);
-bool is_nd_pmem(struct device *dev);
-bool is_nd_volatile(struct device *dev);
-static inline bool is_nd_region(struct device *dev)
+bool is_nvdimm(const struct device *dev);
+bool is_nd_pmem(const struct device *dev);
+bool is_nd_volatile(const struct device *dev);
+static inline bool is_nd_region(const struct device *dev)
 {
 	return is_nd_pmem(dev) || is_nd_volatile(dev);
 }
-static inline bool is_memory(struct device *dev)
+static inline bool is_memory(const struct device *dev)
 {
 	return is_nd_pmem(dev) || is_nd_volatile(dev);
 }
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 85ca5b4da3cf..cc166f99b005 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -599,7 +599,7 @@ static inline int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 struct nd_dax *to_nd_dax(struct device *dev);
 #if IS_ENABLED(CONFIG_NVDIMM_DAX)
 int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns);
-bool is_nd_dax(struct device *dev);
+bool is_nd_dax(const struct device *dev);
 struct device *nd_dax_create(struct nd_region *nd_region);
 #else
 static inline int nd_dax_probe(struct device *dev,
@@ -608,7 +608,7 @@ static inline int nd_dax_probe(struct device *dev,
 	return -ENODEV;
 }
 
-static inline bool is_nd_dax(struct device *dev)
+static inline bool is_nd_dax(const struct device *dev)
 {
 	return false;
 }
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 83dbf398ea84..8f134d63af13 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -839,12 +839,12 @@ static const struct device_type nd_volatile_device_type = {
 	.groups = nd_region_attribute_groups,
 };
 
-bool is_nd_pmem(struct device *dev)
+bool is_nd_pmem(const struct device *dev)
 {
 	return dev ? dev->type == &nd_pmem_device_type : false;
 }
 
-bool is_nd_volatile(struct device *dev)
+bool is_nd_volatile(const struct device *dev)
 {
 	return dev ? dev->type == &nd_volatile_device_type : false;
 }
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index a2ceeacc33eb..d934c27491c4 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1545,9 +1545,9 @@ void pci_dev_put(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_dev_put);
 
-static int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int pci_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct pci_dev *pdev;
+	const struct pci_dev *pdev;
 
 	if (!dev)
 		return -ENODEV;
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index ace133b9f7d4..c8087efa5e4a 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -927,9 +927,9 @@ static int pcmcia_bus_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
-static int pcmcia_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int pcmcia_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct pcmcia_device *p_dev;
+	const struct pcmcia_device *p_dev;
 	int i;
 	u32 hash[4] = { 0, 0, 0, 0};
 
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 46d1edc08f20..4fe7650dd014 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -797,9 +797,9 @@ static struct attribute *wmi_method_attrs[] = {
 };
 ATTRIBUTE_GROUPS(wmi_method);
 
-static int wmi_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int wmi_dev_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct wmi_block *wblock = dev_to_wblock(dev);
+	const struct wmi_block *wblock = dev_to_wblock(dev);
 
 	if (add_uevent_var(env, "MODALIAS=wmi:%pUL", &wblock->gblock.guid))
 		return -ENOMEM;
diff --git a/drivers/rapidio/rio-driver.c b/drivers/rapidio/rio-driver.c
index a72bb0a40fcf..e60e49769bed 100644
--- a/drivers/rapidio/rio-driver.c
+++ b/drivers/rapidio/rio-driver.c
@@ -204,9 +204,9 @@ static int rio_match_bus(struct device *dev, struct device_driver *drv)
       out:return 0;
 }
 
-static int rio_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int rio_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct rio_dev *rdev;
+	const struct rio_dev *rdev;
 
 	if (!dev)
 		return -ENODEV;
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index d6dde00efdae..a2207c0cf432 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -492,9 +492,9 @@ static int rpmsg_dev_match(struct device *dev, struct device_driver *drv)
 	return of_driver_match_device(dev, drv);
 }
 
-static int rpmsg_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int rpmsg_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
+	const struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 	int ret;
 
 	ret = of_device_uevent_modalias(dev, env);
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index c7db95398500..0723921902da 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -1402,9 +1402,9 @@ static void css_shutdown(struct device *dev)
 		sch->driver->shutdown(sch);
 }
 
-static int css_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int css_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct subchannel *sch = to_subchannel(dev);
+	const struct subchannel *sch = to_subchannel(dev);
 	int ret;
 
 	ret = add_uevent_var(env, "ST=%01X", sch->st);
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 9e0cf44ff9d4..b07ffd9ff117 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -80,7 +80,7 @@ ccw_bus_match (struct device * dev, struct device_driver * drv)
  * specified size. Return length of resulting string (excluding trailing '\0')
  * even if string doesn't fit buffer (snprintf semantics). */
 static int snprint_alias(char *buf, size_t size,
-			 struct ccw_device_id *id, const char *suffix)
+			 const struct ccw_device_id *id, const char *suffix)
 {
 	int len;
 
@@ -101,10 +101,10 @@ static int snprint_alias(char *buf, size_t size,
 
 /* Set up environment variables for ccw device uevent. Return 0 on success,
  * non-zero otherwise. */
-static int ccw_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int ccw_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct ccw_device *cdev = to_ccwdev(dev);
-	struct ccw_device_id *id = &(cdev->id);
+	const struct ccw_device *cdev = to_ccwdev(dev);
+	const struct ccw_device_id *id = &(cdev->id);
 	int ret;
 	char modalias_buf[30];
 
diff --git a/drivers/s390/cio/scm.c b/drivers/s390/cio/scm.c
index b6b4589c70bd..6b21ba68c1fe 100644
--- a/drivers/s390/cio/scm.c
+++ b/drivers/s390/cio/scm.c
@@ -37,7 +37,7 @@ static void scmdev_remove(struct device *dev)
 		scmdrv->remove(scmdev);
 }
 
-static int scmdev_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int scmdev_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	return add_uevent_var(env, "MODALIAS=scm:scmdev");
 }
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index b02c631f3b71..f4cc1720156f 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -613,10 +613,10 @@ static int ap_bus_match(struct device *dev, struct device_driver *drv)
  * It sets up a single environment variable DEV_TYPE which contains the
  * hardware device type.
  */
-static int ap_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int ap_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	int rc = 0;
-	struct ap_device *ap_dev = to_ap_dev(dev);
+	const struct ap_device *ap_dev = to_ap_dev(dev);
 
 	/* Uevents from ap bus core don't need extensions to the env */
 	if (dev == ap_root_device)
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 981d1bab2120..a0dd711eb408 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -534,9 +534,9 @@ static int scsi_bus_match(struct device *dev, struct device_driver *gendrv)
 	return (sdp->inq_periph_qual == SCSI_INQ_PQ_CON)? 1: 0;
 }
 
-static int scsi_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int scsi_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct scsi_device *sdev;
+	const struct scsi_device *sdev;
 
 	if (dev->type != &scsi_dev_type)
 		return 0;
diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 219483b79c09..d43873bb5fe6 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -93,9 +93,9 @@ static void slim_device_remove(struct device *dev)
 	}
 }
 
-static int slim_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int slim_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct slim_device *sbdev = to_slim_device(dev);
+	const struct slim_device *sbdev = to_slim_device(dev);
 
 	return add_uevent_var(env, "MODALIAS=slim:%s", dev_name(&sbdev->dev));
 }
diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index cd44f17dad3d..d0f5cb2dd0ef 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -387,9 +387,9 @@ static void apr_device_remove(struct device *dev)
 	spin_unlock(&apr->svcs_lock);
 }
 
-static int apr_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int apr_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct apr_device *adev = to_apr_device(dev);
+	const struct apr_device *adev = to_apr_device(dev);
 	int ret;
 
 	ret = of_device_uevent_modalias(dev, env);
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3cc7bb4d03de..9d5cec65cec8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -395,7 +395,7 @@ static int spi_match_device(struct device *dev, struct device_driver *drv)
 	return strcmp(spi->modalias, drv->name) == 0;
 }
 
-static int spi_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int spi_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	const struct spi_device		*spi = to_spi_device(dev);
 	int rc;
diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 55381592bb5a..73551531ed43 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -366,7 +366,7 @@ static void spmi_drv_shutdown(struct device *dev)
 		sdrv->shutdown(to_spmi_device(dev));
 }
 
-static int spmi_drv_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int spmi_drv_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	int ret;
 
diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
index 8a93c83cb6f8..ab080cf26c9f 100644
--- a/drivers/ssb/main.c
+++ b/drivers/ssb/main.c
@@ -339,9 +339,9 @@ static int ssb_bus_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
-static int ssb_device_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int ssb_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
+	const struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
 
 	if (!dev)
 		return -ENODEV;
diff --git a/drivers/staging/greybus/gbphy.c b/drivers/staging/greybus/gbphy.c
index 5a5c17a4519b..6a7d8cf2a1eb 100644
--- a/drivers/staging/greybus/gbphy.c
+++ b/drivers/staging/greybus/gbphy.c
@@ -71,14 +71,14 @@ static const struct device_type greybus_gbphy_dev_type = {
 	.pm	=	&gb_gbphy_pm_ops,
 };
 
-static int gbphy_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int gbphy_dev_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct gbphy_device *gbphy_dev = to_gbphy_dev(dev);
-	struct greybus_descriptor_cport *cport_desc = gbphy_dev->cport_desc;
-	struct gb_bundle *bundle = gbphy_dev->bundle;
-	struct gb_interface *intf = bundle->intf;
-	struct gb_module *module = intf->module;
-	struct gb_host_device *hd = intf->hd;
+	const struct gbphy_device *gbphy_dev = to_gbphy_dev(dev);
+	const struct greybus_descriptor_cport *cport_desc = gbphy_dev->cport_desc;
+	const struct gb_bundle *bundle = gbphy_dev->bundle;
+	const struct gb_interface *intf = bundle->intf;
+	const struct gb_module *module = intf->module;
+	const struct gb_host_device *hd = intf->hd;
 
 	if (add_uevent_var(env, "BUS=%u", hd->bus_id))
 		return -ENOMEM;
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 98da206cd761..452cbb8ad484 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1207,7 +1207,7 @@ static int tee_client_device_match(struct device *dev,
 	return 0;
 }
 
-static int tee_client_device_uevent(struct device *dev,
+static int tee_client_device_uevent(const struct device *dev,
 				    struct kobj_uevent_env *env)
 {
 	uuid_t *dev_id = &to_tee_client_device(dev)->id.uuid;
diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index d7c8461976ce..67b780b256a9 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -55,9 +55,9 @@ static int ulpi_match(struct device *dev, struct device_driver *driver)
 	return 0;
 }
 
-static int ulpi_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int ulpi_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct ulpi *ulpi = to_ulpi_dev(dev);
+	const struct ulpi *ulpi = to_ulpi_dev(dev);
 	int ret;
 
 	ret = of_device_uevent_modalias(dev, env);
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 7e7e119c253f..a0e076c6f3a4 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -899,14 +899,14 @@ static int usb_device_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
-static int usb_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int usb_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct usb_device *usb_dev;
+	const struct usb_device *usb_dev;
 
 	if (is_usb_device(dev)) {
 		usb_dev = to_usb_device(dev);
 	} else if (is_usb_interface(dev)) {
-		struct usb_interface *intf = to_usb_interface(dev);
+		const struct usb_interface *intf = to_usb_interface(dev);
 
 		usb_dev = interface_to_usbdev(intf);
 	} else {
diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index 31c2a3130cad..dbcb96151558 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -321,9 +321,9 @@ static int typec_match(struct device *dev, struct device_driver *driver)
 	return 0;
 }
 
-static int typec_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int typec_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct typec_altmode *altmode = to_typec_altmode(dev);
+	const struct typec_altmode *altmode = to_typec_altmode(dev);
 
 	if (add_uevent_var(env, "SVID=%04X", altmode->svid))
 		return -ENOMEM;
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b9a80aedee1b..3893dc29eb26 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -95,9 +95,9 @@ static int virtio_dev_match(struct device *_dv, struct device_driver *_dr)
 	return 0;
 }
 
-static int virtio_uevent(struct device *_dv, struct kobj_uevent_env *env)
+static int virtio_uevent(const struct device *_dv, struct kobj_uevent_env *env)
 {
-	struct virtio_device *dev = dev_to_virtio(_dv);
+	const struct virtio_device *dev = dev_to_virtio(_dv);
 
 	return add_uevent_var(env, "MODALIAS=virtio:d%08Xv%08X",
 			      dev->id.device, dev->id.vendor);
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index f2ae2e563dc5..3a1018e9415b 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -170,7 +170,7 @@ static struct w1_family w1_default_family = {
 	.fops = &w1_default_fops,
 };
 
-static int w1_uevent(struct device *dev, struct kobj_uevent_env *env);
+static int w1_uevent(const struct device *dev, struct kobj_uevent_env *env);
 
 static struct bus_type w1_bus_type = {
 	.name = "w1",
@@ -577,11 +577,11 @@ void w1_destroy_master_attributes(struct w1_master *master)
 	sysfs_remove_group(&master->dev.kobj, &w1_master_defattr_group);
 }
 
-static int w1_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int w1_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct w1_master *md = NULL;
-	struct w1_slave *sl = NULL;
-	char *event_owner, *name;
+	const struct w1_master *md = NULL;
+	const struct w1_slave *sl = NULL;
+	const char *event_owner, *name;
 	int err = 0;
 
 	if (dev->driver == &w1_master_driver) {
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index 28b2a1fa25ab..e46de75096f1 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -1186,7 +1186,7 @@ static int pvcalls_back_remove(struct xenbus_device *dev)
 	return 0;
 }
 
-static int pvcalls_back_uevent(struct xenbus_device *xdev,
+static int pvcalls_back_uevent(const struct xenbus_device *xdev,
 			       struct kobj_uevent_env *env)
 {
 	return 0;
diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index 9c09f89d8278..da96c260e26b 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -92,12 +92,12 @@ static int backend_bus_id(char bus_id[XEN_BUS_ID_SIZE], const char *nodename)
 	return 0;
 }
 
-static int xenbus_uevent_backend(struct device *dev,
+static int xenbus_uevent_backend(const struct device *dev,
 				 struct kobj_uevent_env *env)
 {
-	struct xenbus_device *xdev;
-	struct xenbus_driver *drv;
-	struct xen_bus_type *bus;
+	const struct xenbus_device *xdev;
+	const struct xenbus_driver *drv;
+	const struct xen_bus_type *bus;
 
 	DPRINTK("");
 
diff --git a/drivers/xen/xenbus/xenbus_probe_frontend.c b/drivers/xen/xenbus/xenbus_probe_frontend.c
index f44d5a64351e..3f3836cb7279 100644
--- a/drivers/xen/xenbus/xenbus_probe_frontend.c
+++ b/drivers/xen/xenbus/xenbus_probe_frontend.c
@@ -73,10 +73,10 @@ static int xenbus_probe_frontend(struct xen_bus_type *bus, const char *type,
 	return err;
 }
 
-static int xenbus_uevent_frontend(struct device *_dev,
+static int xenbus_uevent_frontend(const struct device *_dev,
 				  struct kobj_uevent_env *env)
 {
-	struct xenbus_device *dev = to_xenbus_device(_dev);
+	const struct xenbus_device *dev = to_xenbus_device(_dev);
 
 	if (add_uevent_var(env, "MODALIAS=xen:%s", dev->devicetype))
 		return -ENOMEM;
diff --git a/drivers/zorro/zorro-driver.c b/drivers/zorro/zorro-driver.c
index 96f068830549..025edfccedcf 100644
--- a/drivers/zorro/zorro-driver.c
+++ b/drivers/zorro/zorro-driver.c
@@ -130,9 +130,9 @@ static int zorro_bus_match(struct device *dev, struct device_driver *drv)
 	return !!zorro_match_device(ids, z);
 }
 
-static int zorro_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int zorro_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct zorro_dev *z;
+	const struct zorro_dev *z;
 
 	if (!dev)
 		return -ENODEV;
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index d529f644e92b..53e3cdf18bae 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -90,7 +90,7 @@ struct bus_type {
 	const struct attribute_group **drv_groups;
 
 	int (*match)(struct device *dev, struct device_driver *drv);
-	int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
+	int (*uevent)(const struct device *dev, struct kobj_uevent_env *env);
 	int (*probe)(struct device *dev);
 	void (*sync_state)(struct device *dev);
 	void (*remove)(struct device *dev);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 9a32495fbb1f..2edf7f09239e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -223,7 +223,7 @@ struct spi_device {
 static_assert((SPI_MODE_KERNEL_MASK & SPI_MODE_USER_MASK) == 0,
 	      "SPI_MODE_USER_MASK & SPI_MODE_KERNEL_MASK must not overlap");
 
-static inline struct spi_device *to_spi_device(struct device *dev)
+static inline struct spi_device *to_spi_device(const struct device *dev)
 {
 	return dev ? container_of(dev, struct spi_device, dev) : NULL;
 }
diff --git a/include/linux/ssb/ssb.h b/include/linux/ssb/ssb.h
index f9b53acb4e02..1f326da289d3 100644
--- a/include/linux/ssb/ssb.h
+++ b/include/linux/ssb/ssb.h
@@ -285,7 +285,7 @@ struct ssb_device {
 
 /* Go from struct device to struct ssb_device. */
 static inline
-struct ssb_device * dev_to_ssb_dev(struct device *dev)
+struct ssb_device * dev_to_ssb_dev(const struct device *dev)
 {
 	struct __ssb_dev_wrapper *wrap;
 	wrap = container_of(dev, struct __ssb_dev_wrapper, dev);
diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index a6872537724d..1c45664e0e5a 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -123,7 +123,7 @@ void snd_hdac_device_exit(struct hdac_device *dev);
 int snd_hdac_device_register(struct hdac_device *codec);
 void snd_hdac_device_unregister(struct hdac_device *codec);
 int snd_hdac_device_set_chip_name(struct hdac_device *codec, const char *name);
-int snd_hdac_codec_modalias(struct hdac_device *hdac, char *buf, size_t size);
+int snd_hdac_codec_modalias(const struct hdac_device *hdac, char *buf, size_t size);
 
 int snd_hdac_refresh_widgets(struct hdac_device *codec);
 
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index b31f77f9c50c..9adefd9c98d4 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -117,7 +117,7 @@ struct xenbus_driver {
 	int (*remove)(struct xenbus_device *dev);
 	int (*suspend)(struct xenbus_device *dev);
 	int (*resume)(struct xenbus_device *dev);
-	int (*uevent)(struct xenbus_device *, struct kobj_uevent_env *);
+	int (*uevent)(const struct xenbus_device *, struct kobj_uevent_env *);
 	struct device_driver driver;
 	int (*read_otherend_details)(struct xenbus_device *dev);
 	int (*is_ready)(struct xenbus_device *dev);
diff --git a/sound/aoa/soundbus/core.c b/sound/aoa/soundbus/core.c
index c9579d97fbab..39fb8fe4e6ab 100644
--- a/sound/aoa/soundbus/core.c
+++ b/sound/aoa/soundbus/core.c
@@ -55,10 +55,10 @@ static int soundbus_probe(struct device *dev)
 }
 
 
-static int soundbus_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int soundbus_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
-	struct soundbus_dev * soundbus_dev;
-	struct platform_device * of;
+	const struct soundbus_dev * soundbus_dev;
+	const struct platform_device * of;
 	const char *compat;
 	int retval = 0;
 	int cplen, seen = 0;
diff --git a/sound/hda/hda_bus_type.c b/sound/hda/hda_bus_type.c
index eea6b63f8305..4cd94178df9f 100644
--- a/sound/hda/hda_bus_type.c
+++ b/sound/hda/hda_bus_type.c
@@ -65,7 +65,7 @@ static int hda_bus_match(struct device *dev, struct device_driver *drv)
 	return 1;
 }
 
-static int hda_uevent(struct device *dev, struct kobj_uevent_env *env)
+static int hda_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	char modalias[32];
 
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index b7e5032b61c9..accc9d279ce5 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -204,7 +204,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_device_set_chip_name);
  *
  * Returns the size of string, like snprintf(), or a negative error code.
  */
-int snd_hdac_codec_modalias(struct hdac_device *codec, char *buf, size_t size)
+int snd_hdac_codec_modalias(const struct hdac_device *codec, char *buf, size_t size)
 {
 	return scnprintf(buf, size, "hdaudio:v%08Xr%08Xa%02X\n",
 			codec->vendor_id, codec->revision_id, codec->type);
-- 
2.39.0

