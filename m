Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38306EFE41
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbjD0ALU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242818AbjD0AKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:10:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C674205
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:10:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGxD1d025310;
        Thu, 27 Apr 2023 00:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=M8m1jpfuKsBAiOuFoEkjKkL2mHa5vwe/lnUsSpAdeqY=;
 b=XioIQjRsKO55if7qU5pc5RmHJ7+xiiutqegxkqaBdyQfIyM/ZkyhCK464QKjJLnxrdmt
 qfFhb26IJfPS5NrhO41Fd7xLL/JUqLb2zwxT1JipnXsUch18NntSN6ysSHKmoqiuDvv8
 UTBTXwdjJbiMdb65OtwieFuuVoojyf3WE8H67z6EwxDbSnkTVFT1lOERHjEV+vVNpX61
 Ib3BI/N2BlYpkNNE/ID2hr5v1pz35CmC/13qXlClCcLN2nevgrzffP8hHOs7I0uxSz9Y
 ppfwpanX2o5Wl8U9+t5Gu1Rj0PFXIxFyaD66RUZewzyXug20mDDAkAGIr2R2GeXnwI6p RA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46622txw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QM05AR007142;
        Thu, 27 Apr 2023 00:09:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4618mpc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 00:09:10 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R0938U013888;
        Thu, 27 Apr 2023 00:09:10 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3q4618mp42-5;
        Thu, 27 Apr 2023 00:09:10 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org,
        ebiederm@xmission.com, keescook@chromium.org, graf@amazon.com,
        jason.zeng@intel.com, lei.l.li@intel.com,
        steven.sistare@oracle.com, fam.zheng@bytedance.com,
        mgalaxy@akamai.com, kexec@lists.infradead.org
Subject: [RFC v3 04/21] mm: PKRAM: implement folio stream operations
Date:   Wed, 26 Apr 2023 17:08:40 -0700
Message-Id: <1682554137-13938-5-git-send-email-anthony.yznaga@oracle.com>
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
X-Proofpoint-ORIG-GUID: 9E3o04aE9ICIsw0HPe36rS9Y7E8_BkLp
X-Proofpoint-GUID: 9E3o04aE9ICIsw0HPe36rS9Y7E8_BkLp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement pkram_save_folio() to populate a PKRAM object with in-memory
folios and pkram_load_folio() to load folios from a PKRAM object.
Saving a folio to PKRAM is accomplished by recording its pfn, order,
and mapping index and incrementing its refcount so that it will not
be freed after the last user puts it.

Originally-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h |  42 ++++++-
 mm/pkram.c            | 311 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 346 insertions(+), 7 deletions(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 83718ad0e416..130ab5c2d94a 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -8,22 +8,47 @@
 
 struct pkram_node;
 struct pkram_obj;
+struct pkram_link;
 
 /**
  * enum pkram_data_flags - definition of data types contained in a pkram obj
  * @PKRAM_DATA_none: No data types configured
+ * @PKRAM_DATA_folios: obj contains folio data
  */
 enum pkram_data_flags {
-	PKRAM_DATA_none		= 0x0,  /* No data types configured */
+	PKRAM_DATA_none		= 0x0,	/* No data types configured */
+	PKRAM_DATA_folios	= 0x1,	/* Contains folio data */
+};
+
+struct pkram_data_stream {
+	/* List of link pages to add/remove from */
+	__u64 *head_link_pfnp;
+	__u64 *tail_link_pfnp;
+
+	struct pkram_link *link;	/* current link */
+	unsigned int entry_idx;		/* next entry in link */
 };
 
 struct pkram_stream {
 	gfp_t gfp_mask;
 	struct pkram_node *node;
 	struct pkram_obj *obj;
+
+	__u64 *folios_head_link_pfnp;
+	__u64 *folios_tail_link_pfnp;
+};
+
+struct pkram_folios_access {
+	unsigned long next_index;
 };
 
-struct pkram_access;
+struct pkram_access {
+	enum pkram_data_flags dtype;
+	struct pkram_stream *ps;
+	struct pkram_data_stream pds;
+
+	struct pkram_folios_access folios;
+};
 
 #define PKRAM_NAME_MAX		256	/* including nul */
 
@@ -41,8 +66,19 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 void pkram_finish_load(struct pkram_stream *ps);
 void pkram_finish_load_obj(struct pkram_stream *ps);
 
+#define PKRAM_PDS_INIT(name, stream, type) {			\
+	.head_link_pfnp = (stream)->type##_head_link_pfnp,	\
+	.tail_link_pfnp = (stream)->type##_tail_link_pfnp,	\
+	}
+
+#define PKRAM_ACCESS_INIT(name, stream, type) {			\
+	.dtype = PKRAM_DATA_##type,				\
+	.ps = (stream),						\
+	.pds = PKRAM_PDS_INIT(name, stream, type),		\
+	}
+
 #define PKRAM_ACCESS(name, stream, type)			\
