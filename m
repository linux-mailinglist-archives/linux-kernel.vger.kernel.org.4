Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCC56D2AFD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 00:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjCaWMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 18:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjCaWM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 18:12:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E8659E9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 15:12:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b20so95216772edd.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 15:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680300743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXj7Qyhuc3VANVAIof/dkXyPEcXygM8YpKQLnR/FCeE=;
        b=Y7wgIhz8nV9/+JLQsYPnAwcryWNNk6SGIsTlR1ZDgFqo2CeTCBdwaY/59tRk1x6wDD
         kJ6hALcgHquJ/7Uw4MiIw4axX8C5DJ7h0ca615Iy3dMLiloDQeOLieUPgXncrwBpcX4e
         m4gAv6Jw4n7BAz5q/oWkZXbBG/l1vfedPJXZxOVCX0izr91Hbzh9Ff5RgEavalR/3rVf
         TlgSh9YdhXvtBNU3CNgG30msbxq42Qn1Iz3O8TlEOIqVOanF6/XVsco+Fyj6Qy1Je7EI
         VsH7GhxQddG6FAxXQId4sr1vTc9RbdeM9SBpzwSijPTcRwfUk4JQDAajQQajP2kXyrdy
         7WBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680300743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXj7Qyhuc3VANVAIof/dkXyPEcXygM8YpKQLnR/FCeE=;
        b=fLC1OLlD6vXO9FxnZMr69Jx3IaeocepBya1A8YNu0eewja8HVSHAq9CEGIFtrWkPFk
         n7z2O/d/J+tNaFmsPBAbq4A5+It5PD+qbpz5rV4lrDMVUyNOH43w+ITzDNcYtPZp3lU/
         urf5ui2huTx8koT9/izGlMNpN1deMmL9TDD8VU6iOGsd40Cyk/Fu6+Ro8ZSydgqVaSW8
         Og02uAGV4obnMZSZi9h699D52AccuIXDj75IUAw2E7T/6u0PvsNZ5uiABNvk+hORrhk/
         VbsqnKM149on0PAs7O84uQq24MDLpwV4lHNeiW1xBMwaWDb+8Hai1t0XN83XyrPElzPE
         Nptg==
X-Gm-Message-State: AAQBX9fCi0iUw9697hwYW9L2LWfX7/UPLCgRu5LPdUlrylyEyvyqc0iH
        1e8uB95l4lMRJYGQtts4L76u+FEuB3FzpV68v9ODxA==
X-Google-Smtp-Source: AKy350YNxzefAx/NXeor8UoJ5Yql4qMe7ZyBd+MvOF9a06S3oO/DniRs2KI3wKVInPUmESDZhZ1+jvPbQ747jsXKQN4=
X-Received: by 2002:a17:906:2456:b0:8e5:411d:4d09 with SMTP id
 a22-20020a170906245600b008e5411d4d09mr14741355ejb.15.1680300742955; Fri, 31
 Mar 2023 15:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230331070818.2792558-1-yosryahmed@google.com>
 <20230331070818.2792558-3-yosryahmed@google.com> <20230331205117.GI3223426@dread.disaster.area>
In-Reply-To: <20230331205117.GI3223426@dread.disaster.area>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 31 Mar 2023 15:11:46 -0700
Message-ID: <CAJD7tkai_tv32GREjLvopLkUufq+WiR0-fFr-eNAzZNmQqk5dQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: vmscan: refactor updating reclaimed pages in reclaim_state
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
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

On Fri, Mar 31, 2023 at 1:51=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Fri, Mar 31, 2023 at 07:08:17AM +0000, Yosry Ahmed wrote:
> > During reclaim, we keep track of pages reclaimed from other means than
> > LRU-based reclaim through scan_control->reclaim_state->reclaimed_slab,
> > which we stash a pointer to in current task_struct.
> >
> > However, we keep track of more than just reclaimed slab pages through
> > this. We also use it for clean file pages dropped through pruned inodes=
,
> > and xfs buffer pages freed. Rename reclaimed_slab to reclaimed, and add
> > a helper function that wraps updating it through current, so that futur=
e
> > changes to this logic are contained within mm/vmscan.c.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> .....
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index fef7d1c0f82b2..a3e38851b34ac 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -511,6 +511,34 @@ static void set_task_reclaim_state(struct task_str=
uct *task,
> >       task->reclaim_state =3D rs;
> >  }
> >
> > +/*
> > + * mm_account_reclaimed_pages(): account reclaimed pages outside of LR=
U-based
> > + * reclaim
> > + * @pages: number of pages reclaimed
> > + *
> > + * If the current process is undergoing a reclaim operation, increment=
 the
> > + * number of reclaimed pages by @pages.
> > + */
> > +void mm_account_reclaimed_pages(unsigned long pages)
> > +{
> > +     if (current->reclaim_state)
> > +             current->reclaim_state->reclaimed +=3D pages;
> > +}
> > +EXPORT_SYMBOL(mm_account_reclaimed_pages);
>
> Shouldn't this be a static inline in a header file?
>
> Then you don't need an EXPORT_SYMBOL() - which should really be
> EXPORT_SYMBOL_GPL() - and callers don't add the overhead of a
> function call for two lines of code....

Yes it should be. Thanks.

An earlier draft of this series had more going on in this function, so
I moved it to mm/vmscan.c, then I forgot to move it to the header
later. Will do that for v4.

>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
