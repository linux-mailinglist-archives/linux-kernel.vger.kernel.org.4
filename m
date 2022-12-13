Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CF164B349
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiLMKfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbiLMKfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:35:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789BA9FD2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:35:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bx10so15153181wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGg6vKEauhotkhfwwbX9Xfm94/pFIlBLO+fx3udphtY=;
        b=JhWIj6CxmlQiKSRetwUPFg+xHtVNbxntjGh3uTjAz9yNDyP+tLWyhXZW2Nmg5ffzK/
         /3wlEjsUA4TFVsykrLXpBJFwKvYMcCNJM6G7/aESArLp3YWR+nKfuD2NfqWaYcisVSMB
         F3oaPgX4+0ZctJF/+4DTS3VrUMujWoO+NqLM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGg6vKEauhotkhfwwbX9Xfm94/pFIlBLO+fx3udphtY=;
        b=4Cx/J7uN/4Kf8Q1AL0wilhN+r96kfuq4u1f2Yaka/24iGwMvqmvhiQUaSmM3gvDGHo
         HGV6zXD5eJ2wQkIaMX795pBPO0Q4lfT6TEne9ntvSsbKSQ+2V//B/ZjSaWzJckjeZ8jU
         UZdoIffJ9KnRIyjquAnRK4YpBQDD1YlTvt6uppZvIFNWgjGTULsibq8hAvOhgVdI+2nc
         u/ve8r5M8dZ+ksX2hG7uy0iq62sXhN/zwo6b+VaSu2ERUI9RT4m6B+ytT2+fZbUn9xiu
         UsdxC2wcCfUUN063wVnzZeQRBQPI0rjbrYqzt9xuEjlg2JYD9VZ6eAOcMunWGISVRIlJ
         9s7g==
X-Gm-Message-State: ANoB5plChubYRvJ+o9DlPUbBK6rztlNXGfoNSxz8UhNA9BhlFUhK2qPV
        KtvtntSX8OFkMYVvpoeKozFqRo2VYHHRaLQ+k296+ycxHXa1jU3ey1tzMD4+BRKy6nMHGOC1m8w
        2+PEYknNBq8ArKKv6zzBsCZQ0JcX6A2tiiFNM6H+OTHuosmrLU51fnV4kSQkfE65aC21ZukCoP3
        8kg8wjryzUgPJllp/fNsxw5Ww=
X-Google-Smtp-Source: AA0mqf6m4tyjpmFogihcw4BU5HrvCx3i3vS1FDPgEZ2EFD4dhkuQ9Dn3Q0dBoHeYB1wYTVXTHeIsMQ==
X-Received: by 2002:adf:aa81:0:b0:242:242b:67a7 with SMTP id h1-20020adfaa81000000b00242242b67a7mr11137471wrc.70.1670927704814;
        Tue, 13 Dec 2022 02:35:04 -0800 (PST)
Received: from MacBook-Pro-6.lan ([2a0d:6fc2:218c:1a00:a0bd:cef2:7a82:b529])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d6b0f000000b002366553eca7sm11295813wrw.83.2022.12.13.02.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 02:35:04 -0800 (PST)
From:   david.keisarschm@mail.huji.ac.il
To:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     David <david.keisarschm@mail.huji.ac.il>, aksecurity@gmail.com,
        ilay.bahat1@gmail.com, linux-mm@kvack.org
Subject: [PATCH v2 1/3] Replace invocation of weak PRNG in mm/slab.c
Date:   Tue, 13 Dec 2022 12:34:57 +0200
Message-Id: <4925f0fe15e9cda5f9d90d75c6e15acdc413ef9e.1670890407.git.david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1670890407.git.david.keisarschm@mail.huji.ac.il>
References: <cover.1670890407.git.david.keisarschm@mail.huji.ac.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David <david.keisarschm@mail.huji.ac.il>

We changed the invocation
 of prandom_u32_state to get_random_u32.
 We also changed the freelist_init_state
 to struct instead of a union,
 since the rnd_state is not needed anymore
- get_random_u32 maintains its own state.
This change it important since it
is make the slab allocator randomization
stronger.

Signed-off-by: David <david.keisarschm@mail.huji.ac.il>
---
 mm/slab.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 92d6b1d48..1476104f4 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2360,20 +2360,17 @@ static void cache_init_objs_debug(struct kmem_cache *cachep, struct slab *slab)
 
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
 /* Hold information during a freelist initialization */
-union freelist_init_state {
-	struct {
-		unsigned int pos;
-		unsigned int *list;
-		unsigned int count;
-	};
-	struct rnd_state rnd_state;
+struct freelist_init_state {
+	unsigned int pos;
+	unsigned int *list;
+	unsigned int count;
 };
 
 /*
  * Initialize the state based on the randomization method available.
  * return true if the pre-computed list is available, false otherwise.
  */
-static bool freelist_state_initialize(union freelist_init_state *state,
+static bool freelist_state_initialize(struct freelist_init_state *state,
 				struct kmem_cache *cachep,
 				unsigned int count)
 {
@@ -2385,7 +2382,6 @@ static bool freelist_state_initialize(union freelist_init_state *state,
 
 	/* Use a random state if the pre-computed list is not available */
 	if (!cachep->random_seq) {
-		prandom_seed_state(&state->rnd_state, rand);
 		ret = false;
 	} else {
 		state->list = cachep->random_seq;
@@ -2397,7 +2393,7 @@ static bool freelist_state_initialize(union freelist_init_state *state,
 }
 
 /* Get the next entry on the list and randomize it using a random shift */
-static freelist_idx_t next_random_slot(union freelist_init_state *state)
+static freelist_idx_t next_random_slot(struct freelist_init_state *state)
 {
 	if (state->pos >= state->count)
 		state->pos = 0;
@@ -2418,7 +2414,7 @@ static void swap_free_obj(struct slab *slab, unsigned int a, unsigned int b)
 static bool shuffle_freelist(struct kmem_cache *cachep, struct slab *slab)
 {
 	unsigned int objfreelist = 0, i, rand, count = cachep->num;
-	union freelist_init_state state;
+	struct freelist_init_state state;
 	bool precomputed;
 
 	if (count < 2)
@@ -2447,7 +2443,7 @@ static bool shuffle_freelist(struct kmem_cache *cachep, struct slab *slab)
 
 		/* Fisher-Yates shuffle */
 		for (i = count - 1; i > 0; i--) {
-			rand = prandom_u32_state(&state.rnd_state);
+			rand = get_random_u32();
 			rand %= (i + 1);
 			swap_free_obj(slab, i, rand);
 		}
-- 
2.38.0

