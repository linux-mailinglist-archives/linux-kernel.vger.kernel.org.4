Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736E273A44E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjFVPHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjFVPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3220426A8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687446354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALwAb4xXprAB+9F/dS+KPiS3Lq1AVB4XEyImG9brJGs=;
        b=dBhwPPJToWpnvVcUYNFPdvCGkGaqor0N+ZrEBA9bJNXNaBqfyDjC5k/GyVUUXqx11zxUl8
        /f/Cw9Qe0XgQBWbAHPi0q6v0rl0plfVbqJGLJiyTZhDdGBKNh2Si2wbhffxwNjpIbOD2DO
        zH3fyrb+PHrhIWzrqwVZEA1nZrUdtxg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-twxjRCbRPPm4vRTKFK298A-1; Thu, 22 Jun 2023 11:05:25 -0400
X-MC-Unique: twxjRCbRPPm4vRTKFK298A-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-25eb77bcd2fso3078153a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687446306; x=1690038306;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALwAb4xXprAB+9F/dS+KPiS3Lq1AVB4XEyImG9brJGs=;
        b=YanwTHuTYvQHA0dYeYIoQVB/iOrhO4UnfHC6VuunWTGHfwesE/HafPntTSyn7JdHjv
         ea1QjpcLqfARALQhubLPk15kRf9Aipfsp2hgfykyA7B4/pf1QYtrWLf7XaYArXB5ReLU
         i53FCnJ94E4PrjOU9ntdkBJRG0LxHdEepfbbOiwi7J2TSOGJYHZu0WUtXNFMZdeBo7Oh
         Puki+fmu073Fhhz9FhSOnuEdQhRYNE2qvNQBRDrlhlLyMyk0GorLwb/rBt9acf8uP34l
         sgv5GmwNl04ZsDwpEEUOBjbBAPunv6cIWSTgilh3XHMfwQu4iUoNGMcLwylof0VzvxeM
         yMbQ==
X-Gm-Message-State: AC+VfDx2yDY0ny2Bxzxek4vShfEriBJMtDInCGFyVOca5f39f8NaCaBH
        XEBdAAnVE+8FgwJkD2quEE0xW0lhgIJq1X5CLdtbGq3v80w2hDSYal971hudFepYMxgmfaOQHaG
        ILRZYlhrK/pxCcEXMTxCXBbaX
X-Received: by 2002:a17:90a:598b:b0:25e:21fd:d0ee with SMTP id l11-20020a17090a598b00b0025e21fdd0eemr12382061pji.4.1687446305553;
        Thu, 22 Jun 2023 08:05:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6VAF41Yl6PWm1TlVPyMZOWckognMLULfXo3Puhxxwa0Hm6Wvk9Q83FUo/5ecv5BWxRadodTQ==
X-Received: by 2002:a17:90a:598b:b0:25e:21fd:d0ee with SMTP id l11-20020a17090a598b00b0025e21fdd0eemr12382031pji.4.1687446305092;
        Thu, 22 Jun 2023 08:05:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de9c:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de9c:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id gz10-20020a17090b0eca00b00256b67208b1sm10867488pjb.56.2023.06.22.08.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 08:05:04 -0700 (PDT)
Message-ID: <c1f05169-dec0-22ee-52fa-c8070678394e@redhat.com>
Date:   Thu, 22 Jun 2023 17:04:52 +0200
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
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <86ef9898-c4b6-f4c0-7ad3-3ffe5358365a@amd.com>
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

