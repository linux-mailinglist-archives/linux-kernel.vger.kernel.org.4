Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670B96D8219
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbjDEPiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbjDEPiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C400549F1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680709055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAoSWbkGrjcqGy1ebcwtm3AyobUtd3KUJObW/aFOL0w=;
        b=aFGzp+QjTh0wubo3/hdEY1PHMxvJJPyI1X4gsfw5jQNa4o/0/EgpRjcbXF7BHc6PgGCQqn
        S4DfJ3l6j4lO16nAfAvikyw9Bbi+oNXHp/TmXsH9D2Fy6/YkGqOpB2CXPlqD0iScdEv/WC
        avvcdTZmrxlwT5nvNoLfIqX23wOpGyQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-T_ZCm0htMLOJwGEJVndOpg-1; Wed, 05 Apr 2023 11:37:22 -0400
X-MC-Unique: T_ZCm0htMLOJwGEJVndOpg-1
Received: by mail-pf1-f200.google.com with SMTP id t67-20020a628146000000b0062d6d838243so14145349pfd.21
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680709021;
        h=content-transfer-encoding:in-reply-to:cc:organization:from
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAoSWbkGrjcqGy1ebcwtm3AyobUtd3KUJObW/aFOL0w=;
        b=fdSnmK7NGnkOE3D0U8y7zfuCUTbIOR+ViOhcIGCahL23BrCCx69UQor3h7VXAsfmpM
         MxbI+eZWbRUFMGZkun3BDTUzAtUkwTPScpQhnD+tUa6c6MLRJGm8qJGLdXuH5CuS8Zad
         2O6cm8dW4B0gY95ClTsPMN9WJBpkQM1t35q8Eds6walJRlcXtQDj4e9zp9Z2vDr2IAIN
         3RoAYAN7vXUdL11CM72DL4cncJU32g1tvH1QRWH/7z5Tpn0jejBYtjOhL7uwfynFrNWn
         ieqAtkZc9jdV++U0kjGF2f8QCYUpOUkVxItmNeYIR2frX05x9Oww3pyAm3gGt7dQEooy
         Eh8g==
X-Gm-Message-State: AAQBX9euDNk8bAYiY1oujdidlN+ec4hhX2PzOTvYoIAU5y2EzPcqVJ02
        5IpXiQ/w+/nP1QyV2Nv2P01mewqxm6xzxNNXdQuE9QUw6TiT1YkYwbThfavYyCKYmpuvTd9N8YT
        vSyx8nqbKQxYav1PMDnDMQmwV
X-Received: by 2002:a17:902:fb86:b0:1a1:cce7:94ed with SMTP id lg6-20020a170902fb8600b001a1cce794edmr5875815plb.67.1680709020723;
        Wed, 05 Apr 2023 08:37:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350Ysj1lHSmWHRrIOh5XGakc+yhw2pI8tXqwln7bNPtMABRm3Ds3ebM09ogVIeJ4YwQVaZ5dCsg==
X-Received: by 2002:a17:902:fb86:b0:1a1:cce7:94ed with SMTP id lg6-20020a170902fb8600b001a1cce794edmr5875793plb.67.1680709020353;
        Wed, 05 Apr 2023 08:37:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm10262513plb.64.2023.04.05.08.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 08:37:00 -0700 (PDT)
Message-ID: <3004a2bf-e725-643e-82af-8a217784e796@redhat.com>
Date:   Wed, 5 Apr 2023 16:05:53 +0200
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
References: <3e00d8a9-b6c4-8202-4f2d-5a659c61d094@redhat.com>
 <2a84875dde6565842aa07ddb96245b7d939cb4fd.camel@pengutronix.de>
 <8b28151c-f2db-af3f-8dff-87dd5d57417b@amd.com>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <8b28151c-f2db-af3f-8dff-87dd5d57417b@amd.com>
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

