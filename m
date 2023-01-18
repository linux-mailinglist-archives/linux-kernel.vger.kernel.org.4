Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BC167223A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjARP5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjARP5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:57:11 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365E459567
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:52:55 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id i185so36182312vsc.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=e11pkTomTpxVYwWB/x5AvRv96kjActm3EnkRXWTwwk8=;
        b=AqBeL7mq8lZay/paXXhXRpjjUJt08FG0+VU0ZB+QGYdRQOFLPBRNqL3f2d/9j0is0u
         nC5nf83+Zr3iIdMxFZ5v+PbCMljIQEZ4/YitGIpzM0Qr4OAyiDmJJnwkl/gcWLDtVPof
         y5M4pF3/e4Ch2yyIgXDvGLtEkimCCIq6390DO77T+SPfBnM7ooO9uB4bz/g7YzUONXzy
         oRLmErk8+FAC7Qp5rgxRpmal6VR2HL4vzdyfJ+xbfD8OhrlbjVi0p/1hOiYJ4JGkUsVc
         YQqunb6tYi3yrUadma6zoTzCssM7MmkzMpkH1e6janr+4wU5yfrR+UDySpft6rNGMZYm
         QrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e11pkTomTpxVYwWB/x5AvRv96kjActm3EnkRXWTwwk8=;
        b=QvnvviM7oRrdBz8vV+EdrPzt+u550BepLclUlLCJ+BNMpJFujVHAG3WEuLA56pAqO6
         /R2MUnr4/12Ys7L9+Rpjk3AyBo9MKcPVHeNpQx4a0MdKTW0as6kbQqgYUnp5vdpGo+7i
         ptkMYiiPqa2ro6uLK7mcoMV42Iw/H+JfGF5ssvRF6lVqO3bzRuDf7whuHWoOz/6qp16E
         qXxPC4TJr1AYflqx46M5WB0oENsuVj8yeafw23lPKh0Qo9WX8DSWb1DvDx8wlNXva7gm
         91pQgbWWwM/y4LHbJuNMcmyqRC23gYzo5PNzbA60se8jUfRSMsEA7ybfq82vsqVxJW2U
         1h7Q==
X-Gm-Message-State: AFqh2kqt9k1iZZtAf0f5JInvYyOHxxVNf5ZUDmUtyydN8cat2dNywIF7
        g+4ncrgEaqAdJfBAsKajAAeE0w==
X-Google-Smtp-Source: AMrXdXtDAtxod2Jf4LXcipYYXHgxbN+j/hk/GhDfBM+ha9kvUk5VE4+MCQIKH0XfpAJYh1JMjv3T4Q==
X-Received: by 2002:a05:6102:941:b0:3ce:b848:d673 with SMTP id a1-20020a056102094100b003ceb848d673mr5109816vsi.32.1674057174121;
        Wed, 18 Jan 2023 07:52:54 -0800 (PST)
Received: from soleen.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id j9-20020a05620a288900b006f9f714cb6asm21935932qkp.50.2023.01.18.07.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:52:53 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, rppt@kernel.org,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        david@redhat.com, quic_charante@quicinc.com,
        lizhe.67@bytedance.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2] mm/page_ext: init page_ext early if there are no deferred struct pages
Date:   Wed, 18 Jan 2023 15:52:51 +0000
Message-Id: <20230118155251.2522985-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_ext must be initialized after all struct pages are initialized.
Therefore, page_ext is initialized after page_alloc_init_late(), and
can optionally be initialized earlier via early_page_ext kernel
parameter which as a side effect also disables deferred struct pages.

Allow to automatically init page_ext early when there are no deferred
struct pages in order to be able to use page_ext during kernel boot
and track for example page allocations early.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ext.h | 2 ++
 init/main.c              | 6 +++---
 mm/page_alloc.c          | 6 +++++-
 mm/page_ext.c            | 2 +-
 4 files changed, 11 insertions(+), 5 deletions(-)

Changelog:
v2: Fixed build issue with CONFIG_PAGE_EXTENSION=n

diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
index 67314f648aeb..bc2e39090a1f 100644
--- a/include/linux/page_ext.h
+++ b/include/linux/page_ext.h
@@ -29,6 +29,8 @@ struct page_ext_operations {
 	bool need_shared_flags;
 };
 
+extern bool deferred_struct_pages;
+
 #ifdef CONFIG_PAGE_EXTENSION
 
 /*
diff --git a/init/main.c b/init/main.c
index e1c3911d7c70..64cd2ff051c4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -855,8 +855,8 @@ static void __init mm_init(void)
 	pgtable_init();
 	debug_objects_mem_init();
 	vmalloc_init();
-	/* Should be run after vmap initialization */
-	if (early_page_ext_enabled())
+	/* If no deferred init page_ext now, as vmap is fully initialized */
+	if (!deferred_struct_pages)
 		page_ext_init();
 	/* Should be run before the first non-init thread is created */
 	init_espfix_bsp();
@@ -1628,7 +1628,7 @@ static noinline void __init kernel_init_freeable(void)
 	padata_init();
 	page_alloc_init_late();
 	/* Initialize page ext after all struct pages are initialized. */
-	if (!early_page_ext_enabled())
+	if (deferred_struct_pages)
 		page_ext_init();
 
 	do_basic_setup();
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 99ebb08dc3f2..717f12e83b85 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -430,6 +430,8 @@ EXPORT_SYMBOL(nr_online_nodes);
 
 int page_group_by_mobility_disabled __read_mostly;
 
+bool deferred_struct_pages __meminitdata;
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 /*
  * During boot we initialize deferred pages on-demand, as needed, but once
@@ -6803,8 +6805,10 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 		if (context == MEMINIT_EARLY) {
 			if (overlap_memmap_init(zone, &pfn))
 				continue;
-			if (defer_init(nid, pfn, zone_end_pfn))
+			if (defer_init(nid, pfn, zone_end_pfn)) {
+				deferred_struct_pages = true;
 				break;
+			}
 		}
 
 		page = pfn_to_page(pfn);
diff --git a/mm/page_ext.c b/mm/page_ext.c
index e2c22ffdbb81..dc1626be458b 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -92,7 +92,7 @@ unsigned long page_ext_size;
 static unsigned long total_usage;
 static struct page_ext *lookup_page_ext(const struct page *page);
 
-bool early_page_ext;
+bool early_page_ext __meminitdata;
 static int __init setup_early_page_ext(char *str)
 {
 	early_page_ext = true;
-- 
2.39.0.314.g84b9a713c41-goog

