Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7A0654E76
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiLWJfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiLWJfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:35:47 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC522EC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:35:45 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u7so4469850plq.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UZD83MOXZu7ObWug7viCm7dC1OYiPt8nw3/TIAMXFZc=;
        b=ivdSHOC7cuQQW3HUW5FmRWqI/shNX4NuoSRLz7FAVjnWOhShvRHLgIk31R6kksEydP
         hrreuf6jMIgmvi1NnayJ9Lbq+I+VKYRXjM+n9zTNwkAzWVUiVo7NFAynhobRTXzWHyTy
         amejSpTCDsobD5yJ3De8e5wgexRrBo0arfEVMuV9VBdt8qBuUJb+3WgzwuQsnm55y1uV
         V5d2vghHb29sV0YNqiy8DsWiLRtce/oS53YrBeAN1fW7vW2hL0sCPsGupJMRWY2fQ0sp
         jZZhh4T2RCz4WtZzlOfu46WuJ1Vyzl5nyX8KPwC9lyODySn8JAelakkwWcbAOI7jusBV
         x+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZD83MOXZu7ObWug7viCm7dC1OYiPt8nw3/TIAMXFZc=;
        b=dtLyLMkhRK/pstkbxcV+eb6+dP41IPekDy7QzwZ2YUOLgwuQ5onffp09wduSp2+ZgO
         bw/Des5qfpmMMoi8f91vwrjhYQB2e6FKCwd/xsw2ciEYgF67WwsryHPv6WHAOMkS9xcP
         8onkxYRybZTR2FyJETpKdXfZIf7Zu3wInB8DlaLsL59kaEHnUfMpHeQItvB+ccS75Zx/
         3V4ZDgf8FWWebW1GK4iJXh44NIkBBycfLwyrqwucEtVe4tGGQQ+hHb7n6QLhZp93J5NF
         e46r9gJ8jG42NhoYPXexsBOzsCZ35iV6jQpKgg3kUb+3BbqsTtTObpCoZqNs1F7X5f0d
         rnSQ==
X-Gm-Message-State: AFqh2kpcb3dVRPycP5R10CwuvB+6B+6yc4pm64TTQfnVsddx8X1RvcXz
        NlNBk2TKBlCCqwI+ODcB3wE=
X-Google-Smtp-Source: AMrXdXvZP1OMssHJW7CyrNn1VCTHO1hIdd27p+8ZDVnvpji17aO92JRBAac1Us8AotS7TelXnDf9oQ==
X-Received: by 2002:a17:902:bc45:b0:188:b084:7bef with SMTP id t5-20020a170902bc4500b00188b0847befmr10967422plz.42.1671788144859;
        Fri, 23 Dec 2022 01:35:44 -0800 (PST)
Received: from localhost.localdomain (ab137057.f.west.v6connect.net. [183.76.137.57])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709027e8500b00189c62eac37sm1979564pla.32.2022.12.23.01.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 01:35:44 -0800 (PST)
From:   Soichiro Ueda <the.latticeheart@gmail.com>
To:     mst@redhat.com, david@redhat.com, jasowang@redhat.com,
        akpm@linux-foundation.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kalutes@google.com, mhiramat@kernel.org, cwd@google.com,
        Soichiro Ueda <the.latticeheart@gmail.com>
Subject: [PATCH] virtio_balloon: high order allocation
Date:   Fri, 23 Dec 2022 09:35:27 +0000
Message-Id: <20221223093527.12424-1-the.latticeheart@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

At present, the VirtIO balloon device driver allocates pages
one by one using alloc_page(), and frees them using put_page().

This changes it so that the driver allocates high order pages
by using alloc_pages(), and frees them using __free_pages() if possible.
By doing so, the CPU performance of inflation and deflation
should be improved.

The effect of this change has been confirmed by benchmarks that measure
the elapsed time of inflation and deflation.

The results are here:

16 pages inflation:
  before: 119,779 ns
  after : 115,655 ns (-3.4%)
64 pages inflation:
  before: 156,977 ns
  after : 150,961 ns (-3.8%)
256 pages inflation:
  before: 218,649 ns
  after : 208,490 ns (-4.6%)
16 pages deflation:
  before: 78,112 ns
  after : 68,288 ns (-12.6%)
