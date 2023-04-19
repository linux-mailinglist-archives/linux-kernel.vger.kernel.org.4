Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38606E7699
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjDSJo1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Apr 2023 05:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjDSJoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:44:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048A52726
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:44:18 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1pp4MG-00024s-3b; Wed, 19 Apr 2023 11:44:12 +0200
Message-ID: <04f039ac71f3c0685a849b492478d18ec6ea4d11.camel@pengutronix.de>
Subject: Re: [PATCH v2] drm/scheduler: set entity to NULL in
 drm_sched_entity_pop_job()
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Steven Price <steven.price@arm.com>,
        Danilo Krummrich <dakr@redhat.com>, luben.tuikov@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Wed, 19 Apr 2023 11:44:10 +0200
In-Reply-To: <ddaf4984-6f5a-404c-df9d-537245e99420@arm.com>
References: <20230418100453.4433-1-dakr@redhat.com>
         <ddaf4984-6f5a-404c-df9d-537245e99420@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Am Mittwoch, dem 19.04.2023 um 10:39 +0100 schrieb Steven Price:
> On 18/04/2023 11:04, Danilo Krummrich wrote:
> > It already happend a few times that patches slipped through which
> > implemented access to an entity through a job that was already removed
> > from the entities queue. Since jobs and entities might have different
> > lifecycles, this can potentially cause UAF bugs.
> > 
> > In order to make it obvious that a jobs entity pointer shouldn't be
> > accessed after drm_sched_entity_pop_job() was called successfully, set
> > the jobs entity pointer to NULL once the job is removed from the entity
> > queue.
> > 
> > Moreover, debugging a potential NULL pointer dereference is way easier
> > than potentially corrupted memory through a UAF.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> 
> This triggers a splat for me (with Panfrost driver), the cause of which
> is the following code in drm_sched_get_cleanup_job():
> 
> 	if (job) {
> 		job->entity->elapsed_ns += ktime_to_ns(
> 			ktime_sub(job->s_fence->finished.timestamp,
> 				  job->s_fence->scheduled.timestamp));
> 	}
> 
> which indeed is accessing entity after the job has been returned from
> drm_sched_entity_pop_job(). And obviously job->entity is a NULL pointer
> with this patch.
> 
> I'm afraid I don't fully understand the lifecycle so I'm not sure if
> this is simply exposing an existing bug in drm_sched_get_cleanup_job()
> or if this commit needs to be reverted.
> 
Not sure which tree you are on. The offending commit has been reverted
in 6.3-rc5.

Regards,
Lucas

> Thanks,
> 
> Steve
> 
> > ---
> >  drivers/gpu/drm/scheduler/sched_entity.c | 6 ++++++
> >  drivers/gpu/drm/scheduler/sched_main.c   | 4 ++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> > index 15d04a0ec623..a9c6118e534b 100644
> > --- a/drivers/gpu/drm/scheduler/sched_entity.c
> > +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> > @@ -448,6 +448,12 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
> >  			drm_sched_rq_update_fifo(entity, next->submit_ts);
> >  	}
> >  
> > +	/* Jobs and entities might have different lifecycles. Since we're
> > +	 * removing the job from the entities queue, set the jobs entity pointer
> > +	 * to NULL to prevent any future access of the entity through this job.
> > +	 */
> > +	sched_job->entity = NULL;
> > +
> >  	return sched_job;
> >  }
> >  
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> > index 9b16480686f6..e89a3e469cd5 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -42,6 +42,10 @@
> >   *    the hardware.
> >   *
> >   * The jobs in a entity are always scheduled in the order that they were pushed.
> > + *
> > + * Note that once a job was taken from the entities queue and pushed to the
> > + * hardware, i.e. the pending queue, the entity must not be referenced anymore
> > + * through the jobs entity pointer.
> >   */
> >  
> >  #include <linux/kthread.h>
> 

