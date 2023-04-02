Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698656D39A2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 19:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjDBR72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 13:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjDBR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 13:59:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AC1EB6B
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 10:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37B0AB80F10
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 17:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60023C433D2;
        Sun,  2 Apr 2023 17:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680458354;
        bh=gi+gKnH113ddsxRQT0k8K/Z9hlCfY3UZcSTiuNPvzNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=awde1rq0CG2iGm1qGV0gdQkp7uOgz7QWFGNa55TUpl3IWrur2vvrCkxhcjCe9PLCO
         QK/HfIQlposmB/c2kpNNlZCvX01Q+uqaqMZ2aS9TAd/0hg+SLNTlYiY6ZC50U1+tvV
         okjXPcuW2EfZC9vzR7vzniQboSNZkrcqHbJu/Q4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Cai Xinchen <caixinchen1@huawei.com>
Subject: [PATCH 4/5] driver core: class: remove struct class_interface * from callbacks
Date:   Sun,  2 Apr 2023 19:58:49 +0200
Message-Id: <2023040250-pushover-platter-509c@gregkh>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <2023040244-duffel-pushpin-f738@gregkh>
References: <2023040244-duffel-pushpin-f738@gregkh>
MIME-Version: 1.0
Lines:  381
X-Developer-Signature: v=1; a=openpgp-sha256; l=14757; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=gi+gKnH113ddsxRQT0k8K/Z9hlCfY3UZcSTiuNPvzNo=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmah6JmGAYoxCj+Yul14HxoUbAw+UbSt6tCZhueH1J37 P5uOIWtI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZiWsUwk1F91d1fX5zfm3Rq 7Zkdm75C95trGsP8wmThgzsFJG2kWU6ueWSrtvXUNz09AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The add_dev and remove_dev callbacks in struct class_interface currently
pass in a pointer back to the class_interface structure that is calling
them, but none of the callback implementations actually use this pointer
as it is pointless (the structure is known, the driver passed it in in
the first place if it is really needed again.)

So clean this up and just remove the pointer from the callbacks and fix
up all callback functions.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Alexandre Bounine <alex.bou9@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Doug Gilbert <dgilbert@interlog.com>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Weiyang <wangweiyang2@huawei.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Jakob Koschel <jakobkoschel@gmail.com>
Cc: Cai Xinchen <caixinchen1@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, subsystem maintainers, this should go through my driver-core tree
as it's part of a larger cleanup of 'struct class' handling.  I'm cc:ing
you all to get reviews to verify I didn't do something foolish, but it
has passed 0-day bot build testing already (which caught many foolish
mistakes of mine...)


 drivers/base/class.c                     |  4 ++--
 drivers/base/core.c                      | 10 ++++------
 drivers/hwmon/drivetemp.c                |  4 ++--
 drivers/net/rionet.c                     |  3 +--
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c   |  6 ++----
 drivers/pcmcia/ds.c                      |  6 ++----
 drivers/pcmcia/rsrc_nonstatic.c          |  6 ++----
 drivers/rapidio/devices/rio_mport_cdev.c |  7 ++-----
 drivers/rapidio/rio_cm.c                 |  8 ++------
 drivers/scsi/ses.c                       |  6 ++----
 drivers/scsi/sg.c                        |  8 ++++----
 include/linux/device/class.h             |  4 ++--
 kernel/time/alarmtimer.c                 |  3 +--
 13 files changed, 28 insertions(+), 47 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index ad8b9f163fd2..ac1808d1a2e8 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -486,7 +486,7 @@ int class_interface_register(struct class_interface *class_intf)
 	if (class_intf->add_dev) {
 		class_dev_iter_init(&iter, parent, NULL, NULL);
 		while ((dev = class_dev_iter_next(&iter)))
-			class_intf->add_dev(dev, class_intf);
+			class_intf->add_dev(dev);
 		class_dev_iter_exit(&iter);
 	}
 	mutex_unlock(&sp->mutex);
@@ -514,7 +514,7 @@ void class_interface_unregister(struct class_interface *class_intf)
 	if (class_intf->remove_dev) {
 		class_dev_iter_init(&iter, parent, NULL, NULL);
 		while ((dev = class_dev_iter_next(&iter)))
-			class_intf->remove_dev(dev, class_intf);
+			class_intf->remove_dev(dev);
 		class_dev_iter_exit(&iter);
 	}
 	mutex_unlock(&sp->mutex);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 64d188be4df9..7a42d1b6b721 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -541,8 +541,7 @@ static struct class devlink_class = {
 	.dev_release = devlink_dev_release,
 };
 
