Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97506360CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiKWN7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238093AbiKWN7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:59:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44707D2DE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:53:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F3D381F88C;
        Wed, 23 Nov 2022 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669211624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aDgpM1Fdb/f/drwuUgdV96KDMG9JfLvZ62oRwB+DzNQ=;
        b=FY97pWy3KlkUXh8W7H7iArWxvIh2oKnF2dmqRxqze0iTTXvOe4okXWLLQ6nJXxwnUUDtgq
        sBhpcO2SD5QJXaUyURiKnea9HoWrkA3g44rCi3st0FG3HQfuwufCQ7OVVlZQyMocPnWSuz
        VX3L2p+0DqMWBo1uQ2wualCogXDaEoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669211624;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aDgpM1Fdb/f/drwuUgdV96KDMG9JfLvZ62oRwB+DzNQ=;
        b=MSdwOQbIUE6Xn8DzZ+SmjcGbXqAhqHQeTJva81j5vZXv3yaJ2j8hxtzClR6srMk5yDIx5b
        MEO4hRFJhCIoT5BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A99F713A37;
        Wed, 23 Nov 2022 13:53:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v1r5J+clfmOxEQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 23 Nov 2022 13:53:43 +0000
Message-ID: <d77498f8-b15f-9dae-1803-2d2bbb99da50@suse.cz>
Date:   Wed, 23 Nov 2022 14:53:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 06/12] mm, slub: don't create kmalloc-rcl caches with
 CONFIG_SLUB_TINY
Content-Language: en-US
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-7-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221121171202.22080-7-vbabka@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 18:11, Vlastimil Babka wrote:
> Distinguishing kmalloc(__GFP_RECLAIMABLE) can help against fragmentation
> by grouping pages by mobility, but on tiny systems the extra memory
> overhead of separate set of kmalloc-rcl caches will probably be worse,
> and mobility grouping likely disabled anyway.
> 
> Thus with CONFIG_SLUB_TINY, don't create kmalloc-rcl caches and use the
> regular ones.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Fixed up in response to lkp report for a MEMCG_KMEM+SLUB_TINY combo:
---8<---
From c1ec0b924850a2863d061f316615d596176f15bb Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Tue, 15 Nov 2022 18:19:28 +0100
Subject: [PATCH 06/12] mm, slub: don't create kmalloc-rcl caches with
 CONFIG_SLUB_TINY

Distinguishing kmalloc(__GFP_RECLAIMABLE) can help against fragmentation
by grouping pages by mobility, but on tiny systems the extra memory
overhead of separate set of kmalloc-rcl caches will probably be worse,
and mobility grouping likely disabled anyway.

Thus with CONFIG_SLUB_TINY, don't create kmalloc-rcl caches and use the
regular ones.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h |  9 +++++++--
 mm/slab_common.c     | 10 ++++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 45efc6c553b8..ae2d19ec8467 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -336,12 +336,17 @@ enum kmalloc_cache_type {
 #endif
 #ifndef CONFIG_MEMCG_KMEM
 	KMALLOC_CGROUP = KMALLOC_NORMAL,
-#else
-	KMALLOC_CGROUP,
 #endif
+#ifdef CONFIG_SLUB_TINY
+	KMALLOC_RECLAIM = KMALLOC_NORMAL,
+#else
 	KMALLOC_RECLAIM,
+#endif
 #ifdef CONFIG_ZONE_DMA
 	KMALLOC_DMA,
+#endif
+#ifdef CONFIG_MEMCG_KMEM
+	KMALLOC_CGROUP,
 #endif
 	NR_KMALLOC_TYPES
 };
diff --git a/mm/slab_common.c b/mm/slab_common.c
index a8cb5de255fc..907d52963806 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -770,10 +770,16 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
 #define KMALLOC_CGROUP_NAME(sz)
 #endif
 
+#ifndef CONFIG_SLUB_TINY
+#define KMALLOC_RCL_NAME(sz)	.name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #sz,
+#else
+#define KMALLOC_RCL_NAME(sz)
+#endif
+
 #define INIT_KMALLOC_INFO(__size, __short_size)			\
 {								\
 	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
-	.name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #__short_size,	\
+	KMALLOC_RCL_NAME(__short_size)				\
 	KMALLOC_CGROUP_NAME(__short_size)			\
 	KMALLOC_DMA_NAME(__short_size)				\
 	.size = __size,						\
@@ -859,7 +865,7 @@ void __init setup_kmalloc_cache_index_table(void)
 static void __init
 new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 {
-	if (type == KMALLOC_RECLAIM) {
+	if ((KMALLOC_RECLAIM != KMALLOC_NORMAL) && (type == KMALLOC_RECLAIM)) {
 		flags |= SLAB_RECLAIM_ACCOUNT;
 	} else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP)) {
 		if (mem_cgroup_kmem_disabled()) {
-- 
2.38.1


