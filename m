Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6485E8158
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiIWSCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiIWSBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:01:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA8F107DCC;
        Fri, 23 Sep 2022 11:01:47 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956105;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YrrEWUxsNdl5KzgI0SHFvxBYvhDFnqI4/IUBM2nMOks=;
        b=eoog3PQMjT9/uuCBJMOC8WSBdR2QlnTO+tIBYBy/pkHBkZ7IBFd+gwdbQ9y2Yl0OD+HBFL
        CczW9ra89FpO/T2lM5d+/61ymBqeBJIE8ruB19K+/rmwO17ko9AxTSwC2SsNjx+OpdVqdg
        JbhFG+y6REvz2Hj/qsnfayz7xNZsqH6Ov9IW8dPBNzI6+sRfubG5ps7A6qZ1sA3XAFVhPl
        hLo1DpBOf+JfRNjaz8VusEBeQ0Ux4QaZdQ+q3LKKyw93fwMn3PtyT9tSzLTN+ZknRlFd1L
        Gn3k5M58sIk0i7X3oAuWzftSUvQWaiN7I9xnoBKcfqko4tNgc6RcWJ6GLUjC7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956105;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YrrEWUxsNdl5KzgI0SHFvxBYvhDFnqI4/IUBM2nMOks=;
        b=Lv7YfDGMWdmLAQiGTLVDLBzpTmyFQrlBnWmNNVad1jpkMU1Bp79f8nvGBRy9dg/HQN7mup
        ihBxAOyL/egs5uDA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move mbm_overflow_count() into
 resctrl_arch_rmid_read()
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-18-james.morse@arm.com>
References: <20220902154829.30399-18-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395610428.401.17778412481657298654.tip-bot2@tip-bot2>
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

Commit-ID:     1d81d15db39c2b517bc58f63008c6255dd08aafe
Gitweb:        https://git.kernel.org/tip/1d81d15db39c2b517bc58f63008c6255dd08aafe
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:25 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 23 Sep 2022 14:22:20 +02:00

x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()

resctrl_arch_rmid_read() is intended as the function that an
architecture agnostic resctrl filesystem driver can use to
read a value in bytes from a counter. Currently the function returns
the MBM values in chunks directly from hardware. When reading a bandwidth
counter, mbm_overflow_count() must be used to correct for any possible
overflow.

mbm_overflow_count() is architecture specific, its behaviour should
be part of resctrl_arch_rmid_read().

Move the mbm_overflow_count() calls into resctrl_arch_rmid_read().
This allows the resctrl filesystems's prev_msr to be removed in
favour of the architecture private version.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-18-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 35 ++++++++++++++-----------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 1d2e7bd..8039e8a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -281,7 +281,6 @@ struct rftype {
 /**
  * struct mbm_state - status for each MBM counter in each domain
  * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
- * @prev_msr:	Value of IA32_QM_CTR for this RMID last time we read it
  * @prev_bw_chunks: Previous chunks value read for bandwidth calculation
  * @prev_bw:	The most recent bandwidth in MBps
  * @delta_bw:	Difference between the current and previous bandwidth
@@ -289,7 +288,6 @@ struct rftype {
  */
 struct mbm_state {
 	u64	chunks;
-	u64	prev_msr;
 	u64	prev_bw_chunks;
 	u32	prev_bw;
 	u32	delta_bw;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 262141b..862a446 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -167,9 +167,20 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 		memset(am, 0, sizeof(*am));
 }
 
+static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
+{
+	u64 shift = 64 - width, chunks;
+
+	chunks = (cur_msr << shift) - (prev_msr << shift);
+	return chunks >> shift;
+}
+
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct arch_mbm_state *am;
 	u64 msr_val;
 
 	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
@@ -191,7 +202,13 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 	if (msr_val & RMID_VAL_UNAVAIL)
 		return -EINVAL;
 
-	*val = msr_val;
+	am = get_arch_mbm_state(hw_dom, rmid, eventid);
+	if (am) {
+		*val = mbm_overflow_count(am->prev_msr, msr_val, hw_res->mbm_width);
+		am->prev_msr = msr_val;
+	} else {
+		*val = msr_val;
+	}
 
 	return 0;
 }
@@ -322,19 +339,10 @@ void free_rmid(u32 rmid)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
-static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
-{
-	u64 shift = 64 - width, chunks;
-
-	chunks = (cur_msr << shift) - (prev_msr << shift);
-	return chunks >> shift;
-}
-
 static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 {
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m;
-	u64 chunks, tval = 0;
+	u64 tval = 0;
 
 	if (rr->first)
 		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
@@ -363,13 +371,10 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 
 	if (rr->first) {
 		memset(m, 0, sizeof(struct mbm_state));
-		m->prev_msr = tval;
 		return 0;
 	}
 
-	chunks = mbm_overflow_count(m->prev_msr, tval, hw_res->mbm_width);
-	m->chunks += chunks;
-	m->prev_msr = tval;
+	m->chunks += tval;
 
 	rr->val += get_corrected_mbm_count(rmid, m->chunks);
 
