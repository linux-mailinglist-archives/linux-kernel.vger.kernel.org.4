Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515206008BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJQIc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiJQIcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:32:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5EB3FEF9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:32:41 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MrVc24CRyzHvsJ;
        Mon, 17 Oct 2022 16:32:34 +0800 (CST)
Received: from huawei.com (10.44.134.232) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 16:32:08 +0800
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yeyunfeng@huawei.com>
CC:     <linfeilong@huawei.com>
Subject: [PATCH 4/5] arm64: mm: Support ASID isolation feature
Date:   Mon, 17 Oct 2022 16:32:02 +0800
Message-ID: <20221017083203.3690346-5-yeyunfeng@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221017083203.3690346-1-yeyunfeng@huawei.com>
References: <20221017083203.3690346-1-yeyunfeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.44.134.232]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a rollover, the global generation will be flushed, which will
cause the process mm->context.id on all CPUs do not match the
generation. Thus, the process will compete for the global spinlock lock
to reallocate a new ASID and refresh the TLBs of all CPUs on context
switch. This will lead to the increase of scheduling delay and TLB miss.

In some delay-sensitive scenarios, for example, part of CPUs are
isolated, only a limited number of processes are deployed to run on the
isolated CPUs. In this case, we do not want these key processes to be
affected by the rollover of ASID.

An ASID isolation method can reduce interference. We divide the
asid_generation into different domains, for example, HOUSEKEEPING and
ISOLATION. Processes in different domains allocate ASID from the shared
asid_map pool, then combine with the generation of local domain as the
mm->context.id. After an ASID rollover, the generation of the
HOUSEKEEPING domain can be flushed independently, and only the TLB of
HOUSEKEEPING domain CPUs will be flushed, so the processes of ISOLATION
domain will not be affected.

In addition, the ASID of the ISOLATION domain is stored in the
isolated_asid bitmap. When the asid_map is refreshed, the isolated_asid
must be copied to the asid_map to ensure that the ASID of the ISOLATION
domain is not allocated by other processes.

The following figure shows the example:

    HOUSEKEEPING (genid: G1)            ISOLATION (genid: G2)

    task1(G1,1)                         task2(G2,2)     task3(G2,3)

    cpu0        cpu1                    cpu3    cpu4    cpu5
    -------------------------           -----------------------
                            \           /              |
                             \         /      isolated_asid: [2,3]
                              \       /
                 asid_map: [1,2,3,4,...,65536]

The task1 is running on the HOUSEKEEPING domain, it allocate ASID 1 from
shared asid_map, so the context id of task1 is (G1,1). The task2 and
task3 are running on the ISOLATION domain, they allocate ASID 2,3 from
shared asid_map, and store ASID 2,3 to isolated_asid. the context id of
task2 is (G2,2), and the context id of task3 is (G2,3). After a
rollover, the generation of HOUSEKEEPING doamin is flushed, for example,
it becomes to G3, then the context id of task1 is changed to (G3,1). In
this time, the generation of ISOLATION domain is not affected.

In some scenarios, a process has multiple threads, and different threads
run in different domains, or processes migrate between different domains.
But the process has only one context ID, there is a problem that how to
select generation in this case. The way we're thinking is, as long as
the process has run to ISOLATION doamin, select generation of ISOLATION
doamin.

For example:

    HOUSEKEEPING (genid: G1)            ISOLATION (genid: G2)

    task1(G1,1)               ====>     task1(G2,1)
    task2(G2,2)               <====     task2(G2,2)

    cpu0        cpu1                    cpu3    cpu4    cpu5
    -------------------------           -----------------------

When task1 is migrated from HOUSEKEEPING domain to ISOLATION domain, the
generation G1 must be changed to G2, and save the ASID 1 to isolated_asid
bitmap. But when task2 is migrated from ISOLATION domain to HOUSEKEEPING
domain, it still use generation G2. In this way, we solve the problem
that which generation should be selected in the scenario of process
migration.

As mentioned before, the generation of different domains is different.
we divide the generation into two parts, the lowest bit is used as the
Flag bit to indicate the HOUSEKEEPING and ISOLATION domain, and the rest
bits are used as the Upper-generation. After a rollover, only the
Upper-generation is flushed, the Flag part does not change in the entire
life. This ensures that the genrentaion of different domains is different.

    asid_generation    |---------------------------|-|--------|
                              Upper-generation     Flag

