Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0670B62EA76
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiKRAlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbiKRAlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:41:40 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455C474CC0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:41:39 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id i2so3313409vsc.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BFnNrvB7M9HLtSs2vrwNNPnwibdPIPOAQwcqKMr9VQ0=;
        b=mFWHTnQ5IkJPKUG3miicfUcXpN+wUXiKowOjse0QQU2UFPzn2p9T/zvlSzj8K+SyQY
         fFBw4WzvCxnJwv4N2rP1gyPcD4wBSvo7hbwEXgocm/i7436cfu0p1EyNDlYuLuUe5i1B
         08lOKJwMiT/DxC0GTaI1ZJCzxyN1lcvV077KKJqJ2uoBV7d0LxEZBgSvNyVmaj+bNYaQ
         N/orf+RNkz4lI0ZQ55jBwaoI154MT+GkeN4E4kDpbpVqv/6piWZr6kqC0VC7fOFnPu7p
         GmD5DZya50+3VMgBS1JG4OGvywzVaCO9T1OzQauYXOWyT60owITtFs1E5wo7fnyyKiND
         Sy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFnNrvB7M9HLtSs2vrwNNPnwibdPIPOAQwcqKMr9VQ0=;
        b=pXCroH5qdL0bjW8RL/Aa1hj9otil2hanhqQJEizT80iuM4m6U87ghdMe9oOAgtClR+
         6iXfjVtB+pinGDAwLFH4mLeR6DVy24Zkkpu3YVMeia51nfQ74r2Bmi0+M6xBUOBdMFZk
         eC/61h1JZzE/BylSIwUCiUGNBz4RJ1p2rg8xT9LmLGosBRzps8E53wAgDZ5uq+YJe6ZB
         Hp9DAjjAvxI9eyloahu3PSenu6Flpiclwr1pVRvNLUgGp2p1dLfMsRfRISjoudSPo0DX
         T6X4m8pls8B0TnRv0dX+M0LUhOwIBrwN5n7fl2JS8BIu86Fbj+Vq0uSboBnrzYMGXvJw
         EaOg==
X-Gm-Message-State: ANoB5pkvhxzwZXv8Z5CrGmA7ZMEtTRBumHQSqYGkaQbwaTph3oH3+S9x
        usZ3uwWB6lkS0oEEj4K43ekgQsqek250vfOzkJIi
X-Google-Smtp-Source: AA0mqf72w7D3AH0S+YamAwp5brz3apOfoM2jqpP8aFAgZKzX4kAL7nDVBn6Bpc13g5m1VAseGmNh7x0BRi4wW/UBDPk=
X-Received: by 2002:a05:6102:c0d:b0:3af:2b1c:9908 with SMTP id
 x13-20020a0561020c0d00b003af2b1c9908mr3460712vss.18.1668732098236; Thu, 17
 Nov 2022 16:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20221117225822.16154-1-mario.limonciello@amd.com> <20221117225822.16154-2-mario.limonciello@amd.com>
In-Reply-To: <20221117225822.16154-2-mario.limonciello@amd.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 17 Nov 2022 16:41:27 -0800
Message-ID: <CANDhNCpvcZj2OL542+NvAC1z-_FAPY5V+Rm-Su5LjxqbEADnDA@mail.gmail.com>
Subject: Re: [RFC v4 1/5] PM: Add a sysfs file to represent the percentage of
 sleep in hardware state
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sven van Ashbrook <svenva@chromium.org>,
        Raul Rangel <rrangel@chromium.org>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 2:58 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index f72b9f1de178..49119a942cb2 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1806,16 +1806,16 @@ void timekeeping_resume(void)
>         cycle_now = tk_clock_read(&tk->tkr_mono);
>         nsec = clocksource_stop_suspend_timing(clock, cycle_now);
>         if (nsec > 0) {
> -               ts_delta = ns_to_timespec64(nsec);
> +               timekeeping_suspend_time = ns_to_timespec64(nsec);
>                 inject_sleeptime = true;
>         } else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
> -               ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
> +               timekeeping_suspend_time = timespec64_sub(ts_new, timekeeping_suspend_time);
>                 inject_sleeptime = true;
>         }
>
>         if (inject_sleeptime) {
>                 suspend_timing_needed = false;
> -               __timekeeping_inject_sleeptime(tk, &ts_delta);
> +               __timekeeping_inject_sleeptime(tk, &timekeeping_suspend_time);
>         }
>
>         /* Re-base the last cycle value */
> @@ -2232,6 +2232,18 @@ void update_wall_time(void)
>                 clock_was_set_delayed();
>  }
>
> +/**
> + * get_suspend_duration_ns - Return the duration of a system suspend.
> + *
> + * Returns the calculation of the duration of time that passed while a
> + * system was suspended.
> + *
> + */
> +u64 get_suspend_duration_ns(void)
> +{
> +       return timespec64_to_ns(&timekeeping_suspend_time);
> +}
> +

Hey Mario, thanks for sending out this patch!

Though, I feel like this overloads the meaning of
timekeeping_suspend_time in a confusing way.  It's supposed to be the
time from the persistent clock that we started suspend.
But this patch overloads it to also keep track of the time in suspend,
but only for the last suspend event. I'd avoid overloading variables
in this way.

Further, I think this will miss suspend time accounting on systems
that do not have a persistent clock (see drivers/rtc/class.c's use of
timekeeping_inject_sleeptime64).

get_suspend_duration_ns() also is confusing as it doesn't clearly
indicate if it should return cumulative time-in-suspend or the last
time-in-suspend.

I think the earlier version of this patch that hooked into
__timekeeping_inject_sleeptime was a better general approach.

thanks
-john
