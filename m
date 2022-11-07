Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F026200ED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiKGVVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiKGVU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:20:56 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AE63056D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:19:50 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-36ad4cf9132so116737397b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 13:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H/Db9QVhek5neko0fLOabrR6exgAplpWG4R/xjzBLjc=;
        b=imEQtpG+c8ktMmb1IK8HOqoPy+FWxyFnTrQ5MuPDImKbZwqqKHdXZNmv87GXcXaVCs
         29qRyI/Tm3otWgD/6t/foNpYuhM69MZLLH28LjAJCtbT+2TlbiLymJ/tqNtNAkAdcsQ4
         9ymcb0gFFYjisR2epDcbv4UwvtyKVT67Yt2EPb2cYhOHWWOT9RmYO84MK3QJY7vQnAH9
         s5vl8hiQgK6QnqgOgVvBwpjnDwXQymGjfsiJwmk+Tydx//b8TMP8zFO/oW3zMeOf8op1
         NHSH+wiBsS++JJjlmdSz+DS3v2tGs3gaSNgwTKXYBJ+nEjX7KElwVIrSqyXsac4neBaK
         Wubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/Db9QVhek5neko0fLOabrR6exgAplpWG4R/xjzBLjc=;
        b=Ya+lbtXwQO3HK47OeaBZ7BOEo7aeyyaXoK+b7DpUJnHVyo9yb3AFz34wy5ggkpZQb/
         kf+fD0/Jy8k+d9SJyT5FdcO/jBDaXY26opVOAGxt/mk8LwZPrGKJ1OrpHs69beWJWAYC
         DNkcCGcIf8+gmkkAdgLXAx23KHakpkIM882c1HQPABL38o1nFtJXETlHzdGMLPqz6ioR
         5ccQ/w9qwjx6fFI/cltkknSqHTqArwPACa44rUKre9m4ilBa87dMATcsITo/D6rdJl86
         ZhjZfDOZUiXb/Pz+9YoCC/GlIZj1TEkSntJqCoK2ldDqL087a7cGqp97AhOn/59WK0YO
         Qyrw==
X-Gm-Message-State: ACrzQf2e1WlCon6tA2eSFeG6TTiiz+uiXTvkWf+1k3eeL5P0/WlmSNR1
        twNB8RRDQga+8jKZdKepWFublkox5OUMlbaLWKhPig==
X-Google-Smtp-Source: AMsMyM5fzdrKc3lZbym82tTvqEBMT9VP1gGgGUGVcjcPVwCVUkT1CvTsrfwQ8pKHkg35WOYQOpo++veb55QcVIgNkFc=
X-Received: by 2002:a0d:d7c4:0:b0:368:9884:fe84 with SMTP id
 z187-20020a0dd7c4000000b003689884fe84mr50081753ywd.252.1667855989534; Mon, 07
 Nov 2022 13:19:49 -0800 (PST)
MIME-Version: 1.0
References: <20221105014013.930636-1-shakeelb@google.com> <20221107130549.db68c48afe5f711b2e99c5c0@linux-foundation.org>
In-Reply-To: <20221107130549.db68c48afe5f711b2e99c5c0@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 7 Nov 2022 13:19:38 -0800
Message-ID: <CALvZod73xvzi=8ZZ-vOXK-ssh54ARwYrizmv5sAa0xyQR=7KOw@mail.gmail.com>
Subject: Re: [PATCH] percpu_counter: add percpu_counter_sum_all interface
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
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

On Mon, Nov 7, 2022 at 1:05 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat,  5 Nov 2022 01:40:13 +0000 Shakeel Butt <shakeelb@google.com> wrote:
>
> > The percpu_counter is used for scenarios where performance is more
> > important than the accuracy. For percpu_counter users, who want more
> > accurate information in their slowpath, percpu_counter_sum is provided
> > which traverses all the online CPUs to accumulate the data. The reason
> > it only needs to traverse online CPUs is because percpu_counter does
> > implement CPU offline callback which syncs the local data of the
> > offlined CPU.
> >
> > However there is a small race window between the online CPUs traversal
> > of percpu_counter_sum and the CPU offline callback. The offline callback
> > has to traverse all the percpu_counters on the system to flush the CPU
> > local data which can be a lot. During that time, the CPU which is going
> > offline has already been published as offline to all the readers. So, as
> > the offline callback is running, percpu_counter_sum can be called for
> > one counter which has some state on the CPU going offline. Since
> > percpu_counter_sum only traverses online CPUs, it will skip that
> > specific CPU and the offline callback might not have flushed the state
> > for that specific percpu_counter on that offlined CPU.
>
> OK, got it, thanks.
>
> > Normally this is not an issue because percpu_counter users can deal with
> > some inaccuracy for small time window. However a new user i.e. mm_struct
> > on the cleanup path wants to check the exact state of the percpu_counter
> > through check_mm(). For such users, this patch introduces
> > percpu_counter_sum_all() which traverses all possible CPUs.
>
> And uses it in fork.c:check_mm()!
>
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -756,7 +756,7 @@ static void check_mm(struct mm_struct *mm)
> >                        "Please make sure 'struct resident_page_types[]' is updated as well");
> >
> >       for (i = 0; i < NR_MM_COUNTERS; i++) {
> > -             long x = percpu_counter_sum(&mm->rss_stat[i]);
> > +             long x = percpu_counter_sum_all(&mm->rss_stat[i]);
>
> check_mm() just became more expensive in some cases.  nr_possible_cpus
> * 4.  I wonder if this is enough for people to start caring about.
>
> check_mm() is presently non-optional and I'd be reluctant to change
> this, given how commonly we see the "BUG: Bad rss-counter state"
> getting reported (22 million hits in a google search!).
>
> We could save a ton of that cost by running percpu_counter_sum() first,
> then trying percpu_counter_sum_all() if percpu_counter_sum() indicated
> an error.  This is only worth bothering about if the new check_mm()
> cost is a concern.
>

Yes, this makes much more sense. I had run hackbench on the original
patch and didn't see any significant difference. I will update this
and run some more perf benchmarks to make sure there is no regression
due to this change.

thanks,
Shakeel
