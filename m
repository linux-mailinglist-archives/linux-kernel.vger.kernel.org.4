Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632E56D1825
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCaHIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjCaHIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:08:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE5191F1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:08:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k199-20020a2524d0000000b00b7f3a027e50so6307547ybk.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680246507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h76ftpfDeW349+865+C5AwRuwTE+LoTxu1YkhFCOpyA=;
        b=I416KE3jHWRA3QMCGUkW1ivXoY9bfwY9Wzs6ajryoP118g2lYRPUBdBs95KIolJuD5
         Ethf/48kB/t99e0lZyDxt6Gzswbs6SgDsOW6Io3pxcCrt46SeVq6PdqDGwpRXRm4mIIO
         6/7VlzMrDBNDNFPKTqzatAKxYD7Ykdp+wnADaTixMb98ZnvPZpzngRlNsTbR1eAqMGin
         OVVTVCUinbAA7DzoMhdK0NIZtCVKH1xuFjJniN2MkWrVvFG9yuSRV9r8Ey4Yt6n+qENf
         XWcPXE7St5/tC16GieQD7BtKre3OtF+VNgjQao02pAU8vmXwS+dEsHk1Tc7dr9q0a6L7
         3Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680246507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h76ftpfDeW349+865+C5AwRuwTE+LoTxu1YkhFCOpyA=;
        b=TFJVyzYQDnnFzBo7gZ3rAvFGiD0Vt6SsLK+MFrUMxtU5DoIbIYThaa1SAccuE2o+aB
         Lkn87EPpQJIYkGKmp6WVsWu4FHFGb9gxYUYhZ2SpZYCnzZaiy9xAIyeRtek5t/2fCzJw
         Md8gez6jNaYTnzZKAY87++CHbFHNyXTX4o4rwKXWARWHNbOc305o4FwirDpUFDZfcvp3
         9IzmHXUF51fPxvIe/GFTiZTlpKilYYfVPXLj0s4XWb34C3zgB1G48n+1fXJZvdpRw13y
         lQhNZRskKPj5EYyAHZSjfB8Broevb7pLwiioAe5e1sr3hmvTZ3JqnXpKtf8rFqwWYSW9
         kdxw==
X-Gm-Message-State: AAQBX9efWI20wpV4+UBb2bIgYOW6OnLiJj0V6dNirEq2VNdrv4YYnx+I
        kXIY9HynBPgyi0TzqfJEKywauVYvDQ+/EqH9
X-Google-Smtp-Source: AKy350Y8WGtJv5wxaytzfKnKlxt10iAfzKZBoBbyFn4WF437gd6aXmlYDb8KK6m+3I5auaqd4e3K7Ex+rHzIvu5H
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:b617:0:b0:541:7f69:aa8b with SMTP
 id u23-20020a81b617000000b005417f69aa8bmr12492986ywh.5.1680246506838; Fri, 31
 Mar 2023 00:08:26 -0700 (PDT)
Date:   Fri, 31 Mar 2023 07:08:18 +0000
In-Reply-To: <20230331070818.2792558-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230331070818.2792558-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230331070818.2792558-4-yosryahmed@google.com>
Subject: [PATCH v3 3/3] mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We keep track of different types of reclaimed pages through
reclaim_state->reclaimed, and we add them to the reported number of
reclaimed pages. For non-memcg reclaim, this makes sense. For memcg
reclaim, we have no clue if those pages are charged to the memcg under
reclaim.

Slab pages are shared by different memcgs, so a freed slab page may have
only been partially charged to the memcg under reclaim. The same goes
for clean file pages from pruned inodes (on highmem systems) or xfs
buffer pages, there is no simple way to currently link them to the memcg
under reclaim.

Stop reporting those freed pages as reclaimed pages during memcg
reclaim. This should make the return value of writing to memory.reclaim,
and may help reduce unnecessary reclaim retries during memcg charging.

Generally, this should make the return value of
try_to_free_mem_cgroup_pages() more accurate. In some limited cases (e.g.
freed a slab page that was mostly charged to the memcg under reclaim),
the return value of try_to_free_mem_cgroup_pages() can be
underestimated, but this should be fine. The freed pages will be
uncharged anyway, and we can charge the memcg the next time around as we
usually do memcg reclaim in a retry loop.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/vmscan.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a3e38851b34ac..bf9d8e175e92a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -533,7 +533,35 @@ EXPORT_SYMBOL(mm_account_reclaimed_pages);
 static void flush_reclaim_state(struct scan_control *sc,
 				struct reclaim_state *rs)
 {
-	if (rs) {
+	/*
+	 * Currently, reclaim_state->reclaimed includes three types of pages
+	 * freed outside of vmscan:
+	 * (1) Slab pages.
+	 * (2) Clean file pages from pruned inodes.
+	 * (3) XFS freed buffer pages.
+	 *
+	 * For all of these cases, we have no way of finding out whether these
+	 * pages were related to the memcg under reclaim. For example, a freed
+	 * slab page could have had only a single object charged to the memcg
+	 * under reclaim. Also, populated inodes are not on shrinker LRUs
+	 * anymore except on highmem systems.
+	 *
+	 * Instead of over-reporting the reclaimed pages in a memcg reclaim,
+	 * only count such pages in system-wide reclaim. This prevents
+	 * unnecessary retries during memcg charging and false positive from
+	 * proactive reclaim (memory.reclaim).
+	 *
+	 * For uncommon cases were the freed pages were actually significantly
+	 * charged to the memcg under reclaim, and we end up under-reporting, it
+	 * should be fine. The freed pages will be uncharged anyway, even if
+	 * they are not reported properly, and we will be able to make forward
+	 * progress in charging (which is usually in a retry loop).
+	 *
+	 * We can go one step further, and report the uncharged objcg pages in
+	 * memcg reclaim, to make reporting more accurate and reduce
+	 * under-reporting, but it's probably not worth the complexity for now.
+	 */
+	if (rs && !cgroup_reclaim(sc)) {
 		sc->nr_reclaimed += rs->reclaimed;
 		rs->reclaimed = 0;
 	}
-- 
2.40.0.348.gf938b09366-goog

