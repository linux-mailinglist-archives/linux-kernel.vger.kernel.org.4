Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60DE693F22
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjBMHx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMHx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:53:27 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0BA422A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:53:26 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-52f233aff21so17929997b3.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NvhGAhuoLUXZRBDLvVFPku75YEeAYrautV9kwkbVm+U=;
        b=optKyx+Ol4vgXo9n9HECwvIRntjr3OUydQJaoxkHSsFuotk0exbyE/mdWNa18ffL/h
         qQmFuqJAhnLXTtEyCMP8wNz4mAakzwVU4q94mV8Eb8IFVJ+0aBHIa2GtgstgoQ8rRmle
         ZwjA6uZ6kVYx40fca2ORN7hr4T6JZTiBfUmY6DSxVTlpg4FGiulHGtFN3JM6VHlNRDyI
         PFoiyLYbHEbYKeXi7+LuOUPsT0PxNlbMuZH8JZiwTJ/vQ5GyrmGG4E2PlXIKAbHUWLhh
         Zlxp5yjsxYzXDqxwf8kdiOk1LJk33G+qspbVqUpAPZGKN3VTQA32H1LgXhuK0fIJHmI0
         5PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NvhGAhuoLUXZRBDLvVFPku75YEeAYrautV9kwkbVm+U=;
        b=OxbF3e+qWo6XbqDQNoKRnURA49TfkRCTZV7Cb3LUY6wey9UI67Sqn3tFUOkiSNpAIx
         zfKBRd0UJpOGLihKIXHuIWKHFrMTX35bni4vxj3l1OK5cU/Fwlk9sxmIN9OPjKv5O87p
         spA5VHu6uQwBAhmTmJOL5AW+vrJMM0F/799/BxzYFJ1FdrGZoUYIW1PS/HYsdppqa5k3
         kv38JB3mFt+5pnLcN+BF52cVKY4rlk2V10WuRUBYEw/93/cNEyIKQGoZubGbiLHknfFv
         zYFZXii9T9Idrcxmcd4SoXIzdTi4pdadykscbeB88PxTIRSIVr/CpV30FXKeMRnRqqmh
         mX5w==
X-Gm-Message-State: AO0yUKVRox6RPgvQto0IEhdZCc7wl8uIeM2z5R12AoZCSsh8NVU23yAg
        rGC0q+P7O/w0cU4/6SI9zQ82UBdeKOg=
X-Google-Smtp-Source: AK7set/guU6artniwycMRZB/B3vkY/jJjJNmh0MMnseMPOIWtKnpO+3lWWTtlzgawUqAURmh5dclb/fIQ84=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7197:d392:1707:74d9])
 (user=yuzhao job=sendgmr) by 2002:a81:a10:0:b0:521:daa4:d687 with SMTP id
 16-20020a810a10000000b00521daa4d687mr30ywk.0.1676274805040; Sun, 12 Feb 2023
 23:53:25 -0800 (PST)
Date:   Mon, 13 Feb 2023 00:53:22 -0700
Message-Id: <20230213075322.1416966-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Subject: [PATCH mm-unstable v1] mm: multi-gen LRU: avoid futile retries
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com, Yu Zhao <yuzhao@google.com>,
        "T . J . Mercier" <tjmercier@google.com>
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

Recall that the per-node memcg LRU has two generations and they
alternate when the last memcg (of a given node) is moved from one to
the other. Each generation is also sharded into multiple bins to
improve scalability. A reclaimer starts with a random bin (in the old
generation) and, if it fails, it will retry, i.e., to try the rest of
the bins.

If a reclaimer fails with the last memcg, it should move this memcg to
the young generation first, which causes the generations to alternate,
and then retry. Otherwise, the retries will be futile because all
other bins are empty.

Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Reported-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d4b9fd1ae0ed..34535bbd4fe9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5356,18 +5356,20 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 
 static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 {
+	int op;
 	int gen;
 	int bin;
 	int first_bin;
 	struct lruvec *lruvec;
 	struct lru_gen_folio *lrugen;
+	struct mem_cgroup *memcg;
 	const struct hlist_nulls_node *pos;
-	int op = 0;
-	struct mem_cgroup *memcg = NULL;
 	unsigned long nr_to_reclaim = get_nr_to_reclaim(sc);
 
 	bin = first_bin = get_random_u32_below(MEMCG_NR_BINS);
 restart:
+	op = 0;
+	memcg = NULL;
 	gen = get_memcg_gen(READ_ONCE(pgdat->memcg_lru.seq));
 
 	rcu_read_lock();
@@ -5391,14 +5393,22 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 
 		op = shrink_one(lruvec, sc);
 
-		if (sc->nr_reclaimed >= nr_to_reclaim)
-			goto success;
-
 		rcu_read_lock();
+
+		if (sc->nr_reclaimed >= nr_to_reclaim)
+			break;
 	}
 
 	rcu_read_unlock();
 
+	if (op)
+		lru_gen_rotate_memcg(lruvec, op);
+
+	mem_cgroup_put(memcg);
+
+	if (sc->nr_reclaimed >= nr_to_reclaim)
+		return;
+
 	/* restart if raced with lru_gen_rotate_memcg() */
 	if (gen != get_nulls_value(pos))
 		goto restart;
@@ -5407,11 +5417,6 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 	bin = get_memcg_bin(bin + 1);
 	if (bin != first_bin)
 		goto restart;
-success:
-	if (op)
-		lru_gen_rotate_memcg(lruvec, op);
-
-	mem_cgroup_put(memcg);
 }
 
 static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
-- 
2.39.1.581.gbfd45094c4-goog

