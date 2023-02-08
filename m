Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C466A68E94A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBHHsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBHHsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:48:18 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56860CC1B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:48:17 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o16-20020a17090ad25000b00230759a8c06so1454603pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 23:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YDb46wbs7Oglszax+zQd4w6i8ViSPc6VOYFdKzRkn4I=;
        b=q6mv6ckiyC7uZBYepeGxsYYHY35eFge4JvWX7ajc76F79EtwCT70FH171xtZqGxICR
         RRoxkElfhXhStfnBLTet5lStDKk2exsBQ4ucY7i+JCL07RqDneLaf5ZQhmHwxJBQt9eY
         //BcpiVOIIr51T0Ggp2qQCjN09feYP64ROMyJkvcGX5hxBJiuz+QA61TdS7uCyGi1nAh
         g8/2tLNTWgh4f7sPDh2FqUxQD8oHgVyU6TUb47m3IBTM2Ef8vYKzsx6HICRJ0SewRBuH
         WVFAdRIp2Z/KJv+8Qoa0bWD5Gd8Q5gtKmjns2byyH+cjV41g0Q6ZiosACzGOC0D1+63q
         egLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDb46wbs7Oglszax+zQd4w6i8ViSPc6VOYFdKzRkn4I=;
        b=PBOz+/whQ2nI0u5oeFy/73qy7vP0lkc0NUChj+1M1SlXjySeeegTX1yATb550URUd/
         8cIAPAQbg2smbRp14o9d7LtPwhsOKsWG9BTJroZIxTUAjxly/g1iA+R+4wf1SBm4Kzjh
         08Xb8aqusK7/WD7fCIzEdjte3h5x/DcIa4Lw8b3ctmk1RqKC7HIaNxGEklZjHGlwxPHC
         lshGy8ws9iM1+wjMM4gGWb8ANcbvGyiGIBLzZW/I+yyxstJFtUkzjk3XwvJrlWPV16sB
         q6Z5vF6mPTFcsEbDFOx1I/KXzWEI7/jhvParOehpahQxiM94z+r/4o0fxeLmC7RTFmpb
         yI5g==
X-Gm-Message-State: AO0yUKX90hY8e4aaZGFljLyu5K3jBva3FjyGFiGm03ELvklsZJMWxl68
        T9REcdAVY4ZKftRvlSrJznS2mln4Sgc9i65iVKMo9g==
X-Google-Smtp-Source: AK7set/2+IuJ9Z1nS2sqc8bZXh3HxZ610puL926atkTwcL4wxNrZFAaRLdeBihZ3YI4gZJQ90w08M3qmShm3YZ43Yy8=
X-Received: by 2002:a17:902:c950:b0:196:6c8c:288f with SMTP id
 i16-20020a170902c95000b001966c8c288fmr1623141pla.32.1675842496761; Tue, 07
 Feb 2023 23:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com> <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 8 Feb 2023 08:48:05 +0100
Message-ID: <CAKfTPtAZ8sfDi1GbKSioJkszkRT6f+am5OSjKKKKv2q_4FKQFQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
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
> SD_PREFER_SIBLING is set from the SMT scheduling domain up to the first
> non-NUMA domain (the exception is systems with SD_ASYM_CPUCAPACITY).
>
> Above the SMT sched domain, all domains have a child. The SD_PREFER_
> SIBLING is honored always regardless of the scheduling domain at which the
> load balance takes place.
>
> There are cases, however, in which the busiest CPU's sched domain has
> child but the destination CPU's does not. Consider, for instance a non-SMT
> core (or an SMT core with only one online sibling) doing load balance with
> an SMT core at the MC level. SD_PREFER_SIBLING will not be honored. We are
> left with a fully busy SMT core and an idle non-SMT core.
>
> Avoid inconsistent behavior. Use the prefer_sibling behavior at the current
> scheduling domain, not its child.
>
> The NUMA sched domain does not have the SD_PREFER_SIBLING flag. Thus, we
> will not spread load among NUMA sched groups, as desired.

This is a significant change in the behavior of the numa system. It
would be good to get figures or confirmation that demonstrate that
it's ok to remove prefer_sibling behavior at the 1st numa level.

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
>  kernel/sched/fair.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index df7bcbf634a8..a37ad59f20ea 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10004,7 +10004,6 @@ static void update_idle_cpu_scan(struct lb_env *env,
>
>  static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sds)
>  {
> -       struct sched_domain *child = env->sd->child;
>         struct sched_group *sg = env->sd->groups;
>         struct sg_lb_stats *local = &sds->local_stat;
>         struct sg_lb_stats tmp_sgs;
> @@ -10045,9 +10044,11 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>                 sg = sg->next;
>         } while (sg != env->sd->groups);
>
> -       /* Tag domain that child domain prefers tasks go to siblings first */
> -       sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
> -
> +       /*
> +        * Tag domain that @env::sd prefers to spread excess tasks among
> +        * sibling sched groups.
> +        */
> +       sds->prefer_sibling = env->sd->flags & SD_PREFER_SIBLING;
>
>         if (env->sd->flags & SD_NUMA)
>                 env->fbq_type = fbq_classify_group(&sds->busiest_stat);
> @@ -10346,7 +10347,6 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>                         goto out_balanced;
>         }
>
> -       /* Try to move all excess tasks to child's sibling domain */
>         if (sds.prefer_sibling && local->group_type == group_has_spare &&
>             busiest->sum_nr_running > local->sum_nr_running + 1)
>                 goto force_balance;
> --
> 2.25.1
>
