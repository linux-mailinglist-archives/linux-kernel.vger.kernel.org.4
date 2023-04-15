Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2116E32EF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 19:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDORhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 13:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjDORht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 13:37:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD2F30D5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 10:37:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-2f833bda191so268794f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1681580212; x=1684172212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=btXnur/uyYMbjwgO0AOsG6yRAGjdTQoh5XcEl+ajryQ=;
        b=qy4P3GExn1lX3wwxj5pPfbl8w8fiET5D/DX0oc0EbOtkwIhyzp0NyCiK0iyhAl6Pcd
         so37v8GFLOwjlXSJ6VCgyyru/KnWOxVJml5yf2oETGgmLD0Z/67YvFnkmRaQXSK37g2A
         Nd72weySDyAYhl2wEai5nZDJgnU6SWiKMLrVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681580212; x=1684172212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btXnur/uyYMbjwgO0AOsG6yRAGjdTQoh5XcEl+ajryQ=;
        b=ILtWym90qzzshX3PrmGHYC1H78kD88dqvgz6M6kBHObh6KXLVihWdZnt4zHMyyfd6L
         Nq+4Gc+piHwYDOG6cwcQyk0WBAEjbgHsXPLJFM2vGfV2GvGpcU8iTtP3F3dZ39xyYpJZ
         Lw902WZ5M5aWAA1LocQNb7jxCfQk/xPpwqtXk3sUdCqBiODgs+uBu5j+H/1ShZ+4Uynx
         zTbpwSa0nQ6EJWaNUBhGGd4zcPDAqj7CTO8yVKyiH/n1Xz8DLVY8jzxiKQYMidHMS/kp
         LVLCBYyrN9B5kHswnjbJge6QMRzsSFy4KqW7gx0aaEV9t+5Uo2fnSJipPC1eqsKBT3WP
         w/zg==
X-Gm-Message-State: AAQBX9fp8O9kt0U+pNCARi6tDDMC1wn/A2CdFP25jRIB41K/yStvn3ZW
        oIQ0r8CEgKDO2mkZHk3HHolvtFSk6rEUp4c3OOINJDf/U18yRy5TLKpSPZEAMdinKyOZ/wehG3I
        oUVkwSekkQa4P1k73RAGnDcasa/I5oITC1Jt11AjivAXuvmxoIQEunj//e0TB6HZLPUqulV4HIc
        9gjPDIVwv+j1kh4ck94xpwxicc6A==
X-Google-Smtp-Source: AKy350Yw2DvODcU0LyZc5dt8e7tecCHCDI5sRahgN6NRKckTItk3WHz8ZLEfSmzjfzCiF6wzH174DA==
X-Received: by 2002:a5d:634e:0:b0:2f6:bf14:f89 with SMTP id b14-20020a5d634e000000b002f6bf140f89mr1998852wrw.20.1681580212483;
        Sat, 15 Apr 2023 10:36:52 -0700 (PDT)
Received: from localhost.localdomain ([94.159.161.55])
        by smtp.gmail.com with ESMTPSA id f24-20020a1cc918000000b003ee63fe5203sm7167052wmb.36.2023.04.15.10.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 10:36:52 -0700 (PDT)
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
Subject: [PATCH v5 2/3]  Replace invocation of weak PRNG
Date:   Sat, 15 Apr 2023 20:36:49 +0300
Message-Id: <20230415173650.5458-1-david.keisarschm@mail.huji.ac.il>
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

The Slab allocator randomization inside slab_common.c
uses the prandom_u32 PRNG. That was added to prevent attackers to obtain
information on the heap state.

However, this PRNG turned out to be weak, as noted in commit c51f8f88d705
To fix it, we have changed the invocation of prandom_u32_state to get_random_u32
to ensure the PRNG is strong.

Since a modulo operation is applied right after that,
in the Fisher-Yates shuffle, we used get_random_u32_below, to achieve uniformity.

Signed-off-by: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
---

This fifth series changes only the arch/x86/mm/kaslr patch.

Changes since v3:
* edited commit message.

Changes since v2:

* replaced instances of get_random_u32 with get_random_u32_below
    in mm/slab_common.c.

 mm/slab_common.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index bf4e777cf..361da2191 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1146,7 +1146,7 @@ EXPORT_SYMBOL(kmalloc_large_node);
 
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
 /* Randomize a generic freelist */
-static void freelist_randomize(struct rnd_state *state, unsigned int *list,
+static void freelist_randomize(unsigned int *list,
 			       unsigned int count)
 {
 	unsigned int rand;
@@ -1157,8 +1157,7 @@ static void freelist_randomize(struct rnd_state *state, unsigned int *list,
 
 	/* Fisher-Yates shuffle */
 	for (i = count - 1; i > 0; i--) {
-		rand = prandom_u32_state(state);
-		rand %= (i + 1);
+		rand = get_random_u32_below(i+1);
 		swap(list[i], list[rand]);
 	}
 }
@@ -1167,7 +1166,6 @@ static void freelist_randomize(struct rnd_state *state, unsigned int *list,
 int cache_random_seq_create(struct kmem_cache *cachep, unsigned int count,
 				    gfp_t gfp)
 {
-	struct rnd_state state;
 
 	if (count < 2 || cachep->random_seq)
 		return 0;
@@ -1176,10 +1174,7 @@ int cache_random_seq_create(struct kmem_cache *cachep, unsigned int count,
 	if (!cachep->random_seq)
 		return -ENOMEM;
 
-	/* Get best entropy at this stage of boot */
-	prandom_seed_state(&state, get_random_long());
-
-	freelist_randomize(&state, cachep->random_seq, count);
+	freelist_randomize(cachep->random_seq, count);
 	return 0;
 }
 
-- 
2.37.3