64 pages deflation:
  before: 97,205 ns
  after : 80,491 ns (-17.194%)
256 pages deflation:
  before: 122,742 ns
  after : 107,526 ns (-12.4%)

Signed-off-by: Soichiro Ueda <the.latticeheart@gmail.com>
---
 drivers/virtio/virtio_balloon.c    | 115 ++++++++++++-----
 include/linux/balloon_compaction.h |  54 ++++++--
 mm/balloon_compaction.c            | 193 ++++++++++++++++++++++-------
 3 files changed, 273 insertions(+), 89 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 3f78a3a1eb75..ba5bd033b2fa 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -18,6 +18,7 @@
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
+#include <linux/log2.h>
 
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
@@ -25,7 +26,6 @@
  * page units.
  */
 #define VIRTIO_BALLOON_PAGES_PER_PAGE (unsigned int)(PAGE_SIZE >> VIRTIO_BALLOON_PFN_SHIFT)
-#define VIRTIO_BALLOON_ARRAY_PFNS_MAX 256
 /* Maximum number of (4k) pages to deflate on OOM notifications. */
 #define VIRTIO_BALLOON_OOM_NR_PAGES 256
 #define VIRTIO_BALLOON_OOM_NOTIFY_PRIORITY 80
@@ -206,14 +206,23 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 	unsigned int num_allocated_pages;
 	unsigned int num_pfns;
 	struct page *page;
-	LIST_HEAD(pages);
+	int order, i;
+	struct list_head page_lists[BALLOON_MAX_ORDER];
+
+	for (order = 0; order < BALLOON_MAX_ORDER; order++)
+		INIT_LIST_HEAD(&page_lists[order]);
 
 	/* We can only do one array worth at a time. */
 	num = min(num, ARRAY_SIZE(vb->pfns));
 
