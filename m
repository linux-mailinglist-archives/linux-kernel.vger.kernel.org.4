Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1886E728521
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbjFHQfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbjFHQex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:34:53 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C8F3AA6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:34:15 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-33d928a268eso142485ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686242043; x=1688834043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c89NpI0V0ZVvNNbEBSn+gUv6LN8PBGc2l0LO77uP+pQ=;
        b=GspKuJq3CLr+8UaqirGKWuyltIMBY+NUYpPlBImfM+jgMiZyBgtgf0UXLAucmWC+rY
         4Fm3Wd2HCGLUlxhzxSrW4gW3fi8cftBsNPxTlbTL0vj5kM+H5KtZnPuMcmErvKv+FSHC
         Ju7pGkiA+gh5KzTMaTmQP+U5N0xW6zyJmmqqpvSCdLh5GjSgASKNhr6cr+gTLE4isUv3
         epvFOQSOhoOP5QBpCSikMUA0LCWL4lhElEUKxXRCRiZ8RirZu97GurUNNs356nDMxg9Q
         wfu5b5+2ZJ9OAqpmn5UlEKm8x5Fm7DxQkqqaOCQiVCNXM2MvdSHsX9nVxsqyVfQ2L9zW
         ybHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242043; x=1688834043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c89NpI0V0ZVvNNbEBSn+gUv6LN8PBGc2l0LO77uP+pQ=;
        b=QWruAZ2IORYpOkIDzlpmAmUzkqXdjrn8EHD/MCD8YEUPdW7aO7YCamAjGycLJgFU2a
         txUL1tL0VTq4zPg3AFXUmxqDgPNUU45RYmDDkQOJHoQpNmqgodsYFuVJvc8e7sdgxAkq
         rEoDgry70lP3fWUBxOWoOcMabTrucm2HGTH9MZtY6oAokFANLtySwwh/7xwFsdVcY+RF
         MMd0ZVXpzRdU2Rn3Hpq0+2UuG5rxsfk/smOa6Fl+5QPesev6QK871X4z3LuZgWLRmEd/
         SIPr1eqeomd9H54S1diVQPfVdR46B3JRYrvuxcWV4VpafKUYxk5NXRlEJYhl/5kNI7Hp
         Q2hA==
X-Gm-Message-State: AC+VfDyN0Anu8BRtDcvzWryeveg4FW7eJLId6BdJ2WI+LqKudrZ+EI3M
        FxFOjgnVBQWZAzShXXXy/ecS+J6rddUvDzftgSYFpA==
X-Google-Smtp-Source: ACHHUZ6NOD/QUbRlWIgNJxPHtKVhUxa3UvUGFGJsGaWce3Db5F7bF0H6JfpQNeTtRvXtN5ydaEYTzbQFWfPdaqkgHWU=
X-Received: by 2002:a05:6e02:1bcd:b0:33b:4a8c:2147 with SMTP id
 x13-20020a056e021bcd00b0033b4a8c2147mr142919ilv.8.1686242043095; Thu, 08 Jun
 2023 09:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221024052841.3291983-1-shakeelb@google.com> <20230608111408.s2minsenlcjow7q3@quack3>
In-Reply-To: <20230608111408.s2minsenlcjow7q3@quack3>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 8 Jun 2023 10:33:26 -0600
Message-ID: <CAOUHufbbFG2hsoVX21KWh=RpvnQe8vT90mGKYHimXvWcOQF90g@mail.gmail.com>
Subject: Re: [PATCH] mm: convert mm's rss stats into percpu_counter
To:     Jan Kara <jack@suse.cz>, Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.cz, vbabka@suse.cz,
        regressions@lists.linux.dev, Yu Ma <yu.ma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 5:14=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 24-10-22 05:28:41, Shakeel Butt wrote:
> > Currently mm_struct maintains rss_stats which are updated on page fault
> > and the unmapping codepaths. For page fault codepath the updates are
> > cached per thread with the batch of TASK_RSS_EVENTS_THRESH which is 64.
> > The reason for caching is performance for multithreaded applications
> > otherwise the rss_stats updates may become hotspot for such
> > applications.
> >
> > However this optimization comes with the cost of error margin in the rs=
s
> > stats. The rss_stats for applications with large number of threads can
> > be very skewed. At worst the error margin is (nr_threads * 64) and we
> > have a lot of applications with 100s of threads, so the error margin ca=
n
> > be very high. Internally we had to reduce TASK_RSS_EVENTS_THRESH to 32.
> >
> > Recently we started seeing the unbounded errors for rss_stats for
> > specific applications which use TCP rx0cp. It seems like
> > vm_insert_pages() codepath does not sync rss_stats at all.
> >
> > This patch converts the rss_stats into percpu_counter to convert the
> > error margin from (nr_threads * 64) to approximately (nr_cpus ^ 2).
> > However this conversion enable us to get the accurate stats for
> > situations where accuracy is more important than the cpu cost. Though
> > this patch does not make such tradeoffs.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> Somewhat late to the game but our performance testing grid has noticed th=
is
> commit causes a performance regression on shell-heavy workloads. For
> example running 'make test' in git sources on our test machine with 192
> CPUs takes about 4% longer, system time is increased by about 9%:
>
>                        before (9cd6ffa6025)  after (f1a7941243c1)
> Amean     User         471.12 *   0.30%*     481.77 *  -1.96%*
> Amean     System       244.47 *   0.90%*     269.13 *  -9.09%*
> Amean     Elapsed      709.22 *   0.45%*     742.27 *  -4.19%*
> Amean     CPU          100.00 (   0.20%)     101.00 *  -0.80%*
>
> Essentially this workload spawns in sequence a lot of short-lived tasks a=
nd
> the task startup + teardown cost is what this patch increases. To
> demonstrate this more clearly, I've written trivial (and somewhat stupid)
> benchmark shell_bench.sh:
>
> for (( i =3D 0; i < 20000; i++ )); do
>         /bin/true
> done
>
> And when run like:
>
> numactl -C 1 ./shell_bench.sh
>
> (I've forced physical CPU binding to avoid task migrating over the machin=
e
> and cpu frequency scaling interfering which makes the numbers much more
> noisy) I get the following elapsed times:
>
>          9cd6ffa6025    f1a7941243c1
> Avg      6.807429       7.631571
> Stddev   0.021797       0.016483
>
> So some 12% regression in elapsed time. Just to be sure I've verified tha=
t
> per-cpu allocator patch [1] does not improve these numbers in any
> significant way.
>
> Where do we go from here? I think in principle the problem could be fixed
> by being clever and when the task has only a single thread, we don't both=
er
> with allocating pcpu counter (and summing it at the end) and just account
> directly in mm_struct. When the second thread is spawned, we bite the
> bullet, allocate pcpu counter and start with more scalable accounting.
> These shortlived tasks in shell workloads or similar don't spawn any
> threads so this should fix the regression. But this is obviously easier
> said than done...
>
>                                                                 Honza
>
> [1] https://lore.kernel.org/all/20230606125404.95256-1-yu.ma@intel.com/

Another regression reported earlier:
https://lore.kernel.org/linux-mm/202301301057.e55dad5b-oliver.sang@intel.co=
m/
