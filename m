Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C779D60CE79
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiJYOKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiJYOKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:10:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FB8101ED;
        Tue, 25 Oct 2022 07:08:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC2C81FA48;
        Tue, 25 Oct 2022 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666706913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RoEGXx+CsUxH6vRbiyjgkwQmdQ57d5+pOzoy1MCTSxE=;
        b=25cKaaFcs2vuVtqnTFrQ7vRegg0CsjbfHGVKF7yckheWqDXaeYjv2Es6UZYsrBPerpQiKD
        GUvSLeW8RsxX6/mPYdj0DLOuE8svtna781AgN4Mbqu74zh6FZasUbNSV8lXD5dxgm7MCQc
        uC+anx//u6JzOi8rWST4ek7JYRNe91g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666706913;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RoEGXx+CsUxH6vRbiyjgkwQmdQ57d5+pOzoy1MCTSxE=;
        b=qPwtU3v9Yms0R9q4E8cn/pdrbrRzqbn74UwUm4PMxRYs4uF/+pKqoFt1ley+ocXsYlFsD1
        4xus56OnANhfxJCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94981134CA;
        Tue, 25 Oct 2022 14:08:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9O2VI+HtV2PPUgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 25 Oct 2022 14:08:33 +0000
Message-ID: <ad3fae63-984b-3a4e-4bfc-a09db0ad35b0@suse.cz>
Date:   Tue, 25 Oct 2022 16:08:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        David Laight <David.Laight@aculab.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com> <YzkmErHFyYW3awRn@hyeyoo>
 <YzsVM8eToHUeTP75@casper.infradead.org>
 <7dddca4c-bc36-2cf0-de1c-a770bef9e1b7@suse.cz> <Y1fpABCR3/Vs/u0H@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y1fpABCR3/Vs/u0H@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 15:47, Hyeonggon Yoo wrote:
> On Mon, Oct 24, 2022 at 04:35:04PM +0200, Vlastimil Babka wrote:
> 
> [,,,]
> 
>> diff --git a/mm/slab.c b/mm/slab.c
>> index 59c8e28f7b6a..219beb48588e 100644
>> --- a/mm/slab.c
>> +++ b/mm/slab.c
>> @@ -1370,6 +1370,8 @@ static struct slab *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>>  
>>  	account_slab(slab, cachep->gfporder, cachep, flags);
>>  	__folio_set_slab(folio);
>> +	/* Make the flag visible before any changes to folio->mapping */
>> +	smp_wmb();
>>  	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
>>  	if (sk_memalloc_socks() && page_is_pfmemalloc(folio_page(folio, 0)))
>>  		slab_set_pfmemalloc(slab);
>> @@ -1387,9 +1389,11 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
>>  
>>  	BUG_ON(!folio_test_slab(folio));
>>  	__slab_clear_pfmemalloc(slab);
>> -	__folio_clear_slab(folio);
>>  	page_mapcount_reset(folio_page(folio, 0));
>>  	folio->mapping = NULL;
>> +	/* Make the mapping reset visible before clearing the flag */
>> +	smp_wmb();
>> +	__folio_clear_slab(folio);
>>  
>>  	if (current->reclaim_state)
>>  		current->reclaim_state->reclaimed_slab += 1 << order;
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 157527d7101b..6dc17cb915c5 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -1800,6 +1800,8 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
>>  
>>  	slab = folio_slab(folio);
>>  	__folio_set_slab(folio);
>> +	/* Make the flag visible before any changes to folio->mapping */
>> +	smp_wmb();
>>  	if (page_is_pfmemalloc(folio_page(folio, 0)))
>>  		slab_set_pfmemalloc(slab);
>>  
>> @@ -2008,8 +2010,10 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
>>  	}
>>  
>>  	__slab_clear_pfmemalloc(slab);
>> -	__folio_clear_slab(folio);
>>  	folio->mapping = NULL;
>> +	/* Make the mapping reset visible before clearing the flag */
>> +	smp_wmb();
>> +	__folio_clear_slab(folio);
>>  	if (current->reclaim_state)
>>  		current->reclaim_state->reclaimed_slab += pages;
>>  	unaccount_slab(slab, order, s);
>> -- 
>> 2.38.0
> 
> Do we need to try this with memory barriers before frozen refcount lands in?

There was IIRC an unresolved issue with frozen refcount tripping the page
isolation code so I didn't want to be depending on that.

> It's quite complicated and IIUC there is a still theoretical race:
> 
> At isolate_movable_page:        At slab alloc:                          At slab free:
>                                 folio = alloc_pages(flags, order)
> 
> folio_try_get()
> folio_test_slab() == false
>                                 __folio_set_slab(folio)
>                                 smp_wmb()
> 
>                                                                         call_rcu(&slab->rcu_head, rcu_free_slab);
> 
> 
> smp_rmb()
> __folio_test_movable() == true
> 
>                                                                         folio->mapping = NULL;
>                                                                         smp_wmb()
>                                                                         __folio_clear_slab(folio);
> smp_rmb()
> folio_test_slab() == false
> 
> folio_trylock()

There's also between above and below:

if (!PageMovable(page) || PageIsolated(page))
	goto out_no_isolated;

mops = page_movable_ops(page);

If we put another smp_rmb() before the PageMovable test, could that have
helped? It would assure we observe the folio->mapping = NULL; from the "slab
free" side?

But yeah, it's getting ridiculous. Maybe there's a simpler way to check two
bits in two different bytes atomically. Or maybe it's just an impossible
task, I feel I just dunno computers at this point.

> mops->isolate_page() (*crash*)
> 
> 
> Please let me know if I'm missing something ;-)
> Thanks!
> 

