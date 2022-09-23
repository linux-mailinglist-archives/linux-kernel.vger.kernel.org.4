Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EA55E8157
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiIWSCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiIWSBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:01:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04788109110;
        Fri, 23 Sep 2022 11:01:47 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956106;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHAuRm2tKV0Kq4suC7Zc8rDX8UpSAUSBB+6W7+AcIw0=;
        b=mPARmlG0NGuLwZCzvhiGtXIQ8iMYHlMbdLc5gUg90krn4O1T6VogbHBR9vVSXdwaAuu/lA
        7/Lkde50lYSaaC/pIZerrc4OuP9CQaQSY3wOHWVV23AlIU4RN0teAulIRQ8CHoabeD7YHL
        dhHlexfGHqS8rFf/teAi/CMr5C/EatBZ3wctqeg/4VVHyd86rTRhuPma8H/UMDwYxOoBtH
        fhp+xwqpA2zao6uozMr9TWsEzQr3mL//if0lepJSLXR0ewEdaEXMVGabd90j5viLKwNqi0
        4KzUMLPM72cWpda6kxcZ3Mixw/w29oywusKBZ9EeMClrzC8xWFXnkBlBrSmrTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956106;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHAuRm2tKV0Kq4suC7Zc8rDX8UpSAUSBB+6W7+AcIw0=;
        b=72eZWYXP+ZOQlJSdQQGy/snFoCghaDayRqeWk6UH+jxuuU21m3gNJxzRS3B7OW74b4C6Cm
        rVUhgElkNAL3nLDA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Pass the required parameters into
 resctrl_arch_rmid_read()
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-17-james.morse@arm.com>
References: <20220902154829.30399-17-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395610537.401.9073026910954710982.tip-bot2@tip-bot2>
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

Commit-ID:     8286618aca331bf17323ff3023ca831ac6e4b86f
Gitweb:        https://git.kernel.org/tip/8286618aca331bf17323ff3023ca831ac6e4b86f
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:24 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 23 Sep 2022 14:21:25 +02:00

x86/resctrl: Pass the required parameters into resctrl_arch_rmid_read()

resctrl_arch_rmid_read() is intended as the function that an
architecture agnostic resctrl filesystem driver can use to
read a value in bytes from a hardware register. Currently the function
returns the MBM values in chunks directly from hardware.

To convert this to bytes, some correction and overflow calculations
are needed. These depend on the resource and domain structures.
Overflow detection requires the old chunks value. None of this
is available to resctrl_arch_rmid_read(). MPAM requires the
resource and domain structures to find the MMIO device that holds
the registers.

Pass the resource and domain to resctrl_arch_rmid_read(). This makes
rmid_dirty() too big. Instead merge it with its only caller, and the
name is kept as a local variable.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-17-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 31 ++++++++++++++------------
 include/linux/resctrl.h               | 18 ++++++++++++++-
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 51ab76f..262141b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -167,10 +167,14 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 		memset(am, 0, sizeof(*am));
 }
 
-int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
+			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
 {
 	u64 msr_val;
 
+	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
+		return -EINVAL;
+
 	/*
 	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
 	 * with a valid event code for supported resource type and the bits
@@ -192,16 +196,6 @@ int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
 	return 0;
 }
 
-static bool rmid_dirty(struct rmid_entry *entry)
-{
-	u64 val = 0;
-
-	if (resctrl_arch_rmid_read(entry->rmid, QOS_L3_OCCUP_EVENT_ID, &val))
-		return true;
-
-	return val >= resctrl_cqm_threshold;
-}
-
 /*
  * Check the RMIDs that are marked as busy for this domain. If the
  * reported LLC occupancy is below the threshold clear the busy bit and
@@ -213,6 +207,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 	struct rmid_entry *entry;
 	struct rdt_resource *r;
 	u32 crmid = 1, nrmid;
+	bool rmid_dirty;
+	u64 val = 0;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
@@ -228,7 +224,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 			break;
 
 		entry = __rmid_entry(nrmid);
-		if (force_free || !rmid_dirty(entry)) {
+
+		if (resctrl_arch_rmid_read(r, d, entry->rmid,
+					   QOS_L3_OCCUP_EVENT_ID, &val))
+			rmid_dirty = true;
+		else
+			rmid_dirty = (val >= resctrl_cqm_threshold);
+
+		if (force_free || !rmid_dirty) {
 			clear_bit(entry->rmid, d->rmid_busy_llc);
 			if (!--entry->busy) {
 				rmid_limbo_count--;
@@ -278,7 +281,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	cpu = get_cpu();
 	list_for_each_entry(d, &r->domains, list) {
 		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
-			err = resctrl_arch_rmid_read(entry->rmid,
+			err = resctrl_arch_rmid_read(r, d, entry->rmid,
 						     QOS_L3_OCCUP_EVENT_ID,
 						     &val);
 			if (err || val <= resctrl_cqm_threshold)
@@ -336,7 +339,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 	if (rr->first)
 		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
 
-	rr->err = resctrl_arch_rmid_read(rmid, rr->evtid, &tval);
+	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &tval);
 	if (rr->err)
 		return rr->err;
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index efe60dd..7ccfa0d 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -219,7 +219,23 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 			    u32 closid, enum resctrl_conf_type type);
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
-int resctrl_arch_rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *res);
+
+/**
+ * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
+ *			      for this resource and domain.
+ * @r:			resource that the counter should be read from.
+ * @d:			domain that the counter should be read from.
+ * @rmid:		rmid of the counter to read.
+ * @eventid:		eventid to read, e.g. L3 occupancy.
+ * @val:		result of the counter read in chunks.
+ *
+ * Call from process context on a CPU that belongs to domain @d.
+ *
+ * Return:
+ * 0 on success, or -EIO, -EINVAL etc on error.
+ */
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
+			   u32 rmid, enum resctrl_event_id eventid, u64 *val);
 
 /**
  * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