On 4/4/23 06:31, Luben Tuikov wrote:
> On 2023-03-28 04:54, Lucas Stach wrote:
>> Hi Danilo,
>>
>> Am Dienstag, dem 28.03.2023 um 02:57 +0200 schrieb Danilo Krummrich:
>>> Hi all,
>>>
>>> Commit df622729ddbf ("drm/scheduler: track GPU active time per entity")
>>> tries to track the accumulated time that a job was active on the GPU
>>> writing it to the entity through which the job was deployed to the
>>> scheduler originally. This is done within drm_sched_get_cleanup_job()
>>> which fetches a job from the schedulers pending_list.
>>>
>>> Doing this can result in a race condition where the entity is already
>>> freed, but the entity's newly added elapsed_ns field is still accessed
>>> once the job is fetched from the pending_list.
>>>
>>> After drm_sched_entity_destroy() being called it should be safe to free
>>> the structure that embeds the entity. However, a job originally handed
>>> over to the scheduler by this entity might still reside in the
>>> schedulers pending_list for cleanup after drm_sched_entity_destroy()
>>> already being called and the entity being freed. Hence, we can run into
>>> a UAF.
>>>
>> Sorry about that, I clearly didn't properly consider this case.
>>
>>> In my case it happened that a job, as explained above, was just picked
>>> from the schedulers pending_list after the entity was freed due to the
>>> client application exiting. Meanwhile this freed up memory was already
>>> allocated for a subsequent client applications job structure again.
>>> Hence, the new jobs memory got corrupted. Luckily, I was able to
>>> reproduce the same corruption over and over again by just using
>>> deqp-runner to run a specific set of VK test cases in parallel.
>>>
>>> Fixing this issue doesn't seem to be very straightforward though (unless
>>> I miss something), which is why I'm writing this mail instead of sending
>>> a fix directly.
>>>
>>> Spontaneously, I see three options to fix it:
>>>
>>> 1. Rather than embedding the entity into driver specific structures
>>> (e.g. tied to file_priv) we could allocate the entity separately and
>>> reference count it, such that it's only freed up once all jobs that were
>>> deployed through this entity are fetched from the schedulers pending list.
>>>
>> My vote is on this or something in similar vain for the long term. I
>> have some hope to be able to add a GPU scheduling algorithm with a bit
>> more fairness than the current one sometime in the future, which
>> requires execution time tracking on the entities.
> 
> Danilo,
> 
> Using kref is preferable, i.e. option 1 above.

I think the only real motivation for doing that would be for generically 
tracking job statistics within the entity a job was deployed through. If 
we all agree on tracking job statistics this way I am happy to prepare a 
patch for this option and drop this one: 
https://lore.kernel.org/all/20230331000622.4156-1-dakr@redhat.com/T/#u

Christian mentioned amdgpu tried something similar to what Lucas tried 
running into similar trouble, backed off and implemented it in another 
way - a driver specific way I guess?

> 
> Lucas, can you shed some light on,
> 
> 1. In what way the current FIFO scheduling is unfair, and
> 2. shed some details on this "scheduling algorithm with a bit
> more fairness than the current one"?
> 
> Regards,
> Luben
> 
>>
>>> 2. Somehow make sure drm_sched_entity_destroy() does block until all
>>> jobs deployed through this entity were fetched from the schedulers
>>> pending list. Though, I'm pretty sure that this is not really desirable.
>>>
>>> 3. Just revert the change and let drivers implement tracking of GPU
>>> active times themselves.
>>>
>> Given that we are already pretty late in the release cycle and etnaviv
>> being the only driver so far making use of the scheduler elapsed time
>> tracking I think the right short term solution is to either move the
>> tracking into etnaviv or just revert the change for now. I'll have a
>> look at this.
>>
>> Regards,
>> Lucas
>>
>>> In the case of just reverting the change I'd propose to also set a jobs
>>> entity pointer to NULL  once the job was taken from the entity, such
>>> that in case of a future issue we fail where the actual issue resides
>>> and to make it more obvious that the field shouldn't be used anymore
>>> after the job was taken from the entity.
>>>
>>> I'm happy to implement the solution we agree on. However, it might also
>>> make sense to revert the change until we have a solution in place. I'm
>>> also happy to send a revert with a proper description of the problem.
>>> Please let me know what you think.
>>>
>>> - Danilo
>>>
>>
> 

