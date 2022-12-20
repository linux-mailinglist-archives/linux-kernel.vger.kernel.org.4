Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213BC651FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiLTLuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLTLuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:50:11 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E70015A2C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:50:10 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so10950309wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qEpSAjhLP8gIxC9dCi/+iFI+n2gBQG/RSMdt2E9cWHU=;
        b=kAOZpmUkYEpzga2KnMTZuxPUgzvBlnt76n6i1BA303YUDbS2lpP2lATkScmpfd8jdy
         6CYvm+/2igFszL6hXbwOV5LQBTPg/dbmiaREk4WESkeO1NaGoOgerSuKxfvmCymAqh69
         ndW8FxjBopXATfA3epT+GUGq77pZzsqX5ryC2GnyjK7Dm51rEa5X3cwjTJGfekqcNKjG
         9pJSlRXLApGiY3pf6YeGZkhf4a/AaRoDwQazscwRRlm4Yl0HoQTqPnz4OsOxse8RF7eq
         oDsWrFsCVCdUGHIbAtyiI6vXLFgSeg+vwo1M9vlEvZ2FGS/ZVmlOWJ23/xjwtu03Ek6n
         xoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEpSAjhLP8gIxC9dCi/+iFI+n2gBQG/RSMdt2E9cWHU=;
        b=Mz6AsaBXzelzL/sTAh0a+QdI1dPJzc+U8c7/Wz+tNls0fMHJUUXThtzfsuY5c8QA00
         pFckqfW9W+fpW5HVvb7gCfDWoOkIecEGYTUBOk3ivORKt8uWyfig5VfC5Q4clG9QOcCC
         gv4fIE6mdxLEjHicUlVgJKViBtXmAlNK++qU9F2cHQ14GQ3Xlgt3d3m+YpvpxfMdMgx5
         ugETTgg5o8Jhft8XN8t0sSI2rmU/uZvN+X82S7Rgybps47PM0ZWrIKWwzZ4GXVgOyx4r
         tApro9rSVTkEjmk63OjMDVQHNK0/Yeob86GpDKBw/F6L32cGjL7yJZvAaf5byTh6Qmpv
         Upjg==
X-Gm-Message-State: ANoB5pk0wJ+1uP+UB9cGyq/dvvihfhq7X3yweAohWPQqMXDlKp/QwxLs
        izk9FrAb0bkHlh7q9swMRb39Yw==
X-Google-Smtp-Source: AA0mqf483onNCTc+lfAEEtNKanNAyb6BeS40TZwzPR3NegFtpMtQVjaaZW7py5k7+qqQzt5OCW2sjg==
X-Received: by 2002:a05:600c:1da8:b0:3d1:e04f:9bf1 with SMTP id p40-20020a05600c1da800b003d1e04f9bf1mr35397538wms.35.1671537008687;
        Tue, 20 Dec 2022 03:50:08 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id bn22-20020a056000061600b002366e3f1497sm12748314wrb.6.2022.12.20.03.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 03:50:08 -0800 (PST)
Date:   Tue, 20 Dec 2022 11:50:07 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
Message-ID: <20221220115007.ouqsj5ejnhdyqwkn@airbuntu>
References: <20221127141742.1644023-4-qyousef@layalina.io>
 <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com>
 <20221203143323.w32boxa6asqvvdnp@airbuntu>
 <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
 <20221205110159.nd5igwvsaj55jar7@airbuntu>
 <CAKfTPtAOhQyfyH_qRArC2SZ1sQOBnRZ4CXARiWu2fvb+KPGsXw@mail.gmail.com>
 <20221208140526.vvmjxlz6akgqyoma@airbuntu>
 <20221209164739.GA24368@vingu-book>
 <20221212184317.sntxy3h6k44oz4mo@airbuntu>
 <1c3c1245-2576-df2e-246b-fc30657fcb56@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c3c1245-2576-df2e-246b-fc30657fcb56@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 18:38, Dietmar Eggemann wrote:
> On 12/12/2022 19:43, Qais Yousef wrote:
> > On 12/09/22 17:47, Vincent Guittot wrote:
> 
> [...]
> 
> > HMP systems for 1k servers just don't make any sense. A desktop with 128 or
> > even 256 HMP cores is a big stretch; and if that exist I don't think there's an
> > overhead to worry about here; and I *did* consider this. I measured the impact
> > if we have 128 and it was mere 1 or 2 us extra.  And that's on under powered
> > pine book pro. If such a system exist it'd probably be more performant.
> > 
> >> uclamp_min must not set a CPU overutilized because the CPU is not overutilized
> >> in this case. It's only the task that is misfit. You mostly try to bias some
> >> behavior to fit your use case.
> > 
> > Maybe we are talking about different things over here. As long as we agree it's
> > a misfit task then we are aligned.
> 
> IMHO, utilization is about the running task and uclamp is maintained
> taking the runnable tasks into consideration as well. Maybe that's the
> source of the different views here?

I don't think so, see below.

> 
> > As far as I know misfit required overutilized to re-enable load balance. But
> > maybe there's a detail that's creating this confusion.
> 
> I think that Vincent is suggesting to let MF load balance happening even
> in !OverUtilized (OU). We gather the necessary load-balance statistics
> already today in !OU so it is easily to do.

I think this is the cause of confusion. The current as it stands relies on OU
being set to enable misfit load balance.

If we decouple them as Vincent suggested - which is a good and independent
improvement - then yeah uclamp_min raising overutilized is not necessary. It's
just an artifact of how misfit load balance works today.

It's a general good improvement to not load misfit raise overutilized.

As discussed offline, Vincent will post independent patch with this
improvement.


Thanks!

--
Qais Yousef
