Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD77728E9E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 05:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjFIDez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 23:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbjFIDev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 23:34:51 -0400
X-Greylist: delayed 513 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Jun 2023 20:34:45 PDT
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7AF930FD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 20:34:45 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.218:59564.1727155665
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [172.18.0.218])
        by chinatelecom.cn (HERMES) with SMTP id CE8C72800B7;
        Fri,  9 Jun 2023 11:26:04 +0800 (CST)
X-189-SAVE-TO-SEND: +liuq131@chinatelecom.cn
Received: from  ([36.111.64.85])
        by app0025 with ESMTP id b3a94a8e8d4e468aa458479e5c11cc05 for akpm@linux-foundation.org;
        Fri, 09 Jun 2023 11:26:07 CST
X-Transaction-ID: b3a94a8e8d4e468aa458479e5c11cc05
X-Real-From: liuq131@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Sender: liuq131@chinatelecom.cn
From:   liuq <liuq131@chinatelecom.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        liuq <liuq131@chinatelecom.cn>
Subject: [PATCH] mm/min_free_kbytes: modify min_free_kbytes calculation rules
Date:   Fri,  9 Jun 2023 11:25:52 +0800
Message-Id: <20230609032552.218010-1-liuq131@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current calculation of min_free_kbytes only uses ZONE_DMA and
ZONE_NORMAL pages,but the ZONE_MOVABLE zone->_watermark[WMARK_MIN]
will also divide part of min_free_kbytes.This will cause the min
watermark of ZONE_NORMAL to be too small in the presence of ZONE_MOVEABLE.

Signed-off-by: liuq <liuq131@chinatelecom.cn>
---
 include/linux/mm.h |  1 +
 mm/khugepaged.c    |  2 +-
 mm/page_alloc.c    | 15 ++++++++++++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cf3d0d673f6b..1f91d035bcaf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -863,6 +863,7 @@ void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
 
 unsigned long nr_free_buffer_pages(void);
+unsigned long nr_free_pagecache_pages(void);
 
 /*
  * Compound pages have a destructor function.  Provide a
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 16be62d493cd..6632264b951c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2342,7 +2342,7 @@ static void set_recommended_min_free_kbytes(void)
 
 	/* don't ever allow to reserve more than 5% of the lowmem */
 	recommended_min = min(recommended_min,
-			      (unsigned long) nr_free_buffer_pages() / 20);
+			      (unsigned long) nr_free_pagecache_pages() / 20);
 	recommended_min <<= (PAGE_SHIFT-10);
 
 	if (recommended_min > min_free_kbytes) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3df0485..489b564526dd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5775,6 +5775,19 @@ unsigned long nr_free_buffer_pages(void)
 }
 EXPORT_SYMBOL_GPL(nr_free_buffer_pages);
 
+/**
+ * nr_free_pagecache_pages - count number of pages beyond high watermark
+ *
+ * nr_free_pagecache_pages() counts the number of pages which are beyond the
+ * high watermark within all zones.
+ *
+ * Return: number of pages beyond high watermark within all zones.
+ */
+unsigned long nr_free_pagecache_pages(void)
+{
+	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER_MOVABLE));
+}
+
 static inline void show_node(struct zone *zone)
 {
 	if (IS_ENABLED(CONFIG_NUMA))
@@ -8651,7 +8664,7 @@ void calculate_min_free_kbytes(void)
 	unsigned long lowmem_kbytes;
 	int new_min_free_kbytes;
 
-	lowmem_kbytes = nr_free_buffer_pages() * (PAGE_SIZE >> 10);
+	lowmem_kbytes = nr_free_pagecache_pages() * (PAGE_SIZE >> 10);
 	new_min_free_kbytes = int_sqrt(lowmem_kbytes * 16);
 
 	if (new_min_free_kbytes > user_min_free_kbytes)
-- 
2.27.0