-	struct pkram_access name
+	struct pkram_access name = PKRAM_ACCESS_INIT(name, stream, type)
 
 void pkram_finish_access(struct pkram_access *pa, bool status_ok);
 
diff --git a/mm/pkram.c b/mm/pkram.c
index 6e3895cb9872..610ff7a88c98 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/err.h>
 #include <linux/gfp.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/mm.h>
@@ -10,8 +11,40 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
+#include "internal.h"
+
+
+/*
+ * Represents a reference to a data page saved to PKRAM.
+ */
+typedef __u64 pkram_entry_t;
+
+#define PKRAM_ENTRY_FLAGS_SHIFT	0x5
+#define PKRAM_ENTRY_FLAGS_MASK	0x7f
+#define PKRAM_ENTRY_ORDER_MASK	0x1f
+
+/*
+ * Keeps references to folios saved to PKRAM.
+ * The structure occupies a memory page.
+ */
+struct pkram_link {
+	__u64	link_pfn;	/* points to the next link of the object */
+	__u64	index;		/* mapping index of first pkram_entry_t */
+
+	/*
+	 * the array occupies the rest of the link page; if the link is not
+	 * full, the rest of the array must be filled with zeros
+	 */
+	pkram_entry_t entry[];
+};
+
+#define PKRAM_LINK_ENTRIES_MAX \
+	((PAGE_SIZE-sizeof(struct pkram_link))/sizeof(pkram_entry_t))
+
 struct pkram_obj {
-	__u64   obj_pfn;	/* points to the next object in the list */
+	__u64	folios_head_link_pfn;	/* the first folios link of the object */
+	__u64	folios_tail_link_pfn;	/* the last folios link of the object */
+	__u64	obj_pfn;	/* points to the next object in the list */
 };
 
 /*
@@ -19,6 +52,10 @@ struct pkram_obj {
  * independently of each other. The nodes are identified by unique name
  * strings.
  *
+ * References to folios saved to a preserved memory node are kept in a
+ * singly-linked list of PKRAM link structures (see above), the node has a
+ * pointer to the head of.
+ *
  * The structure occupies a memory page.
  */
 struct pkram_node {
@@ -68,6 +105,41 @@ static struct pkram_node *pkram_find_node(const char *name)
 	return NULL;
 }
 
