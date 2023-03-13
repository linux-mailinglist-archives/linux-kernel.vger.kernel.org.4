Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39436B8034
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCMSS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCMSS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:18:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE94C4DBFD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:18:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B69661466
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4C8C433D2;
        Mon, 13 Mar 2023 18:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678731532;
        bh=n9wY/55nU24yn6OvMnd83xXtJBonPqmT1oLevrj73cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQYuhQRtRmSl7II9TJ1VkOmOrPDENPSBqeQmtTAEU6FErAF7Xb17eG9S1CM17QDoZ
         Z35WbF1DCiF24eKwPPo8EuYek9dpcgFUVBGqwfS9WPajWta2nJsHBsPB3K68C3jTgo
         Dg4YsN2a8tWCqP6ECutICwcofaiX62jDVZ4cBxV8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/12] drivers: remove struct module * setting from struct class
Date:   Mon, 13 Mar 2023 19:18:33 +0100
Message-Id: <20230313181843.1207845-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
References: <20230313181843.1207845-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17484; i=gregkh@linuxfoundation.org; h=from:subject; bh=n9wY/55nU24yn6OvMnd83xXtJBonPqmT1oLevrj73cg=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn8mYzRImYq4h1VyY1zGp9d4hfzdN00I/hAmOUrxUjxI 81Sio87YlkYBJkYZMUUWb5s4zm6v+KQopeh7WmYOaxMIEMYuDgFYCJPwxjmJ1RxXOThko67f4XJ M/lBl2P5pqsPGebwWj858ELxsaDLjFPeMw5dqWKecJ8PAA==
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

There is no need to manually set the owner of a struct class, as the
registering function does it automatically, so remove all of the
explicit settings from various drivers that did so as it is unneeded.

This allows us to remove this pointer entirely from this structure going
forward.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/vpe-mt.c                    | 1 -
 drivers/base/core.c                          | 1 -
 drivers/base/devcoredump.c                   | 1 -
 drivers/block/pktcdvd.c                      | 1 -
 drivers/block/zram/zram_drv.c                | 1 -
 drivers/gpio/gpiolib-sysfs.c                 | 2 --
 drivers/hwmon/hwmon.c                        | 1 -
 drivers/isdn/mISDN/core.c                    | 1 -
 drivers/media/pci/ddbridge/ddbridge-core.c   | 1 -
 drivers/mfd/cros_ec_dev.c                    | 1 -
 drivers/misc/enclosure.c                     | 1 -
 drivers/mtd/mtdcore.c                        | 1 -
 drivers/mtd/ubi/build.c                      | 1 -
 drivers/mux/core.c                           | 1 -
 drivers/net/ipvlan/ipvtap.c                  | 1 -
 drivers/net/macvtap.c                        | 1 -
 drivers/nvme/host/fc.c                       | 1 -
 drivers/platform/chrome/wilco_ec/event.c     | 1 -
 drivers/platform/chrome/wilco_ec/telemetry.c | 1 -
 drivers/platform/x86/intel/pmt/class.c       | 1 -
 drivers/platform/x86/intel_scu_ipc.c         | 1 -
 drivers/ptp/ptp_ocp.c                        | 1 -
 drivers/pwm/sysfs.c                          | 1 -
 drivers/rapidio/rio-driver.c                 | 1 -
 drivers/scsi/sd.c                            | 1 -
 drivers/soc/qcom/rmtfs_mem.c                 | 1 -
 drivers/spi/spi.c                            | 2 --
 drivers/staging/fieldbus/dev_core.c          | 1 -
 drivers/staging/greybus/loopback.c           | 1 -
 drivers/staging/greybus/vibrator.c           | 1 -
 drivers/usb/typec/class.c                    | 1 -
 drivers/usb/typec/mux.c                      | 1 -
 drivers/usb/typec/pd.c                       | 1 -
 drivers/usb/typec/retimer.c                  | 1 -
 drivers/watchdog/watchdog_dev.c              | 1 -
 fs/ksmbd/server.c                            | 1 -
 net/wireless/sysfs.c                         | 1 -
 37 files changed, 39 deletions(-)

diff --git a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
index 223d6274f2e5..667bc75f6420 100644
--- a/arch/mips/kernel/vpe-mt.c
+++ b/arch/mips/kernel/vpe-mt.c
@@ -316,7 +316,6 @@ static void vpe_device_release(struct device *cd)
 
 static struct class vpe_class = {
 	.name = "vpe",
-	.owner = THIS_MODULE,
 	.dev_release = vpe_device_release,
 	.dev_groups = vpe_groups,
 };
