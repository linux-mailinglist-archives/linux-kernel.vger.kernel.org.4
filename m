Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C194B6496B0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 23:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiLKWQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 17:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiLKWQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 17:16:28 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2E4DE88
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 14:16:26 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h7so10307372wrs.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 14:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zM8KEovEBPpuDpU7J5nrYIVpuEqDseyeMIrsp4iQznI=;
        b=fWKZ9AyL/cITc+iqt3VV5VKWgDaeRzwAk2ZBkHGdlAsfED8yw9QZsYVlvaF0m6MBrK
         WVS5xYAnIG/aiFcxxZayewGR0nVoRWNeAPy8fdwmVZKrovRizmZEv3AonkIYuwTR2VbR
         ipyYIpxN6IgV4M3EMaYlBX6qyfqYkyHcILUeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zM8KEovEBPpuDpU7J5nrYIVpuEqDseyeMIrsp4iQznI=;
        b=eqQXt5jTDCpumT323xi8rZlFzV+l+Rxv13jgYWXLnEjJkwvhbZbcD7jOhC2t+kPgcX
         kgT4UyIXfB/OPzkUVxDN9Hjj/jQRx2Y1fUBzuEkYm+BGdFCJGkHOb72LJC1d6jrEAqu9
         GkVnV8HpVB5RBixiFVxQ/rF/I/6Ocx9bVVFrsccfWgebh6U0nFm7vCQa2e9C/olv9FoJ
         5n5g9dpuSWzLXbv6QzmVOyJyScTPA7YtjAlhajWz+wVOFQdAya0+AG89VeDTuk7VqQ65
         bzR2LrGB7TleDMgc76SlGizlVTR+aOJYgAVkrC3xaPaYgpgqO/P8wRLtkRMphMCnU08J
         Auuw==
X-Gm-Message-State: ANoB5pmzkfmzObvfcth5ske6aR8+SsCbw2O1ys3VnyF8v+KPPZRH0u3c
        GZdt0NrwGUsk5eyYa1yaoSnkig==
X-Google-Smtp-Source: AA0mqf5QscAKPqWC/oCh0m4RyFsDHTkAHL/kHN3AUFV3csBH/BHNtmhVewKthz4gV534opneQKsf0g==
X-Received: by 2002:adf:f205:0:b0:242:1809:7e17 with SMTP id p5-20020adff205000000b0024218097e17mr8808872wro.6.1670796985307;
        Sun, 11 Dec 2022 14:16:25 -0800 (PST)
Received: from MacBook-Pro-5.lan ([2a0d:6fc2:218c:1a00:a91c:f8bf:c26f:4f15])
        by smtp.gmail.com with ESMTPSA id d7-20020adffd87000000b002422bc69111sm8605805wrr.9.2022.12.11.14.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 14:16:24 -0800 (PST)
From:   david.keisarschm@mail.huji.ac.il
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     David <david.keisarschm@mail.huji.ac.il>, aksecurity@gmail.com,
        ilay.bahat1@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Replace invocation of weak PRNG in mm/slab.c
Date:   Mon, 12 Dec 2022 00:16:06 +0200
Message-Id: <18076e09f1062f38f5d02e8fefb73b810f437ca3.1670778652.git.david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1670778651.git.david.keisarschm@mail.huji.ac.il>
References: <cover.1670778651.git.david.keisarschm@mail.huji.ac.il>
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

We changed the invocation of
prandom_u32_state to get_random_u32.
 We also changed the freelist_init_state
to struct instead of a union,
since the rnd_state is not needed anymore -
 get_random_u32 maintains its own state.

Signed-off-by: David <david.keisarschm@mail.huji.ac.il>
---
 mm/slab.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index ff71c5757..1476104f4 100644
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
-			rand = predictable_rng_prandom_u32_state(&state.rnd_state);
+			rand = get_random_u32();
 			rand %= (i + 1);
 			swap_free_obj(slab, i, rand);
 		}
-- 
2.38.0

