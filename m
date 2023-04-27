Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451646EFE3F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbjD0ALM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242787AbjD0AKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA93AB0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGwraY017018;
        Thu, 27 Apr 2023 00:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=TFcTuHsIv/plzZmdlp1y8kigeEeyXo4KMEAxl9EnHkE=;
 b=Zggh1E8czE4x4ifpjvsDspPPPFrTZtGY0vjQy73xEQSQJCKBnE4cJTj4k5BJ5EXzz1Su
 KsiwjlUDFJNM0uU2OJB/zM5Bm9iqCJeuDWrpQ/MKoHxEXp0zMW1mIqKa3m5N4CQormOS
 z7FEU3qe7EeyswcxhsWF8wXz9MgbSVFiSArjA8dRyMlNb/JnPJC7N6VrgImA1wYTkyxp
 ctCaI/TG+W5xh1cBKNImbW8wT7qmLf4zR/nm8RB1KqjFdQRqFLyQoSuKmPAtJLhdvsAQ
 FQE42ee6cVT5V1dU/kk3KMCHIgvH2DN3bPq0HhRluiybIMW2fDFh36w+3T5LamXb1skG hA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q476u2ng3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QLgiYb007654;
        Thu, 27 Apr 2023 00:09:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938e013888;
        Thu, 27 Apr 2023 00:09:17 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-10;
        Thu, 27 Apr 2023 00:09:17 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 09/21] PKRAM: pass a list of preserved ranges to the next kernel
Date:   Wed, 26 Apr 2023 17:08:45 -0700
Message-Id: <1682554137-13938-10-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-GUID: xTHpC9CzAHAd5dZprMjOHVznQrKD_GfJ
X-Proofpoint-ORIG-GUID: xTHpC9CzAHAd5dZprMjOHVznQrKD_GfJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to build a new memblock reserved list during boot that
includes ranges preserved by the previous kernel, a list of preserved
ranges is passed to the next kernel via the pkram superblock. The
ranges are stored in ascending order in a linked list of pages. A more
complete memblock list is not prepared to avoid possible conflicts with
changes in a newer kernel and to avoid having to allocate a contiguous
range larger than a page.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 184 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 177 insertions(+), 7 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index e6c0f3c52465..3790e5180feb 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -84,6 +84,20 @@ struct pkram_node {
 #define PKRAM_LOAD		2
 #define PKRAM_ACCMODE_MASK	3
 
+struct pkram_region {
+	phys_addr_t base;
+	phys_addr_t size;
+};
+
+struct pkram_region_list {
+	__u64	prev_pfn;
+	__u64	next_pfn;
+
+	struct pkram_region regions[0];
+};
+
+#define PKRAM_REGIONS_LIST_MAX \
+	((PAGE_SIZE-sizeof(struct pkram_region_list))/sizeof(struct pkram_region))
 /*
  * The PKRAM super block contains data needed to restore the preserved memory
  * structure on boot. The pointer to it (pfn) should be passed via the 'pkram'
@@ -96,13 +110,21 @@ struct pkram_node {
  */
 struct pkram_super_block {
 	__u64	node_pfn;		/* first element of the node list */
+	__u64	region_list_pfn;
+	__u64	nr_regions;
 };
 
+static struct pkram_region_list *pkram_regions_list;
+static int pkram_init_regions_list(void);
+static unsigned long pkram_populate_regions_list(void);
+
 static unsigned long pkram_sb_pfn __initdata;
 static struct pkram_super_block *pkram_sb;
 
 extern int pkram_add_identity_map(struct page *page);
 extern void pkram_remove_identity_map(struct page *page);
+extern void pkram_find_preserved(unsigned long start, unsigned long end, void *private,
+			int (*callback)(unsigned long base, unsigned long size, void *private));
 
 /*
  * For convenience sake PKRAM nodes are kept in an auxiliary doubly-linked list
@@ -878,21 +900,48 @@ static void __pkram_reboot(void)
 	struct page *page;
 	struct pkram_node *node;
 	unsigned long node_pfn = 0;
+	unsigned long rl_pfn = 0;
+	unsigned long nr_regions = 0;
+	int err = 0;
 
-	list_for_each_entry_reverse(page, &pkram_nodes, lru) {
-		node = page_address(page);
-		if (WARN_ON(node->flags & PKRAM_ACCMODE_MASK))
-			continue;
-		node->node_pfn = node_pfn;
-		node_pfn = page_to_pfn(page);
+	if (!list_empty(&pkram_nodes)) {
+		err = pkram_add_identity_map(virt_to_page(pkram_sb));
+		if (err) {
+			pr_err("PKRAM: failed to add super block to pagetable\n");
+			goto done;
+		}
+		list_for_each_entry_reverse(page, &pkram_nodes, lru) {
+			node = page_address(page);
+			if (WARN_ON(node->flags & PKRAM_ACCMODE_MASK))
+				continue;
+			node->node_pfn = node_pfn;
+			node_pfn = page_to_pfn(page);
+		}
+		err = pkram_init_regions_list();
+		if (err) {
+			pr_err("PKRAM: failed to init regions list\n");
+			goto done;
+		}
+		nr_regions = pkram_populate_regions_list();
+		if (IS_ERR_VALUE(nr_regions)) {
+			err = nr_regions;
+			pr_err("PKRAM: failed to populate regions list\n");
+			goto done;
+		}
+		rl_pfn = page_to_pfn(virt_to_page(pkram_regions_list));
 	}
 
+done:
 	/*
 	 * Zero out pkram_sb completely since it may have been passed from
 	 * the previous boot.
 	 */
 	memset(pkram_sb, 0, PAGE_SIZE);
-	pkram_sb->node_pfn = node_pfn;
+	if (!err && node_pfn) {
+		pkram_sb->node_pfn = node_pfn;
+		pkram_sb->region_list_pfn = rl_pfn;
+		pkram_sb->nr_regions = nr_regions;
+	}
 }
 
 static int pkram_reboot(struct notifier_block *notifier,
@@ -968,3 +1017,124 @@ static int __init pkram_init(void)
 	return 0;
 }
 module_init(pkram_init);
