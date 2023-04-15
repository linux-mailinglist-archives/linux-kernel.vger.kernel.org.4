Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC506E32EE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 19:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjDORhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 13:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjDORhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 13:37:17 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1FB35AB
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 10:36:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so9746639wmb.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1681580196; x=1684172196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tywA8rmVIJzBGfSKBGfQ/D1/dGwROMgtT/yYwruYZtg=;
        b=X+bgruq6dNzBiAoOzk73n13dkmLGsZTRPczDLborRgY8ILMNsH+k2EQianqKzoF3Ds
         EiXqmlR8iAP970UTDyw9xkiSXJLirO4/JRe+3eArCawKufVwYuhiC101IV7hxygx8mB9
         qfN//B2ITyw8OyXJ6g970zP6I77vwk1n/WO80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681580196; x=1684172196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tywA8rmVIJzBGfSKBGfQ/D1/dGwROMgtT/yYwruYZtg=;
        b=gqOV78hovIF9Q2hjNWqg5nOSQ4srZGVxnxLoD+KYROJDtvCH87YrRO7x8y7KUxQw7M
         qLPE6L/flqMBqaaykNKRSHYnK3EfoduAo1npELUnE8ntAQcIbaLQx0KrKV2+c3aUAUQR
         LF/q78vP2zT//pXO7AHSFABPczt/kcChfKRfTcMuH1sNw8vkfyhUHzyL1um0Hii1C8yk
         PBB9kAo0YKYpH53f7EFQ+Pbb/KGgx+UAUEBPceHRGKdZyWXxmIL4Ol2RYXsvwatk0A3Z
         soPK6EnLziM+9OY47drZOW4AI2G7ZdSTfUjSgPBMZ8Bwx3V6dJBPgNLfyH/v36qKwDIl
         LyEQ==
X-Gm-Message-State: AAQBX9eYqUKYKM3enwCJZAe3SJZlWrZ4hm/ZWZG+MZxQ5l2t1Ln9gMPD
        +JcKnrJ3h03CsDjmyy2in/5UrM41FzKH4E7oSVN54b86kKNhDB7rT6Pao1PLR/LOka8l7CeXds1
        prPombrfsrXIZRk+lb0WaAZ4Znctjk3OjcCRgngXhRYgC8OhRKrfyVzfJokhI2irOmJpqOJnAGN
        YOHaJKmZ0ckma4RaCxPHXBvYYUeA==
X-Google-Smtp-Source: AKy350a0uPA1FB4zfUmQJQYkReVdccdEX2m3gYR5CuipNp/6PlquyjnM03BQxqQUt7Q9RdcVC8yVQg==
X-Received: by 2002:a1c:e903:0:b0:3f0:a023:2614 with SMTP id q3-20020a1ce903000000b003f0a0232614mr6624420wmc.6.1681580195782;
        Sat, 15 Apr 2023 10:36:35 -0700 (PDT)
Received: from localhost.localdomain ([94.159.161.55])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c3b0200b003f0652084b8sm10869481wms.20.2023.04.15.10.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 10:36:35 -0700 (PDT)
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
Subject: [PATCH v5 1/3] Replace invocation of weak PRNG
Date:   Sat, 15 Apr 2023 20:36:32 +0300
Message-Id: <20230415173633.5422-1-david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
This fifth series changes only the arch/x86/mm/kaslr patch.

Changes since v3:

* edited commit message.

Changes since v2:

* replaced instances of get_random_u32 with get_random_u32_below
    in mm/slab.c.

 mm/slab.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index edbe722fb..7c8bb4a8f 100644
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
2.37.3

