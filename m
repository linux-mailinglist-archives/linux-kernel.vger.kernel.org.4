Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1235E8173
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiIWSDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiIWSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:02:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86D513EE95;
        Fri, 23 Sep 2022 11:01:59 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956118;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Te0qtIdI3W0ICk/OBQHzFhDBkKsDg5PMEOT/JijiAE=;
        b=20NWmrK9mjXqb0JQO9C/mi1uiOiaGT1cEDe3vMNurNJgEwn2X3q+5hC80yE7bcZcx0RxCc
        s+MdviIyM+eQzNkJOSNCARIYziQW/yQBCj6gi4rkASVNm5BvUUw9gq6JDbpLGXwyzXwGZa
        n+8cyjx3Dk4ZrdG0NZPCV0tmTab39+wEM90s+O8Z3qwLnfpDbiw4dbjlnl5z8DRbbSlhB5
        jriR7eiJJV9q/91QfFP2KxAqoTi/YP9vbBKSAwiHf2EbtVcjtPp5UnyuVlyWDSRgca9rlL
        2qqGJ3z1onW5wIfu9myOZ+wYkJmPCbXGQI91V/NLjDFUo6TEJRj0GrTyWNTqaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956118;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Te0qtIdI3W0ICk/OBQHzFhDBkKsDg5PMEOT/JijiAE=;
        b=MYJSwlLXDGLz06b4tHHoJPgt4aAbSN5uVLaU1SyxpBmORtxRZIT13zaI1Eet0l1NzWAOtf
        59NdI5aB5y8diOCQ==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add domain offline callback for resctrl work
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-6-james.morse@arm.com>
References: <20220902154829.30399-6-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395611688.401.1902343437727291224.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     798fd4b9ac37fec571f55fb8592497b0dd5f7a73
Gitweb:        https://git.kernel.org/tip/798fd4b9ac37fec571f55fb8592497b0dd5f7a73
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:13 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 22 Sep 2022 15:42:40 +02:00

x86/resctrl: Add domain offline callback for resctrl work

Because domains are exposed to user-space via resctrl, the filesystem
must update its state when CPU hotplug callbacks are triggered.

Some of this work is common to any architecture that would support
resctrl, but the work is tied up with the architecture code to
free the memory.

Move the monitor subdir removal and the cancelling of the mbm/limbo
works into a new resctrl_offline_domain() call. These bits are not
specific to the architecture. Grouping them in one function allows
that code to be moved to /fs/ and re-used by another architecture.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-6-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 26 +-------------
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 45 ++++++++++++++++++++++---
 include/linux/resctrl.h                |  1 +-
 4 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index e37889f..f691829 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -523,27 +523,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 	cpumask_clear_cpu(cpu, &d->cpu_mask);
 	if (cpumask_empty(&d->cpu_mask)) {
-		/*
-		 * If resctrl is mounted, remove all the
-		 * per domain monitor data directories.
-		 */
-		if (static_branch_unlikely(&rdt_mon_enable_key))
-			rmdir_mondata_subdir_allrdtgrp(r, d->id);
+		resctrl_offline_domain(r, d);
 		list_del(&d->list);
-		if (r->mon_capable && is_mbm_enabled())
-			cancel_delayed_work(&d->mbm_over);
-		if (is_llc_occupancy_enabled() &&  has_busy_rmid(r, d)) {
-			/*
-			 * When a package is going down, forcefully
-			 * decrement rmid->ebusy. There is no way to know
-			 * that the L3 was flushed and hence may lead to
-			 * incorrect counts in rare scenarios, but leaving
-			 * the RMID as busy creates RMID leaks if the
-			 * package never comes back.
-			 */
-			__check_limbo(d, true);
-			cancel_delayed_work(&d->cqm_limbo);
-		}
 
 		/*
 		 * rdt_domain "d" is going to be freed below, so clear
@@ -551,11 +532,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		 */
 		if (d->plr)
 			d->plr->d = NULL;
-
-		bitmap_free(d->rmid_busy_llc);
-		kfree(d->mbm_total);
-		kfree(d->mbm_local);
 		domain_free(hw_dom);
+
 		return;
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index be48a68..e12b55f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -522,8 +522,6 @@ void free_rmid(u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
-void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-				    unsigned int dom_id);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 030a703..5830905 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2499,14 +2499,12 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
  * Remove all subdirectories of mon_data of ctrl_mon groups
  * and monitor groups with given domain id.
  */
-void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r, unsigned int dom_id)
+static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
+					   unsigned int dom_id)
 {
 	struct rdtgroup *prgrp, *crgrp;
 	char name[32];
 
-	if (!r->mon_capable)
-		return;
-
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		sprintf(name, "mon_%s_%02d", r->name, dom_id);
 		kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
@@ -3233,6 +3231,45 @@ out:
 	return ret;
 }
 
+static void domain_destroy_mon_state(struct rdt_domain *d)
+{
+	bitmap_free(d->rmid_busy_llc);
+	kfree(d->mbm_total);
+	kfree(d->mbm_local);
+}
+
+void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (!r->mon_capable)
+		return;
+
+	/*
+	 * If resctrl is mounted, remove all the
+	 * per domain monitor data directories.
+	 */
+	if (static_branch_unlikely(&rdt_mon_enable_key))
+		rmdir_mondata_subdir_allrdtgrp(r, d->id);
+
+	if (is_mbm_enabled())
+		cancel_delayed_work(&d->mbm_over);
+	if (is_llc_occupancy_enabled() && has_busy_rmid(r, d)) {
+		/*
+		 * When a package is going down, forcefully
+		 * decrement rmid->ebusy. There is no way to know
+		 * that the L3 was flushed and hence may lead to
+		 * incorrect counts in rare scenarios, but leaving
+		 * the RMID as busy creates RMID leaks if the
+		 * package never comes back.
+		 */
+		__check_limbo(d, true);
+		cancel_delayed_work(&d->cqm_limbo);
+	}
+
+	domain_destroy_mon_state(d);
+}
+
 static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 {
 	size_t tsize;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index d512455..5d283bd 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -193,5 +193,6 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
+void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
 
 #endif /* _RESCTRL_H */
