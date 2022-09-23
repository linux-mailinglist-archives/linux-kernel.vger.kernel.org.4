Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990365E8164
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiIWSCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiIWSCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:02:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AACE13C847;
        Fri, 23 Sep 2022 11:01:52 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956110;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aovbly4/A7xUlS7xCzDb0DiWoRe36nGpHkeo2qOdcDw=;
        b=aZOwXfSqglQb8M/o9plrl7eISCIvxq8VfDw6AWi7N7hZMEkyedGknGVUWORT7/FcebU23h
        FldWKWJ38D2qdT5U+nl1imGW2AioKxG9A93g7yv5LO4Ag/waXOA8pSNgKDTqrmGnv1oxsd
        NKZlXo0ZDDrMOrtEBazQ07dTmeiLs+YL7lI8fnCwWtVH5HwzZrBNkZAANGOtzjnUCu8gF4
        m/oD+lcArMt+KjxNUu8fk7UwDdnMvKeGHKM8WSm2h9gKIffXDxhBCkmSveLjAn+UcVv/M9
        DduzITrdK/UnzmVgm82wPdmOEzy9u8h0PhJAu/i3p2OMlMsq0NcaoGQTmbYHIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956110;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aovbly4/A7xUlS7xCzDb0DiWoRe36nGpHkeo2qOdcDw=;
        b=XJXdpiSWYQ/sEAXgWVqpTdQQgvCyWl2zgmc3jfMxarZQGrroqfrcaa31lJPOPM906eG5R6
        1IAiELy3jWaFb+DQ==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Calculate bandwidth from the previous
 __mon_event_count() chunks
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-13-james.morse@arm.com>
References: <20220902154829.30399-13-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395610953.401.969948201916916421.tip-bot2@tip-bot2>
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

Commit-ID:     30442571ec81fb33f7bd8cea5a14afb10b8f442a
Gitweb:        https://git.kernel.org/tip/30442571ec81fb33f7bd8cea5a14afb10b8f442a
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:20 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 22 Sep 2022 17:44:57 +02:00

x86/resctrl: Calculate bandwidth from the previous __mon_event_count() chunks

mbm_bw_count() is only called by the mbm_handle_overflow() worker once a
second. It reads the hardware register, calculates the bandwidth and
updates m->prev_bw_msr which is used to hold the previous hardware register
value.

Operating directly on hardware register values makes it difficult to make
this code architecture independent, so that it can be moved to /fs/,
making the mba_sc feature something resctrl supports with no additional
support from the architecture.
Prior to calling mbm_bw_count(), mbm_update() reads from the same hardware
register using __mon_event_count().

Change mbm_bw_count() to use the current chunks value most recently saved
by __mon_event_count(). This removes an extra call to __rmid_read().
Instead of using m->prev_msr to calculate the number of chunks seen,
use the rr->val that was updated by __mon_event_count(). This removes an
extra call to mbm_overflow_count() and get_corrected_mbm_count().
Calculating bandwidth like this means mbm_bw_count() no longer operates
on hardware register values directly.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-13-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/internal.h |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 25 ++++++++++++++++---------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 3b9e43b..4606209 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -289,7 +289,7 @@ struct rftype {
  * struct mbm_state - status for each MBM counter in each domain
  * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
  * @prev_msr:	Value of IA32_QM_CTR for this RMID last time we read it
- * @prev_bw_msr:Value of previous IA32_QM_CTR for bandwidth counting
+ * @prev_bw_chunks: Previous chunks value read for bandwidth calculation
  * @prev_bw:	The most recent bandwidth in MBps
  * @delta_bw:	Difference between the current and previous bandwidth
  * @delta_comp:	Indicates whether to compute the delta_bw
@@ -297,7 +297,7 @@ struct rftype {
 struct mbm_state {
 	u64	chunks;
 	u64	prev_msr;
-	u64	prev_bw_msr;
+	u64	prev_bw_chunks;
 	u32	prev_bw;
 	u32	delta_bw;
 	bool	delta_comp;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 3e69386..2d81b6c 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -315,7 +315,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 
 	if (rr->first) {
 		memset(m, 0, sizeof(struct mbm_state));
-		m->prev_bw_msr = m->prev_msr = tval;
+		m->prev_msr = tval;
 		return 0;
 	}
 
@@ -329,27 +329,32 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 }
 
 /*
+ * mbm_bw_count() - Update bw count from values previously read by
+ *		    __mon_event_count().
+ * @rmid:	The rmid used to identify the cached mbm_state.
+ * @rr:		The struct rmid_read populated by __mon_event_count().
+ *
  * Supporting function to calculate the memory bandwidth
- * and delta bandwidth in MBps.
+ * and delta bandwidth in MBps. The chunks value previously read by
+ * __mon_event_count() is compared with the chunks value from the previous
+ * invocation. This must be called once per second to maintain values in MBps.
  */
 static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
 	struct mbm_state *m = &rr->d->mbm_local[rmid];
-	u64 tval, cur_bw, chunks;
+	u64 cur_bw, chunks, cur_chunks;
 
-	tval = __rmid_read(rmid, rr->evtid);
-	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL))
-		return;
+	cur_chunks = rr->val;
+	chunks = cur_chunks - m->prev_bw_chunks;
+	m->prev_bw_chunks = cur_chunks;
 
-	chunks = mbm_overflow_count(m->prev_bw_msr, tval, hw_res->mbm_width);
-	cur_bw = (get_corrected_mbm_count(rmid, chunks) * hw_res->mon_scale) >> 20;
+	cur_bw = (chunks * hw_res->mon_scale) >> 20;
 
 	if (m->delta_comp)
 		m->delta_bw = abs(cur_bw - m->prev_bw);
 	m->delta_comp = false;
 	m->prev_bw = cur_bw;
-	m->prev_bw_msr = tval;
 }
 
 /*
@@ -516,10 +521,12 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
 	 */
 	if (is_mbm_total_enabled()) {
 		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
+		rr.val = 0;
 		__mon_event_count(rmid, &rr);
 	}
 	if (is_mbm_local_enabled()) {
 		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
+		rr.val = 0;
 		__mon_event_count(rmid, &rr);
 
 		/*
