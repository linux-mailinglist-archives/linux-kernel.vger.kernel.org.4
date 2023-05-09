Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5E46FC03B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjEIHMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbjEIHMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:12:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA6226B8;
        Tue,  9 May 2023 00:12:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-965ac4dd11bso1086285766b.2;
        Tue, 09 May 2023 00:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683616332; x=1686208332;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+aAIP8ajfLei8y315mzvfv242eDfozwQdKlXY70z4I=;
        b=XDgkfCPWZ5DargSfyQlY3d6DnlIJgh/UruzjxNkJhDmTGgB77hY9SyEWDSodWX9W9U
         NQaX3ksDR2muJpVt8fYGVrIs/BlzmP2yy9hRcJ4du4yawDE1rWV1t2qfUhrQU2TtipeL
         aQGI7qXn/N4ckElhSwF/RKyx0rxSaTKbO3HW/AvRD1CIxfq/ANQL/KYXACifHN7pocOb
         jq1cQaRu2LnKnEuZ2QQfLjo46od2p2+dcBRnsMqGUju1gIkRct1+O6IkEtoiPFBa1J1H
         yzNvGfv5PUfAdwPSaUyw/t/+sS3ZMgi/LHEbqIa1IkOeVHhbYVjrhukAN+QNBBM2pnpf
         tN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683616332; x=1686208332;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+aAIP8ajfLei8y315mzvfv242eDfozwQdKlXY70z4I=;
        b=igJTTKZrSg8WSBU0+vZtN49M+aqoHp8AQ3y4GsozWcXzOxs16xtsAP1hNQe1mgHsx/
         yolbdcd/Vnf4bS7wcZm+D153oGq0twKpnwOCXf1DfM5G+iN5XPIIfKTiqXC3LVxGj6+H
         Bwx+cvDSN9Z4XYBmSI8ZtN+KLOyzVr/M1GXXhyk+VXolZ6sCjxmephNNDjwWHVh0sRmp
         kZOdwFmnE+VVeLFnPN1oL452aGPpX9DFq+Tyz2jmubCMtNJQ/g18AKLYdf50S0DlLnmY
         MAMemLOZU4bcMdS5sHZa1zyjEDFn7UyMINu9JwyKZKdKNQS5U5s7LcZ0zAMRs4SPSB66
         I9jQ==
X-Gm-Message-State: AC+VfDw8Sh+JW1b2isz4X4hZixgyryVppWt4a0cAEYx+1FPpKd0w04JO
        b9mGqSD2J7Vb4zBLtOz/raY=
X-Google-Smtp-Source: ACHHUZ7tVsDsrIvQZCyzO3IbZvqJmpg9O2zw45SMLd9uUvgRfE5Fsnwqe3oI+i0zBauKKHLajoLbiQ==
X-Received: by 2002:a17:907:983:b0:94f:2c22:a7a2 with SMTP id bf3-20020a170907098300b0094f2c22a7a2mr10646421ejc.68.1683616331548;
        Tue, 09 May 2023 00:12:11 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:b892:8631:69c7:ec2c])
        by smtp.gmail.com with ESMTPSA id s3-20020a170906bc4300b0095fde299e83sm919706ejv.214.2023.05.09.00.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 00:12:11 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] net: skbuff: remove special handling for SLOB
Date:   Tue,  9 May 2023 09:12:07 +0200
Message-Id: <20230509071207.28942-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c9929f0e344a ("mm/slob: remove CONFIG_SLOB") removes CONFIG_SLOB.
Now, we can also remove special handling for socket buffers with the SLOB
allocator. The code with HAVE_SKB_SMALL_HEAD_CACHE=1 is now the default
behavior for all allocators.

Remove an unnecessary distinction between SLOB and SLAB/SLUB allocator
after the SLOB allocator is gone.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 net/core/skbuff.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 515ec5cdc79c..01b48e68aca0 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -92,15 +92,7 @@ static struct kmem_cache *skbuff_fclone_cache __ro_after_init;
 static struct kmem_cache *skbuff_ext_cache __ro_after_init;
 #endif
 