Finally, it is important to select which domain generation and TLBs are
flushed after a rollover. By default, only the HOUSEKEEPING domain is
selected. When the number of ASIDs in the ISOLATION domain exceeds the
max threshold, the ISOLATION domain is selected too.

By default, the ASID isolation feature is disabled, and a cmdline
parameter is provided to control whether the ASID isolation feature is
enabled.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 arch/arm64/mm/context.c | 203 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 183 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index e402997aa1c2..0ea3e7485ae7 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/cpumask.h>
+#include <linux/sched/isolation.h>
 
 #include <asm/cpufeature.h>
 #include <asm/mmu_context.h>
@@ -24,10 +25,20 @@ struct asid_bitmap {
 	unsigned long max;
 };
 
+enum {
+	ASID_HOUSEKEEPING = 0,
+	ASID_ISOLATION = 1,
+	ASID_TYPE_MAX,
+};
+
+struct asid_domain {
+	atomic64_t asid_generation;
+};
+
 static u32 asid_bits;
 static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
 
-static atomic64_t asid_generation;
+static struct asid_domain asid_domain[ASID_TYPE_MAX];
 static unsigned long *asid_map;
 
 static DEFINE_PER_CPU(atomic64_t, active_asids);
@@ -36,11 +47,16 @@ static cpumask_t tlb_flush_pending;
 static const struct cpumask *asid_housekeeping_mask;
 
 static struct asid_bitmap pinned_asid;
+static struct asid_bitmap isolated_asid;
+
+static int asid_isolation_cmdline;
+static DEFINE_STATIC_KEY_FALSE(asid_isolation_enable);
 
 #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
-#define ASID_FIRST_VERSION	(1UL << asid_bits)
+#define NUM_USER_ASIDS		(1UL << asid_bits)
 
-#define NUM_USER_ASIDS		ASID_FIRST_VERSION
+#define ASID_ISOLATION_FLAG	(NUM_USER_ASIDS)
+#define ASID_FIRST_VERSION	(NUM_USER_ASIDS << 1)
 #define ctxid2asid(asid)	((asid) & ~ASID_MASK)
 #define asid2ctxid(asid, genid)	((asid) | (genid))
 
@@ -94,6 +110,61 @@ static void set_kpti_asid_bits(unsigned long *map)
 	memset(map, 0xaa, len);
 }
 
+static inline bool is_isolated_asid(u64 asid)
+{
+	/*
+	 * Note that asid 0 is not the isolated asid. The judgment
+	 * is correct in this situation since the ASID_ISOLATION_FLAG
+	 * bit is defined as 1 to indicate ISOLATION domain.
+	 */
+	return asid & ASID_ISOLATION_FLAG;
+}
+
+static inline bool on_isolated_cpu(int cpu)
+{
+	return !cpumask_test_cpu(cpu, asid_housekeeping_mask);
+}
+
+static inline int asid_domain_type(u64 asid, unsigned int cpu)
+{
+	if (on_isolated_cpu(cpu) || is_isolated_asid(asid))
+		return ASID_ISOLATION;
+
+	return ASID_HOUSEKEEPING;
+}
+
+static inline int asid_flush_type(void)
+{
+	if (isolated_asid.nr > isolated_asid.max)
+		return ASID_ISOLATION;
+	else
+		return ASID_HOUSEKEEPING;
+}
+
+static void asid_try_to_isolate(u64 asid)
+{
+	if (!static_branch_unlikely(&asid_isolation_enable))
+		return;
+
+	if (!is_isolated_asid(asid))
+		return;
+	if (!__test_and_set_bit(ctxid2asid(asid), isolated_asid.map))
+		isolated_asid.nr++;
+}
+
+static void update_reserved_asid_bits(void)
+{
+	if (!static_branch_unlikely(&asid_isolation_enable))
+		return;
+
+	if (asid_flush_type() == ASID_HOUSEKEEPING) {
+		bitmap_or(asid_map, asid_map, isolated_asid.map, NUM_USER_ASIDS);
+	} else {
+		bitmap_zero(isolated_asid.map, NUM_USER_ASIDS);
+		isolated_asid.nr = 0;
+	}
+}
+
 static void set_reserved_asid_bits(void)
 {
 	if (pinned_asid.map)
@@ -102,23 +173,51 @@ static void set_reserved_asid_bits(void)
 		set_kpti_asid_bits(asid_map);
 	else
 		bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
+
+	update_reserved_asid_bits();
 }
 
 static void asid_generation_init(void)
 {
-	atomic64_set(&asid_generation, ASID_FIRST_VERSION);
+	struct asid_domain *ad;
+
+	ad = &asid_domain[ASID_HOUSEKEEPING];
+	atomic64_set(&ad->asid_generation, ASID_FIRST_VERSION);
+
+	ad = &asid_domain[ASID_ISOLATION];
+	atomic64_set(&ad->asid_generation, ASID_ISOLATION_FLAG);
 }
 
 static void flush_generation(void)
 {
+	struct asid_domain *ad = &asid_domain[ASID_HOUSEKEEPING];
+
 	/* We're out of ASIDs, so increment the global generation count */
 	atomic64_add_return_relaxed(ASID_FIRST_VERSION,
-					&asid_generation);
+					&ad->asid_generation);
+
+	if (asid_flush_type() == ASID_ISOLATION) {
+		ad = &asid_domain[ASID_ISOLATION];
+		atomic64_add_return_relaxed(ASID_FIRST_VERSION,
+					&ad->asid_generation);
+	}
 }
 
