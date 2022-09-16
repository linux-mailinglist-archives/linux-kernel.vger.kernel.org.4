Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6775BAE4B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiIPNhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiIPNhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:37:08 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21E4AC255
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:37:06 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id p5so26026143ljc.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BNr579MPUpBlNB016dcpQJAUDBZMbLiiEVY+aFYhFJ0=;
        b=uz4sGI+1uL8AisIcwfRejIBgxha5ufOJQG2c8ni9YHCRRKwl8D1MClt+J7wzDAM9Cx
         ZdbSyhIfJnrK/ih20efRtNeWD7Lq+Pr9yOY9ZeYarWfRphPSFvwiNLxXDvaEEuYUNl1J
         5XkCVAWKPjtCGrRaG4EFuGX3iBkS85FI06eHkACDYxScys5bxA8MA8YHUKTtWnbayLhl
         gw86kxjUm57ES2Wx3byANyKxqorfi/E5xTDQc3qPVGXPJIeChCcdlBiupYUlL2bkBJWh
         /7mc638dbkRaodna5svrDs+lOgEVrFPBVCpHZOIQWHL5lXxSMBMRqg5aY/DxA6uDdSVm
         KoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BNr579MPUpBlNB016dcpQJAUDBZMbLiiEVY+aFYhFJ0=;
        b=oG01ukbR8rchgyH26DYwnK2hvMdsQrSn9qKagR47Vl+N7nG/qc2Vk++Oh5tMGEYIw4
         l7OnXGwy9TXd00fqNzZgXpL5bmYB3xUyril1DpEJoQF39YSGBaw2oyENFWSTOtVXslKF
         o5Bbq6INKO1qA4jgL0q7U/Zvr30vk5s29lFkyeJMFvQGPefnupgNdIzdKb+kRlzY4iFm
         IFiIAe2J1x3l44TT2abDSWFjLhu0PrXq4kxUORfntTwfGWJSsl9kPi0jJ4yUFJMhxLTb
         LXPU65GMT7Np9uu0M01u4HlDIQ6Q2UCayfxGF5obKgiN6GLeTEo6I7Wt9kRKOx7H9XBi
         eZ5Q==
X-Gm-Message-State: ACrzQf2xdTvC08xfN5Z03UI2jX0l9Bmu+GSZtnne62cE69U7y/LKlDS4
        JxksOtpcUG7A4PFzR+H5eU5eUkciKUeky9oBPMsw3Q==
X-Google-Smtp-Source: AMsMyM4o1CDq0lVx3zR3LBnFmOkRyaj7CUypLRlvapURWQhtGmNoNbRScG9H1KH1qSovAoMhJPhsAj0dE9VZ3RhRpKc=
X-Received: by 2002:a2e:bf01:0:b0:25f:df1a:f39d with SMTP id
 c1-20020a2ebf01000000b0025fdf1af39dmr1565245ljr.365.1663335424982; Fri, 16
 Sep 2022 06:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-6-vincent.guittot@linaro.org> <20220916120245.2951-1-hdanton@sina.com>
In-Reply-To: <20220916120245.2951-1-hdanton@sina.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 16 Sep 2022 15:36:53 +0200
Message-ID: <CAKfTPtDV+ACXtQGH38sXwFVJfq+EzyKO1mCMZ68Q+GC5kw7-ww@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] sched/fair: Take into account latency priority at wakeup
To:     Hillf Danton <hdanton@sina.com>
Cc:     peterz@infradead.org, mgorman@suse.de, valentin.schneider@arm.com,
        parth@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

On Fri, 16 Sept 2022 at 14:03, Hillf Danton <hdanton@sina.com> wrote:
>
> Hello Vincent
>
> On 16 Sep 2022 10:03:02 +0200 Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >
> > @@ -4606,6 +4608,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >
> >       se = __pick_first_entity(cfs_rq);
> >       delta = curr->vruntime - se->vruntime;
> > +     delta -= wakeup_latency_gran(curr, se);
> >
> >       if (delta < 0)
> >               return;
>
> What is derived from the latency nice you added is the runtime granulaity
> which has a role in preempting the current task.
>
> Given the same defination of latency nice as the nice, the runtime granularity
> can be computed without introducing the latency nice.
>
> Only for thoughts now.
>
> Hillf
>
> +++ b/kernel/sched/fair.c
> @@ -4569,7 +4569,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
>  static void
>  check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  {
> -       unsigned long ideal_runtime, delta_exec;
> +       unsigned long ideal_runtime, delta_exec, granu;
>         struct sched_entity *se;
>         s64 delta;
>
> @@ -4594,6 +4594,14 @@ check_preempt_tick(struct cfs_rq *cfs_rq
>                 return;
>
>         se = __pick_first_entity(cfs_rq);
> +
> +       granu = sysctl_sched_min_granularity +
> +               (ideal_runtime - sysctl_sched_min_granularity) *
> +               (se->latency_nice + 20) / LATENCY_NICE_WIDTH;

There is no latency_nice field in se but a latency_offset instead

Also at this step, we are sure that curr has run at least
sysctl_sched_min_granularity and we want now to compare curr vruntime
with first se's one. We take the latency offset into account to make
sure we will not preempt curr too early

> +
> +       if (delta_exec < granu)
> +               return;
> +
>         delta = curr->vruntime - se->vruntime;
>
>         if (delta < 0)
