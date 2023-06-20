Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3367364FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjFTHm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjFTHmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:42:32 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B70CF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:42:19 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-be3b35ae72dso4470732276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687246939; x=1689838939;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mQCeX//121ajNwvCY66Rysl9c9mZt4CnPkKAdBrlyo=;
        b=Rk9aZz3lCgWM/wzoeIdA8TQQHo7EP0qUx4FBk6w6vBIv3V9EGmhpCtWeOKkVLalH/B
         3/IhZXP8pzSAUtUwv1YZ0rZFRUBVXIfjAUyirXzYoBsOop5Z2sZPS+eTpvJIhr7MrLYm
         LUjzgRD1GyQ/XuvAm8PLozNnLUaUsJj8Srr/G3h67lgjS83i0yMgd02EIVoO5rsRx9kI
         daqlfGCCUSLKQt7wMh3o0YW7GwW3VGqW8slprzgeDxp+5B0Z6u1+4uuHf8AelDneMwjV
         DKf7ckeYtLcfEfqu2RjXHw4XHJyjxhdMznrF0GKkr5IkH8s4Le9upNEGz9sVfSI4hq5l
         39mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687246939; x=1689838939;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mQCeX//121ajNwvCY66Rysl9c9mZt4CnPkKAdBrlyo=;
        b=WxQwtBgzb9TP2kdtTi/B44z0bDZJVx5KGzA4YEbR6nr9tUdBlvL8NXfyqJmpE8Cuiu
         pnRtsVEMB3MhKzuKTq46OdviE7jRgyWKCJuEIQ/gODbGEmPxS9P+U2Kauo2i970gAU4x
         Z806Kp0c/E+D6w1+7abTjA0HPXbEffp2txddpQSI0VEf2iOe135xREehT+UO7rxdyaxs
         VkpMB54Wbq1jMozN41LTzZBAB6fV85yuutCQcoovqdrJzT3N94jC9fbjK13F9qQCMsGc
         JTSprXkEpJMSodtJcXGTrCTFHYZR42IdgE/oQlsdZMMvkYoEHTq6IAfM2mwvlq1vFtbj
         sQ5Q==
X-Gm-Message-State: AC+VfDwUlPbBrQHwqpsu+4gnY7ORK5F6Ox1VDgjYYj+Gbh4yPaT8uXsx
        xCdVZ1p2U+4Em+G1h+keaWbKSg==
X-Google-Smtp-Source: ACHHUZ5rgE5ZeLfP+qyjhwCRCkWSPHoZuMre6lfq8YixODGIptTSfSS2sgODZVUUkcQ4STmKqbbGHw==
X-Received: by 2002:a25:4dc2:0:b0:bac:4dd6:d0d1 with SMTP id a185-20020a254dc2000000b00bac4dd6d0d1mr7498427ybb.19.1687246938747;
        Tue, 20 Jun 2023 00:42:18 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j200-20020a2523d1000000b00be6cf9d2544sm254636ybj.40.2023.06.20.00.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 00:42:18 -0700 (PDT)
Date:   Tue, 20 Jun 2023 00:42:13 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David Sc. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 02/12] mm/pgtable: add PAE safety to __pte_offset_map()
In-Reply-To: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
Message-ID: <df1884ce-93c-efa-2354-4d749eb25f1@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a faint risk that __pte_offset_map(), on a 32-bit architecture
with a 64-bit pmd_t e.g. x86-32 with CONFIG_X86_PAE=y, would succeed on
a pmdval assembled from a pmd_low and a pmd_high which never belonged
together: their combination not pointing to a page table at all, perhaps
not even a valid pfn.  pmdp_get_lockless() is not enough to prevent that.

Guard against that (on such configs) by local_irq_save() blocking TLB
flush between present updates, as linux/pgtable.h suggests.  It's only
needed around the pmdp_get_lockless() in __pte_offset_map(): a race when
__pte_offset_map_lock() repeats the pmdp_get_lockless() after getting the
lock, would just send it back to __pte_offset_map() again.

Complement this pmdp_get_lockless_start() and pmdp_get_lockless_end(),
used only locally in __pte_offset_map(), with a pmdp_get_lockless_sync()
synonym for tlb_remove_table_sync_one(): to send the necessary interrupt
at the right moment on those configs which do not already send it.

CONFIG_GUP_GET_PXX_LOW_HIGH is enabled when required by mips, sh and x86.
It is not enabled by arm-32 CONFIG_ARM_LPAE: my understanding is that
Will Deacon's 2020 enhancements to READ_ONCE() are sufficient for arm.
It is not enabled by arc, but its pmd_t is 32-bit even when pte_t 64-bit.

Limit the IRQ disablement to CONFIG_HIGHPTE?  Perhaps, but would need a
little more work, to retry if pmd_low good for page table, but pmd_high
non-zero from THP (and that might be making x86-specific assumptions).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/pgtable.h |  4 ++++
 mm/pgtable-generic.c    | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8b0fc7fdc46f..525f1782b466 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -390,6 +390,7 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
 	return pmd;
 }
 #define pmdp_get_lockless pmdp_get_lockless
+#define pmdp_get_lockless_sync() tlb_remove_table_sync_one()
 #endif /* CONFIG_PGTABLE_LEVELS > 2 */
 #endif /* CONFIG_GUP_GET_PXX_LOW_HIGH */
 
@@ -408,6 +409,9 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
 {
 	return pmdp_get(pmdp);
 }
+static inline void pmdp_get_lockless_sync(void)
+{
+}
 #endif
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 674671835631..5e85a625ab30 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -232,12 +232,41 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 #endif
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+#if defined(CONFIG_GUP_GET_PXX_LOW_HIGH) && \
+	(defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RCU))
+/*
+ * See the comment above ptep_get_lockless() in include/linux/pgtable.h:
+ * the barriers in pmdp_get_lockless() cannot guarantee that the value in
+ * pmd_high actually belongs with the value in pmd_low; but holding interrupts
+ * off blocks the TLB flush between present updates, which guarantees that a
+ * successful __pte_offset_map() points to a page from matched halves.
+ */
+static unsigned long pmdp_get_lockless_start(void)
+{
+	unsigned long irqflags;
+
+	local_irq_save(irqflags);
+	return irqflags;
+}
+static void pmdp_get_lockless_end(unsigned long irqflags)
+{
+	local_irq_restore(irqflags);
+}
+#else
+static unsigned long pmdp_get_lockless_start(void) { return 0; }
+static void pmdp_get_lockless_end(unsigned long irqflags) { }
+#endif
+
 pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 {
+	unsigned long irqflags;
 	pmd_t pmdval;
 
 	rcu_read_lock();
+	irqflags = pmdp_get_lockless_start();
 	pmdval = pmdp_get_lockless(pmd);
+	pmdp_get_lockless_end(irqflags);
+
 	if (pmdvalp)
 		*pmdvalp = pmdval;
 	if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
-- 
2.35.3

