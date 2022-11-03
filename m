Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610FF61856E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiKCQ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiKCQ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:57:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7D410B5B;
        Thu,  3 Nov 2022 09:57:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 41D2021BFF;
        Thu,  3 Nov 2022 16:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667494673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPajYb9QcCfgn85MBno6QGeeo7jki/qMqTDWc2NpTcs=;
        b=qWVIpBAf1t4NHS/Wb4B+MVZEkZT1GaQgVpmLRWYymb0oGCYgHav+YQCqDPblc8X7KtywFx
        XT6jMTeED1SFEIp/kmscGivlZuUF1OEgCx6g2nMH23KRjp/pagAY5D6CtdMQSYnn5D+J1y
        iVE4ivQWEusKW6Q7B7dIgID58bzY7tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667494673;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPajYb9QcCfgn85MBno6QGeeo7jki/qMqTDWc2NpTcs=;
        b=3wj4J8Vytkn5XsbjGnCWlnJZgd4HXOv3S2iSdsMmG59vsZhTo7UsxRoKw5lf4Q5ekHISqW
        wg3LXY70pHhz2+Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1E2113AAF;
        Thu,  3 Nov 2022 16:57:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /Y+PMhDzY2M+UwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 03 Nov 2022 16:57:52 +0000
Message-ID: <8f2cc14c-d8b3-728d-7d12-13f2c1b0d8a0@suse.cz>
Date:   Thu, 3 Nov 2022 17:57:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v6 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Feng Tang <feng.tang@intel.com>
Cc:     John Thomson <lists@johnthomson.fastmail.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
References: <Y1+0sbQ3R4DB46NX@feng-clx>
 <9b71ae3e-7f53-4c9e-90c4-79d3d649f94c@app.fastmail.com>
 <Y2DReuPHZungAGsU@feng-clx>
 <53b53476-bb1e-402e-9f65-fd7f0ecf94c2@app.fastmail.com>
 <Y2DngwUc7cLB0dG7@hyeyoo>
 <29271a2b-cf19-4af9-bfe5-5bcff8a23fda@app.fastmail.com>
 <097d8fba-bd10-a312-24a3-a4068c4f424c@suse.cz> <Y2NXiiAF6V2DnBrB@feng-clx>
 <f88a5d34-de05-25d7-832d-36b3a3eddd72@suse.cz> <Y2PNLENnxxpqZ74g@feng-clx>
 <Y2PR45BW2mgLLMwC@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y2PR45BW2mgLLMwC@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 15:36, Hyeonggon Yoo wrote:
> On Thu, Nov 03, 2022 at 10:16:12PM +0800, Feng Tang wrote:
>> On Thu, Nov 03, 2022 at 09:33:28AM +0100, Vlastimil Babka wrote:
>> [...]
>> > >> AFAICS before this patch, we "survive" "kmem_cache *s" being NULL as
>> > >> slab_pre_alloc_hook() will happen to return NULL and we bail out from
>> > >> slab_alloc_node(). But this is a side-effect, not an intended protection.
>> > >> Also the CONFIG_TRACING variant of kmalloc_trace() would have called
>> > >> trace_kmalloc dereferencing s->size anyway even before this patch.
>> > >> 
>> > >> I don't think we should add WARNS in the slab hot paths just to prevent this
>> > >> rare error of using slab too early. At most VM_WARN... would be acceptable
>> > >> but still not necessary as crashing immediately from a NULL pointer is
>> > >> sufficient.
>> > >> 
>> > >> So IMHO mips should fix their soc init, 
>> > > 
>> > > Yes, for the mips fix, John has proposed to defer the calling of prom_soc_init(),
>> > > which looks reasonable.
>> > > 
>> > >> and we should look into the
>> > >> CONFIG_TRACING=n variant of kmalloc_trace(), to pass orig_size properly.
>> > > 
>> > > You mean check if the pointer is NULL and bail out early. 
>> > 
>> > No I mean here:
>> > 
>> > #else /* CONFIG_TRACING */
>> > /* Save a function call when CONFIG_TRACING=n */
>> > static __always_inline __alloc_size(3)                                   
>> > void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
>> > {       
>> >         void *ret = kmem_cache_alloc(s, flags);
>> >                     
>> >         ret = kasan_kmalloc(s, ret, size, flags);
>> >         return ret;
>> > }
>> > 
>> > we call kmem_cache_alloc() and discard the size parameter, so it will assume
>> > s->object_size (and as the side-effect, crash if s is NULL). We shouldn't
>> > add "s is NULL?" checks, but fix passing the size - probably switch to
>> > __kmem_cache_alloc_node()? and in the following kmalloc_node_trace() analogically.
>>  
>> Got it, thanks! I might have missed it during some rebasing for the
>> kmalloc wastage debug patch.
> 
> That was good catch and I missed too!
> But FYI I'm suggesting to drop CONFIG_TRACING=n variant:
> 
> https://lore.kernel.org/linux-mm/20221101222520.never.109-kees@kernel.org/T/#m20ecf14390e406247bde0ea9cce368f469c539ed
> 
> Any thoughts?

