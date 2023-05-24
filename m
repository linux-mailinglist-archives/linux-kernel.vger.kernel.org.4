Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B1970FA65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbjEXPgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbjEXPfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EC5E7A
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684942428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgbi0fncQFlNqYJvJIncCzqzDTHwL/0fY7UO/lvli4s=;
        b=hTPgvlWoInLvn++tgGEbbo5CQe2zyOKlXGZJnFqICvHNGvvqFT0wLnTwNb+rhRHkGgTUFY
        6XG3CLTf74Ae1W1e8TJFHzj2e4rSRboLSPjU5M2W5O/WgDHbRAMg3Eq+Mc0RMLFQPDDIxx
        INSLprQJTn1RfnGkk4xLRKKwy8kuS8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-IhsFsMjsP6yLutFsBhfOSA-1; Wed, 24 May 2023 11:33:44 -0400
X-MC-Unique: IhsFsMjsP6yLutFsBhfOSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EDD280027F;
        Wed, 24 May 2023 15:33:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2DC4C1ED99;
        Wed, 24 May 2023 15:33:41 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 07/12] net: Clean up users of netdev_alloc_cache and napi_frag_cache
Date:   Wed, 24 May 2023 16:33:06 +0100
Message-Id: <20230524153311.3625329-8-dhowells@redhat.com>
In-Reply-To: <20230524153311.3625329-1-dhowells@redhat.com>
References: <20230524153311.3625329-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The users of netdev_alloc_cache and napi_frag_cache don't need to take the
bh lock around access to these fragment caches any more as the percpu
handling is now done in page_frag_alloc_align().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-mm@kvack.org
---
 include/linux/skbuff.h |  3 ++-
 net/core/skbuff.c      | 29 +++++++++--------------------
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 41b63e72c6c3..e11a765fe7fa 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -252,7 +252,8 @@
 /* Maximum value in skb->csum_level */
 #define SKB_MAX_CSUM_LEVEL	3
 
-#define SKB_DATA_ALIGN(X)	ALIGN(X, SMP_CACHE_BYTES)
+#define SKB_DATA_ALIGNMENT	SMP_CACHE_BYTES
+#define SKB_DATA_ALIGN(X)	ALIGN(X, SKB_DATA_ALIGNMENT)
 #define SKB_WITH_OVERHEAD(X)	\
 	((X) - SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 225a16f3713f..c2840b0dcad9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -291,27 +291,20 @@ void napi_get_frags_check(struct napi_struct *napi)
 
 void *napi_alloc_frag_align(unsigned int fragsz, unsigned int align)
 {
-	fragsz = SKB_DATA_ALIGN(fragsz);
-
+	align = min_t(unsigned int, align, SKB_DATA_ALIGNMENT);
 	return page_frag_alloc_align(&napi_frag_cache, fragsz, GFP_ATOMIC, align);
 }
 EXPORT_SYMBOL(napi_alloc_frag_align);
 
 void *netdev_alloc_frag_align(unsigned int fragsz, unsigned int align)
 {
-	void *data;
-
-	fragsz = SKB_DATA_ALIGN(fragsz);
-	if (in_hardirq() || irqs_disabled()) {
-		data = page_frag_alloc_align(&netdev_alloc_cache,
+	align = min_t(unsigned int, align, SKB_DATA_ALIGNMENT);
+	if (in_hardirq() || irqs_disabled())
+		return page_frag_alloc_align(&netdev_alloc_cache,
 					     fragsz, GFP_ATOMIC, align);
-	} else {
-		local_bh_disable();
-		data = page_frag_alloc_align(&napi_frag_cache,
+	else
+		return page_frag_alloc_align(&napi_frag_cache,
 					     fragsz, GFP_ATOMIC, align);
-		local_bh_enable();
-	}
-	return data;
 }
 EXPORT_SYMBOL(netdev_alloc_frag_align);
 
@@ -709,15 +702,11 @@ struct sk_buff *__netdev_alloc_skb(struct net_device *dev, unsigned int len,
 	if (sk_memalloc_socks())
 		gfp_mask |= __GFP_MEMALLOC;
 
-	if (in_hardirq() || irqs_disabled()) {
+	if (in_hardirq() || irqs_disabled())
 		data = page_frag_alloc(&netdev_alloc_cache, len, gfp_mask);
-		pfmemalloc = folio_is_pfmemalloc(virt_to_folio(data));
-	} else {
-		local_bh_disable();
+	else
 		data = page_frag_alloc(&napi_frag_cache, len, gfp_mask);
-		pfmemalloc = folio_is_pfmemalloc(virt_to_folio(data));
-		local_bh_enable();
-	}
+	pfmemalloc = folio_is_pfmemalloc(virt_to_folio(data));
 
 	if (unlikely(!data))
 		return NULL;

