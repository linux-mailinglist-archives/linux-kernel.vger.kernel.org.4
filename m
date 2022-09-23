Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F235E815B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiIWSCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiIWSBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:01:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC621075A3;
        Fri, 23 Sep 2022 11:01:49 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956107;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zm1EwGXrR2kVSXsjauI8UZceso4+wma30ip2xqDZcrg=;
        b=KXVvA9Uamonbb45cOM3FCAXQMoP0nbISbxaWG1SsdNUF6kzinBtiM2w8ZJknGvMKCcltOE
        rbW39oZRXm9TK6E0Q34ZILmqqXXoVbcgzndwEwwlbVO96Pe0m/FV9V1r1dMKfaZWfJE/VK
        g6Y/Y6IdoJ77MWC0HPbo/yQl9r7UTdHc37P5dyAe18MTTZe6W8qfO5rdnHhfaXP/qPTfgd
        w2KbibsuB8PjZNBwwt8AfTrU1rUm1/NlMZqeNgckjtQy6cjv1HqRN4ULkqiHlSVZGmJsAo
        IedFT8Qni9LWE7GaGwv4YDGk5y5eTqj5chd2QrfL7snFi2q2SGkABzMTxsE+FQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956107;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zm1EwGXrR2kVSXsjauI8UZceso4+wma30ip2xqDZcrg=;
        b=Ali8uLDBITuXH+LW4p8+yoCtu3TjyMwuo+e24WDVDNgWYRukQZoSoJRfLIKsxKy/l6Y4QT
        MUsuMfW+gFSUfkCQ==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Abstract __rmid_read()
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-16-james.morse@arm.com>
References: <20220902154829.30399-16-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395610637.401.5883519621024530217.tip-bot2@tip-bot2>
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

Commit-ID:     4d044c521a63b2cd394ea6e3547012032145e47e
Gitweb:        https://git.kernel.org/tip/4d044c521a63b2cd394ea6e3547012032145e47e
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:23 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 23 Sep 2022 14:17:20 +02:00

x86/resctrl: Abstract __rmid_read()

__rmid_read() selects the specified eventid and returns the counter
value from the MSR. The error handling is architecture specific, and
handled by the callers, rdtgroup_mondata_show() and __mon_event_count().

Error handling should be handled by architecture specific code, as
a different architecture may have different requirements. MPAM's
counters can report that they are 'not ready', requiring a second
read after a short delay. This should be hidden from resctrl.

Make __rmid_read() the architecture specific function for reading
a counter. Rename it resctrl_arch_rmid_read() and move the error
handling into it.

A read from a counter that hardware supports but resctrl does not
now returns -EINVAL instead of -EIO from the default case in
__mon_event_count(). It isn't possible for user-space to see this
change as resctrl doesn't expose counters it doesn't support.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-16-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +-
 arch/x86/kernel/cpu/resctrl/internal.h    |  1 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     | 62 +++++++++++++---------
 include/linux/resctrl.h                   |  1 +-
 4 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 0ab9232..42a1abb 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -579,9 +579,9 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 
 	mon_event_read(&rr, r, d, rdtgrp, evtid, false);
 
-	if (rr.val & RMID_VAL_ERROR)
+	if (rr.err == -EIO)
 		seq_puts(m, "Error\n");
-	else if (rr.val & RMID_VAL_UNAVAIL)
+	else if (rr.err == -EINVAL)
 		seq_puts(m, "Unavailable\n");
 	else
 		seq_printf(m, "%llu\n", rr.val * hw_res->mon_scale);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b34a140..1d2e7bd 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -94,6 +94,7 @@ struct rmid_read {
 	struct rdt_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
+	int			err;
 	u64			val;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e975514..51ab76f 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -167,9 +167,9 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 		memset(am, 0, sizeof(*am));
 }
 
-static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
+int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
-	u64 val;
+	u64 msr_val;
 
 	/*
 	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
@@ -180,14 +180,24 @@ static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
 	 * are error bits.
 	 */
 	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
-	rdmsrl(MSR_IA32_QM_CTR, val);
+	rdmsrl(MSR_IA32_QM_CTR, msr_val);
 
-	return val;
+	if (msr_val & RMID_VAL_ERROR)
+		return -EIO;
+	if (msr_val & RMID_VAL_UNAVAIL)
+		return -EINVAL;
+
+	*val = msr_val;
+
+	return 0;
 }
 
 static bool rmid_dirty(struct rmid_entry *entry)
 {
-	u64 val = __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
+	u64 val = 0;
+
+	if (resctrl_arch_rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID, &val))
+		return true;
 
 	return val >= resctrl_cqm_threshold;
 }
@@ -259,8 +269,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r;
 	struct rdt_domain *d;
-	int cpu;
-	u64 val;
+	int cpu, err;
+	u64 val = 0;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
@@ -268,8 +278,10 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	cpu = get_cpu();
 	list_for_each_entry(d, &r->domains, list) {
 		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
-			val = __rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID);
-			if (val <= resctrl_cqm_threshold)
+			err = resctrl_arch_rmid_read(entry->rmid,
+						     QOS_L3_OCCUP_EVENT_ID,
+						     &val);
+			if (err || val <= resctrl_cqm_threshold)
 				continue;
 		}
 
@@ -315,19 +327,19 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
 	return chunks >> shift;
 }
 
-static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
+static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m;
-	u64 chunks, tval;
+	u64 chunks, tval = 0;
 
 	if (rr->first)
 		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
 
-	tval = __rmid_read(rmid, rr->evtid);
-	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
-		return tval;
-	}
+	rr->err = resctrl_arch_rmid_read(rmid, rr->evtid, &tval);
+	if (rr->err)
+		return rr->err;
+
 	switch (rr->evtid) {
 	case QOS_L3_OCCUP_EVENT_ID:
 		rr->val += tval;
@@ -341,9 +353,9 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 	default:
 		/*
 		 * Code would never reach here because an invalid
-		 * event id would fail the __rmid_read.
+		 * event id would fail in resctrl_arch_rmid_read().
 		 */
-		return RMID_VAL_ERROR;
+		return -EINVAL;
 	}
 
 	if (rr->first) {
@@ -399,11 +411,11 @@ void mon_event_count(void *info)
 	struct rdtgroup *rdtgrp, *entry;
 	struct rmid_read *rr = info;
 	struct list_head *head;
-	u64 ret_val;
+	int ret;
 
 	rdtgrp = rr->rgrp;
 
-	ret_val = __mon_event_count(rdtgrp->mon.rmid, rr);
+	ret = __mon_event_count(rdtgrp->mon.rmid, rr);
 
 	/*
 	 * For Ctrl groups read data from child monitor groups and
@@ -415,13 +427,17 @@ void mon_event_count(void *info)
 	if (rdtgrp->type == RDTCTRL_GROUP) {
 		list_for_each_entry(entry, head, mon.crdtgrp_list) {
 			if (__mon_event_count(entry->mon.rmid, rr) == 0)
-				ret_val = 0;
+				ret = 0;
 		}
 	}
 
-	/* Report error if none of rmid_reads are successful */
-	if (ret_val)
-		rr->val = ret_val;
+	/*
+	 * __mon_event_count() calls for newly created monitor groups may
+	 * report -EINVAL/Unavailable if the monitor hasn't seen any traffic.
+	 * Discard error if any of the monitor event reads succeeded.
+	 */
+	if (ret == 0)
+		rr->err = 0;
 }
 
 /*
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8184567..efe60dd 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -219,6 +219,7 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
+int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *res);
 
 /**
  * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
