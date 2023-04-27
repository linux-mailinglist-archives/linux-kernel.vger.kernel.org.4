Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC106EFE30
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbjD0ALR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242795AbjD0AKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF49E40EF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGx0ji015505;
        Thu, 27 Apr 2023 00:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=gsaWUneWyL6rRzD/yIHYfGhUn1k+T9X+WkpsWzv1iV8=;
 b=mDqUgTbTSU6cnPw3zIM1XyCiMw+fSQGgT3QxlLZPvuf6xhN7kjfpA5S65xHVuzL7FT1d
 MGjlWEjvHmFFK3pStMXSW4nUHTx3bOBt7b2EJakJCY7L7meqs0m0QV2Vtng255bRdgm8
 /rWYGb8HvY3c+vhBXe6XD5MEw4a0TCADR/xoqYuuf47wVDeLuXAs4nhk4CCj/AQuq3dL
 MKTx8r86M10M50OkBFdr6kXy6b6ORkvf2QOT7QqahA3CX8uDHoX4t/UG7HZ1itPxWs8D
 GTo2afqCR/a4R6vypgdRkWzRNdCnjRCdrFsN6EfXrUHHNrXiRPPYj+Hya6fk5sCqJDgZ OA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460dampm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QMDCSI007353;
        Thu, 27 Apr 2023 00:09:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:16 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938c013888;
        Thu, 27 Apr 2023 00:09:15 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-9;
        Thu, 27 Apr 2023 00:09:15 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 08/21] PKRAM: track preserved pages in a physical mapping pagetable
Date:   Wed, 26 Apr 2023 17:08:44 -0700
Message-Id: <1682554137-13938-9-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.9.4
In-Reply-To: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270000
X-Proofpoint-GUID: 6JJSP6KEDa_4tfH-GxMGt6XutfQgNfDT
X-Proofpoint-ORIG-GUID: 6JJSP6KEDa_4tfH-GxMGt6XutfQgNfDT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Later patches in this series will need a way to efficiently identify
physically contiguous ranges of preserved pages independent of their
virtual addresses. To facilitate this all pages to be preserved across
kexec are added to a pseudo identity mapping pagetable.

The pagetable makes use of the existing architecture definitions for
building a memory mapping pagetable except that a bitmap is used to
represent the presence or absence of preserved pages at the PTE level.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/Makefile          |   4 +-
 mm/pkram.c           |  30 ++++-
 mm/pkram_pagetable.c | 375 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 404 insertions(+), 5 deletions(-)
 create mode 100644 mm/pkram_pagetable.c

