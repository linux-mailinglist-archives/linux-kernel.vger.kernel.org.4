Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2089A705445
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjEPQoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjEPQol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:44:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB89140E7
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:44:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C20463CA7
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22229C433EF;
        Tue, 16 May 2023 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684255474;
        bh=oI/w41//LmhBbTJUIIKUoIgJT4tMuwewNU0CYpQ25/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5EARszE4TyE9KS7I51W38SR5n7Bc74hVJRONPVLwM0Go7PY72IqtJaYgX7vrZaNY
         rqj1vAIJxec9TNeLh/re6W8ROBz33fszELvWzvvMQ701PUkTa+PFdVwmChp9jinPlv
         zm89889dgT1+XV/vKtr53Y6O7EFxxEioSt4SjxWFv81aY+433OmOeNH+P6IglH5Evs
         ggzxpsYViBLsSNNTVbiiyMQvr70TcM0gBLCMRR7mDgYg2jv7tLlRTuyfNB99GIi8Dl
         RhtfiBAtQ5kG4DAhzQqyZ6flxWolTYzsZErQT2Ge/RaImD07AnYKDYHNV5YKOvuJV+
         CowyLHoX7rcjQ==
Date:   Tue, 16 May 2023 18:44:27 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        nicolas.dichtel@6wind.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Message-ID: <20230516-summieren-bankintern-7def19d6ec45@brauner>
References: <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
 <20230516-weltmeere-backofen-27f12ae2c9e0@brauner>
 <683d0c30-4aeb-3547-49a9-90ce6eb1a7d0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <683d0c30-4aeb-3547-49a9-90ce6eb1a7d0@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 11:24:48AM -0500, Mike Christie wrote:
> On 5/16/23 3:39 AM, Christian Brauner wrote:
> > On Mon, May 15, 2023 at 05:23:12PM -0500, Mike Christie wrote:
> >> On 5/15/23 10:44 AM, Linus Torvalds wrote:
> >>> On Mon, May 15, 2023 at 7:23 AM Christian Brauner <brauner@kernel.org> wrote:
> >>>>
> >>>> So I think we will be able to address (1) and (2) by making vhost tasks
> >>>> proper threads and blocking every signal except for SIGKILL and SIGSTOP
> >>>> and then having vhost handle get_signal() - as you mentioned - the same
> >>>> way io uring already does. We should also remove the ingore_signals
> >>>> thing completely imho. I don't think we ever want to do this with user
> >>>> workers.
> >>>
> >>> Right. That's what IO_URING does:
> >>>
> >>>         if (args->io_thread) {
> >>>                 /*
> >>>                  * Mark us an IO worker, and block any signal that isn't
> >>>                  * fatal or STOP
> >>>                  */
> >>>                 p->flags |= PF_IO_WORKER;
> >>>                 siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
> >>>         }
> >>>
> >>> and I really think that vhost should basically do exactly what io_uring does.
> >>>
> >>> Not because io_uring fundamentally got this right - but simply because
> >>> io_uring had almost all the same bugs (and then some), and what the
> >>> io_uring worker threads ended up doing was to basically zoom in on
> >>> "this works".
> >>>
> >>> And it zoomed in on it largely by just going for "make it look as much
> >>> as possible as a real user thread", because every time the kernel
> >>> thread did something different, it just caused problems.
> >>>
> >>> So I think the patch should just look something like the attached.
> >>> Mike, can you test this on whatever vhost test-suite?
> >>
> >> I tried that approach already and it doesn't work because io_uring and vhost
> >> differ in that vhost drivers implement a device where each device has a vhost_task
> >> and the drivers have a file_operations for the device. When the vhost_task's
> >> parent gets signal like SIGKILL, then it will exit and call into the vhost
> >> driver's file_operations->release function. At this time, we need to do cleanup
> > 
> > But that's no reason why the vhost worker couldn't just be allowed to
> > exit on SIGKILL cleanly similar to io_uring. That's just describing the
> > current architecture which isn't a necessity afaict. And the helper
> > thread could e.g., crash.
> > 
> >> like flush the device which uses the vhost_task. There is also the case where if
> >> the vhost_task gets a SIGKILL, we can just exit from under the vhost layer.
> > 
> > In a way I really don't like the patch below. Because this should be
> > solvable by adapting vhost workers. Right now, vhost is coming from a
> > kthread model and we ported it to a user worker model and the whole
> > point of this excercise has been that the workers behave more like
> > regular userspace processes. So my tendency is to not massage kernel
> > signal handling to now also include a special case for user workers in
> > addition to kthreads. That's just the wrong way around and then vhost
> > could've just stuck with kthreads in the first place.
> 
> I would have preferred that :) Maybe let's take a step back and revisit
> that decision to make sure it was right. The vhost layer wants:
> 
> 1. inherit cgroups.
> 2. share mm.
> 3. no signals
> 4. to not show up was an extra process like in Nicolas's bug.
> 5. have it's worker threads counted under its parent nproc limit.
> 
> We can do 1 - 4 today with kthreads. Can we do #5 with kthreads? My first
> attempt which passed around the creds to use for kthreads or exported a
> helper for the nproc accounting was not liked and we eventually ended up
> here.
> 
> Is this hybird user/kernel thread/task still the right way to go or is
> better to use kthreads and add some way to handle #5?

I think the io_uring model makes a lot more sense for vhost than the
current approach.

> 
> 
> > 
> > So I'm fine with skipping over the freezing case for now but SIGKILL
> > should be handled imho. Only init and kthreads should get the luxury of
> > ignoring SIGKILL.
> > 
> > So, I'm afraid I'm asking some work here of you but how feasible would a
> > model be where vhost_worker() similar to io_wq_worker() gracefully
> > handles SIGKILL. Yes, I see there's
> > 
> > net.c:   .release = vhost_net_release
> > scsi.c:  .release = vhost_scsi_release
> > test.c:  .release = vhost_test_release
> > vdpa.c:  .release = vhost_vdpa_release
> > vsock.c: .release = virtio_transport_release
> > vsock.c: .release = vhost_vsock_dev_release
> > 
> > but that means you have all the basic logic in place and all of those
> > drivers also support the VHOST_RESET_OWNER ioctl which also stops the
> > vhost worker. I'm confident that a lof this can be leveraged to just
> > cleanup on SIGKILL.
> 
> We can do this, but the issue I'm worried about is that right now if there
> is queued/running IO and userspace escalates to SIGKILL, then the vhost layer
> will still complete those IOs. If we now allow SIGKILL on the vhost thread,
> then those IOs might fail.
> 
> If we get a SIGKILL, I can modify vhost_worker() so that it temporarily
> ignores the signal and allows IO/flushes/whatever-operations to complete
> at that level. However, we could hit issues where when vhost_worker()

It's really not that different from io_uring though which also flushes
out remaining io, no? This seems to basically line up with what
io_wq_worker() does.

> calls into the drivers listed above, and those drivers call into whatever
> kernel layer they use, that might do
> 
> if (signal_pending(current))
> 	return failure;
> 
> and we now fail.
> 
> If we say that since we got a SIGKILL, then failing is acceptable behavior
> now, I can code what you are requesting.

I think this is fine but I don't maintain vhost and we'd need their
opinion.
