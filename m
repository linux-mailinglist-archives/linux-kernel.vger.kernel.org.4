Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7088F62DAD9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbiKQM3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbiKQM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:29:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5512571F3E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668688130; x=1700224130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AcazR/H20mISo14KS0UTsyO1aBphJqbxGL1MXlKHjqU=;
  b=eT3i2dXRs21nQZVRFfhdaBfpjjcLePvajbtaUZNjXNdP1nWe9B8WUJfW
   lPzs06VuOTS2nafCZmle1kuEBTAOZEJjz38khrY3yB1Jk3wFfMuo9hI/5
   BcM0p1DcGi4hYPEXfqs7xx8dASOoIAGAw9w+a7zewtwU36VHFJsR8zjqJ
   wy9IQ/oaJQuHJKzAV9sgjpRsntZY8Sld/KRxlEYF/m8C6gSCqwhwgWIpq
   FOsxVEyj2Bs9ftZo1Px4bAx7I7YTimBWjY+0MIuTEVrFzENd2cEGn6sJ3
   cHHTE8qKQfTd1eDk10YX8JoVa3eBOEuhy50eNo4jyBMdRnekZiVQOmUUT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296199871"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296199871"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:28:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590604555"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="590604555"
Received: from jfdev013vml03.jf.intel.com ([10.23.26.52])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2022 04:28:46 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 05/11] perf/x86/intel/uncore: Generalize get_topology() for SKX PMUs
Date:   Thu, 17 Nov 2022 12:28:27 +0000
Message-Id: <20221117122833.3103580-6-alexander.antonov@linux.intel.com>
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

Factor out a generic code from skx_iio_get_topology() to skx_pmu_get_topology()
to avoid code duplication. This code will be used by get_topology() procedure
for SKX UPI PMUs in the further patch.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 38 ++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index e14b96398377..254ba0ad650a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3837,14 +3837,14 @@ static void pmu_free_topology(struct intel_uncore_type *type)
 	}
 }
 
-static int skx_iio_get_topology(struct intel_uncore_type *type)
+static int skx_pmu_get_topology(struct intel_uncore_type *type,
+				 int (*topology_cb)(struct intel_uncore_type*, int, int, u64))
 {
 	int die, ret = -EPERM;
-	u64 configuration;
-	int idx;
+	u64 cpu_bus_msr;
 
 	for (die = 0; die < uncore_max_dies(); die++) {
-		ret = skx_msr_cpu_bus_read(die_to_cpu(die), &configuration);
+		ret = skx_msr_cpu_bus_read(die_to_cpu(die), &cpu_bus_msr);
 		if (ret)
 			break;
 
@@ -3852,17 +3852,35 @@ static int skx_iio_get_topology(struct intel_uncore_type *type)
 		if (ret < 0)
 			break;
 
-		for (idx = 0; idx < type->num_boxes; idx++) {
-			type->topology[die][idx].pmu_idx = idx;
-			type->topology[die][idx].iio->segment = ret;
-			type->topology[die][idx].iio->pci_bus_no =
-				(configuration >> (idx * BUS_NUM_STRIDE)) & 0xff;
-		}
+		ret = topology_cb(type, ret, die, cpu_bus_msr);
+		if (ret)
+			break;
 	}
 
 	return ret;
 }
 
+static int skx_iio_topology_cb(struct intel_uncore_type *type, int segment,
+				int die, u64 cpu_bus_msr)
+{
+	int idx;
+	struct intel_uncore_topology *t;
+
+	for (idx = 0; idx < type->num_boxes; idx++) {
+		t = &type->topology[die][idx];
+		t->pmu_idx = idx;
+		t->iio->segment = segment;
+		t->iio->pci_bus_no = (cpu_bus_msr >> (idx * BUS_NUM_STRIDE)) & 0xff;
+	}
+
+	return 0;
+}
+
+static int skx_iio_get_topology(struct intel_uncore_type *type)
+{
+	return skx_pmu_get_topology(type, skx_iio_topology_cb);
+}
+
 static struct attribute_group skx_iio_mapping_group = {
 	.is_visible	= skx_iio_mapping_visible,
 };
-- 
2.25.1

