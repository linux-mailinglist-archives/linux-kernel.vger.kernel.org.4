Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CAA6CB9EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjC1Iy7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Mar 2023 04:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjC1Iyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:54:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F230319A1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:54:48 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ph56E-0002sU-Jk; Tue, 28 Mar 2023 10:54:38 +0200
Message-ID: <2a84875dde6565842aa07ddb96245b7d939cb4fd.camel@pengutronix.de>
Subject: Re: [Regression] drm/scheduler: track GPU active time per entity
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Danilo Krummrich <dakr@redhat.com>, daniel@ffwll.ch,
        Dave Airlie <airlied@gmail.com>, luben.tuikov@amd.com,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        andrey.grodzovsky@amd.com,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Mar 2023 10:54:37 +0200
In-Reply-To: <3e00d8a9-b6c4-8202-4f2d-5a659c61d094@redhat.com>
References: <3e00d8a9-b6c4-8202-4f2d-5a659c61d094@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

Am Dienstag, dem 28.03.2023 um 02:57 +0200 schrieb Danilo Krummrich:
> Hi all,
> 
> Commit df622729ddbf ("drm/scheduler: track GPU active time per entity") 
> tries to track the accumulated time that a job was active on the GPU 
> writing it to the entity through which the job was deployed to the 
> scheduler originally. This is done within drm_sched_get_cleanup_job() 
> which fetches a job from the schedulers pending_list.
> 
> Doing this can result in a race condition where the entity is already 
> freed, but the entity's newly added elapsed_ns field is still accessed 
> once the job is fetched from the pending_list.
> 
> After drm_sched_entity_destroy() being called it should be safe to free 
> the structure that embeds the entity. However, a job originally handed 
> over to the scheduler by this entity might still reside in the 
> schedulers pending_list for cleanup after drm_sched_entity_destroy() 
> already being called and the entity being freed. Hence, we can run into 
> a UAF.
> 
Sorry about that, I clearly didn't properly consider this case.

> In my case it happened that a job, as explained above, was just picked 
> from the schedulers pending_list after the entity was freed due to the 
> client application exiting. Meanwhile this freed up memory was already 
> allocated for a subsequent client applications job structure again. 
> Hence, the new jobs memory got corrupted. Luckily, I was able to 
> reproduce the same corruption over and over again by just using 
> deqp-runner to run a specific set of VK test cases in parallel.
> 
> Fixing this issue doesn't seem to be very straightforward though (unless 
> I miss something), which is why I'm writing this mail instead of sending 
> a fix directly.
> 
> Spontaneously, I see three options to fix it:
> 
> 1. Rather than embedding the entity into driver specific structures 
> (e.g. tied to file_priv) we could allocate the entity separately and 
> reference count it, such that it's only freed up once all jobs that were 
> deployed through this entity are fetched from the schedulers pending list.
> 
My vote is on this or something in similar vain for the long term. I
have some hope to be able to add a GPU scheduling algorithm with a bit
more fairness than the current one sometime in the future, which
requires execution time tracking on the entities.

> 2. Somehow make sure drm_sched_entity_destroy() does block until all 
> jobs deployed through this entity were fetched from the schedulers 
> pending list. Though, I'm pretty sure that this is not really desirable.
> 
> 3. Just revert the change and let drivers implement tracking of GPU 
> active times themselves.
> 
Given that we are already pretty late in the release cycle and etnaviv
being the only driver so far making use of the scheduler elapsed time
tracking I think the right short term solution is to either move the
tracking into etnaviv or just revert the change for now. I'll have a
look at this.

Regards,
Lucas

> In the case of just reverting the change I'd propose to also set a jobs 
> entity pointer to NULL  once the job was taken from the entity, such 
> that in case of a future issue we fail where the actual issue resides 
> and to make it more obvious that the field shouldn't be used anymore 
> after the job was taken from the entity.
> 
> I'm happy to implement the solution we agree on. However, it might also 
> make sense to revert the change until we have a solution in place. I'm 
> also happy to send a revert with a proper description of the problem. 
> Please let me know what you think.
> 
> - Danilo
> 

