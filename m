Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20186EFE3A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242878AbjD0AK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbjD0AKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E8E40C8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGxDTg025309;
        Thu, 27 Apr 2023 00:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=ltRUZX+kav0KgoOWwJByY5TJz/DW4UwuIA/fz1dRFQU=;
 b=xpVH9EsAYlNzHPNKr28M6uYk8hxosg9wy9QOXmzA9yN+HMuUoZfcrajvTUUr1lkOvLaX
 RM5c5MqPJv+zMSxVMYAjYSzVMxH6Rel4z1jaQnAe6791QBOa/kQboYsFtWjcxY5DF1+a
 bZzZXeUrWtDQzeHd6c+9eLsg7Xag/Vq9S/PA337P3zPlOG8CX9SArYqtBICe5MEdhCkn
 2o/qGCjzmDk6N7GnF5wgATLTEi4/nVQSw6G+sUQlDmkGujq7HBYq5x1/ZTnpjCqDlMh3
 qdorPMujYiR67P6HuxfFSjflchL9Svsbzw9GxTe6B8GKNUwz6HdzD7R0TQBFPcB+c7NM qQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46622ty7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QNIv5m007334;
        Thu, 27 Apr 2023 00:09:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mppp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:25 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938o013888;
        Thu, 27 Apr 2023 00:09:24 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-15;
        Thu, 27 Apr 2023 00:09:24 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 14/21] PKRAM: provide a way to ban pages from use by PKRAM
Date:   Wed, 26 Apr 2023 17:08:50 -0700
Message-Id: <1682554137-13938-15-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: BQQ0fjLL1Sgk_Nth9r2mdIqR3T5y8aHc
X-Proofpoint-GUID: BQQ0fjLL1Sgk_Nth9r2mdIqR3T5y8aHc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all memory ranges can be used for saving preserved over-kexec data.
For example, a kexec kernel may be loaded before pages are preserved.
The memory regions where the kexec segments will be copied to on kexec
must not contain preserved pages or else they will be clobbered.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |   2 +
 mm/pkram.c            | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index c909aa299fc4..29109e875604 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -103,10 +103,12 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 extern unsigned long pkram_reserved_pages;
 void pkram_reserve(void);
 void pkram_cleanup(void);
+void pkram_ban_region(unsigned long start, unsigned long end);
 #else
 #define pkram_reserved_pages 0UL
 static inline void pkram_reserve(void) { }
 static inline void pkram_cleanup(void) { }
+static inline void pkram_ban_region(unsigned long start, unsigned long end) { }
 #endif
 
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index befdffc76940..cef75bd8ba99 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -140,6 +140,28 @@ extern void pkram_find_preserved(unsigned long start, unsigned long end, void *p
 unsigned long __initdata pkram_reserved_pages;
 
 /*
+ * For tracking a region of memory that PKRAM is not allowed to use.
+ */
+struct banned_region {
+	unsigned long start, end;		/* pfn, inclusive */
+};
+
+#define MAX_NR_BANNED		(32 + MAX_NUMNODES * 2)
+
+static unsigned int nr_banned;			/* number of banned regions */
+
+/* banned regions; arranged in ascending order, do not overlap */
+static struct banned_region banned[MAX_NR_BANNED];
+/*
+ * If a page allocated for PKRAM turns out to belong to a banned region,
+ * it is placed on the banned_pages list so subsequent allocation attempts
+ * do not encounter it again. The list is shrunk when system memory is low.
+ */
+static LIST_HEAD(banned_pages);			/* linked through page::lru */
+static DEFINE_SPINLOCK(banned_pages_lock);
+static unsigned long nr_banned_pages;
+
+/*
  * The PKRAM super block pfn, see above.
  */
 static int __init parse_pkram_sb_pfn(char *arg)
@@ -206,12 +228,116 @@ void __init pkram_reserve(void)
 	pr_info("PKRAM: %lu pages reserved\n", pkram_reserved_pages);
 }
 
