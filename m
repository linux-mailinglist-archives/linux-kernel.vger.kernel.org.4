Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF35C6B982D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjCNOmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCNOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:42:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446C59FBC3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:41:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 02A711F8A8;
        Tue, 14 Mar 2023 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678804887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m3IFfK1lzZOOAhfMZAFOZzrg+aG7ZeILbuK2cFMzIbk=;
        b=c0aRqiyqBHhDrx5p/kAUQkMRgs8DpxiB3gMlMmB42rS0Vuwj9WlekMz7iRI14Vj39jRlpx
        uHCrMG++uE3b9Q5p4j11WxkseceL5ylKC7LwXSyYA+EZEN5yVscfXvmlBXHUhAWGWtFMlG
        O5jJwfGDjgP8ga7Qx0hme2VwvbVjAoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678804887;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m3IFfK1lzZOOAhfMZAFOZzrg+aG7ZeILbuK2cFMzIbk=;
        b=lfkEaRQUztmKF1Y8rpc4SqctCIo5ag1LPTL6F+7W+Z2R/Rxl7rPgg3lxe4H6b5myU+fE+y
        Pt1esHqla7v3cSAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB2DE13A26;
        Tue, 14 Mar 2023 14:41:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PoDjMJaHEGSvJQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Mar 2023 14:41:26 +0000
Message-ID: <0cad1ff3-8339-a3eb-fc36-c8bda1392451@suse.cz>
Date:   Tue, 14 Mar 2023 15:41:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm/slub: Reduce memory consumption in extreme scenarios
Content-Language: en-US
To:     Chen Jun <chenjun102@huawei.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     xuqiang36@huawei.com, wangkefeng.wang@huawei.com
References: <20230314123403.100158-1-chenjun102@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230314123403.100158-1-chenjun102@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/14/23 13:34, Chen Jun wrote:
> When kmalloc_node() is called without __GFP_THISNODE and the target node
> lacks sufficient memory, SLUB allocates a folio from a different node
> other than the requested node, instead of taking a partial slab from it.
> 
> However, since the allocated folio does not belong to the requested
> node, it is deactivated and added to the partial slab list of the node
> it belongs to.
> 
> This behavior can result in excessive memory usage when the requested
> node has insufficient memory, as SLUB will repeatedly allocate folios
> from other nodes without reusing the previously allocated ones.
> 
> To prevent memory wastage,
> when (node != NUMA_NO_NODE) && (gfpflags & __GFP_THISNODE) is:
> 1) try to get a partial slab from target node with __GFP_THISNODE.
> 2) if 1) failed, try to allocate a new slab from target node with
>    __GFP_THISNODE.
> 3) if 2) failed, retry 1) and 2) without __GFP_THISNODE constraint.
> 
> when node != NUMA_NO_NODE || (gfpflags & __GFP_THISNODE), the behavior
> remains unchanged.
> 
> On qemu with 4 numa nodes and each numa has 1G memory. Write a test ko
> to call kmalloc_node(196, GFP_KERNEL, 3) for (4 * 1024 + 4) * 1024 times.
> 
> cat /proc/slabinfo shows:
> kmalloc-256       4200530 13519712    256   32    2 : tunables..
> 
> after this patch,
> cat /proc/slabinfo shows:
> kmalloc-256       4200558 4200768    256   32    2 : tunables..
> 
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> ---
>  mm/slub.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 39327e98fce3..32e436957e03 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2384,7 +2384,7 @@ static void *get_partial(struct kmem_cache *s, int node, struct partial_context
>  		searchnode = numa_mem_id();
>  
>  	object = get_partial_node(s, get_node(s, searchnode), pc);
> -	if (object || node != NUMA_NO_NODE)
> +	if (object || (node != NUMA_NO_NODE && (pc->flags & __GFP_THISNODE)))
>  		return object;
>  
>  	return get_any_partial(s, pc);
> @@ -3069,6 +3069,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	struct slab *slab;
>  	unsigned long flags;
>  	struct partial_context pc;
> +	bool try_thisnode = true;
>  
>  	stat(s, ALLOC_SLOWPATH);
>  
> @@ -3181,8 +3182,18 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	}
>  
>  new_objects:
> -
>  	pc.flags = gfpflags;
> +
> +	/*
> +	 * when (node != NUMA_NO_NODE) && (gfpflags & __GFP_THISNODE)
> +	 * 1) try to get a partial slab from target node with __GFP_THISNODE.
> +	 * 2) if 1) failed, try to allocate a new slab from target node with
> +	 *    __GFP_THISNODE.
> +	 * 3) if 2) failed, retry 1) and 2) without __GFP_THISNODE constraint.
> +	 */
> +	if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode)
> +			pc.flags |= __GFP_THISNODE;

Hmm I'm thinking we should also perhaps remove direct reclaim possibilities
from the attempt 2). In your qemu test it should make no difference, as it
fills everything with kernel memory that is not reclaimable. But in practice
the target node might be filled with user memory, and I think it's better to
quickly allocate on a different node than spend time in direct reclaim. So
the following should work I think?

pc.flags = GFP_NOWAIT | __GFP_NOWARN |__GFP_THISNODE

> +
>  	pc.slab = &slab;
>  	pc.orig_size = orig_size;
>  	freelist = get_partial(s, node, &pc);
> @@ -3190,10 +3201,15 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		goto check_new_slab;
>  
>  	slub_put_cpu_ptr(s->cpu_slab);
> -	slab = new_slab(s, gfpflags, node);
> +	slab = new_slab(s, pc.flags, node);
>  	c = slub_get_cpu_ptr(s->cpu_slab);
>  
>  	if (unlikely(!slab)) {
> +		if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode) {
> +			try_thisnode = false;
> +			goto new_objects;
> +		}
> +
>  		slab_out_of_memory(s, gfpflags, node);
>  		return NULL;
>  	}

