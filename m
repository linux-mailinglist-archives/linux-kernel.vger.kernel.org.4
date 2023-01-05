Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2068D65E525
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjAEFfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjAEFfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:35:42 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC5D4858B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 21:35:40 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id r18so23819837pgr.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 21:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNDbEU6GJSl4dMMRDfb+E6NT+uZQaENbR2FZEs35hTc=;
        b=UlX/lnwlf6fIQFIsZcBBD4u/IPlewAyXweh0bMynwmBpANcJ7jnMIod48XA9in383A
         1UK4jVAaY2SfCjbsggvlu9ABgeEPohET6f7Sd1wbMcEVoU+rDpvh1LLGoGnsjZnmxfXt
         OztWNCYcuYgxz/E1e+NlICj1UXsrLnCP3mY68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNDbEU6GJSl4dMMRDfb+E6NT+uZQaENbR2FZEs35hTc=;
        b=lrEJZ2/TP1UhioZ6HqrllQ9I5Z1VhWOhBYtdboeAQKwujPluYOMoRqEJ6CV1WkfSWr
         9R/GSjJfoFr7O0JN6lIAUr2eRb72zRsW+ldggFYmKFXV87esSYUNY6YE/jbTV4kRM4jK
         UDpdyzegYPScVbISVrxnI4umtJPDa/HF5yMctpaYk0bX0nY2ACEbU7cZghPvW+sFEY86
         XFGbcIIi6Tjd6Ra98NAf9HH7eFcd7bMnYcXFLLa9XR79eMRulogna6ejT3gW2g32egHW
         WLhiJ6RnDXuL299CxGeb8eV/PGckd+6H4guYyUf4cwwAg/aoyCQ4FxSAn3HxS9EXqh1L
         lfbA==
X-Gm-Message-State: AFqh2krNdHmDyl7eaVEwYVHVoWVhgYgF3VbqmgSan3ZZQcXBjXMhemWi
        oERPagLf2zrU8ObVRgT6pf1nVg==
X-Google-Smtp-Source: AMrXdXs8xtoHQAu80/AXDIApYwbIuB3LIkfP6hr+4B2fJbDkMV6pCTZqhjjdA4EnSCvzd9059skuwg==
X-Received: by 2002:a05:6a00:2281:b0:581:a8dc:8f95 with SMTP id f1-20020a056a00228100b00581a8dc8f95mr34967574pfe.12.1672896940075;
        Wed, 04 Jan 2023 21:35:40 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:da84:4bce:bb29:7dea])
        by smtp.gmail.com with ESMTPSA id v27-20020aa799db000000b00577c5915138sm2036855pfi.128.2023.01.04.21.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 21:35:39 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 3/4] zsmalloc: make zspage chain size configurable
Date:   Thu,  5 Jan 2023 14:35:09 +0900
Message-Id: <20230105053510.1819862-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230105053510.1819862-1-senozhatsky@chromium.org>
References: <20230105053510.1819862-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hard coded limit on the maximum number of physical
pages per-zspage.

This will allow tuning of zsmalloc pool as zspage chain
size changes `pages per-zspage` and `objects per-zspage`
characteristics of size classes which also affects size
classes clustering (the way size classes are merged).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../admin-guide/blockdev/zsmalloc.rst         | 157 ++++++++++++++++++
 mm/Kconfig                                    |  19 +++
 mm/zsmalloc.c                                 |  15 +-
 3 files changed, 180 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/admin-guide/blockdev/zsmalloc.rst

