Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437D2717442
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 05:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjEaDQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 23:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjEaDPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 23:15:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C80180
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 20:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685502942; x=1717038942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZpdxB1tn4u4OhUdxszyZlKy/CjHo5nh+Kt7t5DnOqAw=;
  b=UBcgNj6sOWu9IuJkWwXZ/cQeH8/d9WyMDBCZHs9yaRiz1Z3OfZIXa4MD
   /5lJwWhfDHqzfYIr4zx6yYnbmEhcyR9OLRbr3LnT0QPgD/WytvLWQ01Ed
   T7JMwAUU0jtQj+CnssMXMnZZpVwPsin54p/DtO+zQ31KmgYOtwPncufhV
   mWB5q5AB+6ihxqN0HAhfZmRdOVIWy9eZhN9zIQ1ZGsTsEZe9BUjZUZEii
   /FpYq2+BQF0J04Abeyz+Nc7vquRt383PhciwPN+12IoOR8psvcWE1ikal
   Clptvg66fpdROLiZeU69VYsdrsMLaJG7rEjYlaSmu25adbaU2q3cS6AVJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="357507683"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="357507683"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="739769540"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="739769540"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:15:40 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 4/4] soundwire: intel_auxdevice: use SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY
Date:   Wed, 31 May 2023 11:37:36 +0800
Message-Id: <20230531033736.792464-5-yung-chuan.liao@linux.intel.com>
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

Change the allocation strategy on Intel platforms to use Device Numbers

[1..5]: unconstrained allocation with bus-specific Device Numbers,
typically for amplifiers.

[6..11]: IDA-based system-unique Device Number to be used for
wake-capable devices such as jack codecs or microphone codecs.

These values were chosen based on the typical maximum number of
devices per link given electrical/PHY limitations. This configuration
will e.g. allow for 8 amplifiers on 2 links, and additional devices on
the remaining links.

Example on Dell SDCA device with jack codec, two amplifiers and one
microphone codec: only the jack codec relies on the IDA, others use
the same Device Number 1 on separate links.

rt711-sdca sdw:0:025d:0711:01: signaling enumeration completion for Slave 6
rt1316-sdca sdw:1:025d:1316:01: signaling enumeration completion for Slave 1
rt1316-sdca sdw:2:025d:1316:01: signaling enumeration completion for Slave 1
rt715-sdca sdw:3:025d:0714:01: signaling enumeration completion for Slave 1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel_auxdevice.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index c1df6f014e6b..917edc75ddfb 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -23,8 +23,12 @@
 #include "intel.h"
 #include "intel_auxdevice.h"
 
-/* IDA min selected to avoid conflicts with HDaudio/iDISP SDI values */
-#define INTEL_DEV_NUM_IDA_MIN           4
+/*
+ * IDA min selected to allow for 5 unconstrained devices per link,
+ * and 6 system-unique Device Numbers for wake-capable devices.
+ */
+
+#define INTEL_DEV_NUM_IDA_MIN           6
 
 #define INTEL_MASTER_SUSPEND_DELAY_MS	3000
 
@@ -66,9 +70,20 @@ static void generic_new_peripheral_assigned(struct sdw_bus *bus,
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	int min_dev = 1;
+	int max_dev = SDW_MAX_DEVICES;
+
+	if (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA) {
+		min_dev = INTEL_DEV_NUM_IDA_MIN;
+	} else if (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY) {
+		if (slave->prop.wake_capable)
+			min_dev = INTEL_DEV_NUM_IDA_MIN;
+		else
+			max_dev = INTEL_DEV_NUM_IDA_MIN - 1;
+	}
 
 	/* paranoia check, this should never happen */
-	if (dev_num < INTEL_DEV_NUM_IDA_MIN || dev_num > SDW_MAX_DEVICES)  {
+	if (dev_num < min_dev || dev_num > max_dev)  {
 		dev_err(bus->dev, "%s: invalid dev_num %d\n", __func__, dev_num);
 		return;
 	}
@@ -167,7 +182,7 @@ static int intel_link_probe(struct auxiliary_device *auxdev,
 	cdns->msg_count = 0;
 
 	bus->link_id = auxdev->id;
-	bus->dev_num_alloc = SDW_DEV_NUM_ALLOC_IDA;
+	bus->dev_num_alloc = SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY;
 	bus->dev_num_ida_min = INTEL_DEV_NUM_IDA_MIN;
 	bus->clk_stop_timeout = 1;
 
-- 
2.25.1

