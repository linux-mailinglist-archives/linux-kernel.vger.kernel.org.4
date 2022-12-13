Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDEF64B34A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiLMKfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbiLMKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:35:10 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0662AE3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:35:08 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i7so497953wrv.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcm81snaAvsLgdPsKbqh9RbYafXEgWwHDgXsAc2f2dA=;
        b=jhlNuQYySQvQvL6Uv1lSZ1IMINg0FK79EDN0CV5OUD+BLwZapAItJRultyEITusAjH
         dY5WpCO+yByRUG/aNyv6HazOkqMJxVeOAbq6IMZI3bgSI5UEIetWJVfvHBZo3uSVc757
         sajsfcwtGfJObeL7woSMY69Ge4dEJDzzbT8EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcm81snaAvsLgdPsKbqh9RbYafXEgWwHDgXsAc2f2dA=;
        b=Mwjpavuw9C9RGdg/gTLabTcpuAXPPN/7thPP5oDpa/VG8oDKZJ0qIx4RnMYAEIlKpr
         WpA1QRW84tV3UzmqSzdb04iBxE+c4ZZtqwePIvmUe7js+4HY3PqaP8NTJgg30R1nt6+h
         U40UeOqDrIewTRkcwNsiblEnBmym5Y6GclsatvtmyyIZydrh7TGcl7PCa8333xmo2Lf1
         oW6ay3Ujsfae/ED4p/EG5h2EmoCvy3j0KyFsoQaNzF6romzrB4anUUPyXUCY/7B4PfOa
         dQDo15dq+fBdQeE+Z6dOS5/9NRL1SCrY9VlEibsMzcXCINZYx8etuKJbIh5S/30KIax+
         5dTg==
X-Gm-Message-State: ANoB5pkuKh4Otxgd41RBnsqZs3Cptr12qFgLO+ggG3yUz+8qzk8r+MGD
        0YNi27aoHeGAvRWGP6kuBAnjBKYAAwM7D/yeIOu1CC/AQ0Y21APxYBnR8fxOvzemY8v/gNFapSF
        X6oudfsl/VVj3lilYa4503G98adyc6jhQtYg12gY2m0kOfSr9IctyYnRyXXn9+AbDuvAagW6Des
        Aat31Vx/rfz7tImA0slOnidIY=
X-Google-Smtp-Source: AA0mqf7XC1U0EGA3KEebTysApwcRsMqQYYuE8Pmznid50KwZQJWfwQ27ESlhE+0f4xjfKtcIeeIEwQ==
X-Received: by 2002:a5d:4888:0:b0:232:be5c:ec7e with SMTP id g8-20020a5d4888000000b00232be5cec7emr12347268wrq.58.1670927706896;
        Tue, 13 Dec 2022 02:35:06 -0800 (PST)
Received: from MacBook-Pro-6.lan ([2a0d:6fc2:218c:1a00:a0bd:cef2:7a82:b529])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d6b0f000000b002366553eca7sm11295813wrw.83.2022.12.13.02.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 02:35:06 -0800 (PST)
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
Subject: [PATCH v2 2/3] Replace invocation of weak PRNG inside mm/slab_common.c
Date:   Tue, 13 Dec 2022 12:34:58 +0200
Message-Id: <c486826064e8c36ad44e5b4d0bcbd18af4ef6d0f.1670890407.git.david.keisarschm@mail.huji.ac.il>
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
 of prandom_u32_state to
 get_random_u32. We also omitted
the initial seeding for the state,
since get_random_u32 maintains
 its own, so there is no need
 to keep storing the state of
 prandom_u32_state here.

Signed-off-by: David <david.keisarschm@mail.huji.ac.il>
---
 mm/slab_common.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index b79755716..6ac68b9a6 100644
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
-		rand = prandom_u32_state(state);
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

