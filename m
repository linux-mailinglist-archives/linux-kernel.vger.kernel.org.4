Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4426743F7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjASVJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjASVJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:09:14 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA62117CC1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:01:56 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l8so2508760wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r/D5AFaWAhCR0gGYjljSteRmQs5Q9XOUZKCf6TA7Htc=;
        b=aH17Bd8bL7rFIslBv9Dgred+WzvkeFtC0MYX6E4BUgAyNx7g4pGkE8Oa4r22RN/DE6
         EDHKLNTs6t7hdcXXs4pg/9v3Zkpsb8OELYsZyd2+IgmQCQBz1FeunTMQsbRAjv2D9PnF
         OekoImj0rppOW6G9NUtR+e5GdrV06hzZnffn2sRT4xjRdTY1s63hFlBQ5v9nbPXg6vmo
         diYQhcvUjoKY6e0HZsRDyFNnHHKPr/CJbjM1u3uNBjvzTaUcOTSmvPa3z/kZYpnC7q0j
         excR0qFH0HyxJBjpAzQZTPQiCoP/yxo7z5ZiJkqtBceWiMwVibpg362WHhYgCIzJtNH0
         xp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/D5AFaWAhCR0gGYjljSteRmQs5Q9XOUZKCf6TA7Htc=;
        b=iCQnvuACC4gfQe1uTgUKyHRoCCJrRK0dzHXQ/4E1uKQxzx5xrbUkW3WkmEOUO66NfV
         xox+ZQUPNxX/grvlKiBaGceZwTZoV6adXb7+DskUIY/wumU25UDhgFsHirFqUa7XQ9vk
         ufGXUQEmLXVW+t731jq8N28LiG8vzLrggyKF7fAlPXIBZi1ilJSBJVQTLJNYuvKCbErm
         e9A++TRksCWg/nY56BmGbNixmIGey0fHPTHOcY+oHjFDEH3k+rFBp7z3WejViTs7f+xc
         xy3CruRi7wJiIY01sfVrH610XLvS65/rKxKZ0a0xMaXx1+kFunvqNwwLaiDWWrzfEqWL
         CE5Q==
X-Gm-Message-State: AFqh2kof70OqzGyMB5dW0b8TkgQcVynu5mQ8VYEA4bgJorWqvA6LOM9R
        A+CBpsTI9+8Yuyu38XVH7W9UWDIgMLIUslt5VS2rOg==
X-Google-Smtp-Source: AMrXdXuu+5oCXCZTe3GScRYJj9HvrrlyBhSpeEBW9O7MNtGBeWkn0umByLsXQZHm2KSZi2VagZgEmsnC9im4jvqRhWk=
X-Received: by 2002:a05:600c:3412:b0:3d0:a619:c445 with SMTP id
 y18-20020a05600c341200b003d0a619c445mr518591wmp.17.1674162115239; Thu, 19 Jan
 2023 13:01:55 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpEMEsSYcKakFiDK=QV+apW-2baLcUcw7uRyrmKkWVnR8A@mail.gmail.com>
 <20230113022555.2467724-1-kamatam@amazon.com> <CAJuCfpEH7kC=S8S_SRLW-X483kpaL4xdn5b35Ou08V7b56QdJA@mail.gmail.com>
 <CAJuCfpHV2-pnHd6U3paA1fO2gaYP1RTqAJwp_5QC7C2YR3JG5g@mail.gmail.com>
