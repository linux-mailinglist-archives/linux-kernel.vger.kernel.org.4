Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096EE661CC5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjAIDjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbjAIDjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:39:18 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76132B1C6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:39:17 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o13so3952563pjg.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 19:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQbjoovHIbft3RuQS8+IrwvvTG2S26k6XMimw8ssuDA=;
        b=SCSfs735viHd2ONTHdFuB/QRBfu12D1iYUKzZBxHfrk9umA28I3o96DV9p4KIxDGdb
         Vg3nOZCj57Scd2L08A4WTyzmg1XyEJtBkeaj21D6FkT4iIlPHc+TFBBztPZrgv8WYhcl
         Htplhe/4VymOfMi14VoVszZGZfHxS5aiKLEHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQbjoovHIbft3RuQS8+IrwvvTG2S26k6XMimw8ssuDA=;
        b=kl3sF9I0+d3lPlIbB2Q+KhDFXjZR8qqlEkHSxPZa9PE8aID3okaIsdEDv0iE5WKPK1
         uYR2gBGvfImY0k9rR6VORTYtQQbF5MQDIIMfQK3nt1pF7O1q1R3EFBShi1/XkaA46Vox
         TlOp7a4/6lwDc9P3koU/ppLzH6mbSMJOsUdUgcDzyw2v/6aVV0cDNCpOgEPIUvSLnrW8
         a9Vn+n1nKOENl4TtS+hA9mdRnoD0ptp4q6GWBNGD+w6CTm9NvRfqk3mhh7v1xGc7eeo/
         2dsZm5gBMgk+Ehw6LegTsDG/0jfoP7Yo560SzjXMErfdLhgm7i7JDZfSYu4YOngfgFBM
         5a1Q==
X-Gm-Message-State: AFqh2ko8cGmJ6VnMQRTUdYZiTMmOKNtN0WvBa5TaDvW8K/FTkYkSESWx
        VulCO45Z6sxt6Wm4s+/PCWfo1g==
X-Google-Smtp-Source: AMrXdXtj8xLVO107KV9BITn1xookzhwU9dCBIXBCpCmlSedliUr6hztw2Bnod2xV5fqJGXwuK1omdQ==
X-Received: by 2002:a05:6a20:2d1e:b0:af:6f24:b154 with SMTP id g30-20020a056a202d1e00b000af6f24b154mr81534280pzl.60.1673235556895;
        Sun, 08 Jan 2023 19:39:16 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5ec1:f8d2:ce47:7ddc])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e80500b00189529ed580sm4896685plg.60.2023.01.08.19.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 19:39:16 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 3/4] zsmalloc: make zspage chain size configurable
Date:   Mon,  9 Jan 2023 12:38:37 +0900
Message-Id: <20230109033838.2779902-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230109033838.2779902-1-senozhatsky@chromium.org>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
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
 Documentation/mm/zsmalloc.rst | 168 ++++++++++++++++++++++++++++++++++
 mm/Kconfig                    |  19 ++++
 mm/zsmalloc.c                 |  15 +--
 3 files changed, 191 insertions(+), 11 deletions(-)

diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
index 6e79893d6132..40323c9b39d8 100644
--- a/Documentation/mm/zsmalloc.rst
+++ b/Documentation/mm/zsmalloc.rst
@@ -80,3 +80,171 @@ Similarly, we assign zspage to:
 * ZS_ALMOST_FULL  when n > N / f
 * ZS_EMPTY        when n == 0
 * ZS_FULL         when n == N
