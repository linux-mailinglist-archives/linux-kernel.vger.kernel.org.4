Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BE16E7720
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjDSKFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjDSKFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:05:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AE1EA5CE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:05:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA6BB106F;
        Wed, 19 Apr 2023 03:06:32 -0700 (PDT)
Received: from [10.57.20.93] (unknown [10.57.20.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 777643F6C4;
        Wed, 19 Apr 2023 03:05:47 -0700 (PDT)
Message-ID: <12a775f5-a4fe-6a61-c187-fb3afa0ab6e2@arm.com>
Date:   Wed, 19 Apr 2023 11:05:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] drm/scheduler: set entity to NULL in
 drm_sched_entity_pop_job()
Content-Language: en-GB
From:   Steven Price <steven.price@arm.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Danilo Krummrich <dakr@redhat.com>, luben.tuikov@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230418100453.4433-1-dakr@redhat.com>
 <ddaf4984-6f5a-404c-df9d-537245e99420@arm.com>
 <04f039ac71f3c0685a849b492478d18ec6ea4d11.camel@pengutronix.de>
 <dcd957cf-8e26-11f1-2ac1-0fdd8541eed3@arm.com>
In-Reply-To: <dcd957cf-8e26-11f1-2ac1-0fdd8541eed3@arm.com>
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

On 19/04/2023 10:53, Steven Price wrote:
> On 19/04/2023 10:44, Lucas Stach wrote:
>> Hi Steven,
>>
>> Am Mittwoch, dem 19.04.2023 um 10:39 +0100 schrieb Steven Price:
>>> On 18/04/2023 11:04, Danilo Krummrich wrote:
>>>> It already happend a few times that patches slipped through which
>>>> implemented access to an entity through a job that was already removed
>>>> from the entities queue. Since jobs and entities might have different
>>>> lifecycles, this can potentially cause UAF bugs.
>>>>
>>>> In order to make it obvious that a jobs entity pointer shouldn't be
>>>> accessed after drm_sched_entity_pop_job() was called successfully, set
>>>> the jobs entity pointer to NULL once the job is removed from the entity
>>>> queue.
>>>>
>>>> Moreover, debugging a potential NULL pointer dereference is way easier
>>>> than potentially corrupted memory through a UAF.
>>>>
>>>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>>>
>>> This triggers a splat for me (with Panfrost driver), the cause of which
>>> is the following code in drm_sched_get_cleanup_job():
>>>
>>> 	if (job) {
>>> 		job->entity->elapsed_ns += ktime_to_ns(
>>> 			ktime_sub(job->s_fence->finished.timestamp,
>>> 				  job->s_fence->scheduled.timestamp));
>>> 	}
>>>
>>> which indeed is accessing entity after the job has been returned from
>>> drm_sched_entity_pop_job(). And obviously job->entity is a NULL pointer
>>> with this patch.
>>>
>>> I'm afraid I don't fully understand the lifecycle so I'm not sure if
>>> this is simply exposing an existing bug in drm_sched_get_cleanup_job()
>>> or if this commit needs to be reverted.
>>>
>> Not sure which tree you are on. The offending commit has been reverted
>> in 6.3-rc5.
> 
> This is in drm-misc-next - I'm not sure which "offending commit" you are
> referring to. I'm referring to:
> 
> 96c7c2f4d5bd ("drm/scheduler: set entity to NULL in
> drm_sched_entity_pop_job()")
> 
> which was merged yesterday to drm-misc-next (and is currently the top
> commit).
> 
> Is there another commit which has been reverted elsewhere which is
> conflicting?

Answering my own question, the conflicting commit is:

baad10973fdb ("Revert "drm/scheduler: track GPU active time per entity"")

But that commit isn't (yet) in drm-misc-next. Which unfortunately means
drm-misc-next is broken until a back-merge happens.

Steve