In-Reply-To: <CAJuCfpHV2-pnHd6U3paA1fO2gaYP1RTqAJwp_5QC7C2YR3JG5g@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 19 Jan 2023 13:01:42 -0800
Message-ID: <CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru==MdEHQg@mail.gmail.com>
Subject: Re: another use-after-free in ep_remove_wait_queue()
To:     Munehisa Kamata <kamatam@amazon.com>, Tejun Heo <tj@kernel.org>
Cc:     ebiggers@kernel.org, hannes@cmpxchg.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mengcc@amazon.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 7:06 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, Jan 13, 2023 at 9:52 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Jan 12, 2023 at 6:26 PM Munehisa Kamata <kamatam@amazon.com> wrote:
> > >
> > > On Thu, 2023-01-12 22:01:24 +0000, Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Mon, Jan 9, 2023 at 7:06 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > >
> > > > > On Mon, Jan 9, 2023 at 5:33 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > >
> > > > > > On Sun, Jan 8, 2023 at 3:49 PM Hillf Danton <hdanton@sina.com> wrote:
> > > > > > >
> > > > > > > On 8 Jan 2023 14:25:48 -0800 PM Munehisa Kamata <kamatam@amazon.com> wrote:
> > > > > > > >
> > > > > > > > That patch survived the repro in my original post, however, the waker
> > > > > > > > (rmdir) was getting stuck until a file descriptor of the epoll instance or
> > > > > > > > the pressure file got closed. So, if the following modified repro runs
> > > > > > > > with the patch, the waker never returns (unless the sleeper gets killed)
> > > > > > > > while holding cgroup_mutex. This doesn't seem to be what you expected to
> > > > > > > > see with the patch, does it? Even wake_up_all() does not appear to empty
> > > > > > > > the queue, but wake_up_pollfree() does.
> > > > > > >
> > > > > > > Thanks for your testing. And the debugging completes.
> > > > > > >
> > > > > > > Mind sending a patch with wake_up_pollfree() folded?
> > > > > >
> > > > > > I finally had some time to look into this issue. I don't think
> > > > > > delaying destruction in psi_trigger_destroy() because there are still
> > > > > > users of the trigger as Hillf suggested is a good way to go. Before
> > > > > > [1] correct trigger destruction was handled using a
> > > > > > psi_trigger.refcount. For some reason I thought it's not needed
> > > > > > anymore when we placed one-trigger-per-file restriction in that patch,
> > > > > > so I removed it. Obviously that was a wrong move, so I think the
> > > > > > cleanest way would be to bring back the refcounting. That way the last
> > > > > > user of the trigger (either psi_trigger_poll() or psi_fop_release())
> > > > > > will free the trigger.
> > > > > > I'll check once more to make sure I did not miss anything and if there
> > > > > > are no objections, will post a fix.
> > > > >
> > > > > Uh, I recalled now why refcounting was not helpful here. I'm making
> > > > > the same mistake of thinking that poll_wait() blocks until the call to
> > > > > wake_up() which is not the case. Let me think if there is anything
> > > > > better than wake_up_pollfree() for this case.
> > > >
> > > > Hi Munehisa,
> > > > Sorry for the delay. I was trying to reproduce the issue but even
> > > > after adding a delay before ep_remove_wait_queue() it did not happen.
> > >
> > > Hi Suren,
> > >
> > > Thank you for your help here.
> > >
> > > Just in case, do you have KASAN enabled in your config? If not, this may
> > > just silently corrupt a certain memory location and not immediately
> > > followed by obvious messages or noticeable event like oops.
> >
> > Yes, KASAN was enabled in my build.
> >
> > >
> > > > One thing about wake_up_pollfree() solution that does not seem right
> > > > to me is this comment at
> > > > https://elixir.bootlin.com/linux/latest/source/include/linux/wait.h#L253:
> > > >
> > > > `In the very rare cases where a ->poll() implementation uses a
> > > > waitqueue whose lifetime is tied to a task rather than to the 'struct
> > > > file' being polled, this function must be called before the waitqueue
> > > > is freed...`
> > > >
> > > > In our case we free the waitqueue from cgroup_pressure_release(),
> > > > which is the handler for `release` operation on cgroup psi files. The
> > > > other place calling psi_trigger_destroy() is psi_fop_release(), which
> > > > is also tied to the lifetime to the psi files.  Therefore the lifetime
> > > > of the trigger's waitqueue is tied to the lifetime of the files and
> > > > IIUC, we should not be required to use wake_up_pollfree().
> > > > Could you please post your .config file? I might be missing some
> > > > configuration which prevents the issue from happening on my side.
> > >
> > > Sure, here is my config.
> > >
> > >  https://gist.github.com/kamatam9/a078bdd9f695e7a0767b061c60e48d50
> > >
> > > I confirmed that it's reliably reproducible with v6.2-rc3 as shown below.
> > >
> > >  https://gist.github.com/kamatam9/096a79cf59d8ed8785c4267e917b8675
> >
> > Thanks! I'll try to figure out the difference.
>
> Sorry for the slow progress on this issue. I'm multiplexing between
> several tasks ATM but I did not forget about this one.
> Even though I still can't get the kasan UAF report, I clearly see the
> wrong order when tracing these functions and forcing the delay before
> ep_remove_wait_queue(). I don't think that should be happening, so
> something in the release process I think needs fixing. Will update
> once I figure out the root cause, hopefully sometime this week.

Hi Folks,
I spent some more time digging into the details and this is what's
happening. When we call rmdir to delete the cgroup with the pressure
file being epoll'ed, roughly the following call chain happens in the
context of the shell process:

do_rmdir
  cgroup_rmdir
    kernfs_drain_open_files
      cgroup_file_release
        cgroup_pressure_release
          psi_trigger_destroy

Later on in the context of our reproducer, the last fput() is called
causing wait queue removal:

fput
  ep_eventpoll_release
    ep_free
      ep_remove_wait_queue
        remove_wait_queue

By this time psi_trigger_destroy() already destroyed the trigger's
waitqueue head and we hit UAF.
I think the conceptual problem here (or maybe that's by design?) is
that cgroup_file_release() is not really tied to the file's real
lifetime (when the last fput() is issued). Otherwise fput() would call
eventpoll_release() before f_op->release() and the order would be fine
(we would remove the wait queue first in eventpoll_release() and then
f_op->release() would cause trigger's destruction).
Considering these findings, I think we can use the wake_up_pollfree()
without contradicting the comment at
https://elixir.bootlin.com/linux/latest/source/include/linux/wait.h#L253
because indeed, cgroup_file_release() and therefore
psi_trigger_destroy() are not tied to the file's lifetime.

I'm CC'ing Tejun to check if this makes sense to him and
cgroup_file_release() is working as expected in this case.

Munehisha, if Tejun confirms this is all valid, could you please post
a patch replacing wake_up_interruptible() with wake_up_pollfree()? We
don't need to worry about wake_up_all() because we have a limitation
of one trigger per file descriptor:
https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L1419,
so there can be only one waiter.
Thanks,
Suren.


>
>
> > Suren.
> >
> > >
> > >
> > > Regards,
> > > Munehisa
> > >
> > >
> > > > Thanks,
> > > > Suren.
> > > >
> > > > >
> > > > >
> > > > > >
> > > > > > [1] https://lore.kernel.org/lkml/20220111232309.1786347-1-surenb@google.com/
> > > > > >
> > > > > > Thanks,
> > > > > > Suren.
> > > > > >
> > > > > > >
> > > > > > > Hillf
> > > >
> > > >
