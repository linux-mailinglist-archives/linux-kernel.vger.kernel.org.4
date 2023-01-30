Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A804681CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjA3VjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjA3Vi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:38:59 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D563C6E80
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:38:28 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c124so8818093pfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tyddJd7/BDQFLiv0W0jcUssj4knaaFKB0Era7s1QU18=;
        b=Rz7BYoxkZNb2J3PQRCPuMSGc03TpKkC0DOxZUQ+brwxmwQy+r693FhqU0xtiZFThot
         6kEKyjqAo+HkeVRpvyTJ9wnSUR4OUff/ya55KORFjhA40180cp9Zdeg2obRv7Hgy4NLQ
         VX2jJuTnqdQjJdQrxQIaY3hTdeAIHd2teefPOwlY8pPKauPIkJrxRbtE5QhFxeqvTsK+
         BIaHPBwaxmogXVTH6TR3YAGI6j+40TB/PRdIZJAzdYdvmx9K0pTiD5CahDZn/ai/5ohj
         0Ga0+uj6/6VtEnmkmdCqzMP/pS7o0gDeibfbaxrCKvde1WrYQC74+tDjmzc7K0qhwXah
         nKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyddJd7/BDQFLiv0W0jcUssj4knaaFKB0Era7s1QU18=;
        b=x1/q7r2VFgN/7RbgO08QO+9vUpuXxH4fbDGyB2VOgPJIVHKoUMZvyjYcYwRuY2pJh3
         xZth1ApZMzUbySaYVjMRtDCWQRyqD4rKSWOfE+rjQ3A3jh2UlAMzoqchIaWvKmPb8SCk
         A1ys0eEO1Fnq+1W3BRAH2tTD8vrcNtJiK2obZJmYEojFJLx4YajGTVBMMGUssHQsbblX
         d+TysucQJFt7JtGLY92eCbF520BXrzgcSHQeuIxDWW6k38n2ULreCrYcsI49ZZR7aFEQ
         a3Hjy0x0OM2FH/ayryTretW+u5NVOJIdtTNj1fatroCvGrT6B48A9Ivn/eprdpsDsAn3
         Q8Fg==
X-Gm-Message-State: AO0yUKXm43b8/CmiQLQ85RIkNiNi0t4UEb5/fIZvVFs8LVXAde0eyBAY
        0jzBCsT+j+eVBm0S+nTo9YLF1Ukju9V/GiIFQyUhuQ==
X-Google-Smtp-Source: AK7set8vR38uMnC+hyU9xXQ6edkPkt2qNJB11lb7sd89FUPmn/s5vSIbZS5NbN5wxGICNf/MTA+KbuUD2D7USnCNfOw=
X-Received: by 2002:aa7:9792:0:b0:593:de7:3303 with SMTP id
 o18-20020aa79792000000b005930de73303mr1850852pfp.66.1675114707927; Mon, 30
 Jan 2023 13:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20230128001639.3510083-1-tj@kernel.org> <20230128001639.3510083-28-tj@kernel.org>
In-Reply-To: <20230128001639.3510083-28-tj@kernel.org>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 30 Jan 2023 13:38:15 -0800
Message-ID: <CABk29Nt2-CCGnogpfEgJ3ZDk5Esk04n6EwsAqpw_vdeVfKuFUQ@mail.gmail.com>
Subject: Re: [PATCH 27/30] sched_ext: Implement core-sched support
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        brho@google.com, pjt@google.com, derkling@google.com,
        haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
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

Hi Tejun,

On Fri, Jan 27, 2023 at 4:17 PM Tejun Heo <tj@kernel.org> wrote:
>
> The core-sched support is composed of the following parts:

Thanks, this looks pretty reasonable overall.

One meta comment is that I think we can shortcircuit from
touch_core_sched when we have sched_core_disabled().

Reviewed-by: Josh Don <joshdon@google.com>

> +                       /*
> +                        * While core-scheduling, rq lock is shared among
> +                        * siblings but the debug annotations and rq clock
> +                        * aren't. Do pinning dance to transfer the ownership.
> +                        */
> +                       WARN_ON_ONCE(__rq_lockp(rq) != __rq_lockp(srq));
> +                       rq_unpin_lock(rq, rf);
> +                       rq_pin_lock(srq, &srf);
> +
> +                       update_rq_clock(srq);

Unfortunate that we have to do this superfluous update; maybe we can
save/restore the clock flags from before the pinning shenanigans?

> +static struct task_struct *pick_task_scx(struct rq *rq)
> +{
> +       struct task_struct *curr = rq->curr;
> +       struct task_struct *first = first_local_task(rq);
> +
> +       if (curr->scx.flags & SCX_TASK_QUEUED) {
> +               /* is curr the only runnable task? */
> +               if (!first)
> +                       return curr;
> +
> +               /*
> +                * Does curr trump first? We can always go by core_sched_at for
> +                * this comparison as it represents global FIFO ordering when
> +                * the default core-sched ordering is in used and local-DSQ FIFO
> +                * ordering otherwise.
> +                */
> +               if (curr->scx.slice && time_before64(curr->scx.core_sched_at,
> +                                                    first->scx.core_sched_at))
> +                       return curr;

So is this to handle the case where we have something running on 'rq'
to match the cookie of our sibling (which had priority), but now we
want to switch to running the first thing in the local queue, which
has a different cookie (and is now the highest priority entity)? Maybe
being slightly more specific in the comment would help :)
