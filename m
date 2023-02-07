Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC25768D4D7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjBGKv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjBGKvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:51:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084963A588
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675767019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWccwJILvPfir6IoRku7EfqJmuwZVLGK2lUu+Ccdb5Y=;
        b=TYQ/kjZXyWyg2n/I2gj+nNPcXjw8Y1OKtGvHK3T9WpEFn6P2WCGlgOojKA43AfhvddUpxu
        TJhjm0CcL/4MgVu9OYFJVa7pL65d7dcj7N4gpIsqSLGKErdjtSPjmsZsBw9hwKa+WSih8i
        96zAHDI+6JLagKbYkEF42/6SdjH9DUw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-540-fqIz929pO2qo6rlpFgFHkA-1; Tue, 07 Feb 2023 05:50:18 -0500
X-MC-Unique: fqIz929pO2qo6rlpFgFHkA-1
Received: by mail-ej1-f70.google.com with SMTP id fy3-20020a1709069f0300b008a69400909fso3293008ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWccwJILvPfir6IoRku7EfqJmuwZVLGK2lUu+Ccdb5Y=;
        b=RxftWS+OypJV/dluERuXvFcWVBoTKndAPxHDNzqhCybvYD0TIK8Gigu2CRMmuqeeHP
         0T9r/ISpkPMOrcKIKusjSUTzNol8qMO9Yod691oao8GXu69qXKUOgxfWbS4U7MIU5xWY
         xl9BLxOjsnQo6dE55NCU2IMpu1Hy5cVR7Guc0bXmup8JR6ft1Gn5ou1Utu+KkO2O2P1n
         tZtCQvHprf8Bh2VbLHTCgrFC1H1Y2p6Nn3ystPeFuKKBzZK16WawYhpVSaHWcx38tId8
         /TSNJxnYNZsVaforXw7uYvaFAc+Kfmn2fo4FHXWHmF2HhFL1fQAqdi2zEKVRVfiuuyWV
         IHUQ==
X-Gm-Message-State: AO0yUKVxKvrNtRCU5+3gNuFCZD7pzm50KswYwPMjOWzM6dV/FDq5O3hd
        oXPxkZF9O6Lcy29gX38nvtjAkiB4A+RWP7EkTk4OzZegqqO8dS74RwhQVBDKfNHszyzY2iVbktF
        fDTjm2TLl4ep3MmzUwIRyuKsLe7QYRw==
X-Received: by 2002:a17:906:f253:b0:88f:8c13:52ba with SMTP id gy19-20020a170906f25300b0088f8c1352bamr3157345ejb.48.1675767016374;
        Tue, 07 Feb 2023 02:50:16 -0800 (PST)
X-Google-Smtp-Source: AK7set9oW8U930FGBTV8niNO+uHiUUmonlSEzr9xcfkIrG51boczPSjNCISgwtjiF9d6Q0UULEduHA==
X-Received: by 2002:a17:906:f253:b0:88f:8c13:52ba with SMTP id gy19-20020a170906f25300b0088f8c1352bamr3157328ejb.48.1675767016165;
        Tue, 07 Feb 2023 02:50:16 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id i12-20020a170906264c00b00878769f1e6bsm6694723ejc.55.2023.02.07.02.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:50:15 -0800 (PST)
Message-ID: <69e87e6a-7e6a-7b8d-c877-739be9cba0a1@redhat.com>
Date:   Tue, 7 Feb 2023 11:50:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Nouveau] [PATCH drm-next 05/14] drm/nouveau: new VM_BIND uapi
 interfaces
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@gmail.com>
Cc:     Matthew Brost <matthew.brost@intel.com>, daniel@ffwll.ch,
        corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mripard@kernel.org, bskeggs@redhat.com, jason@jlekstrand.net,
        nouveau@lists.freedesktop.org, airlied@redhat.com
References: <20230118061256.2689-1-dakr@redhat.com>
 <20230118061256.2689-6-dakr@redhat.com>
 <Y9MjSeMcsd18r9vM@DUT025-TGLU.fm.intel.com>
 <7c046ff9-728d-7634-9d77-8536308c7481@redhat.com>
 <c2256c7d-e768-ae3f-d465-b9f8080d111b@amd.com>
 <2427a918-5348-d1ef-ccae-a29c1ff33c83@redhat.com>
 <a214b28b-043c-a8bb-69da-b4d8216fce56@amd.com>
 <3a76bfa9-8ee5-a7d9-b9fb-a98181baec0b@redhat.com>
 <49ac3f95-6eda-9009-4b28-0167213301b2@amd.com>
 <bc523c5c-efe6-1a7f-b49a-e0867dc1413d@redhat.com>
 <15fb0179-c7c5-8a64-ed08-841189919f5e@redhat.com>
 <1840e9fb-fd1b-79b7-4238-54ae97333d0b@amd.com>
 <CAPM=9txON8VCb3H7vDY_DOgtUg2Ad3mBvYVxgSMyZ1noOu-rBQ@mail.gmail.com>
 <a1c526e0-0df7-12cb-c5a1-06e9cd0d876b@amd.com>
 <3f935a7e-fede-2bad-c029-4a3af850c9b5@redhat.com>
 <95d0631b-545c-ea4d-7439-75422e9a9120@amd.com>
 <67958920-c5bb-a0f5-2306-e3ae4fdbaeb3@redhat.com>
 <c0635ff3-027f-bcd7-afbc-46f4e62d3651@amd.com>
 <4439c44b-cbd0-7160-da3d-e78f6aeeec77@redhat.com>
 <85548cd2-1bea-3c04-40b9-9abb03cb57b3@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <85548cd2-1bea-3c04-40b9-9abb03cb57b3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/23 10:35, Christian König wrote:
