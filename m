Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B415EC97F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiI0Q3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiI0Q2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:28:36 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749931D73E7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:28:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x1so9554506plv.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=UPBfe5+emU2lZV2Ta0H8Gmt2le1D45pCpoZ1AicX3QU=;
        b=VFnTafmMx7bEEJfYVDIA0Rrh91fZRWNgXbWeRC7qecbBwMh6+y8LhKIbJAkCwZc966
         475Bg3KBMO4hzTojVN3B6klCt32d2Et6kL5RpheWAZpl65RO/Puxf8I9xyOrjFeN3pl6
         5SxuNykCP5I6qo3oYBgdFP6AJSx5+8nSur0f5kbrUDDy/c29DeBWEnSZ0p61uMc/4wOA
         CtPDUOQvHwkhYvWlC3+azC65w742QUsW0/RC/x8clzIyw3YDFl1MPael81G4b/pMySc9
         NZNebC0kYIRWx3jD2CFP38149zxkE5ya+GauiEui96YKD9G/uZbnAGc59wS2CXLTi4Y6
         +VoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UPBfe5+emU2lZV2Ta0H8Gmt2le1D45pCpoZ1AicX3QU=;
        b=MwmX+Gq0Rkv4g5KkBZ/1ISAXdeS+kGPd/2s3APf3J54rtkXavmqj9KZi7dZJqjfKOG
         Uquro/+cg2OcL38rA2iselKi3mZU9Mtdn5k419KotlQvX4bCWS0TZVlbO11KoamLds+x
         WglS8hE38dOPjUmg15fzsMhiopfw+lyvPnQwIUgxWTxmaSVUKOm2nobLtmBaGV3p3wHP
         RamqJCY7rKenOSwrvxYRPzKKi2QgoVq/6VpIvQCoKnskQqw08iJQe8NMFrLW7eGyF5i0
         K10+5JalbS+xXSrYjWAo/1V6FcQ7mU1G/QTloEf75I/soXRC3AJfkOa7qjTF+Hoi5raZ
         dJcQ==
X-Gm-Message-State: ACrzQf2DlQPsSyCdS0Bc5C78MbtsGLAT0Bc7Irq6UuKJZlZPf8R/F8AP
        SQCDRqLF+XhQhiwhywDCnuc=
X-Google-Smtp-Source: AMsMyM4ONx1zJi90ty+YJenscn3ji4lqd2kzXea94wuzGI9g1HdJMJaGRSKMilkaJeT7h6vj5xnbqg==
X-Received: by 2002:a17:902:d485:b0:179:e4a2:18c2 with SMTP id c5-20020a170902d48500b00179e4a218c2mr5282084plg.160.1664296106198;
        Tue, 27 Sep 2022 09:28:26 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id 9-20020a17090a0f0900b001f333fab3d6sm8602360pjy.18.2022.09.27.09.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:28:25 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>, Nadav Amit <namit@vmware.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [RFC PATCH v2 9/9] mm: Introduce Copy-On-Write PTE table
Date:   Wed, 28 Sep 2022 00:29:57 +0800
Message-Id: <20220927162957.270460-10-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927162957.270460-1-shiyn.lin@gmail.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the Copy-On-Write (COW) mechanism to the PTE table.
To enable the COW page table use the sysctl vm.cow_pte file with the
corresponding PID. It will set the MMF_COW_PTE_READY flag to the
process for enabling COW PTE during the next time of fork.

It uses the MMF_COW_PTE flag to distinguish the normal page table
and the COW one. Moreover, it is difficult to distinguish whether the
entire page table is out of COW state. So the MMF_COW_PTE flag won't be
disabled after its setup.

Since the memory space of the page table is distinctive for each process
in kernel space. It uses the address of the PMD index for the PTE table
ownership to identify which one of the processes needs to update the
page table state. In other words, only the owner will update shared
(COWed) PTE table state, like the RSS and pgtable_bytes.

Some PTE tables (e.g., pinned pages that reside in the table) still need
to be copied immediately for consistency with the current COW logic. As
a result, a flag, COW_PTE_OWNER_EXCLUSIVE, indicating whether a PTE
table is exclusive (i.e., only one task owns it at a time) is added to
the table’s owner pointer. Every time a PTE table is copied during the
fork, the owner pointer (and thus the exclusive flag) will be checked to
determine whether the PTE table can be shared across processes.

It uses a reference count to track the lifetime of COWed PTE table.
Doing the fork with COW PTE will increase the refcount. And, when
someone writes to the COWed PTE table, it will cause the write fault to
break COW PTE. If the COWed PTE table's refcount is one, the process
that triggers the fault will reuse the COWed PTE table. Otherwise, the
process will decrease the refcount, copy the information to a new PTE
table or dereference all the information and change the owner if they
have the COWed PTE table.

If doing the COW to the PTE table once as the time touching the PMD
entry, it cannot preserves the reference count of the COWed PTE table.
Since the address range of VMA may overlap the PTE table, the copying
function will use VMA to travel the page table for copying it. So it may
increase the reference count of the COWed PTE table multiple times in
one COW page table forking. Generically it will only increase once time
as the child reference it. To solve this problem, it needs to check the
destination of PMD entry does exist. And the reference count of the
source PTE table is more than one before doing the COW.

