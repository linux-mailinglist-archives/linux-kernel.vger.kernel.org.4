Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1867B65C75D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbjACTUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238710AbjACTTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:19:02 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681A31403E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:16:26 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303IGIJt001055
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jan 2023 11:16:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=A5mQJgLgeuVaRaprTixgL92AGRDAjggd9fT1lVRLHz4=;
 b=ZAg9gUuSEX2QQtcM3LiP4SXxhGtvrZiGYoyHxev1/qfFVm2MptiZyV54kzBWS7Tf1u0g
 6qE+Fgw6tK9ojojlzslm2a2ZtHj/jD0bluf7W/0OUTXCB1Jv/wjiimC2yWYzBHF31YDw
 EaWFTcPUxYW1nwjG1Pbd5ZkHTltz9YTwEd1CRJkJtI62k96prQVCekSVKuWIwGFWQRTH
 5WEhDQZQkKzwb2cVkUwWejZmNPxNRNg7axSTV8/WC3dqx6f0bpd0+/pVbXsZVOV9bmuI
 286i0Dr6G6EWsWLbE28uoT9ymKO8EpPI1VuQNcqlX2Lc3rX998hOnJj46qPfSjdD9akh yg== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mtkt0sxf9-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:16:25 -0800
Received: from twshared7043.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 3 Jan 2023 11:16:22 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 5F13FE1F5E1E; Tue,  3 Jan 2023 11:15:55 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 11/12] dmapool: link blocks across pages
Date:   Tue, 3 Jan 2023 11:15:50 -0800
Message-ID: <20230103191551.3254778-12-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230103191551.3254778-1-kbusch@meta.com>
References: <20230103191551.3254778-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cIkyoqP_XWyomJsACNT7rXXZcCzIAkqA
X-Proofpoint-GUID: cIkyoqP_XWyomJsACNT7rXXZcCzIAkqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The allocated dmapool pages are never freed for the lifetime of the
pool. There is no need for the two level list+stack lookup for finding a
free block since nothing is ever removed from the list. Just use a
simple stack, reducing time complexity to constant.

The implementation inserts the stack linking elements and the dma handle
of the block within itself when freed. This means the smallest possible
dmapool block is increased to at most 16 bytes to accomodate these
fields, but there are no exisiting users requesting a dma pool smaller
than that anyway.

Removing the list has a significant change in performance. Using the
kernel's micro-benchmarking self test:

Before:

  # modprobe dmapool_test
  dmapool test: size:16   blocks:8192   time:57282
  dmapool test: size:64   blocks:8192   time:172562
  dmapool test: size:256  blocks:8192   time:789247
  dmapool test: size:1024 blocks:2048   time:371823
  dmapool test: size:4096 blocks:1024   time:362237

After:

  # modprobe dmapool_test
  dmapool test: size:16   blocks:8192   time:24997
  dmapool test: size:64   blocks:8192   time:26584
  dmapool test: size:256  blocks:8192   time:33542
  dmapool test: size:1024 blocks:2048   time:9022
  dmapool test: size:4096 blocks:1024   time:6045

The module test allocates quite a few blocks that may not accurately
represent how these pools are used in real life. For a more marco level
benchmark, running fio high-depth + high-batched on nvme, this patch
shows submission and completion latency reduced by ~100usec each, 1%
IOPs improvement, and perf record's time spent in dma_pool_alloc/free
were reduced by half.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/dmapool.c | 221 ++++++++++++++++++++++++---------------------------
 1 file changed, 106 insertions(+), 115 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index d886b46c4b289..d23747a71bff2 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -15,7 +15,7 @@
  * represented by the 'struct dma_pool' which keeps a doubly-linked list=
 of
  * allocated pages.  Each page in the page_list is split into blocks of =
at
  * least 'size' bytes.  Free blocks are tracked in an unsorted singly-li=
nked
- * list of free blocks within the page.  Used blocks aren't tracked, but=
 we
+ * list of free blocks across all pages.  Used blocks aren't tracked, bu=
t we
  * keep a count of how many are currently allocated from each page.
  */
=20
@@ -40,13 +40,22 @@
 #define DMAPOOL_DEBUG 1
 #endif
=20
+struct dma_block {
+	struct dma_block *next_block;
+	dma_addr_t dma;
+};
+
 struct dma_pool {		/* the pool */
 	struct list_head page_list;
 	spinlock_t lock;
 	struct device *dev;
+	struct dma_block *next_block;
 	unsigned int size;
 	unsigned int allocation;
 	unsigned int boundary;
+	size_t nr_blocks;
+	size_t nr_active;
+	size_t nr_pages;
 	char name[32];
 	struct list_head pools;
 };
