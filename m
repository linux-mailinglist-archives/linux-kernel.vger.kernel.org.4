Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99C066B9CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjAPJGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjAPJFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:05:19 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9952913D48
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:02:07 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id hw16so54600323ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wpTf07ZS/duN4c4LbU4nodHpbeXhHIqedQaCMZDq6KE=;
        b=B8a12MQkmfoRjB+Lzwxr/ipzdqA3YwsAvoihplgMzCdglJhFIrvfOYryP6fYZb4d3G
         X9XpnTIeUPIlDAUr0ma4CE+jlzxxz3R//zVSRC3NUqte3GnV9NS40Qs+QceBKSYAChvX
         /9p+L1vaQ8NDYegN5Bmkh/rWfsstzXFa1xVp+Duk2k1oG+r9Sf3v8x7J081wdGWdbOug
         9AYfDfGrRD9L3+UkJbaP3c2SriWzrPcYp499//dY0VQzKlW47xdN2p63zRBRSEhIDEmm
         OXrQ90GrwJ79t5vPdQDzWVGD+gWaVFB42YjRFJ1FSEaqd+ei2iQ/FrB5cxZ44exlq1lG
         HtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpTf07ZS/duN4c4LbU4nodHpbeXhHIqedQaCMZDq6KE=;
        b=f8UlSYklgrgGwfJ8CWXX2nn28dHhrwdCDeEtqU1dAZgkYoUU0TPdBu/g/zsg1Ri2Dk
         hihCI8e9XfFVogfeifIYFvOxRbsZ5J4gJI3+9Agh6TxI4RZ5otVrNaDOme+n+aoPHsG+
         w0hm97uRPEa7951Lw7jAsUbukglC/+u19AACZr/S3slZ7DhOlGezN1bUug6WvjDTVR3q
         WCGZA6r22WNVjDAdIwpN6IEM0Kih1a9/Ptz/nqNyfHuEVW3f1UCBvN5UhaqG4KIrxun8
         JYfQutNge6ZXdJdn/kw+SIlCrZZI74qIa/NWxtYgkldivYWmt6hk8rjqc+anEYNkdJ4k
         yTTA==
X-Gm-Message-State: AFqh2kqjJ8I8jsNjn0IwUW4pAcDVvVvCe3k/6QkbnewLeCOOJs4nOoW+
        cWINfi2dxks52sPKJVu4ymw=
X-Google-Smtp-Source: AMrXdXt8i7a+eBiQw+5bVF8p64CpR6SAmv/aTq/MN7RjJLMeAsEfFZy+WK08BhOwfI2sGnwpLmhoHg==
X-Received: by 2002:a17:906:191a:b0:84d:3822:a14e with SMTP id a26-20020a170906191a00b0084d3822a14emr24537982eje.64.1673859726001;
        Mon, 16 Jan 2023 01:02:06 -0800 (PST)
Received: from gmail.com (1F2EF7EB.nat.pool.telekom.hu. [31.46.247.235])
        by smtp.gmail.com with ESMTPSA id nd38-20020a17090762a600b0084d1b34973dsm11538731ejc.61.2023.01.16.01.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 01:02:04 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 16 Jan 2023 10:02:02 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] sched/idle: Make idle poll dynamic per-cpu
Message-ID: <Y8USikoCYTBl7VFr@gmail.com>
References: <20230112162426.217522-1-bristot@kernel.org>
 <Y8UQdKx+004a28fL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8UQdKx+004a28fL@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jan 12, 2023 at 05:24:26PM +0100, Daniel Bristot de Oliveira wrote:
> > idle=poll is frequently used on ultra-low-latency systems. Examples of
> > such systems are high-performance trading and 5G NVRAM. The performance
> > gain is given by avoiding the idle driver machinery and by keeping the
> > CPU is always in an active state - avoiding (odd) hardware heuristics that
> > are out of the control of the OS.
> > 
> > Currently, idle=poll is an all-or-nothing static option defined at
> > boot time. The motivation for creating this option dynamic and per-cpu
> > are two:
> > 
> >   1) Reduce the power usage/heat by allowing only selected CPUs to
> >      do idle polling;
> >   2) Allow multi-tenant systems (e.g., Kubernetes) to enable idle
> >      polling only when ultra-low-latency applications are present
> >      on specific CPUs.
> > 
> > Joe Mario did some experiments with this option enabled, and the results
> > were significant. For example, by using dynamic idle polling on
> > selected CPUs, cyclictest performance is optimal (like when using
> > idle=poll), but cpu power consumption drops from 381 to 233 watts.
> > 
> > Also, limiting idle=poll to the set of CPUs that benefits from
> > it allows other CPUs to benefit from frequency boosts. Joe also
> > shows that the results can be in the order of 80nsec round trip
> > improvement when system-wide idle=poll was not used.
> > 
> > The user can enable idle polling with this command:
> >   # echo 1 > /sys/devices/system/cpu/cpu{CPU_ID}/idle_poll
> > 
> > And disable it via:
> >   # echo 0 > /sys/devices/system/cpu/cpu{CPU_ID}/idle_poll
> > 
> > By default, all CPUs have idle polling disabled (the current behavior).
> > A static key avoids the CPU mask check overhead when no idle polling
> > is enabled.
> 
> Urgh, can we please make this a cpuidle governor thing or so? So that we
> don't need to invent new interfaces and such.

I think the desired property here would be to make this interface on top of 
pretty much any governor. Ie. have a governor, but also a way to drop any 
CPU into idle-poll, overriding that.

Thanks,

	Ingo