-	for (num_pfns = 0; num_pfns < num;
-	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
-		struct page *page = balloon_page_alloc();
+	order = min(__ilog2_u64(num), BALLOON_MAX_ORDER - 1);
+	while (num > 0) {
+		for (order = min(__ilog2_u64(num), order);
+			 order >= 0; order--) {
+			page = balloon_pages_alloc(order);
+			if (page)
+				break;
+		}
 
 		if (!page) {
 			dev_info_ratelimited(&vb->vdev->dev,
@@ -224,22 +233,36 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 			break;
 		}
 
-		balloon_page_push(&pages, page);
+		balloon_page_push(&page_lists[order], page);
+		num_pfns = (1 << order);
+		num -= num_pfns;
 	}
 
 	mutex_lock(&vb->balloon_lock);
 
 	vb->num_pfns = 0;
 
-	while ((page = balloon_page_pop(&pages))) {
-		balloon_page_enqueue(&vb->vb_dev_info, page);
-
-		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
-		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
-		if (!virtio_has_feature(vb->vdev,
-					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
-			adjust_managed_page_count(page, -1);
-		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
+	for (order = 0; order < BALLOON_MAX_ORDER; order++) {
+		num_pfns = (1 << order);
+		while ((page = balloon_page_pop(&page_lists[order]))) {
+			if ((balloon_page_enqueue(
+				    &vb->vb_dev_info, page, order))) {
+				WARN_ONCE(1, "invalid page or order: page=%p, order=%d",
+				    page, order);
+				break;
+			}
+			for (i = 0; i < num_pfns; i++) {
+				set_page_pfns(vb, vb->pfns + vb->num_pfns + i,
+					      nth_page(page, i));
+			}
+			vb->num_pages +=
+				num_pfns * VIRTIO_BALLOON_PAGES_PER_PAGE;
+			if (!virtio_has_feature(
+				    vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+				adjust_managed_page_count(page, -num_pfns);
+			vb->num_pfns +=
+				num_pfns * VIRTIO_BALLOON_PAGES_PER_PAGE;
+		}
 	}
 
 	num_allocated_pages = vb->num_pfns;
@@ -252,40 +275,68 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 }
 
 static void release_pages_balloon(struct virtio_balloon *vb,
-				 struct list_head *pages)
+				 struct list_head *page_lists)
 {
 	struct page *page, *next;
-
-	list_for_each_entry_safe(page, next, pages, lru) {
-		if (!virtio_has_feature(vb->vdev,
-					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
-			adjust_managed_page_count(page, 1);
-		list_del(&page->lru);
-		put_page(page); /* balloon reference */
+	int order;
+
+	for (order = 0; order < BALLOON_MAX_ORDER; order++) {
+		list_for_each_entry_safe(page, next, &page_lists[order], lru) {
+			if (!virtio_has_feature(
+				    vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+				adjust_managed_page_count(page, 1 << order);
+			list_del(&page->lru);
+			__free_pages(page, order); /* balloon reference */
+		}
 	}
 }
 
 static unsigned int leak_balloon(struct virtio_balloon *vb, size_t num)
 {
 	unsigned int num_freed_pages;
+	unsigned int num_pfns;
 	struct page *page;
 	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
-	LIST_HEAD(pages);
+	struct list_head page_lists[BALLOON_MAX_ORDER];
+	int order, i;
+
+	for (order = 0; order < BALLOON_MAX_ORDER; order++)
+		INIT_LIST_HEAD(&page_lists[order]);
 
 	/* We can only do one array worth at a time. */
 	num = min(num, ARRAY_SIZE(vb->pfns));
 
 	mutex_lock(&vb->balloon_lock);
 	/* We can't release more pages than taken */
-	num = min(num, (size_t)vb->num_pages);
-	for (vb->num_pfns = 0; vb->num_pfns < num;
-	     vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
-		page = balloon_page_dequeue(vb_dev_info);
+	num = min_t(size_t, num, vb->num_pages);
+
+	vb->num_pfns = 0;
+	order = min(__ilog2_u64(num), BALLOON_MAX_ORDER);
+	while (num > 0) {
+		for (order = min(__ilog2_u64(num), order);
+			 order >= 0; order--) {
+			page = balloon_page_dequeue_by_order(vb_dev_info, order);
+
+			if (page)
+				break;
+		}
+
+		if (IS_ERR(page)) {
+			WARN_ONCE(1, "invalid order (%d)\n", order);
+			break;
+		}
+
 		if (!page)
 			break;
-		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
-		list_add(&page->lru, &pages);
-		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
+
+		num_pfns = (1 << order);
+		for (i = 0; i < num_pfns; i++)
+			set_page_pfns(vb, vb->pfns + vb->num_pfns + i, nth_page(page, i));
+		list_add(&page->lru, &page_lists[order]);
+		vb->num_pages -= num_pfns * VIRTIO_BALLOON_PAGES_PER_PAGE;
+		vb->num_pfns += num_pfns * VIRTIO_BALLOON_PAGES_PER_PAGE;
+
+		num -= num_pfns * VIRTIO_BALLOON_PAGES_PER_PAGE;
 	}
 
 	num_freed_pages = vb->num_pfns;
@@ -296,7 +347,7 @@ static unsigned int leak_balloon(struct virtio_balloon *vb, size_t num)
 	 */
 	if (vb->num_pfns != 0)
 		tell_host(vb, vb->deflate_vq);
-	release_pages_balloon(vb, &pages);
+	release_pages_balloon(vb, page_lists);
 	mutex_unlock(&vb->balloon_lock);
 	return num_freed_pages;
 }
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 5ca2d5699620..edf4309dee95 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -43,6 +43,11 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/list.h>
+#include <linux/log2.h>
+
+#define VIRTIO_BALLOON_ARRAY_PFNS_MAX_SHIFT 8
+#define VIRTIO_BALLOON_ARRAY_PFNS_MAX (1 << VIRTIO_BALLOON_ARRAY_PFNS_MAX_SHIFT)
+#define BALLOON_MAX_ORDER (VIRTIO_BALLOON_ARRAY_PFNS_MAX_SHIFT + 1)
 
 /*
  * Balloon device information descriptor.
@@ -54,15 +59,19 @@
 struct balloon_dev_info {
 	unsigned long isolated_pages;	/* # of isolated pages for migration */
 	spinlock_t pages_lock;		/* Protection to pages list */
-	struct list_head pages;		/* Pages enqueued & handled to Host */
+	struct list_head
+		pages_lists[BALLOON_MAX_ORDER];	/* Pages enqueued & handled to Host */
 	int (*migratepage)(struct balloon_dev_info *, struct page *newpage,
 			struct page *page, enum migrate_mode mode);
 };
 
 extern struct page *balloon_page_alloc(void);
-extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
-				 struct page *page);
+extern struct page *balloon_pages_alloc(unsigned int order);
+extern int balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
+				 struct page *page, unsigned int order);
 extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info);
+extern struct page *balloon_page_dequeue_by_order(
+				      struct balloon_dev_info *b_dev_info, unsigned int order);
 extern size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
 				      struct list_head *pages);
 extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
@@ -70,15 +79,37 @@ extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 
 static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 {
+	int i;
+
 	balloon->isolated_pages = 0;
 	spin_lock_init(&balloon->pages_lock);
-	INIT_LIST_HEAD(&balloon->pages);
+	for (i = 0; i < BALLOON_MAX_ORDER; i++)
+		INIT_LIST_HEAD(&balloon->pages_lists[i]);
 	balloon->migratepage = NULL;
 }
 
 #ifdef CONFIG_BALLOON_COMPACTION
 extern const struct movable_operations balloon_mops;
 
+/*
+ * balloon_page_insert_by_order - insert a page into the balloon's page list
+ *			 and make the page->private assignment accordingly.
+ * @balloon : pointer to balloon device
+ * @page    : page to be assigned as a 'balloon page'
+ * @order   : order of page
+ *
+ * Like balloon_page_insert, except the caller can specify
+ * an order of a page to allocate.
+ */
+static inline void balloon_page_insert_by_order(struct balloon_dev_info *balloon,
+				       struct page *page, unsigned int order)
+{
+	__SetPageOffline(page);
+	__SetPageMovable(page, &balloon_mops);
+	set_page_private(page, (unsigned long)balloon);
+	list_add(&page->lru, &balloon->pages_lists[order]);
+}
+
 /*
  * balloon_page_insert - insert a page into the balloon's page list and make
  *			 the page->private assignment accordingly.
@@ -91,10 +122,7 @@ extern const struct movable_operations balloon_mops;
 static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
-	__SetPageOffline(page);
-	__SetPageMovable(page, &balloon_mops);
-	set_page_private(page, (unsigned long)balloon);
-	list_add(&page->lru, &balloon->pages);
+	balloon_page_insert_by_order(balloon, page, 0);
 }
 
 /*
@@ -134,11 +162,17 @@ static inline gfp_t balloon_mapping_gfp_mask(void)
 
 #else /* !CONFIG_BALLOON_COMPACTION */
 
+static inline void balloon_page_insert_by_order(struct balloon_dev_info *balloon,
+				       struct page *page, unsigned int order)
+{
+	__SetPageOffline(page);
+	list_add(&page->lru, &balloon->pages_lists[order]);
+}
+
 static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
-	__SetPageOffline(page);
-	list_add(&page->lru, &balloon->pages);
+	balloon_page_insert_by_order(balloon, page, 0);
 }
 
 static inline void balloon_page_delete(struct page *page)
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 22c96fed70b5..3654422c0411 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -12,7 +12,7 @@
 #include <linux/balloon_compaction.h>
 
 static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
-				     struct page *page)
+				     struct page *page, unsigned int order, bool is_split_requeue)
 {
 	/*
 	 * Block others from accessing the 'page' when we get around to
@@ -21,9 +21,63 @@ static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
 	 * memory corruption is possible and we should stop execution.
 	 */
 	BUG_ON(!trylock_page(page));
-	balloon_page_insert(b_dev_info, page);
+	balloon_page_insert_by_order(b_dev_info, page, order);
 	unlock_page(page);
-	__count_vm_event(BALLOON_INFLATE);
+
+	if (!is_split_requeue)
+		__count_vm_event(BALLOON_INFLATE);
+}
+
+static struct page *balloon_page_dequeue_one(struct balloon_dev_info *b_dev_info,
+				 unsigned int order)
+{
+		struct page *page = NULL, *removed_page = NULL, *tmp;
+
+		list_for_each_entry_safe(page, tmp, &b_dev_info->pages_lists[order], lru) {
+			/*
+			 * Block others from accessing the 'page' while we get around to
+			 * establishing additional references and preparing the 'page'
+			 * to be released by the balloon driver.
+			 */
+			if (!trylock_page(page))
+				continue;
+
+			if (IS_ENABLED(CONFIG_BALLOON_COMPACTION) &&
+			    PageIsolated(page)) {
+				/* raced with isolation */
+				unlock_page(page);
+				continue;
+			}
+			balloon_page_delete(page);
+			removed_page = page;
+			break;
+		}
+
+		return removed_page;
+}
+
+static void balloon_split_high_order_page(struct balloon_dev_info *b_dev_info)
+{
+	struct page *page = NULL;
+	unsigned int order, i, num_pages;
+
+	for (order = 1; order < BALLOON_MAX_ORDER; order++) {
+		if (list_empty(&b_dev_info->pages_lists[order]))
+			continue;
+		page = balloon_page_dequeue_one(b_dev_info, order);
+
+		if (page)
+			break;
+	}
+
+	if (!page)
+		return;
+
+	unlock_page(page);
+	split_page(page, order);
+	num_pages = (1 << order);
+	for (i = 0; i < num_pages; i++)
+		balloon_page_enqueue_one(b_dev_info, nth_page(page, i), 0, false);
 }
 
 /**
@@ -47,7 +101,7 @@ size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	list_for_each_entry_safe(page, tmp, pages, lru) {
 		list_del(&page->lru);
-		balloon_page_enqueue_one(b_dev_info, page);
+		balloon_page_enqueue_one(b_dev_info, page, 0, true);
 		n_pages++;
 	}
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
@@ -76,36 +130,15 @@ EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
 size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 				 struct list_head *pages, size_t n_req_pages)
 {
-	struct page *page, *tmp;
-	unsigned long flags;
+	struct page *page;
 	size_t n_pages = 0;
 
-	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
-	list_for_each_entry_safe(page, tmp, &b_dev_info->pages, lru) {
-		if (n_pages == n_req_pages)
+	for (n_pages = 0; n_pages < n_req_pages; n_pages++) {
+		page = balloon_page_dequeue(b_dev_info);
+		if (!page)
 			break;
-
-		/*
-		 * Block others from accessing the 'page' while we get around to
-		 * establishing additional references and preparing the 'page'
-		 * to be released by the balloon driver.
-		 */
-		if (!trylock_page(page))
-			continue;
-
-		if (IS_ENABLED(CONFIG_BALLOON_COMPACTION) &&
-		    PageIsolated(page)) {
-			/* raced with isolation */
-			unlock_page(page);
-			continue;
-		}
-		balloon_page_delete(page);
-		__count_vm_event(BALLOON_DEFLATE);
 		list_add(&page->lru, pages);
-		unlock_page(page);
-		n_pages++;
 	}
-	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 
 	return n_pages;
 }
@@ -123,18 +156,42 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
  */
 struct page *balloon_page_alloc(void)
 {
-	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
-				       __GFP_NOMEMALLOC | __GFP_NORETRY |
-				       __GFP_NOWARN);
-	return page;
+	return balloon_pages_alloc(0);
 }
 EXPORT_SYMBOL_GPL(balloon_page_alloc);
 
