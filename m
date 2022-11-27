Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3E3639E22
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 00:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiK0XBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 18:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK0XBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 18:01:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325C7FD15
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 15:01:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C670A1F8C2;
        Sun, 27 Nov 2022 23:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669590099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a29l7jcLu+VPTYRVin0cjX4H/D4GVLR0xYwLr3AIEfQ=;
        b=y1sZ+ZHybILLz2FC6B/JLdp86WU/cq/2L96+ln8bLhI9cchuLRXheXYwQcltG3iBENpJUB
        sv7VKXPx8pcqa8BpWPkrTzO4Vmha0aJjTs/5IITezQnEmAdd20wIiZ5gkKPVJrZi+ksFoK
        okZ6NW3SIY6c056Dchsg3b6obd2Shp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669590099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a29l7jcLu+VPTYRVin0cjX4H/D4GVLR0xYwLr3AIEfQ=;
        b=z19YFeJ9xDX80bbJb30hCWwCplNFsc5s08/6baxW9I8xprSzp2/5e33ZseL4QZE9k05njq
        3DTH2N7nlmHRuaAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90D4B134CE;
        Sun, 27 Nov 2022 23:01:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rxGZIlPsg2NBfwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sun, 27 Nov 2022 23:01:39 +0000
Message-ID: <863dfdbb-2efc-a1d4-3cb1-3edaa67f67bd@suse.cz>
Date:   Mon, 28 Nov 2022 00:01:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 09/12] mm, slub: split out allocations from pre/post hooks
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-10-vbabka@suse.cz> <Y4NB5i4WBvLr1GGZ@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y4NB5i4WBvLr1GGZ@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/22 11:54, Hyeonggon Yoo wrote:
> On Mon, Nov 21, 2022 at 06:11:59PM +0100, Vlastimil Babka wrote:
>> In the following patch we want to introduce CONFIG_SLUB_TINY allocation
>> paths that don't use the percpu slab. To prepare, refactor the
>> allocation functions:
>> 
>> Split out __slab_alloc_node() from slab_alloc_node() where the former
>> does the actual allocation and the latter calls the pre/post hooks.
>> 
>> Analogically, split out __kmem_cache_alloc_bulk() from
>> kmem_cache_alloc_bulk().
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slub.c | 127 +++++++++++++++++++++++++++++++++---------------------
>>  1 file changed, 77 insertions(+), 50 deletions(-)
> 
> [...]
> 
>> +
>> +/* Note that interrupts must be enabled when calling this function. */
>> +int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>> +			  void **p)
>> +{
>> +	int i;
>> +	struct obj_cgroup *objcg = NULL;
>> +
>> +	/* memcg and kmem_cache debug support */
>> +	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
>> +	if (unlikely(!s))
>> +		return false;
>> +
>> +	i = __kmem_cache_alloc_bulk(s, flags, size, p, objcg);
>> +
>> +	/*
>> +	 * memcg and kmem_cache debug support and memory initialization.
>> +	 * Done outside of the IRQ disabled fastpath loop.
>> +	 */
>> +	if (i != 0)
>> +		slab_post_alloc_hook(s, objcg, flags, size, p,
>> +				slab_want_init_on_alloc(flags, s));
> 
> This patch looks mostly good but wondering what happens if someone calls it with size == 0
> so it does not call slab_post_alloc_hook()?

Hmm looks like in that case we miss doing obj_cgroup_put(objcg) in
memcg_slab_post_alloc_hook(). Good catch, thanks!

Fixing up, also a "return false" from int function
(existed also before this patch).

----8<----
diff --git a/mm/slub.c b/mm/slub.c
index b74c4664160e..88f0ce49caab 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3888,10 +3888,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	int i;
 	struct obj_cgroup *objcg = NULL;
 
+	if (!size)
+		return 0;
+
 	/* memcg and kmem_cache debug support */
 	s = slab_pre_alloc_hook(s, NULL, &objcg, size, flags);
 	if (unlikely(!s))
-		return false;
+		return 0;
 
 	i = __kmem_cache_alloc_bulk(s, flags, size, p, objcg);
 

