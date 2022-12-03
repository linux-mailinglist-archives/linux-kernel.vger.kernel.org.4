Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9851641753
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 15:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLCOda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 09:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLCOdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 09:33:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB1012774
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 06:33:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o30so5526015wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 06:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHMWSdrH2WRF10mVDjxBf7QyYX5TvTZfyuslwjhHGuI=;
        b=l21TzG1NH94DGWvm+VdNnUA7UxNBxg/E0y4GBqlYUS1cTmeuYrgXQch6vry0hXZsTa
         T/YqftlFT0g+E5yEyVFsomET8djBmppgIUEbReO5YIty6WeN2oh/iEEG57N2Hr12fzRm
         82h9mq2lno9/gWdWtZlm6gyZ4cckSwYpozA6dzia+/GPkJ5ZrOXnskfdAdypgkzYYIrB
         0dzsvas9eqUkkS0DUUM73dAb0Z0uPdUZoUZ+upy+VyRwm2N+vOyJ0urkE0mU5dJZAkCt
         cTq7SJWybP2hGYxa6z4Zw9VDLzMxlg8XB43Of+jjimwtMCXgH1i2If3Xz2j97bdlSOQ8
         IjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHMWSdrH2WRF10mVDjxBf7QyYX5TvTZfyuslwjhHGuI=;
        b=uWNQvHvJqkkCTgC3un/P5MysDhX347AKOnWOJ5bLGtBfyhX3EQpPJwrh4Gdw+cepN8
         VeZkdgWfz1Oytqu/tdJKm+y8VGLskGvuR775kDq5QukfaluAwZqQFY0nxRZDQNPH4w1u
         uqRXCtDTNN2Fv8F8KnBFWE8BQUnNoKKYQSUANYBmMnXNDl5Z7rdLPjgcTtlzpR7vNNY2
         qRa6US7fbxI9KkRLnyo85R6j5OjQ5UNyZmi4ZZ1AXruaJYHM3h9WsifmFXTeXPidLFO5
         nnn6MqXKDydIRobI+ZS8U6/5dQ0CRiFfZnUsVqfYgzyhnrm0KDUlMIUlDsUSjgTgoNwT
         tyGw==
X-Gm-Message-State: ANoB5pkkseczYjEwu8ZU1/b8zBkk9lhbaEZKGXJ/jyGdd0Jbl6IZUA9K
        0xwYygFNm5bkDpntlIZcvjnoQA==
X-Google-Smtp-Source: AA0mqf5u7u/taARsvOEgfrHeU+VF2t3L7/Nm5lvApqz8nxAjGOPF5d84qpPb06m4w/J0QqZqUOdxCQ==
X-Received: by 2002:a05:600c:288:b0:3cf:758f:161f with SMTP id 8-20020a05600c028800b003cf758f161fmr51632723wmk.54.1670078004536;
        Sat, 03 Dec 2022 06:33:24 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d46c8000000b0023662d97130sm9671405wrs.20.2022.12.03.06.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 06:33:24 -0800 (PST)
Date:   Sat, 3 Dec 2022 14:33:23 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
Message-ID: <20221203143323.w32boxa6asqvvdnp@airbuntu>
References: <20221127141742.1644023-1-qyousef@layalina.io>
 <20221127141742.1644023-4-qyousef@layalina.io>
 <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/22 15:57, Vincent Guittot wrote:

> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 7c0dd57e562a..4bbbca85134b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8856,23 +8856,20 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> >          *   * Thermal pressure will impact all cpus in this perf domain
> >          *     equally.
> >          */
> > -       if (sched_energy_enabled()) {
> > +       if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> >                 unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> > -               struct perf_domain *pd = rcu_dereference(rq->rd->pd);
> > +               struct cpufreq_policy *policy, __maybe_unused *policy_n;
> >
> >                 rq->cpu_capacity_inverted = 0;
> >
> > -               SCHED_WARN_ON(!rcu_read_lock_held());
> > -
> > -               for (; pd; pd = pd->next) {
> > -                       struct cpumask *pd_span = perf_domain_span(pd);
> > +               for_each_active_policy_safe(policy, policy_n) {
> 
> So you are looping all cpufreq policy (and before the perf domain) in
> the period load balance. That' really not something we should or want
> to do

Why is it not acceptable in the period load balance but acceptable in the hot
wake up path in feec()? What's the difference?


Thanks!

--
Qais Yousef
