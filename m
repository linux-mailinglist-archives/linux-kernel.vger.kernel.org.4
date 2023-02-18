Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EDC69BA89
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 15:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBRO5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 09:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBRO5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 09:57:09 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F262193C4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 06:57:08 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ee44so171908edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 06:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wuUX11iGDln05bGMWVMxB0dWuTwObLjcPQ1PL8HVstE=;
        b=TO1sqPVUyJGIb+lcWOqRLCmRL53S3p7PYEuwcJqBjxy2hOUPbizuqLSLkr/7Fe74u1
         THZw63sEruHlNMfhdFLCqLIge3Ho68shBZDWaFJFss7FxgyIJjECOzbkZs80m2TC1cnl
         7RMgcuPSiDugw4WDWAEjTnvxwusnqSGoce3DM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wuUX11iGDln05bGMWVMxB0dWuTwObLjcPQ1PL8HVstE=;
        b=RcExYSdQl5HOfD4rAgZO3T1wITYBJUKu4lRs63SlzXzGz43Z/jKgaHFuiAMCwQHPhv
         KOLYIb6kIH8pSNlUE2J6TUxlLQtEEtURCUBSNyIq3aU5HusUd8zlRvn+fa7pBWn4L9/a
         Qrg8cdMZ5vjCNs7uq8A9+LFfLOUc1r92XsxDcK7hrg7uHovE9VUHRrSJKNferGMGRDDA
         MQ4+oRRWO+upDvaHhiwe7p1uhJF5FpFsg3CKW3GAyTi/OpjbhkxMYnhMXrAREmQLKFRX
         nFiFDVmYTt2W5qqRgBamZZnwDlSSYyYLVm+PTaJuQE8JXMrNPtbIJclADcOnMpG+oSC1
         OImQ==
X-Gm-Message-State: AO0yUKUF/O/wf4nk3oDFRZUh5z/ElTBXmJotJWGNOqJH16A5OWn99D8p
        YjK+7HhK3Z+rp0FZWz+dvArwxZZnxC61LvbhnwJGhA==
X-Google-Smtp-Source: AK7set+g69qne69Z1Rg+H7pU25a2Zh+cUUv2WW+rcITTYgqdOvren38Zfqax5xPGWOq0fM2E76StfT16/tPrw4UnnuA=
X-Received: by 2002:a50:bac7:0:b0:4ad:7482:cd3b with SMTP id
 x65-20020a50bac7000000b004ad7482cd3bmr59075ede.6.1676732227744; Sat, 18 Feb
 2023 06:57:07 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
In-Reply-To: <20230211064527.3481754-2-jstultz@google.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Sat, 18 Feb 2023 15:56:56 +0100
Message-ID: <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John