+/*
+ * balloon_page_alloc - allocates a new page for insertion into the balloon
+ *			page list.
+ *
+ * @order: order of a page to allocate.
+ *
+ * Like balloon_page_alloc, except the caller can specify
+ * an order of a page to allocate.
+ *
+ * Return: struct page for the allocated page, or NULL on allocation failure.
+ */
+struct page *balloon_pages_alloc(unsigned int order)
+{
+	gfp_t gfp_mask;
+
+	gfp_mask = balloon_mapping_gfp_mask() |
+				__GFP_NOMEMALLOC | __GFP_NORETRY |
+				__GFP_NOWARN;
+	/* prevent compaction from running */
+	if (order != 0)
+		gfp_mask &= ~__GFP_RECLAIM;
+
+	return alloc_pages(gfp_mask, order);
+}
+EXPORT_SYMBOL_GPL(balloon_pages_alloc);
+
 /*
  * balloon_page_enqueue - inserts a new page into the balloon page list.
  *
  * @b_dev_info: balloon device descriptor where we will insert a new page
- * @page: new page to enqueue - allocated using balloon_page_alloc.
+ * @page: new page to enqueue - allocated using balloon_pages_alloc.
+ * @order: order of the new page.
  *
  * Drivers must call this function to properly enqueue a new allocated balloon
  * page before definitively removing the page from the guest system.
@@ -142,15 +199,21 @@ EXPORT_SYMBOL_GPL(balloon_page_alloc);
  * Drivers must not call balloon_page_enqueue on pages that have been pushed to
  * a list with balloon_page_push before removing them with balloon_page_pop. To
  * enqueue a list of pages, use balloon_page_list_enqueue instead.
+ *
+ * Return: error if the page is NULL or order is BALLOON_MAX_ORDER or more.
  */
