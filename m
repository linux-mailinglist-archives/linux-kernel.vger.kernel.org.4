Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28C717440
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 05:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjEaDQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 23:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjEaDPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 23:15:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A96133
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685502938; x=1717038938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cDPxAfvdGUM1tm5hvXaDY204P9qt4B3UxsBRfKyYP3M=;
  b=GgDfbPpZPyDMPUO5i/9fGXLmmB/AcKCYbDJNPl3Wd7pb6woBKhQIabsx
   aWOCfhLbwZqQMU4X+H7Sv5Ro4Qanjqa/a7zhjR++KJtkN7BaCxgSAMUWm
   mg9+cGZEYl8oeUQGjDKBKzfCgYnp0yZE2fRpIluIhAX70UxaScRfOKB+l
   jY2t1hFfx1QlGbe3Z6TJvUQRES3OThR0HAgUaTk1tVMu3JGYwtIliozm4
   gK8UK+1EZAsbYs9DWF/ztYdEYvyXImbNj5g0PsxhFd0HY6s406vi4hL/o
   fRQ0UD7Z4JchkB9DcjrzvBOExeLStVi9tsd3Anbcovffy+Yo7GGB6DjXQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="357507661"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="357507661"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:15:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="739769514"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="739769514"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:15:36 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 2/4] soundwire: introduce SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY
Date:   Wed, 31 May 2023 11:37:34 +0800
Message-Id: <20230531033736.792464-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531033736.792464-1-yung-chuan.liao@linux.intel.com>
References: <20230531033736.792464-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This patch adds a new Device Number allocation strategy, with the IDA
used only for devices that are wake-capable.

"regular" devices such as amplifiers will use Device Numbers
[1..min_ida-1].

"wake-capable" devices such as jack or microphone codecs will use
Device Numbers [min_ida..11].

This hybrid strategy extends the number of supported devices in a
system by only constraining the allocation if required, e.g. in the
case of Intel LunarLake platforms the wake-capable devices are
required to have a unique address to use the HDaudio SDI and HDAudio
WAKEEN/WAKESTS registers.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c       | 26 +++++++++++++++++++++-----
 include/linux/soundwire/sdw.h |  4 ++++
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index e8c1c55a2a73..6f465cce8369 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -159,7 +159,9 @@ static int sdw_delete_slave(struct device *dev, void *data)
 
 	if (slave->dev_num) { /* clear dev_num if assigned */
 		clear_bit(slave->dev_num, bus->assigned);
-		if (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA)
+		if (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA ||
+		    (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY &&
+		     slave->prop.wake_capable))
 			ida_free(&sdw_peripheral_ida, slave->dev_num);
 	}
 	list_del_init(&slave->node);
@@ -699,17 +701,31 @@ EXPORT_SYMBOL(sdw_compare_devid);
 /* called with bus_lock held */
 static int sdw_get_device_num(struct sdw_slave *slave)
 {
+	struct sdw_bus *bus = slave->bus;
 	int bit;
 
-	if (slave->bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA) {
+	if (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA ||
+	    (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY &&
+	     slave->prop.wake_capable)) {
 		bit = ida_alloc_range(&sdw_peripheral_ida,
-				      slave->bus->dev_num_ida_min, SDW_MAX_DEVICES,
+				      bus->dev_num_ida_min, SDW_MAX_DEVICES,
 				      GFP_KERNEL);
 		if (bit < 0)
 			goto err;
 	} else {
-		bit = find_first_zero_bit(slave->bus->assigned, SDW_MAX_DEVICES);
-		if (bit == SDW_MAX_DEVICES) {
+		int max_devices = SDW_MAX_DEVICES;
+
+		if (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY &&
+		    !slave->prop.wake_capable) {
+			max_devices = bus->dev_num_ida_min - 1;
+
+			/* range check */
+			if (max_devices < 1 || max_devices > SDW_MAX_DEVICES)
+				return -EINVAL;
+		}
+
+		bit = find_first_zero_bit(bus->assigned, max_devices);
+		if (bit == max_devices) {
 			bit = -ENODEV;
 			goto err;
 		}
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 4656d6d0f3bb..8a7541ac735e 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -869,10 +869,14 @@ struct sdw_master_ops {
  * @SDW_DEV_NUM_ALLOC_DEFAULT: unconstrained first-come-first-serve allocation,
  * using range [1, 11]
  * @SDW_DEV_NUM_ALLOC_IDA: IDA-based allocation, using range [ida_min, 11]
+ * @SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY: Hybrid allocation where wake-capable devices rely on
+ * IDA-based allocation and range [ida_min, 11], while regular devices rely on default
+ * allocation in range [1, ida_min - 1]
  */
 enum sdw_dev_num_alloc {
 	SDW_DEV_NUM_ALLOC_DEFAULT = 0,
 	SDW_DEV_NUM_ALLOC_IDA,
+	SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY,
 };
 
 /**
-- 
2.25.1