diff --git a/Documentation/admin-guide/blockdev/zsmalloc.rst b/Documentation/admin-guide/blockdev/zsmalloc.rst
new file mode 100644
index 000000000000..2e238afb1b4b
--- /dev/null
+++ b/Documentation/admin-guide/blockdev/zsmalloc.rst
@@ -0,0 +1,157 @@
+========================================
+zsmalloc allocator
+========================================
+
+Internals
+---------
+
+zsmalloc has 255 size classes. Size classes hold a number of zspages, each
+zspage can consist of up to ZSMALLOC_CHAIN_SIZE physical (0 order) pages.
+The exact (most optimal) zspage chain size is calculated for each size class
+during zsmalloc pool creation (see calculate_zspage_chain_size()).
+
+As a reasonable optimization, zsmalloc merges size classes that have
+similar characteristics: number of pages per zspage and number of
+objects zspage can store.
+
+For example, let's look at the following size classes:::
+
+class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
+..
+   94  1536           0            0             0          0          0                3        0
+  100  1632           0            0             0          0          0                2        0
+..
+
+Size classes #95-99 are merged with size class #100. That is, each time
+we store an object of size, say, 1568 bytes instead of using class #96
+we end up storing it in size class #100. Class #100 is for objects of
+1632 bytes in size, hence every 1568 bytes object wastes 1632-1568 bytes.
+Class #100 zspages consist of 2 physical pages and can hold 5 objects.
+When we need to store, say, 13 objects of size 1568 we end up allocating
+three zspages; in other words, 6 physical pages.
+
+However, if we'll look closer at size class #96 (which should hold objects
+of size 1568 bytes) and trace calculate_zspage_chain_size():::
+
+    pages per zspage      wasted bytes     used%
+           1                  960           76
+           2                  352           95
+           3                 1312           89
+           4                  704           95
+           5                   96           99
+
+We'd notice that the most optimal zspage configuration for this class is
+when it consists of 5 physical pages. A 5 page class #96 configuration
+would store 13 objects of size 1568 in a single zspage, allocating 5 physical
+pages, as opposed to 6 physical pages that class #100 would allocate otherwise.
+
+A larger zspage chain size for class #96 also changes its key characteristics:
+pages per-zspage and objects per-zspage. As a result we merge less classes. In
+other words classes are grouped in a more compact way, which decreases memory
+wastage.
+
+Let's take a closer look at the bottom of /sys/kernel/debug/zsmalloc/zramX/classes:::
+
+class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
+..
+  202  3264           0            0             0          0          0                4        0
+  254  4096           0            0             0          0          0                1        0
+..
+
+For exactly same reason - maximum 4 pages per zspage - the last non-huge
+size class is #202, which stores objects of size 3264 bytes. Any object
+larger than 3264 bytes, hence, is considered to be huge and lands in size
+class #254, which uses a whole physical page to store every object (objects
+in huge classes don't share physical pages).
+
+Another consequence of larger zspages chain sizes is that we move the huge
+size class watermark up and as a result have less huge classes and store
+large objects in a more compact way.
+
+For zspage chain size of 8, huge class watermark becomes 3632 bytes:::
+
+class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
+..
+  202  3264           0            0             0          0          0                4        0
+  211  3408           0            0             0          0          0                5        0
+  217  3504           0            0             0          0          0                6        0
+  222  3584           0            0             0          0          0                7        0
+  225  3632           0            0             0          0          0                8        0
+  254  4096           0            0             0          0          0                1        0
+..
+
+For zspage chain size of 16, huge class watermark becomes 3840 bytes:::
+
+class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
+..
+  202  3264           0            0             0          0          0                4        0
+  206  3328           0            0             0          0          0               13        0
+  207  3344           0            0             0          0          0                9        0
+  208  3360           0            0             0          0          0               14        0
+  211  3408           0            0             0          0          0                5        0
+  212  3424           0            0             0          0          0               16        0
+  214  3456           0            0             0          0          0               11        0
+  217  3504           0            0             0          0          0                6        0
+  219  3536           0            0             0          0          0               13        0
+  222  3584           0            0             0          0          0                7        0
+  223  3600           0            0             0          0          0               15        0
+  225  3632           0            0             0          0          0                8        0
+  228  3680           0            0             0          0          0                9        0
+  230  3712           0            0             0          0          0               10        0
+  232  3744           0            0             0          0          0               11        0
+  234  3776           0            0             0          0          0               12        0
+  235  3792           0            0             0          0          0               13        0
+  236  3808           0            0             0          0          0               14        0
+  238  3840           0            0             0          0          0               15        0
+  254  4096           0            0             0          0          0                1        0
+..
+
+Overall the combined zspage chain size effect on zsmalloc pool configuration:::
+
+pages per zspage   number of size classes (clusters)   huge size class watermark
+       4                        69                               3264
+       5                        86                               3408
+       6                        93                               3504
+       7                       112                               3584
+       8                       123                               3632
+       9                       140                               3680
+      10                       143                               3712
+      11                       159                               3744
+      12                       164                               3776
+      13                       180                               3792
+      14                       183                               3808
+      15                       188                               3840
+      16                       191                               3840
+
+A synthetic test:::
+
+CONFIG_ZSMALLOC_CHAIN_SIZE=4
+
+zsmalloc classes stats
+ class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
+ ..
+ Total                13           51        413836     412973     159955                         3
+
+zram mm_stat
+1691783168 628083717 655175680        0 655175680       60        0    34048    34049
+
+CONFIG_ZSMALLOC_CHAIN_SIZE=8
+
+zsmalloc classes stats
+ class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
+ ..
+ Total                18           87        414852     412978     156666                         0
+
+zram mm_stat
+1691803648 627793930 641703936        0 641703936       60        0    33591    33591
+
+Note that for the same amount of data zsmalloc uses less physical pages: down
+to 156666 from 159955, and maximum zsmalloc pool memory usage also went down
+from 655175680 to 641703936 bytes.
+
+The obvious downside of larger zspage chains is that some zspages require
+more physical pages, which can, in theory, increase system memory pressure
+in cases when zspool suffers from heavy internal fragmentation and zspool
+compaction cannot relocate objects and release some zspages. In such cases
+users are advised to lower zspage chain size limit (CONFIG_ZSMALLOC_CHAIN_SIZE
+option).
diff --git a/mm/Kconfig b/mm/Kconfig
index ff7b209dec05..995a7c4083c2 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -191,6 +191,25 @@ config ZSMALLOC_STAT
 	  information to userspace via debugfs.
 	  If unsure, say N.
 
