Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519EE73FF24
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjF0O7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjF0O7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E74435AA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687877894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=22WIB2A6ca/NnHLuFFcsjHuBNywV8R5tbGUZ8poEA4c=;
        b=O7jxeIo+wDzoDIJ1pYiZyunWRvrr3Jbq3Qh6gcE4lIgl9xBDXy5uSO0+jCFOZF3f6gZrcH
        KSMjjtSi2+PUGZ0dy5bmPYrpTN32OLnC+ARCssAkBcYG9Rf/k+MOuAfLod8VasD7/V2ohL
        38mAVZyMum8W7fzuzRFjdTI1W46tC/E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-ypxCbvpmOriIllpWxr-vDw-1; Tue, 27 Jun 2023 10:58:12 -0400
X-MC-Unique: ypxCbvpmOriIllpWxr-vDw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f9d7ff4b6aso27243595e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687877891; x=1690469891;
        h=content-transfer-encoding:in-reply-to:organization:from:cc
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22WIB2A6ca/NnHLuFFcsjHuBNywV8R5tbGUZ8poEA4c=;
        b=EScuCuECec8Kwb2EAUu/Nj1HVk2sq4WLZlbARw30XQYV5Wp83XCGyijm6gdsR2QmhD
         qe705HIHTDhV4HhQHXr1j7DY2lYGS8pSJ66rzAro7mRDHKx/RT2dLgoT23e0HDSAJ+ZM
         YlOMavm5dQITAcHKS+DyKk9osHRuQvuHkig5JZdxUkf7RNBLwb5fjAs4Njpy8AmKBt5o
         Wrxc7C7SKkZzTXRcu1mcHyXauhgVZKMbbT8YDOrrr1aNY0bY+IhHbO8CEYFjRK0H6ee7
         zntOdncpybXd4EJYm/aiwJk77Ef4muprvn3iuXi6siOQxvYsZwAqL9aLa4Muu2Xv9L2b
         uKVw==
X-Gm-Message-State: AC+VfDxOn/s99g3WYAME2jsg3xyzsHVky+A5BlXkzKvhJne1O3eBm5cw
        bVaBpn47ExOnp86i8y7gS7/U2Up+kXU85FVM1dudhI/Ubw9mPA8yRZ0h5clfIUaJiVwqXPlLtUu
        //54oKSa0nOpraNtb21IY61VD
X-Received: by 2002:a7b:cd89:0:b0:3fa:77f2:e255 with SMTP id y9-20020a7bcd89000000b003fa77f2e255mr11560435wmj.5.1687877891441;
        Tue, 27 Jun 2023 07:58:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61jcVhTD0zZcew2gvDckPUL/B+cQLRZ/+isa5eHR+vXxkfvm9FF02emyUVceHzBZqZfr255Q==
X-Received: by 2002:a7b:cd89:0:b0:3fa:77f2:e255 with SMTP id y9-20020a7bcd89000000b003fa77f2e255mr11560420wmj.5.1687877891065;
        Tue, 27 Jun 2023 07:58:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d6550000000b00313f4304bcasm5174625wrv.16.2023.06.27.07.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 07:58:10 -0700 (PDT)
Message-ID: <08d4385b-15f6-f0e4-bc5d-528f6a8af3f3@redhat.com>
Date:   Tue, 27 Jun 2023 15:15:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 14/16] maple_tree: Refine mas_preallocate() node
 calculations
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
 <20230612203953.2093911-15-Liam.Howlett@oracle.com>
 <26d8fbcf-d34f-0a79-9d91-8c60e66f7341@redhat.com>
 <cdab5e74-7559-cb31-90ca-b99a5c3a6dd6@gmail.com>
 <43ce08db-210a-fec8-51b4-351625b3cdfb@redhat.com>
 <ZJmQVeiLtkFAGfW0@casper.infradead.org>
 <57527c36-57a1-6699-b6f0-373ba895014c@redhat.com>
 <ZJmmFF1Hz5ajRhy3@casper.infradead.org>
 <8cc06224-8243-e08e-d0ea-4db71ddc7745@redhat.com>
 <20230627015832.a4rojonhlykemose@revolver>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <perlyzhang@gmail.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        David Airlie <airlied@redhat.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230627015832.a4rojonhlykemose@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On 6/27/23 03:58, Liam R. Howlett wrote:
