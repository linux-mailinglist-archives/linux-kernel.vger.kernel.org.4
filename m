Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409F968766F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBBHgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBBHgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:36:50 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02F290
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 23:36:48 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f34so1669911lfv.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 23:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jg67WxlKebtOZEkR8HkkEzTUQ4ni0YDxJ9W63Ptj/HU=;
        b=hbKKHV+Z/H52cWd1e6LzE7JZmXjETSK/5yBXDDMGKCstGImVbaR/49d/S1bK7jOATs
         RxyFRu1cennYC95IKwSjjA2Fsxwb6p16j4voL/8uGz2JF5Cnaw9vmoAOYt3YkwudL5wy
         IRARIuhZJ3a+XtzObwsRTkxj0CI+p3odLvk2r1MrO2M3vw+ppoqsilZl2gDgPrqkBTrr
         8YA3TAtaW3sgaByHqz8uoNqzLBo8VS05E8KQB85cTiJ0C95M//8MmYW4kimghCUt/Y8D
         m5xAer/aguXiVBqRMAUjubnY3uuawfkLrC8XHy4wnS2oJf5zYq1y2R2Ga06Jc6cRtFmS
         QWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jg67WxlKebtOZEkR8HkkEzTUQ4ni0YDxJ9W63Ptj/HU=;
        b=y10ZMJhGoX+x36wmRyr6G9T2xjNB+88ZBE/f2iWivCf6WilLNtiaVmXD3R2Nqq5tvi
         frNbcUBLkmpkbl8zoWJqrQZn56Cynn1EqiV8XBDnJ+AYjloRJ054LavGdkw9AGSIHBVY
         BC0ySUgaCQiwSE8q5QInNMmrm5FI+559xtTDeLbSJHeA5uRsujQYFk9EwXG19zZXia/e
         Gb1x8tjPzNrPpXRfmFOHyINkl6/TwUPHjXxxoflsvOSbY32TnDAFIw3H0wWZhHRsmNXG
         g8oiDK97KOK6PksPQMDu9YUrXZj3Wfq2gYemQgSgzBgF+3OPPwwav1c459o/9ROUSK4Y
         ZUOg==
X-Gm-Message-State: AO0yUKU4lZA2EDfhAUunNMqbGLOhF5YXnB1w/T6zkIDNA1Aj1FEFhlAD
        ueXNoSiqf4VlmOqoc5vgCiCrJuMjd6QCjNaxdFsvCA==
X-Google-Smtp-Source: AK7set+Ir/aY6xTBdYpreAsGZ8ou3PikuOS4pmfqKn+hF8jkWTYLyi7AHhqKwo0yRwrHmoMhl3d45t1pQ+mhipp0Fko=
X-Received: by 2002:ac2:5208:0:b0:4cb:e97:c4ff with SMTP id
 a8-20020ac25208000000b004cb0e97c4ffmr967379lfl.101.1675323406750; Wed, 01 Feb
 2023 23:36:46 -0800 (PST)
MIME-Version: 1.0
References: <20230126105128.2249938-1-dvyukov@google.com> <20230126154118.2393850-1-dvyukov@google.com>
 <CANpmjNM=PVigDZKu-H_-cLECUJKSx7TH+kxSjfF=4UHdrGBj+g@mail.gmail.com>
 <87o7qlgjce.ffs@tglx> <CACT4Y+aMLeCo9+nwXrFWo8FLG8rKHDe8v2ppkZ+mOaKAF6qtgw@mail.gmail.com>
In-Reply-To: <CACT4Y+aMLeCo9+nwXrFWo8FLG8rKHDe8v2ppkZ+mOaKAF6qtgw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 2 Feb 2023 08:36:34 +0100
Message-ID: <CACT4Y+ZKEHfg7M5QW3jDLPjxUmU6mFF8r+yb2Zb77_kL13NnqQ@mail.gmail.com>
Subject: Re: [PATCH v4] posix-timers: Prefer delivery of signals to the
 current thread
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marco Elver <elver@google.com>, oleg@redhat.com,
        linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>
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

,On Fri, 27 Jan 2023 at 07:58, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, 26 Jan 2023 at 20:57, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Thu, Jan 26 2023 at 18:51, Marco Elver wrote:
> > > On Thu, 26 Jan 2023 at 16:41, Dmitry Vyukov <dvyukov@google.com> wrote:
> > >>
> > >> Prefer to deliver signals to the current thread if SIGEV_THREAD_ID
> > >> is not set. We used to prefer the main thread, but delivering
> > >> to the current thread is both faster, and allows to sample actual thread
> > >> activity for CLOCK_PROCESS_CPUTIME_ID timers, and does not change
> > >> the semantics (since we queue into shared_pending, all thread may
> > >> receive the signal in both cases).
> > >
> > > Reviewed-by: Marco Elver <elver@google.com>
> > >
> > > Nice - and and given the test, hopefully this behaviour won't regress in future.
> >
> > The test does not tell much. It just waits until each thread got a
> > signal once, which can take quite a while. It does not tell about the
> > distribution of the signals, which can be completely randomly skewed
> > towards a few threads.
> >
> > Also for real world use cases where you have multiple threads with
> > different periods and runtime per period I have a hard time to
> > understand how that signal measures anything useful.
> >
> > The most time consuming thread might actually trigger rarely while other
> > short threads end up being the ones which cause the timer to fire.
> >
> > What's the usefulness of this information?
> >
> > Thanks,
> >
> >         tglx
>
> Hi Thomas,
>
> Our goal is to sample what threads are doing in production with low
> frequency and low overhead. We did not find any reasonable existing
> way of doing it on Linux today, as outlined in the RFC version of the
> patch (other solutions are either much more complex and/or incur
> higher memory and/or CPU overheads):
> https://lore.kernel.org/all/20221216171807.760147-1-dvyukov@google.com/
>
> This sampling does not need to be 100% precise as CPU profilers would
> require, getting high precision generally requires more complexity and
> overheads. The accent is on use in production and low overhead.
> Consider we sample with O(seconds) interval, so some activities can
> still be unsampled whatever we do here (if they take <second). But on
> the other hand the intention is to use this over billions of CPU
> hours. So on the global scale we still observe more-or-less
> everything.
>
> Currently all signals are practically delivered to the main thread and
> the added test does not pass (at least I couldn't wait long enough).
> After this change the test passes quickly (within a second for me).
> Testing the actual distribution without flaky failures is very hard in
> unit tests. After rounds of complaints and deflaking they usually
> transform into roughly what this test is doing -- all threads are
> getting at least something.
> If we want to test ultimate fairness, we would need to start with the
> scheduler itself. If threads don't get fair fractions, then signals
> won't be evenly distributed as well. I am not sure if there are unit
> tests for the scheduler that ensure this in all configurations (e.g.
> uneven ratio of runnable threads to CPUs, running in VMs, etc).
> I agree this test is not perfect, but as I said, it does not pass now.
> So it is useful and will detect a future regression in this logic. It
> ensures that running threads eventually get signals.
>
> But regardless of our motivation, this change looks like an
> improvement in general. Consider performance alone (why would we wake
> another thread, maybe send an IPI, evict caches). Sending the signal
> to the thread that overflowed the counter also looks reasonable. For
> some programs it may actually give a good picture. Say thread A is
> running for a prolonged time, then thread B is running. The program
> will first get signals in thread A and then in thread B (instead of
> getting them on an unrelated thread).



Hi Thomas,

Has this answered your question? Do you have any other concerns?
If not, please take this into some tree for upstreamming.

Thanks
