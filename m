Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516176957A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 04:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjBNDzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 22:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjBNDy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 22:54:58 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C4F13D61
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:54:57 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso10693133ilj.17
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7z7DhJJ7GQp6CX5gwTveavGyOgqeiEEFMgrBGxLBZ8=;
        b=DNQ50StaD0fjmUsChg+gdyZp+khgLhAxfrWnJb2OjAvyrOWHpTYym5niXksLMEJ48x
         BFErgHn8aGfTbHqafwyUa+VSRZMfJwNGCIxqG8OfEHYlw+yRb1MLm/hOBe4f395C77aS
         8o8OrnaN+u5BXtjEcUB5UxWiVYbSKJJXRBfRQJwjc245KCkYJcXUBmS0XQlJf0QNXJgt
         26nrLQVjHocIy1JIQXEKFZZeyDCQ+PJ1u48kYdY0zT7qb6xgcy3KPPoD2wZ337KrikqS
         C7DCmeU96uqcKBYo2fglHR6luPpVgGamDa7H/Gr2E071d0jxmUgB8Sl5pmiGqHgDLx78
         VpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7z7DhJJ7GQp6CX5gwTveavGyOgqeiEEFMgrBGxLBZ8=;
        b=cLohiCz6QHTU4gisKbj6UujgxtBWPi0fbE+9MD7eH/y792Wgc89qce2ML2E+Te68vz
         5o9hxf6aeaw6vmRMkA2EjdEBAasK/bmQgz4GXJrf+PqbxJCOREtenBaoJXxPW2y7Z8AR
         kxaXxaqlhMkJxlfAcpWBNVjErG9GFZKYYO5SfnfHj67hR9U2kM2HMSbGcid6OAJXQG6l
         i30exEpif22cqAeGAUs0wslETxo1CgfoxMAbSNZ446tru7btsZL3LHPTG/GS8SjnfYXH
         aRhRzlUbcKoec19fmXzfxUU98Qs5WuMy/Xf+Jsraoe0lX07UxxMCBP9ItITdB6Yc6jB6
         hdvw==
X-Gm-Message-State: AO0yUKVu1OyGlUGT/n29LbMWAbk19wbhBwzfVcSnjYAkyXW/Pdp3XubA
        gP6yTBvEmrtRou90lcRhv2tbu4ydFQpnlA==
X-Google-Smtp-Source: AK7set8/q1DBAyzD2gxm/b23P4hXajELnAW83AEicocg/SCqMKehiAlBF9FRSqCCo2kQBEB9XFjy0MU/dkxFHQ==
X-Received: from talumbau.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a6b:4a13:0:b0:740:694b:54b2 with SMTP id
 w19-20020a6b4a13000000b00740694b54b2mr112310iob.21.1676346896619; Mon, 13 Feb
 2023 19:54:56 -0800 (PST)
Date:   Tue, 14 Feb 2023 03:54:45 +0000
In-Reply-To: <20230214035445.1250139-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230214035445.1250139-1-talumbau@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230214035445.1250139-2-talumbau@google.com>
Subject: [PATCH mm-unstable v1 2/2] mm: multi-gen LRU: improve design doc
From:   "T.J. Alumbaugh" <talumbau@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com, "T.J. Alumbaugh" <talumbau@google.com>
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

This patch improves the design doc. Specifically,
  1. add a section for the per-memcg mm_struct list, and
  2. add a section for the PID controller.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 Documentation/mm/multigen_lru.rst | 44 +++++++++++++++++++++++++++----
 mm/vmscan.c                       |  2 +-
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/mm/multigen_lru.rst b/Documentation/mm/multigen_lru.rst
index 5f1f6ecbb79b..52ed5092022f 100644
--- a/Documentation/mm/multigen_lru.rst
+++ b/Documentation/mm/multigen_lru.rst
@@ -103,7 +103,8 @@ moving across tiers only involves atomic operations on
 ``folio->flags`` and therefore has a negligible cost. A feedback loop
 modeled after the PID controller monitors refaults over all the tiers
 from anon and file types and decides which tiers from which types to
-evict or protect.
+evict or protect. The desired effect is to balance refault percentages
+between anon and file types proportional to the swappiness level.
 
 There are two conceptually independent procedures: the aging and the
 eviction. They form a closed-loop system, i.e., the page reclaim.
@@ -156,6 +157,27 @@ This time-based approach has the following advantages:
    and memory sizes.
 2. It is more reliable because it is directly wired to the OOM killer.
 
+``mm_struct`` list
+------------------
+An ``mm_struct`` list is maintained for each memcg, and an
+``mm_struct`` follows its owner task to the new memcg when this task
+is migrated.
+
+A page table walker iterates ``lruvec_memcg()->mm_list`` and calls
+``walk_page_range()`` with each ``mm_struct`` on this list to scan
+PTEs. When multiple page table walkers iterate the same list, each of
+them gets a unique ``mm_struct``, and therefore they can run in
+parallel.
+
+Page table walkers ignore any misplaced pages, e.g., if an
+``mm_struct`` was migrated, pages left in the previous memcg will be
+ignored when the current memcg is under reclaim. Similarly, page table
+walkers will ignore pages from nodes other than the one under reclaim.
+
+This infrastructure also tracks the usage of ``mm_struct`` between
+context switches so that page table walkers can skip processes that
+have been sleeping since the last iteration.
+
 Rmap/PT walk feedback
 ---------------------
 Searching the rmap for PTEs mapping each page on an LRU list (to test
@@ -170,7 +192,7 @@ promotes hot pages. If the scan was done cacheline efficiently, it
 adds the PMD entry pointing to the PTE table to the Bloom filter. This
 forms a feedback loop between the eviction and the aging.
 
-Bloom Filters
+Bloom filters
 -------------
 Bloom filters are a space and memory efficient data structure for set
 membership test, i.e., test if an element is not in the set or may be
@@ -186,6 +208,18 @@ is false positive, the cost is an additional scan of a range of PTEs,
 which may yield hot pages anyway. Parameters of the filter itself can
 control the false positive rate in the limit.
 
+PID controller
+--------------
+A feedback loop modeled after the Proportional-Integral-Derivative
+(PID) controller monitors refaults over anon and file types and
+decides which type to evict when both types are available from the
+same generation.
+
+The PID controller uses generations rather than the wall clock as the
+time domain because a CPU can scan pages at different rates under
+varying memory pressure. It calculates a moving average for each new
+generation to avoid being permanently locked in a suboptimal state.
+
 Memcg LRU
 ---------
 An memcg LRU is a per-node LRU of memcgs. It is also an LRU of LRUs,
@@ -223,9 +257,9 @@ parts:
 
 * Generations
 * Rmap walks
-* Page table walks
-* Bloom filters
-* PID controller
+* Page table walks via ``mm_struct`` list
+* Bloom filters for rmap/PT walk feedback
+* PID controller for refault feedback
 
 The aging and the eviction form a producer-consumer model;
 specifically, the latter drives the former by the sliding window over
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 09c064accdb1..43e69dc8b4bd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3604,7 +3604,7 @@ static bool iterate_mm_list_nowalk(struct lruvec *lruvec, unsigned long max_seq)
 }
 
 /******************************************************************************
- *                          refault feedback loop
+ *                          PID controller
  ******************************************************************************/
 
 /*
-- 
2.39.1.581.gbfd45094c4-goog

