Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DFD6B0990
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjCHNjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjCHNjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:39:11 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF155D47A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:37:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id x34so16556824pjj.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 05:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678282639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=skOevrBH/VdT5SIidruNWf0l96ZcVNpPBjmQkY/d2IQ=;
        b=Wz1rqGM9u7pa/IXS179+od4C1bHsMAYPmBwY2249MGxdGEOlnIzanmdT9MWEM2pJK7
         GeEQ9+tRUCMX6IOssznZjpGwp+frC2DMjcVs3Qcc5JLsHPB91G+ADEp9yBjRHhKBG6ve
         +ZjMl4yk4+UCqat0DYNZlavasSXdTIl3pU+LEKHy2/o9TSWNockQkqd3nW/KEVNrJM+4
         6TkyrL+A1nr5Z4MjmkkoRpaCY59kCF9JBio+OBHLUvTj+VebTvTTFjU7WkpR3qBSiAF9
         d/h/kNXMVZrEPXDUyQkw5EHjF+dwuWhZh95BLqTBJ9jqBtjyD9E8R+HkUhWDKxhZUVQm
         YlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678282639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skOevrBH/VdT5SIidruNWf0l96ZcVNpPBjmQkY/d2IQ=;
        b=NvnDsSGuMNUkcf+cirzpktCwsZkhjVJEH8pTH8EF4rQEU/T/pfYPrvEmpLXkD0AvGv
         zHRIshuFH/ua29KR+BHIkrGv2/bLEpz8OBp89LxpbPJ+FMiuOJ8OfZIXhDTiG1EQe68q
         8ZlkfCetQPqGX911vKpcNY+EX2vXAj5omvACaAW1SnR/9j5rsyGqipH1J+jDLEMAnwPQ
         HkBHhlN76iWMHIlebTOz0Ihh+Mpo16w4ISEYmRAld1tifpql/CpijfmspuXQ/N1j5E7l
         4Zz2gP97vE9jKpoUHLxh7Uq4gnYNY41Wn9sLFkHYugZB9xl6TguBJscgfPuZfOANIpdD
         iJOQ==
X-Gm-Message-State: AO0yUKWgBLGoBGxBapH6tmPVy3W+kbbr+/vBhmrGCW5GM+AMUtTj15MM
        JUDe0lut/mgKp+aaz9AZtf0=
X-Google-Smtp-Source: AK7set+3i5xscnsi+WC/xa2PTuvdUZN2C+YhvLhpH4GA681dwhDxy1HAYOY3w+6YxEgZJpRBEfsI9g==
X-Received: by 2002:a05:6a20:e688:b0:c7:6cb7:cfbf with SMTP id mz8-20020a056a20e68800b000c76cb7cfbfmr16095556pzb.10.1678282639263;
        Wed, 08 Mar 2023 05:37:19 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7870d000000b0058dbd7a5e0esm9372589pfo.89.2023.03.08.05.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 05:37:18 -0800 (PST)