+static void pkram_truncate_link(struct pkram_link *link)
+{
+	struct page *page;
+	pkram_entry_t p;
+	int i;
+
+	for (i = 0; i < PKRAM_LINK_ENTRIES_MAX; i++) {
+		p = link->entry[i];
+		if (!p)
+			continue;
+		page = pfn_to_page(PHYS_PFN(p));
+		put_page(page);
+	}
+}
+
+static void pkram_truncate_links(unsigned long link_pfn)
+{
+	struct pkram_link *link;
+
+	while (link_pfn) {
+		link = pfn_to_kaddr(link_pfn);
+		pkram_truncate_link(link);
+		link_pfn = link->link_pfn;
+		pkram_free_page(link);
+		cond_resched();
+	}
+}
+
+static void pkram_truncate_obj(struct pkram_obj *obj)
+{
+	pkram_truncate_links(obj->folios_head_link_pfn);
+	obj->folios_head_link_pfn = 0;
+	obj->folios_tail_link_pfn = 0;
+}
+
 static void pkram_truncate_node(struct pkram_node *node)
 {
 	unsigned long obj_pfn;
@@ -76,6 +148,7 @@ static void pkram_truncate_node(struct pkram_node *node)
 	obj_pfn = node->obj_pfn;
 	while (obj_pfn) {
 		obj = pfn_to_kaddr(obj_pfn);
+		pkram_truncate_obj(obj);
 		obj_pfn = obj->obj_pfn;
 		pkram_free_page(obj);
 		cond_resched();
@@ -83,6 +156,84 @@ static void pkram_truncate_node(struct pkram_node *node)
 	node->obj_pfn = 0;
 }
 
+static void pkram_add_link(struct pkram_link *link, struct pkram_data_stream *pds)
+{
+	__u64 link_pfn = page_to_pfn(virt_to_page(link));
+
+	if (!*pds->head_link_pfnp) {
+		*pds->head_link_pfnp = link_pfn;
+		*pds->tail_link_pfnp = link_pfn;
+	} else {
+		struct pkram_link *tail = pfn_to_kaddr(*pds->tail_link_pfnp);
+
+		tail->link_pfn = link_pfn;
+		*pds->tail_link_pfnp = link_pfn;
+	}
+}
+
+static struct pkram_link *pkram_remove_link(struct pkram_data_stream *pds)
+{
+	struct pkram_link *link;
+
+	if (!*pds->head_link_pfnp)
+		return NULL;
+
+	link = pfn_to_kaddr(*pds->head_link_pfnp);
+	*pds->head_link_pfnp = link->link_pfn;
+	if (!*pds->head_link_pfnp)
+		*pds->tail_link_pfnp = 0;
+	else
+		link->link_pfn = 0;
+
+	return link;
+}
+
+static struct pkram_link *pkram_new_link(struct pkram_data_stream *pds, gfp_t gfp_mask)
+{
+	struct pkram_link *link;
+	struct page *link_page;
+
+	link_page = pkram_alloc_page((gfp_mask & GFP_RECLAIM_MASK) |
+				    __GFP_ZERO);
+	if (!link_page)
+		return NULL;
+
+	link = page_address(link_page);
+	pkram_add_link(link, pds);
+	pds->link = link;
+	pds->entry_idx = 0;
+
+	return link;
+}
+
+static void pkram_add_link_entry(struct pkram_data_stream *pds, struct page *page)
+{
+	struct pkram_link *link = pds->link;
+	pkram_entry_t p;
+	short flags = 0;
+
+	p = page_to_phys(page);
+	p |= compound_order(page);
+	p |= ((flags & PKRAM_ENTRY_FLAGS_MASK) << PKRAM_ENTRY_FLAGS_SHIFT);
+	link->entry[pds->entry_idx] = p;
+	pds->entry_idx++;
+}
+
+static int pkram_next_link(struct pkram_data_stream *pds, struct pkram_link **linkp)
+{
+	struct pkram_link *link;
+
+	link = pkram_remove_link(pds);
+	if (!link)
+		return -ENODATA;
+
+	pds->link = link;
+	pds->entry_idx = 0;
+	*linkp = link;
+
+	return 0;
+}
+
 static void pkram_stream_init(struct pkram_stream *ps,
 			     struct pkram_node *node, gfp_t gfp_mask)
 {
@@ -159,6 +310,9 @@ int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
 
+	if (flags & ~PKRAM_DATA_folios)
+		return -EINVAL;
+
 	page = pkram_alloc_page(ps->gfp_mask | __GFP_ZERO);
 	if (!page)
 		return -ENOMEM;
@@ -168,6 +322,10 @@ int pkram_prepare_save_obj(struct pkram_stream *ps, enum pkram_data_flags flags)
 		obj->obj_pfn = node->obj_pfn;
 	node->obj_pfn = page_to_pfn(page);
 
+	if (flags & PKRAM_DATA_folios) {
+		ps->folios_head_link_pfnp = &obj->folios_head_link_pfn;
+		ps->folios_tail_link_pfnp = &obj->folios_tail_link_pfn;
+	}
 	ps->obj = obj;
 	return 0;
 }
@@ -274,8 +432,17 @@ int pkram_prepare_load_obj(struct pkram_stream *ps)
 		return -ENODATA;
 
 	obj = pfn_to_kaddr(node->obj_pfn);
+	if (!obj->folios_head_link_pfn) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
 	node->obj_pfn = obj->obj_pfn;
 
+	if (obj->folios_head_link_pfn) {
+		ps->folios_head_link_pfnp = &obj->folios_head_link_pfn;
+		ps->folios_tail_link_pfnp = &obj->folios_tail_link_pfn;
+	}
 	ps->obj = obj;
 	return 0;
 }
@@ -292,6 +459,7 @@ void pkram_finish_load_obj(struct pkram_stream *ps)
 
 	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
 
+	pkram_truncate_obj(obj);
 	pkram_free_page(obj);
 }
 
