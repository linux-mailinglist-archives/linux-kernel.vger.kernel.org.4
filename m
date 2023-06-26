Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A746873D59A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 03:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjFZBwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 21:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFZBwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 21:52:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FA3187
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 18:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687744319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sfgyyq+iw8RNZpIOQEvl88qX1LmwtfH97CloAGRNmOk=;
        b=RgFP7yQenEpE+joACsgmToOYLbxcR1C6AotX8NUSPyNEDGk60F4S2Vc+iLV37Zr1a6z2aW
        0g39zNAsqQaeSVtbyTZxbIAOOZW0ID60pZCpiGYJ0OcHuI6AHtqnDuYtWrWYKLccsKu71M
        Al7h73+o6D7+giKCDSe+E8jomYdtR9U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-6ycQJCCLNpWteJ1r-RblhQ-1; Sun, 25 Jun 2023 21:51:57 -0400
X-MC-Unique: 6ycQJCCLNpWteJ1r-RblhQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7e4dc0fe5so16365395e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 18:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687744316; x=1690336316;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfgyyq+iw8RNZpIOQEvl88qX1LmwtfH97CloAGRNmOk=;
        b=CNP2rr4qv0bct4Wg/OShRjBc1qiOZPO2q+ZjekRKxCQOZNZrwr3iByNJDSUULcmQuO
         ZUFXOp3deBUpD4XKF9AbTTE25OdIcrmrQ7dPJh7erhQvY483/mJnSlNZuwzRHDC7evbO
         Cw0NNtrk3H5WUl+c4ExhucsEXJblURN39Bcro/Hv4x2unazGDdA4S+SxGzFu3YJnJN5N
         VYnllq5FU+TBEkwWQBDlV9yOtPcu9wRr3z1dGpkCNYPudllpY0jgDXorjPg10k80S2A0
         7ax9eQr+EXqcf4l3vldtMuoKV5cp0RAdEzow97f9qAEuANuf65FShS/1tTkcvuYZ0jp4
         YKNw==
X-Gm-Message-State: AC+VfDzLf9rTj+6IIO5/c1zb+U0R5p2g5UKfbkqwaK9jheBDqB7T3kme
        YCl8/ujCIQS5wf23Uwbh1h+Kbj1FihzwpVVcuNM6LjOvPA1bjWSBSIzXnKiFJ+w8XpYD5K8FQc8
        OmTYOu/peVLK12g0bLlEgT6Gj
X-Received: by 2002:a5d:448a:0:b0:30e:3ec4:e49e with SMTP id j10-20020a5d448a000000b0030e3ec4e49emr21850451wrq.70.1687744316674;
        Sun, 25 Jun 2023 18:51:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6gpIipJLYnEFx5Q6D/rGiHsZp2nIwlN2f6BezUcw8AvNfBg0LfKZogchXEwUma5epKE/hvvw==
X-Received: by 2002:a5d:448a:0:b0:30e:3ec4:e49e with SMTP id j10-20020a5d448a000000b0030e3ec4e49emr21850445wrq.70.1687744316371;
        Sun, 25 Jun 2023 18:51:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id k26-20020a5d525a000000b003078354f774sm5830052wrc.36.2023.06.25.18.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 18:51:55 -0700 (PDT)
Message-ID: <43ce08db-210a-fec8-51b4-351625b3cdfb@redhat.com>
Date:   Mon, 26 Jun 2023 02:38:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 14/16] maple_tree: Refine mas_preallocate() node
 calculations
Content-Language: en-US
To:     Peng Zhang <perlyzhang@gmail.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        David Airlie <airlied@redhat.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
 <20230612203953.2093911-15-Liam.Howlett@oracle.com>
 <26d8fbcf-d34f-0a79-9d91-8c60e66f7341@redhat.com>
 <cdab5e74-7559-cb31-90ca-b99a5c3a6dd6@gmail.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <cdab5e74-7559-cb31-90ca-b99a5c3a6dd6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 6/25/23 05:28, Peng Zhang wrote:
> 
> 
> 在 2023/6/23 00:41, Danilo Krummrich 写道:
>> On 6/12/23 22:39, Liam R. Howlett wrote:
>>> Calculate the number of nodes based on the pending write action instead
>>> of assuming the worst case.
>>
>> Liam already gave me a heads-up on this patch, which I already replied 
>> to [1].
>>
>> However, I think it might make sense to also reply to this patch 
>> directly.
>>
>> For a mas_preallocate() calculating the actual required nodes to be 
>> allocated instead of assuming the worst to work, it is required to 
>> ensure that the tree does not change between calling mas_preallocate() 
>> and mas_store_prealloc() if my understanding is correct.
>>
>> In DRM however, more specifically the DRM GPUVA Manager [2], we do 
>> have the case that we are not able to ensure this:
>>
>> Jobs to create GPU mappings can be submitted by userspace, are queued 
>> up by the kernel and are processed asynchronously in dma-fence 
>> signalling critical paths, e.g. by using the drm_gpu_scheduler. Hence, 
>> we must be able to allocate the worst case amount of node, since at 
>> the time a job is submitted we can't predict the state the maple tree 
>> keeping track of mappings has once a mapping is inserted in the 
>> (asynchronous) dma-fence signalling critical path.
>>
>> A more detailed explanation can be found in [1].
>>
>> Could we keep a separate function for allocating the worst case amount 
>> of nodes additionally to this optimization? E.g. something like 
>> mas_preallocate_worst_case() or mas_preallocate_unlocked() (since I 
>> guess the new one requires the maple tree to be kept locked in order 
>> not to change)?
> Hi Danilo,
> 
> Your understanding seems incorrect. Even with previously unoptimized
> mas_preallocate(), the maple tree cannot be modified between calls to
> mas_preallocate() and mas_store_prealloc(). The calculation of the
> number of pre-allocated nodes depends on the structure of the maple
> tree. In the unoptimized mas_preallocate(), it depends on the height of
> the tree. If the maple tree is modified before mas_store_prealloc() and
> the height of the tree changes, the number of pre-allocated nodes is
> inaccurate.

