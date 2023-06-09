Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A6772A0A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjFIQwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjFIQwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:52:35 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4A61993
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:52:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-256797b5664so663216a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686329554; x=1688921554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdL8NMRyWgx4omfN+veAQU7XOV8UtG2HtxDF43UR3l4=;
        b=V2g3MrSlKjY/8gjoUkuEp3iUrdjqGn13Dq1/8VPIaIlCBeFhAAwrNk8PkIMgO0Ends
         sO5CQHx9eyuM7PAZOKExIzQ9HW9tFWINyVLJsg6IHU60vQ+x/eumfDZ4tMVaprHJX9n9
         McU9REwcuDQ77irw36UT1e5gXWQtEg4LtHBzgmaLRYRDCee6RQgi4B2u0p+h4spBC8U0
         DY9TSvUnZDC4u22SX/AlwRONejDm575xmedjqmLOaTg3HppHQjt3hFQEWsKpUJ0ih9RI
         z08JPmP94V9ozf5vHi9BBdX2v0btLmt15mmdy1un4aal9g7kctseMr/4OOHIQ5lhoIlb
         Ja+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686329554; x=1688921554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdL8NMRyWgx4omfN+veAQU7XOV8UtG2HtxDF43UR3l4=;
        b=OcHWztu5RRIeOAV6zjHee5wM4XPfGP2Mho0JrKBdDUuF/p0bG88o0t8z1efadlDj75
         AoszLG+A9wpugdqhihc/zoPulK7MMcelRP9DYPG18QvwY6+q6XXZl3pTeE4RJ/ey/Dz4
         gWjXvyrpdiVCTYXIimPh+jVIy3/h1JmOdkB8wEe7AQbS1/7r0I9mBY9CbjMEulLbqqqk
         WqbeIjxD5m0++RbC3uu4PTb+0s49qQPhmJ9PXHJ1bIJNCJmnpZ3IAoYY3sSHYUpB+btn
         h3Yto3nG71gI6VjSFggL/wGOsdj+cyMsJvbZbk4POkRj2QJC8lYJZFI8WdCR/H0JSxqw
         qJ3w==
X-Gm-Message-State: AC+VfDyjaSHWFYWLLjLUXQd43uuTWLbDTJ5202Q9JQmDC/xPdcGFz3j+
        i7m1UnrvoHH6MtZlHvhHnG00Cahcpx15Q4wCcRFpy1UNKeT5Xu/I
X-Google-Smtp-Source: ACHHUZ5wfy8qoPdGu3z+HlPTKMfs6OsO6RQS/quD2YO7N6mhmKv8/34GYVO3IuWRCdkq6jsOXhqz1BC4FD3hxPYGmJw=
X-Received: by 2002:a17:90a:f007:b0:258:de25:5e2f with SMTP id
 bt7-20020a17090af00700b00258de255e2fmr1430038pjb.38.1686329553729; Fri, 09
 Jun 2023 09:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <F4B69136-C13A-4449-9005-4BB0617E60AC@oracle.com>
In-Reply-To: <F4B69136-C13A-4449-9005-4BB0617E60AC@oracle.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 9 Jun 2023 18:52:22 +0200
Message-ID: <CAKfTPtCBQJYfFgFhA6=364onup2TU1hrTxJYJA5OiSJ_ECB0JA@mail.gmail.com>
Subject: Re: Reporting a performance regression in sched/fair on Unixbench
 Shell Scripts with commit a53ce18cacb4
To:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "zhangqiao22@huawei.com" <zhangqiao22@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saeed,

On Fri, 9 Jun 2023 at 00:48, Saeed Mirzamohammadi
<saeed.mirzamohammadi@oracle.com> wrote:
>
> Hi all,
>
> I=E2=80=99m reporting a regression of up to 8% with Unixbench Shell Scrip=
ts benchmarks after the following commit:
>
> Commit Data:
>  commit-id        : a53ce18cacb477dd0513c607f187d16f0fa96f71
>  subject          : sched/fair: Sanitize vruntime of entity being migrate=
d
>  author           : vincent.guittot@linaro.org
>  author date      : 2023-03-17 16:08:10
>
>
> We have observed this on our v5.4 and v4.14 kernel and not yet tested 5.1=
5 but I expect the same.

It would be good to confirm that the regression is present on v6.3
where the patch has been merged originally.  It can be that there is
hidden dependency with other patches introduced since v5.4

>
> ub_gcc_1copy_Shell_Scripts_1_concurrent  :  -0.01%
> ub_gcc_1copy_Shell_Scripts_8_concurrent  :  -0.1%
> ub_gcc_1copy_Shell_Scripts_16_concurrent  :  -0.12%%
> ub_gcc_56copies_Shell_Scripts_1_concurrent  :  -2.29%%
> ub_gcc_56copies_Shell_Scripts_8_concurrent  :  -4.22%
> ub_gcc_56copies_Shell_Scripts_16_concurrent  :  -4.23%
> ub_gcc_224copies_Shell_Scripts_1_concurrent  :  -5.54%
> ub_gcc_224copies_Shell_Scripts_8_concurrent  :  -8%
> ub_gcc_224copies_Shell_Scripts_16_concurrent  :  -7.05%
> ub_gcc_448copies_Shell_Scripts_1_concurrent  :  -6.4%
> ub_gcc_448copies_Shell_Scripts_8_concurrent  :  -8.35%
> ub_gcc_448copies_Shell_Scripts_16_concurrent  :  -7.09%
>
> Link to unixbench:
> github.com/kdlucas/byte-unixbench

I tried to reproduce the problem with v6.3 on my system but I don't
see any difference with or without the patch

Do you have more details on your setup ? number of cpu and topology ?

>
> Info about benchmark:
>  "The shells scripts test measures the number of times per minute a
>   process can start and reap a set of one, two, four and eight concurrent
> copies of a shell scripts where the shell script applies a series of
> transformation to a data file=E2=80=9D
>
> I have also evaluated performance before and after both of these two comm=
its (one if fixing the other) but I still observe the same regression (C1 i=
s still the source of regression).
> C1. a53ce18cacb4 sched/fair: Sanitize vruntime of entity being migrated
> C2. 829c1651e9c4 sched/fair: sanitize vruntime of entity being placed

C2 has introduced some regressions because of the case of newly
migrated tasks that were not correctly managed and C1 fixes this
problem. Then, both have an impact on system that runs for days  with
low prio task

Thanks,
Vincent


>
> Thank you very much,
> Saeed
>
