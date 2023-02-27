Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB42B6A4271
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjB0NSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjB0NSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:18:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769839752
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677503867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7/JwXXOcUANfKgQHRX2hBTjJHPucALZHVEapWMAnt6c=;
        b=Fp2kNCda00wuR/WWJowDJXc7DaCv6I4GaXgjZYU9jdezebapHumbMVTkz/EfventLNwdmY
        E+PvAqofzbfl87LUKKwqQ2pJZOylrmicAjAV4ACB1iBeWkH9esCo6lPKUyZGPwHE8uqQgI
        f8jDykBPLsMXId7J2oNU3CcJsMkc/+Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-_vUxBjRpPYeBzf89_DFCHA-1; Mon, 27 Feb 2023 08:17:45 -0500
X-MC-Unique: _vUxBjRpPYeBzf89_DFCHA-1
Received: by mail-ed1-f72.google.com with SMTP id v12-20020a056402174c00b004acb5c6e52bso8460598edx.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:organization:from
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/JwXXOcUANfKgQHRX2hBTjJHPucALZHVEapWMAnt6c=;
        b=weuivLIlypJYZEXtE2EjPlGjm+p/zUUfcmCR1ZDVZbqauHay6yHhJEFguCxWRwsT2B
         nRRe4vkeBlt1U3I35rA9s/9sg9Dmt+gPXLgDL9ww/OQgfkIzV075GId4TFW8v/c60voI
         rIbzbpH1YJ6fuNkJf80CRSi6l+ruFtjTJRxASA2nuwDZCpt6iGfFo2zAaJW1B/mCX31b
         O2K1ysZiHkAgXTp4rr1HwftN0OKiVWnJ+13OYodDZk/0eHMlFu8PGvevJmbYNEETH8CY
         6XNjQZ6LMiwBkmu+f5oGIC7yxa5c06Zy8ABigtNahP0vuI7i+hvRkhIIGSrfzGkdFblR
         Ganw==
X-Gm-Message-State: AO0yUKX8yR5pzFZ61SQB7HkcdFntaEQbwNqI97aj8DIDfgQND6ddaX/M
        qD6LW4bSLiUqYcgkWFAlIZEFl/KajbDeeq8MH1PQy6eXiw6oIRqiS8tX6lwUh5ICBBLuZMwfFO2
        A4rNQMmeK83xd8JncJNCqPdx4
X-Received: by 2002:a17:906:37cb:b0:8b1:2867:380 with SMTP id o11-20020a17090637cb00b008b128670380mr31973707ejc.22.1677503864553;
        Mon, 27 Feb 2023 05:17:44 -0800 (PST)
X-Google-Smtp-Source: AK7set+Cy7sWsLPXTn4bLU8LAuBfTn0Skdun8SJ+X036TqItJ9jom1n1S1TS3Ov3cpgz77klS/5oQA==
X-Received: by 2002:a17:906:37cb:b0:8b1:2867:380 with SMTP id o11-20020a17090637cb00b008b128670380mr31973678ejc.22.1677503864067;
        Mon, 27 Feb 2023 05:17:44 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id sb11-20020a170906edcb00b008d2d2990c9fsm3238435ejb.93.2023.02.27.05.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 05:17:43 -0800 (PST)
Message-ID: <0868bbeb-11b4-b832-a601-f289278e3e76@redhat.com>
Date:   Mon, 27 Feb 2023 13:23:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH drm-next v2 05/16] drm: manager to keep track of GPUs VA
 mappings
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230217134422.14116-1-dakr@redhat.com>
 <20230217134422.14116-6-dakr@redhat.com>
 <20230221182050.day6z5ge2e3dxerv@revolver>
 <ce3ee7f2-e8a3-80eb-9bca-cd465f7f332e@redhat.com>
 <20230223190941.bkkloowmvqjiu6d7@revolver>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, matthew.brost@intel.com,
        boris.brezillon@collabora.com, alexdeucher@gmail.com,
        ogabbay@kernel.org, bagasdotme@gmail.com, willy@infradead.org,
        jason@jlekstrand.net, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
