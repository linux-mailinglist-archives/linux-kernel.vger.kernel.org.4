Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C95D735DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjFSTih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjFSTie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:38:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBEDE71
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:38:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-be47a3b3a01so4003385276.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 12:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687203511; x=1689795511;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HCw2VH+vwapV6l/h+dF5z2IFI4Xz0i/+vWzvGaN0ULY=;
        b=ob9C8F/z7W2ZwmjqKz/Cvine6FVUEUnDsKk1zQIsGAIkjG83xxDJzueWto4L0n6VBq
         V0jkBXab7krBI+QchBRNdl5zRkUv1eEYXNfD54GlT4eg181CEItBbaNF2WGB6SkK9hWB
         alN+QbwXqOPTUwn3IOEBhW6FQ6gX1+KEah/ycaLWU4tl5xVPL4aJXhvXNAhDb92wLKgG
         JTv5Mp0z75TlwvOCjFlF6fz976sUTZfB1t/YeUx8BTpYTeRZaEJ7a9Gd6kCdydKWHfDx
         4ZtGINXlu88f8GZnqSjrNh93MPA+YKVTVY4aOIaQXDRBafm7QJwqNuAvJ5Ho7Sr1UPRZ
         Q8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687203511; x=1689795511;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCw2VH+vwapV6l/h+dF5z2IFI4Xz0i/+vWzvGaN0ULY=;
        b=KU6Rf0W2XM6w74mpGDxPiMJi+vN+m0noZYDC0fbq1+cLYSRBE2GKKyZNPW7ZUrH/kz
         lAYinRD7evuTrE3oJjgn1duJ0GTq7FLsdFqvenHojcZTsKot1o5L1Xr2+fzyMXGJRzWR
         vjne6Bfhu8XZH/Xw6VY1bHev0q1VF4BHmcLlPMw+wk+nAK4DFisyawCNAb+kaOUbQkPW
         /TjnN3f8V5uTVMDykF8vrdgj2UpK2PWh35s77gosSwkUWEy0Y1QM590Zr8hB/sNqUBwY
         TT84rVWLk9JMOyAZX48ai5ZqHchpsfKg03Kbpyk4EGCao5+gaXMHu0CmT+ydVTQbC3in
         GN8g==
X-Gm-Message-State: AC+VfDwIKcmwPdjSE0Zdj1m/gv0eWjaRWGINW9eNX5gIwrtjw71H4YmZ
        QGV/Hfge/og+qdOZT6S+v+TbEloV3yA=
X-Google-Smtp-Source: ACHHUZ5pfU5AaytiISOSDvFrNLXjh0g8DNDoFNsY2iGWO+BXyG7SrQ5ViqTG3yVka44liPSNzRY5KXR79KI=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:202:6457:2153:f1fa:3f37])
 (user=yuzhao job=sendgmr) by 2002:a25:23c1:0:b0:be7:ea0b:2702 with SMTP id
 j184-20020a2523c1000000b00be7ea0b2702mr1031854ybj.12.1687203511044; Mon, 19
 Jun 2023 12:38:31 -0700 (PDT)
Date:   Mon, 19 Jun 2023 13:38:21 -0600
Message-Id: <20230619193821.2710944-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.185.g7c58973941-goog
Subject: [PATCH mm-unstable v1] mm/mglru: make memcg_lru->lock irq safe
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>,
        syzbot+87c490fd2be656269b6a@syzkaller.appspotmail.com
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

lru_gen_rotate_memcg() can happen in softirq if
memory.soft_limit_in_bytes is set. This requires memcg_lru->lock to be
irq safe.

This problem only affects memcg v1.

Reported-by: syzbot+87c490fd2be656269b6a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=87c490fd2be656269b6a
Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 45d17c7cc555..27f90896f789 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4759,10 +4759,11 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 {
 	int seg;
 	int old, new;
+	unsigned long flags;
 	int bin = get_random_u32_below(MEMCG_NR_BINS);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
-	spin_lock(&pgdat->memcg_lru.lock);
+	spin_lock_irqsave(&pgdat->memcg_lru.lock, flags);
 
 	VM_WARN_ON_ONCE(hlist_nulls_unhashed(&lruvec->lrugen.list));
 
@@ -4797,7 +4798,7 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	if (!pgdat->memcg_lru.nr_memcgs[old] && old == get_memcg_gen(pgdat->memcg_lru.seq))
 		WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
 
-	spin_unlock(&pgdat->memcg_lru.lock);
+	spin_unlock_irqrestore(&pgdat->memcg_lru.lock, flags);
 }
 
 void lru_gen_online_memcg(struct mem_cgroup *memcg)
@@ -4810,7 +4811,7 @@ void lru_gen_online_memcg(struct mem_cgroup *memcg)
 		struct pglist_data *pgdat = NODE_DATA(nid);
 		struct lruvec *lruvec = get_lruvec(memcg, nid);
 
-		spin_lock(&pgdat->memcg_lru.lock);
+		spin_lock_irq(&pgdat->memcg_lru.lock);
 
 		VM_WARN_ON_ONCE(!hlist_nulls_unhashed(&lruvec->lrugen.list));
 
@@ -4821,7 +4822,7 @@ void lru_gen_online_memcg(struct mem_cgroup *memcg)
 
 		lruvec->lrugen.gen = gen;
 
-		spin_unlock(&pgdat->memcg_lru.lock);
+		spin_unlock_irq(&pgdat->memcg_lru.lock);
 	}
 }
 
@@ -4845,7 +4846,7 @@ void lru_gen_release_memcg(struct mem_cgroup *memcg)
 		struct pglist_data *pgdat = NODE_DATA(nid);
 		struct lruvec *lruvec = get_lruvec(memcg, nid);
 
-		spin_lock(&pgdat->memcg_lru.lock);
+		spin_lock_irq(&pgdat->memcg_lru.lock);
 
 		VM_WARN_ON_ONCE(hlist_nulls_unhashed(&lruvec->lrugen.list));
 
@@ -4857,7 +4858,7 @@ void lru_gen_release_memcg(struct mem_cgroup *memcg)
 		if (!pgdat->memcg_lru.nr_memcgs[gen] && gen == get_memcg_gen(pgdat->memcg_lru.seq))
 			WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
 
-		spin_unlock(&pgdat->memcg_lru.lock);
+		spin_unlock_irq(&pgdat->memcg_lru.lock);
 	}
 }
 
-- 
2.41.0.185.g7c58973941-goog