@@ -317,7 +485,41 @@ void pkram_finish_load(struct pkram_stream *ps)
  */
 void pkram_finish_access(struct pkram_access *pa, bool status_ok)
 {
-	WARN_ON_ONCE(1);
+	if (status_ok)
+		return;
+
+	if (pa->ps->node->flags == PKRAM_SAVE)
+		return;
+
+	if (pa->pds.link)
+		pkram_truncate_link(pa->pds.link);
+}
+
+/*
+ * Add a page to a PKRAM obj allocating a new PKRAM link if necessary.
+ */
+static int __pkram_save_page(struct pkram_access *pa, struct page *page,
+			     unsigned long index)
+{
+	struct pkram_data_stream *pds = &pa->pds;
+	struct pkram_link *link = pds->link;
+
+	if (!link || pds->entry_idx >= PKRAM_LINK_ENTRIES_MAX ||
+	    index != pa->folios.next_index) {
+		link = pkram_new_link(pds, pa->ps->gfp_mask);
+		if (!link)
+			return -ENOMEM;
+
+		pa->folios.next_index = link->index = index;
+	}
+
+	get_page(page);
+
+	pkram_add_link_entry(pds, page);
+
+	pa->folios.next_index += compound_nr(page);
+
+	return 0;
 }
 
 /**
@@ -327,10 +529,102 @@ void pkram_finish_access(struct pkram_access *pa, bool status_ok)
  * with PKRAM_ACCESS().
  *
  * Returns 0 on success, -errno on failure.
+ *
+ * Error values:
+ *	%ENOMEM: insufficient amount of memory available
+ *
+ * Saving a folio to preserved memory is simply incrementing its refcount so
+ * that it will not get freed after the last user puts it. That means it is
+ * safe to use the folio as usual after it has been saved.
  */
 int pkram_save_folio(struct pkram_access *pa, struct folio *folio)
 {
-	return -EINVAL;
+	struct pkram_node *node = pa->ps->node;
+	struct page *page = folio_page(folio, 0);
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_SAVE);
+
+	return __pkram_save_page(pa, page, page->index);
+}
+
+static struct page *__pkram_prep_load_page(pkram_entry_t p)
+{
+	struct page *page;
+	int order;
+	short flags;
+
+	flags = (p >> PKRAM_ENTRY_FLAGS_SHIFT) & PKRAM_ENTRY_FLAGS_MASK;
+	order = p & PKRAM_ENTRY_ORDER_MASK;
+	if (order >= MAX_ORDER)
+		goto out_error;
+
+	page = pfn_to_page(PHYS_PFN(p));
+
+	if (!page_ref_freeze(pg, 1)) {
+		pr_err("PKRAM preserved page has unexpected inflated ref count\n");
+		goto out_error;
+	}
+
+	if (order) {
+		prep_compound_page(page, order);
+		if (order > 1)
+			prep_transhuge_page(page);
+	}
+
+	page_ref_unfreeze(page, 1);
+
+	return page;
+
+out_error:
+	return ERR_PTR(-EINVAL);
+}
+
+/*
+ * Extract the next page from preserved memory freeing a PKRAM link if it
+ * becomes empty.
+ */
+static struct page *__pkram_load_page(struct pkram_access *pa, unsigned long *index)
+{
+	struct pkram_data_stream *pds = &pa->pds;
+	struct pkram_link *link = pds->link;
+	struct page *page;
+	pkram_entry_t p;
+	int ret;
+
+	if (!link) {
+		ret = pkram_next_link(pds, &link);
+		if (ret)
+			return NULL;
+
+		if (index)
+			pa->folios.next_index = link->index;
+	}
+
+	BUG_ON(pds->entry_idx >= PKRAM_LINK_ENTRIES_MAX);
+
+	p = link->entry[pds->entry_idx];
+	BUG_ON(!p);
+
+	page = __pkram_prep_load_page(p);
+	if (IS_ERR(page))
+		return page;
+
+	if (index) {
+		*index = pa->folios.next_index;
+		pa->folios.next_index += compound_nr(page);
+	}
+
+	/* clear to avoid double free (see pkram_truncate_link()) */
+	link->entry[pds->entry_idx] = 0;
+
+	pds->entry_idx++;
+	if (pds->entry_idx >= PKRAM_LINK_ENTRIES_MAX ||
+	    !link->entry[pds->entry_idx]) {
+		pds->link = NULL;
+		pkram_free_page(link);
+	}
+
+	return page;
 }
 
 /**
@@ -348,7 +642,16 @@ int pkram_save_folio(struct pkram_access *pa, struct folio *folio)
  */
 struct folio *pkram_load_folio(struct pkram_access *pa, unsigned long *index)
 {
-	return NULL;
+	struct pkram_node *node = pa->ps->node;
+	struct page *page;
+
+	BUG_ON((node->flags & PKRAM_ACCMODE_MASK) != PKRAM_LOAD);
+
+	page = __pkram_load_page(pa, index);
+	if (IS_ERR_OR_NULL(page))
+		return (struct folio *)page;
+	else
+		return page_folio(page);
 }
 
 /**
-- 
1.9.4

