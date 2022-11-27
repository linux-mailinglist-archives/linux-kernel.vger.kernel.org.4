Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA8D639935
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 03:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiK0Cpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 21:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiK0Cpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 21:45:47 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC8215723
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 18:45:46 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 6so7000925pgm.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 18:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ppae8YkGxihHdolp7H9Ytm/fuY6Yp4IGxdByEhiVIp0=;
        b=O2xOwuAqWd42vmpaztCU+N0Zt7qwCJ+HxM+oeF/R/Gj78hawuSuBKUWUiUq7nriKCE
         LXgj9dd2Y8h6yoGZ98JNK9rt2CFthOzB9ISvDyTsm996HEY84YepKQ1lmA3YKTGbqdfS
         mZYY3HcYNv+rwoedu1KmAvTk9QCvqoATnvSwbk8KhsqeTscHgGX9mujcI5woUWdPOMEs
         4CCoP/7Ov1iBFRXxGUv6s2OlEGFERatM1Gdb5Oa+k2sM4c0A6+b6jO3vxTs8rcRfRCW8
         M22qGsW3PQAJ6X6AY74nYB2fn3GraeQtDLGqaZkcLvU8YBFhVjvAnC3tcNli0r+YBO5N
         bzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppae8YkGxihHdolp7H9Ytm/fuY6Yp4IGxdByEhiVIp0=;
        b=N3X2LlEIlmWyViRrJ7HyFu6i36FAlKd1xt4HhNSOSlMVOmtl7C+KQISGr4i34I+rDZ
         FvWhnFxujzGsUjMy6an+dsjd1FeipHvzrn/kTuaUzV+VcePsH4eFA/INPLGCsJ7JG5HA
         KsQ6iBbEbVTM5hQbz3yZjx1MMJ1nwXy63U2iIC+Z1daQOYEFmovcPyMtZsN+s1j1Gnb0
         ZuGDtbjVG42r2QHeuLg3GRBJRgCzLxY+cI9I5mfQ6Zxj/m6KdmPLWEa13DOthDFfnxa9
         CVvtkvBQISZ1OO1+3/Mcp86y1BBFyUSK/XHskrbx/teKFevVdM9bJF83pxvy2+zsNl1z
         pMPg==
X-Gm-Message-State: ANoB5pluyW5qMgxFCLOF9LNST/A3cK0oJUeUJXToGZAQoumlLpP4jFcq
        trzQZIQYLPVH8X62Rp1JEpzul4nILwBWarv3vYhYOHg5/lcJnQ==
X-Google-Smtp-Source: AA0mqf6YciwvlYw43Lh0nHr5XuZ1gXzzHQykeXjeIoYNZhlpSYxSR4xj6cT/+28H978gFdAz/Dp8UCqc83Ro3cy9dEM=
X-Received: by 2002:a65:45ce:0:b0:44b:2928:f868 with SMTP id
 m14-20020a6545ce000000b0044b2928f868mr31009871pgr.384.1669517145674; Sat, 26
 Nov 2022 18:45:45 -0800 (PST)
MIME-Version: 1.0
References: <20221121035140.118651-1-zhouzhouyi@gmail.com> <87y1rxwsse.ffs@tglx>
In-Reply-To: <87y1rxwsse.ffs@tglx>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sun, 27 Nov 2022 10:45:34 +0800
Message-ID: <CAABZP2xNTbrx9iV+KH3VZx1c9Yi97+izNA=XSJQBuOJ4WENFZg@mail.gmail.com>
Subject: Re: [PATCH linux-next][RFC]torture: avoid offline tick_do_timer_cpu
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     fweisbec@gmail.com, mingo@kernel.org, dave@stgolabs.net,
        paulmck@kernel.org, josh@joshtriplett.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank Thomas for your guidance

On Sun, Nov 27, 2022 at 1:05 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, Nov 21 2022 at 11:51, Zhouyi Zhou wrote:
> > During CPU-hotplug torture (CONFIG_NO_HZ_FULL=y), if we try to
> > offline tick_do_timer_cpu, the operation will fail because in
> > function tick_nohz_cpu_down:
> > ```
> > if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
> >       return -EBUSY;
> > ```
> > Above bug was first discovered in torture tests performed in PPC VM
>
> How is this a bug?
Yes, this is a false positive instead.
>
> > of Open Source Lab of Oregon State University, and reproducable in RISC-V
> > and X86-64 (with additional kernel commandline cpu0_hotplug).
> >
> > In this patch, we avoid offline tick_do_timer_cpu by distribute
> > the offlining cpu among remaining cpus.
>
> Please read Documentation/process. Search for 'this patch'...
Documentation/process/submitting-patches.rst says:
"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."

So, I should construct my patch as:
We avoid ... by ...
>
> >
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > ---
> >  include/linux/tick.h        |  1 +
> >  kernel/time/tick-common.c   |  1 +
> >  kernel/time/tick-internal.h |  1 -
> >  kernel/torture.c            | 10 ++++++++++
> >  4 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > index bfd571f18cfd..23cc0b205853 100644
> > --- a/include/linux/tick.h
> > +++ b/include/linux/tick.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/rcupdate.h>
> >
> >  #ifdef CONFIG_GENERIC_CLOCKEVENTS
> > +extern int tick_do_timer_cpu __read_mostly;
> >  extern void __init tick_init(void);
> >  /* Should be core only, but ARM BL switcher requires it */
> >  extern void tick_suspend_local(void);
> > diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> > index 46789356f856..87b9b9afa320 100644
> > --- a/kernel/time/tick-common.c
> > +++ b/kernel/time/tick-common.c
> > @@ -48,6 +48,7 @@ ktime_t tick_next_period;
> >   *    procedure also covers cpu hotplug.
> >   */
> >  int tick_do_timer_cpu __read_mostly = TICK_DO_TIMER_BOOT;
> > +EXPORT_SYMBOL_GPL(tick_do_timer_cpu);
>
> No. We are not exporting this just to make a bogus test case happy.
>
> Fix the torture code to handle -EBUSY correctly.
I am going to do a study on this, for now, I do a grep in the kernel tree:
find . -name "*.c"|xargs grep cpuhp_setup_state|wc -l
The result of the grep command shows that there are 268
cpuhp_setup_state* cases.
which may make our task more complicated.

After my study, should we also take Frederic's proposal as a possible option?
(construct a function for this)
https://lore.kernel.org/lkml/20221123223658.GC1395324@lothringen/

I learned a lot during this process
Many thanks
Zhouyi
>
> Thanks,
>
>         tglx
