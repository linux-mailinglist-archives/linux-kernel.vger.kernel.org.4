Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E7D5F06D2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiI3Ir4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiI3Iru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:47:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B800F184834
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:47:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a14so4072997ljj.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=9r3yesNDvHF4bI/ZQd/yVIvjI+ovfbKRt9UlHzDBDpo=;
        b=KfosB4NAN7pSi65zOuKl6MqdYNvxNGjMc5XHljAR+dfJackmXebe762Tjt48NOGNr/
         DTmH17WfE2LpJm6IsKqLFIit9HGQseO8ewXWz78506AA67yDILD9peZde8RhU/BlrQTE
         iO4/R6MdoPLMaWOlJMD5R+9IDanymmQizVBA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9r3yesNDvHF4bI/ZQd/yVIvjI+ovfbKRt9UlHzDBDpo=;
        b=Sc71BQ2P7Z6om+1HvAATc6CdjVhV1DugI3FETRJvPuhNR+F+94dj/kFQFMaxhDlli6
         NbAwr5Bs/8ex5ZEkYd9mx+fnNwa2wHMIHL0437zxycapOMNoFm/V7F/89WtcJTyG+xwR
         CEPUTwxY3bRpXyZT5jSYm6xSy5nX7n+X4SehDVwmbzfEJRdrcY5RLly2AWutB7eGDjGt
         n4xO9TKaSUB4XdzqhltbhzO2j2EWBBj2mS1jm5Sw14sIgdf53lJcQvM0rSYSdBck8ow8
         fYBMioDkdzViMNRmK2Md8nFtcP/NflPuC45HhH/HGUg7e9ivBZYzEi6x7+PTesqxwzTI
         kW8w==
X-Gm-Message-State: ACrzQf1dXG8QtlEqZnjBHb8/LcPGWlGuH7VienUxlH6tnfmjkMdR9wJ/
        KGlyA4VPzVKEuMPgT6POjhJ/6A/weK/wgUOM
X-Google-Smtp-Source: AMsMyM71wkHFcOEk79iv6oi8Ae75Va/dkrh2wttVeG5BtQiRnK39kt/pfONL87ULjT9ywBHtArQpiA==
X-Received: by 2002:a2e:90da:0:b0:26c:8dc:3c52 with SMTP id o26-20020a2e90da000000b0026c08dc3c52mr2624000ljg.474.1664527665386;
        Fri, 30 Sep 2022 01:47:45 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id k21-20020a05651210d500b00494618889c0sm230691lfg.42.2022.09.30.01.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 01:47:44 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: slub: remove dead and buggy code from sysfs_slab_add()
Date:   Fri, 30 Sep 2022 10:47:42 +0200
Message-Id: <20220930084742.771804-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function sysfs_slab_add() has two callers:

One is slab_sysfs_init(), which first initializes slab_kset, and only
when that succeeds sets slab_state to FULL, and then proceeds to call
sysfs_slab_add() for all previously created slabs.

The other is __kmem_cache_create(), but only after a

	if (slab_state <= UP)
		return 0;

check.

So in other words, sysfs_slab_add() is never called without
slab_kset (aka the return value of cache_kset()) being non-NULL.

And this is just as well, because if we ever did take this path and
called kobject_init(&s->kobj), and then later when called again from
slab_sysfs_init() would end up calling kobject_init_and_add(), we
would hit

	if (kobj->state_initialized) {
		/* do not error out as sometimes we can recover */
		pr_err("kobject (%p): tried to init an initialized object, something is seriously wrong.\n",
		dump_stack();
	}

in kobject.c.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 mm/slub.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4b98dff9be8e..04a7f75a7b1f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5937,11 +5937,6 @@ static int sysfs_slab_add(struct kmem_cache *s)
 	struct kset *kset = cache_kset(s);
 	int unmergeable = slab_unmergeable(s);
 
-	if (!kset) {
-		kobject_init(&s->kobj, &slab_ktype);
-		return 0;
-	}
-
 	if (!unmergeable && disable_higher_order_debug &&
 			(slub_debug & DEBUG_METADATA_FLAGS))
 		unmergeable = 1;
-- 
2.37.2

