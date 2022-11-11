Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75E8625503
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiKKIMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiKKIMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:12:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349F5729B9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:12:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD62E22987;
        Fri, 11 Nov 2022 08:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668154340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rKsv2kApUh0znibD5DPAFWgQv7vvm/xaww+iNqXUWGU=;
        b=G2Mdh1hQw2eLj8LzwM7qY9czs4X4GPfI3e8T59x+EjCQtkufmuzIEpD2K0pfTk6l+/BiP+
        JNQvxiCsrPSJZXZkYaJRv0xTlUbDhiwBJzmPKgy3ML2CkASzSgDEGaK0qGLp73yOh1AL91
        M2CxWRdpJ2kVeoSBscMY3KmTTDzpPJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668154340;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rKsv2kApUh0znibD5DPAFWgQv7vvm/xaww+iNqXUWGU=;
        b=WIuaxZ8tofIql51ub9eoeLcUB0YxIYEBCwxq8YaKITq46feTAdn/ldCWe7mWsAErOOVJqm
        Wzu6ARswVIWwfgDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3698E13357;
        Fri, 11 Nov 2022 08:12:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LnadDOQDbmNcNwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 11 Nov 2022 08:12:20 +0000
Message-ID: <59a0b85a-9001-8c7d-8b98-fd8a87e636fa@suse.cz>
Date:   Fri, 11 Nov 2022 09:12:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v7 3/3] mm/slub: extend redzone check to extra allocated
 kmalloc space than requested
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20221021032405.1825078-1-feng.tang@intel.com>
 <20221021032405.1825078-4-feng.tang@intel.com>
 <e2dd7c7c-b0b7-344a-de37-4624f5339bce@suse.cz> <Y23vtK4tuBogff+m@feng-clx>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y23vtK4tuBogff+m@feng-clx>
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

On 11/11/22 07:46, Feng Tang wrote:
> On Thu, Nov 10, 2022 at 04:48:35PM +0100, Vlastimil Babka wrote:
>> On 10/21/22 05:24, Feng Tang wrote:
>> > kmalloc will round up the request size to a fixed size (mostly power
>> > of 2), so there could be a extra space than what is requested, whose
>> > size is the actual buffer size minus original request size.
>> > 
>> > To better detect out of bound access or abuse of this space, add
>> > redzone sanity check for it.
>> > 
>> > In current kernel, some kmalloc user already knows the existence of
>> > the space and utilizes it after calling 'ksize()' to know the real
>> > size of the allocated buffer. So we skip the sanity check for objects
>> > which have been called with ksize(), as treating them as legitimate
>> > users.
>> 
>> Hm so once Kees's effort is finished and all ksize() users behave correctly,
>> we can drop all that skip_orig_size_check() code, right?
> 
> Yes, will update the commit log.
> 
>> > In some cases, the free pointer could be saved inside the latter
>> > part of object data area, which may overlap the redzone part(for
>> > small sizes of kmalloc objects). As suggested by Hyeonggon Yoo,
>> > force the free pointer to be in meta data area when kmalloc redzone
>> > debug is enabled, to make all kmalloc objects covered by redzone
>> > check.
>> > 
>> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> > Signed-off-by: Feng Tang <feng.tang@intel.com>
>> > Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> 
>> Looks fine, but a suggestion below:
>> 
> [...]
>> > @@ -966,13 +982,27 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
>> >  static void init_object(struct kmem_cache *s, void *object, u8 val)
>> >  {
>> >  	u8 *p = kasan_reset_tag(object);
>> > +	unsigned int orig_size = s->object_size;
>> >  
>> > -	if (s->flags & SLAB_RED_ZONE)
>> > +	if (s->flags & SLAB_RED_ZONE) {
>> >  		memset(p - s->red_left_pad, val, s->red_left_pad);
>> >  
>> > +		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
>> > +			orig_size = get_orig_size(s, object);
>> > +
>> > +			/*
>> > +			 * Redzone the extra allocated space by kmalloc
>> > +			 * than requested.
>> > +			 */
>> > +			if (orig_size < s->object_size)
>> > +				memset(p + orig_size, val,
>> > +				       s->object_size - orig_size);
>> 
>> Wondering if we can remove this if - memset and instead below:
>> 
>> > +		}
>> > +	}
>> > +
>> >  	if (s->flags & __OBJECT_POISON) {
>> > -		memset(p, POISON_FREE, s->object_size - 1);
>> > -		p[s->object_size - 1] = POISON_END;
>> > +		memset(p, POISON_FREE, orig_size - 1);
>> > +		p[orig_size - 1] = POISON_END;
>> >  	}
>> >  
>> >  	if (s->flags & SLAB_RED_ZONE)
>> 
>> This continues by:
>>     memset(p + s->object_size, val, s->inuse - s->object_size);
>> Instead we could do this, no?
>>     memset(p + orig_size, val, s->inuse - orig_size);
> 
> Yep, the code is much simpler and cleaner! thanks
>  
> I also change the name from 'orig_size' to 'poison_size', as below:
> 
> Thanks,
> Feng

Thanks! Now merged all to slab/for-6.2/kmalloc_redzone and for-next

