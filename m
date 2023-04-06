Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF646D9C32
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbjDFPZl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Apr 2023 11:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237171AbjDFPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:25:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7C77EDC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:25:37 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1pkRTu-0002NT-7K; Thu, 06 Apr 2023 17:24:58 +0200
Message-ID: <9ac69b11802331f9e024ab837b85214c4243e3fd.camel@pengutronix.de>
Subject: Re: [Regression] drm/scheduler: track GPU active time per entity
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Luben Tuikov <luben.tuikov@amd.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Dave Airlie <airlied@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        andrey.grodzovsky@amd.com, tvrtko.ursulin@linux.intel.com,
        Matthew Brost <matthew.brost@intel.com>, yuq825@gmail.com,
        Boris Brezillon <boris.brezillon@collabora.com>,
        lina@asahilina.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Apr 2023 17:24:55 +0200
In-Reply-To: <31f03135-40e4-a6ad-37e0-3b434a37922d@amd.com>
References: <3e00d8a9-b6c4-8202-4f2d-5a659c61d094@redhat.com>
         <2a84875dde6565842aa07ddb96245b7d939cb4fd.camel@pengutronix.de>
         <8b28151c-f2db-af3f-8dff-87dd5d57417b@amd.com>
         <3004a2bf-e725-643e-82af-8a217784e796@redhat.com>
         <013781a3-5abd-8c66-8a0a-dd36c9c487af@amd.com>
         <28d10733-b217-7ccc-4b8c-54bdc8249234@amd.com>
         <CAKMK7uFeeAaG8+1EutgMtmVANTb-acL0faEkJfUp1_35rSjaEg@mail.gmail.com>
         <9c72c7162da56234addd7083ec774e525a13957c.camel@pengutronix.de>
         <31f03135-40e4-a6ad-37e0-3b434a37922d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