On 6/22/23 16:42, Christian König wrote:
> Am 22.06.23 um 16:22 schrieb Danilo Krummrich:
>> On 6/22/23 15:54, Christian König wrote:
>>> Am 20.06.23 um 14:23 schrieb Danilo Krummrich:
>>>> Hi Christian,
>>>>
>>>> On 6/20/23 08:45, Christian König wrote:
>>>>> Hi Danilo,
>>>>>
>>>>> sorry for the delayed reply. I've trying to dig myself out of a 
>>>>> hole at the moment.
>>>>
>>>> No worries, thank you for taking a look anyway!
>>>>
>>>>>
>>>>> Am 20.06.23 um 02:42 schrieb Danilo Krummrich:
>>>>>> [SNIP]
>>>>>> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
>>>>>> index bbc721870c13..5ec8148a30ee 100644
>>>>>> --- a/include/drm/drm_gem.h
>>>>>> +++ b/include/drm/drm_gem.h
>>>>>> @@ -36,6 +36,8 @@
>>>>>>   #include <linux/kref.h>
>>>>>>   #include <linux/dma-resv.h>
>>>>>> +#include <linux/list.h>
>>>>>> +#include <linux/mutex.h>
>>>>>>   #include <drm/drm_vma_manager.h>
>>>>>> @@ -379,6 +381,18 @@ struct drm_gem_object {
>>>>>>        */
>>>>>>       struct dma_resv _resv;
>>>>>> +    /**
>>>>>> +     * @gpuva:
>>>>>> +     *
>>>>>> +     * Provides the list of GPU VAs attached to this GEM object.
>>>>>> +     *
>>>>>> +     * Drivers should lock list accesses with the GEMs &dma_resv 
>>>>>> lock
>>>>>> +     * (&drm_gem_object.resv).
>>>>>> +     */
>>>>>> +    struct {
>>>>>> +        struct list_head list;
>>>>>> +    } gpuva;
>>>>>> +
>>>>>>       /**
>>>>>>        * @funcs:
>>>>>>        *
>>>>>
>>>>> I'm pretty sure that it's not a good idea to attach this directly 
>>>>> to the GEM object.
>>>>
>>>> Why do you think so? IMHO having a common way to connect mappings to 
>>>> their backing buffers is a good thing, since every driver needs this 
>>>> connection anyway.
>>>>
>>>> E.g. when a BO gets evicted, drivers can just iterate the list of 
>>>> mappings and, as the circumstances require, invalidate the 
>>>> corresponding mappings or to unmap all existing mappings of a given 
>>>> buffer.
>>>>
>>>> What would be the advantage to let every driver implement a driver 
>>>> specific way of keeping this connection?
>>>
>>> Flexibility. For example on amdgpu the mappings of a BO are groups by 
>>> VM address spaces.
>>>
>>> E.g. the BO points to multiple bo_vm structures which in turn have 
>>> lists of their mappings.
>>
>> Isn't this (almost) the same relationship I introduce with the GPUVA 
>> manager?
>>
>> If you would switch over to the GPUVA manager right now, it would be 
>> that every GEM has a list of it's mappings (the gpuva list). The 
>> mapping is represented by struct drm_gpuva (of course embedded in 
>> driver specific structure(s)) which has a pointer to the VM address 
>> space it is part of, namely the GPUVA manager instance. And the GPUVA 
>> manager keeps a maple tree of it's mappings as well.
>>
>> If you still would like to *directly* (indirectly you already have 
>> that relationship) keep a list of GPUVA managers (VM address spaces) 
>> per GEM, you could still do that in a driver specific way.
>>
>> Do I miss something?
> 
> How do you efficiently find only the mappings of a BO in one VM?

Actually, I think this case should even be more efficient than with a BO 
having a list of GPUVAs (or mappings):

Having a list of GPUVAs per GEM, each GPUVA has a pointer to it's VM. 
Hence, you'd only need to iterate the list of mappings for a given BO 
and check the mappings VM pointer.

Having a list of VMs per BO, you'd have to iterate the whole VM to find 
the mappings having a pointer to the given BO, right?

I'd think that a single VM potentially has more mapping entries than a 
single BO was mapped in multiple VMs.

Another case to consider is the case I originally had in mind choosing 
this relationship: finding all mappings for a given BO, which I guess 
all drivers need to do in order to invalidate mappings on BO eviction.

Having a list of VMs per BO, wouldn't you need to iterate all of the VMs 
entirely?

> 
> Keep in mind that we have cases where one BO is shared with hundreds of 
> different VMs as well as potentially the number of mappings can be >10k.
> 
>>
>>>
>>> Additional to that there is a state maschine associated with the 
>>> mappings, e.g. if the page tables are up to date or need to be 
>>> updated etc....
>>>
>>>> Do you see cases where this kind of connection between mappings and 
>>>> backing buffers wouldn't be good enough? If so, which cases do you 
>>>> have in mind? Maybe we can cover them in a common way as well?
>>>
>>> Yeah, we have tons of cases like that. But I have no idea how to 
>>> generalize them.
>>
>> They could still remain to be driver specific then, right?
> 
> Well does the mapping has a back pointer to the BO? And can that be 
> optional NULL if there is no BO?

Yes to both.

- Danilo

> 
> Regards,
> Christian.
> 
>>
>>>
>>>>
>>>>>
>>>>> As you wrote in the commit message it's highly driver specific what 
>>>>> to map and where to map it.
>>>>
>>>> In the end the common case should be that in a VA space at least 
>>>> every mapping being backed by a BO is represented by a struct 
>>>> drm_gpuva.
>>>
>>> Oh, no! We also have mappings not backed by a BO at all! For example 
>>> for partial resident textures or data routing to internal hw etc...
>>>
>>> You can't be sure that a mapping is backed by a BO at all.
>>
>> I fully agree, that's why I wrote "the common case should be that in a 
>> VA space at least every mapping *being backed by a BO* is represented 
>> by a struct drm_gpuva".
>>
>> Mappings not being backed by an actual BO would not be linked to a GEM 
>> of course.
>>
>>>
>>>>
>>>>>
>>>>> Instead I suggest to have a separate structure for mappings in a VA 
>>>>> space which driver can then add to their GEM objects or whatever 
>>>>> they want to map into their VMs.
>>>>
>>>> Which kind of separate structure for mappings? Another one analogous 
>>>> to struct drm_gpuva?
>>>
>>> Well similar to what amdgpu uses BO -> one structure for each 
>>> combination of BO and VM -> mappings inside that VM
>>
>> As explained above, I think that's exactly what the GPUVA manager 
>> does, just in another order:
>>
>> BO has list of mappings, mappings have pointer to VM, VM has list (or 
>> actually a maple tree) of mappings.
>>
>> You see any advantages or disadvantages of either order of 
>> relationships? For me it looks like it doesn't really matter which one 
>> to pick.
>>
>> - Danilo
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> - Danilo
>>>>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>
>>>>
>>>
>>
> 

