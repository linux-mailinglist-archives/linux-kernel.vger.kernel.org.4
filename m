Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D99610C03
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJ1IOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJ1IOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:14:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853B31C2F2A;
        Fri, 28 Oct 2022 01:14:00 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MzFcG1FNczFq4L;
        Fri, 28 Oct 2022 16:11:10 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 16:13:58 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <anshuman.khandual@arm.com>, <linux-doc@vger.kernel.org>
CC:     <corbet@lwn.net>, <peterz@infradead.org>, <arnd@arndb.de>,
        <punit.agrawal@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <darren@os.amperecomputing.com>, <yangyicong@hisilicon.com>,
        <huzhanyuan@oppo.com>, <lipeifeng@oppo.com>,
        <zhangshiming@oppo.com>, <guojian@oppo.com>, <realmz6@gmail.com>,
        <linux-mips@vger.kernel.org>, <openrisc@lists.librecores.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>, Barry Song <21cnbao@gmail.com>,
        <wangkefeng.wang@huawei.com>, <xhao@linux.alibaba.com>,
        <prime.zeng@hisilicon.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Barry Song <baohua@kernel.org>
Subject: [PATCH v5 1/2] mm/tlbbatch: Introduce arch_tlbbatch_should_defer()
Date:   Fri, 28 Oct 2022 16:12:54 +0800
Message-ID: <20221028081255.19157-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221028081255.19157-1-yangyicong@huawei.com>
References: <20221028081255.19157-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

The entire scheme of deferred TLB flush in reclaim path rests on the
fact that the cost to refill TLB entries is less than flushing out
individual entries by sending IPI to remote CPUs. But architecture
can have different ways to evaluate that. Hence apart from checking
TTU_BATCH_FLUSH in the TTU flags, rest of the decision should be
architecture specific.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
[https://lore.kernel.org/linuxppc-dev/20171101101735.2318-2-khandual@linux.vnet.ibm.com/]
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
[Rebase and fix incorrect return value type]
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Barry Song <baohua@kernel.org>
---
 arch/x86/include/asm/tlbflush.h | 12 ++++++++++++
 mm/rmap.c                       |  9 +--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index cda3118f3b27..8a497d902c16 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -240,6 +240,18 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
 }
 
+static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
+{
+	bool should_defer = false;
+
+	/* If remote CPUs need to be flushed then defer batch the flush */
+	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
+		should_defer = true;
+	put_cpu();
+
+	return should_defer;
+}
+
 static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
 {
 	/*
diff --git a/mm/rmap.c b/mm/rmap.c
index 2ec925e5fa6a..a9ab10bc0144 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -685,17 +685,10 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
  */
 static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
 {
-	bool should_defer = false;
-
 	if (!(flags & TTU_BATCH_FLUSH))
 		return false;
 
-	/* If remote CPUs need to be flushed then defer batch the flush */
-	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
-		should_defer = true;
-	put_cpu();
-
-	return should_defer;
+	return arch_tlbbatch_should_defer(mm);
 }
 
 /*
-- 
2.24.0

