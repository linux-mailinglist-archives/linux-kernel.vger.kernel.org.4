Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EA96B0854
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCHNTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjCHNSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:18:31 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3F1CDA28
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:15:10 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id l31-20020a05600c1d1f00b003e8626cdd42so5858372wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 05:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678281308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IWv04zwKPneNYxLs1BbPEMCnf2deIeuFiHgPUvk4fKo=;
        b=ncgPRVcobR0NbnPhgiLgKATtFzK1Pwszpc66U8K4etCXhJRBDORnkwokA8SHqOPvpp
         R6wmTfiSI5L8MeNQxGP4csKkyoUJB42k3+SFCx4CC7n4AG/8Uv/9V6+NvIgciVVz2xjZ
         QBoaRNYoNF4vj4yq9vOhI9vcspOEOw3utNKB9hKAfrMxApTVGdUVJQ2CWvw5AbicENuR
         wqigJLtZqufisVbuPvB3yhEeIN71AZrj1By87XjShYV6sVaXFYx7xI+bOrDyT50aPIMe
         gJXb4llltVotqkXjEEcozWwRj4C1oUOFJdz4MVjdsHPgOgTmO7SnGmZ4zhsJfudpgLPC
         g2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678281308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWv04zwKPneNYxLs1BbPEMCnf2deIeuFiHgPUvk4fKo=;
        b=cvdPTp9deYfdGxtM9Y7A/VMgWULzPt1yvO8j6r7pMpk7MorUaYk1Bksb+suv8FeO96
         a7/bVKa1RqiHm/c3WXcfVFKbIgEG6k4tFCPYyrR+ZOY6YiMBtEfra5kFkWMwDQceKyQw
         JbaAOzovLct7D8T2DA2AF11WYF+X1IlZ8ZSmqkPFagrdRqdo6X7ctmf0+bQcDb8PGWvu
         WtvCHkiYiTQOO1MNDDyS4DzNZh4x/AbHeRsU0j36Z3CfT7nN0isyp0oFKfYiZS5Azwhf
         nuB1hIjKZXv9A6WtxPf4kewwbCxZZGh1SWKTECYvMsy0812eBKGUtZpFiL6Psb56haN6
         OOkw==
X-Gm-Message-State: AO0yUKVjPUorjEzmLBQQh1M7xtP0agLh29P1rYvJu2HdAia6MT3S/y5c
        mLpLGnPFw0odh8e5Zh7nhp/u1LtWegPRfZOx2A==
X-Google-Smtp-Source: AK7set9QjCf1dVDHaqZayVk6eOkGMNkTLTm1LzJGi+y5o7tzPQsmRplexqsVlYqaXv6zbGcUQGhpw6GJf2SM8kpEtQ==
X-Received: from peternewman-vh.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:30cc])
 (user=peternewman job=sendgmr) by 2002:a05:600c:54ce:b0:3df:97a1:75e0 with
 SMTP id iw14-20020a05600c54ce00b003df97a175e0mr3872239wmb.2.1678281308150;
 Wed, 08 Mar 2023 05:15:08 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:14:51 +0100
In-Reply-To: <20230308131452.383914-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230308131452.383914-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230308131452.383914-3-peternewman@google.com>
Subject: [PATCH v4 2/3] x86/resctrl: Parameterize rdt_move_group_tasks() task matching
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, skodak@google.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow rdt_move_group_tasks() to be used for new group-scope operations.
This function is currently only used to implement rmdir on a group or
unmounting resctrlfs.

Callers now provide a filtering function to indicate which tasks should
be moved.

No functional change.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 34 +++++++++++++++++++-------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c3fb525d52e9..84af23a29612 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2393,22 +2393,29 @@ static int reset_all_ctrls(struct rdt_resource *r)
 }
 
 /*
- * Move tasks from one to the other group. If @from is NULL, then all tasks
- * in the systems are moved unconditionally (used for teardown).
+ * Move tasks from one to the other group.
+ *
+ * @from:		passed unmodified to task_match_fn() for each task
+ * @to:			group providing new config values for matching tasks
+ * @task_match_fn:	callback returning true when a task requires update
+ * @mask:		output-parameter indicating set of CPUs impacted by this
+ *			operation
  *
  * If @mask is not NULL the cpus on which moved tasks are running are set
  * in that mask so the update smp function call is restricted to affected
  * cpus.
  */
-static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
-				 struct cpumask *mask)
+static void rdt_move_group_tasks(struct rdtgroup *from,
+				 struct rdtgroup *to,
+				 struct cpumask *mask,
+				 bool task_match_fn(struct task_struct *,
+						    struct rdtgroup *))
 {
 	struct task_struct *p, *t;
 
 	read_lock(&tasklist_lock);
 	for_each_process_thread(p, t) {
-		if (!from || is_closid_match(t, from) ||
-		    is_rmid_match(t, from)) {
+		if (task_match_fn(t, from)) {
 			WRITE_ONCE(t->closid, to->closid);
 			WRITE_ONCE(t->rmid, to->mon.rmid);
 
@@ -2451,6 +2458,15 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
 	}
 }
 
+/*
+ * If @from is NULL, then all tasks in the systems are moved unconditionally
+ * (used for teardown).
+ */
+static bool rmdir_match(struct task_struct *t, struct rdtgroup *from)
+{
+	return !from || is_closid_match(t, from) || is_rmid_match(t, from);
+}
+
 /*
  * Forcibly remove all of subdirectories under root.
  */
@@ -2459,7 +2475,7 @@ static void rmdir_all_sub(void)
 	struct rdtgroup *rdtgrp, *tmp;
 
 	/* Move all tasks to the default resource group */
-	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL);
+	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL, rmdir_match);
 
 	list_for_each_entry_safe(rdtgrp, tmp, &rdt_all_groups, rdtgroup_list) {
 		/* Free any child rmids */
@@ -3124,7 +3140,7 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	int cpu;
 
 	/* Give any tasks back to the parent group */
-	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
+	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask, rmdir_match);
 
 	/* Update per cpu rmid of the moved CPUs first */
 	for_each_cpu(cpu, &rdtgrp->cpu_mask)
@@ -3164,7 +3180,7 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	int cpu;
 
 	/* Give any tasks back to the default group */
-	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask);
+	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask, rmdir_match);
 
 	/* Give any CPUs back to the default group */
 	cpumask_or(&rdtgroup_default.cpu_mask,
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

