Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E05A6496B1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 23:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiLKWQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 17:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiLKWQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 17:16:28 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1F5CE2E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 14:16:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h12so10289986wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 14:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haTxffWmHSbAPwv39fal7v0AA4S/hzfP5R1mLvgRpek=;
        b=UbLp/WJdGEjbrNFkSsIuV78VgoO68KxhGH2WYTQpJtOfXrKCllm7Y+e+mOcVYVBjmd
         54ZjcvsZUdzXyeVth+DloJ5pZNO1lLMOm4QQA5AqbesJaSqGG0SKj2+MBqhmW8fczXDm
         rFe1P4tp6xRSDbJjsqwUHsIkj5X77hGVZleuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haTxffWmHSbAPwv39fal7v0AA4S/hzfP5R1mLvgRpek=;
        b=ly1iJ/63ZiQH490nnUBBWg3lFleruNDCM+ev5Oko1hLXgWXJxmR5M8Yy0/85ZrwVU2
         ieIJHajL9jhYxZ8qM2DgN5Y5BzcD8GhJFjMJ/bSjf7oC6CcMuaXYqF4GwRVx7CBOz5fv
         CpgJNQkkZy5SitFIP3QwnwpP0zTp+3ucBHEa3XqTwacl7d3O2/LEBn4xFhIhiiVFcgfc
         zHHNunghvGE7YvKukdT9rPaAae+VNSY2cWq7wRAzOF4xX1NUL62zcQHcLlefy2n8FTtr
         2ztfZ+jMw1OGhZKFlB0AISrRV//y8TiBdCH+SBwAgtTlBrQfGv9DacZrJQItAslpdtHs
         T6Kg==
X-Gm-Message-State: ANoB5pmf+IXA+7GnczS+txTFVo9zILwYLozc+2xjjzQ58itpuiaSgCwa
        Ap4Owj8HZxzBTxG7rsV4xQdgHA==
X-Google-Smtp-Source: AA0mqf4+pbXX8gZcvwBJDDX/GsbtFqpKUq1E1bX85Vp1pP715Zv9EOXv/m3uGnNCBqE5llnuBJD80w==
X-Received: by 2002:a5d:4090:0:b0:24d:5829:4e59 with SMTP id o16-20020a5d4090000000b0024d58294e59mr4060976wrp.58.1670796987434;
        Sun, 11 Dec 2022 14:16:27 -0800 (PST)
Received: from MacBook-Pro-5.lan ([2a0d:6fc2:218c:1a00:a91c:f8bf:c26f:4f15])
        by smtp.gmail.com with ESMTPSA id d7-20020adffd87000000b002422bc69111sm8605805wrr.9.2022.12.11.14.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 14:16:27 -0800 (PST)
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
Subject: [PATCH 4/5] Replace invocation of weak PRNG inside mm/slab_common.c
Date:   Mon, 12 Dec 2022 00:16:07 +0200
Message-Id: <095bc8aafcc97d6a53d1f946a9528b10a826116d.1670778652.git.david.keisarschm@mail.huji.ac.il>
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

We changed the invocation
 of prandom_u32_state to get_random_u32.
 We also omitted the initial seeding for the state,
 since get_random_u32 maintains its own,
 so there is no need to keep
storing the state of prandom_u32_state here.

Signed-off-by: David <david.keisarschm@mail.huji.ac.il>
---
 mm/slab_common.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index deb764785..6ac68b9a6 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1130,7 +1130,7 @@ EXPORT_SYMBOL(kmalloc_large_node);
 
 #ifdef CONFIG_SLAB_FREELIST_RANDOM
 /* Randomize a generic freelist */
-static void freelist_randomize(struct rnd_state *state, unsigned int *list,
+static void freelist_randomize(unsigned int *list,
 			       unsigned int count)
 {
 	unsigned int rand;
@@ -1141,7 +1141,7 @@ static void freelist_randomize(struct rnd_state *state, unsigned int *list,
 
 	/* Fisher-Yates shuffle */
 	for (i = count - 1; i > 0; i--) {
-		rand = predictable_rng_prandom_u32_state(state);
+		rand = get_random_u32();
 		rand %= (i + 1);
 		swap(list[i], list[rand]);
 	}
@@ -1151,7 +1151,6 @@ static void freelist_randomize(struct rnd_state *state, unsigned int *list,
 int cache_random_seq_create(struct kmem_cache *cachep, unsigned int count,
 				    gfp_t gfp)
 {
-	struct rnd_state state;
 
 	if (count < 2 || cachep->random_seq)
 		return 0;
@@ -1160,10 +1159,7 @@ int cache_random_seq_create(struct kmem_cache *cachep, unsigned int count,
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
2.38.0

