Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63E67083EE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjEROaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjEROaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D034B109
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 587E764FAF
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48B2C433EF;
        Thu, 18 May 2023 14:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684420220;
        bh=oiyruRYpa4OdZ9MvJ0BqTaOPeX7abBj/V2ECuKiAHTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQCyNToQWA0PBkCIvHDJvOFlnHYSAqhzue0w3F9toZhIybNycO+hhOe+qhjkg6pE0
         KE99qKFA4NlHCer8lpuT12QZ0gUmMMHCr8lKSm7dS0dmgYApd9E7BAX87jMNVujFik
         hsOjmMVGKPhDUtWyWWYUcArN8eTryMFHAZPCbDd4TGo6Tq4J4QdNiz7S1QnLb0P8ej
         Gx8sl8S8X8bwlvBiY6RnOS0l05eXzqIoxSX1jfuhr3mjK0v5gwtGmyF/bqvgovFEXE
         2va2f3UYVwgo4wiPAeovhBcYw6NG3+AvvLoWJlMd4Ghli+NQS05ssFb6LPPf/SHDK1
         /0y4f+ZLioLaw==
Date:   Thu, 18 May 2023 16:30:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [RFC PATCH 0/8] vhost_tasks: Use CLONE_THREAD/SIGHAND
Message-ID: <20230518-abserviert-netzwerk-fe9e028846f5@brauner>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518-appetit-aufsicht-238e950b97d6@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518-appetit-aufsicht-238e950b97d6@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Just two more thoughts:

The following places currently check for PF_IO_WORKER:

arch/x86/include/asm/fpu/sched.h: !(current->flags & (PF_KTHREAD | PF_IO_WORKER))) {
arch/x86/kernel/fpu/context.h:    if (WARN_ON_ONCE(current->flags & (PF_KTHREAD | PF_IO_WORKER)))
arch/x86/kernel/fpu/core.c:       if (!(current->flags & (PF_KTHREAD | PF_IO_WORKER)) &&

Both PF_KTHREAD and PF_IO_WORKER don't need TIF_NEED_FPU_LOAD because
they never return to userspace. But that's not specific to
PF_IO_WORKERs. Please generalize this to just check for PF_USER_WORKER
via a simple s/PF_IO_WORKER/PF_USER_WORKER/g in these places.

Another thing, in the sched code we have hooks into sched_submit_work()
and sched_update_worker() specific to PF_IO_WORKERs. But again, I don't
think this needs to be special to PF_IO_WORKERS. This might be
generally useful for PF_USER_WORKER. So we should probably generalize
this and have a generic user_worker_sleeping() and user_worker_running()
helper that figures out internally what specific helper to call. That's
not something that needs to be done right now though since I don't think
vhost needs this functionality.

But we should generalize this for the next development cycle so we have
this all nice and clean when someone actually needs this. Overall this
will mean that there would only be a single place left where
PF_IO_WORKER would need to be checked and that's in io_uring code
itself. And if we do things just right we might not even need that
PF_IO_WORKER flag anymore at all. But again, that's just notes for next
cycle.

Thoughts? Rotten apples?
