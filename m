Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD115FEAE8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJNItG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJNItA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:49:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC971781D7;
        Fri, 14 Oct 2022 01:48:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 300C121A2C;
        Fri, 14 Oct 2022 08:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665737338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e92DTbDaQNolF7YKNbIS6b3pmt4/q07KdyY56iTEIVM=;
        b=sJi7T1ThSa1l+g9i6ycsgjAk9iuUOTs7/3izNtA7vQnv0vyYMVFBw41TRBvSfWJEzHS6IV
        wnNgxagYdYqWzA7MRb7ZVLzFdLK2JgsstbQopXqLeqDtsRUQn9vRzk77wMfrVH+jk3lcJo
        kIP0bAClmUL/wZxr/KHNYTaw6GxACNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665737338;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e92DTbDaQNolF7YKNbIS6b3pmt4/q07KdyY56iTEIVM=;
        b=jzHsfiRL+KN0jqgeVZuneNFRQnh63NlQM3eIemKaaGji/7C4arlS9jkiKa/xLFHT23zaB2
        M5vBQmiEajm4ASDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1B8513451;
        Fri, 14 Oct 2022 08:48:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nC9wMnkiSWMSCQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 14 Oct 2022 08:48:57 +0000
Message-ID: <d9b794ea-ff2f-b1a0-0569-1b7a54136242@suse.cz>
Date:   Fri, 14 Oct 2022 10:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] mm: Make failslab writable again
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, kernel@openvz.org,
        Kees Cook <keescook@chromium.org>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220920121111.1792905-1-alexander.atanasov@virtuozzo.com>
 <Yyr1xONdw8dBgsKr@hyeyoo>
 <30063d97-69f0-bea2-9d59-108140995bfc@virtuozzo.com>
 <YzJIsFZQoCEYntvR@hyeyoo>
 <7640a2d9-a32d-2fd7-8f64-586edb9b781e@virtuozzo.com>
 <YzRmZlJBFA9HIlSM@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YzRmZlJBFA9HIlSM@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 17:21, Hyeonggon Yoo wrote:
> On Tue, Sep 27, 2022 at 10:44:20AM +0300, Alexander Atanasov wrote:
>> Hello,
>> 
>> On 27.09.22 3:49, Hyeonggon Yoo wrote:
>> > On Fri, Sep 23, 2022 at 10:34:28AM +0300, Alexander Atanasov wrote:
>> > > Hello,
>> > > 
>> > > On 21.09.22 14:30, Hyeonggon Yoo wrote:
>> > > > On Tue, Sep 20, 2022 at 03:11:11PM +0300, Alexander Atanasov wrote:
>> > > > > In (060807f841ac mm, slub: make remaining slub_debug related attributes
>> > > > > read-only) failslab was made read-only.
>> > > > > I think it became a collateral victim to the two other options for which
>> > > > > the reasons are perfectly valid.
>> > > > > Here is why:
>> > > > >    - sanity_checks and trace are slab internal debug options,
>> > > > >      failslab is used for fault injection.
>> > > > >    - for fault injections, which by presumption are random, it
>> > > > >      does not matter if it is not set atomically. And you need to
>> > > > >      set atleast one more option to trigger fault injection.
>> > > > >    - in a testing scenario you may need to change it at runtime
>> > > > >      example: module loading - you test all allocations limited
>> > > > >      by the space option. Then you move to test only your module's
>> > > > >      own slabs.
>> > > > >    - when set by command line flags it effectively disables all
>> > > > >      cache merges.
>> > > > 
>> > > > Maybe we can make failslab= boot parameter to consider cache filtering?
>> > > > 
>> > > > With that, just pass something like this:
>> > > > 	failslab=X,X,X,X,cache_filter slub_debug=A,<cache-name>>
>> > > 
>> > > > Users should pass slub_debug=A,<cache-name> anyway to prevent cache merging.
>> > > 
>> > > It will be good to have this in case you want to test cache that is used
>> > > early. But why push something to command line option only when it can be
>> > > changed at runtime?
>> > 
>> > Hmm okay. I'm not against changing it writable. (it looks okay to me.)
>> 
>> Okay. Good to know that.
>> 
>> > Just wanted to understand your use case!
>> > Can you please elaborate why booting with slub_debug=A,<your cache name>
>> > and enabling cache_filter after boot does not work?
>> 
>> I didn't say it does not work - it does work but requires reboot. You may
>> want to test variations of caches for example. Cache A, Cache B ... C and so
>> on one by one. Reboots might be fast these days with VMs but you may not be
>> able to test everything in a VM. And ... reboots used to be the signature
>> move of one Other OS.
> 
> Thank you for elaboration!
> Makes sense.
> 
>> 
>> > Or is it trying to changnig these steps,
>> > 
>> > FROM
>> > 	1. booting with slub_debug=A,<cache name>
>> > 	2. write to cache_filter to enable cache filtering
>> > 	3. setup probability, interval, times, size
>> > 
>> > TO
>> > 
>> > 	1. write to failslab attribute of <cache name> (may fail it has alias)
>> > 	2. write to cache_filter to enable cache filtering
>> > 	3. setup probability, interval, times, size
>> > ?
>> > 
>> > as you may know, SLAB_FAILSLAB does nothing whens
>> > cache_filter is disabled, and you should pass slub_debug=A,<cache name> anyway
>> 
>> Okay , i think there awaits another problem:
>> bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>> {
>> ...
>> 
>>         if (failslab.cache_filter && !(s->flags & SLAB_FAILSLAB))
>>                 return false;
>> ...
>> 	return should_fail(&failslab.attr, s->object_size);
>> }
>> 
>> So if you do not have cache_filter set ... you go to should_fail for all
>> slabs.
> 
> Yes.
> 
>> I've been hit by that and spend a lot of time trying to understand why i got
>> crashes at random places. And the reason was that i read an old
>> documentation that said cache_filter is writable and i blindly wrote 1 to
>> it.

I don't understand. It is writable for root, and you can enable it that way, no?

>> If the intent is to only work with cache filter set - then i will update
>> the patch to do so.
> 
> You mean to set cache_filter to true when writing to 'failslab',
> or when setting SLAB_FAILSLAB slab flag?
> 
> I'm not so confident for that because it's implicitly changing.
> Maybe more documentation would be proper?
> 
> what do you think, Vlastimil?

I also don't think we should change cache_filter when writing to a cache's
failslab attribute.

>> This is the only place where SLAB_FAILSLAB is explicitly
>> tested, other places check it as part of SLAB_NEVER_MERGE.
>> 
>> But even for all caches it is kind of possible to test with size(space)
>> which is in turn useful because you need to figure out how you handle
>> failures from external caches - external to your code under test and you
>> don't want to keep track for all of them (same goes for too much options in
>> command line). 
> 
> Yeah, we should be able to inject fault in all caches, or a specific
> cache(s).
> 
>> > to prevent doing cache merging with <cache name>.
>> 
>> Or you can pass SLAB_FAILSLAB from your module when creating the cache to
>> prevent merge when under test.
> 
> Right. I missed that.
> 
>> 
>> 
>> -- 
>> Regards,
>> Alexander Atanasov
>> 
> 

