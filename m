Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75383709721
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjESMPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjESMPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:15:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE12192
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0496161760
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA66C4339B;
        Fri, 19 May 2023 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684498509;
        bh=VTGX2OX7+uxXQDH3wTNN0vLi9cF62gFXdXsTqtCJTac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fK+xUpikHVk7SLGvhUmZ/eIe/LYtPJ+bfRAvQVAABqfteacqCyZYUJTvPKSB69UFF
         s6wqd2q0tFtPAeLWT5A6/uiN4sbm8/FkB1g4HWziYSJNqAKRbVENpv/yUwHPYtwIC+
         EOvs9TcRbaOlxiNmBX+/KVBx6KTkbf7BCGojiCPhYRJq8lM7g/pQQxJ1HIAgjnZMHU
         IZXN1ULEkl3BMaOh+BZ2qE/uZb/zTbp69ILfMWEkOgtRM5yEwVdzONXTqC/d6B7E34
         CymmGbwFthyPCVN1wX9OGqd6BpiOTpGFVvW92tu+hf+Lsx18Qz8TgikZn32G/pqv7X
         XLMQ/diS6+/TQ==
Date:   Fri, 19 May 2023 14:15:02 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, konrad.wilk@oracle.com
Subject: Re: [RFC PATCH 0/8] vhost_tasks: Use CLONE_THREAD/SIGHAND
Message-ID: <20230519-vormittag-dschungel-83607e9d2255@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230518-appetit-aufsicht-238e950b97d6@brauner>
 <20230516-weltmeere-backofen-27f12ae2c9e0@brauner>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 10:25:11AM +0200, Christian Brauner wrote:
> On Wed, May 17, 2023 at 07:09:12PM -0500, Mike Christie wrote:
> > This patch allows the vhost and vhost_task code to use CLONE_THREAD,
> > CLONE_SIGHAND and CLONE_FILES. It's a RFC because I didn't do all the
> > normal testing, haven't coverted vsock and vdpa, and I know you guys
> > will not like the first patch. However, I think it better shows what
> 
> Just to summarize the core idea behind my proposal is that no signal
> handling changes are needed unless there's a bug in the current way
> io_uring workers already work. All that should be needed is
> s/PF_IO_WORKER/PF_USER_WORKER/ in signal.c.
> 
> If you follow my proposal than vhost and io_uring workers should almost
> collapse into the same concept. Specifically, io_uring workers and vhost
> workers should behave the same when it comes ot handling signals.
> 
> See 
> https://lore.kernel.org/lkml/20230518-kontakt-geduckt-25bab595f503@brauner
> 
> 
> > we need from the signal code and how we can support signals in the
> > vhost_task layer.
> > 
> > Note that I took the super simple route and kicked off some work to
> > the system workqueue. We can do more invassive approaches:
> > 1. Modify the vhost drivers so they can check for IO completions using
> > a non-blocking interface. We then don't need to run from the system
> > workqueue and can run from the vhost_task.
> > 
> > 2. We could drop patch 1 and just say we are doing a polling type
> > of approach. We then modify the vhost layer similar to #1 where we
> > can check for completions using a non-blocking interface and use
> > the vhost_task task.
> 
> My preference would be to do whatever is the minimal thing now and has
> the least bug potential and is the easiest to review for us non-vhost
> experts. Then you can take all the time to rework and improve the vhost
> infra based on the possibilities that using user workers offers. Plus,
> that can easily happen in the next kernel cycle.
> 
> Remember, that we're trying to fix a regression here. A regression on an
> unreleased kernel but still.

