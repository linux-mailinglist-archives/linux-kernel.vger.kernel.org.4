Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D55466A316
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjAMTbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjAMTa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:30:26 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC1888DEE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:16 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4d4b54d0731so108678167b3.18
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OYI7n7ZxeJbzc3ugoUEmPU4HTlcXY2wcEsEpgVbelmw=;
        b=ThGDNtBdyYDpNLmjAmXExCnTdPb0ZeXG7u+LrZopq0ooHgWxrX9/gBZ+z52wHQZOlq
         j5iFxBoe++GtsSU4jtrJqmyYkdpVDDoYB5hgiS9eQqb2CDzQ5Cyd2Mby1rif3UNQ59MQ
         CNSQBTXvhPwdn6ezr51z3znvGuGpDk0+PwPW2BcW7oJpWh+IcWlrZMZe1PGOgSVy7SHr
         DT09Nlqd1UNXs4vcAvKLTFzQTMTod+dQk4l3ZoKR3ENRloVjFbKmGTYcaefe8nFd0vfR
         HDmdRO8a/L7QgVCp6/sdy37Ak1DDXt4kEw0AD4lBQzcbumK0CQQ9fWCMmJWDTGHzj1Ei
         ZdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYI7n7ZxeJbzc3ugoUEmPU4HTlcXY2wcEsEpgVbelmw=;
        b=ZAoH+jBJxWADzHy69N9ZKeObHcprjatulXhJThz9DpkX3rOmWwoYx0Vl8RnoT8Anxf
         f07zwztG/P3wjzhiDWicVba6VwL5z5WSxJfDpGBiQaVZChU+U6VNyLfHKspLsJq8lkGR
         lRYy9VYKHbkDlIhMWKOGCg4hy9XQKZJ2RLzbXvWkx4EkNy0Xkwzs9wBVUWwDIxbVEfsY
         /A3dnEVSWabCPqcUou66QbmV7dcMxxFZ+qRdjGS/vShEmP8JA82X1IE4/wva/Xr3KmI9
         k+cco3ISiCY3FqZT0sLXK1bRbMYRn7odK8MYkNYxID6pHJCEGhPcNmT6JQZuPRIauhmJ
         uDZA==
X-Gm-Message-State: AFqh2kqb6pWzD4kCG2yXLQSIL3N8G3pW9kgMdptUuLBe0lwzqFHm/K8+
        dZYXY4VaJv2VyXJKIKN7HxPuBVW61B2Q
X-Google-Smtp-Source: AMrXdXsgTTSp4m33QxaqaCs0r9IfBeXFvdinDI+HQvS2JRlTxa/XPXazKp04CFYAH1EhQBUlU59kVehclstM
X-Received: from bg.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b4])
 (user=bgeffon job=sendgmr) by 2002:a0d:db93:0:b0:3ab:78e8:caef with SMTP id
 d141-20020a0ddb93000000b003ab78e8caefmr3106653ywe.285.1673638216101; Fri, 13
 Jan 2023 11:30:16 -0800 (PST)
Date:   Fri, 13 Jan 2023 14:30:06 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230113193006.1320379-1-bgeffon@google.com>
Subject: [PATCH] PM: hibernate: don't store zero pages in the image file.
From:   Brian Geffon <bgeffon@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ChromeOS we've observed a considerable number of in-use pages filled
with zeros. Today with hibernate it's entirely possible that saveable
pages are just zero filled. Since we're already copying pages
word-by-word in do_copy_page it becomes almost free to determine if a
page was completely filled with zeros.

This change introduces a new bitmap which will track these zero pages.
If a page is zero it will not be included in the saved image, instead to
track these zero pages in the image file we will introduce a new flag
which we will set on the packed PFN list. When reading back in the image
file we will detect these zero page PFNs and rebuild the zero page bitmap.

When the image is being loaded through calls to snapshot_write_next if we
encounter a zero page we will silently memset it to 0 and then continue on
to the next page. Given the implementation in snapshot_read_next and
snapshot_write_next this change  will be transparent to non-compressed,
compressed, and swsusp modes of operation.

To provide some concrete numbers from simple ad-hoc testing, on a device
which was lightly in use we saw that:

 PM: hibernation: Image created (964408 pages copied, 548304 zero pages)

Of the approximately 6.2GB of saveable pages 2.2GB (36%) were just zero
filled and could be tracked entirely within the packed PFN list. The
savings would obviously be much lower for lzo compressed images, but even
in the case of compression not copying pages across to the compression
threads will still speed things up. It's also possible that we would see
better overall compression ratios as larger regions of "real data" would
improve the compressibility.

