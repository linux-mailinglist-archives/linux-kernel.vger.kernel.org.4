Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A5C6DC89D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjDJPgs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Apr 2023 11:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjDJPgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:36:46 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1D14EC7;
        Mon, 10 Apr 2023 08:36:45 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id z23so3627599uav.8;
        Mon, 10 Apr 2023 08:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681141005; x=1683733005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mZMaZ5yM1oqShI5ecZeTy++LWeRnqrDt5SHNiRc2dw=;
        b=4h3B48wV9ux9k1pjzAZbdODKjzzLv00gUyGT5kI/tJX/aR+nJSE3rKFoDenYFbFd6U
         PYtN2EB0qmwDHAgzhV4Mz96fmOeExCRsWD5r0JtB4c3jQT43V/rlpACzwViBQGIZBKpx
         omqk4+P8bJeyG+5N+tm3+7V0LEoKsfpwlz+fZcOslHCprQc5eYaURBxyJTKKBI57t1e6
         YbZmAxpgaLlS8NjYeOgHnEhueAQ5F2PtZihyTYn2Hk1+63tIDwUNDH18NXRnTLJpuq0q
         SCdpZvFH2eCzz6ixe0X/nREkNyCMyDPhnwg6UETy9klDYVTqK3f+WBXQfQU0sqGAC0i6
         L2GQ==
X-Gm-Message-State: AAQBX9esjagkCvwrNdB06ZyaH+pADCHD27zyJY0YML+PYeVLyQDeQjaO
        dR/qN24exjxNiO85BXtgDB7OKv+5oCLZipBRvQY=
X-Google-Smtp-Source: AKy350bNKl0reJD3SO/DqgLdgKOPJmlAx2JD3JHd6SAqnqPLXa9KyNikKOvfnDIqNJEjZ9U/6Ef3je8q0/I4luvxHx4=
X-Received: by 2002:a1f:1750:0:b0:43f:cacf:9f08 with SMTP id
 77-20020a1f1750000000b0043fcacf9f08mr1385800vkx.12.1681141003430; Mon, 10 Apr
 2023 08:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cgK-P5KuDy7hkAR4j7oB4ydE6Mw3KexqgwPPhJF6MKtXQ@mail.gmail.com>
 <20230410132239.2062-1-laihangliang1@huawei.com>
In-Reply-To: <20230410132239.2062-1-laihangliang1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 10 Apr 2023 08:36:31 -0700
Message-ID: <CAM9d7cjy-XivELAgq49YF9RKxFZ3M+H3V6s6zVboenRT3oRFDA@mail.gmail.com>
Subject: Re: [PATCH v3] perf top: expand the range of multithreaded phase
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

On Mon, Apr 10, 2023 at 6:22 AM Hangliang Lai <laihangliang1@huawei.com> wrote:
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

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
> v2 -> v3
>  - Sorry for my misunderstanding, patch v3 makes perf_set_multithreaded
>    unconditional after synthesis and set_singlethread in the end.
>
>  tools/perf/builtin-top.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index d4b5b02bab73..ae96ddaf85c4 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1273,8 +1273,7 @@ static int __cmd_top(struct perf_top *top)
>                                     top->evlist->core.threads, true, false,
>                                     top->nr_threads_synthesize);
>
> -       if (top->nr_threads_synthesize > 1)
> -               perf_set_singlethreaded();
> +       perf_set_multithreaded();
>
>         if (perf_hpp_list.socket) {
>                 ret = perf_env__read_cpu_topology_map(&perf_env);
> @@ -1352,6 +1351,7 @@ static int __cmd_top(struct perf_top *top)
>  out_join_thread:
>         cond_signal(&top->qe.cond);
>         pthread_join(thread_process, NULL);
> +       perf_set_singlethreaded();
>         return ret;
>  }
>
> --
> 2.33.0
>
