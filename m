Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E356008C0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiJQIdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiJQIcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:32:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4BA101DE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:32:46 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MrVc220fLzHvtL;
        Mon, 17 Oct 2022 16:32:34 +0800 (CST)
Received: from huawei.com (10.44.134.232) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 16:32:07 +0800
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yeyunfeng@huawei.com>
CC:     <linfeilong@huawei.com>
Subject: [PATCH 1/5] arm64: mm: Define asid_bitmap structure for pinned_asid
Date:   Mon, 17 Oct 2022 16:31:59 +0800
Message-ID: <20221017083203.3690346-2-yeyunfeng@huawei.com>
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

It is clearer to use the asid_bitmap structure for pinned_sid, and we
will use it for isolated asid later.

No functional change.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 arch/arm64/mm/context.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index e1e0dca01839..8549b5f30352 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -17,6 +17,12 @@
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
 
+struct asid_bitmap {
+	unsigned long *map;
+	unsigned long nr;
+	unsigned long max;
+};
+
 static u32 asid_bits;
 static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
 
@@ -27,9 +33,7 @@ static DEFINE_PER_CPU(atomic64_t, active_asids);
 static DEFINE_PER_CPU(u64, reserved_asids);
 static cpumask_t tlb_flush_pending;
 
-static unsigned long max_pinned_asids;
-static unsigned long nr_pinned_asids;
-static unsigned long *pinned_asid_map;
+static struct asid_bitmap pinned_asid;
 
 #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
 #define ASID_FIRST_VERSION	(1UL << asid_bits)
@@ -90,8 +94,8 @@ static void set_kpti_asid_bits(unsigned long *map)
 
 static void set_reserved_asid_bits(void)
 {
-	if (pinned_asid_map)
-		bitmap_copy(asid_map, pinned_asid_map, NUM_USER_ASIDS);
+	if (pinned_asid.map)
+		bitmap_copy(asid_map, pinned_asid.map, NUM_USER_ASIDS);
 	else if (arm64_kernel_unmapped_at_el0())
 		set_kpti_asid_bits(asid_map);
 	else
@@ -275,7 +279,7 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
 	unsigned long flags;
 	u64 asid;
 
-	if (!pinned_asid_map)
+	if (!pinned_asid.map)
 		return 0;
 
 	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
@@ -285,7 +289,7 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
 	if (refcount_inc_not_zero(&mm->context.pinned))
 		goto out_unlock;
 
-	if (nr_pinned_asids >= max_pinned_asids) {
+	if (pinned_asid.nr >= pinned_asid.max) {
 		asid = 0;
 		goto out_unlock;
 	}
@@ -299,8 +303,8 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
 		atomic64_set(&mm->context.id, asid);
 	}
 
-	nr_pinned_asids++;
-	__set_bit(ctxid2asid(asid), pinned_asid_map);
+	pinned_asid.nr++;
+	__set_bit(ctxid2asid(asid), pinned_asid.map);
 	refcount_set(&mm->context.pinned, 1);
 
 out_unlock:
@@ -321,14 +325,14 @@ void arm64_mm_context_put(struct mm_struct *mm)
 	unsigned long flags;
 	u64 asid = atomic64_read(&mm->context.id);
 
-	if (!pinned_asid_map)
+	if (!pinned_asid.map)
 		return;
 
 	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
 
 	if (refcount_dec_and_test(&mm->context.pinned)) {
-		__clear_bit(ctxid2asid(asid), pinned_asid_map);
-		nr_pinned_asids--;
+		__clear_bit(ctxid2asid(asid), pinned_asid.map);
+		pinned_asid.nr--;
 	}
 
 	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
@@ -377,8 +381,8 @@ static int asids_update_limit(void)
 
 	if (arm64_kernel_unmapped_at_el0()) {
 		num_available_asids /= 2;
-		if (pinned_asid_map)
-			set_kpti_asid_bits(pinned_asid_map);
+		if (pinned_asid.map)
+			set_kpti_asid_bits(pinned_asid.map);
 	}
 	/*
 	 * Expect allocation after rollover to fail if we don't have at least
@@ -393,7 +397,7 @@ static int asids_update_limit(void)
 	 * even if all CPUs have a reserved ASID and the maximum number of ASIDs
 	 * are pinned, there still is at least one empty slot in the ASID map.
 	 */
-	max_pinned_asids = num_available_asids - num_possible_cpus() - 2;
+	pinned_asid.max = num_available_asids - num_possible_cpus() - 2;
 	return 0;
 }
 arch_initcall(asids_update_limit);
@@ -407,8 +411,8 @@ static int asids_init(void)
 		panic("Failed to allocate bitmap for %lu ASIDs\n",
 		      NUM_USER_ASIDS);
 
-	pinned_asid_map = bitmap_zalloc(NUM_USER_ASIDS, GFP_KERNEL);
-	nr_pinned_asids = 0;
+	pinned_asid.map = bitmap_zalloc(NUM_USER_ASIDS, GFP_KERNEL);
+	pinned_asid.nr = 0;
 
 	/*
 	 * We cannot call set_reserved_asid_bits() here because CPU
-- 
2.27.0