Finally, such an approach could dramatically improve swsusp performance
as each one of those zero pages requires a write syscall to reload, by
handling it as part of the packed PFN list we're able to fully avoid
that.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 kernel/power/snapshot.c | 127 ++++++++++++++++++++++++++++++----------
 1 file changed, 97 insertions(+), 30 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index cd8b7b35f1e8..9846de7f2d41 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -404,6 +404,7 @@ struct bm_position {
 	struct mem_zone_bm_rtree *zone;
 	struct rtree_node *node;
 	unsigned long node_pfn;
+	unsigned long cur_pfn;
 	int node_bit;
 };
 
@@ -589,6 +590,7 @@ static void memory_bm_position_reset(struct memory_bitmap *bm)
 	bm->cur.node = list_entry(bm->cur.zone->leaves.next,
 				  struct rtree_node, list);
 	bm->cur.node_pfn = 0;
+	bm->cur.cur_pfn = BM_END_OF_MAP;
 	bm->cur.node_bit = 0;
 }
 
@@ -850,6 +852,11 @@ static void memory_bm_clear_current(struct memory_bitmap *bm)
 	clear_bit(bit, bm->cur.node->data);
 }
 
+static unsigned long memory_bm_get_current(struct memory_bitmap *bm)
+{
+	return bm->cur.cur_pfn;
+}
+
 static int memory_bm_test_bit(struct memory_bitmap *bm, unsigned long pfn)
 {
 	void *addr;
@@ -929,10 +936,12 @@ static unsigned long memory_bm_next_pfn(struct memory_bitmap *bm)
 		if (bit < bits) {
 			pfn = bm->cur.zone->start_pfn + bm->cur.node_pfn + bit;
 			bm->cur.node_bit = bit + 1;
+			bm->cur.cur_pfn = pfn;
 			return pfn;
 		}
 	} while (rtree_next_node(bm));
 
+	bm->cur.cur_pfn = BM_END_OF_MAP;
 	return BM_END_OF_MAP;
 }
 
@@ -1371,14 +1380,18 @@ static unsigned int count_data_pages(void)
 
 /*
  * This is needed, because copy_page and memcpy are not usable for copying
- * task structs.
+ * task structs. Returns 1 if a page was filled with only zeros, otherwise 0.
  */
-static inline void do_copy_page(long *dst, long *src)
+static inline int do_copy_page(long *dst, long *src)
 {
 	int n;
+	long z = 0;
 
-	for (n = PAGE_SIZE / sizeof(long); n; n--)
+	for (n = PAGE_SIZE / sizeof(long); n; n--) {
+		z |= *src;
 		*dst++ = *src++;
+	}
+	return !z;
 }
 
 /**
@@ -1389,15 +1402,17 @@ static inline void do_copy_page(long *dst, long *src)
  * CONFIG_ARCH_HAS_SET_DIRECT_MAP is not set. In that case kernel_page_present()
  * always returns 'true'.
  */
-static void safe_copy_page(void *dst, struct page *s_page)
+static int safe_copy_page(void *dst, struct page *s_page)
 {
+	int ret;
 	if (kernel_page_present(s_page)) {
-		do_copy_page(dst, page_address(s_page));
+		ret = do_copy_page(dst, page_address(s_page));
 	} else {
 		hibernate_map_page(s_page);
-		do_copy_page(dst, page_address(s_page));
+		ret = do_copy_page(dst, page_address(s_page));
 		hibernate_unmap_page(s_page);
 	}
+	return ret;
 }
 
 #ifdef CONFIG_HIGHMEM
@@ -1407,17 +1422,18 @@ static inline struct page *page_is_saveable(struct zone *zone, unsigned long pfn
 		saveable_highmem_page(zone, pfn) : saveable_page(zone, pfn);
 }
 
-static void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
+static int copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 {
 	struct page *s_page, *d_page;
 	void *src, *dst;
+	int ret;
 
 	s_page = pfn_to_page(src_pfn);
 	d_page = pfn_to_page(dst_pfn);
 	if (PageHighMem(s_page)) {
 		src = kmap_atomic(s_page);
 		dst = kmap_atomic(d_page);
-		do_copy_page(dst, src);
+		ret = do_copy_page(dst, src);
 		kunmap_atomic(dst);
 		kunmap_atomic(src);
 	} else {
@@ -1426,30 +1442,32 @@ static void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 			 * The page pointed to by src may contain some kernel
 			 * data modified by kmap_atomic()
 			 */
-			safe_copy_page(buffer, s_page);
+			ret = safe_copy_page(buffer, s_page);
 			dst = kmap_atomic(d_page);
 			copy_page(dst, buffer);
 			kunmap_atomic(dst);
 		} else {
-			safe_copy_page(page_address(d_page), s_page);
+			ret = safe_copy_page(page_address(d_page), s_page);
 		}
 	}
