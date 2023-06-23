Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A74D73BB94
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjFWPZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjFWPZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752E5C2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687533859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/S7PlGAxyYZzFvK0bsc5hgdhJYvUxmCp25URDm0iv8=;
        b=gMOET0b/kuhZ39XliiIIsZL2HYwZC1l7JzNFWCqcf6aBwaPr9Ugf0XIPOh1bRYYjFE3rrJ
        Gp2BSbpOn3bc1UOKPUjwCDrJB7NSWp6m8eh9NdSXY16OsCuFiv2DAEIixv3Q4q3+vyEW/t
        TK65n8zf1ifJ2eAoM/Ekr7TX7jKNCXY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-E3s0A8mnP_eGx-FHUMfKeg-1; Fri, 23 Jun 2023 11:24:17 -0400
X-MC-Unique: E3s0A8mnP_eGx-FHUMfKeg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1b506eb8798so5407505ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533856; x=1690125856;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/S7PlGAxyYZzFvK0bsc5hgdhJYvUxmCp25URDm0iv8=;
        b=WVFPWY4m8clglJ6d4ShN+Dc7aB0b98RZySZmY4lrY/faMBqesEZHNWGNIeDLVGyBGi
         KW+C8A1OQZCGXJr+OnT770TxQZ9sffle6PxPuuHm8qrtX/7PnM0uxxB7vrXfOQUTAP0Q
         kU7GfHMk0+7DIYm4V43e4NrouFbqeOPL3b6wtDLZG8FD62lvcW5nJB3vjevx8KrNOv9l
         f+m9ax7+ENyotSJSgFZOugepl59Gx84Bvy+Y+qRAzjDD12r8fuItqPmEv5LfddSgom/6
         fXMqwapb9ODJ708VfDOSn9vK+JhXcrVvhpJgiSRqGPfofyweRW6lVtbBqHol+OyI26OM
         4KIw==
X-Gm-Message-State: AC+VfDxObgr3besuWTgkqNWELBCShZ9YVB/wEXxRjKMQpycKIH72rmLN
        09dh86evz1VlEqW3kFZx7ZdMMkRtXqYelOwDiarTEqHt/nH/tlgDJxpy+WLgQAb+6nMNEEepccg
        9KboRb8Mszq8MHbOlttMRSUd1
X-Received: by 2002:a17:902:efcb:b0:1b5:11e:e48a with SMTP id ja11-20020a170902efcb00b001b5011ee48amr19497403plb.69.1687533855748;
        Fri, 23 Jun 2023 08:24:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RurcfAp7lRzkU6veda3yFfLKhnT+ZP/W2E7cRQ76Iy3mMxyblmZ4BOb9jbh0S7Ay8fzqw7w==
X-Received: by 2002:a17:902:efcb:b0:1b5:11e:e48a with SMTP id ja11-20020a170902efcb00b001b5011ee48amr19497390plb.69.1687533855411;
        Fri, 23 Jun 2023 08:24:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902779000b001b03cda6389sm7387865pll.10.2023.06.23.08.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 08:24:15 -0700 (PDT)
Message-ID: <d18a4ea5-4e8e-be69-84c3-ca658f5cfd24@redhat.com>
Date:   Fri, 23 Jun 2023 15:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH drm-next v5 03/14] drm: manager to keep track of GPUs VA
 mappings
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, bskeggs@redhat.com,
        Liam.Howlett@oracle.com, matthew.brost@intel.com,
        boris.brezillon@collabora.com, alexdeucher@gmail.com,
        ogabbay@kernel.org, bagasdotme@gmail.com, willy@infradead.org,
        jason@jlekstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Donald Robson <donald.robson@imgtec.com>,
        Dave Airlie <airlied@redhat.com>
