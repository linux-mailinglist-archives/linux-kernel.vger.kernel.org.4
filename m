Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C77696C74
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjBNSKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjBNSKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:10:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C1855A7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:10:16 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id he5so3753846wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VzmCI5BRei19wPOVafVhuihEl0GYlrqi5ocie9N5jI8=;
        b=2niTtN2BnZA/CH00WRUbEuDTHT8eZdzWrDrqm2kGyB8VrN1hLuGnX5YjXXtGNzWftx
         LgWhXp/Z1rc3rkIH7zAuLt334QHjSazEUSkASowMFGbmc44jn7P8xllO6sL/JPnizNO1
         FJl4i9Pd7yeL/734BIGg/lrgbHyNqRJoHH4QIV04uX66dAwmf1EsIGRk+cAELqGphmqX
         RVYZ+v1kJ7Gw3FCoyOUISgwa6RtWU/zD3h7t/P9kdG2GzkdgmNFYOOfiR/5B4829D5Tj
         wq/n0tJM3Ghi5vb4KOlIstSiQ91PX5FzvqW/tt5CQcjX1Jcm2+vViAoFJV26Nfp67y/6
         UG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzmCI5BRei19wPOVafVhuihEl0GYlrqi5ocie9N5jI8=;
        b=LZt8Jm7m84g4tLOQ7kjCUSmAGtYoaJJEK/vGNDUEm0NMduOtHiFj63HcaazrY/M69o
         iOEum0FD1KzdmimYNmhCoX+0X3W9yMGlCyjdSc92iY7e/8wq3WJbrFZ/IYlcNo2gIq3L
         d5h+mvOFs1ggKAKDIKdzX03iS+rUjDFUxz/QMouIio0Gwp6BE8F+5ev8GF69yUAdL8/N
         3MaFESnNRz8AloQ3ypvQ5Dy1S9XcHfjySHUUHDAbPopvMb9WEFu/WXGLt/2/GyCpPEm9
         UDyNOMMQb9ZK9Hth0HpeBZx3zSM2lcZdZsjsgk0Zmp4yG4Iur8zxLx8aULOJYhynXf0g
         45vQ==
X-Gm-Message-State: AO0yUKUu/MJlsDa+aqIAhLF+43jDvlVP7btZBLLFObEHnU+Q1/qHkpXc
        QDYgNRqSOSpeLa/JR09Tiq4kFQ==
X-Google-Smtp-Source: AK7set8uwRi/PJptQOEhqs3L0IZhZE5ptSINUtFfFJVZtgWIALJnPtJSxCMhu9e8v+3fjI3vd5/mNw==
X-Received: by 2002:a05:600c:4b1d:b0:3df:fbc7:5b10 with SMTP id i29-20020a05600c4b1d00b003dffbc75b10mr2862308wmp.0.1676398214938;
        Tue, 14 Feb 2023 10:10:14 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c2cd000b003daffc2ecdesm22129494wmc.13.2023.02.14.10.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 10:10:14 -0800 (PST)
Date:   Tue, 14 Feb 2023 18:10:13 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [PATCH v2 2/3] sched/uclamp: Ignore (util == 0) optimization in
 feec() when p_util_max = 0
Message-ID: <20230214181013.hdtqkh26rbpuuzig@airbuntu>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-3-qyousef@layalina.io>
 <CAKfTPtCf4+orEhYmFBg+tsMH7e5sV5zJZ1k8apjZkYwSAxAu+w@mail.gmail.com>
 <d7f29def-7004-b62d-9266-3ad997111e2f@arm.com>
 <20230211180119.4mbfn7j3skvoasop@airbuntu>
 <d7b319cc-5c02-df0f-44d5-cd3aa2bd2474@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d7b319cc-5c02-df0f-44d5-cd3aa2bd2474@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/23 13:47, Dietmar Eggemann wrote:
> On 11/02/2023 19:01, Qais Yousef wrote:
> > On 02/08/23 12:52, Dietmar Eggemann wrote:
> >> On 07/02/2023 11:04, Vincent Guittot wrote:
> >>> On Sun, 5 Feb 2023 at 23:43, Qais Yousef <qyousef@layalina.io> wrote:
> >>>>
> >>>> find_energy_efficient_cpu() bails out early if effective util of the
> >>>> task is 0. When uclamp is being used, this could lead to wrong decisions
> >>>> when uclamp_max is set to 0. Cater for that.
> >>
> >> IMHO this needs a little bit more explanation. Someone could argue that
> >> 'util > 0, uclamp_min=0, uclamp_max=0' is a valid setup for a task which
> >> should let it appear as a task with 0 util (capped to 0).
> > 
> > You want me to explain the purpose of the optimization then?
> > 
> > The optimization skips energy calculation when util is 0 because the delta will
> > be 0. But when uclamp_max = 0 util is not really 0 - consequently  the delta
> 
> I would say:
> 
> s/really/necessarily
> s/delta/energy delta

+1

> 
> > will not be 0.
> > 
> > Would such an explanation clarify things better?
> 
> Yes. It key to understand that there is a 2-step process. First,
> admittance to a possible target (util and uclamp) and second, energy
> diff based target-selection (util).
> 
> >>>> Fixes: d81304bc6193 ("sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition")
> >>>> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> >>>> ---
> >>>>  kernel/sched/fair.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>> index 7a21ee74139f..a8c3d92ff3f6 100644
> >>>> --- a/kernel/sched/fair.c
> >>>> +++ b/kernel/sched/fair.c
> >>>> @@ -7374,7 +7374,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >>>>         target = prev_cpu;
> >>>>
> >>>>         sync_entity_load_avg(&p->se);
> >>>> -       if (!uclamp_task_util(p, p_util_min, p_util_max))
> >>>> +       if (!uclamp_task_util(p, p_util_min, p_util_max) && p_util_max != 0)
> >>>
> >>> The below should do the same without testing twice p_util_max:
> >>> uclamp_task_util(p, p_util_min, ULONG_MAX)
> >>
> >> Since uclamp_task_util() is only used here and we don't want to test for
> >> capping to 0 anymore, why not just get rid of this function and use:
> >>
> >>   !(task_util_est(p) || p_util_min)
> > 
> > That would be better, yes!
> > 
> > Question for you and Vincent. Do we really want this optimization? I started
> > with removing it - then erred on the conservative side and kept it.
> 
> Hard to say ... at least we know that util=0 will have absolutely no
> effect on task placement. So we can spare the heavy EAS algorithm in
> this case for sure.
> 
> > I don't know how often we hit this case and I didn't see any benchmark run to
> > be able to verify anything when I looked at the history.
> 
> There are very few EAS wakeups with `task_util_est(p) = 0`. Probably not
> relevant.
> 
> > It seems helpful in theory - but why we save something if we ignore 0 but not
> > 1 which I suspect will not produce a significant delta either.
> 
> True, it's hard to find the real line of significance here.
> 
> > I don't mind keeping it - but I think worth thinking if it is really adding
> > much.
> 
> I would keep it and just remove uclamp_task_util(). We still have a lot
> of uclamp/util related functions, we should try to keep the number as
> low as possible. Just checked it, this check has been there from the
> beginning of EAS.

Yeah I looked at the history and it was always there.

I'll update with the new check and update the commit message too.


Thanks!

--
Qais Yousef
