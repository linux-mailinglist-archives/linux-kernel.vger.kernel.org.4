Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325B160087F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiJQINu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiJQINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:13:39 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A3A5C377
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:13:36 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MrV4h352tz1P7Zm;
        Mon, 17 Oct 2022 16:08:52 +0800 (CST)
Received: from huawei.com (10.44.134.232) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 16:13:03 +0800
From:   y00318929 <yeyunfeng@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yeyunfeng@huawei.com>
Subject: [PATCH 3/5] arm64: mm: Use cpumask in flush_context()
Date:   Mon, 17 Oct 2022 16:12:56 +0800
Message-ID: <20221017081258.3678830-4-yeyunfeng@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221017081258.3678830-1-yeyunfeng@huawei.com>
References: <20221017081258.3678830-1-yeyunfeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.44.134.232]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

Currently, all CPUs are selected to flush TLB in flush_context().
In order to prepare for flushing only part of the CPUs TLB, we use
asid_housekeeping_mask and use cpumask_or() instead of cpumask_setall().

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 arch/arm64/mm/context.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 380c7b05c36b..e402997aa1c2 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/cpumask.h>
 
 #include <asm/cpufeature.h>
 #include <asm/mmu_context.h>
@@ -32,6 +33,7 @@ static unsigned long *asid_map;
 static DEFINE_PER_CPU(atomic64_t, active_asids);
 static DEFINE_PER_CPU(u64, reserved_asids);
 static cpumask_t tlb_flush_pending;
+static const struct cpumask *asid_housekeeping_mask;
 
 static struct asid_bitmap pinned_asid;
 
@@ -129,17 +131,23 @@ static inline bool asid_gen_match(u64 asid)
 	return asid_match(asid, asid_read_generation());
 }
 
+static const struct cpumask *flush_cpumask(void)
+{
+	return asid_housekeeping_mask;
+}
+
 static void flush_context(void)
 {
 	int i;
 	u64 asid;
+	const struct cpumask *cpumask = flush_cpumask();
 
 	flush_generation();
 
 	/* Update the list of reserved ASIDs and the ASID bitmap. */
 	set_reserved_asid_bits();
 
-	for_each_possible_cpu(i) {
+	for_each_cpu(i, cpumask) {
 		asid = atomic64_xchg_relaxed(&per_cpu(active_asids, i), 0);
 		/*
 		 * If this CPU has already been through a
@@ -158,7 +166,7 @@ static void flush_context(void)
 	 * Queue a TLB invalidation for each CPU to perform on next
 	 * context-switch
 	 */
-	cpumask_setall(&tlb_flush_pending);
+	cpumask_or(&tlb_flush_pending, &tlb_flush_pending, cpumask);
 }
 
 static bool check_update_reserved_asid(u64 asid, u64 newasid)
@@ -439,6 +447,8 @@ static int asids_init(void)
 	pinned_asid.map = bitmap_zalloc(NUM_USER_ASIDS, GFP_KERNEL);
 	pinned_asid.nr = 0;
 
+	asid_housekeeping_mask = cpu_possible_mask;
+
 	/*
 	 * We cannot call set_reserved_asid_bits() here because CPU
 	 * caps are not finalized yet, so it is safer to assume KPTI
-- 
2.27.0

