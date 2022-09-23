Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B44C5E8153
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiIWSB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiIWSBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:01:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDBF115F5D;
        Fri, 23 Sep 2022 11:01:43 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956101;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wqu2td9G6BImYXsEj1Rl86ZncpaxoR3mV0JBlL8OESI=;
        b=G1xn4NyVqpd0kq6jRKrgjQE1f/mkhdRrc5brHDk44pZpdImM0YIeM5IOobsLJZE1bRYyRP
        MGCNon3p3po2YjFOBmzkmAqtRdweb0MxPLVN9+Ok6tgCCIdGQas74NMwouyusYUqv+SP0l
        RVAnSP3NOFM21FuIl8SJegQJTklwhoOuZkvie2k3BpkDAd7b+h0jplOFd1nKcJXL9ABJiA
        /baVaxlQmIK3JJ6zZL25P8MdXgtn8y+i5rDIe384HW8rluAZqI7GYHSer9g5b3KPkWk9E+
        r+4JAo+IKhe3IV9a9WnO2c6HYehi8P02074OYlcSoJaDwxSVpLJ++BmokZn2XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956101;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wqu2td9G6BImYXsEj1Rl86ZncpaxoR3mV0JBlL8OESI=;
        b=EGW4IfMk0qBDa+wT2LLn6fdvZf0hozbxxUhq77HbysQnqgFnoQ4YY6CqM6dStCEjarDCdG
        EzK7w/6U+q5ExaBg==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Make resctrl_arch_rmid_read() return
 values in bytes
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-22-james.morse@arm.com>
References: <20220902154829.30399-22-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395609992.401.3249343600620973680.tip-bot2@tip-bot2>
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

Commit-ID:     f7b1843eca6fe295ba0c71fc02a3291954078f2b
Gitweb:        https://git.kernel.org/tip/f7b1843eca6fe295ba0c71fc02a3291954078f2b
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:29 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 23 Sep 2022 14:25:05 +02:00

x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes

resctrl_arch_rmid_read() returns a value in chunks, as read from the
hardware. This needs scaling to bytes by mon_scale, as provided by
the architecture code.

Now that resctrl_arch_rmid_read() performs the overflow and corrections
itself, it may as well return a value in bytes directly. This allows
the accesses to the architecture specific 'hw' structure to be removed.

Move the mon_scale conversion into resctrl_arch_rmid_read().
mbm_bw_count() is updated to calculate bandwidth from bytes.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-22-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  6 ++----
 arch/x86/kernel/cpu/resctrl/internal.h    |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c     | 24 ++++++++++------------
 include/linux/resctrl.h                   |  2 +-
 4 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 42a1abb..1dafbdc 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -549,7 +549,6 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
-	struct rdt_hw_resource *hw_res;
 	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
@@ -569,8 +568,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	domid = md.u.domid;
 	evtid = md.u.evtid;
 
-	hw_res = &rdt_resources_all[resid];
-	r = &hw_res->r_resctrl;
+	r = &rdt_resources_all[resid].r_resctrl;
 	d = rdt_find_domain(r, domid, NULL);
 	if (IS_ERR_OR_NULL(d)) {
 		ret = -ENOENT;
@@ -584,7 +582,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	else if (rr.err == -EINVAL)
 		seq_puts(m, "Unavailable\n");
 	else
-		seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
+		seq_printf(m, "%llu\n", rr.val);
 
 out:
 	rdtgroup_kn_unlock(of->kn);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c05e9b7..5f71286 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -279,13 +279,13 @@ struct rftype {
 
 /**
  * struct mbm_state - status for each MBM counter in each domain
- * @prev_bw_chunks: Previous chunks value read for bandwidth calculation
+ * @prev_bw_bytes: Previous bytes value read for bandwidth calculation
  * @prev_bw:	The most recent bandwidth in MBps
  * @delta_bw:	Difference between the current and previous bandwidth
  * @delta_comp:	Indicates whether to compute the delta_bw
  */
 struct mbm_state {
-	u64	prev_bw_chunks;
+	u64	prev_bw_bytes;
 	u32	prev_bw;
 	u32	delta_bw;
 	bool	delta_comp;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 8d15568..efe0c30 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 
 #include <asm/cpu_device_id.h>
@@ -189,7 +190,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct arch_mbm_state *am;
-	u64 msr_val;
+	u64 msr_val, chunks;
 
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
 		return -EINVAL;
@@ -214,12 +215,14 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	if (am) {
 		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
 						 hw_res->mbm_width);
-		*val = get_corrected_mbm_count(rmid, am->chunks);
+		chunks = get_corrected_mbm_count(rmid, am->chunks);
 		am->prev_msr = msr_val;
 	} else {
-		*val = msr_val;
+		chunks = msr_val;
 	}
 
+	*val = chunks * hw_res->mon_scale;
+
 	return 0;
 }
 
@@ -232,7 +235,6 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 void __check_limbo(struct rdt_domain *d, bool force_free)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rmid_entry *entry;
 	u32 crmid = 1, nrmid;
 	bool rmid_dirty;
@@ -255,7 +257,6 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 					   QOS_L3_OCCUP_EVENT_ID, &val)) {
 			rmid_dirty = true;
 		} else {
-			val *= hw_res->mon_scale;
 			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
 		}
 
@@ -299,7 +300,6 @@ int alloc_rmid(void)
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_domain *d;
 	int cpu, err;
 	u64 val = 0;
@@ -311,7 +311,6 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 			err = resctrl_arch_rmid_read(r, d, entry->rmid,
 						     QOS_L3_OCCUP_EVENT_ID,
 						     &val);
-			val *= hw_res->mon_scale;
 			if (err || val <= resctrl_rmid_realloc_threshold)
 				continue;
 		}
@@ -403,15 +402,14 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
  */
 static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 {
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m = &rr->d->mbm_local[rmid];
-	u64 cur_bw, chunks, cur_chunks;
+	u64 cur_bw, bytes, cur_bytes;
 
-	cur_chunks = rr->val;
-	chunks = cur_chunks - m->prev_bw_chunks;
-	m->prev_bw_chunks = cur_chunks;
+	cur_bytes = rr->val;
+	bytes = cur_bytes - m->prev_bw_bytes;
+	m->prev_bw_bytes = cur_bytes;
 
-	cur_bw = (chunks * hw_res->mon_scale) >> 20;
+	cur_bw = bytes / SZ_1M;
 
 	if (m->delta_comp)
 		m->delta_bw = abs(cur_bw - m->prev_bw);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index cb857f7..0cf5b20 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -227,7 +227,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
  * @d:			domain that the counter should be read from.
  * @rmid:		rmid of the counter to read.
  * @eventid:		eventid to read, e.g. L3 occupancy.
- * @val:		result of the counter read in chunks.
+ * @val:		result of the counter read in bytes.
  *
  * Call from process context on a CPU that belongs to domain @d.
  *
