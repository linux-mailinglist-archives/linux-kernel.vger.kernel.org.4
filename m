Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1048B5F07A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiI3Jbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiI3JbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:31:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EFEC9025;
        Fri, 30 Sep 2022 02:31:11 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:31:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664530269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uh0vduFCnK3f4rfhmyjZDrGPtyKKhsI9Q8llfsJQwE8=;
        b=dbJ+0m6xnjDhrdP95GbUCcSDLeIpA5jjZ04reOZ+5KJsMJUO9fZdJ+CsW6K/hftFTHfwLy
        V5sxqq5faHG0BFwRtINw7zhotjnToTmeZ4NXC5PZFtIxKjy+q5P73rYfVW3Ph+/XBwsws5
        DRyt13nFRLrx9OjBdGOzoCVrg7xwxHrYnSfWn+ZD7XsOpZtglJpNYP32+ZhPex02GxfThF
        EbBoTc84VPyD+5ajAFeprlWAJCuDHWvCkG+JuUaBV9JRczZIpW4LFmN+TLYK+qs0i3Ort/
        9jr2w08HQglMdt/WZ1UHyHVVy7jmpNraFi9tDEE93GeLmhrIdhgIyFjLJqvq1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664530269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uh0vduFCnK3f4rfhmyjZDrGPtyKKhsI9Q8llfsJQwE8=;
        b=2O6Hu4NCZBouFrsh1m5yOMDefafE6vokJvM7u04oWwcnB+f03AYM4Jh+uOG+4aLVtwZLVx
        CGbVCTB8bGTIo5AA==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Support PERF_SAMPLE_DATA_SRC
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220928095805.596-4-ravi.bangoria@amd.com>
References: <20220928095805.596-4-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <166453026835.401.17914693880512567098.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7c10dd0a88b1cc6ae4637fffb494c5e080027eb6
Gitweb:        https://git.kernel.org/tip/7c10dd0a88b1cc6ae4637fffb494c5e080027eb6
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 28 Sep 2022 15:27:53 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Sep 2022 12:20:55 +02:00

perf/x86/amd: Support PERF_SAMPLE_DATA_SRC

struct perf_mem_data_src is used to pass arch specific memory access
details into generic form. These details gets consumed by tools like
perf mem and c2c. IBS tagged load/store sample provides most of the
information needed for these tools. Add a logic to convert IBS
specific raw data into perf_mem_data_src.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220928095805.596-4-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 318 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 312 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c29a006..e20caa5 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -678,6 +678,312 @@ static struct perf_ibs perf_ibs_op = {
 	.get_count		= get_ibs_op_count,
 };
 