On Sat, Feb 11, 2023 at 7:45 AM John Stultz <jstultz@google.com> wrote:
>
> Instead of trying to handle the freezer waking up tasks from
> schedule() in nanosleep on alarmtimers explicitly, use
> TASK_FREEZABLE which marks the task freezable when it goes
> to schedule, which prevents the signal wakeup.
>
> This allows for the freezer handling to be removed, simplifying
> the code.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michael <michael@mipisi.de>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: kernel-team@android.com
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.1909021247250.3955@nanos.tec.linutronix.de/
> [jstultz: Forward ported to 6.2-rc and split out from a separate
>           fix.]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  kernel/time/alarmtimer.c | 53 ++--------------------------------------
>  1 file changed, 2 insertions(+), 51 deletions(-)
>
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index f7b2128f64e2..15ecde8fcc1b 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -49,14 +49,6 @@ static struct alarm_base {
>         clockid_t               base_clockid;
>  } alarm_bases[ALARM_NUMTYPE];
>
> -#if defined(CONFIG_POSIX_TIMERS) || defined(CONFIG_RTC_CLASS)
> -/* freezer information to handle clock_nanosleep triggered wakeups */
> -static enum alarmtimer_type freezer_alarmtype;
> -static ktime_t freezer_expires;
> -static ktime_t freezer_delta;
> -static DEFINE_SPINLOCK(freezer_delta_lock);
> -#endif
> -
>  #ifdef CONFIG_RTC_CLASS
>  /* rtc timer and device for setting alarm wakeups at suspend */
>  static struct rtc_timer                rtctimer;
> @@ -241,19 +233,12 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
>   */
>  static int alarmtimer_suspend(struct device *dev)
>  {
> -       ktime_t min, now, expires;
> +       ktime_t now, expires, min = KTIME_MAX;
>         int i, ret, type;
>         struct rtc_device *rtc;
>         unsigned long flags;
>         struct rtc_time tm;
>
> -       spin_lock_irqsave(&freezer_delta_lock, flags);
> -       min = freezer_delta;
> -       expires = freezer_expires;
> -       type = freezer_alarmtype;
> -       freezer_delta = KTIME_MAX;
> -       spin_unlock_irqrestore(&freezer_delta_lock, flags);
> -
>         rtc = alarmtimer_get_rtcdev();
>         /* If we have no rtcdev, just return */
>         if (!rtc)
> @@ -480,38 +465,6 @@ u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
>  EXPORT_SYMBOL_GPL(alarm_forward_now);
>
>  #ifdef CONFIG_POSIX_TIMERS
> -
> -static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type type)
> -{
> -       struct alarm_base *base;
> -       unsigned long flags;
> -       ktime_t delta;
> -
> -       switch(type) {
> -       case ALARM_REALTIME:
> -               base = &alarm_bases[ALARM_REALTIME];
> -               type = ALARM_REALTIME_FREEZER;
> -               break;
> -       case ALARM_BOOTTIME:
> -               base = &alarm_bases[ALARM_BOOTTIME];
> -               type = ALARM_BOOTTIME_FREEZER;
> -               break;
> -       default:
> -               WARN_ONCE(1, "Invalid alarm type: %d\n", type);
> -               return;
> -       }
> -
> -       delta = ktime_sub(absexp, base->get_ktime());
> -
> -       spin_lock_irqsave(&freezer_delta_lock, flags);
> -       if (delta < freezer_delta) {
> -               freezer_delta = delta;
> -               freezer_expires = absexp;
> -               freezer_alarmtype = type;
> -       }
> -       spin_unlock_irqrestore(&freezer_delta_lock, flags);
> -}
> -
>  /**
>   * clock2alarm - helper that converts from clockid to alarmtypes
>   * @clockid: clockid.
> @@ -750,7 +703,7 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, ktime_t absexp,
>         struct restart_block *restart;
>         alarm->data = (void *)current;
>         do {
> -               set_current_state(TASK_INTERRUPTIBLE);
> +               set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
>                 alarm_start(alarm, absexp);
>                 if (likely(alarm->data))
>                         schedule();
> @@ -765,8 +718,6 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, ktime_t absexp,
>         if (!alarm->data)
>                 return 0;
>
> -       if (freezing(current))
> -               alarmtimer_freezerset(absexp, type);
>         restart = &current->restart_block;
>         if (restart->nanosleep.type != TT_NONE) {
>                 struct timespec64 rmt;
> --
> 2.39.1.581.gbfd45094c4-goog
>

I have changed the alarm test to check some corner case

periodic_alarm
Start time (CLOCK_REALTIME_ALARM)[   85.624819] alarmtimer_enqueue: called
: 94:865096467
Setting alarm for every 4 seconds
Starting suspend loops
[   89.674127] PM: suspend entry (deep)
[   89.714916] Filesystems sync: 0.037 seconds
[   89.733594] Freezing user space processes
[   89.740680] Freezing user space processes completed (elapsed 0.002 seconds)
[   89.748593] OOM killer disabled.
[   89.752257] Freezing remaining freezable tasks
[   89.756807] alarmtimer_fired: called
[   89.756831] alarmtimer_dequeue: called <---- HERE

I have the dequeue but not an enquee of the periodic alarm. I was
thinking that create a periodic time of 4 seconds
and have the first alarm on suspend will always guarantee the re-arm
it but it's not working as I expect

Michael




[   89.767735] Freezing remaining freezable tasks completed (elapsed
0.003 seconds)
[   89.775626] printk: Suspending console(s) (use no_console_suspend to debug)


-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