> Am 06.02.23 um 19:20 schrieb Danilo Krummrich:
>> On 2/6/23 17:14, Christian König wrote:
>>> Concentrating this discussion on a very big misunderstanding first.
>>>
>>> Am 06.02.23 um 14:27 schrieb Danilo Krummrich:
>>>> [SNIP]
>>>> My understanding is that userspace is fully responsible on the parts 
>>>> of the GPU VA space it owns. This means that userspace needs to take 
>>>> care to *not* ask the kernel to modify mappings that are in use 
>>>> currently.
>>>
>>> This is a completely wrong assumption! Take a look at what games like 
>>> Forza Horizzon are doing.
>>>
>>> Basically that game allocates a very big sparse area and fills it 
>>> with pages from BOs while shaders are accessing it. And yes, as far 
>>> as I know this is completely valid behavior.
>>
>> I also think this is valid behavior. That's not the problem I'm trying 
>> to describe. In this case userspace modifies the VA space 
>> *intentionally* while shaders are accessing it, because it knows that 
>> the shaders can deal with reading 0s.
> 
> No, it's perfectly valid for userspace to modify the VA space even if 
> shaders are not supposed to deal with reading 0s.
> 
>>
>>
>> Just to have it all in place, the example I gave was:
>>  - two virtually contiguous buffers A and B
>>  - binding 1 mapped to A with BO offset 0
>>  - binding 2 mapped to B with BO offset length(A)
>>
>> What I did not mention both A and B aren't sparse buffers in this 
>> example, although it probably doesn't matter too much.
>>
>> Since the conditions to do so are given, we merge binding 1 and 
>> binding 2 right at the time when binding 2 is requested. To do so a 
>> driver might unmap binding 1 for a very short period of time (e.g. to 
>> (re-)map the freshly merged binding with a different page size if 
>> possible).
> 
> Nope, that's not correct handling.

I agree, and that's exactly what I'm trying to say. However, I start 
noticing that this is not correct if it happens within the same buffer 
as well.

> 
>>
>> From userspace perspective buffer A is ready to use before applying 
>> binding 2 to buffer B, hence it would be illegal to touch binding 1 
>> again when userspace asks the kernel to map binding 2 to buffer B.
>>
>> Besides that I think there is no point in merging between buffers 
>> anyway because we'd end up splitting such a merged mapping anyway 
>> later on when one of the two buffers is destroyed.
>>
>> Also, I think the same applies to sparse buffers as well, a mapping 
>> within A isn't expected to be re-mapped just because something is 
>> mapped to B.
>>
>> However, in this context I start wondering if re-mapping in the 
>> context of merge and split is allowed at all, even within the same 
>> sparse buffer (and even with a separate page table for sparse mappings 
>> as described in my last mail; shaders would never fault).
> 
> See, your assumption is that userspace/applications don't modify the VA 
> space intentionally while the GPU is accessing it is just bluntly 
> speaking incorrect.
> 

I don't assume that. The opposite is the case. My assumption is that 
it's always OK for userspace to intentionally modify the VA space.

However, I also assumed that if userspace asks for e.g. a new mapping 
within a certain buffer it is OK for the kernel to apply further changes 
(e.g. re-organize PTs to split or merge) to the VA space of which 
userspace isn't aware of. At least as long as they happen within the 
bounds of this particular buffer, but not for other buffers.

I think the reasoning I had in mind was that I thought if userspace asks 
for any modification of a given portion of the VA space (that is a 
VKBuffer) userspace must assume that until this modification (e.g. 
re-organization of PTs) is complete reading 0s intermediately may 
happen. This seems to be clearly wrong.

> When you have a VA address which is mapped to buffer A and accessed by 
> some GPU shaders it is perfectly valid for the application to say "map 
> it again to the same buffer A".
> 
> It is also perfectly valid for an application to re-map this region to a 
> different buffer B, it's just not defined when the access then transits 
> from A to B. (AFAIK this is currently worked on in a new specification).
> 
> So when your page table updates result in the shader to intermediately 
> get 0s in return, because you change the underlying mapping you simply 
> have some implementation bug in Nouveau.

Luckily that's not the case (anymore).

> 
> I don't know how Nvidia hw handles this, and yes it's quite complicated 
> on AMD hw as well because our TLBs are not really made for this use 
> case, but I'm 100% sure that this is possible since it is still part of 
> some of the specifications (mostly Vulkan I think).
> 
> To sum it up as far as I can see by giving the regions to the kernel is 
> not something you would want for Nouveau either.

If, as it turns out, it's also not allowed to do what I described above 
within the same VKBuffer, I agree the bounds aren't needed for merging.

However, I still don't see why we would want to merge over buffer 
boundaries, because ultimately we'll end up splitting such a merged 
mapping later on anyway once one of the buffers is destroyed.

Also, as explained in one of the previous mails in nouveau we can have 
separate PTs for sparse mappings with large page sizes and separate PTs 
for memory backed mappings with smaller page sizes overlaying them. 
Hence, I need to track a single sparse mapping per buffer spanning the 
whole buffer (which I do with a region) and the actual memory backed 
mappings within the same range.

Now, this might or might not be unique for Nvidia hardware. If nouveau 
would be the only potential user, plus we don't care about potentially 
merging mappings over buffer boundaries and hence producing foreseeable 
splits of those merged mappings, we could get rid of regions entirely.

> 
> Regards,
> Christian.
> 
> 
>>
>>>
>>> So you need to be able to handle this case anyway and the approach 
>>> with the regions won't help you at all preventing that.
>>>
>>> Regards,
>>> Christian.
>>>
>>
> 

