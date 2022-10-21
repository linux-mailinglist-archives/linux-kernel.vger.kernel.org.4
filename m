Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C8B6077FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiJUNNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiJUNNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:13:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4849027357A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:12:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A4331042;
        Fri, 21 Oct 2022 06:13:00 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFC8F3F792;
        Fri, 21 Oct 2022 06:12:51 -0700 (PDT)
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
Subject: [PATCH 09/18] x86/resctrl: Allow resctrl_arch_rmid_read() to sleep
Date:   Fri, 21 Oct 2022 13:11:55 +0000
Message-Id: <20221021131204.5581-10-james.morse@arm.com>
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

MPAM's cache occupancy counters can take a little while to settle once
the monitor has been configured. The maximum settling time is described
to the driver via a firmware table. The value could be large enough
that it makes sense to sleep.

To avoid exposing this to resctrl, it should be hidden behind MPAM's
resctrl_arch_rmid_read(). But add_rmid_to_limbo() calls
resctrl_arch_rmid_read() from a non-preemptible context.

add_rmid_to_limbo() is opportunistically reading the L3 occupancy counter
on this domain to avoid adding the RMID to limbo if this domain's value
has drifted below resctrl_rmid_realloc_threshold since the limbo handler
last ran. Determining 'this domain' involves disabling preeption to
prevent the thread being migrated to CPUs in a different domain between
the check and resctrl_arch_rmid_read() call. The check is skipped
for all remote domains.

Instead, call resctrl_arch_rmid_read() for each domain, and get it to
read the arch specific counter via IPI if its called on a CPU outside
the target domain. By covering remote domains, this change stops the
limbo handler from being started unnecessarily.

This also allows resctrl_arch_rmid_read() to sleep.

Signed-off-by: James Morse <james.morse@arm.com>
---
The alternative is to remove the counter read from this path altogether,
and assume user-space would never try to re-allocate the last RMID before
the limbo handler runs next.
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 58 ++++++++++++++++++---------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 2ca76cddb170..e4ddc2477631 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -199,17 +199,19 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 	return chunks >> shift;
 }
 
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
-			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
-			   u64 *val)
+struct __rmid_read_arg
 {
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
-	struct arch_mbm_state *am;
-	u64 msr_val, chunks;
+	u32 rmid;
+	enum resctrl_event_id eventid;
 
-	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
-		return -EINVAL;
+	u64 msr_val;
+};
+
+static void __rmid_read(void *arg)
+{
+	enum resctrl_event_id eventid = ((struct __rmid_read_arg *)arg)->eventid;
+	u32 rmid = ((struct __rmid_read_arg *)arg)->rmid;
+	u64 msr_val;
 
 	/*
 	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
@@ -222,6 +224,28 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
 	rdmsrl(MSR_IA32_QM_CTR, msr_val);
 
+	((struct __rmid_read_arg *)arg)->msr_val = msr_val;
+}
+
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
+			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
+			   u64 *val)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct __rmid_read_arg arg;
+	struct arch_mbm_state *am;
+	u64 msr_val, chunks;
+	int err;
+
+	arg.rmid = rmid;
+	arg.eventid = eventid;
+
+	err = smp_call_function_any(&d->cpu_mask, __rmid_read, &arg, true);
+	if (err)
+		return err;
+
+	msr_val = arg.msr_val;
 	if (msr_val & RMID_VAL_ERROR)
 		return -EIO;
 	if (msr_val & RMID_VAL_UNAVAIL)
@@ -376,23 +400,18 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	struct rdt_domain *d;
-	int cpu, err;
 	u64 val = 0;
 	u32 idx;
+	int err;
 
 	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
 
 	entry->busy = 0;
-	cpu = get_cpu();
 	list_for_each_entry(d, &r->domains, list) {
-		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
-			err = resctrl_arch_rmid_read(r, d, entry->closid,
-						     entry->rmid,
-						     QOS_L3_OCCUP_EVENT_ID,
-						     &val);
-			if (err || val <= resctrl_rmid_realloc_threshold)
-				continue;
-		}
+		err = resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
+					     QOS_L3_OCCUP_EVENT_ID, &val);
+		if (err || val <= resctrl_rmid_realloc_threshold)
+			continue;
 
 		/*
 		 * For the first limbo RMID in the domain,
@@ -403,7 +422,6 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 		set_bit(idx, d->rmid_busy_llc);
 		entry->busy++;
 	}
-	put_cpu();
 
 	if (entry->busy)
 		rmid_limbo_count++;
-- 
2.30.2

