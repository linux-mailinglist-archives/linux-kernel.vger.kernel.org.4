Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8F36E50A4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjDQTJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjDQTJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:09:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA915BA7;
        Mon, 17 Apr 2023 12:09:10 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso27390338pjp.5;
        Mon, 17 Apr 2023 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681758549; x=1684350549;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=um1aePTMmxrWsi2GLli2ilatx36oHvor21ECPKcsLyA=;
        b=PzxDxYeono/BrAzsGyYXWDmTFFWDf7M6HLd2Tsdcl30qrD8mj5+PR+80VlrQiL71ub
         PJxIkIJy7ljO6nWTfAWam6ozw6SQRg4X4B9YOImYPLgKg6lNk4h5qB4O8DneqPd5+W3c
         hOac/dY/0a/rtMD4uFmoNVPckiQSJ2I8iCnkohK75LSG+BPakGpi/wYy1DCdz8rWuk8t
         eldm5Koz0uJ7Jg9ILUp+ideegrPrNHnnX0nr9hMmtHZp0hm/k9bvSyglo8HIlgFv81K0
         9mLZTtLLFnkb2afxb+itZ2cq8Ki+iLDS1ZuvO3/xTAYwehRC8Mudtx+S48FJNIUzbiFi
         qqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681758549; x=1684350549;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=um1aePTMmxrWsi2GLli2ilatx36oHvor21ECPKcsLyA=;
        b=g3M0mnc8OYJ6B8dn96Vde8fK51OtEOtULTtc/Ri1rhsrE0f+4Yi+P5HYpRW/Q+GD20
         pEczGZi3bfiUZrtR+jZDprFpuqXCcWVl946SR2Pg+Ex0eKWYHlGbUfkuZtuQgV3iIjEq
         L8K7XzyQLpBH6XHWEFPzfuViizDpU/ZOeLyJpTgGkHuQDTBobK5GeI/QhG8/gOP//Qi0
         puxuWzWFdFQXDH40AaddEBolnXER9ApOSIMSwAUsvisj8f7AJTp4jwECsCSqz+3yogEH
         +QYbBTLUISI0TbjUykybzs98IukzSe/PJq4gy+zzC5EMcks/6pc2jkxy+kRrRZl2nkZN
         aPOw==
X-Gm-Message-State: AAQBX9c505qGZ78GbKQt3byvLTRQdUcN0IhCmBXTc8MYLweiLEsy7bUI
        Kin+ehkJ3BNRKxXRBb1UQdMkpNSSPgpdVg==
X-Google-Smtp-Source: AKy350bRHzK6FzHefVHu7roPW/hHOVOEuvhug6/ANMUujXagMa1UqQv3Y70aF1e7U0TaKPgr2C7uqQ==
X-Received: by 2002:a17:903:187:b0:19d:1834:92b9 with SMTP id z7-20020a170903018700b0019d183492b9mr17780346plg.56.1681758549386;
        Mon, 17 Apr 2023 12:09:09 -0700 (PDT)
Received: from kazuki-mac ([2400:4051:ea3:5910:ae9:b36:cd78:dae1])
        by smtp.gmail.com with ESMTPSA id n23-20020a170902969700b001a27e5ee634sm6038077plp.33.2023.04.17.12.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:09:08 -0700 (PDT)
From:   Kazuki H <kazukih0205@gmail.com>
X-Google-Original-From: Kazuki H <kazuki@kazuki-mac>
Date:   Tue, 18 Apr 2023 04:09:03 +0900
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PM: s2idle: Fully block the system from entering
 s2idle when cpuidle isn't supported
Message-ID: <dfpay3ihwqtxri4izfstvk6eyty5r67w4m4xda6gcjax2y5iii@ujuko5cnv3vd>
References: <20230316074750.289025-1-kazukih0205@gmail.com>
 <20230316074750.289025-3-kazukih0205@gmail.com>
 <CAJZ5v0jncgS6Uh1n3RrTwbwJpEQ+x2Rw5Gr8dcZuVx=W9L8B4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jncgS6Uh1n3RrTwbwJpEQ+x2Rw5Gr8dcZuVx=W9L8B4Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, apologies for the late response.