Thanks for pointing this out!

First of all, it's probably fair to say "naive me", it totally makes 
sense the tree height is needed - it's a b-tree.

On the other hand, unless I miss something (and if so, please let me 
know), something is bogus with the API then.

While the documentation of the Advanced API of the maple tree explicitly 
claims that the user of the API is responsible for locking, this should 
be limited to the bounds set by the maple tree implementation. Which 
means, the user must decide for either the internal (spin-) lock or an 
external lock (which possibly goes away in the future) and acquire and 
release it according to the rules maple tree enforces through lockdep 
checks.

Let's say one picks the internal lock. How is one supposed to ensure the 
tree isn't modified using the internal lock with mas_preallocate()?

Besides that, I think the documentation should definitely mention this 
limitation and give some guidance for the locking.

Currently, from an API perspective, I can't see how anyone not familiar 
with the implementation details would be able to recognize this limitation.

In terms of the GPUVA manager, unfortunately, it seems like I need to 
drop the maple tree and go back to using a rb-tree, since it seems there 
is no sane way doing a worst-case pre-allocation that does not suffer 
from this limitation.

- Danilo

> 
> Regards,
> Peng
> 
>>
>> [1] 
>> https://lore.kernel.org/nouveau/68cd25de-e767-725e-2e7b-703217230bb0@redhat.com/T/#ma326e200b1de1e3c9df4e9fcb3bf243061fee8b5
>>
>> [2] 
>> https://lore.kernel.org/linux-mm/20230620004217.4700-8-dakr@redhat.com/T/#m47ab82310f87793d0f0cc1825a316eb30ad5b653
>>
>> - Danilo
>>
>>>
>>> This addresses a performance regression introduced in platforms that
>>> have longer allocation timing.
>>>
>>> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>>> ---
>>>   lib/maple_tree.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 47 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>>> index 048d6413a114..7ac5b5457603 100644
>>> --- a/lib/maple_tree.c
>>> +++ b/lib/maple_tree.c
>>> @@ -5541,9 +5541,55 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
>>>    */
>>>   int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>>>   {
>>> +    MA_WR_STATE(wr_mas, mas, entry);
>>> +    unsigned char node_size;
>>> +    int request = 1;
>>>       int ret;
>>> -    mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
>>> +
>>> +    if (unlikely(!mas->index && mas->last == ULONG_MAX))
>>> +        goto ask_now;
>>> +
>>> +    mas_wr_store_setup(&wr_mas);
>>> +    wr_mas.content = mas_start(mas);
>>> +    /* Root expand */
>>> +    if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
>>> +        goto ask_now;
>>> +
>>> +    if (unlikely(!mas_wr_walk(&wr_mas))) {
>>> +        /* Spanning store, use worst case for now */
>>> +        request = 1 + mas_mt_height(mas) * 3;
>>> +        goto ask_now;
>>> +    }
>>> +
>>> +    /* At this point, we are at the leaf node that needs to be 
>>> altered. */
>>> +    /* Exact fit, no nodes needed. */
>>> +    if (wr_mas.r_min == mas->index && wr_mas.r_max == mas->last)
>>> +        return 0;
>>> +
>>> +    mas_wr_end_piv(&wr_mas);
>>> +    node_size = mas_wr_new_end(&wr_mas);
>>> +    /* Slot store can avoid using any nodes */
>>> +    if (node_size == wr_mas.node_end && wr_mas.offset_end - 
>>> mas->offset == 1)
>>> +        return 0;
>>> +
>>> +    if (node_size >= mt_slots[wr_mas.type]) {
>>> +        /* Split, worst case for now. */
>>> +        request = 1 + mas_mt_height(mas) * 2;
>>> +        goto ask_now;
>>> +    }
>>> +
>>> +    /* Appending does not need any nodes */
>>> +    if (node_size == wr_mas.node_end + 1 && mas->offset == 
>>> wr_mas.node_end)
>>> +        return 0;
>>> +
>>> +    /* Potential spanning rebalance collapsing a node, use 
>>> worst-case */
>>> +    if (node_size  - 1 <= mt_min_slots[wr_mas.type])
>>> +        request = mas_mt_height(mas) * 2 - 1;
>>> +
>>> +    /* node store needs one node */
>>> +ask_now:
>>> +    mas_node_count_gfp(mas, request, gfp);
>>>       mas->mas_flags |= MA_STATE_PREALLOC;
>>>       if (likely(!mas_is_err(mas)))
>>>           return 0;
>>
>>
> 

