Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B7173A459
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjFVPIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjFVPIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C24510C1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687446458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jx6WC1mHABJsvuM+bnp+yD3GpYJCZcdfj8MNht3/Ius=;
        b=eqBj/V04wMBBlreYMap80uLufI5NhvU9o+EqvPFw7kxYaO8poOfDRc1E5DSuekApBbJkW9
        5Ucb8sPAjtPqSuHgT+yqhpPZ/YH0AkDQ8xzWFcKwybCSo7uOkSX4SJD2YdOPYpZLv67wSD
        6BkLQxrXvTWCs7nf1zsrYdBT2esqpJw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-Gk9BP8esNQiAV1nckcS8Fg-1; Thu, 22 Jun 2023 11:07:26 -0400
X-MC-Unique: Gk9BP8esNQiAV1nckcS8Fg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-66663453f65so3575990b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687446445; x=1690038445;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jx6WC1mHABJsvuM+bnp+yD3GpYJCZcdfj8MNht3/Ius=;
        b=PWXbReEgNu8XF2bA5sHUoNqvFgPS4x4kOnZoyKnOnofGc/ClBhojYjAuBMFoidanLU
         OQNGDGzPiX0zCXjs/sfX4FGa38V4j9FbcLHzncU37w+98U4LjDcMl/0fvNgWgwGJynFK
         4s+bgVwbVOccDzj1xIcJF8smhEhjdznGtLM2dhiext+n0AjjCV46OoRTEoOwfnmfyoei
         ik09qXd2uAQMg+9iF73THfTU6DG7rBxI04X7MJCIcikJVsSHjSKNu8yg7GVVGlx3Bct7
         xbDUt5LptHLei1DzH06LvFSbE9tuJ85vjepW88xo2NXIRcpCaSMT4Hq3t5VMNBNK4vRA
         3xEQ==
X-Gm-Message-State: AC+VfDyq6p5xoE18jkqFmSzWCInrt2HkIWVa3pe/rbq4KjzlnrGmNPmp
        SR+XcFoXktuOvC2m6C7qnOZKj3lJ6+It7SC4pDqdUuFfxS3p2ZEnu7lZQ50DCtDh0Pka7Gz9H3G
        gwJiQq3pdv9YeAzSYcxt/rShg
X-Received: by 2002:a05:6a00:809:b0:66a:2ff1:dee4 with SMTP id m9-20020a056a00080900b0066a2ff1dee4mr6496418pfk.2.1687446445071;
        Thu, 22 Jun 2023 08:07:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6HRa0GCUXkWBtzHtdiP3Pquuzaz9AEf4d8mo5rrQwuiJDyyK0Sq1psu59IAgHb74bq4hLcmA==
X-Received: by 2002:a05:6a00:809:b0:66a:2ff1:dee4 with SMTP id m9-20020a056a00080900b0066a2ff1dee4mr6496388pfk.2.1687446444684;
        Thu, 22 Jun 2023 08:07:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id o2-20020a63e342000000b0053fb37fb626sm5011644pgj.43.2023.06.22.08.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 08:07:24 -0700 (PDT)
Message-ID: <2f502150-c1f8-615c-66d9-c3fb59b8c409@redhat.com>
Date:   Thu, 22 Jun 2023 17:07:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH drm-next v5 03/14] drm: manager to keep track of GPUs VA
 mappings
Content-Language: en-US
From:   Danilo Krummrich <dakr@redhat.com>
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
Organization: RedHat
In-Reply-To: <c1f05169-dec0-22ee-52fa-c8070678394e@redhat.com>
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

