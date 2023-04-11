Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1D96DE39E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjDKSOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjDKSOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E1AE5A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681236835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RerCY0HGkQYWMAGOybHYjUb4SPrEcjg1XoaZcfXg++g=;
        b=WByFDvgkYjWHCMfYelL4q0fZIeRInpoJaCPPXRPrsjUAocNh0ZoxQsqbXOoGdnVEowZT9q
        UG2Clg9D1IeXoQrf0+ZhQeELgF75GE6FZiDOYTA4CKuU4V34tCQ5EiD6ET7fz+8Fd85v72
        AQuNAA+NAqaKQYaHHl+HWXsEfamHj6g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-iJPy-Em1MKy9c7x0_q0u8Q-1; Tue, 11 Apr 2023 14:13:54 -0400
X-MC-Unique: iJPy-Em1MKy9c7x0_q0u8Q-1
Received: by mail-ej1-f69.google.com with SMTP id ja8-20020a170907988800b0094aa0655f0eso2402046ejc.18
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236833;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RerCY0HGkQYWMAGOybHYjUb4SPrEcjg1XoaZcfXg++g=;
        b=ihBaremOxmbUreGsk3DXiX/9Ffydvlhr0ezERgLL5WaxCllN7uY7Oytt88rQKYkxjA
         PMye/XY9jL46FdDrCb63fHIbKu/WorgqgUmyJjpk9GNzGvDiddG+USZdcQnlmIURccZc
         PvT764qY3HRRRIjaXjJWDinyAPVmVbzNjid61m300mi15ZtElCsu2SI+upUeECQZ4OD8
         X8GvMTPgMwOAv6V1t6ZH8cJm3D1APhLiMb2bNahLPKaZ6zx+gFf5mH1o60RLiga7J5ND
         1TaMc5x9hT+DRXIo9u4gYn59k5oEQjzn2+o0TdHRhMEUHaROXG+jPaHuXP/VWHBUtr1c
         neDA==
X-Gm-Message-State: AAQBX9cUi/l8/P0K/ov9EdYjPUsCoY44pEut83uNoh0PUdRYHj9AsUfM
        N/aHo29RhiIccytLW6jWT/jvb/DNV3JWJv6F0KO/nQZQcMvSHvqewxhKYTOdvU36NM8NYOn2LL4
        CcJymLaqYygJMcgOzVsbUM7M1
X-Received: by 2002:a17:906:b2c8:b0:92f:f655:cc78 with SMTP id cf8-20020a170906b2c800b0092ff655cc78mr3605086ejb.53.1681236833081;
        Tue, 11 Apr 2023 11:13:53 -0700 (PDT)
X-Google-Smtp-Source: AKy350bdO2gyZ3joFZbc+2ky2KNki/3ikt5tL+a0aCOQ5MzjlIgiZGpN0xDyLgfYz1JG/c8F5CKPcA==
X-Received: by 2002:a17:906:b2c8:b0:92f:f655:cc78 with SMTP id cf8-20020a170906b2c800b0092ff655cc78mr3605065ejb.53.1681236832744;
        Tue, 11 Apr 2023 11:13:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090677cb00b0094e44445f30sm291729ejn.215.2023.04.11.11.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 11:13:52 -0700 (PDT)
Message-ID: <32c28b47-2a3b-db1d-e927-ae44d52cae0b@redhat.com>
Date:   Tue, 11 Apr 2023 20:13:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/scheduler: set entity to NULL in
 drm_sched_entity_pop_job()
To:     Luben Tuikov <luben.tuikov@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        airlied@gmail.com, daniel@ffwll.ch, l.stach@pengutronix.de,
        "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230331000622.4156-1-dakr@redhat.com>
 <6ad72a7f-302f-4be1-0d53-00ff9dc37ef7@amd.com>
 <ecef210b-dc7d-e385-f9b2-927d55a6777e@amd.com>
Content-Language: en-US
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <ecef210b-dc7d-e385-f9b2-927d55a6777e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 19:39, Luben Tuikov wrote:
> On 2023-03-31 01:59, Christian König wrote:
>> Am 31.03.23 um 02:06 schrieb Danilo Krummrich:
>>> It already happend a few times that patches slipped through which
>>> implemented access to an entity through a job that was already removed
>>> from the entities queue. Since jobs and entities might have different
>>> lifecycles, this can potentially cause UAF bugs.
>>>
>>> In order to make it obvious that a jobs entity pointer shouldn't be
>>> accessed after drm_sched_entity_pop_job() was called successfully, set
>>> the jobs entity pointer to NULL once the job is removed from the entity
>>> queue.
>>>
>>> Moreover, debugging a potential NULL pointer dereference is way easier
>>> than potentially corrupted memory through a UAF.
>>>
>>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>>
>> In general "YES PLEASE!", but I fear that this will break amdgpus reset
>> sequence.
>>
>> On the other hand when amdgpu still relies on that pointer it's clearly
>> a bug (which I pointed out tons of times before).
>>
>> Luben any opinion on that? Could you drive cleaning that up as well?
> 
> I didn't find any references to scheduling entity after the job
> is submitted to the hardware. (I commented the same in the other
> thread, we just need to decide which way to go.)

AFAICS from the other mail thread it seems to be consensus to not 
ref-count entities and handle job statistics differently.

Should we go ahead and take this patch then? Maybe it also makes sense 
to send a V2 additionally adding a comment to the drm_sched_job 
structure mentioning that .entity must not be used after the job was 
taken from the entities queue.

- Danilo

> 
> Regards,
> Luben
> 
>>
>> Thanks,
>> Christian.
>>
>>> ---
>>> I'm aware that drivers could already use job->entity in arbitrary places, since
>>> they in control of when the entity is actually freed. A quick grep didn't give
>>> me any results where this would actually be the case, however maybe I also just
>>> didn't catch it.
>>>
>>> If, therefore, we don't want to set job->entity to NULL I think we should at
>>> least add a comment somewhere.
>>> ---
>>>
>>>    drivers/gpu/drm/scheduler/sched_entity.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>>> index 15d04a0ec623..a9c6118e534b 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>>> @@ -448,6 +448,12 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>>>    			drm_sched_rq_update_fifo(entity, next->submit_ts);
>>>    	}
>>>    
>>> +	/* Jobs and entities might have different lifecycles. Since we're
>>> +	 * removing the job from the entities queue, set the jobs entity pointer
>>> +	 * to NULL to prevent any future access of the entity through this job.
>>> +	 */
>>> +	sched_job->entity = NULL;
>>> +
>>>    	return sched_job;
>>>    }
>>>    
>>
> 