+	return ret;
 }
 #else
 #define page_is_saveable(zone, pfn)	saveable_page(zone, pfn)
 
-static inline void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
+static inline int copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 {
-	safe_copy_page(page_address(pfn_to_page(dst_pfn)),
+	return safe_copy_page(page_address(pfn_to_page(dst_pfn)),
 				pfn_to_page(src_pfn));
 }
 #endif /* CONFIG_HIGHMEM */
 
 static void copy_data_pages(struct memory_bitmap *copy_bm,
-			    struct memory_bitmap *orig_bm)
+			    struct memory_bitmap *orig_bm,
+			    struct memory_bitmap *zero_bm)
 {
 	struct zone *zone;
-	unsigned long pfn;
+	unsigned long pfn, copy_pfn;
 
 	for_each_populated_zone(zone) {
 		unsigned long max_zone_pfn;
@@ -1462,11 +1480,18 @@ static void copy_data_pages(struct memory_bitmap *copy_bm,
 	}
 	memory_bm_position_reset(orig_bm);
 	memory_bm_position_reset(copy_bm);
+	copy_pfn = memory_bm_next_pfn(copy_bm);
 	for(;;) {
 		pfn = memory_bm_next_pfn(orig_bm);
 		if (unlikely(pfn == BM_END_OF_MAP))
 			break;
-		copy_data_page(memory_bm_next_pfn(copy_bm), pfn);
+		if (copy_data_page(copy_pfn, pfn)) {
+			memory_bm_set_bit(zero_bm, pfn);
+
+			/* We will reuse this copy_pfn for a real 'nonzero' page. */
+			continue;
+		}
+		copy_pfn = memory_bm_next_pfn(copy_bm);
 	}
 }
 
@@ -1494,6 +1519,9 @@ static struct memory_bitmap orig_bm;
  */
 static struct memory_bitmap copy_bm;
 
+/* Memory bitmap which tracks which saveable pages were zero filled. */
+static struct memory_bitmap zero_bm;
+
 /**
  * swsusp_free - Free pages allocated for hibernation image.
  *
@@ -1756,6 +1784,12 @@ int hibernate_preallocate_memory(void)
 		goto err_out;
 	}
 
+	error = memory_bm_create(&zero_bm, GFP_IMAGE, PG_ANY);
+	if (error) {
+		pr_err("Cannot allocate zero bitmap\n");
+		goto err_out;
+	}
+
 	alloc_normal = 0;
 	alloc_highmem = 0;
 
@@ -2013,11 +2047,12 @@ static int swsusp_alloc(struct memory_bitmap *copy_bm,
 
 asmlinkage __visible int swsusp_save(void)
 {
-	unsigned int nr_pages, nr_highmem;
+	unsigned int nr_pages, nr_highmem, nr_zero_pages;
 
 	pr_info("Creating image:\n");
 
 	drain_local_pages(NULL);
+	nr_zero_pages = 0;
 	nr_pages = count_data_pages();
 	nr_highmem = count_highmem_pages();
 	pr_info("Need to copy %u pages\n", nr_pages + nr_highmem);
@@ -2037,19 +2072,23 @@ asmlinkage __visible int swsusp_save(void)
 	 * Kill them.
 	 */
 	drain_local_pages(NULL);
-	copy_data_pages(&copy_bm, &orig_bm);
+	copy_data_pages(&copy_bm, &orig_bm, &zero_bm);
 
 	/*
 	 * End of critical section. From now on, we can write to memory,
 	 * but we should not touch disk. This specially means we must _not_
 	 * touch swap space! Except we must write out our image of course.
 	 */
+	memory_bm_position_reset(&zero_bm);
+	while (memory_bm_next_pfn(&zero_bm) != BM_END_OF_MAP)
+		nr_zero_pages++;
 
 	nr_pages += nr_highmem;
-	nr_copy_pages = nr_pages;
+	/* We don't actually copy the zero pages */
+	nr_copy_pages = nr_pages - nr_zero_pages;
 	nr_meta_pages = DIV_ROUND_UP(nr_pages * sizeof(long), PAGE_SIZE);
 
-	pr_info("Image created (%d pages copied)\n", nr_pages);
+	pr_info("Image created (%d pages copied, %d zero pages)\n", nr_copy_pages, nr_zero_pages);
 
 	return 0;
 }
@@ -2094,15 +2133,22 @@ static int init_header(struct swsusp_info *info)
 	return init_header_complete(info);
 }
 
