Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B2465045A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 19:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiLRSbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 13:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiLRSaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 13:30:35 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C531A6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 10:19:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h11so6759326wrw.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 10:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg0kRjUkHsbVldHE/ToyxuU6W5oSI6/mxVC6mkuggOI=;
        b=M2Ymm3OzlmHxaIpnbfofJ1RMKGA7L0CweSfRTYVTWEU6Ni0XAEKHuLIaEcWmFpQsbY
         jQOjpFBKtGchKShh10zl5ey+a1KSTVK5QFQ+Da9b/gvZyD2ppRvk6BalmoLkL1vRJJ7o
         UAq7YQm6D7tefSeuieLgpSG5p7Utu+/J/sqrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jg0kRjUkHsbVldHE/ToyxuU6W5oSI6/mxVC6mkuggOI=;
        b=Z4c80Zb+2jGwyq3yTfjCYURBSuDEqzwqSFzLnoXNLI1zhaHY5oKDFJLnJ5jD8gksXE
         o3JH4KYrbg0R4NnQma1pu8ihQOVL+8tvplbJYWSu+7H9Gagj6z0hMIa3H1C6TDMvxL/J
         e9cjzqCLBg1osfIB4qyLqLdqXxOGYh8XdUVH5hnQhSJ4TQxNLHGTbC1GCRcUIQNiCz20
         ibVxWNI2HVF68RuzVoJzFWYAERlKBJrC/MRd3vPgOY75zXXQochmfvH0tHJQxprYHmLe
         /BUJ4nAT9OdmuYNIHbEKiIcHnFm0kVv7hZq7z6zJJbVK4dNPg0IZ0g3pTgXv0mFTQ2X3
         TC6Q==
X-Gm-Message-State: ANoB5pkluIVBDW9LlsqvljLvFBqB0uXw6hmDmuhnBFQswo4Ftgh9+bZL
        RgZD+B7quqbjzAngSuYBaXOTkxC2n3oEwDLWAzvuhPOTauDXxqiag3zFr3xm/5SpMQSWP32c8YK
        w/LhYLxbLdBo3SBSGptXVprM1rIOKfSKzMvOKdLLOcZlwzGED1fti9n+mWvA5m3BUNK15IT8oas
        9mOfwfeskFREBqtGjwD7hZeO/p6w==
X-Google-Smtp-Source: AA0mqf6mLbw8THD4/ZgFr10rOzQ/8PAMYOZrejAIYU7OuGCysRcBIowkEyxN+N6xImTtCNhFMgIlyg==
X-Received: by 2002:adf:e8ce:0:b0:24c:f1ac:9a3 with SMTP id k14-20020adfe8ce000000b0024cf1ac09a3mr20078504wrn.27.1671387547014;
        Sun, 18 Dec 2022 10:19:07 -0800 (PST)
Received: from MacBook-Pro-6.lan ([2a0d:6fc2:218c:1a00:c45e:1c4b:fab4:ee34])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600003cd00b0024cb961b6aesm7956489wrg.104.2022.12.18.10.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 10:19:06 -0800 (PST)
From:   david.keisarschm@mail.huji.ac.il
To:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Jason@zx2c4.com,
        David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>,
        aksecurity@gmail.com, ilay.bahat1@gmail.com, linux-mm@kvack.org
Subject: [PATCH v3 1/3] Replace invocation of weak PRNG in mm/slab.c
Date:   Sun, 18 Dec 2022 20:18:58 +0200
Message-Id: <c64c1b08c60dee2a2d7f18d42acad71c2b271711.1671277662.git.david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1671277662.git.david.keisarschm@mail.huji.ac.il>
References: <cover.1671277662.git.david.keisarschm@mail.huji.ac.il>
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

From: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>

This third series add some changes to the commit messages,
and also replaces get_random_u32 with get_random_u32_below,
in a case a modulo operation is done on the result.

The Slab allocator randomization uses the prandom_u32 PRNG.
That was added to prevent attackers to obtain information on the heap state,
by randomizing the freelists state.

However, this PRNG turned out to be weak, as noted in commit c51f8f88d705
To fix it, we have changed the invocation of prandom_u32_state to get_random_u32
to ensure the PRNG is strong.

Since a modulo operation is applied right after that,
we used get_random_u32_below, to achieve uniformity.

In addition, we changed the freelist_init_state union to struct,
since the rnd_state inside which is used to store the state of prandom_u32,
is not needed anymore, since get_random_u32 maintains its own state.

# Changes since v2

* edited commit message.
* replaced instances of get_random_u32 with get_random_u32_below
    in mm/slab.c.


Signed-off-by: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
---
 mm/slab.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 59c8e28f7..c259e0b09 100644
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
@@ -2381,23 +2378,22 @@ static bool freelist_state_initialize(union freelist_init_state *state,
 	unsigned int rand;
 
 	/* Use best entropy available to define a random shift */
-	rand = get_random_u32();
+	rand = get_random_u32_below(count);
 
 	/* Use a random state if the pre-computed list is not available */
 	if (!cachep->random_seq) {
-		prandom_seed_state(&state->rnd_state, rand);
 		ret = false;
 	} else {
 		state->list = cachep->random_seq;
 		state->count = count;
-		state->pos = rand % count;
+		state->pos = rand;
 		ret = true;
 	}
 	return ret;
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
@@ -2447,8 +2443,7 @@ static bool shuffle_freelist(struct kmem_cache *cachep, struct slab *slab)
 
 		/* Fisher-Yates shuffle */
 		for (i = count - 1; i > 0; i--) {
-			rand = prandom_u32_state(&state.rnd_state);
-			rand %= (i + 1);
+			rand = get_random_u32_below(i+1);
 			swap_free_obj(slab, i, rand);
 		}
 	} else {
-- 
2.38.0

