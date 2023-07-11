Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D5B74F811
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjGKSix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGKSiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:38:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC0510F0;
        Tue, 11 Jul 2023 11:38:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b9cd6a0051so20298855ad.1;
        Tue, 11 Jul 2023 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689100730; x=1691692730;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gNrGulHqwLQXaAn5lL1h5AYMqRTSStR67krFxwljyEM=;
        b=GpWZkJjRB5b4mvQiDzQRbSbsEi1mRQx7+zpvkOfOMnJltoqtOgNEcRHs0eQ4+TLlRO
         6AtcyxaY9uzlxCgZf59rv35x7htVSozVFOAQdPob0dwcFfQiJ1wPipBr0k5XVYn8kqHF
         qXp433woeA6mhTi3e9q3AK7nlEFEi6/sMcP9vHf2M7iPe25Jw1kw+j1HmX98ev2vAcYa
         8Q4Gqw19x/El5eSBKjg/DRDBSxUmGPoH3jNmJUvp4e+niwzEGzYE5oXljgAwKAAQ1K1j
         lXiFLFtNSgw6zEoU//zh6gCaIQIdbpujk5vb9XlnN70/R2CBSjBxqO+1UCVWXiEqmMqO
         opig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689100730; x=1691692730;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNrGulHqwLQXaAn5lL1h5AYMqRTSStR67krFxwljyEM=;
        b=j6q8XVrndXMcI3vNBsGiawA60epOli/+uM1KF+vfTlIgP/H9KbUncH/WJXPLVDSAEL
         hvY8wbu9vfDoCsJ84zm+q6ilmC6mkulziZkyk4fSTm4sp5TXJBdW0azlyPv3KexpfYcp
         XnblgRaov1dYBh6i5nPWRpCpHzVbAg07Cix3xvtZz/6n3F7c3I80mhMVZjc0lPvGyZRn
         0mlKm7LJlHGBFKkCicKfPbx8uwtlERj6IY2P7OZxhiCi902oKhjYxMFiNTDtNKPKelNO
         YRJCjQFV45+r0JaYZNZ8KoeMgI4O3goSLQrRzo0XH6MTW8ObxQRwvShAvqicjAwH1rXJ
         oOWg==
X-Gm-Message-State: ABy/qLaGeZjgKwffvrFdwxUdWH9TdoblRvN7wvPno+ffijPRRWi1/2UX
        +nuDucKVw/iZwKMttamBZ/w=
X-Google-Smtp-Source: APBJJlEirM0WibpPlnBkJckQB3C0by+Ewx1LebY77M2JJMGav07jVUdYBRANj9Jh3yXCI0qR+hBYQg==
X-Received: by 2002:a17:902:c410:b0:1b9:ce7a:88b4 with SMTP id k16-20020a170902c41000b001b9ce7a88b4mr10820632plk.42.1689100729797;
        Tue, 11 Jul 2023 11:38:49 -0700 (PDT)
Received: from j293.lan ([2400:4051:ea3:5910:5676:1078:8b85:c18f])
        by smtp.gmail.com with ESMTPSA id jw20-20020a170903279400b001aaecc0b6ffsm2269296plb.160.2023.07.11.11.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 11:38:49 -0700 (PDT)
Date:   Wed, 12 Jul 2023 03:38:45 +0900
From:   Kazuki H <kazukih0205@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Hector Martin <marcan@marcan.st>,
        Kazuki Hashimoto <kazukih0205@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PM: s2idle: Fully prevent the system from entering
 s2idle when cpuidle isn't supported
Message-ID: <dd5ajvkn5leu3m6gy7jeiwquoslv6ysiq52fzwhudqlzhtsc47@5jmw337kij3p>
References: <20230711-cpuidle-v1-0-f391224b3140@gmail.com>
 <20230711-cpuidle-v1-2-f391224b3140@gmail.com>
 <CAJZ5v0hBJoCHk_hFN2unez+Qi9v_zAFCZHXHa=Rb95pCFRLk6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hBJoCHk_hFN2unez+Qi9v_zAFCZHXHa=Rb95pCFRLk6g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 07:55:46PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 11, 2023 at 7:54 AM Kazuki Hashimoto <kazukih0205@gmail.com> wrote:
