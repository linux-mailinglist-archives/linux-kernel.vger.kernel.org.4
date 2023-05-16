Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0A8704807
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjEPIkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjEPIkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:40:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AE21BF6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B39C062FFE
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B049C433D2;
        Tue, 16 May 2023 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684226401;
        bh=L//2mJqpJe73Cmk74amA5WtIVkNTK2EJMElKgY4Oifw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HllN8HjVjfHFg0iKJPiSZ+Ym2m9sd35ggzSOD6myB8PVaHbOVyxF9vNF6JCWqpRTd
         GSJ/qoF84U8qBkM6Ikskkgi5Wi7fwb6evjn/mrZFaEFSsjVf0hT6Mme9PThb3IbOc+
         5GgWXkL74/h9xy4Pn4WSCkjUysVIF4HnnjQgck9UN4x5uXA/qcAeZ/JeqYf+NHD241
         cuPjBVe8somRlu6CjRrMttWHt5XrMWYNQoz29dG21zk0PBGc1nbdF4r+wtNFSUo98C
         tVOxOBb40VoktDmsHMrLQksJZOBPtiZ3MKXTlG7Iq6IjIFJ2/nWFLZl7vxXmcIWa+z
         RXHLm6mijvu7g==
Date:   Tue, 16 May 2023 10:39:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, nicolas.dichtel@6wind.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Message-ID: <20230516-weltmeere-backofen-27f12ae2c9e0@brauner>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 05:23:12PM -0500, Mike Christie wrote:
> On 5/15/23 10:44 AM, Linus Torvalds wrote:
> > On Mon, May 15, 2023 at 7:23 AM Christian Brauner <brauner@kernel.org> wrote:
> >>
> >> So I think we will be able to address (1) and (2) by making vhost tasks
> >> proper threads and blocking every signal except for SIGKILL and SIGSTOP
> >> and then having vhost handle get_signal() - as you mentioned - the same
> >> way io uring already does. We should also remove the ingore_signals
> >> thing completely imho. I don't think we ever want to do this with user
> >> workers.
> > 
> > Right. That's what IO_URING does:
> > 
> >         if (args->io_thread) {
> >                 /*
> >                  * Mark us an IO worker, and block any signal that isn't
> >                  * fatal or STOP
> >                  */
> >                 p->flags |= PF_IO_WORKER;
> >                 siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
> >         }
> > 
> > and I really think that vhost should basically do exactly what io_uring does.
> > 
> > Not because io_uring fundamentally got this right - but simply because
> > io_uring had almost all the same bugs (and then some), and what the
> > io_uring worker threads ended up doing was to basically zoom in on
> > "this works".
> > 
> > And it zoomed in on it largely by just going for "make it look as much
> > as possible as a real user thread", because every time the kernel
> > thread did something different, it just caused problems.
> > 
> > So I think the patch should just look something like the attached.
> > Mike, can you test this on whatever vhost test-suite?
> 
> I tried that approach already and it doesn't work because io_uring and vhost
> differ in that vhost drivers implement a device where each device has a vhost_task
> and the drivers have a file_operations for the device. When the vhost_task's
> parent gets signal like SIGKILL, then it will exit and call into the vhost
> driver's file_operations->release function. At this time, we need to do cleanup

But that's no reason why the vhost worker couldn't just be allowed to
exit on SIGKILL cleanly similar to io_uring. That's just describing the
current architecture which isn't a necessity afaict. And the helper
thread could e.g., crash.

> like flush the device which uses the vhost_task. There is also the case where if
> the vhost_task gets a SIGKILL, we can just exit from under the vhost layer.

In a way I really don't like the patch below. Because this should be
solvable by adapting vhost workers. Right now, vhost is coming from a
kthread model and we ported it to a user worker model and the whole
point of this excercise has been that the workers behave more like
regular userspace processes. So my tendency is to not massage kernel
signal handling to now also include a special case for user workers in
addition to kthreads. That's just the wrong way around and then vhost
could've just stuck with kthreads in the first place.

So I'm fine with skipping over the freezing case for now but SIGKILL
should be handled imho. Only init and kthreads should get the luxury of
ignoring SIGKILL.

So, I'm afraid I'm asking some work here of you but how feasible would a
model be where vhost_worker() similar to io_wq_worker() gracefully
handles SIGKILL. Yes, I see there's

net.c:   .release = vhost_net_release
scsi.c:  .release = vhost_scsi_release
test.c:  .release = vhost_test_release
vdpa.c:  .release = vhost_vdpa_release
vsock.c: .release = virtio_transport_release
vsock.c: .release = vhost_vsock_dev_release

but that means you have all the basic logic in place and all of those
drivers also support the VHOST_RESET_OWNER ioctl which also stops the
vhost worker. I'm confident that a lof this can be leveraged to just
cleanup on SIGKILL.

So it feels like this should be achievable by adding a callback to
struct vhost_worker that get's called when vhost_worker() gets SIGKILL
and that all the users of vhost workers are forced to implement.

Yes, it is more work but I think that's the right thing to do and not to
complicate our signal handling.

Worst case if this can't be done fast enough we'll have to revert the
vhost parts. I think the user worker parts are mostly sane and are
useful.
Thoughts?