Am Donnerstag, dem 06.04.2023 um 16:21 +0200 schrieb Christian König:
> Am 06.04.23 um 12:45 schrieb Lucas Stach:
> > Am Donnerstag, dem 06.04.2023 um 10:27 +0200 schrieb Daniel Vetter:
> > > On Thu, 6 Apr 2023 at 10:22, Christian König <christian.koenig@amd.com> wrote:
> > > > Am 05.04.23 um 18:09 schrieb Luben Tuikov:
> > > > > On 2023-04-05 10:05, Danilo Krummrich wrote:
> > > > > > On 4/4/23 06:31, Luben Tuikov wrote:
> > > > > > > On 2023-03-28 04:54, Lucas Stach wrote:
> > > > > > > > Hi Danilo,
> > > > > > > > 
> > > > > > > > Am Dienstag, dem 28.03.2023 um 02:57 +0200 schrieb Danilo Krummrich:
> > > > > > > > > Hi all,
> > > > > > > > > 
> > > > > > > > > Commit df622729ddbf ("drm/scheduler: track GPU active time per entity")
> > > > > > > > > tries to track the accumulated time that a job was active on the GPU
> > > > > > > > > writing it to the entity through which the job was deployed to the
> > > > > > > > > scheduler originally. This is done within drm_sched_get_cleanup_job()
> > > > > > > > > which fetches a job from the schedulers pending_list.
> > > > > > > > > 
> > > > > > > > > Doing this can result in a race condition where the entity is already
> > > > > > > > > freed, but the entity's newly added elapsed_ns field is still accessed
> > > > > > > > > once the job is fetched from the pending_list.
> > > > > > > > > 
> > > > > > > > > After drm_sched_entity_destroy() being called it should be safe to free
> > > > > > > > > the structure that embeds the entity. However, a job originally handed
> > > > > > > > > over to the scheduler by this entity might still reside in the
> > > > > > > > > schedulers pending_list for cleanup after drm_sched_entity_destroy()
> > > > > > > > > already being called and the entity being freed. Hence, we can run into
> > > > > > > > > a UAF.
> > > > > > > > > 
> > > > > > > > Sorry about that, I clearly didn't properly consider this case.
> > > > > > > > 
> > > > > > > > > In my case it happened that a job, as explained above, was just picked
> > > > > > > > > from the schedulers pending_list after the entity was freed due to the
> > > > > > > > > client application exiting. Meanwhile this freed up memory was already
> > > > > > > > > allocated for a subsequent client applications job structure again.
> > > > > > > > > Hence, the new jobs memory got corrupted. Luckily, I was able to
> > > > > > > > > reproduce the same corruption over and over again by just using
> > > > > > > > > deqp-runner to run a specific set of VK test cases in parallel.
> > > > > > > > > 
> > > > > > > > > Fixing this issue doesn't seem to be very straightforward though (unless
> > > > > > > > > I miss something), which is why I'm writing this mail instead of sending
> > > > > > > > > a fix directly.
> > > > > > > > > 
> > > > > > > > > Spontaneously, I see three options to fix it:
> > > > > > > > > 
> > > > > > > > > 1. Rather than embedding the entity into driver specific structures
> > > > > > > > > (e.g. tied to file_priv) we could allocate the entity separately and
> > > > > > > > > reference count it, such that it's only freed up once all jobs that were
> > > > > > > > > deployed through this entity are fetched from the schedulers pending list.
> > > > > > > > > 
> > > > > > > > My vote is on this or something in similar vain for the long term. I
> > > > > > > > have some hope to be able to add a GPU scheduling algorithm with a bit
> > > > > > > > more fairness than the current one sometime in the future, which
> > > > > > > > requires execution time tracking on the entities.
> > > > > > > Danilo,
> > > > > > > 
> > > > > > > Using kref is preferable, i.e. option 1 above.
> > > > > > I think the only real motivation for doing that would be for generically
> > > > > > tracking job statistics within the entity a job was deployed through. If
> > > > > > we all agree on tracking job statistics this way I am happy to prepare a
> > > > > > patch for this option and drop this one:
> > > > > > https://lore.kernel.org/all/20230331000622.4156-1-dakr@redhat.com/T/#u
> > > > > Hmm, I never thought about "job statistics" when I preferred using kref above.
> > > > > The reason kref is attractive is because one doesn't need to worry about
> > > > > it--when the last user drops the kref, the release is called to do
> > > > > housekeeping. If this never happens, we know that we have a bug to debug.
> > > > Yeah, reference counting unfortunately have some traps as well. For
> > > > example rarely dropping the last reference from interrupt context or
> > > > with some unexpected locks help when the cleanup function doesn't expect
> > > > that is a good recipe for problems as well.
> > > > 
> > Fully agreed.
> > 
> > > > > Regarding the patch above--I did look around the code, and it seems safe,
> > > > > as per your analysis, I didn't see any reference to entity after job submission,
> > > > > but I'll comment on that thread as well for the record.
> > > > Reference counting the entities was suggested before. The intentionally
> > > > avoided that so far because the entity might be the tip of the iceberg
> > > > of stuff you need to keep around.
> > > > 
> > > > For example for command submission you also need the VM and when you
> > > > keep the VM alive you also need to keep the file private alive....
> > > Yeah refcounting looks often like the easy way out to avoid
> > > use-after-free issue, until you realize you've just made lifetimes
> > > unbounded and have some enourmous leaks: entity keeps vm alive, vm
> > > keeps all the bo alives, somehow every crash wastes more memory
> > > because vk_device_lost means userspace allocates new stuff for
> > > everything.
> > > 
> > > If possible a lifetime design where lifetimes have hard bounds and you
> > > just borrow a reference under a lock (or some other ownership rule) is
> > > generally much more solid. But also much harder to design correctly
> > > :-/
> > > 
> > The use we are discussing here is to keep the entity alive as long as
> > jobs from that entity are still active on the HW. While there are no
> > hard bounds on when a job will get inactive, at least it's not
> > unbounded. On a crash/fault the job will be removed from the hardware
> > pretty soon.
> > 
> > Well behaved jobs after a application shutdown might take a little
> > longer, but I don't really see the new problem with keeping the entity
> > alive? As long as a job is active on the hardware, we can't throw out
> > the VM or BOs, no difference whether the entity is kept alive or not.
> 
> Exactly that's the problem. VM & BOs are dropped as soon as the process 
> is destroyed, we *don't* wait for the hw to finish before doing so.
> 
> Just the backing store managed by all the house keeping objects isn't 
> freed until the hw is idle preventing a crash or accessing freed memory.
> 
> This behavior is rather important for the OOM killer since we need to be 
> able to tear down the process as fast as possible in that case.
> 
Are you talking about the dropping of pending jobs in
drm_sched_entity_kill? I'm certainly not trying to change that in any
way. Those aren't put onto the hardware yet, so we can always safely
drop them and do so as fast as possible.

What I'm concerned about are the jobs that are already scheduled on the
HW. At least with Vivante hardware there is no race free way to get rid
of jobs once they are put on the ring. So whatever the scheduler or DRM
core is doing, we have to hold on to the BOs and GPU memory management
structures to keep the hardware from operating on freed memory.

That's already a lot of memory, so I don't really see the issue with
keeping the entity around in a quiescent state until all the currently
queued jobs have left the HW.

> Changing that is possible, but that's quite a huge change I'm not really 
> willing to do just for tracking the time spend.
> 
Yea, it's a big change and whether it's a good idea really depends on
what we a gaining from it. You seem to see quite low value in "just
tracking the time spent" and that might be true, but it also forces all
drivers that want to implement fdinfo to roll their own time tracking.
I would rather see more of this moved to the scheduler and thus shared
between drivers.

Regards,
Lucas

> What we could do is to track the unsignaled fences in each entity 
> similar to what amdgpu is doing.
> 
> Regards,
> Christian.
> 
> > 
> > Some hardware might have ways to expedite job inactivation by
> > deactivating scheduling queues, or just taking a fault, but for some HW
> > we'll just have to wait for the job to finish.
> > 
> > Regards,
> > Lucas
> > 
> 

