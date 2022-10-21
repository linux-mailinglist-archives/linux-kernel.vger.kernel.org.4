Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F9360780D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJUNO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiJUNNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:13:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 625F824CC22
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:13:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 449001BF3;
        Fri, 21 Oct 2022 06:13:24 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AE0E3F792;
        Fri, 21 Oct 2022 06:13:15 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com, peternewman@google.com
Subject: [PATCH 18/18] x86/resctrl: Separate arch and fs resctrl locks
Date:   Fri, 21 Oct 2022 13:12:04 +0000
Message-Id: <20221021131204.5581-19-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221021131204.5581-1-james.morse@arm.com>
References: <20221021131204.5581-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resctrl has one mutex that is taken by the architecture specific code,
and the filesystem parts. The two interact via cpuhp, where the
architecture code updates the domain list. Filesystem handlers that
walk the domains list should not run concurrently with the cpuhp
callback modifying the list.

Exposing a lock from the filesystem code means the interface is not
cleanly defined, and creates the possibility of cross-architecture
lock ordering headaches. The interaction only exists so that certain
filesystem paths are serialised against cpu hotplug. The cpu hotplug
code already has a mechanism to do this using cpus_read_lock().

MPAM's monitors have an overflow interrupt, so it needs to be possible
to walk the domains list in irq context. RCU is ideal for this,
but some paths need to be able to sleep to allocate memory.

Because resctrl_{on,off}line_cpu() take the rdtgroup_mutex as part
of a cpuhp callback, cpus_read_lock() must always be taken first.
rdtgroup_schemata_write() already does this.

All but one of the filesystem code's domain list walkers are
currently protected by the rdtgroup_mutex taken in
rdtgroup_kn_lock_live(). The exception is rdt_bit_usage_show()
which takes the lock directly.

Make the domain list protected by RCU. An architecture-specific
lock prevents concurrent writers. rdt_bit_usage_show() can
walk the domain list under rcu_read_lock().
The other filesystem list walkers need to be able to sleep.
Add cpus_read_lock() to rdtgroup_kn_lock_live() so that the
cpuhp callbacks can't be invoked when file system operations are
occurring.

Add lockdep_assert_cpus_held() in the cases where the
rdtgroup_kn_lock_live() call isn't obvious.

Resctrl's domain online/offline calls now need to take the
rdtgroup_mutex themselves.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c        | 33 ++++++++------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 14 ++++--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  3 ++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  3 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 54 ++++++++++++++++++++---
 include/linux/resctrl.h                   |  2 +-
 6 files changed, 84 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 00b098b56e42..c4e4ce5bf87f 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -25,8 +25,14 @@
 #include <asm/resctrl.h>
 #include "internal.h"
 
