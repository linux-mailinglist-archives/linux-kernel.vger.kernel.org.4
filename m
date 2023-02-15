Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B407697810
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 09:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjBOIXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 03:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjBOIXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 03:23:11 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF70A32CE7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:23:09 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s11so13092629edd.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 00:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=elEpNM5pz79miW5z5H6E+G7XDsBRqGvMJmXjgI1ePc4=;
        b=OYUw55pIxlaGMkeCPp9K6UOx1nSSdz4jOSzFTKp3QALhPgH/qJ5ealWeSQcXIQSaYy
         ByfIvD4tnF843i5oRiuNOSG4OeCQww8qLpg+qCRkFVI3mMJbbYmgvaBXbUTpORE9GMEg
         OKqZkgEhIhi6afIeyRfvyCvUFQo+tSqStdYXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elEpNM5pz79miW5z5H6E+G7XDsBRqGvMJmXjgI1ePc4=;
        b=YiHesftt6wBzBRuWgSHy/GVamds0Oiikbj94BQCto88Py+Pzce/HghEeeA3HLtEDXn
         GgrbER4TpWf7kFMt09FFnmowWlaiOFhq35JcGpQKwpzA72WdenjfNWKwiqYfyXXTN/+W
         VkZFSxG0Dfe41ITox7bh/4ZeqhP8whnGTAv+3CSLeEhoHVg/cYJ6owRZ77/eMOGsnvzc
         jsbTTQR91YBZa+P2T4vzITdRJnapWhexR17uIYxAJIwpUuwI3+KOoG8/OM1GlwDFswlF
         tK+IjN4endph6gbhdCQ1kO78o1XLwo5tAUCrgwW0QKrTO8V1Kpu04YKM4d8zYY5cuL1R
         GSYg==
X-Gm-Message-State: AO0yUKWHDeTY913WrNqv4zmVZ4EewCnWYIpgl2zjdzO7uiY19Ya3MRYz
        YVLTXaTduSwRbC/UDenSCioqdS8YrD3yaQ8N0kaHtA==
X-Google-Smtp-Source: AK7set+O2JySJmOfU+sugMmGBNWn2xBfCl31PX0jJV9K8IvqQsjXi6zyfMOSmF35H/SN/lqxxwJO+PNsjfgAzp/noAs=
X-Received: by 2002:a50:c441:0:b0:4ac:b7c1:9109 with SMTP id
 w1-20020a50c441000000b004acb7c19109mr577780edf.6.1676449388192; Wed, 15 Feb
 2023 00:23:08 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
In-Reply-To: <20230211064527.3481754-2-jstultz@google.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Wed, 15 Feb 2023 09:22:57 +0100
Message-ID: <CAOf5uwn4NPsXp91aUAwa0RFP9jFRyaNDzOQr6FzUHTC26Y6+bg@mail.gmail.com>
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

For kernel 5.10.x and lts is possible to use freezable_schedule and
let this set_current_state as was before.
I have seen patch that introduce the new state but I suppose that in
order to be compatible to stable this should be the
change. Am I right?

Michael

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
