Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3101A6EFE2F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242743AbjD0AKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242704AbjD0AKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EEA3C0C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:01 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGxES2025338;
        Thu, 27 Apr 2023 00:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=qCn/KjOTilZ1uLUD9nUQPCZhyulY7CLY6Ex38w3zacI=;
 b=Bm/jAfF05hZ41Po/Sldj/OVZEgh4vornvAX3ywU3g0/yLbdoYbJMFOMTp7C5akCX3fcZ
 +pInqqlhBeWA1j5TPNcZ+6iEF6gS/F5sq1lf/buPv1WXX5wsj5gKfhyz8y8F710gFQvy
 q3dmGfVJQxHlYBNf/drz3+bPaSYVMM92CKhQlUQu4PKBx+edhfUxVnE93LXz0l2c3jod
 c0Yhtsq4U5CR9dYfi1acKahr/PyUR0HznCt6VPM22Bm0p28plaj/4tvVXewIDniGtxfB
 U6VxuygBOvSiOhVsBYRZQ4FOX7K5ngh3ZyBqGktoa1h2pAyzX/SDB/RijrDDl5gqc2tg Fw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46622ty5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QNUjaf007380;
        Thu, 27 Apr 2023 00:09:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:21 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938i013888;
        Thu, 27 Apr 2023 00:09:20 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-12;
        Thu, 27 Apr 2023 00:09:20 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 11/21] mm: PKRAM: reserve preserved memory at boot
Date:   Wed, 26 Apr 2023 17:08:47 -0700
Message-Id: <1682554137-13938-12-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: ePrmjbJOEXsn1MF-WbF_e2bo2djCeESw
X-Proofpoint-GUID: ePrmjbJOEXsn1MF-WbF_e2bo2djCeESw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep preserved pages from being recycled during boot by adding them
to the memblock reserved list during early boot. If memory reservation
fails (e.g. a region has already been reserved), all preserved pages
are dropped.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/kernel/setup.c |  3 ++
 arch/x86/mm/init_64.c   |  2 ++
 include/linux/pkram.h   |  8 +++++
 mm/pkram.c              | 84 ++++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 16babff771bd..2806b21236d0 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -18,6 +18,7 @@
 #include <linux/memblock.h>
 #include <linux/panic_notifier.h>
 #include <linux/pci.h>
+#include <linux/pkram.h>
 #include <linux/root_dev.h>
 #include <linux/hugetlb.h>
 #include <linux/tboot.h>
@@ -1221,6 +1222,8 @@ void __init setup_arch(char **cmdline_p)
 	initmem_init();
 	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
 
+	pkram_reserve();
+
 	if (boot_cpu_has(X86_FEATURE_GBPAGES))
 		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a190aae8ceaf..a46ffb434f39 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -34,6 +34,7 @@
 #include <linux/gfp.h>
 #include <linux/kcore.h>
 #include <linux/bootmem_info.h>
+#include <linux/pkram.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
@@ -1339,6 +1340,7 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
+	totalram_pages_add(pkram_reserved_pages);
 	/*
 	 * Must be done after boot memory is put on freelist, because here we
 	 * might set fields in deferred struct pages that have not yet been
diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index b614e9059bba..53d5a1ec42ff 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -99,4 +99,12 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 ssize_t pkram_write(struct pkram_access *pa, const void *buf, size_t count);
 size_t pkram_read(struct pkram_access *pa, void *buf, size_t count);
 
+#ifdef CONFIG_PKRAM
+extern unsigned long pkram_reserved_pages;
+void pkram_reserve(void);
+#else
+#define pkram_reserved_pages 0UL
+static inline void pkram_reserve(void) { }
+#endif
+
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index c649504fa1fa..b711f94dbef4 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -134,6 +134,8 @@ extern void pkram_find_preserved(unsigned long start, unsigned long end, void *p
 static LIST_HEAD(pkram_nodes);			/* linked through page::lru */
 static DEFINE_MUTEX(pkram_mutex);		/* serializes open/close */
 
+unsigned long __initdata pkram_reserved_pages;
+
 /*
  * The PKRAM super block pfn, see above.
  */
@@ -143,6 +145,59 @@ static int __init parse_pkram_sb_pfn(char *arg)
 }
 early_param("pkram", parse_pkram_sb_pfn);
 