On Tue, May 16, 2023 at 10:40:01AM +0200, Christian Brauner wrote:
> On Mon, May 15, 2023 at 05:23:12PM -0500, Mike Christie wrote:
> > On 5/15/23 10:44 AM, Linus Torvalds wrote:
> > > On Mon, May 15, 2023 at 7:23 AM Christian Brauner <brauner@kernel.org> wrote:
> > >>
> > >> So I think we will be able to address (1) and (2) by making vhost tasks
> > >> proper threads and blocking every signal except for SIGKILL and SIGSTOP
> > >> and then having vhost handle get_signal() - as you mentioned - the same
> > >> way io uring already does. We should also remove the ingore_signals
> > >> thing completely imho. I don't think we ever want to do this with user
> > >> workers.
> > > 
> > > Right. That's what IO_URING does:
> > > 
> > >         if (args->io_thread) {
> > >                 /*
> > >                  * Mark us an IO worker, and block any signal that isn't
> > >                  * fatal or STOP
> > >                  */
> > >                 p->flags |= PF_IO_WORKER;
> > >                 siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
> > >         }
> > > 
> > > and I really think that vhost should basically do exactly what io_uring does.
> > > 
> > > Not because io_uring fundamentally got this right - but simply because
> > > io_uring had almost all the same bugs (and then some), and what the
> > > io_uring worker threads ended up doing was to basically zoom in on
> > > "this works".
> > > 
> > > And it zoomed in on it largely by just going for "make it look as much
> > > as possible as a real user thread", because every time the kernel
> > > thread did something different, it just caused problems.
> > > 
> > > So I think the patch should just look something like the attached.
> > > Mike, can you test this on whatever vhost test-suite?
> > 
> > I tried that approach already and it doesn't work because io_uring and vhost
> > differ in that vhost drivers implement a device where each device has a vhost_task
> > and the drivers have a file_operations for the device. When the vhost_task's
> > parent gets signal like SIGKILL, then it will exit and call into the vhost
> > driver's file_operations->release function. At this time, we need to do cleanup
> 
> But that's no reason why the vhost worker couldn't just be allowed to
> exit on SIGKILL cleanly similar to io_uring. That's just describing the
> current architecture which isn't a necessity afaict. And the helper
> thread could e.g., crash.
> 
> > like flush the device which uses the vhost_task. There is also the case where if
> > the vhost_task gets a SIGKILL, we can just exit from under the vhost layer.
> 
> In a way I really don't like the patch below. Because this should be
> solvable by adapting vhost workers. Right now, vhost is coming from a
> kthread model and we ported it to a user worker model and the whole
> point of this excercise has been that the workers behave more like
> regular userspace processes. So my tendency is to not massage kernel
> signal handling to now also include a special case for user workers in
> addition to kthreads. That's just the wrong way around and then vhost
> could've just stuck with kthreads in the first place.
> 
> So I'm fine with skipping over the freezing case for now but SIGKILL
> should be handled imho. Only init and kthreads should get the luxury of
> ignoring SIGKILL.
> 
> So, I'm afraid I'm asking some work here of you but how feasible would a
> model be where vhost_worker() similar to io_wq_worker() gracefully
> handles SIGKILL. Yes, I see there's
> 
> net.c:   .release = vhost_net_release
> scsi.c:  .release = vhost_scsi_release
> test.c:  .release = vhost_test_release
> vdpa.c:  .release = vhost_vdpa_release
> vsock.c: .release = virtio_transport_release
> vsock.c: .release = vhost_vsock_dev_release
> 
> but that means you have all the basic logic in place and all of those
> drivers also support the VHOST_RESET_OWNER ioctl which also stops the
> vhost worker. I'm confident that a lof this can be leveraged to just
> cleanup on SIGKILL.
> 
> So it feels like this should be achievable by adding a callback to
> struct vhost_worker that get's called when vhost_worker() gets SIGKILL
> and that all the users of vhost workers are forced to implement.
> 
> Yes, it is more work but I think that's the right thing to do and not to
> complicate our signal handling.
> 
> Worst case if this can't be done fast enough we'll have to revert the
> vhost parts. I think the user worker parts are mostly sane and are

As mentioned, if we can't settle this cleanly before -rc4 we should
revert the vhost parts unless Linus wants to have it earlier.
