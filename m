Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBAD719A12
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjFAKr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjFAKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:47:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59189D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:47:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4208C63921
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD4AC433D2;
        Thu,  1 Jun 2023 10:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685616445;
        bh=41eM8QuP5hVSTNUbOJRPYeeJz1S6tM92155sWldxvGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FFMfJ9I9UJVVpM/e48PslhY1OAVu1m4Xh9fkMnnfAlVOkb5WYOc03pJXM7+F0mLir
         3uEAr5WNdddTdIISBtWxOfQa64M3DaHh5rXi2jTGpYmWkbztJn9nze6/kn9LmD7Lua
         JHK3zY2+Po46Syw7GpuJTu4H+5T3O3+sLHDEjl/nsOkWL2aJfIzIhCY5X6OFmZAM0Z
         ZM+GFsCnOYZn4S8JJsSBKK/UZv+XEb8sXUlc6Kd2al0/xsxPjaMTeEd1+rnSWSYR/0
         nC/pgUMw/6M1kqeh6MM9tDxzdF0PFOWKmxfwszRQsutuif4VUilZ/RaNtlSRKUtlSZ
         FjuFBT7LNBGPA==
Date:   Thu, 1 Jun 2023 12:47:19 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Mike Christie <michael.christie@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     oleg@redhat.com, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        hch@infradead.org, konrad.wilk@oracle.com
Subject: Re: [RFC PATCH 0/8] vhost_tasks: Use CLONE_THREAD/SIGHAND
Message-ID: <20230601-herzallerliebst-dschungel-4515db351a0c@brauner>
References: <20230519-vormittag-dschungel-83607e9d2255@brauner>
 <ab8c9f95-c9e9-de04-4e28-78163a32da80@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab8c9f95-c9e9-de04-4e28-78163a32da80@leemhuis.info>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 09:58:38AM +0200, Thorsten Leemhuis wrote:
> On 19.05.23 14:15, Christian Brauner wrote:
> > On Thu, May 18, 2023 at 10:25:11AM +0200, Christian Brauner wrote:
> >> On Wed, May 17, 2023 at 07:09:12PM -0500, Mike Christie wrote:
> >>> This patch allows the vhost and vhost_task code to use CLONE_THREAD,
> >>> CLONE_SIGHAND and CLONE_FILES. It's a RFC because I didn't do all the
> >>> normal testing, haven't coverted vsock and vdpa, and I know you guys
> >>> will not like the first patch. However, I think it better shows what
> >>
> >> Just to summarize the core idea behind my proposal is that no signal
> >> handling changes are needed unless there's a bug in the current way
> >> io_uring workers already work. All that should be needed is
> >> s/PF_IO_WORKER/PF_USER_WORKER/ in signal.c.
> [...]
> >> So it feels like this should be achievable by adding a callback to
> >> struct vhost_worker that get's called when vhost_worker() gets SIGKILL
> >> and that all the users of vhost workers are forced to implement.
> >>
> >> Yes, it is more work but I think that's the right thing to do and not to
> >> complicate our signal handling.
> >>
> >> Worst case if this can't be done fast enough we'll have to revert the
> >> vhost parts. I think the user worker parts are mostly sane and are
> > 
> > As mentioned, if we can't settle this cleanly before -rc4 we should
> > revert the vhost parts unless Linus wants to have it earlier.
> 
> Meanwhile -rc5 is just a few days away and there are still a lot of
> discussions in the patch-set proposed to address the issues[1]. Which is
> kinda great (albeit also why I haven't given it a spin yet), but on the
> other hand makes we wonder:

You might've missed it in the thread but it seems everyone is currently
operating under the assumption that the preferred way is to fix this is
rather than revert. See the mail in [1]:

"So I'd really like to finish this. Even if we end up with a hack or
two in signal handling that we can hopefully fix up later by having
vhost fix up some of its current assumptions."

which is why no revert was send for -rc4. And there's a temporary fix we
seem to have converged on.

@Mike, do you want to prepare an updated version of the temporary fix.
If @Linus prefers to just apply it directly he can just grab it from the
list rather than delaying it. Make sure to grab a Co-developed-by line
on this, @Mike.

Just in case we misunderstood the intention, I also prepared a revert
at the end of this mail that Linus can use.

@Thorsten, you can test it if you want. The revert only reverts the
vhost bits as the general agreement seems to be that user workers are
otherwise the path forward.

[1]: https://lore.kernel.org/lkml/CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com

---

/* Summary */
Switching vhost workers to user workers broke existing workflows because
vhost workers started showing up in ps output breaking various scripts.
The reason is that vhost user workers are currently spawned as separate
processes and not as threads. Revert the patches converting vhost from
kthreads to vhost workers until vhost is ready to support user workers
created as actual threads.

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/kernel/v6.4-rc4/vhost

for you to fetch changes up to b20084b6bc90012a8ccce72ef1c0050d5fd42aa8:

  Revert "vhost_task: Allow vhost layer to use copy_process" (2023-06-01 12:33:19 +0200)

----------------------------------------------------------------
kernel/v6.4-rc4/vhost

----------------------------------------------------------------
Christian Brauner (3):
      Revert "vhost: use vhost_tasks for worker threads"
      Revert "vhost: move worker thread fields to new struct"
      Revert "vhost_task: Allow vhost layer to use copy_process"

 MAINTAINERS                      |   1 -
 drivers/vhost/Kconfig            |   5 --
 drivers/vhost/vhost.c            | 124 ++++++++++++++++++++-------------------
 drivers/vhost/vhost.h            |  11 +---
 include/linux/sched/vhost_task.h |  23 --------
 kernel/Makefile                  |   1 -
 kernel/vhost_task.c              | 117 ------------------------------------
 7 files changed, 67 insertions(+), 215 deletions(-)
 delete mode 100644 include/linux/sched/vhost_task.h
 delete mode 100644 kernel/vhost_task.c
