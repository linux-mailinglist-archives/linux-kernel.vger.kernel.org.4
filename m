Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EFE738D60
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjFURlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjFURkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:40:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265FD19B;
        Wed, 21 Jun 2023 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687369242; x=1718905242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dhSYaV/feip3Bku5n5e/swWWwTp+mDFZDryH6jxbEoc=;
  b=UPnHMomi8eaapNnXx/y37gfGqF3wQKkbY97EqxYXLwYG8HJ5ys3/9XXW
   +HtBB68Y0QOvJEUUOPolPGZQEg7HEwUBq1Zn7DCRwofwQyPt9ceQQ63Xp
   /MaqvYfV3iLJHFJL5oi1opLBnCMsbfOy5QhjXUYs1tY0b9V59UC/0kF2X
   5x/JxtRXKiFACDv3k/ViToJiU/2PVEoQyEYq6OgdyPGPfuynuf87Kyk2q
   GVij6nTXugF+zLqi72Cdj8UvMFBozl/dFg96gudrKI+aMOGG4ek8ZeX+T
   CbPBAuWHhoVgDIOTVjq+QU2pofJbhqeS6c6fJ+G+QjX83eL7GGoQoOnLq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="359120514"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="359120514"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:40:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="779921564"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="779921564"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:40:16 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 2/7] x86/resctrl: Remove hard code of RDT_RESOURCE_L3 in monitor.c
Date:   Wed, 21 Jun 2023 10:40:01 -0700
Message-Id: <20230621174006.42533-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621174006.42533-1-tony.luck@intel.com>
References: <20230621174006.42533-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scope of monitoring may be scoped at L3 cache granularity (legacy) or
at the node level (systems with Sub NUMA Cluster enabled).

Save the struct rdt_resource pointer that was used to initialize
the monitor sections of code and use that value instead of the
hard-coded RDT_RESOURCE_L3.

No functional change.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ded1fc7cb7cb..9be6ffdd01ae 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -30,6 +30,8 @@ struct rmid_entry {
 	struct list_head		list;
 };
 
+static struct rdt_resource *mon_resource;
+
 /**
  * @rmid_free_lru    A least recently used list of free RMIDs
  *     These RMIDs are guaranteed to have an occupancy less than the
@@ -268,7 +270,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
  */
 void __check_limbo(struct rdt_domain *d, bool force_free)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_resource *r = mon_resource;
 	struct rmid_entry *entry;
 	u32 crmid = 1, nrmid;
 	bool rmid_dirty;
@@ -333,7 +335,7 @@ int alloc_rmid(void)
 
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_resource *r = mon_resource;
 	struct rdt_domain *d;
 	int cpu, err;
 	u64 val = 0;
@@ -645,7 +647,7 @@ void cqm_handle_limbo(struct work_struct *work)
 
 	mutex_lock(&rdtgroup_mutex);
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	r = mon_resource;
 	d = container_of(work, struct rdt_domain, cqm_limbo.work);
 
 	__check_limbo(d, false);
@@ -681,7 +683,7 @@ void mbm_handle_overflow(struct work_struct *work)
 	if (!static_branch_likely(&rdt_mon_enable_key))
 		goto out_unlock;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	r = mon_resource;
 	d = container_of(work, struct rdt_domain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
@@ -759,9 +761,9 @@ static struct mon_evt mbm_local_event = {
 /*
  * Initialize the event list for the resource.
  *
- * Note that MBM events are also part of RDT_RESOURCE_L3 resource
- * because as per the SDM the total and local memory bandwidth
- * are enumerated as part of L3 monitoring.
+ * Monitor events can either be part of RDT_RESOURCE_L3 resource,
+ * or they may be per NUMA node on systems with sub-NUMA cluster
+ * enabled and are then in the RDT_RESOURCE_NODE resource.
  */
 static void l3_mon_evt_init(struct rdt_resource *r)
 {
@@ -773,6 +775,8 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 		list_add_tail(&mbm_total_event.list, &r->evt_list);
 	if (is_mbm_local_enabled())
 		list_add_tail(&mbm_local_event.list, &r->evt_list);
+
+	mon_resource = r;
 }
 
 int __init rdt_get_mon_l3_config(struct rdt_resource *r)
-- 
2.40.1

