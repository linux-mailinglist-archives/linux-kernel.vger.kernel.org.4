Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB4662DAE1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbiKQMaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiKQM3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:29:06 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA882725D5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668688131; x=1700224131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LS4csCspXL+rIOXLV2JQBdKyVNCUcCeKYclRfWXseug=;
  b=bUxte9pkKdrlx6CiJv/6NNWRcSFPWXd1KE9M1L2RAfX5QmN2LtdQN5zR
   ioIDGL0trAivSx2dqiKDWGH2VRQJiOL2KFkrGkH0GRL0824eVSxPv5u4S
   nnrcfaYWq4Sj5e7fomSHaE95RdkhuuAsifKtKP4KqVz8I1euWNiwbNzeX
   HQDJm6jh7zb1QR1uR/XyKLZWlGA2nhGOxK6XvmyhPHAfls2QBfmdXPZls
   fQHRcduhjdYm0s6n+zLqsXjf0ol6UmuLR0K2CXOzaHBzVqc7DGSTsjAnQ
   m4gF8VuGEOT7udGpdjq7L5XSHcrAF5WTREwJxzeaCH2O48Jh/Rou5BSCA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296199876"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296199876"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:28:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590604560"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="590604560"
Received: from jfdev013vml03.jf.intel.com ([10.23.26.52])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2022 04:28:47 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 10/11] perf/x86/intel/uncore: Update sysfs-devices-mapping file
Date:   Thu, 17 Nov 2022 12:28:32 +0000
Message-Id: <20221117122833.3103580-11-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117122833.3103580-1-alexander.antonov@linux.intel.com>
References: <20221117122833.3103580-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

Add description for /sys/devices/uncore_upi_*/die* attributes to
sysfs-devices-mapping.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 .../ABI/testing/sysfs-devices-mapping         | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-mapping b/Documentation/ABI/testing/sysfs-devices-mapping
index 8d202bac9394..2eee1446ad4c 100644
--- a/Documentation/ABI/testing/sysfs-devices-mapping
+++ b/Documentation/ABI/testing/sysfs-devices-mapping
@@ -1,6 +1,6 @@
 What:           /sys/devices/uncore_iio_x/dieX
 Date:           February 2020
-Contact:        Roman Sudarikov <roman.sudarikov@linux.intel.com>
+Contact:        Alexander Antonov <alexander.antonov@linux.intel.com>
 Description:
                 Each IIO stack (PCIe root port) has its own IIO PMON block, so
                 each dieX file (where X is die number) holds "Segment:Root Bus"
@@ -32,3 +32,31 @@ Description:
 		    IIO PMU 0 on die 1 belongs to PCI RP on bus 0x40, domain 0x0000
 		    IIO PMU 0 on die 2 belongs to PCI RP on bus 0x80, domain 0x0000
 		    IIO PMU 0 on die 3 belongs to PCI RP on bus 0xc0, domain 0x0000
+
+What:           /sys/devices/uncore_upi_x/dieX
+Date:           March 2022
+Contact:        Alexander Antonov <alexander.antonov@linux.intel.com>
+Description:
+                Each /sys/devices/uncore_upi_X/dieY file holds "upi_Z,die_W"
+                value that means UPI link number X on die Y is connected to UPI
+                link Z on die W and this link between sockets can be monitored
+                by UPI PMON block.
+                For example, 4-die Sapphire Rapids platform has the following
+                UPI 0 topology::
+
+		    # tail /sys/devices/uncore_upi_0/die*
+		    ==> /sys/devices/uncore_upi_0/die0 <==
+		    upi_1,die_1
+		    ==> /sys/devices/uncore_upi_0/die1 <==
+		    upi_0,die_3
+		    ==> /sys/devices/uncore_upi_0/die2 <==
+		    upi_1,die_3
+		    ==> /sys/devices/uncore_upi_0/die3 <==
+		    upi_0,die_1
+
+                Which means::
+
+		    UPI link 0 on die 0 is connected to UPI link 1 on die 1
+		    UPI link 0 on die 1 is connected to UPI link 0 on die 3
+		    UPI link 0 on die 2 is connected to UPI link 1 on die 3
+		    UPI link 0 on die 3 is connected to UPI link 0 on die 1
\ No newline at end of file
-- 
2.25.1

