Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1396663C7D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbiK2TLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbiK2TKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:10:47 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C435B844
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669749046; x=1701285046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e37VGWZJt5D4i22LVtIZLifzbTAg/lau23PCib3BX/M=;
  b=Z9A08qGReGDcgdfyrgS6mVuxHyOHnv8Z/X8UCvSKgfFrVU1OOnZcF2ft
   SZwlcoDHm76cURqbgEZazAgOm+4lEqTyjbBsWewiIAmEqPIKAGxTWG/zh
   zaAV7iJQvqt+ffXTsf+LpQ0Ozkpx9awiQuzPuXJDDNnejuaKLPxV6Ds4z
   za/k0NfGycwYz9NrshEbfm3ammcFIVqBAbEFKjSwl0YqG4p8NHFzM1V+Q
   dp/wt/sGNkWBZZbbYZTBCnpe7FLKHOvrWLsBeDbw/E+G+xkA19U4i/vvq
   VaT1sVsQo2MDK1mKWZvGhGnoa+1uMnFCM7SWp7D1a8Eea7wb0rJvpwxGt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379490791"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="379490791"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 11:10:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="749992012"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="749992012"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 29 Nov 2022 11:10:35 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     steve.wahl@hpe.com, alexander.antonov@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, namhyung@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 5/5] perf/x86/uncore: Don't WARN_ON_ONCE() for a broken discovery table
Date:   Tue, 29 Nov 2022 11:10:23 -0800
Message-Id: <20221129191023.936738-6-kan.liang@linux.intel.com>
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

The kernel warning message is triggered, when SPR MCC is used.

[   17.945331] ------------[ cut here ]------------
[   17.946305] WARNING: CPU: 65 PID: 1 at
arch/x86/events/intel/uncore_discovery.c:184
intel_uncore_has_discovery_tables+0x4c0/0x65c
[   17.946305] Modules linked in:
[   17.946305] CPU: 65 PID: 1 Comm: swapper/0 Not tainted
5.4.17-2136.313.1-X10-2c+ #4

It's caused by the broken discovery table of UPI.

The discovery tables are from hardware. Except for dropping the broken
information, there is nothing Linux can do. Using WARN_ON_ONCE() is
overkilled.

Use the pr_info() to replace WARN_ON_ONCE(), and specify what uncore unit
is dropped and the reason.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_discovery.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index abb51191f5af..cb488e41807c 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -128,13 +128,21 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 	unsigned int *box_offset, *ids;
 	int i;
 
-	if (WARN_ON_ONCE(!unit->ctl || !unit->ctl_offset || !unit->ctr_offset))
+	if (!unit->ctl || !unit->ctl_offset || !unit->ctr_offset) {
+		pr_info("Invalid address is detected for uncore type %d box %d, "
+			"Disable the uncore unit.\n",
+			unit->box_type, unit->box_id);
 		return;
+	}
 
 	if (parsed) {
 		type = search_uncore_discovery_type(unit->box_type);
-		if (WARN_ON_ONCE(!type))
+		if (!type) {
+			pr_info("A spurious uncore type %d is detected, "
+				"Disable the uncore type.\n",
+				unit->box_type);
 			return;
+		}
 		/* Store the first box of each die */
 		if (!type->box_ctrl_die[die])
 			type->box_ctrl_die[die] = unit->ctl;
@@ -169,8 +177,12 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
 		ids[i] = type->ids[i];
 		box_offset[i] = type->box_offset[i];
 
-		if (WARN_ON_ONCE(unit->box_id == ids[i]))
+		if (unit->box_id == ids[i]) {
+			pr_info("Duplicate uncore type %d box ID %d is detected, "
+				"Drop the duplicate uncore unit.\n",
+				unit->box_type, unit->box_id);
 			goto free_ids;
+		}
 	}
 	ids[i] = unit->box_id;
 	box_offset[i] = unit->ctl - type->box_ctrl;
-- 
2.35.1