Date:   Wed, 8 Mar 2023 13:37:10 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     "chenjun (AM)" <chenjun102@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "xuqiang (M)" <xuqiang36@huawei.com>
Subject: Re: [RFC] mm/slub: Reduce memory consumption in extreme scenarios
Message-ID: <ZAiPhtexI0ebJCkV@localhost>
References: <20230307082811.120774-1-chenjun102@huawei.com>
 <ZAdIJKkT8VHdbPs9@localhost>
 <4ad448c565134d76bea0ac8afffe4f37@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ad448c565134d76bea0ac8afffe4f37@huawei.com>
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 07:16:49AM +0000, chenjun (AM) wrote:
> Hi,
> 
> Thanks for reply.
> 
> 在 2023/3/7 22:20, Hyeonggon Yoo 写道:
> > On Tue, Mar 07, 2023 at 08:28:11AM +0000, Chen Jun wrote:
> >> If call kmalloc_node with NO __GFP_THISNODE and node[A] with no memory.
> >> Slub will alloc a slub page which is not belong to A, and put the page
> >> to kmem_cache_node[page_to_nid(page)]. The page can not be reused
> >> at next calling, because NULL will be get from get_partical().
> >> That make kmalloc_node consume more memory.
> > 
> > Hello,
> > 
> > elaborating a little bit:
> > 
> > "When kmalloc_node() is called without __GFP_THISNODE and the target node
> > lacks sufficient memory, SLUB allocates a folio from a different node other
> > than the requested node, instead of taking a partial slab from it.
> > 
> > However, since the allocated folio does not belong to the requested node,
> > it is deactivated and added to the partial slab list of the node it
> > belongs to.
> > 
> > This behavior can result in excessive memory usage when the requested
> > node has insufficient memory, as SLUB will repeatedly allocate folios from
> > other nodes without reusing the previously allocated ones.
> > 
> > To prevent memory wastage, take a partial slab from a different node when
> > the requested node has no partial slab and __GFP_THISNODE is not explicitly
> > specified."
> > 
> 
> Thanks, This is more clear than what I described.
> 
> >> On qemu with 4 numas and each numa has 1G memory, Write a test ko
> >> to call kmalloc_node(196, 0xd20c0, 3) for 5 * 1024 * 1024 times.
> >>
> >> cat /proc/slabinfo shows:
> >> kmalloc-256       4302317 15151808    256   32    2 : tunables..
> >>
> >> the total objects is much more then active objects.
> >>
> >> After this patch, cat /prac/slubinfo shows:
> >> kmalloc-256       5244950 5245088    256   32    2 : tunables..
> >>
> >> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> >> ---
> >>   mm/slub.c | 17 ++++++++++++++---
> >>   1 file changed, 14 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index 39327e98fce3..c0090a5de54e 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -2384,7 +2384,7 @@ static void *get_partial(struct kmem_cache *s, int node, struct partial_context
> >>   		searchnode = numa_mem_id();
> >>   
> >>   	object = get_partial_node(s, get_node(s, searchnode), pc);
> >> -	if (object || node != NUMA_NO_NODE)
> >> +	if (object || (node != NUMA_NO_NODE && (pc->flags & __GFP_THISNODE)))
> >>   		return object;
> > 
> > I think the problem here is to avoid taking a partial slab from
> > different node than the requested node even if __GFP_THISNODE is not set.
> > (and then allocating new slab instead)
> > 
> > Thus this hunk makes sense to me,
> > even if SLUB currently do not implement __GFP_THISNODE semantics.
> > 
> >>   	return get_any_partial(s, pc);
> >> @@ -3069,6 +3069,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >>   	struct slab *slab;
> >>   	unsigned long flags;
> >>   	struct partial_context pc;
> >> +	int try_thisndoe = 0;
> >>
> >>   
> >>   	stat(s, ALLOC_SLOWPATH);
> >>   
> >> @@ -3181,8 +3182,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >>   	}
> >>   
> >>   new_objects:
> >> -
> >>   	pc.flags = gfpflags;
> >> +
> >> +	/* Try to get page from specific node even if __GFP_THISNODE is not set */
> >> +	if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode)
> >> +			pc.flags |= __GFP_THISNODE;
> >> +
> >>   	pc.slab = &slab;
> >>   	pc.orig_size = orig_size;
> >>   	freelist = get_partial(s, node, &pc);
> >> @@ -3190,10 +3195,16 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >>   		goto check_new_slab;
> >>   
> >>   	slub_put_cpu_ptr(s->cpu_slab);
> >> -	slab = new_slab(s, gfpflags, node);
> >> +	slab = new_slab(s, pc.flags, node);
> >>   	c = slub_get_cpu_ptr(s->cpu_slab);
> >>   
> >>   	if (unlikely(!slab)) {
> >> +		/* Try to get page from any other node */
> >> +		if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode) {
> >> +			try_thisnode = 0;
> >> +			goto new_objects;
> >> +		}
> >> +
> >>   		slab_out_of_memory(s, gfpflags, node);
> >>   		return NULL;
> > 
> > But these hunks do not make sense to me.
> > Why force __GFP_THISNODE even when the caller did not specify it?
> > 
> > (Apart from the fact that try_thisnode is defined as try_thisndoe,
> >   and try_thisnode is never set to nonzero value.)
> 
> My mistake， It should be:
> int try_thisnode = 0;

I think it should be try_thisnode = 1?
Otherwise it won't be executed at all.
Also bool type will be more readable than int.

> 
> > 
> > IMHO the first hunk is enough to solve the problem.
> 
> I think, we should try to alloc a page on the target node before getting 
> one from other nodes' partial.

You are right.

Hmm then the new behavior when 
(node != NUMA_NO_NODE) && (gfpflags & __GFP_THISNODE) is:

1) try to get a partial slab from target node with __GFP_THISNODE
2) if 1) failed, try to allocate a new slab from target node with __GFP_THISNODE
3) if 2) failed, retry 1) and 2) without __GFP_THISNODE constraint

when node != NUMA_NO_NODE || (gfpflags & __GFP_THISNODE), the behavior
remains unchanged.

It does not look that crazy to me, although it complicates the code
a little bit. (Vlastimil may have some opinions?)

Now that I understand your intention, I think this behavior change also
need to be added to the commit log.

Thanks,
Hyeonggon

> If the caller does not specify __GFP_THISNODE, we add __GFP_THISNODE to 
> try to get the slab only on the target node. If it fails, use the 
> original GFP FLAG to allow fallback.
