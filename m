Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C076D6A57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjDDRV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbjDDRVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:21:51 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698161717
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:21:45 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id d3so11697473ybu.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680628904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/6nWpG035DFCd1KL6TSDLFyH9kaDtT1tj9RQy6j89U=;
        b=PKraOirR2pRBA2DBW/b33pTm+8HXjKvpeNeRzehm9FD9V7XXtodyrrySXy1qTEBZQr
         KFtO6wcuZl5I0TAgoLpYtumb2AXH1YDSl7tNZVF0teic9sNmnZ5Au1/xUa9gyEVdQLdV
         AY7qyFZ1dPyPFa1UUhVHvv8/mO0zS1TBX7chxj/oUPivbEu361UcjMNugE1rCkF2gF0Q
         67lgHtBl39eyST0OLIFXiGODcqI2+588kxayaRE7NbbqOro+EqNNKkmqAeeBCCR7SquS
         F31eMziiL3Tu2fHhzHuplp2dE7AYSjVVNkuvNqRVoXYN2Tei1Q9gxYr8f2pGG+ajomnQ
         hbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/6nWpG035DFCd1KL6TSDLFyH9kaDtT1tj9RQy6j89U=;
        b=lr4XmPaBnHwclVfM7tyMoEjHGrzKEy0yOdZCJq2ScDC8qAyWXhkT6xR3v5QWLEXcXe
         Ygj7vPAA89HdVyDQ78Tz7NDhXXBK9XJ2G3spMPJYiOlP4L6s+0CIrVEn1jCW1tbliqS8
         IN99r0lsL+diiw2e7KgpVMO17yvf0Kx5z1mz4hSzLJ8ITQGctL7I1zqSv+BLdi/gatOc
         93RKOrZ0ce43SAsDhvsFRTbVnGkkWaDXQsfmkgEOFCPv2XylgKnAh8bSwR4Rgh1B90zR
         lgCO/ynJQgzlGfvA0rLDZwHWAJC2XQtMyMHZbtDfPWZQO0JQYdJXJ1ohBhPZxSM9di8l
         acnA==
X-Gm-Message-State: AAQBX9fwt/lMHPguMbrk1BlVKhRULC/BnbvyxPvT7IhQNPK30Mv8bf7U
        PjbSd/tROYvuvtnXF39IZe94ezQBGuMKou3Qc1OTXw==
X-Google-Smtp-Source: AKy350YO1gXKrbjU1BYPifCphoRiUxy1FvIjM90AQwLqo17M47gxr8jXro28tsqB3CbSgypd8zH6KOlbq2rBGIO2s70=
X-Received: by 2002:a25:ca4b:0:b0:b77:d2db:5f8f with SMTP id
 a72-20020a25ca4b000000b00b77d2db5f8fmr2305401ybg.12.1680628904510; Tue, 04
 Apr 2023 10:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191801.1967435-1-yosryahmed@google.com>
 <20230330191801.1967435-5-yosryahmed@google.com> <20230404165258.ie6ttxobbmgn62hs@blackpad>
 <CALvZod5Y+quOS1XQvVBTvv7FRs3455j_79f0GoR+FqCFzbwkuA@mail.gmail.com>
In-Reply-To: <CALvZod5Y+quOS1XQvVBTvv7FRs3455j_79f0GoR+FqCFzbwkuA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 4 Apr 2023 10:21:33 -0700
Message-ID: <CALvZod7Ao-VmB4as+VHsR+awW1jmOA18uVM7qk21mVsXTOYC2A@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] memcg: replace stats_flush_lock with an atomic
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
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
        bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>
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

On Tue, Apr 4, 2023 at 10:13=E2=80=AFAM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Tue, Apr 4, 2023 at 9:53=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
> >
> > Hello.
> >
> > On Thu, Mar 30, 2023 at 07:17:57PM +0000, Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > >  static void __mem_cgroup_flush_stats(void)
> > >  {
> > > -     unsigned long flag;
> > > -
> > > -     if (!spin_trylock_irqsave(&stats_flush_lock, flag))
> > > +     /*
> > > +      * We always flush the entire tree, so concurrent flushers can =
just
> > > +      * skip. This avoids a thundering herd problem on the rstat glo=
bal lock
> > > +      * from memcg flushers (e.g. reclaim, refault, etc).
> > > +      */
> > > +     if (atomic_read(&stats_flush_ongoing) ||
> > > +         atomic_xchg(&stats_flush_ongoing, 1))
> > >               return;
> >
> > I'm curious about why this instead of
> >
> >         if (atomic_xchg(&stats_flush_ongoing, 1))
> >                 return;
> >
> > Is that some microarchitectural cleverness?
> >
>
> Yes indeed it is. Basically we want to avoid unconditional cache
> dirtying. This pattern is also used at other places in the kernel like
> qspinlock.

Oh also take a look at
https://lore.kernel.org/all/20230404052228.15788-1-feng.tang@intel.com/