-/* Mutex to protect rdtgroup access. */
-DEFINE_MUTEX(rdtgroup_mutex);
+/*
+ * rdt_domain structures are kfree()d when their last cpu goes offline,
+ * and allocated when the first cpu in a new domain comes online.
+ * The rdt_resource's domain list is updated when this happens. The domain
+ * list is protected by RCU, but callers can also take the cpus_read_lock()
+ * to prevent modification if they need to sleep. All writers take this mutex:
+ */
+static DEFINE_MUTEX(domain_list_lock);
 
 /*
  * The cached resctrl_pqr_state is strictly per CPU and can never be
@@ -489,6 +495,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	struct rdt_domain *d;
 	int err;
 
+	lockdep_assert_held(&domain_list_lock);
+
 	d = rdt_find_domain(r, id, &add_pos);
 	if (IS_ERR(d)) {
 		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
@@ -522,11 +530,12 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
-	list_add_tail(&d->list, add_pos);
+	list_add_tail_rcu(&d->list, add_pos);
 
 	err = resctrl_online_domain(r, d);
 	if (err) {
-		list_del(&d->list);
+		list_del_rcu(&d->list);
+		synchronize_rcu();
 		domain_free(hw_dom);
 	}
 }
@@ -547,7 +556,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 	cpumask_clear_cpu(cpu, &d->cpu_mask);
 	if (cpumask_empty(&d->cpu_mask)) {
 		resctrl_offline_domain(r, d);
-		list_del(&d->list);
+		list_del_rcu(&d->list);
+		synchronize_rcu();
 
 		/*
 		 * rdt_domain "d" is going to be freed below, so clear
@@ -575,30 +585,27 @@ static void clear_closid_rmid(int cpu)
 static int resctrl_arch_online_cpu(unsigned int cpu)
 {
 	struct rdt_resource *r;
-	int err;
 
-	mutex_lock(&rdtgroup_mutex);
+	mutex_lock(&domain_list_lock);
 	for_each_capable_rdt_resource(r)
 		domain_add_cpu(cpu, r);
 	clear_closid_rmid(cpu);
+	mutex_unlock(&domain_list_lock);
 
-	err = resctrl_online_cpu(cpu);
-	mutex_unlock(&rdtgroup_mutex);
-
-	return err;
+	return resctrl_online_cpu(cpu);
 }
 
 static int resctrl_arch_offline_cpu(unsigned int cpu)
 {
 	struct rdt_resource *r;
 
-	mutex_lock(&rdtgroup_mutex);
 	resctrl_offline_cpu(cpu);
 
+	mutex_lock(&domain_list_lock);
 	for_each_capable_rdt_resource(r)
 		domain_remove_cpu(cpu, r);
 	clear_closid_rmid(cpu);
-	mutex_unlock(&rdtgroup_mutex);
+	mutex_unlock(&domain_list_lock);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 842266d1d148..dc700a09d661 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -209,6 +209,9 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	struct rdt_domain *d;
 	unsigned long dom_id;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
 	    r->rid == RDT_RESOURCE_MBA) {
 		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
@@ -314,6 +317,9 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	int cpu;
 	u32 idx;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
@@ -384,11 +390,9 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 		return -EINVAL;
 	buf[nbytes - 1] = '\0';
 
-	cpus_read_lock();
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
 		rdtgroup_kn_unlock(of->kn);
-		cpus_read_unlock();
 		return -ENOENT;
 	}
 	rdt_last_cmd_clear();
@@ -452,7 +456,6 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 out:
 	rdtgroup_kn_unlock(of->kn);
-	cpus_read_unlock();
 	return ret ?: nbytes;
 }
 
@@ -472,6 +475,9 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 	bool sep = false;
 	u32 ctrl_val;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	seq_printf(s, "%*s:", max_name_width, schema->name);
 	list_for_each_entry(dom, &r->domains, list) {
 		if (sep)
@@ -534,7 +540,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    int evtid, int first)
 {
 	/* When picking a cpu from cpu_mask, ensure it can't race with cpuhp */
-	lockdep_assert_held(&rdtgroup_mutex);
+	lockdep_assert_cpus_held();
 
 	/*
 	 * setup the parameters to pass to mon_event_count() to read the data.
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 42a7fd6d56c9..777085df07cf 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -414,6 +414,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	u32 idx;
 	int err;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
 
 	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 48f196007e9c..690dc6c9f3d4 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -830,6 +830,9 @@ bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_domain *d)
 	struct rdt_domain *d_i;
 	bool ret = false;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	if (!zalloc_cpumask_var(&cpu_with_psl, GFP_KERNEL))
 		return true;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f8ea04d95c42..5febb6dfaea0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -35,6 +35,10 @@
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
 DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
+
+/* Mutex to protect rdtgroup access. */
+DEFINE_MUTEX(rdtgroup_mutex);
+
 static struct kernfs_root *rdt_root;
 struct rdtgroup rdtgroup_default;
 LIST_HEAD(rdt_all_groups);
@@ -930,7 +934,8 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 
 	mutex_lock(&rdtgroup_mutex);
 	hw_shareable = r->cache.shareable_bits;
