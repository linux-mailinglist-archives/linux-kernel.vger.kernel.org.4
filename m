Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB3F6008BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiJQIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiJQIcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:32:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0F73FEC9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:32:41 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MrVc23jfWzHvRq;
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
Subject: [PATCH 2/5] arm64: mm: Extract the processing of asid_generation
Date:   Mon, 17 Oct 2022 16:32:00 +0800
Message-ID: <20221017083203.3690346-3-yeyunfeng@huawei.com>
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

To prepare for supporting ASID isolation feature, extract the processing
of asid_generation. it is convenient to modify the asid_generation
centrally.

By the way, It is clearer to put flush_generation() into flush_context().

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 arch/arm64/mm/context.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 8549b5f30352..380c7b05c36b 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -102,14 +102,40 @@ static void set_reserved_asid_bits(void)
 		bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
 }
 
-#define asid_gen_match(asid) \
-	(!(((asid) ^ atomic64_read(&asid_generation)) >> asid_bits))
+static void asid_generation_init(void)
+{
+	atomic64_set(&asid_generation, ASID_FIRST_VERSION);
+}
+
+static void flush_generation(void)
+{
+	/* We're out of ASIDs, so increment the global generation count */
+	atomic64_add_return_relaxed(ASID_FIRST_VERSION,
+					&asid_generation);
+}
+
+static inline u64 asid_read_generation(void)
+{
+	return atomic64_read(&asid_generation);
+}
+
+static inline bool asid_match(u64 asid, u64 genid)
+{
+	return (!(((asid) ^ (genid)) >> asid_bits));
+}
+
+static inline bool asid_gen_match(u64 asid)
+{
+	return asid_match(asid, asid_read_generation());
+}
 
 static void flush_context(void)
 {
 	int i;
 	u64 asid;
 
+	flush_generation();
+
 	/* Update the list of reserved ASIDs and the ASID bitmap. */
 	set_reserved_asid_bits();
 
@@ -163,7 +189,7 @@ static u64 new_context(struct mm_struct *mm)
 {
 	static u32 cur_idx = 1;
 	u64 asid = atomic64_read(&mm->context.id);
-	u64 generation = atomic64_read(&asid_generation);
+	u64 generation = asid_read_generation();
 
 	if (asid != 0) {
 		u64 newasid = asid2ctxid(ctxid2asid(asid), generation);
@@ -202,14 +228,12 @@ static u64 new_context(struct mm_struct *mm)
 	if (asid != NUM_USER_ASIDS)
 		goto set_asid;
 
-	/* We're out of ASIDs, so increment the global generation count */
-	generation = atomic64_add_return_relaxed(ASID_FIRST_VERSION,
-						 &asid_generation);
 	flush_context();
 
 	/* We have more ASIDs than CPUs, so this will always succeed */
 	asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, 1);
 
+	generation = asid_read_generation();
 set_asid:
 	__set_bit(asid, asid_map);
 	cur_idx = asid;
@@ -405,7 +429,8 @@ arch_initcall(asids_update_limit);
 static int asids_init(void)
 {
 	asid_bits = get_cpu_asid_bits();
-	atomic64_set(&asid_generation, ASID_FIRST_VERSION);
+	asid_generation_init();
+
 	asid_map = bitmap_zalloc(NUM_USER_ASIDS, GFP_KERNEL);
 	if (!asid_map)
 		panic("Failed to allocate bitmap for %lu ASIDs\n",
-- 
2.27.0