+static void perf_ibs_get_mem_op(union ibs_op_data3 *op_data3,
+				struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+
+	data_src->mem_op = PERF_MEM_OP_NA;
+
+	if (op_data3->ld_op)
+		data_src->mem_op = PERF_MEM_OP_LOAD;
+	else if (op_data3->st_op)
+		data_src->mem_op = PERF_MEM_OP_STORE;
+}
+
+/*
+ * Processors having CPUID_Fn8000001B_EAX[11] aka IBS_CAPS_ZEN4 has
+ * more fine granular DataSrc encodings. Others have coarse.
+ */
+static u8 perf_ibs_data_src(union ibs_op_data2 *op_data2)
+{
+	if (ibs_caps & IBS_CAPS_ZEN4)
+		return (op_data2->data_src_hi << 3) | op_data2->data_src_lo;
+
+	return op_data2->data_src_lo;
+}
+
+static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
+				 union ibs_op_data3 *op_data3,
+				 struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+	u8 ibs_data_src = perf_ibs_data_src(op_data2);
+
+	data_src->mem_lvl = 0;
+
+	/*
+	 * DcMiss, L2Miss, DataSrc, DcMissLat etc. are all invalid for Uncached
+	 * memory accesses. So, check DcUcMemAcc bit early.
+	 */
+	if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO) {
+		data_src->mem_lvl = PERF_MEM_LVL_UNC | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	/* L1 Hit */
+	if (op_data3->dc_miss == 0) {
+		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	/* L2 Hit */
+	if (op_data3->l2_miss == 0) {
+		/* Erratum #1293 */
+		if (boot_cpu_data.x86 != 0x19 || boot_cpu_data.x86_model > 0xF ||
+		    !(op_data3->sw_pf || op_data3->dc_miss_no_mab_alloc)) {
+			data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
+			return;
+		}
+	}
+
+	/*
+	 * OP_DATA2 is valid only for load ops. Skip all checks which
+	 * uses OP_DATA2[DataSrc].
+	 */
+	if (data_src->mem_op != PERF_MEM_OP_LOAD)
+		goto check_mab;
+
+	/* L3 Hit */
+	if (ibs_caps & IBS_CAPS_ZEN4) {
+		if (ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE) {
+			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
+			return;
+		}
+	} else {
+		if (ibs_data_src == IBS_DATA_SRC_LOC_CACHE) {
+			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_REM_CCE1 |
+					    PERF_MEM_LVL_HIT;
+			return;
+		}
+	}
+
+	/* A peer cache in a near CCX */
+	if (ibs_caps & IBS_CAPS_ZEN4 &&
+	    ibs_data_src == IBS_DATA_SRC_EXT_NEAR_CCX_CACHE) {
+		data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	/* A peer cache in a far CCX */
+	if (ibs_caps & IBS_CAPS_ZEN4) {
+		if (ibs_data_src == IBS_DATA_SRC_EXT_FAR_CCX_CACHE) {
+			data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
+			return;
+		}
+	} else {
+		if (ibs_data_src == IBS_DATA_SRC_REM_CACHE) {
+			data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
+			return;
+		}
+	}
+
+	/* DRAM */
+	if (ibs_data_src == IBS_DATA_SRC_EXT_DRAM) {
+		if (op_data2->rmt_node == 0)
+			data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
+		else
+			data_src->mem_lvl = PERF_MEM_LVL_REM_RAM1 | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	/* PMEM */
+	if (ibs_caps & IBS_CAPS_ZEN4 && ibs_data_src == IBS_DATA_SRC_EXT_PMEM) {
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_PMEM;
+		if (op_data2->rmt_node) {
+			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+			/* IBS doesn't provide Remote socket detail */
+			data_src->mem_hops = PERF_MEM_HOPS_1;
+		}
+		return;
+	}
+
+	/* Extension Memory */
+	if (ibs_caps & IBS_CAPS_ZEN4 &&
+	    ibs_data_src == IBS_DATA_SRC_EXT_EXT_MEM) {
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_EXTN_MEM;
+		if (op_data2->rmt_node) {
+			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+			/* IBS doesn't provide Remote socket detail */
+			data_src->mem_hops = PERF_MEM_HOPS_1;
+		}
+		return;
+	}
+
+	/* IO */
+	if (ibs_data_src == IBS_DATA_SRC_EXT_IO) {
+		data_src->mem_lvl = PERF_MEM_LVL_IO;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_IO;
+		if (op_data2->rmt_node) {
+			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
+			/* IBS doesn't provide Remote socket detail */
+			data_src->mem_hops = PERF_MEM_HOPS_1;
+		}
+		return;
+	}
+
+check_mab:
+	/*
+	 * MAB (Miss Address Buffer) Hit. MAB keeps track of outstanding
+	 * DC misses. However, such data may come from any level in mem
+	 * hierarchy. IBS provides detail about both MAB as well as actual
+	 * DataSrc simultaneously. Prioritize DataSrc over MAB, i.e. set
+	 * MAB only when IBS fails to provide DataSrc.
+	 */
+	if (op_data3->dc_miss_no_mab_alloc) {
+		data_src->mem_lvl = PERF_MEM_LVL_LFB | PERF_MEM_LVL_HIT;
+		return;
+	}
+
+	data_src->mem_lvl = PERF_MEM_LVL_NA;
+}
+
+static bool perf_ibs_cache_hit_st_valid(void)
+{
+	/* 0: Uninitialized, 1: Valid, -1: Invalid */
+	static int cache_hit_st_valid;
+
+	if (unlikely(!cache_hit_st_valid)) {
+		if (boot_cpu_data.x86 == 0x19 &&
+		    (boot_cpu_data.x86_model <= 0xF ||
+		    (boot_cpu_data.x86_model >= 0x20 &&
+		     boot_cpu_data.x86_model <= 0x5F))) {
+			cache_hit_st_valid = -1;
+		} else {
+			cache_hit_st_valid = 1;
+		}
+	}
+
+	return cache_hit_st_valid == 1;
+}
+
+static void perf_ibs_get_mem_snoop(union ibs_op_data2 *op_data2,
+				   struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+	u8 ibs_data_src;
+
+	data_src->mem_snoop = PERF_MEM_SNOOP_NA;
+
+	if (!perf_ibs_cache_hit_st_valid() ||
+	    data_src->mem_op != PERF_MEM_OP_LOAD ||
+	    data_src->mem_lvl & PERF_MEM_LVL_L1 ||
+	    data_src->mem_lvl & PERF_MEM_LVL_L2 ||
+	    op_data2->cache_hit_st)
+		return;
+
+	ibs_data_src = perf_ibs_data_src(op_data2);
+
+	if (ibs_caps & IBS_CAPS_ZEN4) {
+		if (ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE ||
+		    ibs_data_src == IBS_DATA_SRC_EXT_NEAR_CCX_CACHE ||
+		    ibs_data_src == IBS_DATA_SRC_EXT_FAR_CCX_CACHE)
+			data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
+	} else if (ibs_data_src == IBS_DATA_SRC_LOC_CACHE) {
+		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
+	}
+}
+
+static void perf_ibs_get_tlb_lvl(union ibs_op_data3 *op_data3,
+				 struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+
+	data_src->mem_dtlb = PERF_MEM_TLB_NA;
+
+	if (!op_data3->dc_lin_addr_valid)
+		return;
+
+	if (!op_data3->dc_l1tlb_miss) {
+		data_src->mem_dtlb = PERF_MEM_TLB_L1 | PERF_MEM_TLB_HIT;
+		return;
+	}
+
+	if (!op_data3->dc_l2tlb_miss) {
+		data_src->mem_dtlb = PERF_MEM_TLB_L2 | PERF_MEM_TLB_HIT;
+		return;
+	}
+
+	data_src->mem_dtlb = PERF_MEM_TLB_L2 | PERF_MEM_TLB_MISS;
+}
+
+static void perf_ibs_get_mem_lock(union ibs_op_data3 *op_data3,
+				  struct perf_sample_data *data)
+{
+	union perf_mem_data_src *data_src = &data->data_src;
+
+	data_src->mem_lock = PERF_MEM_LOCK_NA;
+
+	if (op_data3->dc_locked_op)
+		data_src->mem_lock = PERF_MEM_LOCK_LOCKED;
+}
+
+#define ibs_op_msr_idx(msr)	(msr - MSR_AMD64_IBSOPCTL)
+
+static void perf_ibs_get_data_src(struct perf_ibs_data *ibs_data,
+				  struct perf_sample_data *data,
+				  union ibs_op_data2 *op_data2,
+				  union ibs_op_data3 *op_data3)
+{
+	perf_ibs_get_mem_lvl(op_data2, op_data3, data);
+	perf_ibs_get_mem_snoop(op_data2, data);
+	perf_ibs_get_tlb_lvl(op_data3, data);
+	perf_ibs_get_mem_lock(op_data3, data);
+}
+
+static __u64 perf_ibs_get_op_data2(struct perf_ibs_data *ibs_data,
+				   union ibs_op_data3 *op_data3)
+{
+	__u64 val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA2)];
+
+	/* Erratum #1293 */
+	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model <= 0xF &&
+	    (op_data3->sw_pf || op_data3->dc_miss_no_mab_alloc)) {
+		/*
+		 * OP_DATA2 has only two fields on Zen3: DataSrc and RmtNode.
+		 * DataSrc=0 is 'No valid status' and RmtNode is invalid when
+		 * DataSrc=0.
+		 */
+		val = 0;
+	}
+	return val;
+}
+
+static void perf_ibs_parse_ld_st_data(__u64 sample_type,
+				      struct perf_ibs_data *ibs_data,
+				      struct perf_sample_data *data)
+{
+	union ibs_op_data3 op_data3;
+	union ibs_op_data2 op_data2;
+
+	data->data_src.val = PERF_MEM_NA;
+	op_data3.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+
+	perf_ibs_get_mem_op(&op_data3, data);
+	if (data->data_src.mem_op != PERF_MEM_OP_LOAD &&
+	    data->data_src.mem_op != PERF_MEM_OP_STORE)
+		return;
+
+	op_data2.val = perf_ibs_get_op_data2(ibs_data, &op_data3);
+
+	if (sample_type & PERF_SAMPLE_DATA_SRC) {
+		perf_ibs_get_data_src(ibs_data, data, &op_data2, &op_data3);
+		data->sample_flags |= PERF_SAMPLE_DATA_SRC;
+	}
+}
+
+static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
+				   int check_rip)
+{
+	if (sample_type & PERF_SAMPLE_RAW ||
+	    (perf_ibs == &perf_ibs_op &&
+	     sample_type & PERF_SAMPLE_DATA_SRC))
+		return perf_ibs->offset_max;
+	else if (check_rip)
+		return 3;
+	return 1;
+}
+
 static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 {
 	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
@@ -725,12 +1031,9 @@ fail:
 	size = 1;
 	offset = 1;
 	check_rip = (perf_ibs == &perf_ibs_op && (ibs_caps & IBS_CAPS_RIPINVALIDCHK));
-	if (event->attr.sample_type & PERF_SAMPLE_RAW)
-		offset_max = perf_ibs->offset_max;
-	else if (check_rip)
-		offset_max = 3;
-	else
-		offset_max = 1;
+
+	offset_max = perf_ibs_get_offset_max(perf_ibs, event->attr.sample_type, check_rip);
+
 	do {
 		rdmsrl(msr + offset, *buf++);
 		size++;
@@ -784,6 +1087,9 @@ fail:
 		data.sample_flags |= PERF_SAMPLE_RAW;
 	}
 
+	if (perf_ibs == &perf_ibs_op)
+		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
+
 	/*
 	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
 	 * recorded as part of interrupt regs. Thus we need to use rip from