I'll get to it, also I think we were pondering that within your series too,
but I wanted to postpone in case somebody objects to the extra function call
it creates.
But that would be for 6.2 anyway while I'll collect the fix here for 6.1.

>> 
>> How about the following fix?
>> 
>> Thanks,
>> Feng
>> 
>> ---
>> From 9f9fa9da8946fd44625f873c0f51167357075be1 Mon Sep 17 00:00:00 2001
>> From: Feng Tang <feng.tang@intel.com>
>> Date: Thu, 3 Nov 2022 21:32:10 +0800
>> Subject: [PATCH] mm/slub: Add missing orig_size parameter for wastage debug
>> 
>> commit 6edf2576a6cc ("mm/slub: enable debugging memory wasting of
>> kmalloc") was introduced for debugging kmalloc memory wastage,
>> and it missed to pass the original request size for kmalloc_trace()
>> and kmalloc_node_trace() in CONFIG_TRACING=n path.
>> 
>> Fix it by using __kmem_cache_alloc_node() with correct original
>> request size.
>> 
>> Fixes: 6edf2576a6cc ("mm/slub: enable debugging memory wasting of kmalloc")
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Feng Tang <feng.tang@intel.com>
>> ---
>>  include/linux/slab.h | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index 90877fcde70b..9691afa569e1 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -469,6 +469,9 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignm
>>  							 __alloc_size(1);
>>  void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
>>  									 __malloc;
>> +void *__kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node,
>> +				size_t orig_size, unsigned long caller) __assume_slab_alignment
>> +									 __malloc;
>>  
>>  #ifdef CONFIG_TRACING
>>  void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
>> @@ -482,7 +485,8 @@ void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
>>  static __always_inline __alloc_size(3)
>>  void *kmalloc_trace(struct kmem_cache *s, gfp_t flags, size_t size)
>>  {
>> -	void *ret = kmem_cache_alloc(s, flags);
>> +	void *ret = __kmem_cache_alloc_node(s, flags, NUMA_NO_NODE,
>> +					    size, _RET_IP_);
>>  
>>  	ret = kasan_kmalloc(s, ret, size, flags);
>>  	return ret;
>> @@ -492,7 +496,8 @@ static __always_inline __alloc_size(4)
>>  void *kmalloc_node_trace(struct kmem_cache *s, gfp_t gfpflags,
>>  			 int node, size_t size)
>>  {
>> -	void *ret = kmem_cache_alloc_node(s, gfpflags, node);
>> +	void *ret = __kmem_cache_alloc_node(s, gfpflags, node,
>> +					    size, _RET_IP_);
>>  
>>  	ret = kasan_kmalloc(s, ret, size, gfpflags);
>>  	return ret;
>> -- 
>> 2.34.1
>> 
>> 
>> 
> 

