Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A05BB94E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiIQQNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiIQQNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:13:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BF02ED7B;
        Sat, 17 Sep 2022 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663431198; x=1694967198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9U0nkN0JYOfe69os/M/gMwdpWQP9UqnbAFepp3vF77w=;
  b=ZkjdRyfh2270vTO+pQJjlvrwt5bR3pOL9lGAudh8flnWb4SWMrKfrmYk
   QpWAfJjHq5/3EbhZM8w2aZjg7yR7GJ7zgrxDfXO3SLd9ym1JKv1f0krcH
   YMl+Ex9WQkW0O3SsbQMOq+sfDjjNAHKjOPA5wXJpbPQ2GyfybAZnenxpQ
   qOoUxqQqRiorE0x+lY2qsbVPEF6tujrCTXZjO6UMv/NN8deSL3SSPafy6
   mmznmqU6sU91Ozo5CyWk/UtyTjXSdMKfay4NHTGOuNu92A5fMEhryMRp5
   4pg5JzLN15etemXT25PTLWNaEDwBh63loEtl1bCcxZGLFV/KdPHo+wpwF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="286206515"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="286206515"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 09:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="686472604"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2022 09:13:14 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 3/5] dmaengine: idxd: add WQ operation cap restriction support
Date:   Sat, 17 Sep 2022 09:12:20 -0700
Message-Id: <20220917161222.2835172-4-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220917161222.2835172-1-fenghua.yu@intel.com>
References: <20220917161222.2835172-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

DSA 2.0 add the capability of configuring DMA ops on a per workqueue basis.
This means that certain ops can be disabled by the system administrator for
certain wq. By default, all ops are available. A bitmap is used to store
the ops due to total op size of 256 bits and it is more convenient to use a
range list to specify which bits are enabled.

One of the usage to support this is for VM migration between different
iteration of devices. The newer ops are disabled in order to allow guest to
migrate to a host that only support older ops. Another usage is to
restrict the WQ to certain operations for QoS of performance.

A sysfs of ops_config attribute is added per wq. It is only usable when the
ops_config bit is set under WQ_CAP register. This means that this attribute
will return -EOPNOTSUPP on DSA 1.x devices. The expected input is a range
list for the bits per operation the WQ supports.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 .../ABI/stable/sysfs-driver-dma-idxd          | 11 +++
 drivers/dma/idxd/device.c                     | 15 +++-
 drivers/dma/idxd/idxd.h                       |  2 +
 drivers/dma/idxd/init.c                       | 10 +++
 drivers/dma/idxd/registers.h                  |  8 +-
 drivers/dma/idxd/sysfs.c                      | 85 +++++++++++++++++++
 6 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index 0c2b613f2373..3f9f93b5e48c 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -227,6 +227,17 @@ Contact:	dmaengine@vger.kernel.org
 Description:	Indicate the number of retires for an enqcmds submission on a sharedwq.
 		A max value to set attribute is capped at 64.
 
+What:		/sys/bus/dsa/devices/wq<m>.<n>/op_config
+Date:		Sept 14, 2022
+KernelVersion:	6.0.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Shows the operation capability bits displayed in bitmap format
+		presented by %*pb printk() output format specifier.
+		The attribute can be configured when the WQ is disabled in
+		order to configure the WQ to accept specific bits that
+		correlates to the operations allowed. It's visible only
+		on platforms that support the capability.
+
 What:           /sys/bus/dsa/devices/engine<m>.<n>/group_id
 Date:           Oct 25, 2019
 KernelVersion:  5.6.0
diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index bbc3c8b9a10f..81a81b8d769d 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -389,6 +389,8 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	memset(wq->name, 0, WQ_NAME_SIZE);
 	wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
 	wq->max_batch_size = WQ_DEFAULT_MAX_BATCH;
+	if (wq->opcap_bmap)
+		bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
 }
 
 static void idxd_wq_device_reset_cleanup(struct idxd_wq *wq)
@@ -807,7 +809,7 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
 	u32 wq_offset;
-	int i;
+	int i, n;
 
 	if (!wq->group)
 		return 0;
@@ -865,6 +867,17 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
 	wq->wqcfg->max_xfer_shift = ilog2(wq->max_xfer_bytes);
 	wq->wqcfg->max_batch_shift = ilog2(wq->max_batch_size);
 