-void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
-			  struct page *page)
+int balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
+			 struct page *page, unsigned int order)
 {
 	unsigned long flags;
 
+	if (!page || order >= BALLOON_MAX_ORDER)
+		return -EINVAL;
+
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
-	balloon_page_enqueue_one(b_dev_info, page);
+	balloon_page_enqueue_one(b_dev_info, page, order, true);
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(balloon_page_enqueue);
 
@@ -175,14 +238,49 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
  * Return: struct page for the dequeued page, or NULL if no page was dequeued.
  */
 struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info)
+{
+	return balloon_page_dequeue_by_order(b_dev_info, 0);
+}
+EXPORT_SYMBOL_GPL(balloon_page_dequeue);
+
+/*
+ * balloon_page_dequeue_by_order - removes a specifiled order page from balloon's
+ * page list and returns its address to allow the driver to release the page.
+ * @b_dev_info: balloon device decriptor where we will grab a page from.
+ * @order: order of a page to remove.
+ *
+ * Like balloon_page_dequeue, except the caller can specify an order to try to
+ * dequeue previously queued pages of that order. For orders greater than 0, this
+ * function may return NULL if there are no queued pages of the specified order. For
+ * order 0, if there are only pages with order greater than 0 queued, then this
+ * function will split one such page and return one of the resulting 0 order pages.
+ *
+ * Return: struct page for the dequeued page, or NULL if no page was dequeued
+ *			or error if order is BALLOON_MAX_ORDER or more.
+ */
+struct page *balloon_page_dequeue_by_order(struct balloon_dev_info *b_dev_info, unsigned int order)
 {
 	unsigned long flags;
-	LIST_HEAD(pages);
-	int n_pages;
+	struct page *page = NULL;
 
-	n_pages = balloon_page_list_dequeue(b_dev_info, &pages, 1);
+	if (page || order >= BALLOON_MAX_ORDER)
+		return ERR_PTR(-EINVAL);
 
-	if (n_pages != 1) {
+	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
+
+	/*
+	 * If a 0-order page is specified, we can fulfill the request
+	 * by splitting a higher order page into 0-order pages.
+	 */
+	if (list_empty(&b_dev_info->pages_lists[order]) && order == 0)
+		balloon_split_high_order_page(b_dev_info);
+
+	page = balloon_page_dequeue_one(b_dev_info, order);
+
+	if (page) {
+		__count_vm_event(BALLOON_DEFLATE);
+		unlock_page(page);
+	} else {
 		/*
 		 * If we are unable to dequeue a balloon page because the page
 		 * list is empty and there are no isolated pages, then something
@@ -190,16 +288,17 @@ struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info)
 		 * BUG() here, otherwise the balloon driver may get stuck in
 		 * an infinite loop while attempting to release all its pages.
 		 */
-		spin_lock_irqsave(&b_dev_info->pages_lock, flags);
-		if (unlikely(list_empty(&b_dev_info->pages) &&
-			     !b_dev_info->isolated_pages))
+		if (unlikely(list_empty(&b_dev_info->pages_lists[order]) &&
+			     order == 0 && !b_dev_info->isolated_pages))
 			BUG();
 		spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 		return NULL;
 	}
-	return list_first_entry(&pages, struct page, lru);
+
+	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
+	return page;
 }
-EXPORT_SYMBOL_GPL(balloon_page_dequeue);
+EXPORT_SYMBOL_GPL(balloon_page_dequeue_by_order);
 
 #ifdef CONFIG_BALLOON_COMPACTION
 
@@ -223,7 +322,7 @@ static void balloon_page_putback(struct page *page)
 	unsigned long flags;
 
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
-	list_add(&page->lru, &b_dev_info->pages);
+	list_add(&page->lru, &b_dev_info->pages_lists[0]);
 	b_dev_info->isolated_pages--;
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 }
-- 
2.35.1

