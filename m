Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D896E76C7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjDSJxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjDSJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:53:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5062DE7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:53:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A81B01063;
        Wed, 19 Apr 2023 02:54:00 -0700 (PDT)
Received: from [10.57.20.93] (unknown [10.57.20.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C10963F6C4;
        Wed, 19 Apr 2023 02:53:14 -0700 (PDT)
Message-ID: <dcd957cf-8e26-11f1-2ac1-0fdd8541eed3@arm.com>
Date:   Wed, 19 Apr 2023 10:53:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] drm/scheduler: set entity to NULL in
 drm_sched_entity_pop_job()
Content-Language: en-GB
To:     Lucas Stach <l.stach@pengutronix.de>,
        Danilo Krummrich <dakr@redhat.com>, luben.tuikov@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230418100453.4433-1-dakr@redhat.com>
 <ddaf4984-6f5a-404c-df9d-537245e99420@arm.com>
 <04f039ac71f3c0685a849b492478d18ec6ea4d11.camel@pengutronix.de>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <04f039ac71f3c0685a849b492478d18ec6ea4d11.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 10:44, Lucas Stach wrote:
> Hi Steven,
> 
> Am Mittwoch, dem 19.04.2023 um 10:39 +0100 schrieb Steven Price:
>> On 18/04/2023 11:04, Danilo Krummrich wrote:
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
>> This triggers a splat for me (with Panfrost driver), the cause of which
>> is the following code in drm_sched_get_cleanup_job():
>>
>> 	if (job) {
>> 		job->entity->elapsed_ns += ktime_to_ns(
>> 			ktime_sub(job->s_fence->finished.timestamp,
>> 				  job->s_fence->scheduled.timestamp));
>> 	}
>>
>> which indeed is accessing entity after the job has been returned from
>> drm_sched_entity_pop_job(). And obviously job->entity is a NULL pointer
>> with this patch.
>>
>> I'm afraid I don't fully understand the lifecycle so I'm not sure if
>> this is simply exposing an existing bug in drm_sched_get_cleanup_job()
>> or if this commit needs to be reverted.
>>
> Not sure which tree you are on. The offending commit has been reverted
> in 6.3-rc5.

This is in drm-misc-next - I'm not sure which "offending commit" you are
referring to. I'm referring to:

96c7c2f4d5bd ("drm/scheduler: set entity to NULL in
drm_sched_entity_pop_job()")

which was merged yesterday to drm-misc-next (and is currently the top
commit).

Is there another commit which has been reverted elsewhere which is
conflicting?

Steve

> Regards,
> Lucas
> 
>> Thanks,
>>
>> Steve
>>
>>> ---
>>>  drivers/gpu/drm/scheduler/sched_entity.c | 6 ++++++
>>>  drivers/gpu/drm/scheduler/sched_main.c   | 4 ++++
>>>  2 files changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
>>> index 15d04a0ec623..a9c6118e534b 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>>> @@ -448,6 +448,12 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
>>>  			drm_sched_rq_update_fifo(entity, next->submit_ts);
>>>  	}
>>>  
>>> +	/* Jobs and entities might have different lifecycles. Since we're
>>> +	 * removing the job from the entities queue, set the jobs entity pointer
>>> +	 * to NULL to prevent any future access of the entity through this job.
>>> +	 */
>>> +	sched_job->entity = NULL;
>>> +
>>>  	return sched_job;
>>>  }
>>>  
>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>>> index 9b16480686f6..e89a3e469cd5 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>> @@ -42,6 +42,10 @@
>>>   *    the hardware.
>>>   *
>>>   * The jobs in a entity are always scheduled in the order that they were pushed.
>>> + *
>>> + * Note that once a job was taken from the entities queue and pushed to the
>>> + * hardware, i.e. the pending queue, the entity must not be referenced anymore
>>> + * through the jobs entity pointer.
>>>   */
>>>  
>>>  #include <linux/kthread.h>
>>
> 