-static inline u64 asid_read_generation(void)
+static inline u64 asid_read_generation(int type)
 {
-	return atomic64_read(&asid_generation);
+	struct asid_domain *ad = &asid_domain[type];
+
+	return atomic64_read(&ad->asid_generation);
+}
+
+static inline u64 asid_curr_generation(u64 asid)
+{
+	int type = ASID_HOUSEKEEPING;
+
+	if (static_branch_unlikely(&asid_isolation_enable))
+		type = asid_domain_type(asid, smp_processor_id());
+
+	return asid_read_generation(type);
 }
 
 static inline bool asid_match(u64 asid, u64 genid)
@@ -128,12 +227,28 @@ static inline bool asid_match(u64 asid, u64 genid)
 
 static inline bool asid_gen_match(u64 asid)
 {
-	return asid_match(asid, asid_read_generation());
+	return asid_match(asid, asid_curr_generation(asid));
+}
+
+static bool asid_is_migrated(u64 asid, u64 newasid)
+{
+	if (!static_branch_unlikely(&asid_isolation_enable))
+		return false;
+
+	if (!is_isolated_asid(asid) && is_isolated_asid(newasid)) {
+		u64 generation = asid_read_generation(ASID_HOUSEKEEPING);
+
+		return asid_match(asid, generation);
+	}
+	return false;
 }
 
 static const struct cpumask *flush_cpumask(void)
 {
-	return asid_housekeeping_mask;
+	if (asid_flush_type() == ASID_HOUSEKEEPING)
+		return asid_housekeeping_mask;
+
+	return cpu_possible_mask;
 }
 
 static void flush_context(void)
@@ -159,6 +274,7 @@ static void flush_context(void)
 		if (asid == 0)
 			asid = per_cpu(reserved_asids, i);
 		__set_bit(ctxid2asid(asid), asid_map);
+		asid_try_to_isolate(asid);
 		per_cpu(reserved_asids, i) = asid;
 	}
 
@@ -193,21 +309,23 @@ static bool check_update_reserved_asid(u64 asid, u64 newasid)
 	return hit;
 }
 
