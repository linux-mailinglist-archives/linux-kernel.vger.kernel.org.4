Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF526DB5C4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 23:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjDGVV6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Apr 2023 17:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjDGVV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 17:21:56 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F148B752;
        Fri,  7 Apr 2023 14:21:55 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id p91so13321206uap.1;
        Fri, 07 Apr 2023 14:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680902514; x=1683494514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+chuPFNNrrKiFi5g5/MT+Goo0tel/zcQRxopfzjdJDA=;
        b=zL4ZSsGGWeOe+fcJKPolHCa8ZVclWa6MbxpIxCKEc7LZZjbHyl2SdiAwzJq/9mEASM
         i2JRd4wZgD8G3X/rGtBZRcR48GcVynuxaI2hDrRRJlujlcj3P0xl0WU2l0TnF2EkXLRT
         CgT5VUfdN17pE1DbIYJXC2Xp1Nt330/1Va7izodHgBggW/xA8J3VyAM+PUOODn/NpKbN
         O2PUqx3YjS65h0tvSHRd5yoGZJch/+3SVdK0wkiwFgl//qU7YPX3STxMwUSYCbDjzDEl
         AQu9UY4uSFGC3MlPqEyZief63Jxjn2UrmCOMDRQPSwKapsZqlqsF3QFCkQUQDZ+Z64ey
         xMHQ==
X-Gm-Message-State: AAQBX9f5bh0/DYfhT4+bW+kPyWnS1i8OFjZlv4GH/dIZrykfRQNmJY4V
        pVHzrP9WTbBulovz0Ag4xFeqUCbGsEtnOMtKq2g=
X-Google-Smtp-Source: AKy350Z85M+JNyYExxdEQuOQYgEw6rJYfNjgo/0JNjhyYmukBarkvWbGysp4Aa8xsP4U0w3MkH+mlhrew1Wb8LZDcEo=
X-Received: by 2002:a1f:28d8:0:b0:43c:5b5a:6c22 with SMTP id
 o207-20020a1f28d8000000b0043c5b5a6c22mr53578vko.13.1680902514324; Fri, 07 Apr
 2023 14:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cjrkWdg18wTA_tRch8oN0YUEy3ZJ2mhrYtk23iLqd1XPw@mail.gmail.com>
 <20230406025329.1888-1-laihangliang1@huawei.com>
In-Reply-To: <20230406025329.1888-1-laihangliang1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 7 Apr 2023 14:21:43 -0700
Message-ID: <CAM9d7cgK-P5KuDy7hkAR4j7oB4ydE6Mw3KexqgwPPhJF6MKtXQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf top: expand the range of multithreaded phase
To:     Hangliang Lai <laihangliang1@huawei.com>
Cc:     acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, brauner@kernel.org,
        hewenliang4@huawei.com, irogers@google.com, jolsa@kernel.org,
        linfeilong@huawei.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, liuwenyu7@huawei.com,
        mark.rutland@arm.com, mingo@redhat.com, yeyunfeng@huawei.com
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

On Wed, Apr 5, 2023 at 7:54 PM Hangliang Lai <laihangliang1@huawei.com> wrote:
>
> In __cmd_top, perf_set_multithreaded is used to enable pthread_rwlock, thus
> donw_read and down_write can work to handle concurrency problems. Then top
> use perf_set_singlethreaded and switch to single threaded phase, assuming
> that no thread concurrency will happen later.
> However, a UAF problem could occur in perf top in single threaded phase,
> The concurrent procedure is like this:
> display_thread                              process_thread
> --------------                              --------------
> thread__comm_len
>   -> thread__comm_str
>     -> __thread__comm_str(thread)
>                                             thread__delete
>                                              -> comm__free
>                                               -> comm_str__put
>                                                -> zfree(&cs->str)
>     -> thread->comm_len = strlen(comm);
> Since in single thread phase, perf_singlethreaded is true, down_read and
> down_write can not work to avoid concurrency problems.
> This patch put perf_set_singlethreaded to the function tail to expand the
> multithreaded phase range, make display_thread and process_thread run
> safe.
>
> Signed-off-by: Hangliang Lai  <laihangliang1@huawei.com>
> Reviewed-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
> v1 -> v2
>  - Since perf top is always multi-threaded, remove top->nr_threads_synthesize judgment.

Not always, the synthesis can run in a single thread.

>
>  tools/perf/builtin-top.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index d4b5b02bab73..a18db1ee87fa 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1242,8 +1242,7 @@ static int __cmd_top(struct perf_top *top)
>         if (perf_session__register_idle_thread(top->session) < 0)
>                 return ret;
>
> -       if (top->nr_threads_synthesize > 1)
> -               perf_set_multithreaded();
> +       perf_set_multithreaded();

I think this part should be kept as is.

>
>         init_process_thread(top);
>
> @@ -1273,9 +1272,6 @@ static int __cmd_top(struct perf_top *top)
>                                     top->evlist->core.threads, true, false,
>                                     top->nr_threads_synthesize);
>
> -       if (top->nr_threads_synthesize > 1)
> -               perf_set_singlethreaded();

Here you can make it multi-threaded unconditionally.

Thanks,
Namhyung

> -
>         if (perf_hpp_list.socket) {
>                 ret = perf_env__read_cpu_topology_map(&perf_env);
>                 if (ret < 0) {
> @@ -1352,6 +1348,9 @@ static int __cmd_top(struct perf_top *top)
>  out_join_thread:
>         cond_signal(&top->qe.cond);
>         pthread_join(thread_process, NULL);
> +
> +       perf_set_singlethreaded();
> +
>         return ret;
>  }
>
> --
> 2.33.0
>