On Mon, Mar 27, 2023 at 07:43:02PM +0200, Rafael J. Wysocki wrote:
> On Thu, Mar 16, 2023 at 8:49 AM Kazuki H <kazukih0205@gmail.com> wrote:
> >
> > s2idle isn't supported on platforms that don't support cpuidle as of
> > 31a3409065d1 ("cpuidle / sleep: Do sanity checks in cpuidle_enter_freeze()
> > too").
> 
> This simply isn't correct.
> 
> As of the above commit, s2idle was still supported without cpuidle as
> long as arch_cpu_idle() worked.
Sorry I linked the wrong commit, ef2b22ac540c (cpuidle / sleep: Use
broadcast timer for states that stop local timer) is the correct one.

This adds this block of code

if (cpuidle_not_available(drv, dev))
	goto use_default;

which prevents this code, critical for s2idle, from executing

if (idle_should_freeze()) {
	entered_state = cpuidle_enter_freeze(drv, dev);
	if (entered_state >= 0) {
		local_irq_enable();
		goto exit_idle;
	}
	reflect = false;
	next_state = cpuidle_find_deepest_state(drv, dev);
} else {
	reflect = true;
	/*
	 * Ask the cpuidle framework to choose a convenient idle state.
	 */
	next_state = cpuidle_select(drv, dev);
}
> > There is a check in the cpuidle subsystem which would prevent the
> > system from entering s2idle. However, there is nothing in the suspend
> > framework which prevents this, which can cause the suspend subsystem to
> > think that the machine is entering s2idle while the cpuidle subsystem is
> > not, which can completely break the system.
> >
> > Block the machine from entering s2idle when cpuidle isn't supported in
> > the suspend subsystem as well.
> 
> First, please explain why the cpuidle_not_available() check in
> cpuidle_idle_call() is not sufficient to avoid the breakage.
cpuidle_idle_call() doesn't notify the PM subsystem that the host
doesn't support s2idle. We need a seperate check here, otherwise the PM
subsystem will happily continue entering s2idle without the other
subsystem's knowledge.
> 
> > Link: https://lore.kernel.org/all/20230204152747.drte4uitljzngdt6@kazuki-mac
> > Fixes: 31a3409065d1 ("cpuidle / sleep: Do sanity checks in cpuidle_enter_freeze() too")
> > Signed-off-by: Kazuki H <kazukih0205@gmail.com>
> > ---
> >  kernel/power/main.c    | 12 +++++++++---
> >  kernel/power/suspend.c |  5 +++++
> >  2 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > index 31ec4a9b9d70..b14765447989 100644
> > --- a/kernel/power/main.c
> > +++ b/kernel/power/main.c
> > @@ -133,6 +133,8 @@ static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
> >         for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++) {
> >                 if (i >= PM_SUSPEND_MEM && cxl_mem_active())
> >                         continue;
> > +               if (i == PM_SUSPEND_TO_IDLE && cpuidle_not_available())
> > +                       continue;
> 
> Not really.
> 
> >                 if (mem_sleep_states[i]) {
> >                         const char *label = mem_sleep_states[i];
> >
> > @@ -185,11 +187,15 @@ static ssize_t mem_sleep_store(struct kobject *kobj, struct kobj_attribute *attr
> >         }
> >
> >         state = decode_suspend_state(buf, n);
> > -       if (state < PM_SUSPEND_MAX && state > PM_SUSPEND_ON)
> > +       if (state == PM_SUSPEND_TO_IDLE && cpuidle_not_available())
> 
> And same here.
> 
> > +               goto einval;
> > +       if (state < PM_SUSPEND_MAX && state > PM_SUSPEND_ON) {
> >                 mem_sleep_current = state;
> > -       else
> > -               error = -EINVAL;
> > +               goto out;
> > +       }
> >
> > + einval:
> > +       error = -EINVAL;
> >   out:
> >         pm_autosleep_unlock();
> >         return error ? error : n;
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index 3f436282547c..55ddf525aaaf 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -556,6 +556,11 @@ static int enter_state(suspend_state_t state)
> >
> >         trace_suspend_resume(TPS("suspend_enter"), state, true);
> >         if (state == PM_SUSPEND_TO_IDLE) {
> > +               if (cpuidle_not_available()) {
> > +                       pr_warn("s2idle is unsupported when cpuidle is unavailable");
> > +                       return -EINVAL;
> > +               }
> > +
> >  #ifdef CONFIG_PM_DEBUG
> >                 if (pm_test_level != TEST_NONE && pm_test_level <= TEST_CPUS) {
> >                         pr_warn("Unsupported test mode for suspend to idle, please choose none/freezer/devices/platform.\n");
> > --
> 
> Again, I need to understand what the problem is in the first place.
Thanks,
Kazuki
