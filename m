Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6286272C9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 22:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiKMVwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 16:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiKMVwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 16:52:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECF6EE2B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 13:52:18 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668376336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+fLPNxn8GyPP2PzSvtJoQcItylFjq9P4TBD/5FwFVmw=;
        b=hJaLVQxE85MqmxdR+HkXBVo2BILykOP01+Y9f3nHWHgN5eZogB9dVQj0XBmWRdgxIlOFso
        4h3Kie5TG5M5KGd64MD3bYEqtArdNHmpSK7B0R9sk3kT8n4qt7ZTnxzY2SochBzHbr3SzR
        uA3Oh5Hl7gJyzqyOpv9FvnspFDa4rrL0vNGgdYL9dew6AIKnrZphbp1QS7gPd/FW2AINMF
        z4928C89xI47DZJl6gVc7nhPYRmA33lY7plh9lco2+kDIoGCqDQUT3qOsJEHFIWvAcJ8e+
        goBbQ0s20+rkvAjvw7XS/qeCo+kpbrMN0+FEsxMc626KzmII2G3CFNvPYC4w4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668376336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+fLPNxn8GyPP2PzSvtJoQcItylFjq9P4TBD/5FwFVmw=;
        b=Fx9ErtwQajmNL9ZilrstPm9jPgTcxPmIGfMohyeImER8s+RpeK6LS2cbHYuouLL/41v6lR
        sI1haewsFgD8HmDw==
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
In-Reply-To: <20221110064147.343514404@goodmis.org>
References: <20221110064101.429013735@goodmis.org>
 <20221110064147.343514404@goodmis.org>
Date:   Sun, 13 Nov 2022 22:52:16 +0100
Message-ID: <87cz9qttdb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10 2022 at 01:41, Steven Rostedt wrote:

$Subject: -ENOPARSE

 timers: Provide timer_shutdown_sync()

and then have some reasonable explanation in the change log?

> We are hitting a common bug were a timer is being triggered after it
> is

We are hitting? Talking in pluralis majestatis by now?

> freed. This causes a corruption in the timer link list and crashes the
> kernel. Unfortunately it is not easy to know what timer it was that was

Well, that's not entirely true. debugobjects can tell you exactly what
happens. 

> freed. Looking at the code, it appears that there are several cases that
> del_timer() is used when del_timer_sync() should have been.
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 717fcb9fb14a..111a3550b3f2 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1017,7 +1017,8 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
>  	unsigned int idx = UINT_MAX;
>  	int ret = 0;
>  
> -	BUG_ON(!timer->function);
> +	if (WARN_ON_ONCE(!timer->function))
> +		return -EINVAL;

Can you please make these BUG -> WARN conversions a separate patch?

> +/**
> + * timer_shutdown_sync - called before freeing the timer

1) The sentence after the dash starts with an upper case letter as all
   sentences do.

2) "called before freeing the timer" tells us what?

   See below.

> + * @timer: The timer to be freed
> + *
> + * Shutdown the timer before freeing. This will return when all pending timers
> + * have finished and it is safe to free the timer.

   "_ALL_ pending timers have finished?"

This is about exactly _ONE_ timer, i.e. the one which is handed in via
the @timer argument.

You want to educate people to do the right thing and then you go and
provide them uncomprehensible documentation garbage. How is that
supposed to work?

Can you please stop this frenzy and get your act together?

> + *
> + * Note, after calling this, if the timer is added back to the queue
> + * it will fail to be added and a WARNING will be triggered.

There is surely a way to express this so that the average driver writer
who does not have the background of you working on this understands this
"note".

> + *
> + * Returns if it deactivated a pending timer or not.

Please look up the kernel-doc syntax for documenting return values.

Thanks,

        tglx
