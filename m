Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9836B63C7D4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiK2TKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiK2TKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:10:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6A830556
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669749045; x=1701285045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NSeYAfZ211QEML4KPYcbjU+itn+gXqaZo2yeuqVu2i0=;
  b=E9uKHfWhgop1pO3srDFUejjztksRHsGBpcJz1Dj6xHcys2jtve6lZ8MW
   EEjlBgFT6k9dJJ2YnOmcAniIJ/7TZvkv21lhC/P3miT/EC3qXke4MuIJv
   f5YFIfj7YPtyGO/VWDc9qp1SJ93vAsNyxNHSY1kjY8yhe9/UHvnlv3q2C
   Ak/Jkkp3rx0BY/14WFyo99V2HLxz3Kw1Yhml4BZ0bNhN9Wl45kGB7m0IS
   Aw1dxvx3Z8CDVSNlDbmt29q95399gjVUWrjSlFEPmJFapkUOExssPhnYH
   E9hIWTZkCW1hVjXBZCW9PqapkrtpMnpuX30PznXW/kqgsgtTNFaO1RBo8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379490770"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="379490770"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 11:10:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="749991998"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="749991998"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 29 Nov 2022 11:10:34 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     steve.wahl@hpe.com, alexander.antonov@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, namhyung@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/5] perf/x86/uncore: Fix potential NULL pointer in uncore_get_alias_name
Date:   Tue, 29 Nov 2022 11:10:20 -0800
Message-Id: <20221129191023.936738-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221129191023.936738-1-kan.liang@linux.intel.com>
References: <20221129191023.936738-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The current code assumes that the discovery table provides valid
box_ids for the normal units. It's not the case anymore since some units
in the discovery table are broken on some SPR variants.

Factor out uncore_get_box_id(). Check the existence of the type->box_ids
before using it. If it's not available, use pmu_idx.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 8caf253be1de..d63be6d1224e 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -857,6 +857,12 @@ static const struct attribute_group uncore_pmu_attr_group = {
 	.attrs = uncore_pmu_attrs,
 };
 
+static inline int uncore_get_box_id(struct intel_uncore_type *type,
+				    struct intel_uncore_pmu *pmu)
+{
+	return type->box_ids ? type->box_ids[pmu->pmu_idx] : pmu->pmu_idx;
+}
+
 void uncore_get_alias_name(char *pmu_name, struct intel_uncore_pmu *pmu)
 {
 	struct intel_uncore_type *type = pmu->type;
@@ -865,7 +871,7 @@ void uncore_get_alias_name(char *pmu_name, struct intel_uncore_pmu *pmu)
 		sprintf(pmu_name, "uncore_type_%u", type->type_id);
 	else {
 		sprintf(pmu_name, "uncore_type_%u_%d",
-			type->type_id, type->box_ids[pmu->pmu_idx]);
+			type->type_id, uncore_get_box_id(type, pmu));
 	}
 }
 
@@ -892,7 +898,7 @@ static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
 		 * Use the box ID from the discovery table if applicable.
 		 */
 		sprintf(pmu->name, "uncore_%s_%d", type->name,
-			type->box_ids ? type->box_ids[pmu->pmu_idx] : pmu->pmu_idx);
+			uncore_get_box_id(type, pmu));
 	}
 }
 
-- 
2.35.1

