Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FE065045C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 19:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiLRSb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 13:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiLRSag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 13:30:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A720325E
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 10:19:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id f18so6808243wrj.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 10:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxOVYuVq/X+wMyFtAUZVP/vn8iM2+0/FONR0L0o4f6Y=;
        b=bIRi4qS0xObNxq2NJbimJJbiscll/li4ZIHTuaFwaogZVUmw8PMIMTCT/P/wSMIFk7
         1Slz2Mj8BFmP3NDbsxicq/Xi7En7reJxQkzZm7O6VbNhmctu5jbYAypz6DV+y/Be61/x
         r2mqKihv0VElhclr06/+OZ+jHAUwsSP3hHAbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxOVYuVq/X+wMyFtAUZVP/vn8iM2+0/FONR0L0o4f6Y=;
        b=R7XIg2XPcueQOb90bfNv9kWZSUeY0iDmOdwVt/3RGwQwF0xK0AN5P6We6AqefMOwqO
         z7ZMsXwkwz9l6+wgiXjceyRz6q7m9NaXKDXg9rDlVay01h+jxOsTVTNrO0AxD2WjwU7V
         gsH496eyr6gcsA1lzdziElH/n7B/gWSIcD5xSsX88QP2vL1kAITO0olhRVW4cOLfnFws
         JnCFD/BwwXnVNO9a5kBX1qXR0etA/zqxp/kWGclK1Ax1dy/FvPwMqVKb0jamT+Gektmi
         6+EVjF2edSoN9vmjbbP/sWdquXaNbqDVIjjFCuFxPM1IE9S4OF7wshNqMsgZS99M9mGW
         cnDw==
X-Gm-Message-State: ANoB5pmZnj1tCA9fgB4YUV8B+3iaxuTVDi4rgshKXB3n9TQ0Pq3+3FXy
        4b3RNvnobF+yBZsh5w47KuJdIPponmerT91n4dJlvrKwayxtRwqHpaO1dIf41L+19h41lRzS5ZI
        5kkTRGoSW1HJx88JpxoD/1M6IxOoAMTHFcj1Lf2U78yj9SKTTHPvZfLwp77p3UNNk3yDqQH8C9m
        Vq2gQw6ePoHTswV43SCaURyXegqg==
X-Google-Smtp-Source: AA0mqf69tXac6Ox1a1XH9//n3JRRS4LTfzZGXQAYlk5AfLKnbgNU1WSL10hQ4YUWlbCjwir8hfgz1Q==
X-Received: by 2002:adf:a459:0:b0:242:798:53d9 with SMTP id e25-20020adfa459000000b00242079853d9mr34143700wra.40.1671387548998;
        Sun, 18 Dec 2022 10:19:08 -0800 (PST)
Received: from MacBook-Pro-6.lan ([2a0d:6fc2:218c:1a00:c45e:1c4b:fab4:ee34])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600003cd00b0024cb961b6aesm7956489wrg.104.2022.12.18.10.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 10:19:08 -0800 (PST)
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
Subject: [PATCH v3 2/3] Replace invocation of weak PRNG inside mm/slab_common.c
Date:   Sun, 18 Dec 2022 20:18:59 +0200
Message-Id: <7f67fa53597058abd8aeb586df91551b118c3527.1671277662.git.david.keisarschm@mail.huji.ac.il>
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

The Slab allocator randomization inside slab_common.c uses the prandom_u32 PRNG.
That was added to prevent attackers to obtain information on the heap state.

However, this PRNG turned out to be weak, as noted in commit c51f8f88d705
To fix it, we have changed the invocation of prandom_u32_state to get_random_u32
to ensure the PRNG is strong.

Since a modulo operation is applied right after that,
in the Fisher-Yates shuffle, we used get_random_u32_below, to achieve uniformity.

# Changes since v2

* edited commit message.
* replaced instances of get_random_u32 with get_random_u32_below
    in mm/slab_common.c.


Signed-off-by: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
---
 mm/slab_common.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 0042fb273..e254b2f55 100644
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
@@ -1141,8 +1141,7 @@ static void freelist_randomize(struct rnd_state *state, unsigned int *list,
 
 	/* Fisher-Yates shuffle */
 	for (i = count - 1; i > 0; i--) {
-		rand = prandom_u32_state(state);
-		rand %= (i + 1);
+		rand = get_random_u32_below(i+1);
 		swap(list[i], list[rand]);
 	}
 }
@@ -1151,7 +1150,6 @@ static void freelist_randomize(struct rnd_state *state, unsigned int *list,
 int cache_random_seq_create(struct kmem_cache *cachep, unsigned int count,
 				    gfp_t gfp)
 {
-	struct rnd_state state;
 
 	if (count < 2 || cachep->random_seq)
 		return 0;
@@ -1160,10 +1158,7 @@ int cache_random_seq_create(struct kmem_cache *cachep, unsigned int count,
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

