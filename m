Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B8266835B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbjALUHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241711AbjALUEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:04:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1EAF02
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673553720; x=1705089720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e37VGWZJt5D4i22LVtIZLifzbTAg/lau23PCib3BX/M=;
  b=bCMvjiTG/ho/kifhzeDmVRehAYdRxFh2ZXcDdv1oqo+7ia5aZ5CfH/qH
   BR7TLnw4SdEG76BvWX+LxjFj4QlDR2bf2TnGSw6NduG9py4nnjdTbDWJE
   yMOFOIpyyQCgfbjk/b4LqVhSSVOvC1ja4D3t8nqlwLXXt+eFeToFAEi4V
   f58xn9rlpYqM1ALoqG5EMwOeskDrDXNwoa6tJZGpKVmu4XRtadTRIEcJF
   jKdlfIrqUw1WVahJgYQxCFDP5SFV6dinWkINX/H0uqH9qFdi+psSYrjZp
   UQAbJZmMOLBgioR0B0bGe2akpHdiCbE38fZ8/dkrn262jY9dVIwqcGo9b
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325867126"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="325867126"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 12:01:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="657959932"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="657959932"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 12 Jan 2023 12:01:29 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     steve.wahl@hpe.com, alexander.antonov@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, namhyung@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH RESEND 5/5] perf/x86/uncore: Don't WARN_ON_ONCE() for a broken discovery table
Date:   Thu, 12 Jan 2023 12:01:05 -0800
Message-Id: <20230112200105.733466-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230112200105.733466-1-kan.liang@linux.intel.com>
References: <20230112200105.733466-1-kan.liang@linux.intel.com>
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

