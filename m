Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAFB6FD90E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbjEJIQx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 May 2023 04:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbjEJIQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:16:46 -0400
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632E810D8
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:16:41 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-44fdac26696so2163161e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683706600; x=1686298600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omCxiKh+FukCh4+vKAQHMDyFO8gvRPCEh1lBDqgPZGY=;
        b=fVHsAvScxpZeGZWxNzsM6gZGdgRfuhPktJI2MA2pe2doScRG77YUZyFbnf0p6CqEw+
         nEIdVMGyISPQXjxdGmWnU+L9+l1YMsq5sJHzpfelgfgrGL9Id3DRVOcsAxZmXP3D6II3
         DRebDVr7t/t8iF2rSG05H7atszmHEVfuJ+t6pQBSuoXB70qXQeAtkXcCnT2yjAkI7jdU
         D/TWZmSzAWOMuVzhMrP+JJXJ+Jh8yiUltDT9YkuFbXODwKIokfOVF4uvpQmJWNcUUMuj
         yZ9P9LegsKrGUWOYXyS2iOouvb/LrHJLmHBDf8SkfuxhOJlIvvTJH4n+apiOafMK7W0r
         pDUw==
X-Gm-Message-State: AC+VfDw22LMJ8rcbRjQBdypVlujCHyu3sg3Ibst2yPgu7L2/8wZF/X2j
        s3R3eHgHL/dDN9jJWuDaJPxu7NwoEFbvVvzJgvI=
X-Google-Smtp-Source: ACHHUZ4P/QSFbB6kLVNsz+Fuy8k1Sc6pmjQ8ieixMS7OV8VcNKxhzltj1u4k/1j1boRc/FznC+p4Wu91e3zs6y8Fas4=
X-Received: by 2002:a1f:bd0d:0:b0:44f:d2e3:1097 with SMTP id
 n13-20020a1fbd0d000000b0044fd2e31097mr5308498vkf.7.1683706600294; Wed, 10 May
 2023 01:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230425181827.219128101@linutronix.de> <20230425183312.932345089@linutronix.de>
 <ZFUXrCZtWyNG3Esi@lothringen> <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx>
 <878rdy32ri.ffs@tglx> <87v8h126p2.ffs@tglx> <875y911xeg.ffs@tglx> <87ednpyyeo.ffs@tglx>
In-Reply-To: <87ednpyyeo.ffs@tglx>
From:   Andrey Vagin <avagin@openvz.org>
Date:   Wed, 10 May 2023 01:16:26 -0700
Message-ID: <CANaxB-wV9iUT6=Y9nZCWbJhiscMrnAQh4fUXs7Tb8pr=-HwSYQ@mail.gmail.com>
Subject: Re: [RFD] posix-timers: CRIU woes
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Pavel Emelyanov <xemul@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 2:42 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Hi!
>
> This is a summary of several mails so that the CRIU people have the full
> picture.
>
> A recent syzbot report made me look at the timer ID management, which
> was modified 7 years ago to accomodate CRIU:
>
>     5ed67f05f66c ("posix timers: Allocate timer id per process (v2)")
>
> and introduced that reported issue along with a bogus loop termination
> problem. See
>
>     https://lore.kernel.org/lkml/000000000000a3723305f9d98fc3@google.com/
>     https://lore.kernel.org/lkml/20230425183312.932345089@linutronix.de
>
> for details.
>
> The intent to make the timer IDs per process is definitely correct, but
> the implementation is beyond suboptimal. I really regret that I did not
> catch this back then when picking those changes up.
>
> The way it works is that each process keeps a 'next_timer_id' which it
> uses to allocate the next timer. That allows CRIU to reconstruct timers
> with the same ID by walking the ID space via
>
>   do {
>      timer_create(&timer, ...., &id);
>      if (id == original_id)
>         goto success;
>      timer_delete(&timer);
>   } while (idspace_not_exhausted());
>
> That works by some definition of works, but it is problematic in two ways:
>
>  1) As the timer ID space is up to INT_MAX, a process which creates and
>     deletes timers frequently, can easily move up close to the INT_MAX
>     id space over time.
>
>     If such a process is checkpointed and restored, then the above loop
>     will run for at least an hour to restore a single timer.
>
>     And no, this is not only a hypothetical issue. There are legitimate
>     scenarios where threads are created and the control thread arms a
>     posix CPU timer on them. Such threads can be torn down on a regular
>     base due to thread pool consolidations. As CRIU does not happen
>     every 5 minutes it's not completely unlikely that such a process
>     surives quite some time on a particular host and thereby approaches
>     the ID space limit.
>
>     Sure we can restrict the ID space to a way smaller number so the
>     search wraps around earlier, but what's a sensible limit?
>
>     Though restricting the ID space has its own issue vs. backwards
>     compability. A process which created a timer on an older kernel with
>     an ID larger than the newer kernels ID limit cannot longer be
>     restored on that newer kernel.
>
>     Aside of that it does not solve the other problem this created:
>
>  2) That change created an user space ABI, which means that the kernel
>     side has to stick with this next ID search mechanism forever.
>
>     That prevents to get rid of that global lock and hash table by
>     sticking an xarray into task::signal which makes a lot of sense in
>     terms of cache locality and gets rid of the extra timer list
>     management in task::signal. Making this change would be very useful
>     to address some other issues in the posix-timer code without
>     creating yet more duct tape horrors.
>
>     Such a change obviously has to aim for a dense ID space to keep the
>     memory overhead low, but that breaks existing CRIU userspace because
>     dense ID space and next ID search does not fit together.
>
>     Next ID search is obviously creating non-recoverable holes in the
>     case that timers are deleted afterwards.
>
>     A dense ID space approach can create holes too, but they are
>     recoverable and well within the resource limits, because the process
>     has to be able to create enough timers in the first place in order
>     to release those in the middle.
>
>     With the next ID search brute force recovery is not possible on a
>     kernel with dense ID as there is no way to create all intermediate
>     timers first before reaching the one at the far end due to resource
>     limits.
>
> So because of that half thought out user space ABI we are now up the
> regression creek without a paddle, unless CRIU can accomodate to a
> different restore mechanism to lift this restriction from the kernel.
>
> Thoughts?

Hi Thomas,

If you give us a new API to create timers with specified id-s, we will
figure out how to live with it. It isn't good to ask users to update
CRIU to work on new kernels, but here are reasons and event improvements
for CRIU, so I think it's worth it.

As for API, we can use one bit of sigevent.sigev_notify to request a
timer with a specified id.

Thanks,
Andrei
