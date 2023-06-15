Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A27731A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344305AbjFONeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344301AbjFONdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:33:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48FAE30DB;
        Thu, 15 Jun 2023 06:33:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F51A113E;
        Thu, 15 Jun 2023 06:34:21 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.46.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5C0E73F64C;
        Thu, 15 Jun 2023 06:33:32 -0700 (PDT)
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
Subject: [PATCH V12 08/10] arm64/perf: Add struct brbe_regset helper functions
Date:   Thu, 15 Jun 2023 19:02:37 +0530
Message-Id: <20230615133239.442736-9-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615133239.442736-1-anshuman.khandual@arm.com>
References: <20230615133239.442736-1-anshuman.khandual@arm.com>
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
Tested-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_brbe.c | 127 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index 4729cb49282b..f6693699fade 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -44,6 +44,133 @@ static void select_brbe_bank(int bank)
 	isb();
 }
 
+static bool __read_brbe_regset(struct brbe_regset *entry, int idx)
+{
+	entry->brbinf = get_brbinf_reg(idx);
+
+	/*
+	 * There are no valid entries anymore on the buffer.
+	 * Abort the branch record processing to save some
+	 * cycles and also reduce the capture/process load
+	 * for the user space as well.
+	 */
+	if (brbe_invalid(entry->brbinf))
+		return false;
+
+	entry->brbsrc = get_brbsrc_reg(idx);
+	entry->brbtgt = get_brbtgt_reg(idx);
+	return true;
+}
+
+/*
+ * This scans over BRBE register banks and captures individual branch records
+ * [BRBSRC, BRBTGT, BRBINF] into a pre-allocated 'struct brbe_regset' buffer,
+ * until an invalid one gets encountered. The caller for this function needs
+ * to ensure BRBE is an appropriate state before the records can be captured.
+ */
+static int capture_brbe_regset(int nr_hw_entries, struct brbe_regset *buf)
+{
+	int idx = 0;
+
+	select_brbe_bank(BRBE_BANK_IDX_0);
+	while (idx < nr_hw_entries && idx < BRBE_BANK0_IDX_MAX) {
+		if (!__read_brbe_regset(&buf[idx], idx))
+			return idx;
+		idx++;
+	}
+
+	select_brbe_bank(BRBE_BANK_IDX_1);
+	while (idx < nr_hw_entries && idx < BRBE_BANK1_IDX_MAX) {
+		if (!__read_brbe_regset(&buf[idx], idx))
+			return idx;
+		idx++;
+	}
+	return idx;
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
+ * the live records. Unless the live buffer is detected as being full
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
+	int nr_move = min(nr_stored, nr_max - nr_live);
+
+	/* Move the tail of the buffer to make room for the new entries */
+	memmove(&stored[nr_live], &stored[0], nr_move * sizeof(*stored));
+
+	/* Copy the new entries into the head of the buffer */
+	memcpy(&stored[0], &live[0], nr_live * sizeof(*stored));
+
+	/* Return the number of entries in the stitched buffer */
+	return min(nr_live + nr_stored, nr_max);
+}
+
 /*
  * Generic perf branch filters supported on BRBE
  *
-- 
2.25.1