-static int devlink_add_symlinks(struct device *dev,
-				struct class_interface *class_intf)
+static int devlink_add_symlinks(struct device *dev)
 {
 	int ret;
 	size_t len;
@@ -591,8 +590,7 @@ static int devlink_add_symlinks(struct device *dev,
 	return ret;
 }
 
-static void devlink_remove_symlinks(struct device *dev,
-				   struct class_interface *class_intf)
+static void devlink_remove_symlinks(struct device *dev)
 {
 	struct device_link *link = to_devlink(dev);
 	size_t len;
@@ -3647,7 +3645,7 @@ int device_add(struct device *dev)
 		/* notify any interfaces that the device is here */
 		list_for_each_entry(class_intf, &sp->interfaces, node)
 			if (class_intf->add_dev)
-				class_intf->add_dev(dev, class_intf);
+				class_intf->add_dev(dev);
 		mutex_unlock(&sp->mutex);
 		subsys_put(sp);
 	}
@@ -3805,7 +3803,7 @@ void device_del(struct device *dev)
 		/* notify any interfaces that the device is now gone */
 		list_for_each_entry(class_intf, &sp->interfaces, node)
 			if (class_intf->remove_dev)
-				class_intf->remove_dev(dev, class_intf);
+				class_intf->remove_dev(dev);
 		/* remove the device from the class list */
 		klist_del(&dev->p->knode_class);
 		mutex_unlock(&sp->mutex);
diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
index 8e5759b42390..86171031ddc5 100644
--- a/drivers/hwmon/drivetemp.c
+++ b/drivers/hwmon/drivetemp.c
@@ -550,7 +550,7 @@ static const struct hwmon_chip_info drivetemp_chip_info = {
  * The device argument points to sdev->sdev_dev. Its parent is
  * sdev->sdev_gendev, which we can use to get the scsi_device pointer.
  */
-static int drivetemp_add(struct device *dev, struct class_interface *intf)
+static int drivetemp_add(struct device *dev)
 {
 	struct scsi_device *sdev = to_scsi_device(dev->parent);
 	struct drivetemp_data *st;
@@ -585,7 +585,7 @@ static int drivetemp_add(struct device *dev, struct class_interface *intf)
 	return err;
 }
 
-static void drivetemp_remove(struct device *dev, struct class_interface *intf)
+static void drivetemp_remove(struct device *dev)
 {
 	struct drivetemp_data *st, *tmp;
 
diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
index fbcb9d05da64..4eececc94513 100644
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -662,8 +662,7 @@ static int rionet_shutdown(struct notifier_block *nb, unsigned long code,
 	return NOTIFY_DONE;
 }
 
-static void rionet_remove_mport(struct device *dev,
-				struct class_interface *class_intf)
+static void rionet_remove_mport(struct device *dev)
 {
 	struct rio_mport *mport = to_rio_mport(dev);
 	struct net_device *ndev;
diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 88ae18b0efa8..d6bbcc7b5b90 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1470,8 +1470,7 @@ static int switchtec_ntb_reinit_peer(struct switchtec_ntb *sndev)
 	return rc;
 }
 
-static int switchtec_ntb_add(struct device *dev,
-			     struct class_interface *class_intf)
+static int switchtec_ntb_add(struct device *dev)
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
 	struct switchtec_ntb *sndev;
@@ -1541,8 +1540,7 @@ static int switchtec_ntb_add(struct device *dev,
 	return rc;
 }
 
-static void switchtec_ntb_remove(struct device *dev,
-				 struct class_interface *class_intf)
+static void switchtec_ntb_remove(struct device *dev)
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
 	struct switchtec_ntb *sndev = stdev->sndev;
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index c8087efa5e4a..d500e5dbbc3f 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -1335,8 +1335,7 @@ static struct pcmcia_callback pcmcia_bus_callback = {
 	.resume = pcmcia_bus_resume,
 };
 
-static int pcmcia_bus_add_socket(struct device *dev,
-					   struct class_interface *class_intf)
+static int pcmcia_bus_add_socket(struct device *dev)
 {
 	struct pcmcia_socket *socket = dev_get_drvdata(dev);
 	int ret;
@@ -1369,8 +1368,7 @@ static int pcmcia_bus_add_socket(struct device *dev,
 	return 0;
 }
 
-static void pcmcia_bus_remove_socket(struct device *dev,
-				     struct class_interface *class_intf)
+static void pcmcia_bus_remove_socket(struct device *dev)
 {
 	struct pcmcia_socket *socket = dev_get_drvdata(dev);
 
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index ad1141fddb4c..471e0c5815f3 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -1200,8 +1200,7 @@ static const struct attribute_group rsrc_attributes = {
 	.attrs = pccard_rsrc_attributes,
 };
 
-static int pccard_sysfs_add_rsrc(struct device *dev,
-					   struct class_interface *class_intf)
+static int pccard_sysfs_add_rsrc(struct device *dev)
 {
 	struct pcmcia_socket *s = dev_get_drvdata(dev);
 
@@ -1210,8 +1209,7 @@ static int pccard_sysfs_add_rsrc(struct device *dev,
 	return sysfs_create_group(&dev->kobj, &rsrc_attributes);
 }
 
-static void pccard_sysfs_remove_rsrc(struct device *dev,
-					       struct class_interface *class_intf)
+static void pccard_sysfs_remove_rsrc(struct device *dev)
 {
 	struct pcmcia_socket *s = dev_get_drvdata(dev);
 
diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index deb96c3160a7..a115730ebf14 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -2536,10 +2536,8 @@ static void mport_cdev_remove(struct mport_dev *md)
 /*
  * mport_add_mport() - Add rio_mport from LDM device struct
  * @dev:		Linux device model struct
- * @class_intf:	Linux class_interface
  */
-static int mport_add_mport(struct device *dev,
-		struct class_interface *class_intf)
+static int mport_add_mport(struct device *dev)
 {
 	struct rio_mport *mport = NULL;
 	struct mport_dev *chdev = NULL;
@@ -2559,8 +2557,7 @@ static int mport_add_mport(struct device *dev,
  * mport_remove_mport() - Remove rio_mport from global list
  * TODO remove device from global mport_dev list
  */
-static void mport_remove_mport(struct device *dev,
-		struct class_interface *class_intf)
+static void mport_remove_mport(struct device *dev)
 {
 	struct rio_mport *mport = NULL;
 	struct mport_dev *chdev;
diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index acaf9cda014c..49f8d111e546 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -2087,13 +2087,11 @@ static int riocm_cdev_add(dev_t devno)
 /*
  * riocm_add_mport - add new local mport device into channel management core
  * @dev: device object associated with mport
- * @class_intf: class interface
  *
  * When a new mport device is added, CM immediately reserves inbound and
  * outbound RapidIO mailboxes that will be used.
  */
-static int riocm_add_mport(struct device *dev,
-			   struct class_interface *class_intf)
+static int riocm_add_mport(struct device *dev)
 {
 	int rc;
 	int i;
@@ -2166,14 +2164,12 @@ static int riocm_add_mport(struct device *dev,
 /*
  * riocm_remove_mport - remove local mport device from channel management core
  * @dev: device object associated with mport
- * @class_intf: class interface
  *
  * Removes a local mport device from the list of registered devices that provide
  * channel management services. Returns an error if the specified mport is not
  * registered with the CM core.
  */
-static void riocm_remove_mport(struct device *dev,
-			       struct class_interface *class_intf)
+static void riocm_remove_mport(struct device *dev)
 {
 	struct rio_mport *mport = to_rio_mport(dev);
 	struct cm_dev *cm;
diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index b11a9162e73a..57feb0cae896 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -663,8 +663,7 @@ static void ses_match_to_enclosure(struct enclosure_device *edev,
 	}
 }
 
-static int ses_intf_add(struct device *cdev,
-			struct class_interface *intf)
+static int ses_intf_add(struct device *cdev)
 {
 	struct scsi_device *sdev = to_scsi_device(cdev->parent);
 	struct scsi_device *tmp_sdev;
@@ -869,8 +868,7 @@ static void ses_intf_remove_enclosure(struct scsi_device *sdev)
 	enclosure_unregister(edev);
 }
 
-static void ses_intf_remove(struct device *cdev,
-			    struct class_interface *intf)
+static void ses_intf_remove(struct device *cdev)
 {
 	struct scsi_device *sdev = to_scsi_device(cdev->parent);
 
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 4997f880d4a4..037f8c98a6d3 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -96,8 +96,8 @@ static int scatter_elem_sz_prev = SG_SCATTER_SZ;
 
 #define SG_SECTOR_SZ 512
 
-static int sg_add_device(struct device *, struct class_interface *);
-static void sg_remove_device(struct device *, struct class_interface *);
+static int sg_add_device(struct device *);
+static void sg_remove_device(struct device *);
 
 static DEFINE_IDR(sg_index_idr);
 static DEFINE_RWLOCK(sg_index_lock);	/* Also used to lock
@@ -1488,7 +1488,7 @@ sg_alloc(struct scsi_device *scsidp)
 }
 
 static int
-sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
+sg_add_device(struct device *cl_dev)
 {
 	struct scsi_device *scsidp = to_scsi_device(cl_dev->parent);
 	Sg_device *sdp = NULL;
@@ -1578,7 +1578,7 @@ sg_device_destroy(struct kref *kref)
 }
 
 static void
-sg_remove_device(struct device *cl_dev, struct class_interface *cl_intf)
+sg_remove_device(struct device *cl_dev)
 {
 	struct scsi_device *scsidp = to_scsi_device(cl_dev->parent);
 	Sg_device *sdp = dev_get_drvdata(cl_dev);
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index 53287aa105b8..9deeaeb457bb 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -219,8 +219,8 @@ struct class_interface {
 	struct list_head	node;
 	const struct class	*class;
 
-	int (*add_dev)		(struct device *, struct class_interface *);
-	void (*remove_dev)	(struct device *, struct class_interface *);
+	int (*add_dev)		(struct device *dev);
+	void (*remove_dev)	(struct device *dev);
 };
 
 int __must_check class_interface_register(struct class_interface *);
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 7e5dff602585..82b28ab0f328 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -81,8 +81,7 @@ struct rtc_device *alarmtimer_get_rtcdev(void)
 }
 EXPORT_SYMBOL_GPL(alarmtimer_get_rtcdev);
 
-static int alarmtimer_rtc_add_device(struct device *dev,
-				struct class_interface *class_intf)
+static int alarmtimer_rtc_add_device(struct device *dev)
 {
 	unsigned long flags;
 	struct rtc_device *rtc = to_rtc_device(dev);
-- 
2.40.0