+config ZSMALLOC_CHAIN_SIZE
+	int "Maximum number of physical pages per-zspage"
+	default 4
+	range 1 16
+	depends on ZSMALLOC
+	help
+	  Each zmalloc page (zspage) can consist of 1 or more physical
+	  (0 order) non contiguous pages. This option sets the upper
+	  (hard) limit on that number.
+
+	  The exact zspage chain size is calculated for each size class
+	  individually during pool initialisation. Changing this results
+	  in different size classes characteristics (pages per-zspage,
+	  objects per-zspage) which in turn results in different pool
+	  configurations: zsmalloc merges size classes that share key
+	  characteristics.
+
+	  Please read zsmalloc documentation for more details.
+
 menu "SLAB allocator options"
 
 choice
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 9a0f1963b803..34ba97d1175f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -73,13 +73,6 @@
  */
 #define ZS_ALIGN		8
 
-/*
- * A single 'zspage' is composed of up to 2^N discontiguous 0-order (single)
- * pages. ZS_MAX_ZSPAGE_ORDER defines upper limit on N.
- */
-#define ZS_MAX_ZSPAGE_ORDER 2
-#define ZS_MAX_PAGES_PER_ZSPAGE (_AC(1, UL) << ZS_MAX_ZSPAGE_ORDER)
-
 #define ZS_HANDLE_SIZE (sizeof(unsigned long))
 
 /*
@@ -126,7 +119,7 @@
 #define MAX(a, b) ((a) >= (b) ? (a) : (b))
 /* ZS_MIN_ALLOC_SIZE must be multiple of ZS_ALIGN */
 #define ZS_MIN_ALLOC_SIZE \
-	MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> OBJ_INDEX_BITS))
+	MAX(32, (CONFIG_ZSMALLOC_CHAIN_SIZE << PAGE_SHIFT >> OBJ_INDEX_BITS))
 /* each chunk includes extra space to keep handle */
 #define ZS_MAX_ALLOC_SIZE	PAGE_SIZE
 
@@ -1078,7 +1071,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 					gfp_t gfp)
 {
 	int i;
-	struct page *pages[ZS_MAX_PAGES_PER_ZSPAGE];
+	struct page *pages[CONFIG_ZSMALLOC_CHAIN_SIZE];
 	struct zspage *zspage = cache_alloc_zspage(pool, gfp);
 
 	if (!zspage)
@@ -1910,7 +1903,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 				struct page *newpage, struct page *oldpage)
 {
 	struct page *page;
-	struct page *pages[ZS_MAX_PAGES_PER_ZSPAGE] = {NULL, };
+	struct page *pages[CONFIG_ZSMALLOC_CHAIN_SIZE] = {NULL, };
 	int idx = 0;
 
 	page = get_first_page(zspage);
@@ -2293,7 +2286,7 @@ static int calculate_zspage_chain_size(int class_size)
 	if (is_power_of_2(class_size))
 		return chain_size;
 
-	for (i = 1; i <= ZS_MAX_PAGES_PER_ZSPAGE; i++) {
+	for (i = 1; i <= CONFIG_ZSMALLOC_CHAIN_SIZE; i++) {
 		int waste;
 
 		waste = (i * PAGE_SIZE) % class_size;
-- 
2.39.0.314.g84b9a713c41-goog