References: <20230620004217.4700-1-dakr@redhat.com>
 <20230620004217.4700-4-dakr@redhat.com>
 <cf6846ea-5bd0-0b41-b7e6-901c70701751@amd.com>
 <a8edf75b-e0f7-a6c7-7d29-f0d39923549b@redhat.com>
 <41aecd10-9956-0752-2838-34c97834f0c8@amd.com>
 <bcde7ea3-fbab-3a18-e810-64b6589ddb18@redhat.com>
 <86ef9898-c4b6-f4c0-7ad3-3ffe5358365a@amd.com>
 <c1f05169-dec0-22ee-52fa-c8070678394e@redhat.com>
 <2f502150-c1f8-615c-66d9-c3fb59b8c409@redhat.com>
 <4a52ac7c-19ba-8906-5902-fbf75673bf59@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <4a52ac7c-19ba-8906-5902-fbf75673bf59@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/23 09:16, Christian König wrote:
> Am 22.06.23 um 17:07 schrieb Danilo Krummrich:
>> On 6/22/23 17:04, Danilo Krummrich wrote:
>>> On 6/22/23 16:42, Christian König wrote:
>>>> Am 22.06.23 um 16:22 schrieb Danilo Krummrich:
>>>>> On 6/22/23 15:54, Christian König wrote:
>>>>>> Am 20.06.23 um 14:23 schrieb Danilo Krummrich:
>>>>>>> Hi Christian,
>>>>>>>
>>>>>>> On 6/20/23 08:45, Christian König wrote:
>>>>>>>> Hi Danilo,
>>>>>>>>
>>>>>>>> sorry for the delayed reply. I've trying to dig myself out of a 
>>>>>>>> hole at the moment.
>>>>>>>
>>>>>>> No worries, thank you for taking a look anyway!
>>>>>>>
>>>>>>>>
>>>>>>>> Am 20.06.23 um 02:42 schrieb Danilo Krummrich:
>>>>>>>>> [SNIP]
>>>>>>>>> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
>>>>>>>>> index bbc721870c13..5ec8148a30ee 100644
>>>>>>>>> --- a/include/drm/drm_gem.h
>>>>>>>>> +++ b/include/drm/drm_gem.h
>>>>>>>>> @@ -36,6 +36,8 @@
>>>>>>>>>   #include <linux/kref.h>
>>>>>>>>>   #include <linux/dma-resv.h>
>>>>>>>>> +#include <linux/list.h>
>>>>>>>>> +#include <linux/mutex.h>
>>>>>>>>>   #include <drm/drm_vma_manager.h>
>>>>>>>>> @@ -379,6 +381,18 @@ struct drm_gem_object {
>>>>>>>>>        */
>>>>>>>>>       struct dma_resv _resv;
>>>>>>>>> +    /**
>>>>>>>>> +     * @gpuva:
>>>>>>>>> +     *
>>>>>>>>> +     * Provides the list of GPU VAs attached to this GEM object.
>>>>>>>>> +     *
>>>>>>>>> +     * Drivers should lock list accesses with the GEMs 
>>>>>>>>> &dma_resv lock
>>>>>>>>> +     * (&drm_gem_object.resv).
>>>>>>>>> +     */
>>>>>>>>> +    struct {
>>>>>>>>> +        struct list_head list;
>>>>>>>>> +    } gpuva;
>>>>>>>>> +
>>>>>>>>>       /**
>>>>>>>>>        * @funcs:
>>>>>>>>>        *
>>>>>>>>
>>>>>>>> I'm pretty sure that it's not a good idea to attach this 
>>>>>>>> directly to the GEM object.
>>>>>>>
>>>>>>> Why do you think so? IMHO having a common way to connect mappings 
>>>>>>> to their backing buffers is a good thing, since every driver 
>>>>>>> needs this connection anyway.
>>>>>>>
>>>>>>> E.g. when a BO gets evicted, drivers can just iterate the list of 
>>>>>>> mappings and, as the circumstances require, invalidate the 
>>>>>>> corresponding mappings or to unmap all existing mappings of a 
>>>>>>> given buffer.
>>>>>>>
>>>>>>> What would be the advantage to let every driver implement a 
>>>>>>> driver specific way of keeping this connection?
>>>>>>
>>>>>> Flexibility. For example on amdgpu the mappings of a BO are groups 
>>>>>> by VM address spaces.
>>>>>>
>>>>>> E.g. the BO points to multiple bo_vm structures which in turn have 
>>>>>> lists of their mappings.
>>>>>
>>>>> Isn't this (almost) the same relationship I introduce with the 
>>>>> GPUVA manager?
>>>>>
>>>>> If you would switch over to the GPUVA manager right now, it would 
>>>>> be that every GEM has a list of it's mappings (the gpuva list). The 
>>>>> mapping is represented by struct drm_gpuva (of course embedded in 
>>>>> driver specific structure(s)) which has a pointer to the VM address 
>>>>> space it is part of, namely the GPUVA manager instance. And the 
>>>>> GPUVA manager keeps a maple tree of it's mappings as well.
>>>>>
>>>>> If you still would like to *directly* (indirectly you already have 
>>>>> that relationship) keep a list of GPUVA managers (VM address 
>>>>> spaces) per GEM, you could still do that in a driver specific way.
>>>>>
>>>>> Do I miss something?
>>>>
>>>> How do you efficiently find only the mappings of a BO in one VM?
>>>
>>> Actually, I think this case should even be more efficient than with a 
>>> BO having a list of GPUVAs (or mappings):
>>
>> *than with a BO having a list of VMs:
>>
>>>
>>> Having a list of GPUVAs per GEM, each GPUVA has a pointer to it's VM. 
>>> Hence, you'd only need to iterate the list of mappings for a given BO 
>>> and check the mappings VM pointer.
> 
> Yeah, and that is extremely time consuming if you have tons of mappings 
> in different VMs.
> 
>>>
>>> Having a list of VMs per BO, you'd have to iterate the whole VM to 
>>> find the mappings having a pointer to the given BO, right?
> 
> No, you don't seem to understand what I'm suggesting.
> 
> Currently you have a list of mappings attached to the BO, so when you 
> need to make sure that a specific BO is up to date in a specific VM you 
> either need to iterate over the VM or the BO. Neither of that is a good 
> idea.
> 
> What you need is a representation of the data used for each BO+VM 
> combination. In other words another indirection which allows you to 
> handle all the mappings of a BO inside a VM at once.

Ok, after having a quick look at amdgpu, I can see what you mean.

The missing piece for me was that the BO+VM abstraction itself keeps a 
list of mappings for this specific BO and VM.

Just to make it obvious for other people following the discussion, let 
me quickly sketch up how this approach would look like for the GPUVA 
manager:

1. We would need a new structure to represent the BO+VM combination, 
something like:

	struct drm_gpuva_mgr_gem {
     		struct drm_gpuva_manager *mgr;
		struct drm_gem_object *obj;
		struct list_head gpuva_list;
	};

with a less horrible name, hopefully.

2. Create an instance of struct drm_gpuva_mgr_gem once a GEM becomes 
associated with a GPUVA manager (VM) and attach it to the GEMs, as by 
now, "gpuva" list.

In amdgpu, for example, this seems to be the case once a GEM object is 
opened, since there is one VM per file_priv.

However, for other drivers this could be different, hence drivers would 
need to take care about this.


3. Attach GPUVAs to the new gpuva_list of the corresponding instance of
struct drm_gpuva_mgr_gem.

4. Drivers would need to clean up the instance of struct 
drm_gpuva_mgr_gem, once the GEM is not associated with the GPUVA manager 
anymore.

As pointed out by Christian, this would optimize the "get all mappings 
backed by a specific BO from a given VM" use case.

The question for me is, do other drivers than amdgpu commonly need this?

And what does amdgpu need this for? Maybe amdgpu does something we're 
not doing (yet)?

Christian - I know you didn't ask for "do it the way amdgpu does", 
instead you voted for keeping it entirely driver specific. But I think 
everyone is pretty close and I'm still optimistic that we could just 
generalize this.

- Danilo

> 
>>>
>>> I'd think that a single VM potentially has more mapping entries than 
>>> a single BO was mapped in multiple VMs.
>>>
>>> Another case to consider is the case I originally had in mind 
>>> choosing this relationship: finding all mappings for a given BO, 
>>> which I guess all drivers need to do in order to invalidate mappings 
>>> on BO eviction.
>>>
>>> Having a list of VMs per BO, wouldn't you need to iterate all of the 
>>> VMs entirely?
> 
> No, see how amdgpu works.
> 
> Regards,
> Christian.
> 