diff --git a/drivers/base/core.c b/drivers/base/core.c
index fe74a786e2c3..57076837b33e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -537,7 +537,6 @@ static void devlink_dev_release(struct device *dev)
 
 static struct class devlink_class = {
 	.name = "devlink",
-	.owner = THIS_MODULE,
 	.dev_groups = devlink_groups,
 	.dev_release = devlink_dev_release,
 };
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 1c06781f7114..59aaf2e1375a 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -226,7 +226,6 @@ ATTRIBUTE_GROUPS(devcd_class);
 
 static struct class devcd_class = {
 	.name		= "devcoredump",
-	.owner		= THIS_MODULE,
 	.dev_release	= devcd_dev_release,
 	.dev_groups	= devcd_dev_groups,
 	.class_groups	= devcd_class_groups,
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 2f1a92509271..642e3377441a 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -417,7 +417,6 @@ static int pkt_sysfs_init(void)
 	if (!class_pktcdvd)
 		return -ENOMEM;
 	class_pktcdvd->name = DRIVER_NAME;
-	class_pktcdvd->owner = THIS_MODULE;
 	class_pktcdvd->class_release = class_pktcdvd_release;
 	class_pktcdvd->class_groups = class_pktcdvd_groups;
 	ret = class_register(class_pktcdvd);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aa490da3cef2..b7bb52f8dfbd 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2481,7 +2481,6 @@ ATTRIBUTE_GROUPS(zram_control_class);
 
 static struct class zram_control_class = {
 	.name		= "zram-control",
-	.owner		= THIS_MODULE,
 	.class_groups	= zram_control_class_groups,
 };
 
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index cd27bf173dec..774755052618 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -523,8 +523,6 @@ ATTRIBUTE_GROUPS(gpio_class);
 
 static struct class gpio_class = {
 	.name =		"gpio",
-	.owner =	THIS_MODULE,
-
 	.class_groups = gpio_class_groups,
 };
 
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 33edb5c02f7d..d15ef89e5191 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -138,7 +138,6 @@ static void hwmon_dev_release(struct device *dev)
 
 static struct class hwmon_class = {
 	.name = "hwmon",
-	.owner = THIS_MODULE,
 	.dev_groups = hwmon_dev_attr_groups,
 	.dev_release = hwmon_dev_release,
 };
diff --git a/drivers/isdn/mISDN/core.c b/drivers/isdn/mISDN/core.c
index 9120be590325..f5989c9907ee 100644
--- a/drivers/isdn/mISDN/core.c
+++ b/drivers/isdn/mISDN/core.c
@@ -159,7 +159,6 @@ static void mISDN_class_release(struct class *cls)
 
 static struct class mISDN_class = {
 	.name = "mISDN",
-	.owner = THIS_MODULE,
 	.dev_uevent = mISDN_uevent,
 	.dev_groups = mISDN_groups,
 	.dev_release = mISDN_dev_release,
diff --git a/drivers/media/pci/ddbridge/ddbridge-core.c b/drivers/media/pci/ddbridge/ddbridge-core.c
index ee8087f29b2c..40e6c873c36d 100644
--- a/drivers/media/pci/ddbridge/ddbridge-core.c
+++ b/drivers/media/pci/ddbridge/ddbridge-core.c
@@ -3117,7 +3117,6 @@ static struct device_attribute ddb_attrs_fanspeed[] = {
 
 static struct class ddb_class = {
 	.name		= "ddbridge",
-	.owner          = THIS_MODULE,
 	.devnode        = ddb_devnode,
 };
 
diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 02d4271dfe06..92f4dfccc3cc 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -20,7 +20,6 @@
 #define DRV_NAME "cros-ec-dev"
 
 static struct class cros_class = {
-	.owner          = THIS_MODULE,
 	.name           = "chromeos",
 };
 
diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index 4ba966529458..76511d279aff 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -451,7 +451,6 @@ ATTRIBUTE_GROUPS(enclosure_class);
 
 static struct class enclosure_class = {
 	.name			= "enclosure",
-	.owner			= THIS_MODULE,
 	.dev_release		= enclosure_release,
 	.dev_groups		= enclosure_class_groups,
 };
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 0feacb9fbdac..63fca6141973 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -63,7 +63,6 @@ static SIMPLE_DEV_PM_OPS(mtd_cls_pm_ops, mtd_cls_suspend, mtd_cls_resume);
 
 static struct class mtd_class = {
 	.name = "mtd",
-	.owner = THIS_MODULE,
 	.pm = MTD_CLS_PM_OPS,
 };
 
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 0904eb40c95f..ae6d35e3da9c 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -111,7 +111,6 @@ ATTRIBUTE_GROUPS(ubi_class);
 /* Root UBI "class" object (corresponds to '/<sysfs>/class/ubi/') */
 struct class ubi_class = {
 	.name		= UBI_NAME_STR,
-	.owner		= THIS_MODULE,
 	.class_groups	= ubi_class_groups,
 };
 
diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 49bedbe6316c..990e7bc17c85 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -45,7 +45,6 @@ struct mux_state {
 
 static struct class mux_class = {
 	.name = "mux",
-	.owner = THIS_MODULE,
 };
 
 static DEFINE_IDA(mux_ida);
diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
index dde272586e80..60944a4beada 100644
--- a/drivers/net/ipvlan/ipvtap.c
+++ b/drivers/net/ipvlan/ipvtap.c
@@ -38,7 +38,6 @@ static const void *ipvtap_net_namespace(const struct device *d)
 
 static struct class ipvtap_class = {
 	 .name = "ipvtap",
-	 .owner = THIS_MODULE,
 	 .ns_type = &net_ns_type_operations,
 	 .namespace = ipvtap_net_namespace,
 };
diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
index 031344239f27..bddcc127812e 100644
--- a/drivers/net/macvtap.c
+++ b/drivers/net/macvtap.c
@@ -43,7 +43,6 @@ static const void *macvtap_net_namespace(const struct device *d)
 
 static struct class macvtap_class = {
 	.name = "macvtap",
-	.owner = THIS_MODULE,
 	.ns_type = &net_ns_type_operations,
 	.namespace = macvtap_net_namespace,
 };
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 456ee42a6133..2ed75923507d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3875,7 +3875,6 @@ static const struct attribute_group *nvme_fc_attr_groups[] = {
 static struct class fc_class = {
 	.name = "fc",
 	.dev_groups = nvme_fc_attr_groups,
-	.owner = THIS_MODULE,
 };
 
 static int __init nvme_fc_init_module(void)
diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index 69ceead8cdaa..a40f60bcefb6 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -58,7 +58,6 @@
 #define DRV_NAME		EVENT_DEV_NAME
 #define EVENT_DEV_NAME_FMT	(EVENT_DEV_NAME "%d")
 static struct class event_class = {
-	.owner	= THIS_MODULE,
 	.name	= EVENT_CLASS_NAME,
 };
 
diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
index 60da7a29f2ff..54708aa6c700 100644
--- a/drivers/platform/chrome/wilco_ec/telemetry.c
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -42,7 +42,6 @@
 #define DRV_NAME		TELEM_DEV_NAME
 #define TELEM_DEV_NAME_FMT	(TELEM_DEV_NAME "%d")
 static struct class telem_class = {
-	.owner	= THIS_MODULE,
 	.name	= TELEM_CLASS_NAME,
 };
 
diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index 46598dcb634a..80292d21a0b4 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -155,7 +155,6 @@ ATTRIBUTE_GROUPS(intel_pmt);
 
 static struct class intel_pmt_class = {
 	.name = "intel_pmt",
-	.owner = THIS_MODULE,
 	.dev_groups = intel_pmt_groups,
 };
 
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index e7a3e3402817..6851d10d6582 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -82,7 +82,6 @@ static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
 
 static struct class intel_scu_ipc_class = {
 	.name = "intel_scu_ipc",
-	.owner = THIS_MODULE,
 };
 
 /**
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 4bbaccd543ad..93eba1430883 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -34,7 +34,6 @@
 #define PCI_DEVICE_ID_OROLIA_ARTCARD		0xa000
 
 static struct class timecard_class = {
-	.owner		= THIS_MODULE,
 	.name		= "timecard",
 };
 
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index e7db8e45001c..1a106ec32939 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -475,7 +475,6 @@ static DEFINE_SIMPLE_DEV_PM_OPS(pwm_class_pm_ops, pwm_class_suspend, pwm_class_r
 
 static struct class pwm_class = {
 	.name = "pwm",
-	.owner = THIS_MODULE,
 	.dev_groups = pwm_chip_groups,
 	.pm = pm_sleep_ptr(&pwm_class_pm_ops),
 };
diff --git a/drivers/rapidio/rio-driver.c b/drivers/rapidio/rio-driver.c
index e60e49769bed..1b3b4c2e015d 100644
--- a/drivers/rapidio/rio-driver.c
+++ b/drivers/rapidio/rio-driver.c
@@ -223,7 +223,6 @@ static int rio_uevent(const struct device *dev, struct kobj_uevent_env *env)
 
 struct class rio_mport_class = {
 	.name		= "rapidio_port",
-	.owner		= THIS_MODULE,
 	.dev_groups	= rio_mport_groups,
 };
 EXPORT_SYMBOL_GPL(rio_mport_class);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 4f28dd617eca..f98878776204 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -587,7 +587,6 @@ ATTRIBUTE_GROUPS(sd_disk);
 
 static struct class sd_disk_class = {
 	.name		= "scsi_disk",
-	.owner		= THIS_MODULE,
 	.dev_release	= scsi_disk_release,
 	.dev_groups	= sd_disk_groups,
 };
diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 2d3ee22b9249..5c321da7bb9d 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -126,7 +126,6 @@ static int qcom_rmtfs_mem_release(struct inode *inode, struct file *filp)
 }
 
 static struct class rmtfs_class = {
-	.owner          = THIS_MODULE,
 	.name           = "rmtfs",
 };
 
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 44b85a8d47f1..4b9a17f024c0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2776,7 +2776,6 @@ static void spi_controller_release(struct device *dev)
 
 static struct class spi_master_class = {
 	.name		= "spi_master",
-	.owner		= THIS_MODULE,
 	.dev_release	= spi_controller_release,
 	.dev_groups	= spi_master_groups,
 };
@@ -2879,7 +2878,6 @@ static const struct attribute_group *spi_slave_groups[] = {
 
 static struct class spi_slave_class = {
 	.name		= "spi_slave",
-	.owner		= THIS_MODULE,
 	.dev_release	= spi_controller_release,
 	.dev_groups	= spi_slave_groups,
 };
diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 5f54f2674bd1..bf1812d8924f 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -154,7 +154,6 @@ __ATTRIBUTE_GROUPS(fieldbus);
 
 static struct class fieldbus_class = {
 	.name =		"fieldbus_dev",
-	.owner =	THIS_MODULE,
 	.dev_groups =	fieldbus_groups,
 };
 
diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 1a61fce98056..d7b39f3bb652 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -100,7 +100,6 @@ struct gb_loopback {
 
 static struct class loopback_class = {
 	.name		= "gb_loopback",
-	.owner		= THIS_MODULE,
 };
 static DEFINE_IDA(loopback_ida);
 
diff --git a/drivers/staging/greybus/vibrator.c b/drivers/staging/greybus/vibrator.c
index 0e2b188e5ca3..227e18d92a95 100644
--- a/drivers/staging/greybus/vibrator.c
+++ b/drivers/staging/greybus/vibrator.c
@@ -107,7 +107,6 @@ ATTRIBUTE_GROUPS(vibrator);
 
 static struct class vibrator_class = {
 	.name		= "vibrator",
-	.owner		= THIS_MODULE,
 	.dev_groups	= vibrator_groups,
 };
 
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index cc3182f70673..349cc2030c90 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -22,7 +22,6 @@ static DEFINE_IDA(typec_index_ida);
 
 struct class typec_class = {
 	.name = "typec",
-	.owner = THIS_MODULE,
 };
 
 /* ------------------------------------------------------------------------- */
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index c7177ddd4f12..d9eaf9a0b0bf 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -514,5 +514,4 @@ EXPORT_SYMBOL_GPL(typec_mux_get_drvdata);
 
 struct class typec_mux_class = {
 	.name = "typec_mux",
-	.owner = THIS_MODULE,
 };
diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
index 59c537a5e600..0bcde1ff4d39 100644
--- a/drivers/usb/typec/pd.c
+++ b/drivers/usb/typec/pd.c
@@ -15,7 +15,6 @@ static DEFINE_IDA(pd_ida);
 
 static struct class pd_class = {
 	.name = "usb_power_delivery",
-	.owner = THIS_MODULE,
 };
 
 #define to_pdo(o) container_of(o, struct pdo, dev)
diff --git a/drivers/usb/typec/retimer.c b/drivers/usb/typec/retimer.c
index 0481e82f6bbc..4a7d1b5c4d86 100644
--- a/drivers/usb/typec/retimer.c
+++ b/drivers/usb/typec/retimer.c
@@ -157,5 +157,4 @@ EXPORT_SYMBOL_GPL(typec_retimer_get_drvdata);
 
 struct class retimer_class = {
 	.name = "retimer",
-	.owner = THIS_MODULE,
 };
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 0122e8796879..12a6f020b6b5 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1005,7 +1005,6 @@ static struct miscdevice watchdog_miscdev = {
 
 static struct class watchdog_class = {
 	.name =		"watchdog",
-	.owner =	THIS_MODULE,
 	.dev_groups =	wdt_groups,
 };
 
diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index 394b6ceac431..b5af3e43e677 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -516,7 +516,6 @@ ATTRIBUTE_GROUPS(ksmbd_control_class);
 
 static struct class ksmbd_control_class = {
 	.name		= "ksmbd-control",
-	.owner		= THIS_MODULE,
 	.class_groups	= ksmbd_control_class_groups,
 };
 
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index cdb638647e0b..268f670835e9 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -157,7 +157,6 @@ static const void *wiphy_namespace(const struct device *d)
 
 struct class ieee80211_class = {
 	.name = "ieee80211",
-	.owner = THIS_MODULE,
 	.dev_release = wiphy_dev_release,
 	.dev_groups = ieee80211_groups,
 	.pm = WIPHY_PM_OPS,
-- 
2.39.2

