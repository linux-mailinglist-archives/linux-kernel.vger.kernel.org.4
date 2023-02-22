Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D470769F930
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjBVQlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjBVQlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:41:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E429366B7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677084019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKvLH39Md6VFASwNimh3Ijve7a+l/n+mf16qXiFcEQs=;
        b=aORvLsDGstN1t7ngnQpYBasfYdWoXDTzRZI4Ej3Ous/wIXYnrnrB7JzHt1aHzlJeIHqfKt
        kywsywiouyYqg78nJSH2+UYgbjdqaaa2HeYDOgh2wB0M3gG+SLu9mxVO8w7yq0owR7/2hg
        pu2j2wVtEgBaaEV6WlAvIX7lBwkE5DE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-386-HY3iPR2XN4G5V8XmrpXQ0w-1; Wed, 22 Feb 2023 11:40:17 -0500
X-MC-Unique: HY3iPR2XN4G5V8XmrpXQ0w-1
Received: by mail-ed1-f72.google.com with SMTP id eh16-20020a0564020f9000b004acc4f8aa3fso11493921edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKvLH39Md6VFASwNimh3Ijve7a+l/n+mf16qXiFcEQs=;
        b=MsXDsT4+fgHwdA6dOLYaw1l+MfYcq81VOadqIrYCMyoZfops5wIsAFYferslzSaxSI
         Rx1vGmJEK6fCRruvjW9vghuaK85REiwM+Y2tSG51VswTVI9xm/8U8zelhSnNe0fn6E1p
         Qb0MQ54qTlQiXQzFWTWVrdC37LCzFZdMYhevkhvXIot0bZlOQ4gWmm+2Lq+pVFpmux00
         inhGF8zZ8lZ4tGi7xCtR7dvE1l18Qwg6eY2p6bYJkYlEqbIoDTDwNHY3p7qbxm+OAqgl
         7esJncM015sJ5QAhSB7qxGMOziRI0OhGTQnGq1eCBar/tRiiODm0TC3LoFCwdtiHve8x
         JjWA==
X-Gm-Message-State: AO0yUKXFLYiSOLbaZ+I7D3dUNHdt7Kwe5TERqhbwWqSlUv0IJmrJMa4I
        /sqJUf2f2KN58mZTyjwDDYGhkIybVVwBk3GR04T2EcjMZa1ESTwIp8UB5OTfhj3MtYl+RL0GaCa
        9tc9PIpH2RipXMmIrpwtSMQ8r
X-Received: by 2002:a17:906:58c6:b0:8ea:825:a5db with SMTP id e6-20020a17090658c600b008ea0825a5dbmr1976003ejs.76.1677084016609;
        Wed, 22 Feb 2023 08:40:16 -0800 (PST)
X-Google-Smtp-Source: AK7set8y1aIvy6/M9izm4ZRhyULPWeIfqPOxVNzTRzQDPPo3HY43nOvrd3fmMTJNtsFtgPLgH4e/yw==
X-Received: by 2002:a17:906:58c6:b0:8ea:825:a5db with SMTP id e6-20020a17090658c600b008ea0825a5dbmr1975964ejs.76.1677084016324;
        Wed, 22 Feb 2023 08:40:16 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id v18-20020a509552000000b004a23558f01fsm3756214eda.43.2023.02.22.08.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 08:40:15 -0800 (PST)
Message-ID: <83755119-083d-7d66-fca0-ca306c841d9c@redhat.com>
Date:   Wed, 22 Feb 2023 17:40:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH drm-next v2 05/16] drm: manager to keep track of GPUs VA
 mappings
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, matthew.brost@intel.com,
        boris.brezillon@collabora.com, alexdeucher@gmail.com,
        ogabbay@kernel.org, bagasdotme@gmail.com, willy@infradead.org,
        jason@jlekstrand.net, linux-doc@vger.kernel.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Dave Airlie <airlied@redhat.com>
References: <20230217134422.14116-1-dakr@redhat.com>
 <20230217134422.14116-6-dakr@redhat.com>
 <70ba382f-1559-289a-4922-ca9c371aaf59@amd.com>
 <cc8eeaf4-31e7-98e4-a712-012fc604e985@redhat.com>
 <29ea3705-5634-c204-c1da-d356b6dfbafc@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <29ea3705-5634-c204-c1da-d356b6dfbafc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 16:14, Christian König wrote:
> Am 22.02.23 um 16:07 schrieb Danilo Krummrich:
>> On 2/22/23 11:25, Christian König wrote:
>>> Am 17.02.23 um 14:44 schrieb Danilo Krummrich:
>>
>> <snip>
>>
>>>> +/**
>>>> + * DOC: Overview
>>>> + *
>>>> + * The DRM GPU VA Manager, represented by struct drm_gpuva_manager 
>>>> keeps track
>>>> + * of a GPU's virtual address (VA) space and manages the 
>>>> corresponding virtual
>>>> + * mappings represented by &drm_gpuva objects. It also keeps track 
>>>> of the
>>>> + * mapping's backing &drm_gem_object buffers.
>>>> + *
>>>> + * &drm_gem_object buffers maintain a list (and a corresponding 
>>>> list lock) of
>>>> + * &drm_gpuva objects representing all existent GPU VA mappings 
>>>> using this
>>>> + * &drm_gem_object as backing buffer.
>>>> + *
>>>> + * If the &DRM_GPUVA_MANAGER_REGIONS feature is enabled, a GPU VA 
>>>> mapping can
>>>> + * only be created within a previously allocated &drm_gpuva_region, 
>>>> which
>>>> + * represents a reserved portion of the GPU VA space. GPU VA 
>>>> mappings are not
>>>> + * allowed to span over a &drm_gpuva_region's boundary.
>>>> + *
>>>> + * GPU VA regions can also be flagged as sparse, which allows 
>>>> drivers to create
>>>> + * sparse mappings for a whole GPU VA region in order to support 
>>>> Vulkan
>>>> + * 'Sparse Resources'.
>>>
>>> Well since we have now found that there is absolutely no technical 
>>> reason for having those regions could we please drop them?
>>
>> I disagree this was the outcome of our previous discussion.
>>
>> In nouveau I still need them to track the separate sparse page tables 
>> and, as you confirmed previously, Nvidia cards are not the only cards 
>> supporting this feature.
>>
>> The second reason is that with regions we can avoid merging between 
>> buffers, which saves some effort. However, I agree that this argument 
>> by itself probably doesn't hold too much, since you've pointed out in 
>> a previous mail that:
>>
>> <cite>
>> 1) If we merge and decide to only do that inside certain boundaries 
>> then those boundaries needs to be provided and checked against. This 
>> burns quite some CPU cycles
>>
>> 2) If we just merge what we can we might have extra page table updates 
>> which cost time and could result in undesired side effects.
>>
>> 3) If we don't merge at all we have additional housekeeping for the 
>> mappings and maybe hw restrictions.
>> </cite>
>>
>> However, if a driver uses regions to track its separate sparse page 
>> tables anyway it gets 1) for free, which is a nice synergy.
>>
>> I totally agree that regions aren't for everyone though. Hence, I made 
>> them an optional feature and by default regions are disabled. In order 
>> to use them drm_gpuva_manager_init() must be called with the 
>> DRM_GPUVA_MANAGER_REGIONS feature flag.
>>
>> I really would not want to open code regions or have two GPUVA manager 
>> instances in nouveau to track sparse page tables. That would be really 
>> messy, hence I hope we can agree on this to be an optional feature.
> 
> I absolutely don't think that this is a good idea then. This separate 
> handling of sparse page tables is completely Nouveau specific.

Actually, I rely on what you said in a previous mail when I say it's, 
potentially, not specific to nouveau.

<cite>
This sounds similar to what AMD hw used to have up until gfx8 (I think), 
basically sparse resources where defined through a separate mechanism to 
the address resolution of the page tables. I won't rule out that other 
hardware has similar approaches.
</cite>

> 
> Even when it's optional feature mixing this into the common handling is 
> exactly what I pointed out as not properly separating between hardware 
> specific and hardware agnostic functionality.

Optionally having regions is *not* a hardware specific concept, drivers 
might use it for a hardware specific purpose though. Which potentially 
is is the case for almost every DRM helper.

Drivers can use regions only for the sake of not merging between buffer 
boundaries as well. Some drivers might prefer this over "never merge" or 
"always merge", depending on the cost of re-organizing page tables for 
unnecessary splits/merges, without having the need of tracking separate 
sparse page tables.

Its just that I think *if* a driver needs to track separate sparse page 
tables anyways its a nice synergy since then there is no extra cost for 
getting this optimization.

> 
> This is exactly the problem we ran into with TTM as well and I've spend 
> a massive amount of time to clean that up again. >

Admittedly, I don't know what problems you are referring to. However, I 
don't see which kind of trouble it could cause by allowing drivers to 
track regions optionally.

> Regards,
> Christian.
> 
>>
>>>
>>> I don't really see a need for them any more.
>>>
>>> Regards,
>>> Christian.
>>>
>>
> 