> >
> > In order for systems to properly enter s2idle, we need functions both in
> > the idle subsystem (such as call_cpuidle_s2idle()) and the suspend subsystem
> > to be executed.
> >
> > s2idle got blocked in the idle subsystem on platforms without cpuidle after
> > commit ef2b22ac540c ("cpuidle / sleep: Use broadcast timer for states that stop
> > local timer").
> 
> What do you mean by "blocked in the idle subsystem"?
There is a check in kernel/sched/idle.c which determines whether cpuidle
is enabled. If that isn't the case, functions necessary for s2idle don't
get executed. Here's a snippet of the code:

        if (cpuidle_not_available(drv, dev)) {
                tick_nohz_idle_stop_tick();

                default_idle_call();
                goto exit_idle;
        }

        /*
         * Suspend-to-idle ("s2idle") is a system state in which all user space
         * has been frozen, all I/O devices have been suspended and the only
         * activity happens here and in interrupts (if any). In that case bypass
         * the cpuidle governor and go straight for the deepest idle state
         * available.  Possibly also suspend the local tick and the entire
         * timekeeping to prevent timer interrupts from kicking us out of idle
         * until a proper wakeup interrupt happens.
         */

        if (idle_should_enter_s2idle() || dev->forced_idle_latency_limit_ns) {
                u64 max_latency_ns;

                if (idle_should_enter_s2idle()) {

                        entered_state = call_cpuidle_s2idle(drv, dev);
                        if (entered_state > 0)
                                goto exit_idle;

                        max_latency_ns = U64_MAX;
                } else {
                        max_latency_ns = dev->forced_idle_latency_limit_ns;
                }

                tick_nohz_idle_stop_tick();

                next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
                call_cpuidle(drv, dev, next_state);
        } else {
                bool stop_tick = true;

                /*
                 * Ask the cpuidle framework to choose a convenient idle state.
                 */
                next_state = cpuidle_select(drv, dev, &stop_tick);

                if (stop_tick || tick_nohz_tick_stopped())
                        tick_nohz_idle_stop_tick();
                else
                        tick_nohz_idle_retain_tick();

                entered_state = call_cpuidle(drv, dev, next_state);
                /*
                 * Give the governor an opportunity to reflect on the outcome
                 */
                cpuidle_reflect(dev, entered_state);
        }

exit_idle:
        __current_set_polling();

        /*
         * It is up to the idle functions to reenable local interrupts
         */
        if (WARN_ON_ONCE(irqs_disabled()))
                local_irq_enable();
> 
> > However, the suspend subsystem doesn't have this, which can cause
> > the suspend subsystem to begin entering s2idle behind the idle subsystem's back,
> 
> What do you mean by this?
The suspend subsystem doesn't have the check which determines whether
cpuidle is enabled or not. Therefore, the suspend subsystem can put the
system into s2idle even though functions necessary for s2idle in the
idle subsystem hasn't been executed.
> 
> > which in turn can cause the system to enter s2idle even though all the functions
> > necessary for s2idle hasn't been executed, breaking the system
> > (e.g. ClOCK_MONOTONIC keeps ticking during suspend even though it's not supposed
> > to).
> 
> Why is this a problem?
There are programs such as systemd, which depend on CLOCK_MONOTONIC
being paused during suspend as outlined here:

> > It increases by the slept time (1min + some seconds required to suspend/wakeup).
> Well, it's really not supposed to. The monotonic clock (CLOCK_MONOTONIC) is supposed
> to pause while the system is suspended. If it continues running then what you are
> seeing is kinda expected, because nothing will be scheduled while the system is
> suspended.
>
> The python test I gave you is entirely independent from systemd, this means this is
> a bug within your kernel, and your kernel only. Please report this to your distro's
> kernel packaging team, there's nothing we can do about this. CLOCK_MONOTONIC is
> supposed to pause during suspend (and CLOCK_BOOTTIME is supposed to continue), and
> if this doesn't work then this is something that has to be fixed in the kernel.

> (Some pre-release kernels carried some patches that broke CLOCK_MONOTONIC and made
> it work like CLOCK_BOOTTIME. They got reverted later on, and shouldn't have reached
> anybody's systems. Otherwise what you are seeing does smell a lot like those patches.)
>
> Anyway, closing this here, as there's nothing we can do about this in systemd, and
> the bug is in your kernel.
https://github.com/systemd/systemd/issues/9538#issuecomment-405590102

> 
> > Prevent the system from entering s2idle when cpuidle isn't supported in the
> > suspend subsystem as well.
> 
> I'm sure that there's a real problem you're trying to address, but I
> cannot help you without understanding what the problem is.
> 
> So please explain what exactly is going on, what is expected to happen
> and what happens instead and why this is problematic.
> 
> Till then, the patches are not going anywhere.
> 
> Thanks!
Sorry for the confusion, I hope this cleared some things up.

Thanks,
Kazuki