+/*
+ * Ban pfn range [start..end] (inclusive) from use in PKRAM.
+ */
+void pkram_ban_region(unsigned long start, unsigned long end)
+{
+	int i, merged = -1;
+
+	/* first try to merge the region with an existing one */
+	for (i = nr_banned - 1; i >= 0 && start <= banned[i].end + 1; i--) {
+		if (end + 1 >= banned[i].start) {
+			start = min(banned[i].start, start);
+			end = max(banned[i].end, end);
+			if (merged < 0)
+				merged = i;
+		} else
+			/*
+			 * Regions are arranged in ascending order and do not
+			 * intersect so the merged region cannot jump over its
+			 * predecessors.
+			 */
+			BUG_ON(merged >= 0);
+	}
+
+	i++;
+
+	if (merged >= 0) {
+		banned[i].start = start;
+		banned[i].end = end;
+		/* shift if merged with more than one region */
+		memmove(banned + i + 1, banned + merged + 1,
+			sizeof(*banned) * (nr_banned - merged - 1));
+		nr_banned -= merged - i;
+		return;
+	}
+
+	/*
+	 * The region does not intersect with an existing one;
+	 * try to create a new one.
+	 */
+	if (nr_banned == MAX_NR_BANNED) {
+		pr_err("PKRAM: Failed to ban %lu-%lu: Too many banned regions\n",
+			start, end);
+		return;
+	}
+
+	memmove(banned + i + 1, banned + i,
+		sizeof(*banned) * (nr_banned - i));
+	banned[i].start = start;
+	banned[i].end = end;
+	nr_banned++;
+}
+
+static void pkram_show_banned(void)
+{
+	int i;
+	unsigned long n, total = 0;
+
+	pr_info("PKRAM: banned regions:\n");
+	for (i = 0; i < nr_banned; i++) {
+		n = banned[i].end - banned[i].start + 1;
+		pr_info("%4d: [%08lx - %08lx] %ld pages\n",
+			i, banned[i].start, banned[i].end, n);
+		total += n;
+	}
+	pr_info("Total banned: %ld pages in %d regions\n",
+		total, nr_banned);
+}
+
+/*
+ * Returns true if the page may not be used for storing preserved data.
+ */
+static bool pkram_page_banned(struct page *page)
+{
+	unsigned long epfn, pfn = page_to_pfn(page);
+	int l = 0, r = nr_banned - 1, m;
+
+	epfn = pfn + compound_nr(page) - 1;
+
+	/* do binary search */
+	while (l <= r) {
+		m = (l + r) / 2;
+		if (epfn < banned[m].start)
+			r = m - 1;
+		else if (pfn > banned[m].end)
+			l = m + 1;
+		else
+			return true;
+	}
+	return false;
+}
+
 static inline struct page *pkram_alloc_page(gfp_t gfp_mask)
 {
 	struct page *page;
+	LIST_HEAD(list);
+	unsigned long len = 0;
 	int err;
 
 	page = alloc_page(gfp_mask);
+	while (page && pkram_page_banned(page)) {
+		len++;
+		list_add(&page->lru, &list);
+		page = alloc_page(gfp_mask);
+	}
+	if (len > 0) {
+		spin_lock(&banned_pages_lock);
+		nr_banned_pages += len;
+		list_splice(&list, &banned_pages);
+		spin_unlock(&banned_pages_lock);
+	}
 	if (page) {
 		err = pkram_add_identity_map(page);
 		if (err) {
@@ -230,6 +356,53 @@ static inline void pkram_free_page(void *addr)
 	free_page((unsigned long)addr);
 }
 
+static void __banned_pages_shrink(unsigned long nr_to_scan)
+{
+	struct page *page;
+
+	if (nr_to_scan <= 0)
+		return;
+
+	while (nr_banned_pages > 0) {
+		BUG_ON(list_empty(&banned_pages));
+		page = list_first_entry(&banned_pages, struct page, lru);
+		list_del(&page->lru);
+		__free_page(page);
+		nr_banned_pages--;
+		nr_to_scan--;
+		if (!nr_to_scan)
+			break;
+	}
+}
+
+static unsigned long
+banned_pages_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	return nr_banned_pages;
+}
+
+static unsigned long
+banned_pages_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int nr_left = nr_banned_pages;
+
+	if (!sc->nr_to_scan || !nr_left)
+		return nr_left;
+
+	spin_lock(&banned_pages_lock);
+	__banned_pages_shrink(sc->nr_to_scan);
+	nr_left = nr_banned_pages;
+	spin_unlock(&banned_pages_lock);
+
+	return nr_left;
+}
+
+static struct shrinker banned_pages_shrinker = {
+	.count_objects = banned_pages_count,
+	.scan_objects = banned_pages_scan,
+	.seeks = DEFAULT_SEEKS,
+};
+
 static inline void pkram_insert_node(struct pkram_node *node)
 {
 	list_add(&virt_to_page(node)->lru, &pkram_nodes);
@@ -705,6 +878,31 @@ static int __pkram_save_page(struct pkram_access *pa, struct page *page,
 	return 0;
 }
 
+static int __pkram_save_page_copy(struct pkram_access *pa, struct page *page)
+{
+	int nr_pages = compound_nr(page);
+	pgoff_t index = page->index;
+	int i, err;
+
+	for (i = 0; i < nr_pages; i++, index++) {
+		struct page *p = page + i;
+		struct page *new;
+
+		new = pkram_alloc_page(pa->ps->gfp_mask);
+		if (!new)
+			return -ENOMEM;
+
+		copy_highpage(new, p);
+		err = __pkram_save_page(pa, new, index);
+		if (err) {
+			pkram_free_page(page_address(new));
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * Save folio @folio to the preserved memory node and object associated
  * with pkram stream access @pa. The stream must have been initialized with
@@ -728,6 +926,10 @@ int pkram_save_folio(struct pkram_access *pa, struct folio *folio)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
+	/* if page is banned, relocate it */
+	if (pkram_page_banned(page))
+		return __pkram_save_page_copy(pa, page);
+
 	err = __pkram_save_page(pa, page, page->index);
 	if (!err)
 		err = pkram_add_identity_map(page);
@@ -987,6 +1189,7 @@ static void __pkram_reboot(void)
 	int err = 0;
 
 	if (!list_empty(&pkram_nodes)) {
+		pkram_show_banned();
 		err = pkram_add_identity_map(virt_to_page(pkram_sb));
 		if (err) {
 			pr_err("PKRAM: failed to add super block to pagetable\n");
@@ -1073,6 +1276,7 @@ static int __init pkram_init_sb(void)
 		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 		if (!page) {
 			pr_err("PKRAM: Failed to allocate super block\n");
+			__banned_pages_shrink(ULONG_MAX);
 			return 0;
 		}
 		pkram_sb = page_address(page);
@@ -1095,6 +1299,7 @@ static int __init pkram_init(void)
 {
 	if (pkram_init_sb()) {
 		register_reboot_notifier(&pkram_reboot_notifier);
+		register_shrinker(&banned_pages_shrinker, "pkram");
 		sysfs_update_group(kernel_kobj, &pkram_attr_group);
 	}
 	return 0;
-- 
1.9.4

