Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4402262DADC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbiKQM3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240046AbiKQM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:29:02 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B28F71F0B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668688130; x=1700224130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tu5hfH1gOVi8ggjfgqKXzyBxrujRcHxaUOVPTnTNUmQ=;
  b=KegWIQoACO7JAC46xwHixt8VEAJ8od798RGR9MVf4AmmeVzPh//PBQBB
   lWGMk+k//4sCDMAuBRB1zyqGR/kupBSwTCnJlbs6rgrAuehizzlcWvMum
   9mds3et4Sk6h+seOa/aZOguJwuCRnfh4o2a1jGpG5ny55Vbgh8aiNl/Yv
   QoeQgHoM/XtSYF+PDLrZJCw1DahG+XSjl/4nef1ZHhkknu5bEhRr4Mk5D
   NqxcbOZSeTNXxMIMBne7cdLX8b3pkZ7DY+rU0hD+JZ/Uwla+E7QbgCPiw
   DKKpq+IswbbdFqG/SGuXYr80HuEHV6PDlS3LRUYscVKUp0Wa33eqemIzs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296199868"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296199868"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:28:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590604553"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="590604553"
Received: from jfdev013vml03.jf.intel.com ([10.23.26.52])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2022 04:28:46 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 03/11] perf/x86/intel/uncore: Clear attr_update properly
Date:   Thu, 17 Nov 2022 12:28:25 +0000
Message-Id: <20221117122833.3103580-4-alexander.antonov@linux.intel.com>
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

Current clear_attr_update procedure in pmu_set_mapping() sets attr_update
field in NULL that is not correct because intel_uncore_type pmu types can
contain several groups in attr_update field. For example, SPR platform
already has uncore_alias_group to update and then UPI topology group will
be added in next patches.

Fix current behavior and clear attr_update group related to mapping only.

Fixes: bb42b3d39781 ("perf/x86/intel/uncore: Expose an Uncore unit to IIO PMON mapping")
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/uncore_snbep.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index d3323f13c304..0d06b56b8a33 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3872,6 +3872,21 @@ static const struct attribute_group *skx_iio_attr_update[] = {
 	NULL,
 };
 
+static void pmu_clear_mapping_attr(const struct attribute_group **groups,
+				   struct attribute_group *ag)
+{
+	int i;
+
+	for (i = 0; groups[i]; i++) {
+		if (groups[i] == ag) {
+			for (i++; groups[i]; i++)
+				groups[i - 1] = groups[i];
+			groups[i - 1] = NULL;
+			break;
+		}
+	}
+}
+
 static int
 pmu_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag,
 		ssize_t (*show)(struct device*, struct device_attribute*, char*),
@@ -3926,7 +3941,7 @@ pmu_set_mapping(struct intel_uncore_type *type, struct attribute_group *ag,
 clear_topology:
 	pmu_free_topology(type);
 clear_attr_update:
-	type->attr_update = NULL;
+	pmu_clear_mapping_attr(type->attr_update, ag);
 	return ret;
 }
 
-- 
2.25.1

