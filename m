Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180B866A52E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjAMVfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjAMVfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:35:47 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7617F033
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:35:45 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q10so2911597wrs.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUN/ktfr557NsAgFfe15xaS8LcaziSyCzLEF8bg3s5M=;
        b=BIRAK53OfezEtN8URwkxVmK5kppDX4q8H2bA72tfN4L+0MiD/i6fPkbEX33sWodGUh
         dAz6/hc5downSGqBmpfb/UfyZc6qVW2rqslcGZ0rZnsvcOtDJwYMUmqXIBB4iKiJbewI
         mTmFX3o2MDXeQv6DuDGQJ/6okhKQvCwCaFQd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUN/ktfr557NsAgFfe15xaS8LcaziSyCzLEF8bg3s5M=;
        b=PwjuREpOJFneaw89JqVfzhDi5io/XmlPFGSQ98Fk/RADg2iXG6jdcgu2id/pj4AINj
         wXpJAjiMBkI5tulsJUAWnLNUqpdYc8czNXD0nHuK6RlSGu47zy3v0POQGKTU+kdF/dU8
         8JmSQSJXlS+67ZtnCR35qDHtn2zX7Q7PbdTCsBSJWnjMl5SdTGlpkm58XFoQaA8w9Umz
         59wnb/d+mhspVDkjpv2eqKnHwl9iWunBm9iazFkssiP3wQJKk+ey9dFx0sWgbqRpI+Ke
         P1LM/+liWygGLHA2qcEAqE0lhqTvBmYZ++BMFa+RHrPYrNw5aKnGb1BQgbuPZMU1wiyU
         O2dQ==
X-Gm-Message-State: AFqh2krXoiXVb4DMc9rdzG+9DS8Ji+tqnC6YPGys9AHdmiDZB5Jr5SsP
        46w7R1dAG3iLJdUndLls5rJaxYaWlAXcvCk3kcm7Va3h1KTiVeZ+fRUVHv7i5oRK049rQ+2De/T
        UbvPOZG/DkcDR2Lyj8NmDiLA7cypBNL2rWhwgWeDW5Je4V8ynD8dB6D+cWCa+hzPgFgso7UkPrC
        T5w65a9Ep5HRu6jv81Jd5ZJdY=
X-Google-Smtp-Source: AMrXdXvE/8rU7gIEorncZU3DBDT4X3Eg5QqP/DvVq2f1hnYANi/szg8il3w3o9R1s/fOXCWai3RgUA==
X-Received: by 2002:a05:6000:1707:b0:2ae:d9e2:7c80 with SMTP id n7-20020a056000170700b002aed9e27c80mr28262611wrc.8.1673645744176;
        Fri, 13 Jan 2023 13:35:44 -0800 (PST)
Received: from MacBook-Pro-6.lan ([2a0d:6fc2:218c:1a00:2dd5:e78e:71c0:661b])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4010000000b002bbed1388a5sm14508089wrp.15.2023.01.13.13.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 13:35:43 -0800 (PST)
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
        aksecurity@gmail.com, ilay.bahat1@gmail.com
Subject: [PATCH v4 1/3] slab_allocator: mm/slab.c: Replace invocation of weak PRNG
Date:   Fri, 13 Jan 2023 23:35:40 +0200
Message-Id: <c64c1b08c60dee2a2d7f18d42acad71c2b271711.1673470326.git.david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1673470326.git.david.keisarschm@mail.huji.ac.il>
References: <cover.1673470326.git.david.keisarschm@mail.huji.ac.il>
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

The Slab allocator randomization uses the prandom_u32 PRNG.
That was added to prevent attackers to obtain information on the heap state,
by randomizing the freelists state.

However, this PRNG turned out to be weak, as noted in commit c51f8f88d705
To fix it, we have changed the invocation of prandom_u32_state to get_random_u32
to ensure the PRNG is strong. Since a modulo operation is applied right after that,
we used get_random_u32_below, to achieve uniformity.

In addition, we changed the freelist_init_state union to struct,
since the rnd_state inside which is used to store the state of prandom_u32,
is not needed anymore, since get_random_u32 maintains its own state.

Signed-off-by: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
---
Changes since v3:
* edited commit message.

Changes since v2:
* replaced instances of get_random_u32 with get_random_u32_below
    in mm/slab.c.


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

