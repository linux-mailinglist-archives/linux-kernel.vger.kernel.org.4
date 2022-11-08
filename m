Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D354E620F25
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiKHLd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiKHLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:33:57 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE861277E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:33:55 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so11488789wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tydk6A1vUHzb19qfF3RhmJ3O+utBlcG181vL7xWHS+E=;
        b=TQsBcPp6f5lb3uLfJsHvB9eseFQcXaW1SDi/9RqpZ3fjAqD9TDxHcoKRW7ROCVxgmm
         khNyE9oIkJOV6sEbgN20bZBimtH+ZF16dZazPEaDCyRFAznHuKJkBSfAhjKWxXU5yUyJ
         idguAp6MjlP+8hit1GwazYBBN6S1ETqm9q4L/2rdG550lqB29rbQbou5OCF10KM2SXt7
         naKD7LDV1NJpDRjM7uC89rgap9Gz7Enu0jRtMwjoyejHbPtA95+5rLmZ16X2EW5iCW8W
         nyFqO+04EWqMQ7av2M09H5pzs2EKL3lWxgHCPIeBPCcOsuZDS1QywCfFriaMndVpHl3b
         6wIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tydk6A1vUHzb19qfF3RhmJ3O+utBlcG181vL7xWHS+E=;
        b=uvrfQKgH8WzHNZ/j+ODcNRxrH08fq8OKoyr+IR4qgE3VTakHLaP+s7n3N7rQfoqGF3
         eTOEi1hokK6OrQnHx0NKTdobaYNJ/iSYxtxFSVz7yYY53iRHkigx1/wRC578TjCGIS/W
         SQxQ3oBZwgGZalBI0vniXGTwIhrc8M2+lMV3htXnwfdQXRTSLDiwDiZPdoOEN3cvUzj2
         GNVrOWxrN82FX0Kpx6xPrhAUXdqyT9BCc2IeMynYrjlPnc/TTDAIXOfhkj+pypmz/X6o
         O5C6sYdfMRK5wQB4HoNqda4a1JzMw/JKW6x8NKblQi7bXJH0oF9PtN4s0G13izLXxrXy
         1fZA==
X-Gm-Message-State: ACrzQf0Utk8PkrJyBXVqVczBRsFErBkJS96scxMADVq4DzFj9QbW+KVJ
        fbLXuRo3sl8XirHrxR6/O2oNpA==
X-Google-Smtp-Source: AMsMyM7GV4PhnE1vLoGzwYkpCLqSzY6e3TVi13CfdbOQWz4VwbbzqopJsBwkvux77rCuINlro6KbxA==
X-Received: by 2002:a05:600c:3c82:b0:3b5:60a6:c80f with SMTP id bg2-20020a05600c3c8200b003b560a6c80fmr37149375wmb.199.1667907233622;
        Tue, 08 Nov 2022 03:33:53 -0800 (PST)
Received: from airbuntu ([104.132.45.106])
        by smtp.gmail.com with ESMTPSA id i5-20020adffc05000000b0023660f6cecfsm10023313wrr.80.2022.11.08.03.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 03:33:53 -0800 (PST)
Date:   Tue, 8 Nov 2022 11:33:51 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Subject: Re: [PATCH v2 1/9] sched/uclamp: Fix relationship between uclamp and
 migration margin
Message-ID: <20221108113351.ne4kobarl5ooqffp@airbuntu>
References: <20220804143609.515789-1-qais.yousef@arm.com>
 <20220804143609.515789-2-qais.yousef@arm.com>
 <xhsmhy1sqvd0a.mognet@vschneid.remote.csb>
 <20221105192452.e6lgq55uyiij7ecf@airbuntu>
 <xhsmhpmdymw1n.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xhsmhpmdymw1n.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/22 18:58, Valentin Schneider wrote:
> On 05/11/22 19:24, Qais Yousef wrote:
> > On 11/04/22 17:35, Valentin Schneider wrote:
> >
> >> > +	/*
> >> > +	 * We must use capacity_orig_of() for comparing against uclamp_min and
> >> > +	 * uclamp_max. We only care about capacity pressure (by using
> >> > +	 * capacity_of()) for comparing against the real util.
> >> > +	 *
> >> > +	 * If a task is boosted to 1024 for example, we don't want a tiny
> >> > +	 * pressure to skew the check whether it fits a CPU or not.
> >> > +	 *
> >> > +	 * Similarly if a task is capped to capacity_orig_of(little_cpu), it
> >> > +	 * should fit a little cpu even if there's some pressure.
> >> > +	 *
> >> > +	 * Only exception is for thermal pressure since it has a direct impact
> >> > +	 * on available OPP of the system.
> >> > +	 *
> >> > +	 * We honour it for uclamp_min only as a drop in performance level
> >> > +	 * could result in not getting the requested minimum performance level.
> >> > +	 *
> >>
> >> Why specifically care about OPPs here? Per our CPU capacity model, a task
> >> alone on a CPUx throttled to f=fmax/2 and a task coscheduled on a CPUy with
> >> RT/DL tasks and/or IRQs such that cpu_capacity(CPUy) = 50% are both getting
> >> (roughly) the same performance level.
> >
> > Depends how you define performance level. What you call performance level,
> > I think is better called bandwidth. Uclamp is a performance and not a bandwidth
> > hint.
> >
> > If a 10% task:
> >
> >       p->util_avg = 10% * 1024
> >
> > is requesting max performance level
> >
> >       p->uclamp_min = 1024
> >
> > This will translate to running at highest frequency and in case of big.LITTLE
> > system, the biggest CPU too.
> >
> > RT/DL pressure has no impact in the task being able to achieve this; that is
> > running at max frequency and biggest cpu.
> >
> > If the cpu has no bandwidth to fit this task, then our usual comparison of
> > util_avg with capacity_of() should fail as usual.
> >
> 
> Ok so we *do* have this with how the fitting criteria are combined (I
> didn't get that when I first scanned through the code); thanks for
> elaborating on that.

Oh yeah, this hasn't changed.

> 
> > In the example above, the RT/DL pressure has to be pretty high for the 10% task
> > not to fit from bandwidth point of view. Which has nothing to do with
> > uclamp_min.  Only thermal pressure which drops OPPs can actually affect the
> > uclamp_min hint/request.
> >
> > That is, when the task runs it will run at maximum frequency regardless of the
> > RT/DL pressure. The fact that the bandwidth of the CPU can be stolen has
> > nothing to do with uclamp_min hint.
> >
> >
> > Thanks!
> >
> > --
> > Qais Yousef
> 
