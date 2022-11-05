Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECED61DDB0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 20:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiKETY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 15:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiKETY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 15:24:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D963CBCBC
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 12:24:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h9so11179885wrt.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 12:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wGGJ4URwLjj7L0LkobyFRReAGKKnw9j2IZx477wjJtE=;
        b=p1GVR+rjRE8rNUk+Rx0/HUHNGL17FWl1dErbuJvmLqqm+6TK++KPKv1v8/bp3+nUfH
         f737khsa8R9iWI9LyBBzJmoHRwSCXr/ecLkkyjchWK4Gqf6mX7e8y13gBPTKWIxLN8Up
         iT7xdWUxczaiUGVU9UutvZqxbCfUSuPBAaXFGw8FtQehFuU3Z9wu5W7//RYsPdpcaGcT
         z9BT4uaoukSbgtz/Nun2V6iFn1395g7xO4R4TC6J22jX3tv0OSaZXXzAvPyjWK+ZtGl2
         r6Y9mcREqNvtyrOCWeUC+DRcWX4HXYVRnasVKsskXMuqpZjTQikIodIf1lV3CFJ6bZQA
         LQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGGJ4URwLjj7L0LkobyFRReAGKKnw9j2IZx477wjJtE=;
        b=dmdEOZHflqoY3YSYtE9VOVBsHgNIfz/VqIW7F/Vtxac3QLtWAXRxY/dlIl+IAL1qIp
         IO7ssvS4IrHyEXUKkOjJGvT5RFBtT4HZz5zKXJWmvaZ9IBNN46+bKiD1qTyiI+vTb760
         mi5uMHlrtM4PXcAHJoBB4Lp6/RfGiZqrJ7zYidZOVrW64bYXX1FwU2mzPSGh1P39i5yM
         /jae/YkthXtmjiShaGpbvhR6z33HGdbaNznRFZ3x4SSqBptS+jr4M4yXn5e5i97CzxMW
         AKGPSO6TZ8KkZByyeHugyliXMZPGc7ahOo0P2qf9GXdudD1teA7i8asxuAO15ahBJvsi
         zklQ==
X-Gm-Message-State: ANoB5pmPZMqKjyaHp8GeiZVM5uskOYbH6LSN5xYB+QmLaI0LDIuzW00F
        0TsP68OC8F0OB2wk8x3sW2r3tA==
X-Google-Smtp-Source: AA0mqf7z/wrLPZQMmPIxON0d4nYCWR2jfKYHVaNYpnYIoVQTbLa2Pux5nmGCEP1LsAxVUgEguc0jxw==
X-Received: by 2002:a5d:588f:0:b0:23a:e75d:eb67 with SMTP id n15-20020a5d588f000000b0023ae75deb67mr5476485wrf.606.1667676294482;
        Sat, 05 Nov 2022 12:24:54 -0700 (PDT)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id q188-20020a1c43c5000000b003cf894c05e4sm6569517wma.22.2022.11.05.12.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 12:24:54 -0700 (PDT)
Date:   Sat, 5 Nov 2022 19:24:52 +0000
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
Message-ID: <20221105192452.e6lgq55uyiij7ecf@airbuntu>
References: <20220804143609.515789-1-qais.yousef@arm.com>
 <20220804143609.515789-2-qais.yousef@arm.com>
 <xhsmhy1sqvd0a.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xhsmhy1sqvd0a.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/22 17:35, Valentin Schneider wrote:

> > +	/*
> > +	 * We must use capacity_orig_of() for comparing against uclamp_min and
> > +	 * uclamp_max. We only care about capacity pressure (by using
> > +	 * capacity_of()) for comparing against the real util.
> > +	 *
> > +	 * If a task is boosted to 1024 for example, we don't want a tiny
> > +	 * pressure to skew the check whether it fits a CPU or not.
> > +	 *
> > +	 * Similarly if a task is capped to capacity_orig_of(little_cpu), it
> > +	 * should fit a little cpu even if there's some pressure.
> > +	 *
> > +	 * Only exception is for thermal pressure since it has a direct impact
> > +	 * on available OPP of the system.
> > +	 *
> > +	 * We honour it for uclamp_min only as a drop in performance level
> > +	 * could result in not getting the requested minimum performance level.
> > +	 *
> 
> Why specifically care about OPPs here? Per our CPU capacity model, a task
> alone on a CPUx throttled to f=fmax/2 and a task coscheduled on a CPUy with
> RT/DL tasks and/or IRQs such that cpu_capacity(CPUy) = 50% are both getting
> (roughly) the same performance level.

Depends how you define performance level. What you call performance level,
I think is better called bandwidth. Uclamp is a performance and not a bandwidth
hint.

If a 10% task:

	p->util_avg = 10% * 1024

is requesting max performance level

	p->uclamp_min = 1024

This will translate to running at highest frequency and in case of big.LITTLE
system, the biggest CPU too.

RT/DL pressure has no impact in the task being able to achieve this; that is
running at max frequency and biggest cpu.

If the cpu has no bandwidth to fit this task, then our usual comparison of
util_avg with capacity_of() should fail as usual.

In the example above, the RT/DL pressure has to be pretty high for the 10% task
not to fit from bandwidth point of view. Which has nothing to do with
uclamp_min.  Only thermal pressure which drops OPPs can actually affect the
uclamp_min hint/request.

That is, when the task runs it will run at maximum frequency regardless of the
RT/DL pressure. The fact that the bandwidth of the CPU can be stolen has
nothing to do with uclamp_min hint.


Thanks!

--
Qais Yousef
