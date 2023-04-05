Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0CB6D8521
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjDERpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjDERpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B451AC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680716652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Tmbj2zjH5DGfDTzgZDLkPOw/999Aeev0sYQlfvmLvY=;
        b=e2kwRMPEyvGx68+g9Yjpr6YxbERU0gaICIFVqB+ftoUtkV9dJHSTtEAU45e44Jn7XbN5YC
        mUa7xGiwR2zVVzMI1PLeoIUzhSMdRtaF7TEDcD6+KBjmT3rI+MbS818ayu6boCyOi4zu6+
        89GNoj2PXB3UL4xqZ6fSVUszg+TAgBw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-F0YygHF5PqStJvEGz9Xg2A-1; Wed, 05 Apr 2023 13:44:09 -0400
X-MC-Unique: F0YygHF5PqStJvEGz9Xg2A-1
Received: by mail-pg1-f198.google.com with SMTP id b1-20020a63d301000000b0050726979a86so10773288pgg.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 10:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680716648;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Tmbj2zjH5DGfDTzgZDLkPOw/999Aeev0sYQlfvmLvY=;
        b=AvHg5IW7Sp+xwSlvSOEVHAL9iSQXlJ6bF7neSb6f7lCLwQyERv83DAYVHqO+D6qHSg
         ckvGYyyfrXYV5ITnHlgqlp6OD3wzAR/iy5RERhFjAOugtpKG/RE3v6qdu/HI1CiNL1ub
         P7rA6rKbhXQw7UjOMvDkkvtdsTxw61DjEdQ1R/I2lkue6DqcCx9wJd4IH05kRwgkkFrc
         tCGMh4LhbSHP50153xi5gPcSUDFZfF4qt/qrKtF4xa7M8V0iS4zkd4BjwvbkQgOTtOTY
         oHMIpWDU0ra0ib0ts6QBHghM6zU4GrA0vBFdL/gZuUNizohX9pIEG65j/2nhbrWytcNF
         S7Zw==
X-Gm-Message-State: AAQBX9dlHFd8UyvId8/QbHdKkJm1Z0S4VaH1QoA0Dw2QdYWZD3h1URuX
        vMVziBzUX4AW7yKjo+AI2kk5BSPBRKyzhPqFymPNzT6Pc7KrZuUa2I7s5YjEnuNlrxK5ZM+0EB4
        d9CW2GT6zBHD5Gqns3w7Cj5+L
X-Received: by 2002:a05:6a20:3aaa:b0:e7:76ba:d74d with SMTP id d42-20020a056a203aaa00b000e776bad74dmr81082pzh.7.1680716648583;
        Wed, 05 Apr 2023 10:44:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZAEr/SmwCymSl6GmdlbqDhvC2ulGWLBiZ9iFKjzXy+wWnw2xl2OEqAk11poK00hiIsgT+jfA==
X-Received: by 2002:a05:6a20:3aaa:b0:e7:76ba:d74d with SMTP id d42-20020a056a203aaa00b000e776bad74dmr81063pzh.7.1680716648225;
        Wed, 05 Apr 2023 10:44:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id g9-20020a62e309000000b006280676b8b4sm10858042pfh.220.2023.04.05.10.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 10:44:07 -0700 (PDT)
Message-ID: <0e14b98d-6b1a-97f0-e6d1-b63ca120d59f@redhat.com>
Date:   Wed, 5 Apr 2023 18:23:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Regression] drm/scheduler: track GPU active time per entity
Content-Language: en-US
To:     Luben Tuikov <luben.tuikov@amd.com>,
        Lucas Stach <l.stach@pengutronix.de>, daniel@ffwll.ch,
        Dave Airlie <airlied@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        andrey.grodzovsky@amd.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        tvrtko.ursulin@linux.intel.com,
        Matthew Brost <matthew.brost@intel.com>, yuq825@gmail.com,
        Boris Brezillon <boris.brezillon@collabora.com>,
        lina@asahilina.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <3e00d8a9-b6c4-8202-4f2d-5a659c61d094@redhat.com>
 <2a84875dde6565842aa07ddb96245b7d939cb4fd.camel@pengutronix.de>
 <8b28151c-f2db-af3f-8dff-87dd5d57417b@amd.com>
 <3004a2bf-e725-643e-82af-8a217784e796@redhat.com>
 <013781a3-5abd-8c66-8a0a-dd36c9c487af@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <013781a3-5abd-8c66-8a0a-dd36c9c487af@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 18:09, Luben Tuikov wrote:
