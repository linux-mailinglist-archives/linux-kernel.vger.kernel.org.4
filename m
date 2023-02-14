Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29453696D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjBNTCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjBNTCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:02:39 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64FB25964;
        Tue, 14 Feb 2023 11:02:37 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i26so265393ila.11;
        Tue, 14 Feb 2023 11:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBFO9aqhV38THoX2Fo6HR6/ykmrwIoxryt9YcUaBQeE=;
        b=PnRIpLuDmcy5yt6aiMl/PRAsAv2Us1E5Oo6e+hJclJqr5tKuSkkUot/8A+HdCQb84I
         03ZPQhb+lNhGg6q826jB6Ts/gEXF0darsyRG3YL/JjAX2Gt09f0PcPIiXJFZvrxPDfxZ
         W73SECriG9ixrM2P58H85Wz9W6lF4oYYgZHN+Zh+CMOq0MQkX1mzM+HZoaKvTN6rS7Fk
         etOzeUyrQsMDkBC4Yd/NrG82W9NQnqDMfYA1Njm0oOo4DOqOhPqIqKo6YiqCEjibcUGP
         ZQSrVhuPqYAufaucTwkOXohFcSD5ZDZ67Pf+Kj+4bUE7ayw4EXksBt/NGF5gslNWNZzL
         0B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBFO9aqhV38THoX2Fo6HR6/ykmrwIoxryt9YcUaBQeE=;
        b=aE5KF46WKhgjDVS8VHrHRRZwFMQIah3zJdV6APwG4weqXrrFALAAVp4pfBuCOiTEJh
         chCkVpHT6gOjxsXrua4/EKP0fzekqxa5OFRO02TAGJXSshZG9ZkifY+eDTl/IXuykccz
         eDleJmYALfF3XAFm4Jzmaf0PhXjplWY7IqKOz/VmAP91c2UbAm3n2Ff9Tep7GSQ0mwL2
         2vOOYc4lvnwq/8d2Zxtl9cHKWZJxQLgF+fKk5vCU7kyHAzcoZmAzYCNvaZ66KDNM9+I5
         PXgyfAf2SJElp2IZ9xtmlMdFQRQ9HpSAG/6zLMYMAbT/iVXq/gdia+uiiikJpDNfuxTJ
         2RKw==
X-Gm-Message-State: AO0yUKXL9XNPfWifPjF36TkUwLjr8BSD18Hh08tpBLKsb/l0Yael8AjR
        dkpkOTF1Z7XoZbYs6koYdjs=
X-Google-Smtp-Source: AK7set9u6j7La87WkLYk/UYILiOBFdY1iKGZoRD/y8K4y4KxyNTy+Te/VhP83riNGGKX7PeiklCynQ==
X-Received: by 2002:a05:6e02:12ed:b0:315:55cc:ff07 with SMTP id l13-20020a056e0212ed00b0031555ccff07mr3475691iln.4.1676401357094;
        Tue, 14 Feb 2023 11:02:37 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id r11-20020a056e0219cb00b0030c27c9eea4sm3608770ill.33.2023.02.14.11.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 11:02:36 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 1/5] mm: page_alloc: add API for bulk allocator with callback
Date:   Tue, 14 Feb 2023 11:02:17 -0800
Message-Id: <20230214190221.1156876-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230214190221.1156876-1-shy828301@gmail.com>
References: <20230214190221.1156876-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the bulk allocator support to pass pages via list or array,
but neither is suitable for some usecases, for example, dm-crypt, which
doesn't need a list, but array may be too big to fit on stack.  So
adding a new bulk allocator API, which passes in a callback function
that deal with the allocated pages.

The API defined in this patch will be used by the following patches.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/gfp.h | 21 +++++++++++++++++----
 mm/mempolicy.c      | 12 +++++++-----
 mm/page_alloc.c     | 21 +++++++++++++++------
 3 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 65a78773dcca..265c19b4822f 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -182,7 +182,9 @@ struct folio *__folio_alloc(gfp_t gfp, unsigned int order, int preferred_nid,
 unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 				nodemask_t *nodemask, int nr_pages,
 				struct list_head *page_list,
-				struct page **page_array);
+				struct page **page_array,
+				void (*cb)(struct page *, void *),
+				void *data);
 
 unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 				unsigned long nr_pages,