-	list_for_each_entry(dom, &r->domains, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(dom, &r->domains, list) {
 		if (sep)
 			seq_putc(seq, ';');
 		sw_shareable = 0;
@@ -986,8 +991,10 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 		}
 		sep = true;
 	}
+	rcu_read_unlock();
 	seq_putc(seq, '\n');
 	mutex_unlock(&rdtgroup_mutex);
+
 	return 0;
 }
 
@@ -1227,6 +1234,9 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 	struct rdt_domain *d;
 	u32 ctrl;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
 		if (r->rid == RDT_RESOURCE_MBA)
@@ -1860,6 +1870,9 @@ static int set_cache_qos_cfg(int level, bool enable)
 	struct rdt_domain *d;
 	int cpu;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	if (level == RDT_RESOURCE_L3)
 		update = l3_qos_cfg_update;
 	else if (level == RDT_RESOURCE_L2)
@@ -2052,6 +2065,7 @@ struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn)
 	atomic_inc(&rdtgrp->waitcount);
 	kernfs_break_active_protection(kn);
 
+	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
 	/* Was this group deleted while we waited? */
@@ -2069,6 +2083,7 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn)
 		return;
 
 	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
 
 	if (atomic_dec_and_test(&rdtgrp->waitcount) &&
 	    (rdtgrp->flags & RDT_DELETED)) {
@@ -2365,6 +2380,9 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	struct rdt_domain *d;
 	int i, cpu;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
@@ -2645,6 +2663,9 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
 	struct rdt_domain *dom;
 	int ret;
 
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
 	list_for_each_entry(dom, &r->domains, list) {
 		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
 		if (ret)
@@ -3328,7 +3349,8 @@ static void domain_destroy_mon_state(struct rdt_domain *d)
 	kfree(d->mbm_local);
 }
 
-void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
+static void _resctrl_offline_domain(struct rdt_resource *r,
+				    struct rdt_domain *d)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 
@@ -3363,6 +3385,13 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 	domain_destroy_mon_state(d);
 }
 
+void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
+{
+	mutex_lock(&rdtgroup_mutex);
+	_resctrl_offline_domain(r, d);
+	mutex_unlock(&rdtgroup_mutex);
+}
+
 static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 {
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
@@ -3394,7 +3423,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
-int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
+static int _resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 {
 	int err;
 
@@ -3425,12 +3454,23 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 	return 0;
 }
 
+int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
+{
+	int err;
+
+	mutex_lock(&rdtgroup_mutex);
+	err = _resctrl_online_domain(r, d);
+	mutex_unlock(&rdtgroup_mutex);
+
+	return err;
+}
+
 int resctrl_online_cpu(unsigned int cpu)
 {
-	lockdep_assert_held(&rdtgroup_mutex);
-
+	mutex_lock(&rdtgroup_mutex);
 	/* The cpu is set in default rdtgroup after online. */
 	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
+	mutex_unlock(&rdtgroup_mutex);
 
 	return 0;
 }
@@ -3451,8 +3491,7 @@ void resctrl_offline_cpu(unsigned int cpu)
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
-	lockdep_assert_held(&rdtgroup_mutex);
-
+	mutex_lock(&rdtgroup_mutex);
 	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
 		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
 			clear_childcpus(rdtgrp, cpu);
@@ -3472,6 +3511,7 @@ void resctrl_offline_cpu(unsigned int cpu)
 			cqm_setup_limbo_handler(d, 0, cpu);
 		}
 	}
+	mutex_unlock(&rdtgroup_mutex);
 }
 
 /*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 530fb21cf9a5..c5af581790dc 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -153,7 +153,7 @@ struct resctrl_schema;
  * @cache_level:	Which cache level defines scope of this resource
  * @cache:		Cache allocation related data
  * @membw:		If the component has bandwidth controls, their properties.
- * @domains:		All domains for this resource
+ * @domains:		RCU list of all domains for this resource
  * @name:		Name to use in "schemata" file.
  * @data_width:		Character width of data when displaying
  * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
-- 
2.30.2