+
+
+Internals
+=========
+
+zsmalloc has 255 size classes, each of which can hold a number of zspages.
+Each zspage can contain up to ZSMALLOC_CHAIN_SIZE physical (0-order) pages.
+The optimal zspage chain size for each size class is calculated during the
+creation of the zsmalloc pool (see calculate_zspage_chain_size()).
+
+As an optimization, zsmalloc merges size classes that have similar
+characteristics in terms of the number of pages per zspage and the number
+of objects that each zspage can store.
+
+For instance, consider the following size classes:::
+
+  class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
+  ...
+     94  1536           0            0             0          0          0                3        0
+    100  1632           0            0             0          0          0                2        0
+  ...
+
+
+Size classes #95-99 are merged with size class #100. This means that when we
+need to store an object of size, say, 1568 bytes, we end up using size class
+#100 instead of size class #96. Size class #100 is meant for objects of size
+1632 bytes, so each object of size 1568 bytes wastes 1632-1568=64 bytes.
+
+Size class #100 consists of zspages with 2 physical pages each, which can
+hold a total of 5 objects. If we need to store 13 objects of size 1568, we
+end up allocating three zspages, or 6 physical pages.
+
+However, if we take a closer look at size class #96 (which is meant for
+objects of size 1568 bytes) and trace `calculate_zspage_chain_size()`, we
+find that the most optimal zspage configuration for this class is a chain
+of 5 physical pages:::
+
+    pages per zspage      wasted bytes     used%
+           1                  960           76
+           2                  352           95
+           3                 1312           89
+           4                  704           95
+           5                   96           99
+
+This means that a class #96 configuration with 5 physical pages can store 13
+objects of size 1568 in a single zspage, using a total of 5 physical pages.
+This is more efficient than the class #100 configuration, which would use 6
+physical pages to store the same number of objects.
+
+As the zspage chain size for class #96 increases, its key characteristics
+such as pages per-zspage and objects per-zspage also change. This leads to
+dewer class mergers, resulting in a more compact grouping of classes, which
+reduces memory wastage.
+
+Let's take a closer look at the bottom of `/sys/kernel/debug/zsmalloc/zramX/classes`:::
+
+  class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
+  ...
+    202  3264           0            0             0          0          0                4        0
+    254  4096           0            0             0          0          0                1        0
+  ...
+
+Size class #202 stores objects of size 3264 bytes and has a maximum of 4 pages
+per zspage. Any object larger than 3264 bytes is considered huge and belongs
+to size class #254, which stores each object in its own physical page (objects
+in huge classes do not share pages).
+
+Increasing the size of the chain of zspages also results in a higher watermark
+for the huge size class and fewer huge classes overall. This allows for more
+efficient storage of large objects.
+
+For zspage chain size of 8, huge class watermark becomes 3632 bytes:::
+
+  class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
+  ...
+    202  3264           0            0             0          0          0                4        0
+    211  3408           0            0             0          0          0                5        0
+    217  3504           0            0             0          0          0                6        0
+    222  3584           0            0             0          0          0                7        0
+    225  3632           0            0             0          0          0                8        0
+    254  4096           0            0             0          0          0                1        0
+  ...
+
+For zspage chain size of 16, huge class watermark becomes 3840 bytes:::
+
+  class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
+  ...
+    202  3264           0            0             0          0          0                4        0
+    206  3328           0            0             0          0          0               13        0
+    207  3344           0            0             0          0          0                9        0
+    208  3360           0            0             0          0          0               14        0
+    211  3408           0            0             0          0          0                5        0
+    212  3424           0            0             0          0          0               16        0
+    214  3456           0            0             0          0          0               11        0
+    217  3504           0            0             0          0          0                6        0
+    219  3536           0            0             0          0          0               13        0
+    222  3584           0            0             0          0          0                7        0
+    223  3600           0            0             0          0          0               15        0
+    225  3632           0            0             0          0          0                8        0
+    228  3680           0            0             0          0          0                9        0
+    230  3712           0            0             0          0          0               10        0
+    232  3744           0            0             0          0          0               11        0
+    234  3776           0            0             0          0          0               12        0
+    235  3792           0            0             0          0          0               13        0
+    236  3808           0            0             0          0          0               14        0
+    238  3840           0            0             0          0          0               15        0
+    254  4096           0            0             0          0          0                1        0
+  ...
+
+Overall the combined zspage chain size effect on zsmalloc pool configuration:::
+
+  pages per zspage   number of size classes (clusters)   huge size class watermark
+         4                        69                               3264
+         5                        86                               3408
+         6                        93                               3504
+         7                       112                               3584
+         8                       123                               3632
+         9                       140                               3680
+        10                       143                               3712
+        11                       159                               3744
+        12                       164                               3776
+        13                       180                               3792
+        14                       183                               3808
+        15                       188                               3840
+        16                       191                               3840
+
+
+A synthetic test
+----------------
+
+zram as a build artifacts storage (Linux kernel compilation).
+
+* `CONFIG_ZSMALLOC_CHAIN_SIZE=4`
+
+  zsmalloc classes stats:::
+
+    class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
+    ...
+    Total                13           51        413836     412973     159955                         3
+
+  zram mm_stat:::
+
+   1691783168 628083717 655175680        0 655175680       60        0    34048    34049
+
+
+* `CONFIG_ZSMALLOC_CHAIN_SIZE=8`
+
+  zsmalloc classes stats:::
+
+    class  size almost_full almost_empty obj_allocated   obj_used pages_used pages_per_zspage freeable
+    ...
+    Total                18           87        414852     412978     156666                         0
+
+  zram mm_stat:::
+
+    1691803648 627793930 641703936        0 641703936       60        0    33591    33591
+
+Using larger zspage chains may result in using fewer physical pages, as seen
+in the example where the number of physical pages used decreased from 159955
+to 156666, at the same time maximum zsmalloc pool memory usage went down from
+655175680 to 641703936 bytes.
+
+However, this advantage may be offset by the potential for increased system
+memory pressure (as some zspages have larger chain sizes) in cases where there
+is heavy internal fragmentation and zspool compaction is unable to relocate
+objects and release zspages. In these cases, it is recommended to decrease
+the limit on the size of the zspage chains (as specified by the
+CONFIG_ZSMALLOC_CHAIN_SIZE option).
diff --git a/mm/Kconfig b/mm/Kconfig
index 4eb4afa53e6d..5b2863de4be5 100644
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
+	  This option sets the upper limit on the number of physical pages
+	  that a zmalloc page (zspage) can consist of. The optimal zspage
+	  chain size is calculated for each size class during the
+	  initialization of the pool.
+
+	  Changing this option can alter the characteristics of size classes,
+	  such as the number of pages per zspage and the number of objects
+	  per zspage. This can also result in different configurations of
+	  the pool, as zsmalloc merges size classes with similar
+	  characteristics.
+
+	  For more information, see zsmalloc documentation.
+
 menu "SLAB allocator options"
 
 choice
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index ee8431784998..77a8746a453d 100644
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
@@ -2290,7 +2283,7 @@ static int calculate_zspage_chain_size(int class_size)
 	if (is_power_of_2(class_size))
 		return chain_size;
 
-	for (i = 1; i <= ZS_MAX_PAGES_PER_ZSPAGE; i++) {
+	for (i = 1; i <= CONFIG_ZSMALLOC_CHAIN_SIZE; i++) {
 		int waste;
 
 		waste = (i * PAGE_SIZE) % class_size;
-- 
2.39.0.314.g84b9a713c41-goog

