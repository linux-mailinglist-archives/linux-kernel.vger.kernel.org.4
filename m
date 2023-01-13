Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D9366A530
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjAMVh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjAMVhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:37:53 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5CAE7D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:37:50 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j34-20020a05600c1c2200b003da1b054057so3920669wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TF4yl0qyemn80KbaOcWcMV7jh9ZuWBx78qicss9uQc=;
        b=p1ndSiVOwC15bI8PmJFG+sQFPFJP0t7Nb2kQN1/L1cRjs7817uXGxSoGRkPnYDtV6C
         S0DyVESqxTkJhavAAUaFaPVxERTTTYzOT/qD3O+CtZ+gHMZNTqKPpjvSOZm7IgSJAlzY
         iKLh98QZQTcQnkUG8so+tEhkdC0HTSTYZ3OvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TF4yl0qyemn80KbaOcWcMV7jh9ZuWBx78qicss9uQc=;
        b=Ij716rwiGSPjXvVASi6Tj1OvjfLtYnl2AfUg4kSMrRRoDs56yMie2rZe/2UziwtiYu
         nEJE3GM1ocTAVhXIBjAsNxsYuGiYiJ22XP82PO9wX7Mb2tGYnem1cXEAUOJ65R227glH
         TMoit8iM3wSgu9ViR3LzITUKMfXNDV7sXtrLpyT/dgypCW3V7qvICVIU9Wbbh2G9v9Jp
         2Tbr1O6bMSBdKCMTj/Qi/1A7aOS/8VNHIjl07Xewy8S72L54KeXn0dMbbOELDtuXBHgA
         0b4mQPHvhH14EB3YVRpmTxLj+5apdkpoJRwTbquP6fmM007hKo7lmRtXZzIyMtRuudJ6
         hDIw==
X-Gm-Message-State: AFqh2kpyfGa+EWll0p50FN4L0/tjAUsXKvI4hGs+snmBTuMpol0lgR6Q
        LwmwvFbKKt4rAR8SuR8kefZKXqiam+DQbeEeZ9Ktm/vuRPsVou7RR6vAfGxHbNo6KTjsoAtU496
        AWQjm1cL3nP5fKyKuICZ9ExPjB0jT+v6P/uxuwlMOqjNVxxKbEqcDo893S23jPTcogoVIWaRBjm
        IEOjY4umfPUcZtG0UMXIWa2Sk=
X-Google-Smtp-Source: AMrXdXtXqloDtFhx4OVf2TNQBeviRbt9VacFPJc7UOTi8ZcQ2RpkAcNb16kTYI3wvQIaO+jNjFrG9Q==
X-Received: by 2002:a05:600c:3b14:b0:3cf:d18e:528b with SMTP id m20-20020a05600c3b1400b003cfd18e528bmr886119wms.39.1673645868866;
        Fri, 13 Jan 2023 13:37:48 -0800 (PST)
Received: from MacBook-Pro-6.lan ([2a0d:6fc2:218c:1a00:2dd5:e78e:71c0:661b])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003da2932bde0sm319944wmq.23.2023.01.13.13.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 13:37:48 -0800 (PST)
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
Subject: [PATCH v4 2/3] slab_allocator: mm/slab_common.c: Replace invocation of weak PRNG
Date:   Fri, 13 Jan 2023 23:37:45 +0200
Message-Id: <fa85216179a1e3ce104a1b3526a01626f0af0024.1673470326.git.david.keisarschm@mail.huji.ac.il>
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

The Slab allocator randomization inside slab_common.c uses the prandom_u32 PRNG.
That was added to prevent attackers to obtain information on the heap state.

However, this PRNG turned out to be weak, as noted in commit c51f8f88d705
To fix it, we have changed the invocation of prandom_u32_state to get_random_u32
to ensure the PRNG is strong.

Since a modulo operation is applied right after that,
in the Fisher-Yates shuffle, we used get_random_u32_below, to achieve uniformity.

Signed-off-by: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
---
Changes since v3:
* edited commit message.

Changes since v2:
* replaced instances of get_random_u32 with get_random_u32_below
    in mm/slab_common.c.


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

