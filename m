Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D84740B70
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbjF1I2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjF1IZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:25:50 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26D2420F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:15:41 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2631fc29e8aso837082a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687940141; x=1690532141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMxqHAnxOZxMzgoGe7kH228DI7ZaEMF5Tfki0D7IS+4=;
        b=CBHWWOf90wfELDWCOMJatEAe0U62nsw8bLsy9S1NhivQJI6Lywv70VWvT5bZkk3l2X
         mQaa+A/h2dQkbPrsHOnNWR/Ckh/FYubF4CF0z0B43SHPxGW0HXFdFKIu+wf1+inIrRe8
         d8GzW1GZIOacvKMtIJcWpBJdjSVptgSwbg2yVIB6If8o8jhOsXWJ3ELpsK7EKCLHAMnI
         RP1jcr1RXKxgOUzVonG3/faDv1dh8iGUIZlgzaLdhO1ToOE6jRezTPPq3I81vu9deONt
         QheNLc5eNO2dvRjwwcMOXO6zARsbLXW7YuSXreuwcQ1kOVW+fxsAFlg8sxhNwSdNBxXb
         X+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940141; x=1690532141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMxqHAnxOZxMzgoGe7kH228DI7ZaEMF5Tfki0D7IS+4=;
        b=Db584hro4xX1W1UVfLw85I4Oc551RYw5XJJ/7565TmnabxARqI5MwDXXssW/VDR0QU
         117g5pqMGCQM2TsjN+DaWxXyDgAlJzEvRuDxbmzeVK5YW6wHSgtVVqEYqW5OkHNo2Qq3
         kht7BdU+xETBQFAdbLFo0xgjHUEMncvxaye0Mzljb0UMR+g/Fc+UfmZXEGTeoSquAPXa
         5BWzHlBFovEJQZDTnEdQNeUfDp+joviVgT7H464TpCOn38hTTsgLeWKFCc9fYQ94uYpK
         lm/8wY3WP7CdJ2WyNMiadPtRW6XXABFCSirp3JHeSgcEeRLEwDdSQNXbtlXEL/Kn0Pmj
         stiw==
X-Gm-Message-State: AC+VfDwoOgyBLwDfF5+E4TUYd8KKUw9rQAOtqhZNzxjWhQyT+Oz1NPKf
        uRQNR9hHeNV59ZDXP6wH16SZCWyiGsg=
X-Google-Smtp-Source: ACHHUZ7N2+Vdz5wzVt4qo3ORJk1cvXaFXFgrNn/dwhdlBeAqH0Ef2MJ/aZaUm1mJL36im1QJNi0z39SWTj8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6664:8bd3:57fd:c83a])
 (user=surenb job=sendgmr) by 2002:a25:ab82:0:b0:bb0:f056:cf43 with SMTP id
 v2-20020a25ab82000000b00bb0f056cf43mr7882151ybi.1.1687936687271; Wed, 28 Jun
 2023 00:18:07 -0700 (PDT)
Date:   Wed, 28 Jun 2023 00:17:55 -0700
In-Reply-To: <20230628071800.544800-1-surenb@google.com>
Mime-Version: 1.0
References: <20230628071800.544800-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628071800.544800-2-surenb@google.com>
Subject: [PATCH v4 1/6] swap: remove remnants of polling from read_swap_cache_async
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit [1] introduced IO polling support duding swapin to reduce
swap read latency for block devices that can be polled. However later
commit [2] removed polling support. Therefore it seems safe to remove
do_poll parameter in read_swap_cache_async and always call swap_readpage
with synchronous=false waiting for IO completion in folio_lock_or_retry.

[1] commit 23955622ff8d ("swap: add block io poll in swapin path")
[2] commit 9650b453a3d4 ("block: ignore RWF_HIPRI hint for sync dio")

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/madvise.c    |  4 ++--
 mm/swap.h       |  1 -
 mm/swap_state.c | 12 +++++-------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index b5ffbaf616f5..b1e8adf1234e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -215,7 +215,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 			continue;
 
 		page = read_swap_cache_async(entry, GFP_HIGHUSER_MOVABLE,
-					     vma, index, false, &splug);
+					     vma, index, &splug);
 		if (page)
 			put_page(page);
 	}
@@ -252,7 +252,7 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 		rcu_read_unlock();
 
 		page = read_swap_cache_async(swap, GFP_HIGHUSER_MOVABLE,
-					     NULL, 0, false, &splug);
+					     NULL, 0, &splug);
 		if (page)
 			put_page(page);
 
diff --git a/mm/swap.h b/mm/swap.h
index 7c033d793f15..8a3c7a0ace4f 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -46,7 +46,6 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				   struct vm_area_struct *vma,
 				   unsigned long addr,
-				   bool do_poll,
 				   struct swap_iocb **plug);
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				     struct vm_area_struct *vma,
diff --git a/mm/swap_state.c b/mm/swap_state.c
index b76a65ac28b3..a3839de71f3f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -517,15 +517,14 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
  */
 struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				   struct vm_area_struct *vma,
-				   unsigned long addr, bool do_poll,
-				   struct swap_iocb **plug)
+				   unsigned long addr, struct swap_iocb **plug)
 {
 	bool page_was_allocated;
 	struct page *retpage = __read_swap_cache_async(entry, gfp_mask,
 			vma, addr, &page_was_allocated);
 
 	if (page_was_allocated)
-		swap_readpage(retpage, do_poll, plug);
+		swap_readpage(retpage, false, plug);
 
 	return retpage;
 }
@@ -620,7 +619,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	struct swap_info_struct *si = swp_swap_info(entry);
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
-	bool do_poll = true, page_allocated;
+	bool page_allocated;
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address;
 
@@ -628,7 +627,6 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	if (!mask)
 		goto skip;
 
-	do_poll = false;
 	/* Read a page_cluster sized and aligned cluster around offset. */
 	start_offset = offset & ~mask;
 	end_offset = offset | mask;
@@ -660,7 +658,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
 	/* The page was likely read above, so no need for plugging here */
-	return read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll, NULL);
+	return read_swap_cache_async(entry, gfp_mask, vma, addr, NULL);
 }
 
 int init_swap_address_space(unsigned int type, unsigned long nr_pages)
@@ -825,7 +823,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 skip:
 	/* The page was likely read above, so no need for plugging here */
 	return read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
-				     ra_info.win == 1, NULL);
+				     NULL);
 }
 
 /**
-- 
2.41.0.162.gfafddb0af9-goog

