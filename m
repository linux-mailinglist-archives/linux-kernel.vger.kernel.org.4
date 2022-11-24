Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AF06373F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiKXIbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiKXIbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:31:51 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EDEC9AB7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:31:47 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id i131so1048134ybc.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GIX8Qnm799zO1cdHABBf5oTsapUrm+E7rvTghMjWXdo=;
        b=NL8/AMqyX/iY/osJzwzEOkmcdEIDFxin9toCDIysA1cE9EqFQxsEfU4o6QtGfB42vJ
         Aha6ojRqykynBJoTTMqoplog3gitGW4w9lku7U+6dFE8/JsKRShzV0XHiCzTxRWTh+Oz
         WYUKkFZ5uPQjKsjrpEPyQAGzqt+Fm6QmY2jDbWK6liBs02w983oh92Ftl7EBqeWimzvD
         d7O018bYQRK5vx4zThbofKfM07icbGXzQVN9SwxASsBlYa/nqzZAZEuAsnhULFvb8cXJ
         yOHODY3M9vjWTsRhFQh7SjlhD+5nmnsaCDSQYQ2FhtOJf8jmCQkAkPXEn7qtg8lEmSwM
         51PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GIX8Qnm799zO1cdHABBf5oTsapUrm+E7rvTghMjWXdo=;
        b=Ds1d5wck3sm2xI7oSBTrK3meBogPvQFslq3Y80KWY4iYb1UX0lDhB9KiXctIwX4Bl1
         O+epXNH+0nJsG1+26zG39wfi7pl1A731D/kv3Qk3x3mONWOLVSQZ8IHnnxn0sJ4yJHoP
         QeLgDK+suRJLuyf6A+63DyxBaxU4jcvji36YrWOpk3ant439djgXiynh5KBrwkN2fe3i
         H9rGpBCIP/fqOldNfvATgonOUSd1J+xK0LKu/uU203z17+fVwROyDK56k3BQyoJ3UnTb
         k6bKnlaWrNbTuxBP40yTq5qYSNJ0Wpz6Uqrap0m0HmfJt+lBqnx2nWEesI5QtK6GgXYJ
         lXuA==
X-Gm-Message-State: ANoB5pmCS0x71ik8xK7JOGXGfgDa68jEEB10Lwfqln0cHtW3wa7in1AA
        10tKXV9GTLQwzICRgGjKH99Vpb+rRTwNbr728q24Sg==
X-Google-Smtp-Source: AA0mqf6b1D7YJzTumAWjGf7V0PY7P7+5DtIQOjhVqJizjMfN7BHtPbMkAhDZybcWfN1zIMMJJFBD/rjd3hgRBQiMPGQ=
X-Received: by 2002:a05:6902:1825:b0:6de:f09:2427 with SMTP id
 cf37-20020a056902182500b006de0f092427mr11694276ybb.125.1669278706819; Thu, 24
 Nov 2022 00:31:46 -0800 (PST)
MIME-Version: 1.0
References: <Y3RbiRmAKrDlVCxC@xpf.sh.intel.com> <Y3Z5WTk+cvHSt0lf@hirez.programming.kicks-ass.net>
 <Y3hDYiXwRnJr8RYG@xpf.sh.intel.com> <Y342qkDw7yqA1VOD@hirez.programming.kicks-ass.net>
In-Reply-To: <Y342qkDw7yqA1VOD@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Thu, 24 Nov 2022 09:31:10 +0100
Message-ID: <CANpmjNOfF92cGPbWxQy9zj__uBgoeuimWjt4ZH9v35Q=PJ3LXQ@mail.gmail.com>
Subject: Re: [Syzkaller & bisect] There is "__perf_event_overflow" WARNING in
 v6.1-rc5 kernel in guest
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Pengfei Xu <pengfei.xu@intel.com>, peter.zijlstra@intel.com,
        linux-kernel@vger.kernel.org, heng.su@intel.com,
        Mark Rutland <mark.rutland@arm.com>
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

On Wed, 23 Nov 2022 at 16:05, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Nov 19, 2022 at 10:45:54AM +0800, Pengfei Xu wrote:
>
> > The result shows that your additional patch fixed this issue!
> > If possible, could you add Reported-and-tested-by tag from me.
>
> After talking with Marco for a bit the patch now looks like the below.
> I've tentatively retained your tested-by, except of course, you haven't.
>
> If I could bother you once more to test the branch:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/urgent
>
> ---
> Subject: perf: Consider OS filter fail
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Sat, 19 Nov 2022 10:45:54 +0800
>
> Some PMUs (notably the traditional hardware kind) have boundary issues
> with the OS filter. Specifically, it is possible for
> perf_event_attr::exclude_kernel=1 events to trigger in-kernel due to
> SKID or errata.
>
> This can upset the sigtrap logic some and trigger the WARN.
>
> However, if this invalid sample is the first we must not loose the
> SIGTRAP, OTOH if it is the second, it must not override the
> pending_addr with an invalid one.
>
> Fixes: ca6c21327c6a ("perf: Fix missing SIGTRAPs")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Link: https://lkml.kernel.org/r/Y3hDYiXwRnJr8RYG@xpf.sh.intel.com

Thanks, FWIW

Reviewed-by: Marco Elver <elver@google.com>

One thing I wondered was, if the event fired in the kernel due to
skid, is the addr always some kernel address, or does this also depend
on the type of PMU? In any case, we don't even want to risk leaking
kernel addresses this way, so this looks sane.

> ---
>  kernel/events/core.c |   24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9273,6 +9273,19 @@ int perf_event_account_interrupt(struct
>         return __perf_event_account_interrupt(event, 1);
>  }
>
> +static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *regs)
> +{
> +       /*
> +        * Due to interrupt latency (AKA "skid"), we may enter the
> +        * kernel before taking an overflow, even if the PMU is only
> +        * counting user events.
> +        */
> +       if (event->attr.exclude_kernel && !user_mode(regs))
> +               return false;
> +
> +       return true;
> +}
> +
>  /*
>   * Generic event overflow handling, sampling.
>   */
> @@ -9306,6 +9319,13 @@ static int __perf_event_overflow(struct
>         }
>
>         if (event->attr.sigtrap) {
> +               /*
> +                * The desired behaviour of sigtrap vs invalid samples is a bit
> +                * tricky; on the one hand, one should not loose the SIGTRAP if
> +                * it is the first event, on the other hand, we should also not
> +                * trigger the WARN or override the data address.
> +                */
> +               bool valid_sample = sample_is_allowed(event, regs);
>                 unsigned int pending_id = 1;
>
>                 if (regs)
> @@ -9313,7 +9333,7 @@ static int __perf_event_overflow(struct
>                 if (!event->pending_sigtrap) {
>                         event->pending_sigtrap = pending_id;
>                         local_inc(&event->ctx->nr_pending);
> -               } else if (event->attr.exclude_kernel) {
> +               } else if (event->attr.exclude_kernel && valid_sample) {
>                         /*
>                          * Should not be able to return to user space without
>                          * consuming pending_sigtrap; with exceptions:
> @@ -9330,7 +9350,7 @@ static int __perf_event_overflow(struct
>                 }
>
>                 event->pending_addr = 0;
> -               if (data->sample_flags & PERF_SAMPLE_ADDR)
> +               if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
>                         event->pending_addr = data->addr;
>                 irq_work_queue(&event->pending_irq);
>         }