> * Danilo Krummrich <dakr@redhat.com> [230626 14:37]:
>> On 6/26/23 16:52, Matthew Wilcox wrote:
>>> On Mon, Jun 26, 2023 at 04:27:54PM +0200, Danilo Krummrich wrote:
>>>> On 6/26/23 15:19, Matthew Wilcox wrote:
>>>>> On Mon, Jun 26, 2023 at 02:38:06AM +0200, Danilo Krummrich wrote:
>>>>>> On the other hand, unless I miss something (and if so, please let me know),
>>>>>> something is bogus with the API then.
>>>>>>
>>>>>> While the documentation of the Advanced API of the maple tree explicitly
>>>>>> claims that the user of the API is responsible for locking, this should be
>>>>>> limited to the bounds set by the maple tree implementation. Which means, the
>>>>>> user must decide for either the internal (spin-) lock or an external lock
>>>>>> (which possibly goes away in the future) and acquire and release it
>>>>>> according to the rules maple tree enforces through lockdep checks.
>>>>>>
>>>>>> Let's say one picks the internal lock. How is one supposed to ensure the
>>>>>> tree isn't modified using the internal lock with mas_preallocate()?
>>>>>>
>>>>>> Besides that, I think the documentation should definitely mention this
>>>>>> limitation and give some guidance for the locking.
>>>>>>
>>>>>> Currently, from an API perspective, I can't see how anyone not familiar with
>>>>>> the implementation details would be able to recognize this limitation.
>>>>>>
>>>>>> In terms of the GPUVA manager, unfortunately, it seems like I need to drop
>>>>>> the maple tree and go back to using a rb-tree, since it seems there is no
>>>>>> sane way doing a worst-case pre-allocation that does not suffer from this
>>>>>> limitation.
>>>>>
>>>>> I haven't been paying much attention here (too many other things going
>>>>> on), but something's wrong.
>>>>>
>>>>> First, you shouldn't need to preallocate.  Preallocation is only there
>>>>
>>>> Unfortunately, I think we really have a case where we have to. Typically GPU
>>>> mappings are created in a dma-fence signalling critical path and that is
>>>> where such mappings need to be added to the maple tree. Hence, we can't do
>>>> any sleeping allocations there.
>>>
>>> OK, so there are various ways to hadle this, depending on what's
>>> appropriate for your case.
>>>
>>> The simplest is to use GFP_ATOMIC.  Essentially, you're saying to the MM
>>> layer "This is too hard, let me tap into the emergency reserves".  It's
>>> mildly frowned upon, so let's see if we can do better.
>>>
>>> If you know where the allocation needs to be stored, but want it to act as
>>> NULL until the time is right, you can store a ZERO entry.  That will read
>>> as NULL until you store to it.  A pure overwriting store will not cause
>>> any memory allocation since all the implementation has to do is change
>>> a pointer.  The XArray wraps this up nicely behind an xa_reserve() API.
>>> As you're discovering, the Maple Tree API isn't fully baked yet.
>>>
>>
>> Unfortunately, GFP_ATOMIC seems the be the only option. I think storing
>> entries in advance would not work. Typically userspace submits a job to the
>> kernel issuing one or multiple requests to map and unmap memory in an ioctl.
>> Such a job is then put into a queue and processed asynchronously in a
>> dma-fence signalling critical section. Hence, at the we'd store entries in
>> advance we could have an arbitrary amount of pending jobs potentially still
>> messing with the same address space region.
> 
> What I think you are saying is that you have a number of requests
> flooding in, which may overwrite the same areas, but are queued up to be
> written after they are queued.  These operations look to be kept in
> order according to the code in nouveau_job_submit[1].  Is this correct?

That's all correct.

(Although Nouveau isn't a good example in this case. Some aspects of it 
do and some aspects of it do not apply to the problem we're discussing 
here.)