In-Reply-To: <20230223190941.bkkloowmvqjiu6d7@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/23 20:09, Liam R. Howlett wrote:
> * Danilo Krummrich <dakr@redhat.com> [230222 13:13]:
>> On 2/21/23 19:20, Liam R. Howlett wrote:
>>> * Danilo Krummrich <dakr@redhat.com> [230217 08:45]:
>>>> Add infrastructure to keep track of GPU virtual address (VA) mappings
>>>> with a decicated VA space manager implementation.
>>>>
>>>> New UAPIs, motivated by Vulkan sparse memory bindings graphics drivers
>>>> start implementing, allow userspace applications to request multiple and
>>>> arbitrary GPU VA mappings of buffer objects. The DRM GPU VA manager is
>>>> intended to serve the following purposes in this context.
>>>>
>>>> 1) Provide infrastructure to track GPU VA allocations and mappings,
>>>>      making use of the maple_tree.
>>>>
>>>> 2) Generically connect GPU VA mappings to their backing buffers, in
>>>>      particular DRM GEM objects.
>>>>
>>>> 3) Provide a common implementation to perform more complex mapping
>>>>      operations on the GPU VA space. In particular splitting and merging
>>>>      of GPU VA mappings, e.g. for intersecting mapping requests or partial
>>>>      unmap requests.
>>>>
>>>> Suggested-by: Dave Airlie <airlied@redhat.com>
>>>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>>>> ---
>>>>    Documentation/gpu/drm-mm.rst    |   31 +
>>>>    drivers/gpu/drm/Makefile        |    1 +
>>>>    drivers/gpu/drm/drm_gem.c       |    3 +
>>>>    drivers/gpu/drm/drm_gpuva_mgr.c | 1704 +++++++++++++++++++++++++++++++
>>>>    include/drm/drm_drv.h           |    6 +
>>>>    include/drm/drm_gem.h           |   75 ++
>>>>    include/drm/drm_gpuva_mgr.h     |  714 +++++++++++++
>>>>    7 files changed, 2534 insertions(+)
>>>>    create mode 100644 drivers/gpu/drm/drm_gpuva_mgr.c
>>>>    create mode 100644 include/drm/drm_gpuva_mgr.h
>>>>
>>>> diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
>>>> index a52e6f4117d6..c9f120cfe730 100644
>>>> --- a/Documentation/gpu/drm-mm.rst
>>>> +++ b/Documentation/gpu/drm-mm.rst
>>>> @@ -466,6 +466,37 @@ DRM MM Range Allocator Function References
>>>>    .. kernel-doc:: drivers/gpu/drm/drm_mm.c
>>>>       :export:
>>> ...
>>>
>>>> +
>>>> +/**
>>>> + * drm_gpuva_remove_iter - removes the iterators current element
>>>> + * @it: the &drm_gpuva_iterator
>>>> + *
>>>> + * This removes the element the iterator currently points to.
>>>> + */
>>>> +void
>>>> +drm_gpuva_iter_remove(struct drm_gpuva_iterator *it)
>>>> +{
>>>> +	mas_erase(&it->mas);
>>>> +}
>>>> +EXPORT_SYMBOL(drm_gpuva_iter_remove);
>>>> +
>>>> +/**
>>>> + * drm_gpuva_insert - insert a &drm_gpuva
>>>> + * @mgr: the &drm_gpuva_manager to insert the &drm_gpuva in
>>>> + * @va: the &drm_gpuva to insert
>>>> + * @addr: the start address of the GPU VA
>>>> + * @range: the range of the GPU VA
>>>> + *
>>>> + * Insert a &drm_gpuva with a given address and range into a
>>>> + * &drm_gpuva_manager.
>>>> + *
>>>> + * Returns: 0 on success, negative error code on failure.
>>>> + */
>>>> +int
>>>> +drm_gpuva_insert(struct drm_gpuva_manager *mgr,
>>>> +		 struct drm_gpuva *va)
>>>> +{
>>>> +	u64 addr = va->va.addr;
>>>> +	u64 range = va->va.range;
>>>> +	MA_STATE(mas, &mgr->va_mt, addr, addr + range - 1);
>>>> +	struct drm_gpuva_region *reg = NULL;
>>>> +	int ret;
>>>> +
>>>> +	if (unlikely(!drm_gpuva_in_mm_range(mgr, addr, range)))
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (unlikely(drm_gpuva_in_kernel_region(mgr, addr, range)))
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (mgr->flags & DRM_GPUVA_MANAGER_REGIONS) {
>>>> +		reg = drm_gpuva_in_region(mgr, addr, range);
>>>> +		if (unlikely(!reg))
>>>> +			return -EINVAL;
>>>> +	}
>>>> +
>>>
>>> -----
>>>
>>>> +	if (unlikely(drm_gpuva_find_first(mgr, addr, range)))
>>>> +		return -EEXIST;
>>>> +
>>>> +	ret = mas_store_gfp(&mas, va, GFP_KERNEL);
>>>
>>> mas_walk() will set the internal maple state to the limits to what it
>>> finds.  So, instead of an iterator, you can use the walk function and
>>> ensure there is a large enough area in the existing NULL:
>>>
>>> /*
>>>    * Nothing at addr, mas now points to the location where the store would
>>>    * happen
>>>    */
>>> if (mas_walk(&mas))
>>> 	return -EEXIST;
>>>
>>> /* The NULL entry ends at mas.last, make sure there is room */
>>> if (mas.last < (addr + range - 1))
>>> 	return -EEXIST;
>>>
>>> /* Limit the store size to the correct end address, and store */
>>>    mas.last = addr + range - 1;
>>>    ret = mas_store_gfp(&mas, va, GFP_KERNEL);
>>>
>>
>> Would this variant be significantly more efficient?
> 
> Well, what you are doing is walking the tree to see if there's anything
> there... then re-walking the tree to store it.  So, yes, it's much more
> efficient..  However, writing is heavier.  How much of the time is spent
> walking vs writing depends on the size of the tree, but it's rather easy
> to do this in a single walk of the tree so why wouldn't you?

I will, I was just curious about how much of an impact it has.

> 
>>
>> Also, would this also work while already walking the tree?
> 
> Yes, to an extent.  If you are at the correct location in the tree, you
> can write to that location.  If you are not in the correct location and
> try to write to the tree then things will go poorly..  In this scenario,
> we are very much walking the tree and writing to it in two steps.
> 
>>
>> To remove an entry while walking the tree I have a separate function
>> drm_gpuva_iter_remove(). Would I need something similar for inserting
>> entries?
> 
> I saw that.  Your remove function uses the erase operation which is
> implemented as a walk to that location and a store of a null over the
> range that is returned.  You do not need a function to insert an entry
> if the maple state is at the correct location, and that doesn't just
> mean setting mas.index/mas.last to the correct value.  There is a node &
> offset saved in the maple state that needs to be in the correct
> location.  If you store to that node then the node may be replaced, so
> other iterators that you have may become stale, but the one you used
> execute the store operation will now point to the new node with the new
> entry.
> 
>>
>> I already provided this example in a separate mail thread, but it may makes
>> sense to move this to the mailing list:
>>
>> In __drm_gpuva_sm_map() we're iterating a given range of the tree, where the
>> given range is the size of the newly requested mapping. __drm_gpuva_sm_map()
>> invokes a callback for each sub-operation that needs to be taken in order to
>> fulfill this mapping request. In most cases such a callback just creates a
>> drm_gpuva_op object and stores it in a list.
>>
>> However, drivers can also implement the callback, such that they directly
>> execute this operation within the callback.
>>
>> Let's have a look at the following example:
>>
>>       0     a     2
>> old: |-----------|       (bo_offset=n)
>>
>>             1     b     3
>> req:       |-----------| (bo_offset=m)
>>
>>       0  a' 1     b     3
>> new: |-----|-----------| (a.bo_offset=n,b.bo_offset=m)
>>
>> This would result in the following operations.
>>
>> __drm_gpuva_sm_map() finds entry "a" and calls back into the driver
>> suggesting to re-map "a" with the new size. The driver removes entry "a"
>> from the tree and adds "a'"
> 
> What you have here won't work.  The driver will cause your iterators
> maple state to point to memory that is freed.  You will either need to
> pass through your iterator so that the modifications can occur with that
> maple state so it remains valid, or you will need to invalidate the
> iterator on every modification by the driver.
> 
> I'm sure the first idea you have will be to invalidate the iterator, but
> that is probably not the way to proceed.  Even ignoring the unclear
> locking of two maple states trying to modify the tree, this is rather
> inefficient - each invalidation means a re-walk of the tree.  You may as
> well not use an iterator in this case.
> 
> Depending on how/when the lookups occur, you could still iterate over
> the tree and let the driver modify the ending of "a", but leave the tree
> alone and just store b over whatever - but the failure scenarios may
> cause you grief.
> 
> If you pass the iterator through, then you can just use it to do your
> writes and keep iterating as if nothing changed.

Passing through the iterater clearly seems to be the way to go.

I assume that if the entry to insert isn't at the location of the 
iterator (as in the following example) we can just keep walking to this 
location my changing the index of the mas and calling mas_walk()? This 
would also imply that the "outer" tree walk continues after the entry we 
just inserted, right?

            1     a     3
old:       |-----------| (bo_offset=n)

      0     b     2
req: |-----------|       (bo_offset=m)

      0     b     2  a' 3
new: |-----------|-----| (b.bo_offset=m,a.bo_offset=n+2)

Again, after finding "a", we want to remove it and insert "a'" instead.

> 
>>
>> __drm_gpuva_sm_map(), ideally, continues the loop searching for nodes
>> starting from the end of "a" (which is 2) till the end of the requested
>> mapping "b" (which is 3). Since it doesn't find any other mapping within
>> this range it calls back into the driver suggesting to finally map "b".
>>
>> If there would have been another mapping between 2 and 3 it would have
>> called back into the driver asking to unmap this mapping beforehand.
>>
>> So, it boils down to re-mapping as described at the beginning (and
>> analogously at the end) of a new mapping range and removing of entries that
>> are enclosed by the new mapping range.
> 
> I assume the unmapped area is no longer needed, and the 're-map' is
> really a removal of information?  Otherwise I'd suggest searching for a
> gap which fits your request.  What you have here is a lot like
> "MAP_FIXED" vs top-down/bottom-up search in the VMA code, this seems to
> be like your __drm_gpuva_sm_map() and the drm mm range allocator with
> DRM_MM_INSERT_LOW, and DRM_MM_INSERT_HIGH.
> 
> Why can these split/unmappings fail?  Is it because they are still
> needed?
> 

You mean the check before the mas_*() operations in drm_gpuva_insert()?

Removing entries should never fail, inserting entries should fail when 
the caller tries to store to an area outside of the VA space (it doesn't 
necessarily span the whole 64-bit space), a kernel reserved area of the 
VA space, is not in any pre-allocated range of the VA space (if regions 
are enabled) or an entry already exists at that location.

>>
>>>> +	if (unlikely(ret))
>>>> +		return ret;
>>>> +
>>>> +	va->mgr = mgr;
>>>> +	va->region = reg;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL(drm_gpuva_insert);
>>>> +
>>>> +/**
>>>> + * drm_gpuva_remove - remove a &drm_gpuva
>>>> + * @va: the &drm_gpuva to remove
>>>> + *
>>>> + * This removes the given &va from the underlaying tree.
>>>> + */
>>>> +void
>>>> +drm_gpuva_remove(struct drm_gpuva *va)
>>>> +{
>>>> +	MA_STATE(mas, &va->mgr->va_mt, va->va.addr, 0);
>>>> +
>>>> +	mas_erase(&mas);
>>>> +}
>>>> +EXPORT_SYMBOL(drm_gpuva_remove);
>>>> +
>>> ...
>>>
>>>> +/**
>>>> + * drm_gpuva_find_first - find the first &drm_gpuva in the given range
>>>> + * @mgr: the &drm_gpuva_manager to search in
>>>> + * @addr: the &drm_gpuvas address
>>>> + * @range: the &drm_gpuvas range
>>>> + *
>>>> + * Returns: the first &drm_gpuva within the given range
>>>> + */
>>>> +struct drm_gpuva *
>>>> +drm_gpuva_find_first(struct drm_gpuva_manager *mgr,
>>>> +		     u64 addr, u64 range)
>>>> +{
>>>> +	MA_STATE(mas, &mgr->va_mt, addr, 0);
>>>> +
>>>> +	return mas_find(&mas, addr + range - 1);
>>>> +}
>>>> +EXPORT_SYMBOL(drm_gpuva_find_first);
>>>> +
>>>> +/**
>>>> + * drm_gpuva_find - find a &drm_gpuva
>>>> + * @mgr: the &drm_gpuva_manager to search in
>>>> + * @addr: the &drm_gpuvas address
>>>> + * @range: the &drm_gpuvas range
>>>> + *
>>>> + * Returns: the &drm_gpuva at a given &addr and with a given &range
>>>
>>> Note that mas_find() will continue upwards in the address space if there
>>> isn't anything at @addr.  This means that &drm_gpuva may not be at
>>> &addr.  If you want to check just at &addr, use mas_walk().
>>
>> Good catch. drm_gpuva_find() should then either also check for 'va->va.addr
>> == addr' as well or, alternatively, use mas_walk(). As above, any reason to
>> prefer mas_walk()?
>>
>>>
>>>> + */
>>>> +struct drm_gpuva *
>>>> +drm_gpuva_find(struct drm_gpuva_manager *mgr,
>>>> +	       u64 addr, u64 range)
>>>> +{
>>>> +	struct drm_gpuva *va;
>>>> +
>>>> +	va = drm_gpuva_find_first(mgr, addr, range);
>>>> +	if (!va)
>>>> +		goto out;
>>>> +
>>>> +	if (va->va.range != range)
>>>> +		goto out;
>>>> +
>>>> +	return va;
>>>> +
>>>> +out:
>>>> +	return NULL;
>>>> +}
>>>> +EXPORT_SYMBOL(drm_gpuva_find);
>>>> +
>>>> +/**
>>>> + * drm_gpuva_find_prev - find the &drm_gpuva before the given address
>>>> + * @mgr: the &drm_gpuva_manager to search in
>>>> + * @start: the given GPU VA's start address
>>>> + *
>>>> + * Find the adjacent &drm_gpuva before the GPU VA with given &start address.
>>>> + *
>>>> + * Note that if there is any free space between the GPU VA mappings no mapping
>>>> + * is returned.
>>>> + *
>>>> + * Returns: a pointer to the found &drm_gpuva or NULL if none was found
>>>> + */
>>>> +struct drm_gpuva *
>>>> +drm_gpuva_find_prev(struct drm_gpuva_manager *mgr, u64 start)
>>>
>>> find_prev() usually continues beyond 1 less than the address. I found
>>> this name confusing.
>>
>> Don't really get that, mind explaining?
> 
> When I ask for the previous one in a list or tree, I think the one
> before.. but since you are limiting your search from start to start - 1,
> you may as well walk to start - 1 and see if one exists.
> 
> Is that what you meant to do here?

Yes, I want to know whether there is a previous entry which ends right 
before the current entry, without a gap between the two.

> 
>>
>>> You may as well use mas_walk(), it would be faster.
>>
>> How would I use mas_walk() for that? If I understand it correctly,
>> mas_walk() requires me to know that start address, which I don't know for
>> the previous entry.
> 
> mas_walk() walks to the value you specify and returns the entry at that
> address, not necessarily the start address, but any address in the
> range.
> 
> If you have a tree and store A = [0x1000 - 0x2000] and set your maple
> state to walk to 0x1500, mas_walk() will return A, and the maple state
> will have mas.index = 0x1000 and mas.last = 0x2000.
> 
> You have set the maple state to start at "start" and called
> mas_prev(&mas, start - 1).  start - 1 is the lower limit, so the
> internal implementation will walk to start then go to the previous entry
> until start - 1.. it will stop at start - 1 and return NULL if there
> isn't one there.

Thanks for the clarification and all the other very helpful comments and 
explanations!

- Danilo

> 
>>
>> However, mas_walk() seems to be a good alternative to use for
>> drm_gpuva_find_next().
>>
>>>> +{
>>>> +	MA_STATE(mas, &mgr->va_mt, start, 0);
>>>> +
>>>> +	if (start <= mgr->mm_start ||
>>>> +	    start > (mgr->mm_start + mgr->mm_range))
>>>> +		return NULL;
>>>> +
>>>> +	return mas_prev(&mas, start - 1);
>>>> +}
>>>> +EXPORT_SYMBOL(drm_gpuva_find_prev);
>>>> +
>>>> +/**
>>>> + * drm_gpuva_find_next - find the &drm_gpuva after the given address
>>>> + * @mgr: the &drm_gpuva_manager to search in
>>>> + * @end: the given GPU VA's end address
>>>> + *
>>>> + * Find the adjacent &drm_gpuva after the GPU VA with given &end address.
>>>> + *
>>>> + * Note that if there is any free space between the GPU VA mappings no mapping
>>>> + * is returned.
>>>> + *
>>>> + * Returns: a pointer to the found &drm_gpuva or NULL if none was found
>>>> + */
>>>> +struct drm_gpuva *
>>>> +drm_gpuva_find_next(struct drm_gpuva_manager *mgr, u64 end)
>>>
>>> This name is also a bit confusing for the same reason.  Again, it seems
>>> worth just walking to end here.
>>>
>>>> +{
>>>> +	MA_STATE(mas, &mgr->va_mt, end - 1, 0);
>>>> +
>>>> +	if (end < mgr->mm_start ||
>>>> +	    end >= (mgr->mm_start + mgr->mm_range))
>>>> +		return NULL;
>>>> +
>>>> +	return mas_next(&mas, end);
>>>> +}
>>>> +EXPORT_SYMBOL(drm_gpuva_find_next);
>>>> +
>>>> +static int
>>>> +__drm_gpuva_region_insert(struct drm_gpuva_manager *mgr,
>>>> +			  struct drm_gpuva_region *reg)
>>>> +{
>>>> +	u64 addr = reg->va.addr;
>>>> +	u64 range = reg->va.range;
>>>> +	MA_STATE(mas, &mgr->region_mt, addr, addr + range - 1);
>>>> +	int ret;
>>>> +
>>>> +	if (unlikely(!drm_gpuva_in_mm_range(mgr, addr, range)))
>>>> +		return -EINVAL;
>>>> +
>>>> +	ret = mas_store_gfp(&mas, reg, GFP_KERNEL);
>>>> +	if (unlikely(ret))
>>>> +		return ret;
>>>> +
>>>> +	reg->mgr = mgr;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * drm_gpuva_region_insert - insert a &drm_gpuva_region
>>>> + * @mgr: the &drm_gpuva_manager to insert the &drm_gpuva in
>>>> + * @reg: the &drm_gpuva_region to insert
>>>> + * @addr: the start address of the GPU VA
>>>> + * @range: the range of the GPU VA
>>>> + *
>>>> + * Insert a &drm_gpuva_region with a given address and range into a
>>>> + * &drm_gpuva_manager.
>>>> + *
>>>> + * Returns: 0 on success, negative error code on failure.
>>>> + */
>>>> +int
>>>> +drm_gpuva_region_insert(struct drm_gpuva_manager *mgr,
>>>> +			struct drm_gpuva_region *reg)
>>>> +{
>>>> +	if (unlikely(!(mgr->flags & DRM_GPUVA_MANAGER_REGIONS)))
>>>> +		return -EINVAL;
>>>> +
>>>> +	return __drm_gpuva_region_insert(mgr, reg);
>>>> +}
>>>> +EXPORT_SYMBOL(drm_gpuva_region_insert);
>>>> +
>>>> +static void
>>>> +__drm_gpuva_region_remove(struct drm_gpuva_region *reg)
>>>> +{
>>>> +	struct drm_gpuva_manager *mgr = reg->mgr;
>>>> +	MA_STATE(mas, &mgr->region_mt, reg->va.addr, 0);
>>>> +
>>>> +	mas_erase(&mas);
>>>> +}
>>>> +
>>>> +/**
>>>> + * drm_gpuva_region_remove - remove a &drm_gpuva_region
>>>> + * @reg: the &drm_gpuva to remove
>>>> + *
>>>> + * This removes the given &reg from the underlaying tree.
>>>> + */
>>>> +void
>>>> +drm_gpuva_region_remove(struct drm_gpuva_region *reg)
>>>> +{
>>>> +	struct drm_gpuva_manager *mgr = reg->mgr;
>>>> +
>>>> +	if (unlikely(!(mgr->flags & DRM_GPUVA_MANAGER_REGIONS)))
>>>> +		return;
>>>> +
>>>> +	if (unlikely(reg == &mgr->kernel_alloc_region)) {
>>>> +		WARN(1, "Can't destroy kernel reserved region.\n");
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	if (unlikely(!drm_gpuva_region_empty(reg)))
>>>> +		WARN(1, "GPU VA region should be empty on destroy.\n");
>>>> +
>>>> +	__drm_gpuva_region_remove(reg);
>>>> +}
>>>> +EXPORT_SYMBOL(drm_gpuva_region_remove);
>>>> +
>>>> +/**
>>>> + * drm_gpuva_region_empty - indicate whether a &drm_gpuva_region is empty
>>>> + * @reg: the &drm_gpuva to destroy
>>>> + *
>>>> + * Returns: true if the &drm_gpuva_region is empty, false otherwise
>>>> + */
>>>> +bool
>>>> +drm_gpuva_region_empty(struct drm_gpuva_region *reg)
>>>> +{
>>>> +	DRM_GPUVA_ITER(it, reg->mgr);
>>>> +
>>>> +	drm_gpuva_iter_for_each_range(it, reg->va.addr,
>>>> +				      reg->va.addr +
>>>> +				      reg->va.range)
>>>> +		return false;
>>>> +
>>>> +	return true;
>>>> +}
>>>> +EXPORT_SYMBOL(drm_gpuva_region_empty);
>>>> +
>>>> +/**
>>>> + * drm_gpuva_region_find_first - find the first &drm_gpuva_region in the given
>>>> + * range
>>>> + * @mgr: the &drm_gpuva_manager to search in
>>>> + * @addr: the &drm_gpuva_regions address
>>>> + * @range: the &drm_gpuva_regions range
>>>> + *
>>>> + * Returns: the first &drm_gpuva_region within the given range
>>>> + */
>>>> +struct drm_gpuva_region *
>>>> +drm_gpuva_region_find_first(struct drm_gpuva_manager *mgr,
>>>> +			    u64 addr, u64 range)
>>>> +{
>>>> +	MA_STATE(mas, &mgr->region_mt, addr, 0);
>>>> +
>>>> +	return mas_find(&mas, addr + range - 1);
>>>> +}
>>>> +EXPORT_SYMBOL(drm_gpuva_region_find_first);
>>>> +
>>>> +/**
>>>> + * drm_gpuva_region_find - find a &drm_gpuva_region
>>>> + * @mgr: the &drm_gpuva_manager to search in
>>>> + * @addr: the &drm_gpuva_regions address
>>>> + * @range: the &drm_gpuva_regions range
>>>> + *
>>>> + * Returns: the &drm_gpuva_region at a given &addr and with a given &range
>>>
>>> again, I'm not sure you want to find first or walk here.. It sounds like
>>> you want exactly addr to addr + range VMA?
>>
>> Exactly, same as above.
> 
> MA_STATE(mas, &mgr->region_mt, addr, addr);
> 
> reg = mas_walk(&mas);
> if (!reg)
> 	return reg;
> 
> if ((mas.index != addr) | (mas.last != range - 1))
> 	return NULL;
> 
> return reg;
> 
>>
>>>
>>>> + */
>>>> +struct drm_gpuva_region *
>>>> +drm_gpuva_region_find(struct drm_gpuva_manager *mgr,
>>>> +		      u64 addr, u64 range)
>>>> +{
>>>> +	struct drm_gpuva_region *reg;
>>>> +
>>>> +	reg = drm_gpuva_region_find_first(mgr, addr, range);
> 
> mas_find() will keep searching, so you may get a VMA that starts higher
> than addr.
> 
>>>> +	if (!reg)
>>>> +		goto out;
>>>> +
>>>> +	if (reg->va.range != range)
>>>> +		goto out;
>>>> +
>>>> +	return reg;
>>>> +
>>>> +out:
>>>> +	return NULL;
>>>> +}
>>>> +EXPORT_SYMBOL(drm_gpuva_region_find);
>>>> +
>>>
>>> ...
>>>
>>
> 

