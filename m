Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997A55FF872
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 06:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJOEen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 00:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJOEel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 00:34:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A899E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 21:34:35 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gf8so6606995pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 21:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TPDhjKmk3ApEu3jvJvKzYDjHE8g/IRJ8TwRkyx2nzjs=;
        b=HkV+O9seq0CJgkveVWp+jhhU3Frhx8ed3q7VPN7T7t+LSwRYfLEdktC8MT7SydK3E+
         s05PH1scaQT4RHsuTElXFlfY/B3DD6fJ4txF39LzDBF20GcUIY4FF3s9wSX95sc90hWx
         nOE9yKjgMl8VVBPBg5l2RXAKIXOSg3zuvyd9LtlSZNZkaDR8xf+xNysEmIcvBg07vsI0
         pdDWzio85rtm0aBLEN66vpHVySQDRkZUoGnxSB93bJxGtvjUM/R8I2zVE0FMlVpS1c99
         vsiVUkGszV4iF+Pr6vFcMP3raFRj8MSxdwqPske/Hh+HUITESZYWd/XJCx3EmmncPRO5
         O6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPDhjKmk3ApEu3jvJvKzYDjHE8g/IRJ8TwRkyx2nzjs=;
        b=eo23AhIi4wVwC60yDaA2xxC/68vThgHBctzcpfwQjMErjJJtqTayRiZQDYhp6LLTD+
         TfZiXnZQoL6pt//9NGggcvTi/H/f/lP5o5KQ4ORY6/BAPYGA7r/O6ab/dUkdi3bQged+
         t8rKFImJ+0EPNGIGiaiDRxzflw4CSgsfvdKJxf3tYfwSUraWHU1dqOp8UTfddfiGR/b8
         TyuIU/XMDIgKV9//OoACwTGvLsad8vi0GDCPWAOS/gMpV9mx1Xpx/JdX2dY3TU2b2bmo
         q3rMWAAYYRh5sdW2SKMV5EtP66/7KF66QbwZ/gkwDm6vkqzPRUeyyILmAK9yHC9QPsT/
         zSGA==
X-Gm-Message-State: ACrzQf23XquB+ETkPyp29Wwd0KV1X/vKmOPTX72+H7qlSR9KhtOKsWL+
        UlGVVfIacH6u1U4icnXI63w=
X-Google-Smtp-Source: AMsMyM6pgV8SYoXuIxXiDSPpJ0linvrCw2sX0HpnBEglIDEFlWuS7kC0ynShA9slKGmqgws/5pEOMw==
X-Received: by 2002:a17:903:234f:b0:17f:6711:1f9f with SMTP id c15-20020a170903234f00b0017f67111f9fmr1204421plh.32.1665808475299;
        Fri, 14 Oct 2022 21:34:35 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902784100b00172b87d9770sm2487852pln.81.2022.10.14.21.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 21:34:34 -0700 (PDT)
Date:   Sat, 15 Oct 2022 13:34:29 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slab: use kmalloc_node() for off slab freelist_idx_t
 array allocation
Message-ID: <Y0o4VaBjksRjb6c8@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014205818.GA1428667@roeck-us.net>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit d6a71648dbc0 ("mm/slab: kmalloc: pass requests larger than
order-1 page to page allocator"), SLAB passes large ( > PAGE_SIZE * 2)
requests to buddy like SLUB does.

SLAB has been using kmalloc caches to allocate freelist_idx_t array for
off slab caches. But after the commit, freelist_size can be bigger than
KMALLOC_MAX_CACHE_SIZE.

Instead of using pointer to kmalloc cache, use kmalloc_node() and only
check if the kmalloc cache is off slab during calculate_slab_order().
If freelist_size > KMALLOC_MAX_CACHE_SIZE, no looping condition happens
as it allocates freelist_idx_t array directly from buddy.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: d6a71648dbc0 ("mm/slab: kmalloc: pass requests larger than order-1 page to page allocator")
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---

@Guenter:
	This fixes the issue on my emulation.
	Can you please test this on your environment?

 include/linux/slab_def.h |  1 -
 mm/slab.c                | 37 +++++++++++++++++++------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index e24c9aff6fed..f0ffad6a3365 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -33,7 +33,6 @@ struct kmem_cache {
 
 	size_t colour;			/* cache colouring range */
 	unsigned int colour_off;	/* colour offset */
-	struct kmem_cache *freelist_cache;
 	unsigned int freelist_size;
 
 	/* constructor func */
diff --git a/mm/slab.c b/mm/slab.c
index a5486ff8362a..d1f6e2c64c2e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1619,7 +1619,7 @@ static void slab_destroy(struct kmem_cache *cachep, struct slab *slab)
 	 * although actual page can be freed in rcu context
 	 */
 	if (OFF_SLAB(cachep))
-		kmem_cache_free(cachep->freelist_cache, freelist);
+		kfree(freelist);
 }
 
 /*
@@ -1671,21 +1671,27 @@ static size_t calculate_slab_order(struct kmem_cache *cachep,
 		if (flags & CFLGS_OFF_SLAB) {
 			struct kmem_cache *freelist_cache;
 			size_t freelist_size;
+			size_t freelist_cache_size;
 
 			freelist_size = num * sizeof(freelist_idx_t);
-			freelist_cache = kmalloc_slab(freelist_size, 0u);
-			if (!freelist_cache)
-				continue;
-
-			/*
-			 * Needed to avoid possible looping condition
-			 * in cache_grow_begin()
-			 */
-			if (OFF_SLAB(freelist_cache))
-				continue;
+			if (freelist_size > KMALLOC_MAX_CACHE_SIZE) {
+				freelist_cache_size = PAGE_SIZE << get_order(freelist_size);
+			} else {
+				freelist_cache = kmalloc_slab(freelist_size, 0u);
+				if (!freelist_cache)
+					continue;
+				freelist_cache_size = freelist_cache->size;
+
+				/*
+				 * Needed to avoid possible looping condition
+				 * in cache_grow_begin()
+				 */
+				if (OFF_SLAB(freelist_cache))
+					continue;
+			}
 
 			/* check if off slab has enough benefit */
-			if (freelist_cache->size > cachep->size / 2)
+			if (freelist_cache_size > cachep->size / 2)
 				continue;
 		}
 
@@ -2061,11 +2067,6 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
 		cachep->flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
 #endif
 
-	if (OFF_SLAB(cachep)) {
-		cachep->freelist_cache =
-			kmalloc_slab(cachep->freelist_size, 0u);
-	}
-
 	err = setup_cpu_cache(cachep, gfp);
 	if (err) {
 		__kmem_cache_release(cachep);
@@ -2292,7 +2293,7 @@ static void *alloc_slabmgmt(struct kmem_cache *cachep,
 		freelist = NULL;
 	else if (OFF_SLAB(cachep)) {
 		/* Slab management obj is off-slab. */
-		freelist = kmem_cache_alloc_node(cachep->freelist_cache,
+		freelist = kmalloc_node(cachep->freelist_size,
 					      local_flags, nodeid);
 	} else {
 		/* We will use last bytes at the slab for freelist */
-- 
2.32.0
