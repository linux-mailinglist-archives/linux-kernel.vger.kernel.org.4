Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CC9600880
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJQIOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiJQINo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:13:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416F55C369
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:13:40 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MrV4j0fT1z1P7hZ;
        Mon, 17 Oct 2022 16:08:53 +0800 (CST)
Received: from huawei.com (10.44.134.232) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 16:13:04 +0800
From:   y00318929 <yeyunfeng@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yeyunfeng@huawei.com>
Subject: [PATCH 5/5] arm64: mm: Add TLB flush trace on context switch
Date:   Mon, 17 Oct 2022 16:12:58 +0800
Message-ID: <20221017081258.3678830-6-yeyunfeng@huawei.com>
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

We do not know how many times the TLB is flushed on context switch.
Adding trace_tlb_flush() in check_and_switch_context() may be useful.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 arch/arm64/mm/context.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 0ea3e7485ae7..eab470a97620 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -19,6 +19,8 @@
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
 
+#include <trace/events/tlb.h>
+
 struct asid_bitmap {
 	unsigned long *map;
 	unsigned long nr;
@@ -60,6 +62,8 @@ static DEFINE_STATIC_KEY_FALSE(asid_isolation_enable);
 #define ctxid2asid(asid)	((asid) & ~ASID_MASK)
 #define asid2ctxid(asid, genid)	((asid) | (genid))
 
+#define TLB_FLUSH_ALL		(-1)
+
 /* Get the ASIDBits supported by the current CPU */
 static u32 get_cpu_asid_bits(void)
 {
@@ -416,8 +420,10 @@ void check_and_switch_context(struct mm_struct *mm)
 		atomic64_set(&mm->context.id, asid);
 	}
 
-	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
+	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending)) {
 		local_flush_tlb_all();
+		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
+	}
 
 	atomic64_set(this_cpu_ptr(&active_asids), asid);
 	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
-- 
2.27.0