This patch modifies the part of the copy page table to do the basic COW.
For the break COW, it modifies the part of a page fault, zaps page table
, unmapping, and remapping.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/memory.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++----
 mm/mmap.c   |  3 ++
 mm/mremap.c |  3 ++
 3 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 4cf3f74fb183f..c532448b5e086 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -250,6 +250,9 @@ static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
+		VM_BUG_ON(cow_pte_count(pmd) != 1);
+		if (!pmd_cow_pte_exclusive(pmd))
+			VM_BUG_ON(!cow_pte_owner_is_same(pmd, NULL));
 		free_pte_range(tlb, pmd, addr);
 	} while (pmd++, addr = next, addr != end);
 
@@ -1006,7 +1009,12 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	 * in the parent and the child
 	 */
 	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
-		ptep_set_wrprotect(src_mm, addr, src_pte);
+		/*
+		 * If parent's PTE table is COWing, keep it as it is.
+		 * Don't set wrprotect to that table.
+		 */
+		if (!__is_pte_table_cowing(src_vma, NULL, addr))
+			ptep_set_wrprotect(src_mm, addr, src_pte);
 		pte = pte_wrprotect(pte);
 	}
 	VM_BUG_ON(page && PageAnon(page) && PageAnonExclusive(page));
@@ -1197,11 +1205,64 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 				continue;
 			/* fall through */
 		}
-		if (pmd_none_or_clear_bad(src_pmd))
-			continue;
-		if (copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd,
-				   addr, next))
-			return -ENOMEM;
+
+		if (is_cow_pte_available(src_vma, src_pmd)) {
+			/*
+			 * Setting wrprotect to pmd entry will trigger
+			 * pmd_bad() for normal PTE table. Skip the bad
+			 * checking here.
+			 */
+			if (pmd_none(*src_pmd))
+				continue;
+
+			/* Skip if the PTE already COW this time. */
+			if (!pmd_none(*dst_pmd) && !pmd_write(*dst_pmd))
+				continue;
+
+			/*
+			 * If PTE doesn't have an owner, the parent needs to
+			 * take this PTE.
+			 */
+			if (cow_pte_owner_is_same(src_pmd, NULL)) {
+				set_cow_pte_owner(src_pmd, src_pmd);
+				/*
+				 * XXX: The process may COW PTE fork two times.
+				 * But in some situations, owner has cleared.
+				 * Previously Child (This time is the parent)
+				 * COW PTE forking, but previously parent, the
+				 * owner , break COW. So it needs to add back
+				 * the RSS state and pgtable bytes.
+				 */
+				if (!pmd_write(*src_pmd)) {
+					cow_pte_rss(src_mm, src_vma, src_pmd,
+						    get_pmd_start_edge(src_vma,
+									addr),
+						    get_pmd_end_edge(src_vma,
+									addr),
+						    true /* inc */);
+					/* Do we need pt lock here? */
+					mm_inc_nr_ptes(src_mm);
+					/* See the comments in pmd_install(). */
+					smp_wmb();
+					pmd_populate(src_mm, src_pmd,
+						     pmd_page(*src_pmd));
+				}
+			}
+
+			pmdp_set_wrprotect(src_mm, addr, src_pmd);
+
+			/* Child reference count */
+			pmd_get_pte(src_pmd);
+
+			/* COW for PTE table */
+			set_pmd_at(dst_mm, addr, dst_pmd, *src_pmd);
+		} else {
+			if (pmd_none_or_clear_bad(src_pmd))
+				continue;
+			if (copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd,
+					   addr, next))
+				return -ENOMEM;
+		}
 	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
 	return 0;
 }
@@ -1594,6 +1655,10 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 			spin_unlock(ptl);
 		}
 
+		/* TODO: Does TLB needs to flush page info in COWed table? */
+		if (is_pte_table_cowing(vma, pmd))
+			handle_cow_pte(vma, pmd, addr, false);
+
 		/*
 		 * Here there can be other concurrent MADV_DONTNEED or
 		 * trans huge page faults running, and if the pmd is
@@ -5321,6 +5386,16 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 				return 0;
 			}
 		}
+
+		/*
+		 * When the PMD entry is set with write protection, it needs to
+		 * handle the on-demand PTE. It will allocate a new PTE and copy
+		 * the old one, then set this entry writeable and decrease the
+		 * reference count at COW PTE.
+		 */
+		if (handle_cow_pte(vmf.vma, vmf.pmd, vmf.real_address,
+				   cow_pte_count(&vmf.orig_pmd) > 1) < 0)
+			return VM_FAULT_OOM;
 	}
 
 	return handle_pte_fault(&vmf);
diff --git a/mm/mmap.c b/mm/mmap.c
index 9d780f415be3c..463359292f8a9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2685,6 +2685,9 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 			return err;
 	}
 
+	if (handle_cow_pte(vma, NULL, addr, true) < 0)
+		return -ENOMEM;
+
 	new = vm_area_dup(vma);
 	if (!new)
 		return -ENOMEM;
diff --git a/mm/mremap.c b/mm/mremap.c
index b522cd0259a0f..14f6ad250289c 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -532,6 +532,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
 		if (!old_pmd)
 			continue;
+
+		handle_cow_pte(vma, old_pmd, old_addr, true);
+
 		new_pmd = alloc_new_pmd(vma->vm_mm, vma, new_addr);
 		if (!new_pmd)
 			break;
-- 
2.37.3

