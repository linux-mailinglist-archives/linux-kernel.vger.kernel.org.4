Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875C66C5E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCWFRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCWFRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:17:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E431F5CF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:17:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eg48so81615773edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679548637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wf+Rn+FqVZ/sEEsLcWdc0Ab7428JNqhvJozhY+1OPkE=;
        b=UHxWcP+YzEnDXmlCMM4KkoxJ1LDDdOcgokWC5PN8qmiIJBy4Amlu03ZpAtkmIXsfwm
         RWn4PlsACc2XuTxyHVrWJGu4NoFd4ClniTSizL/83reSjz4HKmvfbePZbcokbL9DDWiG
         TP5Sjo3IF8xMn8px91h8B4L5Eh9dPtZq4JhbqVT9k24fwBDe+4+sU9Z2i8Ok57D6Qb/N
         rnLUbX3kP4DcjeHwrk+/nzNrcNoBYwqDvNsx8nBG6TmYcm1YuX9LPzwcvMxSubyOjAnF
         krM2wEcyWV/eQ3sw5wI3NOyBMOQzFLMafCs6zrgwLGYhZyaKdjtssQ8BakuWxEgVN9jf
         A4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679548637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wf+Rn+FqVZ/sEEsLcWdc0Ab7428JNqhvJozhY+1OPkE=;
        b=iKWIz5XwUUBRKlOCUOBT4cSIQGYh4twj1J7WsKOjZO2vxznySERN5ItQBdWpq76ZbW
         mEKf2+jlxghlzcAhPfrXEzgZN2n8LgreT8Kx8YFo/yeJT8aCkKNwBDTiXtstRZS0DEfg
         v9NM9qNwBQsD/scWfc7BhUTqA2LJgExgUow8SNQ8k6roP8+bIIuyxBTBJrb5E/k+cM28
         4b9x+zrzDdNEzwKxZ0jqb5Y6FTybnA07uVxKLx/PZeiTZolC1sTpuS+uOtPfOc7uHtt4
         HmhXLE2x33SIZWTcaysDEiao22x77SceB08fcESOcWC1Ea9QEtoe53l1q22YxijUlHfM
         hOrg==
X-Gm-Message-State: AO0yUKWU7yoHlv9zcWr51HOJz32WuUVy13IRXnA8vAE+APTkBOrcac/n
        jmpeGUzlp63zPayPP2y6SaMiUrn9aFgsoEognjZGwg==
X-Google-Smtp-Source: AK7set+njzVnfe8Swf7T8yAS00s4xUQcg5nPNp7fc0oRod15AHWx6jQG85RvuSvIK+G/onp8lGtBweZI7fXPAisH/a4=
X-Received: by 2002:a50:9b55:0:b0:4fc:473d:3308 with SMTP id
 a21-20020a509b55000000b004fc473d3308mr2358825edj.8.1679548636938; Wed, 22 Mar
 2023 22:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-3-yosryahmed@google.com> <CALvZod5MnM8UJ0pj44QYb4sVwgFZ1B2KpSL6oqBQbJU3wH6eNA@mail.gmail.com>
In-Reply-To: <CALvZod5MnM8UJ0pj44QYb4sVwgFZ1B2KpSL6oqBQbJU3wH6eNA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 22 Mar 2023 22:16:40 -0700
Message-ID: <CAJD7tkZJWXDinusUeYNBf_qov0+4ug2hG75Ge8NuP=6jG7+byA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] memcg: do not disable interrupts when holding stats_flush_lock
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 9:32=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Wed, Mar 22, 2023 at 9:00=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > The rstat flushing code was modified so that we do not disable interrup=
ts
> > when we hold the global rstat lock. Do the same for stats_flush_lock on
> > the memcg side to avoid unnecessarily disabling interrupts throughout
> > flushing.
> >
> > Since the code exclusively uses trylock to acquire this lock, it should
> > be fine to hold from interrupt contexts or normal contexts without
> > disabling interrupts as a deadlock cannot occur. For interrupt contexts
> > we will return immediately without flushing anyway.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  mm/memcontrol.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 5abffe6f8389..e0e92b38fa51 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -636,15 +636,17 @@ static inline void memcg_rstat_updated(struct mem=
_cgroup *memcg, int val)
> >
> >  static void __mem_cgroup_flush_stats(void)
> >  {
> > -       unsigned long flag;
> > -
> > -       if (!spin_trylock_irqsave(&stats_flush_lock, flag))
> > +       /*
> > +        * This lock can be acquired from interrupt context,
>
> How? What's the code path?

I believe through the charge/uncharge path we can do
memcg_check_events()->mem_cgroup_threshold()->mem_cgroup_usage()->mem_cgrou=
p_flush_stats(),
right? I am assuming we can charge/uncharge memory in an interrupt
context.

Also the current code always disables interrupts before calling
memcg_check_events(), which made me suspect the percpu variables that
are modified by that call can also be modified in interrupt context.

>
> > but we only acquire
> > +        * using trylock so it should be fine as we cannot cause a dead=
lock.
> > +        */
> > +       if (!spin_trylock(&stats_flush_lock))
> >                 return;
> >
> >         flush_next_time =3D jiffies_64 + 2*FLUSH_TIME;
> >         cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup);
> >         atomic_set(&stats_flush_threshold, 0);
> > -       spin_unlock_irqrestore(&stats_flush_lock, flag);
> > +       spin_unlock(&stats_flush_lock);
> >  }
> >
> >  void mem_cgroup_flush_stats(void)
> > --
> > 2.40.0.rc1.284.g88254d51c5-goog
> >
