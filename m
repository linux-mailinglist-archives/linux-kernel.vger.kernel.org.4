Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D4A688ADB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjBBXcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjBBXcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:32:39 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A842102
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:32:37 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id u18-20020a62ed12000000b00593cc641da4so1684746pfh.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 15:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NNiCqwzESyAJCUAtzOveFlWcEoCPQvaoYU5oWya4UE=;
        b=hOhCADwPkxUGmi7V1P/nnFPjlarle5tUS/LLXkpE2OMQZSESuPz1Yg7ch5+w2lQPvZ
         Tg/E8g4ve+TuLwEeRfChTbEYbLJeSDJDBhmLL+z83Q3UbkFRR/7iALI3n//9YzuETtUk
         /td2TUtQtadczPSW8P9uXTi/L7bXWxzWMSBHRmqrt9SBSEfcBH/jtfBlcjWv7c1f+PLe
         QQJMnYWOv7ywl4B7eaZ7s3dALT60pveMbI3kcs7UOtDp14gKlyebUk9ejlg7acW+153Z
         oPfBCDEgRhQOIX+ZejkUx9YYjTBJC43e4lfmtvzzmccRB1Rl0AHErHGP8WlCALz8YStS
         jSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NNiCqwzESyAJCUAtzOveFlWcEoCPQvaoYU5oWya4UE=;
        b=0w5HWkXlV2dKp3opUL8RAjLFQaV/gNOeO2uWaTpcl4CEEZ93ROLehhbUYx6JhnwWZ2
         PJS9XdrFCQd8sz8avgX0vamZRmTFGfPNxtiJj5Fod6SelEQMu32sBvuBLxC/MamMfBG5
         Vezt4E/wUD/kbiP5AyUiTIMwMrAMvwsZknVwnjE4kh9hfSXnxa87V+buPVxSxcwT4fEw
         Ml9ZwXWQZZJJ0mfFQmgrxFvgUE0BfuPNHVjDY9ufTnzhkWbRuwgB96jdIoqWfiHEU9Xe
         /niSj353OZDKwgQTkUpllw3271k63pvh2MjIaKRECLfCoO05TSpA1DdgdrcrhV40Pphw
         wPgg==
X-Gm-Message-State: AO0yUKWTtlOpKDZBaPYSf+xafcSyIuCKaHpDdk4ZvhZHt9j5u9tcda8C
        M289KjW3cWF55wC9A2Gw1Yr8u6+J4OqF2l4j
X-Google-Smtp-Source: AK7set/gX+d7qL2VYRm0mNT1mURMK3jqpTnNExhfErr1wouO0vmd1XoXrrDp0BwbdxbCN+7oo8RXZwzOeOx6nPe4
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:903:1c8:b0:193:9ec:fc13 with SMTP
 id e8-20020a17090301c800b0019309ecfc13mr1942596plh.33.1675380757137; Thu, 02
 Feb 2023 15:32:37 -0800 (PST)
Date:   Thu,  2 Feb 2023 23:32:29 +0000
In-Reply-To: <20230202233229.3895713-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230202233229.3895713-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202233229.3895713-3-yosryahmed@google.com>
Subject: [RFC PATCH v1 2/2] mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
for clean file pages from pruned inodes or xfs buffer pages, there is no
way to link them to the memcg under reclaim.

Stop reporting those freed pages as reclaimed pages during memcg
reclaim. This should make the return value of writing to memory.reclaim,
and may help reduce unnecessary reclaim retries during memcg charging.

Generally, this should make the return value of
try_to_free_mem_cgroup_pages() more accurate. In some limited cases (e.g.
freed a slab page that was mostly charged to the memcg under reclaim),
the return value of try_to_free_mem_cgroup_pages() can be
underestimated, but this should be fine as it is mostly called in a
retry loop.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 63a27d2f6f31..207998b16e5f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6181,7 +6181,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 	shrink_node_memcgs(pgdat, sc);
 
-	if (reclaim_state) {
+	if (reclaim_state && !cgroup_reclaim(sc)) {
 		sc->nr_reclaimed += reclaim_state->reclaimed;
 		reclaim_state->reclaimed = 0;
 	}
-- 
2.39.1.519.gcb327c4b5f-goog

