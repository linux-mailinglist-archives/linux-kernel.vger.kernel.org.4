Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527806D2BFD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 02:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjDAALR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 20:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDAALP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 20:11:15 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F891024A;
        Fri, 31 Mar 2023 17:11:13 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id s23so17263272uae.5;
        Fri, 31 Mar 2023 17:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680307873; x=1682899873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nke42VouiMKyNWR3ankpeC1nBHAkEoxU/z0yVq9MO0Q=;
        b=mUi5hnviJGJZXi4MzDjk6KNXvoP/YUacbILB7wj6aKEWO6aq3H0kYY6xZruuPJOJ3F
         lUZj6b1jcuzPNJPJu67uVlCOPKlF5/mQDp/GSsna10Zx8N/fI9dMUTSPA8IaWmGqj0Nf
         rb5uZ9pgTX8GR5svXZinWCHT+qArvsqYz2zJ+j4Ogs5jkGQFplHkDphxYeN5y+S2OOAB
         sEPGmZk5DnRfDw/UUJMT8m5w2TrIKJPBXboM/RdRqYxNPgqhtHuNEtI0fCv+f0Owi0WW
         5uR29uRPUl9U8MoLgaLBt3nZ5qa3VEJ+1ag9kF6pIEDW07jgrwHExfIumFaCXk7OgloW
         zxzw==
X-Gm-Message-State: AAQBX9fde3dTdeQXutJtUebdhrvQ4YF0BXHR9awAnBISptGPRfMTJ2pF
        PcSOfLndJjd/zkWbXZo3KT6iPmDySLU9ZVPtXTo=
X-Google-Smtp-Source: AKy350aqvhPPKCeCa5/veozoAkaSgdzSji+xmWoW4nqfYqAy6uXVjOOp8JlYvnQFAt8eUegQAMk2zXNo3gYTrZ/rXi0=
X-Received: by 2002:a1f:b446:0:b0:401:32f5:a867 with SMTP id
 d67-20020a1fb446000000b0040132f5a867mr3899359vkf.2.1680307872792; Fri, 31 Mar
 2023 17:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230317100514.1373-1-laihangliang1@huawei.com>
In-Reply-To: <20230317100514.1373-1-laihangliang1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 31 Mar 2023 17:11:01 -0700
Message-ID: <CAM9d7cjrkWdg18wTA_tRch8oN0YUEy3ZJ2mhrYtk23iLqd1XPw@mail.gmail.com>
Subject: Re: [PATCH] perf top: expand the range of multithreaded phase
To:     Hangliang Lai <laihangliang1@huawei.com>
Cc:     liuwenyu7@huawei.com, acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, brauner@kernel.org,
        hewenliang4@huawei.com, irogers@google.com, jolsa@kernel.org,
        linfeilong@huawei.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, yeyunfeng@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for the late reply.

On Fri, Mar 17, 2023 at 3:05 AM Hangliang Lai <laihangliang1@huawei.com> wrote:
>
> In __cmd_top, perf_set_multithreaded is used to enable pthread_rwlock, thus
> donw_read and down_write can work to handle concurrency problems. Then top
> use perf_set_singlethreaded and switch to single threaded phase, assuming
> that no thread concurrency will happen later.
>
> However, a UAF problem could occur in perf top in single threaded phase,
> The concurrent procedure is like this:
>
> display_thread                              process_thread
> --------------                              --------------
>
> thread__comm_len
>   -> thread__comm_str
>     -> __thread__comm_str(thread)
>                                             thread__delete
>                                              -> comm__free
>                                               -> comm_str__put
>                                                -> zfree(&cs->str)
>     -> thread->comm_len = strlen(comm);
>
> Since in single thread phase, perf_singlethreaded is true, down_read and
> down_write can not work to avoid concurrency problems.
>
> This patch put perf_set_singlethreaded to the function tail to expand the
> multithreaded phase range, make display_thread and process_thread run
> safe.

I think it should be unconditional as perf top is always multi-threaded.

>
> Signed-off-by: Hangliang Lai  <laihangliang1@huawei.com>
> Reported-by: Wenyu Liu <liuwenyu7@huawei.com>
> Reviewed-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  tools/perf/builtin-top.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 7c6413447..74239940b 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1280,9 +1280,6 @@ static int __cmd_top(struct perf_top *top)
>                                     top->evlist->core.threads, false,
>                                     top->nr_threads_synthesize);
>
> -       if (top->nr_threads_synthesize > 1)
> -               perf_set_singlethreaded();

Instead, we can simply do

    perf_set_multithreaded();

If top->nr_threads_synthesize > 1, no effect.  If not, it turns
the switch on here.

> -
>         if (perf_hpp_list.socket) {
>                 ret = perf_env__read_cpu_topology_map(&perf_env);
>                 if (ret < 0) {
> @@ -1359,6 +1356,10 @@ out_join:
>  out_join_thread:
>         pthread_cond_signal(&top->qe.cond);
>         pthread_join(thread_process, NULL);
> +
> +       if (top->nr_threads_synthesize > 1)
> +               perf_set_singlethreaded();

And remove the condition here.

Thanks,
Namhyung


> +
>         return ret;
>  }
>
> --
> 2.33.0
>
