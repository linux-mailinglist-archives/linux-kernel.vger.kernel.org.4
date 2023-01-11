Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595A4665A44
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbjAKLc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjAKLb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:31:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCF438A1;
        Wed, 11 Jan 2023 03:31:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D14C2B81B8D;
        Wed, 11 Jan 2023 11:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9C5C433EF;
        Wed, 11 Jan 2023 11:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673436675;
        bh=07TcxooMePyS4B9Y9vjTDSwlSURFf2vzK1ujAXwFgzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ez09IDD+1Xt+5uh7AY5fJ58sffaEvbwpNQbYqJbxhCpp82Hjqu11+yp4CpvrQxyua
         FpfhEa+sbAQPP6Z7sBs9pX+bryl/7TF2tdYfMzwd813vPhnx0iszeHh3CgiaXE65X8
         j5R/YXlbrh3qavzmVuXhaqLLpraNcs5Q0IFE4SHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Won Chung <wonchung@google.com>, linux-block@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        linux-usb@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 06/16] driver core: make struct device_type.devnode() take a const *
Date:   Wed, 11 Jan 2023 12:30:08 +0100
Message-Id: <20230111113018.459199-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111113018.459199-1-gregkh@linuxfoundation.org>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6485; i=gregkh@linuxfoundation.org; h=from:subject; bh=07TcxooMePyS4B9Y9vjTDSwlSURFf2vzK1ujAXwFgzI=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn75p64nFHg2G95V6xMNikuX1rS8kDSZk4769kP2bdKerAt b2bviGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgIm8nsUwm4X/Tkt1irLF+af9j0M102 rd4x2UGebKfjixlyef3+Jkvd93kYrmlbse6l4AAA==
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

The devnode() callback in struct device_type should not be modifying the
device that is passed into it, so mark it as a const * and propagate the
function signature changes out into all relevant subsystems that use
this callback.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Jeremy Kerr <jk@ozlabs.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Alistar Popple <alistair@popple.id.au>
Cc: Eddie James <eajames@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jilin Yuan <yuanjilin@cdjrlc.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Won Chung <wonchung@google.com>
Cc: linux-block@vger.kernel.org
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/genhd.c                         | 2 +-
 drivers/cxl/core/memdev.c             | 2 +-
 drivers/fsi/fsi-core.c                | 6 +++---
 drivers/hwtracing/intel_th/core.c     | 6 +++---
 drivers/hwtracing/intel_th/intel_th.h | 4 ++--
 drivers/usb/core/usb.c                | 4 ++--
 include/linux/device.h                | 2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 23cf83b3331c..09f2ac548832 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1201,7 +1201,7 @@ struct class block_class = {
 	.dev_uevent	= block_uevent,
 };
 
-static char *block_devnode(struct device *dev, umode_t *mode,
+static char *block_devnode(const struct device *dev, umode_t *mode,
 			   kuid_t *uid, kgid_t *gid)
 {
 	struct gendisk *disk = dev_to_disk(dev);
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a74a93310d26..a38a0cc20d47 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -27,7 +27,7 @@ static void cxl_memdev_release(struct device *dev)
 	kfree(cxlmd);
 }
 
-static char *cxl_memdev_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
+static char *cxl_memdev_devnode(const struct device *dev, umode_t *mode, kuid_t *uid,
 				kgid_t *gid)
 {
 	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 694e80c06665..0b927c9f4267 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -897,10 +897,10 @@ static const struct attribute_group *cfam_attr_groups[] = {
 	NULL,
 };
 
-static char *cfam_devnode(struct device *dev, umode_t *mode,
+static char *cfam_devnode(const struct device *dev, umode_t *mode,
 			  kuid_t *uid, kgid_t *gid)
 {
-	struct fsi_slave *slave = to_fsi_slave(dev);
+	const struct fsi_slave *slave = to_fsi_slave(dev);
 
 #ifdef CONFIG_FSI_NEW_DEV_NODE
 	return kasprintf(GFP_KERNEL, "fsi/cfam%d", slave->cdev_idx);
@@ -915,7 +915,7 @@ static const struct device_type cfam_type = {
 	.groups = cfam_attr_groups
 };
 
-static char *fsi_cdev_devnode(struct device *dev, umode_t *mode,
+static char *fsi_cdev_devnode(const struct device *dev, umode_t *mode,
 			      kuid_t *uid, kgid_t *gid)
 {
 #ifdef CONFIG_FSI_NEW_DEV_NODE
diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 7e753a75d23b..cc7f879bb175 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -185,11 +185,11 @@ static struct device_type intel_th_source_device_type = {
 	.release	= intel_th_device_release,
 };
 
-static char *intel_th_output_devnode(struct device *dev, umode_t *mode,
+static char *intel_th_output_devnode(const struct device *dev, umode_t *mode,
 				     kuid_t *uid, kgid_t *gid)
 {
-	struct intel_th_device *thdev = to_intel_th_device(dev);
-	struct intel_th *th = to_intel_th(thdev);
+	const struct intel_th_device *thdev = to_intel_th_device(dev);
+	const struct intel_th *th = to_intel_th(thdev);
 	char *node;
 
 	if (thdev->id >= 0)
diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index 0ffb42990175..6cbba733f259 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -205,7 +205,7 @@ struct intel_th_driver {
  * INTEL_TH_SWITCH and INTEL_TH_SOURCE are children of the intel_th device.
  */
 static inline struct intel_th_device *
-to_intel_th_parent(struct intel_th_device *thdev)
+to_intel_th_parent(const struct intel_th_device *thdev)
 {
 	struct device *parent = thdev->dev.parent;
 
@@ -215,7 +215,7 @@ to_intel_th_parent(struct intel_th_device *thdev)
 	return to_intel_th_device(parent);
 }
 
-static inline struct intel_th *to_intel_th(struct intel_th_device *thdev)
+static inline struct intel_th *to_intel_th(const struct intel_th_device *thdev)
 {
 	if (thdev->type == INTEL_TH_OUTPUT)
 		thdev = to_intel_th_parent(thdev);
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 8527c06b65e6..4df26f4f76e6 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -505,10 +505,10 @@ static const struct dev_pm_ops usb_device_pm_ops = {
 #endif	/* CONFIG_PM */
 
 
-static char *usb_devnode(struct device *dev,
+static char *usb_devnode(const struct device *dev,
 			 umode_t *mode, kuid_t *uid, kgid_t *gid)
 {
-	struct usb_device *usb_dev;
+	const struct usb_device *usb_dev;
 
 	usb_dev = to_usb_device(dev);
 	return kasprintf(GFP_KERNEL, "bus/usb/%03d/%03d",
diff --git a/include/linux/device.h b/include/linux/device.h
index dad0614aad96..318861000b83 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -89,7 +89,7 @@ struct device_type {
 	const char *name;
 	const struct attribute_group **groups;
 	int (*uevent)(const struct device *dev, struct kobj_uevent_env *env);
-	char *(*devnode)(struct device *dev, umode_t *mode,
+	char *(*devnode)(const struct device *dev, umode_t *mode,
 			 kuid_t *uid, kgid_t *gid);
 	void (*release)(struct device *dev);
 
-- 
2.39.0