@@ -55,8 +64,6 @@ struct dma_page {		/* cacheable header for 'allocation'=
 bytes */
 	struct list_head page_list;
 	void *vaddr;
 	dma_addr_t dma;
-	unsigned int in_use;
-	unsigned int offset;
 };
=20
 static DEFINE_MUTEX(pools_lock);
@@ -64,30 +71,18 @@ static DEFINE_MUTEX(pools_reg_lock);
=20
 static ssize_t pools_show(struct device *dev, struct device_attribute *a=
ttr, char *buf)
 {
-	int size;
-	struct dma_page *page;
 	struct dma_pool *pool;
+	unsigned size;
=20
 	size =3D sysfs_emit(buf, "poolinfo - 0.1\n");
=20
 	mutex_lock(&pools_lock);
 	list_for_each_entry(pool, &dev->dma_pools, pools) {
-		unsigned pages =3D 0;
-		size_t blocks =3D 0;
-
-		spin_lock_irq(&pool->lock);
-		list_for_each_entry(page, &pool->page_list, page_list) {
-			pages++;
-			blocks +=3D page->in_use;
-		}
-		spin_unlock_irq(&pool->lock);
-
 		/* per-pool info, no real statistics yet */
-		size +=3D sysfs_emit_at(buf, size, "%-16s %4zu %4zu %4u %2u\n",
-				      pool->name, blocks,
-				      (size_t) pages *
-				      (pool->allocation / pool->size),
-				      pool->size, pages);
+		size +=3D sysfs_emit_at(buf, size, "%-16s %4zu %4zu %4u %2zu\n",
+				      pool->name, pool->nr_active,
+				      pool->nr_blocks, pool->size,
+				      pool->nr_pages);
 	}
 	mutex_unlock(&pools_lock);
=20
@@ -96,6 +91,25 @@ static ssize_t pools_show(struct device *dev, struct d=
evice_attribute *attr, cha
=20
 static DEVICE_ATTR_RO(pools);
=20
+static struct dma_block *pool_block_pop(struct dma_pool *pool)
+{
+	struct dma_block *block =3D pool->next_block;
+
+	if (block) {
+		pool->next_block =3D block->next_block;
+		pool->nr_active++;
+	}
+	return block;
+}
+
+static void pool_block_push(struct dma_pool *pool, struct dma_block *blo=
ck,
+			    dma_addr_t dma)
+{
+	block->dma =3D dma;
+	block->next_block =3D pool->next_block;
+	pool->next_block =3D block;
+}
+
 /**
  * dma_pool_create - Creates a pool of consistent memory blocks, for dma=
.
  * @name: name of pool, for diagnostics
@@ -136,8 +150,8 @@ struct dma_pool *dma_pool_create(const char *name, st=
ruct device *dev,
=20
 	if (size =3D=3D 0 || size > INT_MAX)
 		return NULL;
-	else if (size < 4)
-		size =3D 4;
+	if (size < sizeof(struct dma_block))
+		size =3D sizeof(struct dma_block);
=20
 	size =3D ALIGN(size, align);
 	allocation =3D max_t(size_t, size, PAGE_SIZE);
@@ -149,7 +163,7 @@ struct dma_pool *dma_pool_create(const char *name, st=
ruct device *dev,
=20
 	boundary =3D min(boundary, allocation);
=20
-	retval =3D kmalloc(sizeof(*retval), GFP_KERNEL);
+	retval =3D kzalloc(sizeof(*retval), GFP_KERNEL);
 	if (!retval)
 		return retval;
=20
@@ -162,7 +176,6 @@ struct dma_pool *dma_pool_create(const char *name, st=
ruct device *dev,
 	retval->size =3D size;
 	retval->boundary =3D boundary;
 	retval->allocation =3D allocation;
-
 	INIT_LIST_HEAD(&retval->pools);
=20
 	/*
@@ -199,23 +212,27 @@ EXPORT_SYMBOL(dma_pool_create);
=20
 static void pool_initialise_page(struct dma_pool *pool, struct dma_page =
*page)
 {
-	unsigned int offset =3D 0;
-	unsigned int next_boundary =3D pool->boundary;
+	unsigned int next_boundary =3D pool->boundary, offset =3D 0;
+	struct dma_block *block;
=20
 #ifdef	DMAPOOL_DEBUG
 	memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
 #endif
-	page->in_use =3D 0;
-	page->offset =3D 0;
-	do {
-		unsigned int next =3D offset + pool->size;
-		if (unlikely((next + pool->size) >=3D next_boundary)) {
-			next =3D next_boundary;
+	while (offset + pool->size <=3D pool->allocation) {
+		if (offset + pool->size > next_boundary) {
+			offset =3D next_boundary;
 			next_boundary +=3D pool->boundary;
+			continue;
 		}
-		*(int *)(page->vaddr + offset) =3D next;
-		offset =3D next;
-	} while (offset < pool->allocation);
+
+		block =3D page->vaddr + offset;
+		pool_block_push(pool, block, page->dma + offset);
+		offset +=3D pool->size;
+		pool->nr_blocks++;
+	}
+
+	list_add(&page->page_list, &pool->page_list);
+	pool->nr_pages++;
 }
=20
 static struct dma_page *pool_alloc_page(struct dma_pool *pool, gfp_t mem=
_flags)
@@ -231,16 +248,10 @@ static struct dma_page *pool_alloc_page(struct dma_=
pool *pool, gfp_t mem_flags)
 		kfree(page);
 		return NULL;
 	}
-	pool_initialise_page(pool, page);
=20
 	return page;
 }
=20
-static inline bool is_page_busy(struct dma_page *page)
-{
-	return page->in_use !=3D 0;
-}
-
 /**
  * dma_pool_destroy - destroys a pool of dma memory blocks.
  * @pool: dma pool that will be destroyed
@@ -252,7 +263,7 @@ static inline bool is_page_busy(struct dma_page *page=
)
 void dma_pool_destroy(struct dma_pool *pool)
 {
 	struct dma_page *page, *tmp;
-	bool empty =3D false;
+	bool empty =3D false, busy =3D false;
=20
 	if (unlikely(!pool))
 		return;
@@ -267,13 +278,15 @@ void dma_pool_destroy(struct dma_pool *pool)
 		device_remove_file(pool->dev, &dev_attr_pools);
 	mutex_unlock(&pools_reg_lock);
=20
+	if (pool->nr_active) {
+		dev_err(pool->dev, "%s %s busy\n", __func__, pool->name);
+		busy =3D true;
+	}
+
 	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
-		if (!is_page_busy(page))
+		if (!busy)
 			dma_free_coherent(pool->dev, pool->allocation,
 					  page->vaddr, page->dma);
-		else
-			dev_err(pool->dev, "%s %s, %p busy\n", __func__,
-				pool->name, page->vaddr);
 		list_del(&page->page_list);
 		kfree(page);
 	}
@@ -283,17 +296,17 @@ void dma_pool_destroy(struct dma_pool *pool)
 EXPORT_SYMBOL(dma_pool_destroy);
=20
 #ifdef	DMAPOOL_DEBUG
-static void pool_check_block(struct dma_pool *pool, void *retval,
-			     unsigned int offset, gfp_t mem_flags)
+static void pool_check_block(struct dma_pool *pool, struct dma_block *bl=
ock,
+			     gfp_t mem_flags)
 {
+	u8 *data =3D (void *)block;
 	int i;
-	u8 *data =3D retval;
-	/* page->offset is stored in first 4 bytes */
-	for (i =3D sizeof(offset); i < pool->size; i++) {
+
+	for (i =3D sizeof(struct dma_block); i < pool->size; i++) {
 		if (data[i] =3D=3D POOL_POISON_FREED)
 			continue;
-		dev_err(pool->dev, "%s %s, %p (corrupted)\n",
-			__func__, pool->name, retval);
+		dev_err(pool->dev, "%s %s, %p (corrupted)\n", __func__,
+			pool->name, block);
=20
 		/*
 		 * Dump the first 4 bytes even if they are not
@@ -303,13 +316,13 @@ static void pool_check_block(struct dma_pool *pool,=
 void *retval,
 				data, pool->size, 1);
 		break;
 	}
+
 	if (!want_init_on_alloc(mem_flags))
-		memset(retval, POOL_POISON_ALLOCATED, pool->size);
+		memset(block, POOL_POISON_ALLOCATED, pool->size);
 }
 #else
-static void pool_check_block(struct dma_pool *pool, void *retval,
-			     unsigned int offset, gfp_t mem_flags)
-
+static void pool_check_block(struct dma_pool *pool, struct dma_block *bl=
ock,
+			     gfp_t mem_flags)
 {
 }
 #endif
@@ -327,45 +340,41 @@ static void pool_check_block(struct dma_pool *pool,=
 void *retval,
 void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 		     dma_addr_t *handle)
 {
-	unsigned long flags;
+	struct dma_block *block;
 	struct dma_page *page;
-	unsigned int offset;
-	void *retval;
+	unsigned long flags;
=20
 	might_alloc(mem_flags);
=20
 	spin_lock_irqsave(&pool->lock, flags);
-	list_for_each_entry(page, &pool->page_list, page_list) {
-		if (page->offset < pool->allocation)
-			goto ready;
-	}
-
-	/* pool_alloc_page() might sleep, so temporarily drop &pool->lock */
-	spin_unlock_irqrestore(&pool->lock, flags);
-
-	page =3D pool_alloc_page(pool, mem_flags & (~__GFP_ZERO));
-	if (!page)
-		return NULL;
+	block =3D pool_block_pop(pool);
+	if (!block) {
+		/*
+		 * pool_alloc_page() might sleep, so temporarily drop
+		 * &pool->lock
+		 */
+		spin_unlock_irqrestore(&pool->lock, flags);
=20
-	spin_lock_irqsave(&pool->lock, flags);
+		page =3D pool_alloc_page(pool, mem_flags & (~__GFP_ZERO));
+		if (!page)
+			return NULL;
=20
-	list_add(&page->page_list, &pool->page_list);
- ready:
-	page->in_use++;
-	offset =3D page->offset;
-	page->offset =3D *(int *)(page->vaddr + offset);
-	retval =3D offset + page->vaddr;
-	*handle =3D offset + page->dma;
-	pool_check_block(pool, retval, offset, mem_flags);
+		spin_lock_irqsave(&pool->lock, flags);
+		pool_initialise_page(pool, page);
+		block =3D pool_block_pop(pool);
+	}
 	spin_unlock_irqrestore(&pool->lock, flags);
=20
+	*handle =3D block->dma;
+	pool_check_block(pool, block, mem_flags);
 	if (want_init_on_alloc(mem_flags))
-		memset(retval, 0, pool->size);
+		memset(block, 0, pool->size);
=20
-	return retval;
+	return block;
 }
 EXPORT_SYMBOL(dma_pool_alloc);
=20
+#ifdef DMAPOOL_DEBUG
 static struct dma_page *pool_find_page(struct dma_pool *pool, dma_addr_t=
 dma)
 {
 	struct dma_page *page;
@@ -379,34 +388,33 @@ static struct dma_page *pool_find_page(struct dma_p=
ool *pool, dma_addr_t dma)
 	return NULL;
 }
=20
-#ifdef DMAPOOL_DEBUG
-static bool pool_page_err(struct dma_pool *pool, struct dma_page *page,
-			  void *vaddr, dma_addr_t dma)
+static bool pool_block_err(struct dma_pool *pool, void *vaddr, dma_addr_=
t dma)
 {
-	unsigned int offset =3D vaddr - page->vaddr;
-	unsigned int chain =3D page->offset;
+	struct dma_block *block =3D pool->next_block;
+	struct dma_page *page;
=20
-	if ((dma - page->dma) !=3D offset) {
-		dev_err(pool->dev, "%s %s, %p (bad vaddr)/%pad\n",
+	page =3D pool_find_page(pool, dma);
+	if (!page) {
+		dev_err(pool->dev, "%s %s, %p/%pad (bad dma)\n",
 			__func__, pool->name, vaddr, &dma);
 		return true;
 	}
=20
-	while (chain < pool->allocation) {
-		if (chain !=3D offset) {
-			chain =3D *(int *)(page->vaddr + chain);
+	while (block) {
+		if (block !=3D vaddr) {
+			block =3D block->next_block;
 			continue;
 		}
 		dev_err(pool->dev, "%s %s, dma %pad already free\n",
 			__func__, pool->name, &dma);
 		return true;
 	}
+
 	memset(vaddr, POOL_POISON_FREED, pool->size);
 	return false;
 }
 #else
-static bool pool_page_err(struct dma_pool *pool, struct dma_page *page,
-			  void *vaddr, dma_addr_t dma)
+static bool pool_block_err(struct dma_pool *pool, void *vaddr, dma_addr_=
t dma)
 {
 	if (want_init_on_free())
 		memset(vaddr, 0, pool->size);
@@ -425,31 +433,14 @@ static bool pool_page_err(struct dma_pool *pool, st=
ruct dma_page *page,
  */
 void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 {
-	struct dma_page *page;
+	struct dma_block *block =3D vaddr;
 	unsigned long flags;
=20
 	spin_lock_irqsave(&pool->lock, flags);
-	page =3D pool_find_page(pool, dma);
-	if (!page) {
-		spin_unlock_irqrestore(&pool->lock, flags);
-		dev_err(pool->dev, "%s %s, %p/%pad (bad dma)\n",
-			__func__, pool->name, vaddr, &dma);
-		return;
-	}
-
-	if (pool_page_err(pool, page, vaddr, dma)) {
-		spin_unlock_irqrestore(&pool->lock, flags);
-		return;
+	if (!pool_block_err(pool, vaddr, dma)) {
+		pool_block_push(pool, block, dma);
+		pool->nr_active--;
 	}
-
-	page->in_use--;
-	*(int *)vaddr =3D page->offset;
-	page->offset =3D vaddr - page->vaddr;
-	/*
-	 * Resist a temptation to do
-	 *    if (!is_page_busy(page)) pool_free_page(pool, page);
-	 * Better have a few empty pages hang around.
-	 */
 	spin_unlock_irqrestore(&pool->lock, flags);
 }
 EXPORT_SYMBOL(dma_pool_free);
--=20
2.30.2