On 6/22/23 17:04, Danilo Krummrich wrote:
> On 6/22/23 16:42, Christian König wrote:
>> Am 22.06.23 um 16:22 schrieb Danilo Krummrich:
>>> On 6/22/23 15:54, Christian König wrote:
>>>> Am 20.06.23 um 14:23 schrieb Danilo Krummrich:
>>>>> Hi Christian,
>>>>>
>>>>> On 6/20/23 08:45, Christian König wrote:
>>>>>> Hi Danilo,
>>>>>>
>>>>>> sorry for the delayed reply. I've trying to dig myself out of a 
>>>>>> hole at the moment.
>>>>>
>>>>> No worries, thank you for taking a look anyway!
>>>>>
>>>>>>
>>>>>> Am 20.06.23 um 02:42 schrieb Danilo Krummrich:
>>>>>>> [SNIP]
>>>>>>> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
>>>>>>> index bbc721870c13..5ec8148a30ee 100644
>>>>>>> --- a/include/drm/drm_gem.h
>>>>>>> +++ b/include/drm/drm_gem.h
>>>>>>> @@ -36,6 +36,8 @@
>>>>>>>   #include <linux/kref.h>
>>>>>>>   #include <linux/dma-resv.h>
>>>>>>> +#include <linux/list.h>
>>>>>>> +#include <linux/mutex.h>
>>>>>>>   #include <drm/drm_vma_manager.h>
>>>>>>> @@ -379,6 +381,18 @@ struct drm_gem_object {
>>>>>>>        */
>>>>>>>       struct dma_resv _resv;
>>>>>>> +    /**
>>>>>>> +     * @gpuva:
>>>>>>> +     *
>>>>>>> +     * Provides the list of GPU VAs attached to this GEM object.
>>>>>>> +     *
>>>>>>> +     * Drivers should lock list accesses with the GEMs &dma_resv 
>>>>>>> lock
>>>>>>> +     * (&drm_gem_object.resv).
>>>>>>> +     */
>>>>>>> +    struct {
>>>>>>> +        struct list_head list;
>>>>>>> +    } gpuva;
>>>>>>> +
>>>>>>>       /**
>>>>>>>        * @funcs:
>>>>>>>        *
>>>>>>
>>>>>> I'm pretty sure that it's not a good idea to attach this directly 
>>>>>> to the GEM object.
>>>>>
>>>>> Why do you think so? IMHO having a common way to connect mappings 
>>>>> to their backing buffers is a good thing, since every driver needs 
>>>>> this connection anyway.
>>>>>
>>>>> E.g. when a BO gets evicted, drivers can just iterate the list of 
>>>>> mappings and, as the circumstances require, invalidate the 
>>>>> corresponding mappings or to unmap all existing mappings of a given 
>>>>> buffer.
>>>>>
>>>>> What would be the advantage to let every driver implement a driver 
>>>>> specific way of keeping this connection?
>>>>
>>>> Flexibility. For example on amdgpu the mappings of a BO are groups 
>>>> by VM address spaces.
>>>>
>>>> E.g. the BO points to multiple bo_vm structures which in turn have 
>>>> lists of their mappings.
>>>
>>> Isn't this (almost) the same relationship I introduce with the GPUVA 
>>> manager?
>>>
>>> If you would switch over to the GPUVA manager right now, it would be 
>>> that every GEM has a list of it's mappings (the gpuva list). The 
>>> mapping is represented by struct drm_gpuva (of course embedded in 
>>> driver specific structure(s)) which has a pointer to the VM address 
>>> space it is part of, namely the GPUVA manager instance. And the GPUVA 
>>> manager keeps a maple tree of it's mappings as well.
>>>
>>> If you still would like to *directly* (indirectly you already have 
>>> that relationship) keep a list of GPUVA managers (VM address spaces) 
>>> per GEM, you could still do that in a driver specific way.
>>>
>>> Do I miss something?
>>
>> How do you efficiently find only the mappings of a BO in one VM?
> 
> Actually, I think this case should even be more efficient than with a BO 
> having a list of GPUVAs (or mappings):

*than with a BO having a list of VMs:

> 
> Having a list of GPUVAs per GEM, each GPUVA has a pointer to it's VM. 
> Hence, you'd only need to iterate the list of mappings for a given BO 
> and check the mappings VM pointer.
> 
> Having a list of VMs per BO, you'd have to iterate the whole VM to find 
> the mappings having a pointer to the given BO, right?
> 
> I'd think that a single VM potentially has more mapping entries than a 
> single BO was mapped in multiple VMs.
> 
> Another case to consider is the case I originally had in mind choosing 
> this relationship: finding all mappings for a given BO, which I guess 
> all drivers need to do in order to invalidate mappings on BO eviction.
> 
> Having a list of VMs per BO, wouldn't you need to iterate all of the VMs 
> entirely?
> 
>>
>> Keep in mind that we have cases where one BO is shared with hundreds 
>> of different VMs as well as potentially the number of mappings can be 
>> >10k.
>>
>>>
>>>>
>>>> Additional to that there is a state maschine associated with the 
>>>> mappings, e.g. if the page tables are up to date or need to be 
>>>> updated etc....
>>>>
>>>>> Do you see cases where this kind of connection between mappings and 
>>>>> backing buffers wouldn't be good enough? If so, which cases do you 
>>>>> have in mind? Maybe we can cover them in a common way as well?
>>>>
>>>> Yeah, we have tons of cases like that. But I have no idea how to 
>>>> generalize them.
>>>
>>> They could still remain to be driver specific then, right?
>>
>> Well does the mapping has a back pointer to the BO? And can that be 
>> optional NULL if there is no BO?
> 
> Yes to both.
> 
> - Danilo
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>> As you wrote in the commit message it's highly driver specific 
>>>>>> what to map and where to map it.
>>>>>
>>>>> In the end the common case should be that in a VA space at least 
>>>>> every mapping being backed by a BO is represented by a struct 
>>>>> drm_gpuva.
>>>>
>>>> Oh, no! We also have mappings not backed by a BO at all! For example 
>>>> for partial resident textures or data routing to internal hw etc...
>>>>
>>>> You can't be sure that a mapping is backed by a BO at all.
>>>
>>> I fully agree, that's why I wrote "the common case should be that in 
>>> a VA space at least every mapping *being backed by a BO* is 
>>> represented by a struct drm_gpuva".
>>>
>>> Mappings not being backed by an actual BO would not be linked to a 
>>> GEM of course.
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Instead I suggest to have a separate structure for mappings in a 
>>>>>> VA space which driver can then add to their GEM objects or 
>>>>>> whatever they want to map into their VMs.
>>>>>
>>>>> Which kind of separate structure for mappings? Another one 
>>>>> analogous to struct drm_gpuva?
>>>>
>>>> Well similar to what amdgpu uses BO -> one structure for each 
>>>> combination of BO and VM -> mappings inside that VM
>>>
>>> As explained above, I think that's exactly what the GPUVA manager 
>>> does, just in another order:
>>>
>>> BO has list of mappings, mappings have pointer to VM, VM has list (or 
>>> actually a maple tree) of mappings.
>>>
>>> You see any advantages or disadvantages of either order of 
>>> relationships? For me it looks like it doesn't really matter which 
>>> one to pick.
>>>
>>> - Danilo
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> - Danilo
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>