-static u64 new_context(struct mm_struct *mm)
+static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 {
 	static u32 cur_idx = 1;
 	u64 asid = atomic64_read(&mm->context.id);
-	u64 generation = asid_read_generation();
+	int domain = asid_domain_type(asid, cpu);
+	u64 generation = asid_read_generation(domain);
+	u64 newasid;
 
 	if (asid != 0) {
-		u64 newasid = asid2ctxid(ctxid2asid(asid), generation);
+		newasid = asid2ctxid(ctxid2asid(asid), generation);
 
 		/*
 		 * If our current ASID was active during a rollover, we
 		 * can continue to use it and this was just a false alarm.
 		 */
 		if (check_update_reserved_asid(asid, newasid))
-			return newasid;
+			goto out;
 
 		/*
 		 * If it is pinned, we can keep using it. Note that reserved
@@ -215,14 +333,21 @@ static u64 new_context(struct mm_struct *mm)
 		 * update the generation into the reserved_asids.
 		 */
 		if (refcount_read(&mm->context.pinned))
-			return newasid;
+			goto out;
 
 		/*
 		 * We had a valid ASID in a previous life, so try to re-use
 		 * it if possible.
 		 */
 		if (!__test_and_set_bit(ctxid2asid(asid), asid_map))
-			return newasid;
+			goto out;
+
+		/*
+		 * We still have a valid ASID now, but the ASID is migrated from
+		 * normal to isolated domain, we should re-use it.
+		 */
+		if (asid_is_migrated(asid, newasid))
+			goto out;
 	}
 
 	/*
@@ -241,11 +366,14 @@ static u64 new_context(struct mm_struct *mm)
 	/* We have more ASIDs than CPUs, so this will always succeed */
 	asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, 1);
 
-	generation = asid_read_generation();
+	generation = asid_read_generation(domain);
 set_asid:
 	__set_bit(asid, asid_map);
 	cur_idx = asid;
-	return asid2ctxid(asid, generation);
+	newasid = asid2ctxid(asid, generation);
+out:
+	asid_try_to_isolate(newasid);
+	return newasid;
 }
 
 void check_and_switch_context(struct mm_struct *mm)
@@ -282,12 +410,12 @@ void check_and_switch_context(struct mm_struct *mm)
 	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
 	/* Check that our ASID belongs to the current generation. */
 	asid = atomic64_read(&mm->context.id);
+	cpu = smp_processor_id();
 	if (!asid_gen_match(asid)) {
-		asid = new_context(mm);
+		asid = new_context(mm, cpu);
 		atomic64_set(&mm->context.id, asid);
 	}
 
-	cpu = smp_processor_id();
 	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
 		local_flush_tlb_all();
 
@@ -327,11 +455,12 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
 	}
 
 	if (!asid_gen_match(asid)) {
+		unsigned int cpu = smp_processor_id();
 		/*
 		 * We went through one or more rollover since that ASID was
 		 * used. Ensure that it is still valid, or generate a new one.
 		 */
-		asid = new_context(mm);
+		asid = new_context(mm, cpu);
 		atomic64_set(&mm->context.id, asid);
 	}
 
@@ -430,10 +559,36 @@ static int asids_update_limit(void)
 	 * are pinned, there still is at least one empty slot in the ASID map.
 	 */
 	pinned_asid.max = num_available_asids - num_possible_cpus() - 2;
+
+	/*
+	 * Generally, the user does not care about the number of asids, so set
+	 * to half of the total number as the default setting of the maximum
+	 * threshold of the isolated asid.
+	 */
+	if (isolated_asid.map)
+		isolated_asid.max = num_available_asids / 2;
+
 	return 0;
 }
 arch_initcall(asids_update_limit);
 
+static void asid_isolation_init(void)
+{
+	if (asid_isolation_cmdline == 0)
+		return;
+
+	if (!housekeeping_enabled(HK_TYPE_DOMAIN))
+		return;
+
+	isolated_asid.map = bitmap_zalloc(NUM_USER_ASIDS, GFP_KERNEL);
+	if (!isolated_asid.map)
+		return;
+
+	asid_housekeeping_mask = housekeeping_cpumask(HK_TYPE_DOMAIN);
+	static_branch_enable(&asid_isolation_enable);
+	pr_info("ASID Isolation enable\n");
+}
+
 static int asids_init(void)
 {
 	asid_bits = get_cpu_asid_bits();
@@ -448,6 +603,7 @@ static int asids_init(void)
 	pinned_asid.nr = 0;
 
 	asid_housekeeping_mask = cpu_possible_mask;
+	asid_isolation_init();
 
 	/*
 	 * We cannot call set_reserved_asid_bits() here because CPU
@@ -459,3 +615,10 @@ static int asids_init(void)
 	return 0;
 }
 early_initcall(asids_init);
+
+static int __init asid_isolation_setup(char *str)
+{
+	asid_isolation_cmdline = 1;
+	return 1;
+}
+__setup("asid_isolation", asid_isolation_setup);
-- 
2.27.0

