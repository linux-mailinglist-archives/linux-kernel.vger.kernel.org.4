Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8182C71743F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 05:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjEaDP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 23:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjEaDPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 23:15:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60023134
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685502936; x=1717038936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GccidoCGBBrPr39HCfpwoXhpbs9LH6bwAbwZCyps1i8=;
  b=Q8MKHHFRjnGjQENvS/zgsaJfhI7aasNBPpCLY7rjuReOeGNtxuNQUbRb
   I3nhHG6msVmA5ojN7eP3/39l7NudhciJoe5rmydvnd1h9eCIDWT1LvyIM
   1RVkY6MhB/Rd2YlEm3ih4CxJciN9E07VN0Hi9x1cVNLH4roCNzUti0ARC
   MpRBgtezmHlgpaUqqPmMeOClQ0lTLRCtQXEBUlb1Kil7mLxCAVIMCGb7A
   AhAcdZCwoGn99jCUgZc0bhR3F5dRojuiOyJ7ELH83fqhw7O8CD4M9zSa6
   5alDP0jItFJSiwtljcbuB0s3kKBWxB3Vb+k+LWNX2YBWpWCfHDThEBwJ0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="357507655"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="357507655"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:15:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="739769481"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="739769481"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:15:34 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 1/4] soundwire: add enum to control device number allocation
Date:   Wed, 31 May 2023 11:37:33 +0800
Message-Id: <20230531033736.792464-2-yung-chuan.liao@linux.intel.com>
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

Commit c60561014257 ("soundwire: bus: allow device number to be unique
at system level") introduced two strategies to allocate device
numbers.

a) a default unconstrained allocation, where each bus can allocate
Device Numbers independently.

b) an ida-based allocation. In this case each Device Number will be
unique at the system-level.

The IDA-based allocation is useful to simplify debug, but it was also
introduced as a prerequisite to deal with the Intel Lunar Lake
hardware programming sequences: the wake-ups have to be handled with a
system-unique SDI address at the HDaudio controller level.

At the time, the restriction introduced by the IDA to 8 devices total
seemed perfectly fine, but recently hardware vendors created
configurations with more than 8 devices.

This patch provides an iso-functionality change, with the allocation
selected with an enum instead of an 'ida_min' value. Follow-up patches
will add a new allocation strategy to allow for more than 8 devices
using information on the type of devices, and only use the IDA-based
allocation for devices capable of generating a wake.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c             |  4 ++--
 drivers/soundwire/intel_auxdevice.c |  1 +
 include/linux/soundwire/sdw.h       | 16 +++++++++++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index b44f8d0affa6..e8c1c55a2a73 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -159,7 +159,7 @@ static int sdw_delete_slave(struct device *dev, void *data)
 
 	if (slave->dev_num) { /* clear dev_num if assigned */
 		clear_bit(slave->dev_num, bus->assigned);
-		if (bus->dev_num_ida_min)
+		if (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA)
 			ida_free(&sdw_peripheral_ida, slave->dev_num);
 	}
 	list_del_init(&slave->node);
@@ -701,7 +701,7 @@ static int sdw_get_device_num(struct sdw_slave *slave)
 {
 	int bit;
 
-	if (slave->bus->dev_num_ida_min) {
+	if (slave->bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA) {
 		bit = ida_alloc_range(&sdw_peripheral_ida,
 				      slave->bus->dev_num_ida_min, SDW_MAX_DEVICES,
 				      GFP_KERNEL);
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 0daa6ca9a224..30f3d2ab80fd 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -165,6 +165,7 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
 	cdns->msg_count = 0;
 
 	bus->link_id = auxdev->id;
+	bus->dev_num_alloc = SDW_DEV_NUM_ALLOC_IDA;
 	bus->dev_num_ida_min = INTEL_DEV_NUM_IDA_MIN;
 	bus->clk_stop_timeout = 1;
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index c076a3f879b3..4656d6d0f3bb 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -864,6 +864,17 @@ struct sdw_master_ops {
 	void (*new_peripheral_assigned)(struct sdw_bus *bus, int dev_num);
 };
 
+/**
+ * enum sdw_dev_num_alloc - Device Number allocation strategies
+ * @SDW_DEV_NUM_ALLOC_DEFAULT: unconstrained first-come-first-serve allocation,
+ * using range [1, 11]
+ * @SDW_DEV_NUM_ALLOC_IDA: IDA-based allocation, using range [ida_min, 11]
+ */
+enum sdw_dev_num_alloc {
+	SDW_DEV_NUM_ALLOC_DEFAULT = 0,
+	SDW_DEV_NUM_ALLOC_IDA,
+};
+
 /**
  * struct sdw_bus - SoundWire bus
  * @dev: Shortcut to &bus->md->dev to avoid changing the entire code.
@@ -895,9 +906,11 @@ struct sdw_master_ops {
  * meaningful if multi_link is set. If set to 1, hardware-based
  * synchronization will be used even if a stream only uses a single
  * SoundWire segment.
+ * @dev_num_alloc: bus-specific device number allocation
  * @dev_num_ida_min: if set, defines the minimum values for the IDA
  * used to allocate system-unique device numbers. This value needs to be
- * identical across all SoundWire bus in the system.
+ * identical across all SoundWire bus in the system. Only used if @sdw_num_alloc
+ * is not default.
  */
 struct sdw_bus {
 	struct device *dev;
@@ -922,6 +935,7 @@ struct sdw_bus {
 	u32 bank_switch_timeout;
 	bool multi_link;
 	int hw_sync_min_links;
+	enum sdw_dev_num_alloc dev_num_alloc;
 	int dev_num_ida_min;
 };
 
-- 
2.25.1