-/* skb_small_head_cache and related code is only supported
- * for CONFIG_SLAB and CONFIG_SLUB.
- * As soon as SLOB is removed from the kernel, we can clean up this.
- */
-#if !defined(CONFIG_SLOB)
-# define HAVE_SKB_SMALL_HEAD_CACHE 1
-#endif
 
-#ifdef HAVE_SKB_SMALL_HEAD_CACHE
 static struct kmem_cache *skb_small_head_cache __ro_after_init;
 
 #define SKB_SMALL_HEAD_SIZE SKB_HEAD_ALIGN(MAX_TCP_HEADER)
@@ -117,7 +109,6 @@ static struct kmem_cache *skb_small_head_cache __ro_after_init;
 
 #define SKB_SMALL_HEAD_HEADROOM						\
 	SKB_WITH_OVERHEAD(SKB_SMALL_HEAD_CACHE_SIZE)
-#endif /* HAVE_SKB_SMALL_HEAD_CACHE */
 
 int sysctl_max_skb_frags __read_mostly = MAX_SKB_FRAGS;
 EXPORT_SYMBOL(sysctl_max_skb_frags);
@@ -562,7 +553,6 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	void *obj;
 
 	obj_size = SKB_HEAD_ALIGN(*size);
-#ifdef HAVE_SKB_SMALL_HEAD_CACHE
 	if (obj_size <= SKB_SMALL_HEAD_CACHE_SIZE &&
 	    !(flags & KMALLOC_NOT_NORMAL_BITS)) {
 		obj = kmem_cache_alloc_node(skb_small_head_cache,
@@ -576,7 +566,6 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 		obj = kmem_cache_alloc_node(skb_small_head_cache, flags, node);
 		goto out;
 	}
-#endif
 	*size = obj_size = kmalloc_size_roundup(obj_size);
 	/*
 	 * Try a regular allocation, when that fails and we're not entitled
@@ -898,11 +887,9 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
 
 static void skb_kfree_head(void *head, unsigned int end_offset)
 {
-#ifdef HAVE_SKB_SMALL_HEAD_CACHE
 	if (end_offset == SKB_SMALL_HEAD_HEADROOM)
 		kmem_cache_free(skb_small_head_cache, head);
 	else
-#endif
 		kfree(head);
 }
 
@@ -2160,7 +2147,6 @@ int __skb_unclone_keeptruesize(struct sk_buff *skb, gfp_t pri)
 	if (likely(skb_end_offset(skb) == saved_end_offset))
 		return 0;
 
-#ifdef HAVE_SKB_SMALL_HEAD_CACHE
 	/* We can not change skb->end if the original or new value
 	 * is SKB_SMALL_HEAD_HEADROOM, as it might break skb_kfree_head().
 	 */
@@ -2174,7 +2160,6 @@ int __skb_unclone_keeptruesize(struct sk_buff *skb, gfp_t pri)
 		WARN_ON_ONCE(1);
 		return 0;
 	}
-#endif
 
 	shinfo = skb_shinfo(skb);
 
@@ -4768,7 +4753,6 @@ void __init skb_init(void)
 						0,
 						SLAB_HWCACHE_ALIGN|SLAB_PANIC,
 						NULL);
-#ifdef HAVE_SKB_SMALL_HEAD_CACHE
 	/* usercopy should only access first SKB_SMALL_HEAD_HEADROOM bytes.
 	 * struct skb_shared_info is located at the end of skb->head,
 	 * and should not be copied to/from user.
@@ -4780,7 +4764,6 @@ void __init skb_init(void)
 						0,
 						SKB_SMALL_HEAD_HEADROOM,
 						NULL);
-#endif
 	skb_extensions_init();
 }
 
-- 
2.17.1