> On 2023-04-05 10:05, Danilo Krummrich wrote:
>> On 4/4/23 06:31, Luben Tuikov wrote:
>>> On 2023-03-28 04:54, Lucas Stach wrote:
>>>> Hi Danilo,
>>>>
>>>> Am Dienstag, dem 28.03.2023 um 02:57 +0200 schrieb Danilo Krummrich:
>>>>> Hi all,
>>>>>
>>>>> Commit df622729ddbf ("drm/scheduler: track GPU active time per entity")
>>>>> tries to track the accumulated time that a job was active on the GPU
>>>>> writing it to the entity through which the job was deployed to the
>>>>> scheduler originally. This is done within drm_sched_get_cleanup_job()
>>>>> which fetches a job from the schedulers pending_list.
>>>>>
>>>>> Doing this can result in a race condition where the entity is already
>>>>> freed, but the entity's newly added elapsed_ns field is still accessed
>>>>> once the job is fetched from the pending_list.
>>>>>
>>>>> After drm_sched_entity_destroy() being called it should be safe to free
>>>>> the structure that embeds the entity. However, a job originally handed
>>>>> over to the scheduler by this entity might still reside in the
>>>>> schedulers pending_list for cleanup after drm_sched_entity_destroy()
>>>>> already being called and the entity being freed. Hence, we can run into
>>>>> a UAF.
>>>>>
>>>> Sorry about that, I clearly didn't properly consider this case.
>>>>
>>>>> In my case it happened that a job, as explained above, was just picked
>>>>> from the schedulers pending_list after the entity was freed due to the
>>>>> client application exiting. Meanwhile this freed up memory was already
>>>>> allocated for a subsequent client applications job structure again.
>>>>> Hence, the new jobs memory got corrupted. Luckily, I was able to
>>>>> reproduce the same corruption over and over again by just using
>>>>> deqp-runner to run a specific set of VK test cases in parallel.
>>>>>
>>>>> Fixing this issue doesn't seem to be very straightforward though (unless
>>>>> I miss something), which is why I'm writing this mail instead of sending
>>>>> a fix directly.
>>>>>
>>>>> Spontaneously, I see three options to fix it:
>>>>>
>>>>> 1. Rather than embedding the entity into driver specific structures
>>>>> (e.g. tied to file_priv) we could allocate the entity separately and
>>>>> reference count it, such that it's only freed up once all jobs that were
>>>>> deployed through this entity are fetched from the schedulers pending list.
>>>>>
>>>> My vote is on this or something in similar vain for the long term. I
>>>> have some hope to be able to add a GPU scheduling algorithm with a bit
>>>> more fairness than the current one sometime in the future, which
>>>> requires execution time tracking on the entities.
>>>
>>> Danilo,
>>>
>>> Using kref is preferable, i.e. option 1 above.
>>
>> I think the only real motivation for doing that would be for generically
>> tracking job statistics within the entity a job was deployed through. If
>> we all agree on tracking job statistics this way I am happy to prepare a
>> patch for this option and drop this one:
>> https://lore.kernel.org/all/20230331000622.4156-1-dakr@redhat.com/T/#u
> 
> Hmm, I never thought about "job statistics" when I preferred using kref above.
> The reason kref is attractive is because one doesn't need to worry about
> it--when the last user drops the kref, the release is called to do
> housekeeping. If this never happens, we know that we have a bug to debug.
> 

I tied it to the use case of (accumulated) job statistics since I think 
using kref might only make sense if we have a reason why a job needs to 
access the entity it was deployed through. And the only real reason to 
keep this connection seems to be (accumulated) job statistics.

If it is only about allowing drivers to derive a driver specific entity 
structure from a job I think it might depend on whether this is a 
"typical application" nearly every driver does (which it seems not to 
be) or if it is an exception.

In the latter case the driver could still store the corresponding 
pointers in its driver specific structures and take care of not freeing 
the structure the entity is embedded in until it is safe to do so.

Since it was already tried twice to generically get (accumulated) job 
statistics into entities personally I think doing so plus using kref 
would be quite nice. However, I'd like to be sure this fits for 
everyone's use cases.

> Regarding the patch above--I did look around the code, and it seems safe,
> as per your analysis, I didn't see any reference to entity after job submission,
> but I'll comment on that thread as well for the record.
> 
> Regards,
> Luben
> 
>>
>> Christian mentioned amdgpu tried something similar to what Lucas tried
>> running into similar trouble, backed off and implemented it in another
>> way - a driver specific way I guess?
>>
>>>
>>> Lucas, can you shed some light on,
>>>
>>> 1. In what way the current FIFO scheduling is unfair, and
>>> 2. shed some details on this "scheduling algorithm with a bit
>>> more fairness than the current one"?
>>>
>>> Regards,
>>> Luben
>>>
>>>>
>>>>> 2. Somehow make sure drm_sched_entity_destroy() does block until all
>>>>> jobs deployed through this entity were fetched from the schedulers
>>>>> pending list. Though, I'm pretty sure that this is not really desirable.
>>>>>
>>>>> 3. Just revert the change and let drivers implement tracking of GPU
>>>>> active times themselves.
>>>>>
>>>> Given that we are already pretty late in the release cycle and etnaviv
>>>> being the only driver so far making use of the scheduler elapsed time
>>>> tracking I think the right short term solution is to either move the
>>>> tracking into etnaviv or just revert the change for now. I'll have a
>>>> look at this.
>>>>
>>>> Regards,
>>>> Lucas
>>>>
>>>>> In the case of just reverting the change I'd propose to also set a jobs
>>>>> entity pointer to NULL  once the job was taken from the entity, such
>>>>> that in case of a future issue we fail where the actual issue resides
>>>>> and to make it more obvious that the field shouldn't be used anymore
>>>>> after the job was taken from the entity.
>>>>>
>>>>> I'm happy to implement the solution we agree on. However, it might also
>>>>> make sense to revert the change until we have a solution in place. I'm
>>>>> also happy to send a revert with a proper description of the problem.
>>>>> Please let me know what you think.
>>>>>
>>>>> - Danilo
>>>>>
>>>>
>>>
>>
> 

