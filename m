Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CEE73730E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjFTRko convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 13:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFTRkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:40:42 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA045C2;
        Tue, 20 Jun 2023 10:40:40 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-98273ae42d0so156857666b.0;
        Tue, 20 Jun 2023 10:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687282839; x=1689874839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbvyqW5ttcIXCMxu5xLmmmHDtXQg9jzcwCTh5GfLAYM=;
        b=K9gCiv+nxFGa8Vx6rFWJxnC3esb3F0D3GcxIFVpq5ayyFCk9uSTnVKrCyTAPrth9se
         6LSwyH4VYn78yCatJLAGA6PPmZq/Wc2gsBD+6mYOyX5Ps5xZ0NTcH52PSFYsgZSujer0
         m1XAeI7H1bZ7YpxKLm+vMdEkC5eqlyZfd6PbxJhpboDHGMF+qRYfZ1bqsuoqukbbWYF0
         pbgQiF74b55xPfUgSWH4DIRf2E/hmWr0neoHOArtnerNMcz5P227Im+TvsYOpeEAKZRL
         1obIZad1ciqqFaL2FSohf4uB10nGyNkrFqdRHR2/jVQhAc/xd5QgBlBKd2xhuqgBvvvY
         lv3w==
X-Gm-Message-State: AC+VfDzLKpAreeuLnxoQEvRO7wJVlHRNGiHernyZJAQ8Pe2u4AB9K442
        2VVvRePQ/dPBKZfvhEa4QXvf+qkMAfZtWOht/Mo=
X-Google-Smtp-Source: ACHHUZ5y+22zswgG+0WbzJydNorerdXk35JNMpSA19c2tKu8muUosxJbgmnvPMLd3vswIwDnUcUNJJQIwPkLAw1/iiA=
X-Received: by 2002:a17:906:74da:b0:976:50a4:ac40 with SMTP id
 z26-20020a17090674da00b0097650a4ac40mr10415448ejl.0.1687282839230; Tue, 20
 Jun 2023 10:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230522145702.2419654-1-lukasz.luba@arm.com> <20230522145702.2419654-4-lukasz.luba@arm.com>
In-Reply-To: <20230522145702.2419654-4-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 19:40:28 +0200
Message-ID: <CAJZ5v0g45=0+uLqPD5jib8aQrw8syjMxzd9uPqnTUzxgVCDVkQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v2 3/3] schedutil: trace: Add tracing to capture
 filter out requests
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, delyank@fb.com,
        qyousef@google.com, qyousef@layalina.io,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 4:57 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Some of the frequency update requests coming form the task scheduler
> might be filter out. It can happen when the previous request was served
> not that long ago (in a period smaller than provided by the cpufreq driver
> as minimum for frequency update). In such case, we want to know if some of
> the frequency updates cannot make through.
> Export the new tracepoint as well. That would allow to handle it by a
> toolkit for trace analyzes.
>
> Reported-by: kernel test robot <lkp@intel.com> # solved tricky build
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/trace/events/sched.h     |  4 ++++
>  kernel/sched/cpufreq_schedutil.c | 10 ++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index dbfb30809f15..e34b7cd5de73 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -739,6 +739,10 @@ DECLARE_TRACE(uclamp_update_tsk_tp,
>         TP_PROTO(struct task_struct *tsk, int uclamp_id,  unsigned int value),
>         TP_ARGS(tsk, uclamp_id, value));
>
> +DECLARE_TRACE(schedutil_update_filtered_tp,
> +       TP_PROTO(int cpu),
> +       TP_ARGS(cpu));
> +
>  #endif /* _TRACE_SCHED_H */
>
>  /* This part must be outside protection */
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index f462496e5c07..4f9daf258a65 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -6,6 +6,8 @@
>   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>   */
>
> +EXPORT_TRACEPOINT_SYMBOL_GPL(schedutil_update_filtered_tp);
> +
>  #define IOWAIT_BOOST_MIN       (SCHED_CAPACITY_SCALE / 8)
>
>  struct sugov_tunables {
> @@ -318,8 +320,10 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>
>         ignore_dl_rate_limit(sg_cpu);
>
> -       if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
> +       if (!sugov_should_update_freq(sg_cpu->sg_policy, time)) {
> +               trace_schedutil_update_filtered_tp(sg_cpu->cpu);

It looks like the tracepoint can be added to
sugov_should_update_freq() for less code duplication.

>                 return false;
> +       }
>
>         sugov_get_util(sg_cpu);
>         sugov_iowait_apply(sg_cpu, time, max_cap);
> @@ -446,8 +450,10 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
>
>         ignore_dl_rate_limit(sg_cpu);
>
> -       if (!sugov_should_update_freq(sg_policy, time))
> +       if (!sugov_should_update_freq(sg_policy, time)) {
> +               trace_schedutil_update_filtered_tp(sg_cpu->cpu);
>                 goto unlock;
> +       }
>
>         next_f = sugov_next_freq_shared(sg_cpu, time);
>
> --