diff --git a/mm/Makefile b/mm/Makefile
index 7a8d5a286d48..7a1a33b67de6 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -138,5 +138,5 @@ obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
-obj-$(CONFIG_PKRAM) += pkram.o
->>>>>>> mm: add PKRAM API stubs and Kconfig
+obj-$(CONFIG_PKRAM) += pkram.o pkram_pagetable.o
+>>>>>>> PKRAM: track preserved pages in a physical mapping pagetable
diff --git a/mm/pkram.c b/mm/pkram.c
index c66b2ae4d520..e6c0f3c52465 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -101,6 +101,9 @@ struct pkram_super_block {
 static unsigned long pkram_sb_pfn __initdata;
 static struct pkram_super_block *pkram_sb;
 
+extern int pkram_add_identity_map(struct page *page);
+extern void pkram_remove_identity_map(struct page *page);
+
 /*
  * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
  * connected through the lru field of the page struct.
@@ -119,11 +122,24 @@ static int __init parse_pkram_sb_pfn(char *arg)
 
 static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
 {
-	return alloc_page(gfp_mask);
+	struct page *page;
+	int err;
+
+	page = alloc_page(gfp_mask);
+	if (page) {
+		err = pkram_add_identity_map(page);
+		if (err) {
+			__free_page(page);
+			page = NULL;
+		}
+	}
+
+	return page;
 }
 
 static inline void pkram_free_page(void *addr)
 {
+	pkram_remove_identity_map(virt_to_page(addr));
 	free_page((unsigned long)addr);
 }
 
@@ -161,6 +177,7 @@ static void pkram_truncate_link(struct pkram_link *link)
 		if (!p)
 			continue;
 		page = pfn_to_page(PHYS_PFN(p));
+		pkram_remove_identity_map(page);
 		put_page(page);
 	}
 }
@@ -610,10 +627,15 @@ int pkram_save_folio(struct pkram_access *pa, struct folio *folio)
 {
 	struct pkram_node *node = pa->ps->node;
 	struct page *page = folio_page(folio, 0);
+	int err;
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
-	return __pkram_save_page(pa, page, page->index);
+	err = __pkram_save_page(pa, page, page->index);
+	if (!err)
+		err = pkram_add_identity_map(page);
+
+	return err;
 }
 
 static int __pkram_bytes_save_page(struct pkram_access *pa, struct page *page)
@@ -658,6 +680,8 @@ static struct page *__pkram_prep_load_page(pkram_entry_t p)
 
 	page_ref_unfreeze(page, 1);
 
+	pkram_remove_identity_map(page);
+
 	return page;
 
 out_error:
@@ -914,7 +938,7 @@ static int __init pkram_init_sb(void)
 	if (!pkram_sb) {
 		struct page *page;
 
-		page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 		if (!page) {
 			pr_err("PKRAM: Failed to allocate super block\n");
 			return 0;
diff --git a/mm/pkram_pagetable.c b/mm/pkram_pagetable.c
new file mode 100644
index 000000000000..85e34301ef1e
--- /dev/null
+++ b/mm/pkram_pagetable.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bitops.h>
+#include <linux/mm.h>
+
+static pgd_t *pkram_pgd;
+static DEFINE_SPINLOCK(pkram_pgd_lock);
+
+#define set_p4d(p4dp, p4d)	WRITE_ONCE(*(p4dp), (p4d))
+
+#define PKRAM_PTE_BM_BYTES	(PTRS_PER_PTE / BITS_PER_BYTE)
+#define PKRAM_PTE_BM_MASK	(PAGE_SIZE / PKRAM_PTE_BM_BYTES - 1)
+
+static pmd_t make_bitmap_pmd(unsigned long *bitmap)
+{
+	unsigned long val;
+
+	val = __pa(ALIGN_DOWN((unsigned long)bitmap, PAGE_SIZE));
+	val |= (((unsigned long)bitmap & ~PAGE_MASK) / PKRAM_PTE_BM_BYTES);
+
+	return __pmd(val);
+}
+
+static unsigned long *get_bitmap_addr(pmd_t pmd)
+{
+	unsigned long val, off;
+
+	val = pmd_val(pmd);
+	off = (val & PKRAM_PTE_BM_MASK) * PKRAM_PTE_BM_BYTES;
+
+	val = (val & PAGE_MASK) + off;
+
+	return __va(val);
+}
+
+int pkram_add_identity_map(struct page *page)
+{
+	unsigned long paddr;
+	unsigned long *bitmap;
+	unsigned int index;
+	struct page *pg;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	if (!pkram_pgd) {
+		spin_lock(&pkram_pgd_lock);
+		if (!pkram_pgd) {
+			pg = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+			if (!pg)
+				goto nomem;
+			pkram_pgd = page_address(pg);
+		}
+		spin_unlock(&pkram_pgd_lock);
+	}
+
+	paddr = __pa(page_address(page));
+	pgd = pkram_pgd;
+	pgd += pgd_index(paddr);
+	if (pgd_none(*pgd)) {
+		spin_lock(&pkram_pgd_lock);
+		if (pgd_none(*pgd)) {
+			pg = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+			if (!pg)
+				goto nomem;
+			p4d = page_address(pg);
+			set_pgd(pgd, __pgd(__pa(p4d)));
+		}
+		spin_unlock(&pkram_pgd_lock);
+	}
+	p4d = p4d_offset(pgd, paddr);
+	if (p4d_none(*p4d)) {
+		spin_lock(&pkram_pgd_lock);
+		if (p4d_none(*p4d)) {
+			pg = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+			if (!pg)
+				goto nomem;
+			pud = page_address(pg);
+			set_p4d(p4d, __p4d(__pa(pud)));
+		}
+		spin_unlock(&pkram_pgd_lock);
+	}
+	pud = pud_offset(p4d, paddr);
+	if (pud_none(*pud)) {
+		spin_lock(&pkram_pgd_lock);
+		if (pud_none(*pud)) {
+			pg = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+			if (!pg)
+				goto nomem;
+			pmd = page_address(pg);
+			set_pud(pud, __pud(__pa(pmd)));
+		}
+		spin_unlock(&pkram_pgd_lock);
+	}
+	pmd = pmd_offset(pud, paddr);
+	if (pmd_none(*pmd)) {
+		spin_lock(&pkram_pgd_lock);
+		if (pmd_none(*pmd)) {
+			if (PageTransHuge(page)) {
+				set_pmd(pmd, pmd_mkhuge(*pmd));
+				spin_unlock(&pkram_pgd_lock);
+				goto done;
+			}
+			bitmap = bitmap_zalloc(PTRS_PER_PTE, GFP_ATOMIC);
+			if (!bitmap)
+				goto nomem;
+			set_pmd(pmd, make_bitmap_pmd(bitmap));
+		} else {
+			BUG_ON(pmd_leaf(*pmd));
+			bitmap = get_bitmap_addr(*pmd);
+		}
+		spin_unlock(&pkram_pgd_lock);
+	} else {
+		BUG_ON(pmd_leaf(*pmd));
+		bitmap = get_bitmap_addr(*pmd);
+	}
+
+	index = pte_index(paddr);
+	BUG_ON(test_bit(index, bitmap));
+	set_bit(index, bitmap);
+	smp_mb__after_atomic();
+	if (bitmap_full(bitmap, PTRS_PER_PTE))
+		set_pmd(pmd, pmd_mkhuge(*pmd));
+done:
+	return 0;
+nomem:
+	return -ENOMEM;
+}
+
+void pkram_remove_identity_map(struct page *page)
+{
+	unsigned long *bitmap;
+	unsigned long paddr;
+	unsigned int index;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	/*
+	 * pkram_pgd will be null when freeing metadata pages after a reboot
+	 */
+	if (!pkram_pgd)
+		return;
+
+	paddr = __pa(page_address(page));
+	pgd = pkram_pgd;
+	pgd += pgd_index(paddr);
+	if (pgd_none(*pgd)) {
+		WARN_ONCE(1, "PKRAM: %s: no pgd for 0x%lx\n", __func__, paddr);
+		return;
+	}
+	p4d = p4d_offset(pgd, paddr);
+	if (p4d_none(*p4d)) {
+		WARN_ONCE(1, "PKRAM: %s: no p4d for 0x%lx\n", __func__, paddr);
+		return;
+	}
+	pud = pud_offset(p4d, paddr);
+	if (pud_none(*pud)) {
+		WARN_ONCE(1, "PKRAM: %s: no pud for 0x%lx\n", __func__, paddr);
+		return;
+	}
+	pmd = pmd_offset(pud, paddr);
+	if (pmd_none(*pmd)) {
+		WARN_ONCE(1, "PKRAM: %s: no pmd for 0x%lx\n", __func__, paddr);
+		return;
+	}
+	if (PageTransHuge(page)) {
+		BUG_ON(!pmd_leaf(*pmd));
+		pmd_clear(pmd);
+		return;
+	}
+
+	if (pmd_leaf(*pmd)) {
+		spin_lock(&pkram_pgd_lock);
+		if (pmd_leaf(*pmd))
+			set_pmd(pmd, __pmd(pte_val(pte_clrhuge(*(pte_t *)pmd))));
+		spin_unlock(&pkram_pgd_lock);
+	}
+
+	bitmap = get_bitmap_addr(*pmd);
+	index = pte_index(paddr);
+	clear_bit(index, bitmap);
+	smp_mb__after_atomic();
+
+	spin_lock(&pkram_pgd_lock);
+	if (!pmd_none(*pmd) && bitmap_empty(bitmap, PTRS_PER_PTE)) {
+		pmd_clear(pmd);
+		spin_unlock(&pkram_pgd_lock);
+		bitmap_free(bitmap);
+	} else {
+		spin_unlock(&pkram_pgd_lock);
+	}
+}
+
+struct pkram_pg_state {
+	int (*range_cb)(unsigned long base, unsigned long size, void *private);
+	unsigned long start_addr;
+	unsigned long curr_addr;
+	unsigned long min_addr;
+	unsigned long max_addr;
+	void *private;
+	bool tracking;
+};
+
+#define pgd_none(a)  (pgtable_l5_enabled() ? pgd_none(a) : p4d_none(__p4d(pgd_val(a))))
+
+static int note_page(struct pkram_pg_state *st, unsigned long addr, bool present)
+{
+	if (!st->tracking && present) {
+		if (addr >= st->max_addr)
+			return 1;
+		/*
+		 * addr can be < min_addr if the page straddles the
+		 * boundary
+		 */
+		st->start_addr = max(addr, st->min_addr);
+		st->tracking = true;
+	} else if (st->tracking) {
+		unsigned long base, size;
+		int ret;
+
+		/* Continue tracking if upper bound has not been reached */
+		if (present && addr < st->max_addr)
+			return 0;
+
+		addr = min(addr, st->max_addr);
+
+		base = st->start_addr;
+		size = addr - st->start_addr;
+		st->tracking = false;
+
+		ret = st->range_cb(base, size, st->private);
+
+		if (addr == st->max_addr)
+			return 1;
+		else
+			return ret;
+	}
+
+	return 0;
+}
+
+static int walk_pte_level(struct pkram_pg_state *st, pmd_t addr, unsigned long P)
+{
+	unsigned long *bitmap;
+	int present;
+	int i, ret;
+
+	bitmap = get_bitmap_addr(addr);
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		unsigned long curr_addr = P + i * PAGE_SIZE;
+
+		if (curr_addr < st->min_addr)
+			continue;
+		present = test_bit(i, bitmap);
+		ret = note_page(st, curr_addr, present);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_pmd_level(struct pkram_pg_state *st, pud_t addr, unsigned long P)
+{
+	pmd_t *start;
+	int i, ret;
+
+	start = pud_pgtable(addr);
+	for (i = 0; i < PTRS_PER_PMD; i++, start++) {
+		unsigned long curr_addr = P + i * PMD_SIZE;
+
+		if (curr_addr + PMD_SIZE <= st->min_addr)
+			continue;
+		if (!pmd_none(*start)) {
+			if (pmd_leaf(*start))
+				ret = note_page(st, curr_addr, true);
+			else
+				ret = walk_pte_level(st, *start, curr_addr);
+		} else
+			ret = note_page(st, curr_addr, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_pud_level(struct pkram_pg_state *st, p4d_t addr, unsigned long P)
+{
+	pud_t *start;
+	int i, ret;
+
+	start = p4d_pgtable(addr);
+	for (i = 0; i < PTRS_PER_PUD; i++, start++) {
+		unsigned long curr_addr = P + i * PUD_SIZE;
+
+		if (curr_addr + PUD_SIZE <= st->min_addr)
+			continue;
+		if (!pud_none(*start)) {
+			if (pud_leaf(*start))
+				ret = note_page(st, curr_addr, true);
+			else
+				ret = walk_pmd_level(st, *start, curr_addr);
+		} else
+			ret = note_page(st, curr_addr, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int walk_p4d_level(struct pkram_pg_state *st, pgd_t addr, unsigned long P)
+{
+	p4d_t *start;
+	int i, ret;
+
+	if (PTRS_PER_P4D == 1)
+		return walk_pud_level(st, __p4d(pgd_val(addr)), P);
+
+	start = (p4d_t *)pgd_page_vaddr(addr);
+	for (i = 0; i < PTRS_PER_P4D; i++, start++) {
+		unsigned long curr_addr = P + i * P4D_SIZE;
+
+		if (curr_addr + P4D_SIZE <= st->min_addr)
+			continue;
+		if (!p4d_none(*start)) {
+			if (p4d_leaf(*start))
+				ret = note_page(st, curr_addr, true);
+			else
+				ret = walk_pud_level(st, *start, curr_addr);
+		} else
+			ret = note_page(st, curr_addr, false);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+void pkram_walk_pgt(struct pkram_pg_state *st, pgd_t *pgd)
+{
+	pgd_t *start = pgd;
+	int i, ret = 0;
+
+	for (i = 0; i < PTRS_PER_PGD; i++, start++) {
+		unsigned long curr_addr = i * PGDIR_SIZE;
+
+		if (curr_addr + PGDIR_SIZE <= st->min_addr)
+			continue;
+		if (!pgd_none(*start))
+			ret = walk_p4d_level(st, *start, curr_addr);
+		else
+			ret = note_page(st, curr_addr, false);
+		if (ret)
+			break;
+	}
+}
+
+void pkram_find_preserved(unsigned long start, unsigned long end, void *private, int (*callback)(unsigned long base, unsigned long size, void *private))
+{
+	struct pkram_pg_state st = {
+		.range_cb = callback,
+		.min_addr = start,
+		.max_addr = end,
+		.private = private,
+	};
+
+	if (!pkram_pgd)
+		return;
+
+	pkram_walk_pgt(&st, pkram_pgd);
+}
-- 
1.9.4

