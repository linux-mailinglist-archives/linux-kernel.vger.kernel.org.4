Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C59626A85
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiKLQXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLQXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:23:16 -0500
Received: from fish.birch.relay.mailchannels.net (fish.birch.relay.mailchannels.net [23.83.209.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE8DC746
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 08:23:14 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CF77B417F5;
        Sat, 12 Nov 2022 16:23:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a241.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4DA1F40E4C;
        Sat, 12 Nov 2022 16:23:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668270192; a=rsa-sha256;
        cv=none;
        b=XxeOR6GRLSHEOomtQ/cXdXDPAlHdt0g6hdW9uV3PwPgstDsYd2BdSmkhBPV46rr66wCMqH
        y+wEMx/+fVYB+dlR2Ew1KW6SXvq4SMuCIKC4USrLFbUxIQ3DgvNKggc9o83AouVgpt5Ukw
        pUV3C7be2MjDe5o9mfCwFctRGGjdoMW5eNuUxiXK7+bMj6kQPOrAXQjn6wFCmS1d+WYM9a
        /MTlKk4i92DtliZaTorOG7lflNBGLCH0DME6+nuYpbnuGGQG2a3pNx2kfxJ3CsVUAwkIBR
        PR1Zf+/EDf+MwC8r0eJ716yLxfIXGbrEl3vsZ3nyRSWk1tib0wGHMlJfNUqJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668270192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=GDkDXGCtUZAA6T1uHsvxX43BUjXPKslpK++ikWiAd8E=;
        b=cBKRzvuiNJ9q2cCpl3PmMjz+RE7hhYoaUa3oFlcc09xU8GtqPvdoxhW09U7/Uov1AngYdQ
        aOFez02rcStSKZ/oBLfha5oahXIienfMZ6zPkNP2MMldg6BRXkF2g9fwRoYnGzk5c5nayU
        bU0xc2BS4SeF5iPNC20qQMCzUc+fFkAGDzMB8A0wn9Sw2aigrKgWIOzhoYbF5x8meCpAPZ
        MmK2r5WjOwVRe45zFG4WBOv5JORaB/TBnb6qkR3eJ6QFYQFS8wAyoJg5cxpulu8Md7MBbZ
        pa1GtqImjJ1g3cIlrtjoayjfiXPagqO8eY0dxM9/hyYvnxPCZrRXyhnPYTDj/g==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-nvvnz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Befitting-Shelf: 334e745f27737371_1668270192646_2430107452
X-MC-Loop-Signature: 1668270192646:4206870944
X-MC-Ingress-Time: 1668270192646
Received: from pdx1-sub0-mail-a241.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.91 (trex/6.7.1);
        Sat, 12 Nov 2022 16:23:12 +0000
Received: from rhino.lan (dsl-50-5-144-34.fuse.net [50.5.144.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a241.dreamhost.com (Postfix) with ESMTPSA id 4N8gq11KnSz66;
        Sat, 12 Nov 2022 08:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1668270190;
        bh=GDkDXGCtUZAA6T1uHsvxX43BUjXPKslpK++ikWiAd8E=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=umYyrH8rEy+unumOiRSIl3uqwu3XmeQ3vBF5QCjROyWKcVwZcQ3P2LuJ//eHpR2UM
         7n/qEQpS2Jlngi4QUuG7YiinpNwBgEwUrRmHPYnwMvd2nqAidBI+UyHcOsM/86CgQ4
         qAqtqnDebn6FFteDEf51nIQ8MO/KrCuBVIrBkxMQ6q6gg/VszSk1Kczj95N8pcrS4s
         rqTYLTwLvHGD9n/eCgI2sCHLnl20PTbAf7oD/UvMg1FlgztlSFSupLYi7EU02+nVbX
         qDZ/wWbDIuLBUqLEshf7C2SB+yYxCTmDiUy2l5MU7YMcg7KAaKQ+nNPDGOy3v6q6a4
         HGqQuWaMiM/fw==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Christoph Lameter <cl@linux.com>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH 1/1] include: linux: slab: rename gfpflags to flags
Date:   Sat, 12 Nov 2022 11:22:59 -0500
Message-Id: <20221112162259.355921-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the slab header the general naming convention for the gfp flags is
`flags` except in a few locations. This refactors all `gfpflags` variable
names to the common `flags` name.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 include/linux/slab.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 90877fcde70b..bb5231cf6859 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -443,7 +443,7 @@ static_assert(PAGE_SHIFT <= 20);
 void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
 void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
 void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
-			   gfp_t gfpflags) __assume_slab_alignment __malloc;
+			   gfp_t flags) __assume_slab_alignment __malloc;
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
 /*
@@ -474,7 +474,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assum
 void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
 		    __assume_kmalloc_alignment __alloc_size(3);
 
-void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
+void *kmalloc_node_trace(struct kmem_cache *s, gfp_t flags,
 			 int node, size_t size) __assume_kmalloc_alignment
 						__alloc_size(4);
 #else /* CONFIG_TRACING */
@@ -489,12 +489,12 @@ void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
 }
 
 static __always_inline __alloc_size(4)
-void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
+void *kmalloc_node_trace(struct kmem_cache *s, gfp_t flags,
 			 int node, size_t size)
 {
-	void *ret = kmem_cache_alloc_node(s, gfpflags, node);
+	void *ret = kmem_cache_alloc_node(s, flags, node);
 
-	ret = kasan_kmalloc(s, ret, size, gfpflags);
+	ret = kasan_kmalloc(s, ret, size, flags);
 	return ret;
 }
 #endif /* CONFIG_TRACING */
-- 
2.38.1

