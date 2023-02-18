Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C45869BA7E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 15:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBROvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 09:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBROvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 09:51:54 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FB618B2C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 06:51:52 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ee44so140556edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 06:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4A5nMruH8bp69Bc7Q1rSOwx+0fOCO2hIc5fu1rbrWEw=;
        b=eCbZ74pojHKvDDNhCXD4k2su632qwXknDermZ0bJBz7GSm4DzcZPoXsUJPufLSRpRy
         q8MQytw5tERT3PSCN29gldM5c/VczK5/XuotvC6FB6V7/FrS4WvzeFeeCYIadipN3v8V
         k47PNgR/rHaGVCyqYr1qG7kK2s2uxeQSBfN64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4A5nMruH8bp69Bc7Q1rSOwx+0fOCO2hIc5fu1rbrWEw=;
        b=cnKRczI0UwYg7NiA2oNNZmJfzdb28EpUIS0CJqcehCILxmNdzkAkaA7C66JhVPo9R+
         JTHnAufIvySU17Oisq1SzD0+KR8+RDJO6mp9MHHTvv7yJ6uE8DatdvhXnujRqJme5EcK
         k50V0Tl4eqSJZkf51QVIOt1uOCiYdAmejk+vt6W15EvS3vsyjx2H+CqdfnNzV9uT0KKI
         +bhgYUfTpF/DsJsYTdv/UY8KXM2AZhhljKjKGcMwPt5wiLv0dl2/8XDN3zeVltdA25Uo
         dA0cVDQC37h+Mjsp+FhZw/sHLMMwPNB3oAEXqiEJe4mbfGDPZOyd0LFsfzwwyn+cZ8vO
         Oh/Q==
X-Gm-Message-State: AO0yUKWVT5uiMPokOVjY1ev+EMSkhoxPvkKTlTUVAEvpJhfiQB2iSkcR
        M+ktQkvXENbNf/ZSWwfpecwDPDrxCCRfxaQmftu2SQ==
X-Google-Smtp-Source: AK7set9/KOewliu+bv8LtD77Q4OG4CyLH7v4/93XQ6L5BNw/41BtkLvOu4SXEJuctKoR/i1pM9zF3rqewW8wRGYkqP4=
X-Received: by 2002:a50:9f28:0:b0:4ac:b618:7fb1 with SMTP id
 b37-20020a509f28000000b004acb6187fb1mr127973edf.6.1676731911073; Sat, 18 Feb
 2023 06:51:51 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com>
In-Reply-To: <20230211064527.3481754-1-jstultz@google.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Sat, 18 Feb 2023 15:51:40 +0100
Message-ID: <CAOf5uwncu5Otb+aQJiOL=twv6tPhNxb9-_pKQEkwe1TZX3gNNQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] time: alarmtimer: Fix erroneous case of using 0
 as an "invalid" initialization value
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

On Sat, Feb 11, 2023 at 7:45 AM John Stultz <jstultz@google.com> wrote:
>
> Michael reported seeing an error where alarmtimers would
> occasionally not wake the system up.
>
> It was found that in alarmtimer_suspend() it was exiting via
> the:
>     if (min == 0)
>         return 0;
> check. This logic was from one of the early versions of the
> original alarmtimer patch, where we initialized min to 0, and
> then this check would exit early if we found no timers to expire
> (leaving min still at 0).
>
> However, its possible for an alarmtimer to expire as we are
> checking it, leaving the calculated delta to be zero, and thus
> setting min to zero.
>
> This is the result of my using 0 as an invalid time value which
> is clearly erroneous. Instead KTIME_MAX should have been used.
>
> This patch, split out from a change originally suggested by
> Thomas Gleixner, changes the logic to instead use KTIME_MAX.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michael <michael@mipisi.de>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: kernel-team@android.com
> Reported-by: Michael <michael@mipisi.de>
> Reported-by: Michael Trimarchi <michael@amarulasolutions.com>
> Fixes: ff3ead96d17f ("timers: Introduce in-kernel alarm-timer interface")
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.1909021247250.3955@nanos.tec.linutronix.de/
> [jstultz: Forward ported to 6.2-rc, and split out just the
>           KTIME_MAX change]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  kernel/time/alarmtimer.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index 5897828b9d7e..f7b2128f64e2 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -251,7 +251,7 @@ static int alarmtimer_suspend(struct device *dev)
>         min = freezer_delta;
>         expires = freezer_expires;
>         type = freezer_alarmtype;
> -       freezer_delta = 0;
> +       freezer_delta = KTIME_MAX;
>         spin_unlock_irqrestore(&freezer_delta_lock, flags);
>
>         rtc = alarmtimer_get_rtcdev();
> @@ -271,13 +271,14 @@ static int alarmtimer_suspend(struct device *dev)
>                 if (!next)
>                         continue;
>                 delta = ktime_sub(next->expires, base->get_ktime());
> -               if (!min || (delta < min)) {
> +               if (delta < min) {
>                         expires = next->expires;
>                         min = delta;
>                         type = i;
>                 }
>         }
> -       if (min == 0)
> +       /* No timers to expire */
> +       if (min == KTIME_MAX)
>                 return 0;
>
>         if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
> @@ -503,7 +504,7 @@ static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type type)
>         delta = ktime_sub(absexp, base->get_ktime());
>
>         spin_lock_irqsave(&freezer_delta_lock, flags);
> -       if (!freezer_delta || (delta < freezer_delta)) {
> +       if (delta < freezer_delta) {
>                 freezer_delta = delta;
>                 freezer_expires = absexp;
>                 freezer_alarmtype = type;
> --
> 2.39.1.581.gbfd45094c4-goog
>

Tested-by: Michael Trimarchi <michael@amarulasolutions.com>

I don't find regression on this

Michael
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