+#define ENCODED_PFN_ZERO_FLAG (1UL << (BITS_PER_LONG - 1))
+#define ENCODED_PFN_MASK (~ENCODED_PFN_ZERO_FLAG)
+
 /**
  * pack_pfns - Prepare PFNs for saving.
  * @bm: Memory bitmap.
  * @buf: Memory buffer to store the PFNs in.
+ * @zero_bm: Memory bitmap containing PFNs of zero pages.
  *
  * PFNs corresponding to set bits in @bm are stored in the area of memory
- * pointed to by @buf (1 page at a time).
+ * pointed to by @buf (1 page at a time). Pages which were filled with only
+ * zeros will have the highest bit set in the packed format to distinguish
+ * them from PFNs which will be contained in the image file.
  */
-static inline void pack_pfns(unsigned long *buf, struct memory_bitmap *bm)
+static inline void pack_pfns(unsigned long *buf, struct memory_bitmap *bm,
+		struct memory_bitmap *zero_bm)
 {
 	int j;
 
@@ -2110,6 +2156,8 @@ static inline void pack_pfns(unsigned long *buf, struct memory_bitmap *bm)
 		buf[j] = memory_bm_next_pfn(bm);
 		if (unlikely(buf[j] == BM_END_OF_MAP))
 			break;
+		if (memory_bm_test_bit(zero_bm, buf[j]))
+			buf[j] |= ENCODED_PFN_ZERO_FLAG;
 	}
 }
 
@@ -2151,7 +2199,7 @@ int snapshot_read_next(struct snapshot_handle *handle)
 		memory_bm_position_reset(&copy_bm);
 	} else if (handle->cur <= nr_meta_pages) {
 		clear_page(buffer);
-		pack_pfns(buffer, &orig_bm);
+		pack_pfns(buffer, &orig_bm, &zero_bm);
 	} else {
 		struct page *page;
 
@@ -2247,24 +2295,30 @@ static int load_header(struct swsusp_info *info)
  * unpack_orig_pfns - Set bits corresponding to given PFNs in a memory bitmap.
  * @bm: Memory bitmap.
  * @buf: Area of memory containing the PFNs.
+ * @zero_bm: Memory bitmap which will be populated with the PFNs of zero pages.
  *
  * For each element of the array pointed to by @buf (1 page at a time), set the
- * corresponding bit in @bm.
+ * corresponding bit in @bm. If the page was originally populated with only
+ * zeros then a corresponding bit will also be set in @zero_bm.
  */
-static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
+static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm,
+		struct memory_bitmap *zero_bm)
 {
-	int j;
+	int j, zero;
+	unsigned long decoded_pfn;
 
 	for (j = 0; j < PAGE_SIZE / sizeof(long); j++) {
 		if (unlikely(buf[j] == BM_END_OF_MAP))
 			break;
 
-		if (pfn_valid(buf[j]) && memory_bm_pfn_present(bm, buf[j])) {
-			memory_bm_set_bit(bm, buf[j]);
+		zero = !!(buf[j] & ENCODED_PFN_ZERO_FLAG);
+		decoded_pfn = buf[j] & ENCODED_PFN_MASK;
+		if (pfn_valid(decoded_pfn) && memory_bm_pfn_present(bm, decoded_pfn)) {
+			memory_bm_set_bit(bm, decoded_pfn);
 		} else {
-			if (!pfn_valid(buf[j]))
+			if (!pfn_valid(decoded_pfn))
 				pr_err(FW_BUG "Memory map mismatch at 0x%llx after hibernation\n",
-				       (unsigned long long)PFN_PHYS(buf[j]));
+				       (unsigned long long)PFN_PHYS(decoded_pfn));
 			return -EFAULT;
 		}
 	}
@@ -2631,6 +2685,7 @@ int snapshot_write_next(struct snapshot_handle *handle)
 	static struct chain_allocator ca;
 	int error = 0;
 
+next:
 	/* Check if we have already loaded the entire image */
 	if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages)
 		return 0;
@@ -2657,9 +2712,13 @@ int snapshot_write_next(struct snapshot_handle *handle)
 		if (error)
 			return error;
 
+		error = memory_bm_create(&zero_bm, GFP_ATOMIC, PG_ANY);
+		if (error)
+			return error;
+
 		hibernate_restore_protection_begin();
 	} else if (handle->cur <= nr_meta_pages + 1) {
-		error = unpack_orig_pfns(buffer, &copy_bm);
+		error = unpack_orig_pfns(buffer, &copy_bm, &zero_bm);
 		if (error)
 			return error;
 
@@ -2686,6 +2745,14 @@ int snapshot_write_next(struct snapshot_handle *handle)
 			handle->sync_read = 0;
 	}
 	handle->cur++;
+
+	/* Zero pages were not included in the image, memset it and move on. */
+	if ((handle->cur > nr_meta_pages + 1) &&
+			memory_bm_test_bit(&zero_bm, memory_bm_get_current(&orig_bm))) {
+		memset(handle->buffer, 0, PAGE_SIZE);
+		goto next;
+	}
+
 	return PAGE_SIZE;
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

