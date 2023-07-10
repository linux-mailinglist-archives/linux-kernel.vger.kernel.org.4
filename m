Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7604D74D06A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjGJInV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjGJIm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:42:59 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF691992;
        Mon, 10 Jul 2023 01:41:41 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Qzy8Y75pSzPk2S;
        Mon, 10 Jul 2023 16:38:53 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 16:41:11 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <akpm@linux-foundation.org>, <catalin.marinas@arm.com>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <x86@kernel.org>, <mark.rutland@arm.com>, <ryan.roberts@arm.com>,
        <will@kernel.org>, <anshuman.khandual@arm.com>,
        <linux-doc@vger.kernel.org>
CC:     <corbet@lwn.net>, <peterz@infradead.org>, <arnd@arndb.de>,
        <punit.agrawal@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <darren@os.amperecomputing.com>, <yangyicong@hisilicon.com>,
        <huzhanyuan@oppo.com>, <lipeifeng@oppo.com>,
        <zhangshiming@oppo.com>, <guojian@oppo.com>, <realmz6@gmail.com>,
        <linux-mips@vger.kernel.org>, <openrisc@lists.librecores.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>, Barry Song <21cnbao@gmail.com>,
        <wangkefeng.wang@huawei.com>, <xhao@linux.alibaba.com>,
        <prime.zeng@hisilicon.com>, <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v10 3/4] mm/tlbbatch: Introduce arch_flush_tlb_batched_pending()
Date:   Mon, 10 Jul 2023 16:39:13 +0800
Message-ID: <20230710083914.18336-4-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230710083914.18336-1-yangyicong@huawei.com>
References: <20230710083914.18336-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

Currently we'll flush the mm in flush_tlb_batched_pending() to
avoid race between reclaim unmaps pages by batched TLB flush
and mprotect/munmap/etc. Other architectures like arm64 may
only need a synchronization barrier(dsb) here rather than
a full mm flush. So add arch_flush_tlb_batched_pending() to
allow an arch-specific implementation here. This intends no
functional changes on x86 since still a full mm flush for
x86.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 arch/x86/include/asm/tlbflush.h | 5 +++++
 mm/rmap.c                       | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 1c7d3a36e16c..837e4a50281a 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -284,6 +284,11 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
 	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
 }
 
+static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
+{
+	flush_tlb_mm(mm);
+}
+
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
 static inline bool pte_flags_need_flush(unsigned long oldflags,
diff --git a/mm/rmap.c b/mm/rmap.c
index 9699c6011b0e..3a16c91be7e2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -717,7 +717,7 @@ void flush_tlb_batched_pending(struct mm_struct *mm)
 	int flushed = batch >> TLB_FLUSH_BATCH_FLUSHED_SHIFT;
 
 	if (pending != flushed) {
-		flush_tlb_mm(mm);
+		arch_flush_tlb_batched_pending(mm);
 		/*
 		 * If the new TLB flushing is pending during flushing, leave
 		 * mm->tlb_flush_batched as is, to avoid losing flushing.
-- 
2.24.0

