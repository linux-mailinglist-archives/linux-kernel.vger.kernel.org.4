Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A01062DADE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbiKQM35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbiKQM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:29:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B04F71F29
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668688129; x=1700224129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oSACIbszHk4Xt5Uru3pdS6y+bivSOIaxBarw+nw5xOU=;
  b=VnWlItOKtKUFt3QqNpgBivcI5LnZb5Lfjzwn6U3J3NCu96mrvwi8FB2G
   gNEemdYlVcZTZuUdzLEsa4x+tOJp/90axtc+nM1yj73v1ekd7gk3GtYzZ
   Xqgbz6kCrrbPnoPUNkenXQ/9M0Kpadn87MNDWAOGIOxBx5mOCIkxPDRVm
   AusTHybGEC3szwkWOducjNRCF2MLPWBI4vDnXNNbrnaOnRl8Y5ITwAq94
   RePysSit9tzaZh6hUS3h7o0Ki/4g+OJljrrsWMRnU8AZI1vk/JeNZm5/I
   i8LTNpyestEX+pbotlL12xRiHjFcF9Xt7CaM3D0Ioj2jaxUBwdChu9WlU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296199867"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296199867"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:28:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590604552"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="590604552"
Received: from jfdev013vml03.jf.intel.com ([10.23.26.52])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2022 04:28:46 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 02/11] perf/x86/intel/uncore: Introduce UPI topology type
Date:   Thu, 17 Nov 2022 12:28:24 +0000
Message-Id: <20221117122833.3103580-3-alexander.antonov@linux.intel.com>
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

This patch introduces new 'uncore_upi_topology' topology type to support
UPI topology discovery.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.h       | 7 +++++++
 arch/x86/events/intel/uncore_snbep.c | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 917cff1e7815..ef1414957623 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -183,11 +183,18 @@ struct uncore_iio_topology {
 	int segment;
 };
 
+struct uncore_upi_topology {
+	int die_to;
+	int pmu_idx_to;
+	int enabled;
+};
+
 struct intel_uncore_topology {
 	int pmu_idx;
 	union {
 		void *untyped;
 		struct uncore_iio_topology *iio;
+		struct uncore_upi_topology *upi;
 	};
 };
 
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 469ff889ea08..d3323f13c304 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3774,11 +3774,13 @@ static int die_to_cpu(int die)
 
 enum {
 	IIO_TOPOLOGY_TYPE,
+	UPI_TOPOLOGY_TYPE,
 	TOPOLOGY_MAX
 };
 
 static const size_t topology_size[TOPOLOGY_MAX] = {
-	sizeof(*((struct intel_uncore_topology *)NULL)->iio)
+	sizeof(*((struct intel_uncore_topology *)NULL)->iio),
+	sizeof(*((struct intel_uncore_topology *)NULL)->upi)
 };
 
 static int pmu_alloc_topology(struct intel_uncore_type *type, int topology_type)
-- 
2.25.1

