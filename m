Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BEF6B56C5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCKAfK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Mar 2023 19:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCKAeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:34:31 -0500
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA70E3AB;
        Fri, 10 Mar 2023 16:33:47 -0800 (PST)
Received: by mail-io1-f41.google.com with SMTP id v10so2729660iox.8;
        Fri, 10 Mar 2023 16:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678494758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ws2skJ37FCki1KwSUpSOEyJRCk/XSPHYtSy0yF1HNaA=;
        b=T7Ug0VJbZIi0AcpOLt3tuKGjvVyZnoRLOcWxhy1jb2jqCjogHFcKihEILx3xeMTvB7
         YQK8Bp6frNKQQskuajAU7W/QOC/AD3QVSEddYXw18xAx4warUPjVJp+9G3DyldMAg9ue
         3FdCrIN5aLQers7moFg1pyIsz7QiCpnwdzZWqVN2kdIKPdULNPhHZ9oSSfqayVlkIuA8
         rx8sak7L0DjTeichJTPuc8uaNKdGK/yZMmFxIfYAmMzGOimEWNVRwpD6Y8htkV0lPiXC
         wtxzmuy6hVKT6wn3/6bUF+YC9C6nyxSzlGCPG28eBrIGoKHroBRjQlNicHBMQKlQDodB
         nI+A==
X-Gm-Message-State: AO0yUKXu8yPlTQV9s8HgwJhFeugdsyo14izY5uSutp7NrGv0kipz9Tfv
        S3MWdlsOVMjxzQztaPmavQK2AwK6ZwDgYWJ/L6MaoPdi
X-Google-Smtp-Source: AK7set/MbE+gdgzBDZPbePFWGMKNZxKoSHr4lcZB10652VHo3Ochc9bFkvSUardatgF5SdUflxsE2WKmpSLSGjzma1Y=
X-Received: by 2002:a02:94cd:0:b0:3e1:fb3d:4dce with SMTP id
 x71-20020a0294cd000000b003e1fb3d4dcemr13747156jah.0.1678494757979; Fri, 10
 Mar 2023 16:32:37 -0800 (PST)
MIME-Version: 1.0
References: <20230309101111.444-1-ravi.bangoria@amd.com> <20230309101111.444-3-ravi.bangoria@amd.com>
In-Reply-To: <20230309101111.444-3-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 10 Mar 2023 16:32:26 -0800
Message-ID: <CAM9d7ci_dRrjq==hu5O0wD2kdN5tSJRNFf2ZtDsQ_X6UXZM3CA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf/ibs: Fix interface via core pmu events
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 2:12 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Although, IBS pmu can be invoked via it's own interface, indirect
> IBS invocation via core pmu event is also supported with fixed set
> of events: cpu-cycles:p, r076:p (same as cpu-cycles:p) and r0C1:p
> (micro-ops) for user convenience.
>
> This indirect IBS invocation is broken since commit 66d258c5b048
> ("perf/core: Optimize perf_init_event()"), which added RAW pmu
> under pmu_idr list and thus if event_init() fails with RAW pmu,
> it started returning error instead of trying other pmus.
>
> Fix it by trying to open event on all pmus if event_init() on user
> requested pmu returns -ESRCH.
>
> Without patch:
>   $ sudo ./perf record -C 0 -e r076:p -- sleep 1
>   Error:
>   The r076:p event is not supported.
>
> With patch:
>   $ sudo ./perf record -C 0 -e r076:p -- sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.341 MB perf.data (37 samples) ]
>
> Note that there is no notion of forward pmu mapping. i.e. kernel doesn't
> know which specific pmu(or a set of pmus) the event should be forwarded
> to. As of now, only AMD core pmu forwards a set of events to IBS pmu
> when precise_ip attribute is set and thus trying with all pmus works.
> But if more pmus starts returning -ESRCH, some sort of forward pmu
> mapping needs to be introduced through which the event can directly
> get forwarded to only mapped pmus. Otherwise, trying all pmus can
> inadvertently open event on wrong pmu.
>
> Fixes: 66d258c5b048 ("perf/core: Optimize perf_init_event()")
> Reported-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/core.c | 11 ++++++++---
>  kernel/events/core.c       | 10 +++++++++-
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 8c45b198b62f..81d67b899371 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -371,10 +371,15 @@ static inline int amd_has_nb(struct cpu_hw_events *cpuc)
>  static int amd_pmu_hw_config(struct perf_event *event)
>  {
>         int ret;
> +       u64 dummy;
>
> -       /* pass precise event sampling to ibs: */
> -       if (event->attr.precise_ip && get_ibs_caps())
> -               return -ENOENT;
> +       if (event->attr.precise_ip) {
> +               /* pass precise event sampling to ibs by returning -ESRCH */
> +               if (get_ibs_caps() && !ibs_core_pmu_event(event, &dummy))
> +                       return -ESRCH;
> +               else
> +                       return -ENOENT;
> +       }
>
>         if (has_branch_stack(event) && !x86_pmu.lbr_nr)
>                 return -EOPNOTSUPP;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f79fd8b87f75..e990c71ba34a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11639,18 +11639,26 @@ static struct pmu *perf_init_event(struct perf_event *event)
>                         goto again;
>                 }
>
> +               /*
> +                * pmu->event_init() should return -ESRCH only when it
> +                * wants to forward the event to other pmu.
> +                */

Can we add this to the comment in the struct pmu?  There is a
description already for other error codes.

Otherwise looks good.

Thanks,
Namhyung


> +               if (ret == -ESRCH)
> +                       goto try_all;
> +
>                 if (ret)
>                         pmu = ERR_PTR(ret);
>
>                 goto unlock;
>         }
>
> +try_all:
>         list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
>                 ret = perf_try_init_event(pmu, event);
>                 if (!ret)
>                         goto unlock;
>
> -               if (ret != -ENOENT) {
> +               if (ret != -ENOENT && ret != -ESRCH) {
>                         pmu = ERR_PTR(ret);
>                         goto unlock;
>                 }
> --
> 2.39.2
>
