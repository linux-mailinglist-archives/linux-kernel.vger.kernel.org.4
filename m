Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417FC6E3A73
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDPRXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDPRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:23:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23992115
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:23:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f16ecaade1so4325205e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1681665779; x=1684257779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U0BT2ZCpYUPI7E6k1EPzMhD2H/202NbXqQPGTFxDDWw=;
        b=HMNxx0bK8hE31ibxZod45AEUjfKqhx9YDLC48pJhkMHdpeNrV8gsXpCH4t3VdWc7f7
         NO+QQSFXNSxZYmUT8a3dwyG4YUOQSLXm9uVMqIE99zUNgvEpcSfTN40xLJEfYEgMTZ+E
         LnuWAhr7jTuYFMEuaC/1J5u7m7UMk4YTGUWnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681665779; x=1684257779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0BT2ZCpYUPI7E6k1EPzMhD2H/202NbXqQPGTFxDDWw=;
        b=Bj3I56kCSw+bxw2KVryao5Z/YyhF4mS/507FBOg8nX51cuN+llJt96zHT0GbSQo+3b
         U2sugG96Wpxzft1xjvUnDCBUnIRivbjmmOkRKMrKGLucKglyQ2DvUy+3C5xANPqcgxmr
         cHlZB768VP3UpIpGipEiTZHXq3K3Je9uYUnSEURu6X4Z3Lzp1E7Maz2gM4cT2r1lPG7E
         f9iiOzliLjcAhuFRpEzQf2sv6lrM+RN1596vdZ/7CJuk5o3tgeouCMhBhFg+NnhVpwHm
         HMe+Ml+mDLRXp4Kw6gq8sueflGdbbJmk7W8wF5rAFWicng01P7/PBcjHMOc01n141Idn
         eRag==
X-Gm-Message-State: AAQBX9fzVvn8hxe3ufW5gvyJMxoZyku8CaWk9W6Iu/2nvWQpICR/DO75
        T6WOLFyZGZUGW8DhBWhO+k1bG1yrPowSJxDy7XWOgONap7wSGeJq5k0RZcunVINh3ylABuUMHvS
        3/QoDjLlaFWbN6Z7/T23tU+Nj8yte0rqWZNpeI+1KN7IvYlklnI5Ye4CpUB8iq9x3rVwhzcffUs
        EdWacFaHQ1Qep4QVpTSlUmVFKMqqTe
X-Google-Smtp-Source: AKy350bPNKCeKNVOGxJ1Fcmr0RUi9jCk9TaIvQPpHxxXIsnAjpcnqa58E03BbCwO8sNPm8TqqU2oFA==
X-Received: by 2002:a05:6000:1047:b0:2d1:9c50:5746 with SMTP id c7-20020a056000104700b002d19c505746mr3878699wrx.12.1681665778922;
        Sun, 16 Apr 2023 10:22:58 -0700 (PDT)
Received: from localhost.localdomain ([94.159.161.55])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c155000b003f0a1c18128sm10695660wmg.29.2023.04.16.10.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 10:22:58 -0700 (PDT)
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
Subject: [PATCH v6 2/3] mm/slab_common: Replace invocation of weak PRNG
Date:   Sun, 16 Apr 2023 20:22:55 +0300
Message-Id: <20230416172256.13220-1-david.keisarschm@mail.huji.ac.il>
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
Changes since v5:
* fixed coding style issues.

Changes since v3:
* edited commit message.

Changes since v2:
* replaced instances of get_random_u32 with get_random_u32_below
    in mm/slab_common.c.

 mm/slab_common.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index bf4e777cf..25ca39f97 100644
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
+		rand = get_random_u32_below(i + 1);
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

