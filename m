Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5452E610670
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiJ0Xeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiJ0Xe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:34:28 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DF2207
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:34:25 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id b18so6144081ljr.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 16:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CkAg4Cf2Dr1/ZG6/7TtW6bvWXD4NPZ0KSNCmhf5kxE0=;
        b=NFaYACGUhqX3+oSi6T4T4MarI8BT/FEzojfdSwXkJA21c7ZoRJ3jAQqyU+BpSp9uPV
         0AwMvnVdWTBE6KaNcVCcszSheuGdTUUXKrlHBXS45eL7sdhHm4t2OsJBcnegMePQvVEB
         /FRDmnCqrA8wRVPlATDqnEP/LpN9Ug+nyopBzb+Ut2XD+4s+Mivy3ukoZgQ31INnwSV4
         GC/YX1Xi6g2BtfoyG8MC8Ng94Fjws2K5QTylcBRHtRb0Uzu9uESLn1QSevpsLRSrjtbD
         o7mIwcoXwSau6yyXGNn4sNg38w/2TV9Iu/RfvBBCYIPgCM7tX5+wpNi4iZ3/VHNp11+s
         IF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CkAg4Cf2Dr1/ZG6/7TtW6bvWXD4NPZ0KSNCmhf5kxE0=;
        b=fZY0pp/K3/NimkNhxm6JvjoNZoX/b61dhydprtqr6iQxi0jV4EBhX0EXlyIWqBr8C8
         auiF4wWr5QiXY3WDxapgefSqmokX+bFhSray0V7VZlGNfi3KMxMXvg27CD/jwVCgOhZk
         uM/KYN7VXtmn1qp93VPMOZ4dQ/Vr698DsYKglW9LXIvEgRTbXGQe2V8jHmD8VKlCJD4J
         2w5hYqe19nWDYUnmoA6JwP12N1d+jDK+8S+95y0oxj7qT9+mVxo7AZxNbYJtF/MtlSJr
         IlJ9OIghna7D0KYl9+7vRo7sxSvPq5b4l0agB4YHH+ZP6/adJiCK+TDEPheXohGjlGPe
         x3XA==
X-Gm-Message-State: ACrzQf2QvMVYOA+YtoDDOKfBDMEOrxLTGIATtp9ac/omiaAFVij2hLb3
        CWXFumHyv2i1jOvNA/9y5tjYhAhl/MiAEFs2hZXvFg==
X-Google-Smtp-Source: AMsMyM5s3icc4aR91tnTEmt3hvt4uu+H5Zckq1lPUaOftUGlZ25tahRHBaqgAEkfqzEpazz8CcwJ/MLMZupl97FeyGw=
X-Received: by 2002:a2e:9a8f:0:b0:277:2427:53cd with SMTP id
 p15-20020a2e9a8f000000b00277242753cdmr3694141lji.52.1666913663447; Thu, 27
 Oct 2022 16:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221027081630.34081-1-zhouchuyi@bytedance.com>
In-Reply-To: <20221027081630.34081-1-zhouchuyi@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 27 Oct 2022 16:34:11 -0700
Message-ID: <CABk29NtDny9qKZbZZ_i8Brwjtqs5GA0G4_SffzK4HzG3RrXVhQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: favor non-idle group in tick preemption
To:     Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
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

Hi Chuyi,

On Thu, Oct 27, 2022 at 1:16 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>
> The non-idle se dominates competition vs the idle se when they
> are belong to the same group. We ensure that idle groups would not
> preempt non-idle group in wakeup preemption(see check_preempt_wakeup()).
> However, this can happen in tick preemption, since check_preempt_tick()
> dose not check current/se is idle or not. This patch adds this check.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  kernel/sched/fair.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e4a0b8bd941c..f3324b8753b3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4750,6 +4750,7 @@ static void
>  check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  {
>         unsigned long ideal_runtime, delta_exec;
> +       int cse_is_idle, pse_is_idle;
>         struct sched_entity *se;
>         s64 delta;
>
> @@ -4779,8 +4780,17 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>         if (delta < 0)
>                 return;
>
> -       if (delta > ideal_runtime)
> +       if (delta > ideal_runtime) {
> +               /*
> +                * Favor non-idle group even in tick preemption
> +                */
> +               cse_is_idle = se_is_idle(curr);
> +               pse_is_idle = se_is_idle(se);
> +               if (unlikely(!cse_is_idle && pse_is_idle))
> +                       return;

This would make it so that we never have tick based preemption of a
non-idle entity by an idle entity. That's a recipe for starvation of
the idle entity, if the non-idle entity is cpu bound.

Beyond that though, I'm not quite sure the issue being solved here.
The large difference in weight between the idle and non-idle entity
means that the non-idle entity will not be preempted for quite a while
due to its ideal_runtime being quite high. The idle entity will
quickly be preempted on the next tick it takes due to the smaller
value of sysctl_sched_idle_min_granularity.

The wakeup check is useful for latency sensitive non-idle tasks.
However, in steady state competition between idle and non-idle, we
must allow some amount of round-robin.

> +
>                 resched_curr(rq_of(cfs_rq));
> +       }
>  }
>
>  static void
> --
> 2.20.1
>

Best,
Josh
