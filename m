Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A92679154
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjAXG40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjAXG4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:56:25 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CADC3346A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:56:24 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id m199so1968757ybm.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 22:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QgezcTkg4MHlax1OqKvWd82+a84hSj5vD+44tqvTytc=;
        b=bB4wJVb4N8vpBUbOMsclF88BGu//ALgeglU7VOTzrEKUv+KUM5lLPARokkheGMzwe/
         HzLa1aAmwNCO1wc3Pt9MlXTmZg+A8hWEgpZAqUtgatoYGQWPk47HNpoSYHaQdpShdTT+
         N3lL+QeL9JYAiT0T3c/cyfRopaUlh8kRkRwQzAGyCChvUHZ0A48G7nL20J2pBP+4/BIu
         Ljh6Gzceq1r4Bwxdg/Ds8ak0xsLQGcntCfh6c3PV19YBLVuBgMPgzHyVfPWgBqh7xodn
         594C+SRzLZpuNZxg9FWG1g3cQZK9lHfn987OUfL0LOegy74F2hX7gGM3XVwyA+BTMb6X
         HOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgezcTkg4MHlax1OqKvWd82+a84hSj5vD+44tqvTytc=;
        b=otKnKeG6uT4iXpXBRxT0/U2yfTJ84XlpNuIqtK39f9vS9/fK9ejMD5IUr4tM3hN/5s
         gIdPCcfeKEVo1HtOO+EupDlgbDI46wXDvS82wnrkD0+YEyhaxf3rBvOVQ3TYPW5ZXAbQ
         WC4ju9Wj6y8GNr7PE9b97gqmEnsHkJFcIlkuPJkBR3JuDGM9PfmSOa57PxQ/F6mYOFfI
         XXn4yq7MAgRLLJxN4hvlbw7dvAY6NZ5nB+ICPFHvnrkE0mMdb81WNWP2SwPFBDyHc5Kk
         9g3TvYGJqg8qONQvwpEuneqzRqoZBSdkTiA1B/5eL7QuHNq/6K5JBKB1ltunH4mx2m+4
         25gA==
X-Gm-Message-State: AO0yUKUPnufhGY78Scd95jGCSNljs9My/5VDQsVP99EyC1XEgoJwi7PF
        e/isYQo7qs3B201o7FCcrxFj9D71vPrU/Yy525Hh
X-Google-Smtp-Source: AK7set+cjg9P5Ad2BtIL267J/C7rcMm+NciUunQBpOx+EJjXEqmZQdbObQlteyTcqibMDzWyNZRkVnZqFiR+N8tkSlM=
X-Received: by 2002:a25:6884:0:b0:80b:72cc:3967 with SMTP id
 d126-20020a256884000000b0080b72cc3967mr31288ybc.123.1674543383316; Mon, 23
 Jan 2023 22:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20230123182728.825519-1-kan.liang@linux.intel.com> <20230123182728.825519-4-kan.liang@linux.intel.com>
In-Reply-To: <20230123182728.825519-4-kan.liang@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 23 Jan 2023 22:56:12 -0800
Message-ID: <CANDhNCqMaqg1S4Vt_6Pe6M-9seGwA8Hxb8vR5KnLaByvG1JANg@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf/x86/intel/ds: Support monotonic clock for PEBS
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, ak@linux.intel.com
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

On Mon, Jan 23, 2023 at 10:27 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Users try to reconcile user samples with PEBS samples and require a
> common clock source. However, the current PEBS codes only convert to
> sched_clock, which is not available from the user space.
>
> Only support converting to clock monotonic. Having one common clock
> source is good enough to fulfill the requirement.
>
> Enable the large PEBS for the monotonic clock to reduce the PEBS
> overhead.
>
> There are a few rare cases that may make the conversion fails. For
> example, TSC overflows. The cycle_last may be changed between samples.
> The time will fallback to the inaccurate SW times. But the cases are
> extremely unlikely to happen.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---

Thanks for sending this out!
A few minor style issues below and a warning.

> The patch has to be on top of the below patch
> https://lore.kernel.org/all/20230123172027.125385-1-kan.liang@linux.intel.com/
>
>  arch/x86/events/intel/core.c |  2 +-
>  arch/x86/events/intel/ds.c   | 30 ++++++++++++++++++++++++++----
>  2 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 14f0a746257d..ea194556cc73 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3777,7 +3777,7 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
>  {
>         unsigned long flags = x86_pmu.large_pebs_flags;
>
> -       if (event->attr.use_clockid)
> +       if (event->attr.use_clockid && (event->attr.clockid != CLOCK_MONOTONIC))
>                 flags &= ~PERF_SAMPLE_TIME;
>         if (!event->attr.exclude_kernel)
>                 flags &= ~PERF_SAMPLE_REGS_USER;
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 7980e92dec64..d7f0eaf4405c 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1570,13 +1570,33 @@ static u64 get_data_src(struct perf_event *event, u64 aux)
>         return val;
>  }
>
> +static int pebs_get_synctime(struct system_counterval_t *system,
> +                            void *ctx)

Just because the abstract function type taken by
get_mono_fast_from_given_time is vague, doesn't mean the
implementation needs to be.
ctx is really a tsc value, right? So let's call it that to make this a
bit more readable.

> +{
> +       *system = set_tsc_system_counterval(*(u64 *)ctx);
> +       return 0;
> +}
> +
> +static inline int pebs_clockid_time(clockid_t clk_id, u64 tsc, u64 *clk_id_time)

clk_id_time is maybe a bit too fuzzy. It is really a mono_ns value,
right? Let's keep that explicit here.

> +{
> +       /* Only support converting to clock monotonic */
> +       if (clk_id != CLOCK_MONOTONIC)
> +               return -EINVAL;
> +
> +       return get_mono_fast_from_given_time(pebs_get_synctime, &tsc, clk_id_time);
> +}
> +
>  static void setup_pebs_time(struct perf_event *event,
>                             struct perf_sample_data *data,
>                             u64 tsc)
>  {
> -       /* Converting to a user-defined clock is not supported yet. */
> -       if (event->attr.use_clockid != 0)
> -               return;
> +       u64 time;

Again, "time" is too generic a term without any context here.
mono_nsec or something would be more clear.

> +
> +       if (event->attr.use_clockid != 0) {
> +               if (pebs_clockid_time(event->attr.clockid, tsc, &time))
> +                       return;
> +               goto done;
> +       }

Apologies for this warning/rant:

So, I do get the NMI safety of the "fast" time accessors (along with
the "high performance" sounding name!) is attractive, but as its use
expands I worry the downsides of this interface isn't made clear
enough.

The fast accessors *can* see time discontinuities! Because the logic
is done without holding the tk_core.seq lock, If you are reading in
the middle of a ntp adjustment, you may find the current value to be
larger than the next time you read the time.  These discontinuities
are likely to be very small, but a negative delta will look very large
as a u64.  So part of using these "fast *and unsafe*" interfaces is
you get to keep both pieces when it breaks. Make sure the code here
that is using these interfaces guards against this (zeroing out
negative deltas).

thanks
-john