+static void * __init pkram_map_meta(unsigned long pfn)
+{
+	if (pfn >= max_low_pfn)
+		return ERR_PTR(-EINVAL);
+	return pfn_to_kaddr(pfn);
+}
+
+int pkram_merge_with_reserved(void);
+/*
+ * Reserve pages that belong to preserved memory.
+ *
+ * This function should be called at boot time as early as possible to prevent
+ * preserved memory from being recycled.
+ */
+void __init pkram_reserve(void)
+{
+	int err = 0;
+
+	if (!pkram_sb_pfn)
+		return;
+
+	pr_info("PKRAM: Examining preserved memory...\n");
+
+	/* Verify that nothing else has reserved the pkram_sb page */
+	if (memblock_is_region_reserved(PFN_PHYS(pkram_sb_pfn), PAGE_SIZE)) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	pkram_sb = pkram_map_meta(pkram_sb_pfn);
+	if (IS_ERR(pkram_sb)) {
+		err = PTR_ERR(pkram_sb);
+		goto out;
+	}
+	/* An empty pkram_sb is not an error */
+	if (!pkram_sb->node_pfn) {
+		pkram_sb = NULL;
+		goto done;
+	}
+
+	err = pkram_merge_with_reserved();
+out:
+	if (err) {
+		pr_err("PKRAM: Reservation failed: %d\n", err);
+		WARN_ON(pkram_reserved_pages > 0);
+		pkram_sb = NULL;
+		return;
+	}
+
+done:
+	pr_info("PKRAM: %lu pages reserved\n", pkram_reserved_pages);
+}
+
 static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
 {
 	struct page *page;
@@ -162,6 +217,7 @@ static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
 
 static inline void pkram_free_page(void *addr)
 {
+	__ClearPageReserved(virt_to_page(addr));
 	pkram_remove_identity_map(virt_to_page(addr));
 	free_page((unsigned long)addr);
 }
@@ -193,13 +249,23 @@ static void pkram_truncate_link(struct pkram_link *link)
 {
 	struct page *page;
 	pkram_entry_t p;
-	int i;
+	int i, j, order;
 
 	for (i = 0; i < PKRAM_LINK_ENTRIES_MAX; i++) {
 		p = link->entry[i];
 		if (!p)
 			continue;
+		order = p & PKRAM_ENTRY_ORDER_MASK;
+		if (order >= MAX_ORDER) {
+			pr_err("PKRAM: attempted truncate of invalid page\n");
+			return;
+		}
 		page = pfn_to_page(PHYS_PFN(p));
+		for (j = 0; j < (1 << order); j++) {
+			struct page *pg = page + j;
+
+			__ClearPageReserved(pg);
+		}
 		pkram_remove_identity_map(page);
 		put_page(page);
 	}
@@ -680,7 +746,7 @@ static int __pkram_bytes_save_page(struct pkram_access *pa, struct page *page)
 static struct page *__pkram_prep_load_page(pkram_entry_t p)
 {
 	struct page *page;
-	int order;
+	int i, order;
 	short flags;
 
 	flags = (p >> PKRAM_ENTRY_FLAGS_SHIFT) & PKRAM_ENTRY_FLAGS_MASK;
@@ -690,9 +756,16 @@ static struct page *__pkram_prep_load_page(pkram_entry_t p)
 
 	page = pfn_to_page(PHYS_PFN(p));
 
-	if (!page_ref_freeze(pg, 1)) {
-		pr_err("PKRAM preserved page has unexpected inflated ref count\n");
-		goto out_error;
+	for (i = 0; i < (1 << order); i++) {
+		struct page *pg = page + i;
+		int was_rsvd;
+
+		was_rsvd = PageReserved(pg);
+		__ClearPageReserved(pg);
+		if ((was_rsvd || i == 0) && !page_ref_freeze(pg, 1)) {
+			pr_err("PKRAM preserved page has unexpected inflated ref count\n");
+			goto out_error;
+		}
 	}
 
 	if (order) {
@@ -1331,6 +1404,7 @@ int __init pkram_create_merged_reserved(struct memblock_type *new)
 	}
 
 	WARN_ON(cnt_a + cnt_b != k);
+	pkram_reserved_pages = nr_preserved;
 	new->cnt = cnt_a + cnt_b;
 	new->total_size = total_size;
 
-- 
1.9.4

