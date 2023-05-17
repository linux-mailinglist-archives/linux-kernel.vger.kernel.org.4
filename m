Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13B3705D37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjEQCZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjEQCZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:25:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 997496197;
        Tue, 16 May 2023 19:25:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 820702F4;
        Tue, 16 May 2023 19:25:53 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.70.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A46F53F793;
        Tue, 16 May 2023 19:25:03 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V10 08/10] arm64/perf: Add struct brbe_regset helper functions
Date:   Wed, 17 May 2023 07:54:08 +0530
Message-Id: <20230517022410.722287-9-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517022410.722287-1-anshuman.khandual@arm.com>
References: <20230517022410.722287-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The primary abstraction level for fetching branch records from BRBE HW has
been changed as 'struct brbe_regset', which contains storage for all three
BRBE registers i.e BRBSRC, BRBTGT, BRBINF. Whether branch record processing
happens in the task sched out path, or in the PMU IRQ handling path, these
registers need to be extracted from the HW. Afterwards both live and stored
sets need to be stitched together to create final branch records set. This
adds required helper functions for such operations.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_brbe.c | 163 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index 484842d8cf3e..759db681d673 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -44,6 +44,169 @@ static void select_brbe_bank(int bank)
 	isb();
 }
 
+/*
+ * This scans over BRBE register banks and captures individual branch reocrds
+ * [BRBSRC, BRBTGT, BRBINF] into a pre-allocated 'struct brbe_regset' buffer,
+ * until an invalid one gets encountered. The caller for this function needs
+ * to ensure BRBE is an appropriate state before the records can be captured.
+ */
+static int capture_brbe_regset(struct brbe_hw_attr *brbe_attr, struct brbe_regset *buf)
+{
+	int loop1_idx1, loop1_idx2, loop2_idx1, loop2_idx2;
+	int idx, count;
+
+	loop1_idx1 = BRBE_BANK0_IDX_MIN;
+	if (brbe_attr->brbe_nr <= BRBE_BANK_MAX_ENTRIES) {
+		loop1_idx2 = brbe_attr->brbe_nr - 1;
+		loop2_idx1 = BRBE_BANK1_IDX_MIN;
+		loop2_idx2 = BRBE_BANK0_IDX_MAX;
+	} else {
+		loop1_idx2 = BRBE_BANK0_IDX_MAX;
+		loop2_idx1 = BRBE_BANK1_IDX_MIN;
+		loop2_idx2 = brbe_attr->brbe_nr - 1;
+	}
+
+	select_brbe_bank(BRBE_BANK_IDX_0);
+	for (idx = 0, count = loop1_idx1; count <= loop1_idx2; idx++, count++) {
+		buf[idx].brbinf = get_brbinf_reg(idx);
+		/*
+		 * There are no valid entries anymore on the buffer.
+		 * Abort the branch record processing to save some
+		 * cycles and also reduce the capture/process load
+		 * for the user space as well.
+		 */
+		if (brbe_invalid(buf[idx].brbinf))
+			return idx;
+
+		buf[idx].brbsrc = get_brbsrc_reg(idx);
+		buf[idx].brbtgt = get_brbtgt_reg(idx);
+	}
+
+	select_brbe_bank(BRBE_BANK_IDX_1);
+	for (count = loop2_idx1; count <= loop2_idx2; idx++, count++) {
+		buf[idx].brbinf = get_brbinf_reg(idx);
+		/*
+		 * There are no valid entries anymore on the buffer.
+		 * Abort the branch record processing to save some
+		 * cycles and also reduce the capture/process load
+		 * for the user space as well.
+		 */
+		if (brbe_invalid(buf[idx].brbinf))
+			return idx;
+
+		buf[idx].brbsrc = get_brbsrc_reg(idx);
+		buf[idx].brbtgt = get_brbtgt_reg(idx);
+	}
+	return idx;
+}
+
+static inline void copy_brbe_regset(struct brbe_regset *src, int src_idx,
+				    struct brbe_regset *dst, int dst_idx)
+{
+	dst[dst_idx].brbinf = src[src_idx].brbinf;
+	dst[dst_idx].brbsrc = src[src_idx].brbsrc;
+	dst[dst_idx].brbtgt = src[src_idx].brbtgt;
+}
+
+/*
+ * This function concatenates branch records from stored and live buffer
+ * up to maximum nr_max records and the stored buffer holds the resultant
+ * buffer. The concatenated buffer contains all the branch records from
+ * the live buffer but might contain some from stored buffer considering
+ * the maximum combined length does not exceed 'nr_max'.
+ *
+ *	Stored records	Live records
+ *	------------------------------------------------^
+ *	|	S0	|	L0	|	Newest	|
+ *	---------------------------------		|
+ *	|	S1	|	L1	|		|
+ *	---------------------------------		|
+ *	|	S2	|	L2	|		|
+ *	---------------------------------		|
+ *	|	S3	|	L3	|		|
+ *	---------------------------------		|
+ *	|	S4	|	L4	|		nr_max
+ *	---------------------------------		|
+ *	|		|	L5	|		|
+ *	---------------------------------		|
+ *	|		|	L6	|		|
+ *	---------------------------------		|
+ *	|		|	L7	|		|
+ *	---------------------------------		|
+ *	|		|		|		|
+ *	---------------------------------		|
+ *	|		|		|	Oldest	|
+ *	------------------------------------------------V
+ *
+ *
+ * S0 is the newest in the stored records, where as L7 is the oldest in
+ * the live reocords. Unless the live buffer is detetcted as being full
+ * thus potentially dropping off some older records, L7 and S0 records
+ * are contiguous in time for a user task context. The stitched buffer
+ * here represents maximum possible branch records, contiguous in time.
+ *
+ *	Stored records  Live records
+ *	------------------------------------------------^
+ *	|	L0	|	L0	|	Newest	|
+ *	---------------------------------		|
+ *	|	L0	|	L1	|		|
+ *	---------------------------------		|
+ *	|	L2	|	L2	|		|
+ *	---------------------------------		|
+ *	|	L3	|	L3	|		|
+ *	---------------------------------		|
+ *	|	L4	|	L4	|	      nr_max
+ *	---------------------------------		|
+ *	|	L5	|	L5	|		|
+ *	---------------------------------		|
+ *	|	L6	|	L6	|		|
+ *	---------------------------------		|
+ *	|	L7	|	L7	|		|
+ *	---------------------------------		|
+ *	|	S0	|		|		|
+ *	---------------------------------		|
+ *	|	S1	|		|    Oldest	|
+ *	------------------------------------------------V
+ *	|	S2	| <----|
+ *	-----------------      |
+ *	|	S3	| <----| Dropped off after nr_max
+ *	-----------------      |
+ *	|	S4	| <----|
+ *	-----------------
+ */
+static int stitch_stored_live_entries(struct brbe_regset *stored,
+				      struct brbe_regset *live,
+				      int nr_stored, int nr_live,
+				      int nr_max)
+{
+	int nr_total, nr_excess, nr_last, i;
+
+	nr_total = nr_stored + nr_live;
+	nr_excess = nr_total - nr_max;
+
+	/* Stored branch records in stitched buffer */
+	if (nr_live == nr_max)
+		nr_stored = 0;
+	else if (nr_excess > 0)
+		nr_stored -= nr_excess;
+
+	/* Stitched buffer branch records length */
+	if (nr_total > nr_max)
+		nr_last = nr_max;
+	else
+		nr_last = nr_total;
+
+	/* Move stored branch records */
+	for (i = 0; i < nr_stored; i++)
+		copy_brbe_regset(stored, i, stored, nr_last - nr_stored - 1 + i);
+
+	/* Copy live branch records */
+	for (i = 0; i < nr_live; i++)
+		copy_brbe_regset(live, i, stored, i);
+
+	return nr_last;
+}
+
 /*
  * Generic perf branch filters supported on BRBE
  *
-- 
2.25.1

