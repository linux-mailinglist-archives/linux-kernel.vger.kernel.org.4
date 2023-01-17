Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D21670B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjAQWER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjAQWDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:03:19 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2975B461
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:21:00 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so78156149ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iWlRLiUKMXJt3KD3VewHmkRai8o03qMC+48h3vloBGk=;
        b=ee9ZsxFH0+TOnSXcPrEGkTd9TlTqtZr8Jzdq1Pc/ZubpNyLzAegr1AYxHJ163b0TUy
         dQQCDckhQGbOqH/LVs697vIWIUgWVjqkezi+1Fb/X67JNEVsvTfG8taaSxj9XMcdqnat
         wuxIENu4lgwtZL3RwMb9XYuzJ3VDaPaHclj4No3S72WGGpkquszBpdzpLTRm/m/xuDVV
         8T7LsomWI6BDi0D4N0JCzOZLjGpkxVUV7UVosfuwrrCZ162QSbHBlAOAjs9iM/HTdmIY
         jo+76qdlqTimsnv4Ll2PCZmWskdhr9cuU2EFxMkUFQGntxOtxZich/LI1zMt8fJgl3Xn
         Cgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWlRLiUKMXJt3KD3VewHmkRai8o03qMC+48h3vloBGk=;
        b=CgWX7dJHUDxqcyAoiIw8AajYv/GYMfNYmkWyhFyqEJb+7M8JeMVLZMao37rQuIs67w
         HSZgSH8JTnNOYU6GaKqk4Xr+WqKxbThCRN+8V0Mcjfbgo+DtPeDL1DpioxIDUZrwz81i
         tNSBczliBrJU8juusT6f5imzil6oDyY5lpquswj6ogBk1ElNHC9529t0QVgwBSHCNiD4
         be8hrgw+fbiiNTFoaQyBB0bUagzFXjIaoX86C10OEgeVks6pNq6Z1Xmt6WRdPnc3xYXQ
         FdDqJLaUwunPbSLWLeYNqcDYATRE/UvMqXBNG4sOjaJjBJaAZFPbK7o+9H/jRMSWZwVX
         +CDg==
X-Gm-Message-State: AFqh2krVQ4weHAC5EndMQWU5gJiNEBo4L3UCgoG7WjqoS7rgu7OPAOST
        AJqcAAJvvzlF6gcAAPEMYaWZ3w==
X-Google-Smtp-Source: AMrXdXs9uRo49QUx37/1Ds+MJCE8jo71WpvZDXyr3NVprgNsVLSvnGgypIdXZ+kNkxM/vZUXmVO/Fw==
X-Received: by 2002:a17:907:a710:b0:7c0:f71b:8b3 with SMTP id vw16-20020a170907a71000b007c0f71b08b3mr4253213ejc.57.1673986858902;
        Tue, 17 Jan 2023 12:20:58 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id k14-20020a17090632ce00b00871ac327db6sm2238452ejk.45.2023.01.17.12.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 12:20:58 -0800 (PST)
Date:   Tue, 17 Jan 2023 20:20:56 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        peterz@infradead.org, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
Subject: Re: [PATCH v3] sched/fair: unlink misfit task from cpu overutilized
Message-ID: <20230117202056.zx2pl22miufcrcu3@airbuntu>
References: <20230113134056.257691-1-vincent.guittot@linaro.org>
 <78bf2d91-0076-f748-7c6a-530dad466787@arm.com>
 <CAKfTPtCAAOvFak2FqkKv2AwnoBZ3cwbMwfnAAGqDx+Wq4Ng+zw@mail.gmail.com>
 <7a6182dd-89f5-69c5-4331-2f102dc0418d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a6182dd-89f5-69c5-4331-2f102dc0418d@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/16/23 14:56, Dietmar Eggemann wrote:
> On 16/01/2023 12:23, Vincent Guittot wrote:
> > On Mon, 16 Jan 2023 at 10:07, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 13/01/2023 14:40, Vincent Guittot wrote:
> 
> [...]
> 
> >>> @@ -6132,6 +6135,7 @@ static inline bool cpu_overutilized(int cpu)
> >>>       unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> >>>       unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> >>>
> >>> +     /* Return true only if the utlization doesn't fit its capacity */
> >>
> >> s/utlization/utilization
> >> s/its/CPU ?
> >>
> >>>       return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
> >>>  }
> >>
> >> cpu_overutilized() is the only place where we now only test for
> >> !util_fits_cpu(). The new comment says we only care about utilization
> >> not fitting CPU capacity.
> >>
> >> Does this mean the rq uclamp values are not important here and we could
> >> go back to use fits_capacity()?
> >>
> >> Not sure since util_fits_cpu() is still coded differently:
> > 
> > uclamp_min is not important but uclamp_max still cap the utilization
> 
> OK, makes sense.
> 
> I.e. we could pass in `rq_util_min = 0` to avoid fetching it
> unnecessary? In case `fits == 1` before the uclamp_min condition in
> util_fits_cpu() it doesn't matter if we switch to return `-1` when
> called from cpu_overutilized(). Detail though ...
> 
> [...]
> 
> >>> @@ -6940,12 +6945,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >>>
> >>>               if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
> >>>                       continue;
> >>> -             if (util_fits_cpu(task_util, util_min, util_max, cpu))
> >>> +
> >>> +             fits = util_fits_cpu(task_util, util_min, util_max, cpu);
> >>> +
> >>> +             /* This CPU fits with all capacity and performance requirements */
> >>
> >> In task_fits_cpu() `utilization and performance (better uclamp)
> >> requirements` term was used. I assume it's the same thing here?
> >>
> >>> +             if (fits > 0)
> >>>                       return cpu;
> >>> +             /*
> >>> +              * Only the min performance (i.e. uclamp_min) doesn't fit. Look
> >>> +              * for the CPU with highest performance capacity.
> >>                                             ^^^^^^^^^^^^^^^^^^^^
> >>
> >> Do we use a new CPU capacity value `performance capacity (1)` here?
> >>
> >> Which I guess is `capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu)`.
> >>
> >> I'm asking since util_fits_cpu() still uses: `capacity_orig_thermal (2)
> >> = capacity_orig - arch_scale_thermal_pressure()` when checking whether
> >> to return -1. Shouldn't (1) and (2) be the same?
> > 
> > I'm all in favor of both being capacity_orig_of(cpu) -
> > thermal_load_avg(cpu_rq(cpu) like the capacity inversion detection
> 
> I think we need a handy name for this new capacity value, which seems to
> be `capacity_orig - capacity reduced by thermal`. And we should either
> use `thermal_load_avg` or `thermal pressure` for the latter part. And
> then we should use this consistently in all these places:
> util_fits_cpu(), feec(), sic().

So we had reports from Xuewen that not using instantaneous pressure causes
problems.

Lukasz came up with this patch to help address the problem, but it's still
waiting discussions. I think we need to discuss this problem more there.

	https://lore.kernel.org/lkml/20220429091245.12423-1-lukasz.luba@arm.com/

At the moment there's no good solution and either comes with its own set of
caveat(s). Being consistent is not an option now AFAICT? We need to improve
thermal_load_avg() response time first somehow.

For now, to make best decision - we look at instantaneous. But when falling
back - I think using the long term pressure signal makes more sense because we
wouldn't be doing this fallback path if everything works as expected thermal
wise.

At least, that's what I think is a good trade-of for now :)


Thanks!

--
Qais Yousef