+
+static int count_region_cb(unsigned long base, unsigned long size, void *private)
+{
+	unsigned long *nr_regions = (unsigned long *)private;
+
+	(*nr_regions)++;
+	return 0;
+}
+
+static unsigned long pkram_count_regions(void)
+{
+	unsigned long nr_regions = 0;
+
+	pkram_find_preserved(0, PHYS_ADDR_MAX, &nr_regions, count_region_cb);
+
+	return nr_regions;
+}
+
+/*
+ * To faciliate rapidly building a new memblock reserved list during boot
+ * with the addition of preserved memory ranges a regions list is built
+ * before reboot.
+ * The regions list is a linked list of pages with each page containing an
+ * array of preserved memory ranges.  The ranges are stored in each page
+ * and across the list in address order.  A linked list is used rather than
+ * a single contiguous range to mitigate against the possibility that a
+ * larger, contiguous allocation may fail due to fragmentation.
+ *
+ * Since the pages of the regions list must be preserved and the pkram
+ * pagetable is used to determine what ranges are preserved, the list pages
+ * must be allocated and represented in the pkram pagetable before they can
+ * be populated.  Rather than recounting the number of regions after
+ * allocating pages and repeating until a precise number of pages are
+ * allocated, the number of pages needed is estimated.
+ */
+static int pkram_init_regions_list(void)
+{
+	struct pkram_region_list *rl;
+	unsigned long nr_regions;
+	unsigned long nr_lpages;
+	struct page *page;
+
+	nr_regions = pkram_count_regions();
+
+	nr_lpages = DIV_ROUND_UP(nr_regions, PKRAM_REGIONS_LIST_MAX);
+	nr_regions += nr_lpages;
+	nr_lpages = DIV_ROUND_UP(nr_regions, PKRAM_REGIONS_LIST_MAX);
+
+	for (; nr_lpages; nr_lpages--) {
+		page = pkram_alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page)
+			return -ENOMEM;
+		rl = page_address(page);
+		if (pkram_regions_list) {
+			rl->next_pfn = page_to_pfn(virt_to_page(pkram_regions_list));
+			pkram_regions_list->prev_pfn = page_to_pfn(page);
+		}
+		pkram_regions_list = rl;
+	}
+
+	return 0;
+}
+
+struct pkram_regions_priv {
+	struct pkram_region_list *curr;
+	struct pkram_region_list *last;
+	unsigned long nr_regions;
+	int idx;
+};
+
+static int add_region_cb(unsigned long base, unsigned long size, void *private)
+{
+	struct pkram_regions_priv *priv;
+	struct pkram_region_list *rl;
+	int i;
+
+	priv = (struct pkram_regions_priv *)private;
+	rl = priv->curr;
+	i = priv->idx;
+
+	if (!rl) {
+		WARN_ON(1);
+		return 1;
+	}
+
+	if (!i)
+		priv->last = priv->curr;
+
+	rl->regions[i].base = base;
+	rl->regions[i].size = size;
+
+	priv->nr_regions++;
+	i++;
+	if (i == PKRAM_REGIONS_LIST_MAX) {
+		u64 next_pfn = rl->next_pfn;
+
+		if (next_pfn)
+			priv->curr = pfn_to_kaddr(next_pfn);
+		else
+			priv->curr = NULL;
+
+		i = 0;
+	}
+	priv->idx = i;
+
+	return 0;
+}
+
+static unsigned long pkram_populate_regions_list(void)
+{
+	struct pkram_regions_priv priv = { .curr = pkram_regions_list };
+
+	pkram_find_preserved(0, PHYS_ADDR_MAX, &priv, add_region_cb);
+
+	/*
+	 * Link the first node to the last populated one.
+	 */
+	pkram_regions_list->prev_pfn = page_to_pfn(virt_to_page(priv.last));
+
+	return priv.nr_regions;
+}
-- 
1.9.4