> 
> So then, your issue isn't that you don't know where they will land, but
> don't know if the area that you reserved is already split into other
> areas?  For instance, before the range 5-10 is backed by whatever
> happens in the fence, it may have already become 5-6 & 8-10 by something
> that came after (from userspace) but hasn't been processed by the
> kernel that will live at 7?  So you can't write 5-10 right away because
> you can't be sure 5-10 is going to exist once you reach the kernel fence
> code that stores the entry?
> 
> Is my understanding of your issue correct?

Yes, it is.

However, the problem already starts while trying to reserve an area. In 
order to satisfy a user request, such a request is broken down into 
operations such as unmap mappings which are in the way entirely, remap 
mappings which intersect with the requested mapping and finally map the 
requested mapping. The execution of such a sequence must appear atomic 
and hence be locked accordingly. When trying to reserve an area we'd 
need to take that lock. But since this lock would be used in the 
dma-fence signalling critical path as well we'd not be allowed to do 
sleeping allocations while holding this lock.

Potentially, this could be solved with a retry loop though. Drop the 
lock while allocating, take it again and check whether we still got 
enough nodes allocated. Analogous to what the maple tree does in 
mas_store_gfp(), I guess.

> 
> Oh, and I guess the queued requests would have to remain ordered between
> threads or whatever is on the other side?  I mean, you can't have two
> threads firing different things into the kernel at the same region
> because I would think the results would be unpredictable?

Once a job is queued up in the kernel they remain ordered.

However, user threads could concurrently push jobs to the kernel 
altering the same region of the address space - it just would not make 
any sense for userspace to do that.

In general userspace is responsible for the semantics of the address 
space. The kernel basically just takes any (valid) request and make it 
happen. It also assures waiting and signalling of fences which might be 
bound to certain jobs and obviously keeps track of the VA space to be 
able to clean things up once a client disappears.

> 
> Can these overlapping entries partially overlap one region and another?
> That is, can you have three in-flight writes that does something like:
> store 1-10, store 10-20, store 5-15?

Absolutely, yes.

> 
> How stable of an output is needed?  Does each kernel write need to be
> 100% correct or is there a point where the userspace updates stop and
> only then it is needed to be stable?

It needs to be 100% correct all the time. The reason is that, as 
mentioned above, every job can carry in- and out-fences, such that 
userspace can order these jobs against the execution of shaders.

This is also why there could be jobs queued up, where all of them apply 
changes to the same region within the VA space, since there might be 
shader executions (or just memory copies) ordered right between them.

- Danilo

> 
>>
>> So, the only way to go seems to be to use mas_store_gfp() with GFP_ATOMIC
>> directly in the fence signalling critical path. I guess mas_store_gfp() does
>> not BUG_ON() if it can't get atomic pages?
>>
>> Also, I just saw that the tree is limited in it's height (MAPLE_HEIGHT_MAX).
>> Do you think it could be a sane alternative to pre-allocate with
>> MAPLE_HEIGHT_MAX rather than to rely on atomic pages? Or maybe a compromise
>> of pre-allocating just a couple of nodes and then rely on atomic pages for
>> the rest?
>>
>> FYI, we're talking about a magnitude of hundreds of thousands of entries to
>> be stored in the tree.
>>
> 
> Since you are not tracking gaps, you will get 16 entries per node.  The
> maximum height is 31, so that would be 16^31, assuming a gap between
> each entry (the worst case), you can cut that in 1/2.  To assure you can
> successfully allocate storage for a new entries, you'd need to allocate
> 30 * 3 + 1, or 91 nodes, which is 6 pages.  That'll be highly wasteful
> as almost all of these would be freed, and sometimes all of them.
> 
> You estimate less than 1M entries, that would never go over 6 levels (8.3M
> entries with the worst-case).  5 levels would get you 500K in the worst
> case, but realistically you'll be in the 5 levels almost always.  So,
> 5*3+1 = 17 nodes, or 2 pages (1 node over 1 page).. assuming 4k pages.
> 
> [1] https://lore.kernel.org/linux-mm/20230620004217.4700-8-dakr@redhat.com/T/#Z2e.:..:20230620004217.4700-4-dakr::40redhat.com:1drivers:gpu:drm:drm_gem.c
> 