@@ -192,13 +194,15 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 static inline unsigned long
 alloc_pages_bulk_list(gfp_t gfp, unsigned long nr_pages, struct list_head *list)
 {
-	return __alloc_pages_bulk(gfp, numa_mem_id(), NULL, nr_pages, list, NULL);
+	return __alloc_pages_bulk(gfp, numa_mem_id(), NULL, nr_pages, list, NULL,
+				  NULL, NULL);
 }
 
 static inline unsigned long
 alloc_pages_bulk_array(gfp_t gfp, unsigned long nr_pages, struct page **page_array)
 {
-	return __alloc_pages_bulk(gfp, numa_mem_id(), NULL, nr_pages, NULL, page_array);
+	return __alloc_pages_bulk(gfp, numa_mem_id(), NULL, nr_pages, NULL, page_array,
+				  NULL, NULL);
 }
 
 static inline unsigned long
@@ -207,7 +211,16 @@ alloc_pages_bulk_array_node(gfp_t gfp, int nid, unsigned long nr_pages, struct p
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
 
-	return __alloc_pages_bulk(gfp, nid, NULL, nr_pages, NULL, page_array);
+	return __alloc_pages_bulk(gfp, nid, NULL, nr_pages, NULL, page_array,
+				  NULL, NULL);
+}
+
+static inline unsigned long
+alloc_pages_bulk_cb(gfp_t gfp, unsigned long nr_pages,
+		    void (*cb)(struct page *page, void *data), void *data)
+{
+	return __alloc_pages_bulk(gfp, numa_mem_id(), NULL, nr_pages, NULL, NULL,
+				  cb, data);
 }
 
 static inline void warn_if_node_offline(int this_node, gfp_t gfp_mask)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0919c7a719d4..00b2d5341790 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2318,12 +2318,13 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
 			nr_allocated = __alloc_pages_bulk(gfp,
 					interleave_nodes(pol), NULL,
 					nr_pages_per_node + 1, NULL,
-					page_array);
+					page_array, NULL, NULL);
 			delta--;
 		} else {
 			nr_allocated = __alloc_pages_bulk(gfp,
 					interleave_nodes(pol), NULL,
-					nr_pages_per_node, NULL, page_array);
+					nr_pages_per_node, NULL, page_array,
+					NULL, NULL);
 		}
 
 		page_array += nr_allocated;
@@ -2344,12 +2345,13 @@ static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
 	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 
 	nr_allocated  = __alloc_pages_bulk(preferred_gfp, nid, &pol->nodes,
-					   nr_pages, NULL, page_array);
+					   nr_pages, NULL, page_array,
+					   NULL, NULL);
 
 	if (nr_allocated < nr_pages)
 		nr_allocated += __alloc_pages_bulk(gfp, numa_node_id(), NULL,
 				nr_pages - nr_allocated, NULL,
-				page_array + nr_allocated);
+				page_array + nr_allocated, NULL, NULL);
 	return nr_allocated;
 }
 
@@ -2377,7 +2379,7 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 
 	return __alloc_pages_bulk(gfp, policy_node(gfp, pol, numa_node_id()),
 				  policy_nodemask(gfp, pol), nr_pages, NULL,
-				  page_array);
+				  page_array, NULL, NULL);
 }
 
 int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1113483fa6c5..d23b8e49a8cd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5402,22 +5402,27 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
  * @nr_pages: The number of pages desired on the list or array
  * @page_list: Optional list to store the allocated pages
  * @page_array: Optional array to store the pages
+ * @cb: Optional callback to handle the page
+ * @data: The parameter passed in by the callback
  *
  * This is a batched version of the page allocator that attempts to
  * allocate nr_pages quickly. Pages are added to page_list if page_list
- * is not NULL, otherwise it is assumed that the page_array is valid.
+ * is not NULL, or it is assumed if the page_array is valid, or it is
+ * passed to a callback if cb is valid.
  *
- * For lists, nr_pages is the number of pages that should be allocated.
+ * For lists and cb, nr_pages is the number of pages that should be allocated.
  *
  * For arrays, only NULL elements are populated with pages and nr_pages
  * is the maximum number of pages that will be stored in the array.
  *
- * Returns the number of pages on the list or array.
+ * Returns the number of pages on the list or array or consumed by cb.
  */
 unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			nodemask_t *nodemask, int nr_pages,
 			struct list_head *page_list,
-			struct page **page_array)
+			struct page **page_array,
+			void (*cb)(struct page *, void *),
+			void *data)
 {
 	struct page *page;
 	unsigned long __maybe_unused UP_flags;
@@ -5532,8 +5537,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		prep_new_page(page, 0, gfp, 0);
 		if (page_list)
 			list_add(&page->lru, page_list);
-		else
+		else if (page_array)
 			page_array[nr_populated] = page;
+		else
+			cb(page, data);
 		nr_populated++;
 	}
 
@@ -5554,8 +5561,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (page) {
 		if (page_list)
 			list_add(&page->lru, page_list);
-		else
+		else if (page_array)
 			page_array[nr_populated] = page;
+		else
+			cb(page, data);
 		nr_populated++;
 	}
 
-- 
2.39.0