+	/* bytes 32-63 */
+	if (idxd->hw.wq_cap.op_config && wq->opcap_bmap) {
+		memset(wq->wqcfg->op_config, 0, IDXD_MAX_OPCAP_BITS / 8);
+		for_each_set_bit(n, wq->opcap_bmap, IDXD_MAX_OPCAP_BITS) {
+			int pos = n % BITS_PER_LONG_LONG;
+			int idx = n / BITS_PER_LONG_LONG;
+
+			wq->wqcfg->op_config[idx] |= BIT(pos);
+		}
+	}
+
 	dev_dbg(dev, "WQ %d CFGs\n", wq->id);
 	for (i = 0; i < WQCFG_STRIDES(idxd); i++) {
 		wq_offset = WQCFG_OFFSET(idxd, wq->id, i);
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 3ab406d74176..ba877ad31932 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -195,6 +195,8 @@ struct idxd_wq {
 	enum idxd_wq_state state;
 	unsigned long flags;
 	union wqcfg *wqcfg;
+	unsigned long *opcap_bmap;
+
 	struct dsa_hw_desc **hw_descs;
 	int num_descs;
 	union {
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 913a55ccb864..bee685bf3ce5 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -185,6 +185,16 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 			rc = -ENOMEM;
 			goto err;
 		}
+
+		if (idxd->hw.wq_cap.op_config) {
+			wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
+			if (!wq->opcap_bmap) {
+				put_device(conf_dev);
+				rc = -ENOMEM;
+				goto err;
+			}
+			bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
+		}
 		idxd->wqs[i] = wq;
 	}
 
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 4c96ea85f843..7b95be8f0f64 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -54,7 +54,8 @@ union wq_cap_reg {
 		u64 priority:1;
 		u64 occupancy:1;
 		u64 occupancy_int:1;
-		u64 rsvd3:10;
+		u64 op_config:1;
+		u64 rsvd3:9;
 	};
 	u64 bits;
 } __packed;
@@ -350,8 +351,11 @@ union wqcfg {
 
 		/* bytes 28-31 */
 		u32 rsvd8;
+
+		/* bytes 32-63 */
+		u64 op_config[4];
 	};
-	u32 bits[8];
+	u32 bits[16];
 } __packed;
 
 #define WQCFG_PASID_IDX                2
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 9998ab4b28c8..3bb1ea02a338 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1058,6 +1058,68 @@ static ssize_t wq_enqcmds_retries_store(struct device *dev, struct device_attrib
 static struct device_attribute dev_attr_wq_enqcmds_retries =
 		__ATTR(enqcmds_retries, 0644, wq_enqcmds_retries_show, wq_enqcmds_retries_store);
 
+static ssize_t wq_op_config_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct idxd_wq *wq = confdev_to_wq(dev);
+
+	return sysfs_emit(buf, "%*pb\n", IDXD_MAX_OPCAP_BITS, wq->opcap_bmap);
+}
+
+static int idxd_verify_supported_opcap(struct idxd_device *idxd, unsigned long *opmask)
+{
+	int bit;
+
+	/*
+	 * The OPCAP is defined as 256 bits that represents each operation the device
+	 * supports per bit. Iterate through all the bits and check if the input mask
+	 * is set for bits that are not set in the OPCAP for the device. If no OPCAP
+	 * bit is set and input mask has the bit set, then return error.
+	 */
+	for_each_set_bit(bit, opmask, IDXD_MAX_OPCAP_BITS) {
+		if (!test_bit(bit, idxd->opcap_bmap))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static ssize_t wq_op_config_store(struct device *dev, struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct idxd_wq *wq = confdev_to_wq(dev);
+	struct idxd_device *idxd = wq->idxd;
+	unsigned long *opmask;
+	int rc;
+
+	if (wq->state != IDXD_WQ_DISABLED)
+		return -EPERM;
+
+	opmask = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
+	if (!opmask)
+		return -ENOMEM;
+
+	rc = bitmap_parse(buf, count, opmask, IDXD_MAX_OPCAP_BITS);
+	if (rc < 0)
+		goto err;
+
+	rc = idxd_verify_supported_opcap(idxd, opmask);
+	if (rc < 0)
+		goto err;
+
+	bitmap_copy(wq->opcap_bmap, opmask, IDXD_MAX_OPCAP_BITS);
+
+	bitmap_free(opmask);
+	return count;
+
+err:
+	bitmap_free(opmask);
+	return rc;
+}
+
+static struct device_attribute dev_attr_wq_op_config =
+		__ATTR(op_config, 0644, wq_op_config_show, wq_op_config_store);
+
 static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_clients.attr,
 	&dev_attr_wq_state.attr,
@@ -1075,11 +1137,33 @@ static struct attribute *idxd_wq_attributes[] = {
 	&dev_attr_wq_ats_disable.attr,
 	&dev_attr_wq_occupancy.attr,
 	&dev_attr_wq_enqcmds_retries.attr,
+	&dev_attr_wq_op_config.attr,
 	NULL,
 };
 
+static bool idxd_wq_attr_op_config_invisible(struct attribute *attr,
+					     struct idxd_device *idxd)
+{
+	return attr == &dev_attr_wq_op_config.attr &&
+	       !idxd->hw.wq_cap.op_config;
+}
+
+static umode_t idxd_wq_attr_visible(struct kobject *kobj,
+				    struct attribute *attr, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct idxd_wq *wq = confdev_to_wq(dev);
+	struct idxd_device *idxd = wq->idxd;
+
+	if (idxd_wq_attr_op_config_invisible(attr, idxd))
+		return 0;
+
+	return attr->mode;
+}
+
 static const struct attribute_group idxd_wq_attribute_group = {
 	.attrs = idxd_wq_attributes,
+	.is_visible = idxd_wq_attr_visible,
 };
 
 static const struct attribute_group *idxd_wq_attribute_groups[] = {
@@ -1091,6 +1175,7 @@ static void idxd_conf_wq_release(struct device *dev)
 {
 	struct idxd_wq *wq = confdev_to_wq(dev);
 
+	bitmap_free(wq->opcap_bmap);
 	kfree(wq->wqcfg);
 	kfree(wq);
 }
-- 
2.32.0

