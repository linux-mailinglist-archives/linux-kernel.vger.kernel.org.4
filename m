Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91B75FF263
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiJNQli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiJNQlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:41:36 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FFB191D5F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:41:35 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3321c2a8d4cso51390247b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NiFexjlTvC7lzZHYKqn2wsRcOtMjNz2f2+18kg4ZV1s=;
        b=PoLyCxWP8+M5FMfSrh3Fejd4iRJAayG5MyO0Ebr8QOFogHI0WSak2i10J1YxDtNz0C
         7h36PymIN/Jshwd03YWupn2wnbj8Px0r04ECbihwM/ltrGsuqu2dOVb33n0c3APlszwt
         FXh/TT0EYAB5gMg5SFgcrC9qLMYySWNnrNamD4xZCjD4lB1lumtRp/PJzwTkpWygqQKm
         Ug9mwVrvCFTWIUSNh8plsniHjiuBAYVAnSlxdTEYFRU2oWUCvlAfLunN6UMpn735dRaE
         Es954MsD21wnFhbGvak5Jiq7sI3abIqOeB11VeHCZR1Ko1mvUuSKbjCgaMY8NHe+6Mnw
         dv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiFexjlTvC7lzZHYKqn2wsRcOtMjNz2f2+18kg4ZV1s=;
        b=qkbP3WQ6lKAaxD5qjxAxzcosHln2DvSsyBHdPtYDYPTny/JDFESqTRdEbi46BUV3D/
         7sa2Z7z85cXOLv7pb7V77C76nUblBJrnwyiDbehKdIiDm2UtG86pYbEvxq8Xf1n1fOvB
         0mnN27aNPPFcnEvkfwo0/PzaenY0uUIwNf1qeYPHZlOjUhM7mzGe3TI6CJAdfCNWa5bJ
         RKYFj9g21h/HnphvNjm4HfvsNPIflN0gwxyWKR1t2I3FiU0vfTr8US8FDekQKY9BW3QT
         CviZFLYNSvIe98ehCFcYrdUBsvcQSZf94P3a0QCyqURaq+42NGgy2oVLrWWd0D2hsZzj
         yxow==
X-Gm-Message-State: ACrzQf2tGIM8zPOIaU1q/liuAhsEo2uc+p8aLC+IL2QE8rq7veO252fJ
        R9AnDaYVI6GfqcnuLfF90I21r2i/Jj50EZEyc0gTuw==
X-Google-Smtp-Source: AMsMyM6G5UFBOJhNxwAUX87q8i8wzHuf/UeAMAkbRY7MF0ch9rRAeLYZukVMGJVxivIs/yJ9YT7WPOyo+NYx5CIIGtU=
X-Received: by 2002:a81:a0d7:0:b0:357:6a14:e736 with SMTP id
 x206-20020a81a0d7000000b003576a14e736mr5521702ywg.455.1665765694861; Fri, 14
 Oct 2022 09:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221014110551.22695-1-zhouchengming@bytedance.com> <Y0lvuKbrb/pyWQDs@cmpxchg.org>
In-Reply-To: <Y0lvuKbrb/pyWQDs@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 14 Oct 2022 09:41:23 -0700
Message-ID: <CAJuCfpEQPpVZ+0Nyb52y30y=5+XBqMqKkvQ93NZtOistrjAC1g@mail.gmail.com>
Subject: Re: [PATCH v2] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        quic_pkondeti@quicinc.com, peterz@infradead.org,
        quic_charante@quicinc.com, linux-kernel@vger.kernel.org
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

On Fri, Oct 14, 2022 at 7:18 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Oct 14, 2022 at 07:05:51PM +0800, Chengming Zhou wrote:
> > Pavan reported a problem that PSI avgs_work idle shutoff is not
> > working at all. Because PSI_NONIDLE condition would be observed in
> > psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
> > only the kworker running avgs_work on the CPU.
> >
> > Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
> > avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
> > still will always re-arm the avgs_work, so shutoff is not working.
> >
> > This patch changes to use PSI_STATE_RESCHEDULE to flag whether to
> > re-arm avgs_work in get_recent_times(). For the current CPU, we re-arm
> > avgs_work only when (NR_RUNNING > 1 || NR_IOWAIT > 0 || NR_MEMSTALL > 0),
> > for other CPUs we can just check PSI_NONIDLE delta. The new flag
> > is only used in psi_avgs_work(), so we check in get_recent_times()
> > that current_work() is avgs_work.
> >
> > One potential problem is that the brief period of non-idle time
> > incurred between the aggregation run and the kworker's dequeue will
> > be stranded in the per-cpu buckets until avgs_work run next time.
> > The buckets can hold 4s worth of time, and future activity will wake
> > the avgs_work with a 2s delay, giving us 2s worth of data we can leave
> > behind when shut off the avgs_work. If the kworker run other works after
> > avgs_work shut off and doesn't have any scheduler activities for 2s,
> > this maybe a problem.
> >
> > Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Please make sure to test the final version. With that done,

Acked-by: Suren Baghdasaryan <surenb@google.com>
