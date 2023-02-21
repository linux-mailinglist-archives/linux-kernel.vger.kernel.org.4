Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EF669DD07
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjBUJjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjBUJi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:38:57 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C7923116
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:38:56 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id c1so4615292plg.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj6vQZLrSWWD+JVkkdwnv1wMO911YnKC/YY+ocT764Q=;
        b=lB5hHcsMATDJzG1x4ZeUt8cnvYY/qmAYQIkZWDr8RDeeAg6ng9k1wd/gqfu/lhW71G
         nQBcVh7k4g7aYlEECfCsxE5c/UucvfS4fJV6pymQKpCrBrxnX3YHltO0sxBrk2tFEwTB
         4dST0dXggxVfREHVQdf0mbFDB9RnSLpYBu93HFJuj6tN4W82lNac64X7xTZgWrjBWT/7
         WV6srQNS5H0gRptQkzdm0+YZQOakgs3vCJGNWJ2VJWKn9h+IV+3fvU2RWzXfM8/DfmY2
         WKmYjxeVugV3UXeV2tVkmVrfZUZCS7nxsxXVM1eWO/TtJbmt6SyDFLWhJs12GU+htAEJ
         GIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gj6vQZLrSWWD+JVkkdwnv1wMO911YnKC/YY+ocT764Q=;
        b=7Q7IRYMmQbFdNyQl4JccYH7kOz+nj1sXKHuKDkgBoh0lyUL5BxwKf+JJQRRBFHAFVk
         kaq/mpy11/lrITY+SrffWEoc2R5iEi6dPfi+BLmlA0GStZp0ttUE8WG2HSaEAmFPpKOb
         dYF0kCrN/i/Cbx616wtJW/8HHvhIQaXX7GLN4ZAm69HNb0CCIyvRwrM/bROha6VVIuSX
         g765dA76xBxPz0KIb7f/hDW2sTXaBaZpZ9VXsrMfHUwcOQQ8DdCyRahcQNRbj1ac1nqv
         mIbAg4+4/l5GoTAqgm9Vx26bDW4MrEoXlyYIXwc2CtymqYmLGs2A8Xy3QJusOCtLkZcR
         aUtA==
X-Gm-Message-State: AO0yUKVgvYVPY+l12pPlxnaaHf7QvalZGs21pVm1IchIfFAdUF+aKQko
        KScuspPNU7w7j74lWL9AJV+9rTfyfgAudVXdLf8I2g==
X-Google-Smtp-Source: AK7set/Jq0MAXBl2ZCTSNMIVoQ9eZj2rBRYK4uCC/3TISWH1WO4yKEWTF/8wPSpTdJTfJIQEer7fwlURP78dbDLWay8=
X-Received: by 2002:a17:902:e888:b0:196:8798:404f with SMTP id
 w8-20020a170902e88800b001968798404fmr589121plg.5.1676972335536; Tue, 21 Feb
 2023 01:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20230209193107.1432770-1-rkagan@amazon.de>
In-Reply-To: <20230209193107.1432770-1-rkagan@amazon.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Feb 2023 10:38:44 +0100
Message-ID: <CAKfTPtB7ZDyCh0MiNQtyimVhYJ6E3C+2bTptj9CX3+mepH8YAQ@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: sanitize vruntime of entity being placed
To:     Roman Kagan <rkagan@amazon.de>
Cc:     linux-kernel@vger.kernel.org,
        Valentin Schneider <vschneid@redhat.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Ben Segall <bsegall@google.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 at 20:31, Roman Kagan <rkagan@amazon.de> wrote:
>
> From: Zhang Qiao <zhangqiao22@huawei.com>
>
> When a scheduling entity is placed onto cfs_rq, its vruntime is pulled
> to the base level (around cfs_rq->min_vruntime), so that the entity
> doesn't gain extra boost when placed backwards.
>
> However, if the entity being placed wasn't executed for a long time, its
> vruntime may get too far behind (e.g. while cfs_rq was executing a
> low-weight hog), which can inverse the vruntime comparison due to s64
> overflow.  This results in the entity being placed with its original
> vruntime way forwards, so that it will effectively never get to the cpu.
>
> To prevent that, ignore the vruntime of the entity being placed if it
> didn't execute for longer than the time that can lead to an overflow.
>
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> [rkagan: formatted, adjusted commit log, comments, cutoff value]
> Co-developed-by: Roman Kagan <rkagan@amazon.de>
> Signed-off-by: Roman Kagan <rkagan@amazon.de>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> v2 -> v3:
> - make cutoff less arbitrary and update comments [Vincent]
>
> v1 -> v2:
> - add Zhang Qiao's s-o-b
> - fix constant promotion on 32bit
>
>  kernel/sched/fair.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0f8736991427..3baa6b7ea860 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4656,6 +4656,7 @@ static void
>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>  {
>         u64 vruntime = cfs_rq->min_vruntime;
> +       u64 sleep_time;
>
>         /*
>          * The 'current' period is already promised to the current tasks,
> @@ -4685,8 +4686,24 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>                 vruntime -= thresh;
>         }
>
> -       /* ensure we never gain time by being placed backwards. */
> -       se->vruntime = max_vruntime(se->vruntime, vruntime);
> +       /*
> +        * Pull vruntime of the entity being placed to the base level of
> +        * cfs_rq, to prevent boosting it if placed backwards.
> +        * However, min_vruntime can advance much faster than real time, with
> +        * the exterme being when an entity with the minimal weight always runs
> +        * on the cfs_rq.  If the new entity slept for long, its vruntime
> +        * difference from min_vruntime may overflow s64 and their comparison
> +        * may get inversed, so ignore the entity's original vruntime in that
> +        * case.
> +        * The maximal vruntime speedup is given by the ratio of normal to
> +        * minimal weight: NICE_0_LOAD / MIN_SHARES, so cutting off on the
> +        * sleep time of 2^63 / NICE_0_LOAD should be safe.
> +        */
> +       sleep_time = rq_clock_task(rq_of(cfs_rq)) - se->exec_start;
> +       if ((s64)sleep_time > (1ULL << 63) / NICE_0_LOAD)
> +               se->vruntime = vruntime;
> +       else
> +               se->vruntime = max_vruntime(se->vruntime, vruntime);
>  }
>
>  static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
> --
> 2.34.1
>
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
>
