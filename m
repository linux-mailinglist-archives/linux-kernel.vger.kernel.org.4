Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72416E3A72
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjDPRWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPRWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:22:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B892114
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:22:47 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f09d08a2bfso5891215e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1681665765; x=1684257765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iFMrYnSSw3X9l1HGYfVpxqFoRoszC2z+WCEwwhPnbPU=;
        b=C/KwP3v5mZWBHJcdg2Xa3ou4cVQDaqoFZpXKR5qbe/2G/gxN18JGjC7ccAYfbdFAvf
         e21nfDat0IaNkLzgH9kZf+kRZwzVU8G1NuKoYxSEycinNlP4GzPuQiuIbeLKiI4t9e/S
         cucBfK8dzbl2gM9luW6kchCriSA9N0uQsz5W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681665765; x=1684257765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iFMrYnSSw3X9l1HGYfVpxqFoRoszC2z+WCEwwhPnbPU=;
        b=drKSIMFO9Eu/Ofs4t2gOzV9Gkgaojx1/fBn2fF8pThXD7OCsX18Bs3WXPxKWC89UwQ
         DqsvGCN8q3xUbdLDOR5rOU2izeo9EylhCDtTgKm2zYr5HVpesFJSWVbew+1eCUNe/kal
         zu1A/313ni1iyPVMScP9WtR2qfwEjDXR1QGYsbfpLheYc7lxi7TO6U+G/bQwnAE5BTSf
         wedVvzXHmdL5v9QErSwbdbfZYxKfNs6WJYyvcdEAnAhgDeYKro+Mgmv59ByStrW3c1kp
         dYGn8OUe1i/IaFfRde3ZkZ4CXj5wQueWZFHmjGsCx2tJo9IdTMZhKUfs8QmxaDNlJjZG
         6T3A==
X-Gm-Message-State: AAQBX9fFuNqhivtDsKw+pGvIZCNG3bpjBIjrW8Ic26nQi5C0CoVam61/
        Yv93PrcdEJzCkx9BiX8JquBtXUWO4aSrbyKRwvFpJS5vKQFo9ePXU/k8z2ypjZP/RgGsGcAW/8K
        j6MAzG1Y92v+zLuYoVOqEtnPRo3ci3XGg6wWfkAlQ9dnywB83HlfqBRj0tcqr7v2dhdmc1x749z
        RS2J7JK83mIIj0PVafBYiBtLAu/10o
X-Google-Smtp-Source: AKy350bWXYWJuKr+DH+kawyLpUCX7nTyWaX63YESheORChPTrGVFQ6sLd1J/LDehgJiyU77SS9Lt7g==
X-Received: by 2002:adf:f089:0:b0:2cf:e422:e28c with SMTP id n9-20020adff089000000b002cfe422e28cmr3445139wro.42.1681665765385;
        Sun, 16 Apr 2023 10:22:45 -0700 (PDT)
Received: from localhost.localdomain ([94.159.161.55])
        by smtp.gmail.com with ESMTPSA id m14-20020a056000008e00b002c71b4d476asm8446889wrx.106.2023.04.16.10.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 10:22:45 -0700 (PDT)
From:   david.keisarschm@mail.huji.ac.il
To:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Jason@zx2c4.com, linux-mm@kvack.org,
        David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>,
        ilay.bahat1@gmail.com, aksecurity@gmail.com
Subject: [PATCH v6 1/3] mm/slab: Replace invocation of weak PRNG
Date:   Sun, 16 Apr 2023 20:22:42 +0300
Message-Id: <20230416172242.13185-1-david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>

The Slab allocator randomization uses the prandom_u32
PRNG. That was added to prevent attackers to obtain information on the heap
state, by randomizing the freelists state.

However, this PRNG turned out to be weak, as noted in commit c51f8f88d705
To fix it, we have changed the invocation of prandom_u32_state to get_random_u32
to ensure the PRNG is strong. Since a modulo operation is applied right after that,
we used get_random_u32_below, to achieve uniformity.

In addition, we changed the freelist_init_state union to struct,
since the rnd_state inside which is used to store the state of prandom_u32,
is not needed anymore, since get_random_u32 maintains its own state.

Signed-off-by: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
---
Changes since v5:
* Fixed coding style issues.

Changes since v3:
* edited commit message.

Changes since v2:
* replaced instances of get_random_u32 with get_random_u32_below
    in mm/slab.c.

 mm/slab.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index edbe722fb..6ac30fd05 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2360,44 +2360,34 @@ static void cache_init_objs_debug(struct kmem_cache *cachep, struct slab *slab)
 
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
 	bool ret;
-	unsigned int rand;
-
-	/* Use best entropy available to define a random shift */
-	rand = get_random_u32();
-
-	/* Use a random state if the pre-computed list is not available */
 	if (!cachep->random_seq) {
-		prandom_seed_state(&state->rnd_state, rand);
 		ret = false;
 	} else {
 		state->list = cachep->random_seq;
 		state->count = count;
-		state->pos = rand % count;
+		state->pos = get_random_u32_below(count);
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
@@ -2418,7 +2408,7 @@ static void swap_free_obj(struct slab *slab, unsigned int a, unsigned int b)
 static bool shuffle_freelist(struct kmem_cache *cachep, struct slab *slab)
 {
 	unsigned int objfreelist = 0, i, rand, count = cachep->num;
-	union freelist_init_state state;
+	struct freelist_init_state state;
 	bool precomputed;
 
 	if (count < 2)
@@ -2447,8 +2437,7 @@ static bool shuffle_freelist(struct kmem_cache *cachep, struct slab *slab)
 
 		/* Fisher-Yates shuffle */
 		for (i = count - 1; i > 0; i--) {
-			rand = prandom_u32_state(&state.rnd_state);
-			rand %= (i + 1);
+			rand = get_random_u32_below(i + 1);
 			swap_free_obj(slab, i, rand);
 		}
 	} else {
-- 
2.37.3

