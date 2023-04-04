Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AAF6D69F9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjDDROI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjDDROA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:14:00 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E4710C1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:13:59 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54601d90118so471608597b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680628438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jB81HM7QxwklDvE39D9zGEd7EL3RK9tGsVExEctIF9g=;
        b=RTE9uUoI7XQ8R2+nrWW7Yx58+ErEPGeeDfqbJ/xGvvaIQ77F/wmkQ1JiRiLzfMk3ds
         aGgu1IiS++nn+phVSuzWXmhmnnCR/c6rjOJll7kCeyjgPiFt1rAHATUDSo6RV05Qzvc2
         xUkU5W+YitmDn4UuYTkJUwt6iLG7fqJ2JdKIaUoaN4I5bJucmRLBWHWQyYSLVRgj5Kb9
         YYRNr9aHII9yl6U38B61zDPm53mjPR6kWofIAAjQ+MEUUeIyy/AFwTH+9VuLtJzwYqJj
         tf1x0gtzBFYsSXZzhLN/ugTsZ4z2Nt+9QfJqs8jO0/JRmH/lPnHVRTX2DCl54PANUWGW
         Ny3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jB81HM7QxwklDvE39D9zGEd7EL3RK9tGsVExEctIF9g=;
        b=HWIWF8Cipg1RRlwUzOQUrxXe4+15T8b8Xi6fOzzxLfsaj1tpisvtyHK7X7NRoW8EJx
         dxO4xS6abkiqntNXrL7u89sszxxJ+EUNzf9mzWncntwVW1tLT8fz0ntjZsSa0vONRi/2
         OQ0FHKJLf8xU82Td4+n5r3UEk1/Jp2hROEqprm8NwZBJIn7eTmuiG719leUj3jZ6k3mJ
         5NEjnFLvNsqwFEAwSykdVUEQgRvTUjI58mFZ02x8sWEDAayqpnW+h4YrAyPmaplx5syG
         FbWRvUEO4kSncqNMQzLXR+7CT+6HZvVzmyqZ8lF3yplF3N6XyzRu0pIEVEI7fMEMlnXP
         K9yg==
X-Gm-Message-State: AAQBX9f0Z3rv+MssIoqBSNZaGyPtH4XBOTeTr1HOu+i20uvNuVPOP2Lf
        XVApEmknKrUq+NdBkwztrkYIyteJDBNYB1H3UCedVw==
X-Google-Smtp-Source: AKy350YfkE1yBZsZo/vuErzxwl0ifJq9+FUSZScFb3AOn/d315UWmv+qL4nxuP4OOnhzt5F3cFDZLFK9czXb9I4PiPQ=
X-Received: by 2002:a81:ac0d:0:b0:52b:fd10:4809 with SMTP id
 k13-20020a81ac0d000000b0052bfd104809mr1973994ywh.0.1680628438438; Tue, 04 Apr
 2023 10:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191801.1967435-1-yosryahmed@google.com>
 <20230330191801.1967435-5-yosryahmed@google.com> <20230404165258.ie6ttxobbmgn62hs@blackpad>
In-Reply-To: <20230404165258.ie6ttxobbmgn62hs@blackpad>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 4 Apr 2023 10:13:47 -0700
Message-ID: <CALvZod5Y+quOS1XQvVBTvv7FRs3455j_79f0GoR+FqCFzbwkuA@mail.gmail.com>
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

On Tue, Apr 4, 2023 at 9:53=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> Hello.
>
> On Thu, Mar 30, 2023 at 07:17:57PM +0000, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> >  static void __mem_cgroup_flush_stats(void)
> >  {
> > -     unsigned long flag;
> > -
> > -     if (!spin_trylock_irqsave(&stats_flush_lock, flag))
> > +     /*
> > +      * We always flush the entire tree, so concurrent flushers can ju=
st
> > +      * skip. This avoids a thundering herd problem on the rstat globa=
l lock
> > +      * from memcg flushers (e.g. reclaim, refault, etc).
> > +      */
> > +     if (atomic_read(&stats_flush_ongoing) ||
> > +         atomic_xchg(&stats_flush_ongoing, 1))
> >               return;
>
> I'm curious about why this instead of
>
>         if (atomic_xchg(&stats_flush_ongoing, 1))
>                 return;
>
> Is that some microarchitectural cleverness?
>

Yes indeed it is. Basically we want to avoid unconditional cache
dirtying. This pattern is also used at other places in the kernel like
qspinlock.
