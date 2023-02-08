Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3AB68E965
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjBHH4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBHH4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:56:46 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9A02B60C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:56:44 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id n2so12534541pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 23:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=crkO54afLAgsJgdC5GpCChR+pEjtVxO1bJbJ06Q0a9A=;
        b=MUyFTQeKZHQfSOUJdukzCiukH4Ua+tMjRllnEcvbRibBH1Ydn9cPXuiLv0BiErmxKV
         9ttRxFXha1O6tUQVhGfi5kgng19LedssfvarpgXzP84fBV1THPuUa7hx8LF8pHwmj1+E
         OK8fkw/ncfFqqLr7CzmX0uTWCK5ON9JV6WcFiCWAXWUyN6m5R+2iHg+oARbqvdPhno6d
         kU4fd/YAgh8syPB2+VW6inGhiQaG662c3eGklkLxcxNKU6PIFSifY+OEbeBjmqBQKFtU
         BfAAuew90eC4uSi9FRjzv8Drjp28CCqk7YYMUPnWTpcumTFdOs7CgiwiAr5wFkmJrLNl
         WIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crkO54afLAgsJgdC5GpCChR+pEjtVxO1bJbJ06Q0a9A=;
        b=JWgMj63vAeUJs2SNXRtd3HJ31N055pyxaw2Jz3FuC5zdS69myblFfA8YP2MoOhEbzX
         IEvsBEvOv3k8+QBFSR0QdougonFV5vdGUBTBiU52BkzHV6hxdRlGiUIBajhtZa/i75om
         6K/l9rAW7w+X/nNVeTfqVkN0pbpMHAHQ/w8E1jvZrecf3/DwxhSttTFAQ03e+JcuDc1G
         V1CrSexkT9/YIB/RdLFm1V7FFJDVo7KXyX2itEthGTdCxBeLjvdpGvoEmYTrK2vvqGVj
         hGDUUWRKsnuVXl42xiG0DKb4NnEYPkAwiov1oWlvXQnIi/ndnGBh3C4Jl/IepzaIAB0n
         8AGw==
X-Gm-Message-State: AO0yUKVs6TMd/J9s9nRUdNGdbUwa80zt6ioOD9zJ3Ml+9TSkAPFolchh
        ipy+1gKlJoDU/+Oz8TRYJWuARm26VqRQVOoL0rw3sg==
X-Google-Smtp-Source: AK7set8ATv7Jv51fWR/roo/jzNf7bMqH4w+qKf1lOVZ3pghRlN7fsOG+zMrvSvGgTOz2insHe8tHvHVMVJUlp9ff9hY=
X-Received: by 2002:a62:31c6:0:b0:591:4b17:22b5 with SMTP id
 x189-20020a6231c6000000b005914b1722b5mr645704pfx.14.1675843003468; Tue, 07
 Feb 2023 23:56:43 -0800 (PST)
MIME-Version: 1.0
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com> <20230207045838.11243-5-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20230207045838.11243-5-ricardo.neri-calderon@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 8 Feb 2023 08:56:32 +0100
Message-ID: <CAKfTPtB_YR8e6fcx3Un0vTeJR4EJS9sOXG=wLb8rZeM5Ub4yyA@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] sched/fair: Let low-priority cores help
 high-priority busy SMT cores
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2023 at 05:50, Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Using asym_packing priorities within an SMT core is straightforward. Just
> follow the priorities that hardware indicates.
>
> When balancing load from an SMT core, also consider the idle of its
> siblings. Priorities do not reflect that an SMT core divides its throughput
> among all its busy siblings. They only makes sense when exactly one sibling
> is busy.
>
> Indicate that active balance is needed if the destination CPU has lower
> priority than the source CPU but the latter has busy SMT siblings.
>
> Make find_busiest_queue() not skip higher-priority SMT cores with more than
> busy sibling.
>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim C. Chen <tim.c.chen@intel.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v2:
>  * Introduced this patch.
>
> Changes since v1:
>  * N/A
> ---
>  kernel/sched/fair.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 80c86462c6f6..c9d0ddfd11f2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10436,11 +10436,20 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>                     nr_running == 1)
>                         continue;
>
> -               /* Make sure we only pull tasks from a CPU of lower priority */
> +               /*
> +                * Make sure we only pull tasks from a CPU of lower priority
> +                * when balancing between SMT siblings.
> +                *
> +                * If balancing between cores, let lower priority CPUs help
> +                * SMT cores with more than one busy sibling.
> +                */
>                 if ((env->sd->flags & SD_ASYM_PACKING) &&
>                     sched_asym_prefer(i, env->dst_cpu) &&
> -                   nr_running == 1)
> -                       continue;
> +                   nr_running == 1) {
> +                       if (env->sd->flags & SD_SHARE_CPUCAPACITY ||
> +                           (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && is_core_idle(i)))

This 2nd if could be merged with the upper one
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10518,11 +10518,10 @@ static struct rq *find_busiest_queue(struct
lb_env *env,
                 */
                if ((env->sd->flags & SD_ASYM_PACKING) &&
                    sched_asym_prefer(i, env->dst_cpu) &&
-                   nr_running == 1) {
-                       if (env->sd->flags & SD_SHARE_CPUCAPACITY ||
-                           (!(env->sd->flags & SD_SHARE_CPUCAPACITY)
&& is_core_idle(i)))
+                   (nr_running == 1) &&
+                   (env->sd->flags & SD_SHARE_CPUCAPACITY ||
+                           (!(env->sd->flags & SD_SHARE_CPUCAPACITY)
&& is_core_idle(i))))
                                continue;
-               }

                switch (env->migration_type) {
                case migrate_load:
---

AFAICT, you can even remove one env->sd->flags & SD_SHARE_CPUCAPACITY
test with the below but this make the condition far less obvious

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a6021af9de11..7dfa30c45327 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10518,11 +10518,10 @@ static struct rq *find_busiest_queue(struct
lb_env *env,
                 */
                if ((env->sd->flags & SD_ASYM_PACKING) &&
                    sched_asym_prefer(i, env->dst_cpu) &&
-                   nr_running == 1) {
-                       if (env->sd->flags & SD_SHARE_CPUCAPACITY ||
-                           (!(env->sd->flags & SD_SHARE_CPUCAPACITY)
&& is_core_idle(i)))
+                   (nr_running == 1) &&
+                   !(!(env->sd->flags & SD_SHARE_CPUCAPACITY) &&
+                       !is_core_idle(i)))
                                continue;
-               }

> +                               continue;
> +               }
>
>                 switch (env->migration_type) {
>                 case migrate_load:
> @@ -10530,8 +10539,20 @@ asym_active_balance(struct lb_env *env)
>          * lower priority CPUs in order to pack all tasks in the
>          * highest priority CPUs.
>          */
> -       return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
> -              sched_asym_prefer(env->dst_cpu, env->src_cpu);
> +       if (env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING)) {
> +               /* Always obey priorities between SMT siblings. */
> +               if (env->sd->flags & SD_SHARE_CPUCAPACITY)
> +                       return sched_asym_prefer(env->dst_cpu, env->src_cpu);
> +
> +               /*
> +                * A lower priority CPU can help an SMT core with more than one
> +                * busy sibling.
> +                */
> +               return sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
> +                      !is_core_idle(env->src_cpu);
> +       }
> +
> +       return false;
>  }
>
>  static inline bool
> --
> 2.25.1
>
