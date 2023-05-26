Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725B7712C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237519AbjEZSQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbjEZSQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:16:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566A4198
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:16:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f6e83e12fso165674866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685124968; x=1687716968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck6N4S4jiJu910yJXpyaQokUMWH4KKhSAsPW4EeI/fE=;
        b=DOeSLj3zYkASws6boClAYXGxuNjRdIm5LlmNF2AU7fqwyEzricfQWmZ4ylo+VNtTpv
         S7MnIj0t2qEqtkI+/722GXPNTAztrMPTUmFVfVF2on2cEClEIbSe1IDeUZXgEzEbYGDN
         jqIRkPlZksHS3N8NJ0yKrR6PiNbaNUItKiug58U6BHtmuMCOUllH1EED7zFCvKS/bnay
         Ocpwte5g7kWUpuikxYmgw4gEf7h6GJSWAJzybDwF0ZtYx2gPmjDhMaPfg5jSNMpcLLt0
         InVE5bcMjqY1LH0s5tmA9uNXTy2qcAv7Zv9C3D4o5lQfz8vyDmBr45kEJBQ3csap2QMc
         8J8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685124968; x=1687716968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ck6N4S4jiJu910yJXpyaQokUMWH4KKhSAsPW4EeI/fE=;
        b=Hcn1XTL3TLv+fkffySWugV6NoFZ5ykqdALtCtwJMKjn2s1/T2Ozxw+uQvJZBvMhmCm
         xeGs8foVdQVBBnAZDcnrwio5SjeVQGmtwIzOkhxTd8h4D+ts9NhdIUM9L96nUYgz08In
         nxg6dhjGAKF0vLsIqrYXENY+rJQa9waJ+zuXfdz0B/l/eka9WRX1yNFG4UCvH+JZLkDq
         SMy8B39mbcgSJMB4lSoRKPFo9oidEPU622Q045lA5NcDWgiaJbbmnyM/1DKzpmSlEgit
         Nwps1Zr55HGQ8qBXdIA39aGCv2NTbl3l7r6XSpd8YBau7tEhx6Uk89KDu5iUEiOqV7yw
         R0Ig==
X-Gm-Message-State: AC+VfDw903/Y3oX7nFJTGiEjVvOkXDCBpk+GtFf++LAnFZF5VISy2Mif
        aEw0ZkKgPPZg+y1a3UHqCq3cOEFpGevA7WvTjjRHtQ==
X-Google-Smtp-Source: ACHHUZ7bmJdZ/B7moM+bwuYRIKTMF0iIacS+JLxF+JNTLcpYnFSA1Zr3ohMkyz3HEFHj+DT9bNeVQpL5IkW7ZHx2CL0=
X-Received: by 2002:a17:906:db0c:b0:96a:37af:ff37 with SMTP id
 xj12-20020a170906db0c00b0096a37afff37mr2666854ejb.15.1685124967602; Fri, 26
 May 2023 11:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230526173955.781115-1-cerasuolodomenico@gmail.com> <20230526181023.GA49039@cmpxchg.org>
In-Reply-To: <20230526181023.GA49039@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 26 May 2023 11:15:31 -0700
Message-ID: <CAJD7tkY55Z9n7Ue-4+a691t4YJAs+0e7gEZGocF7cp197gL+Dg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: shrink until can accept
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 11:10=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Fri, May 26, 2023 at 07:39:55PM +0200, Domenico Cerasuolo wrote:
> > This update addresses an issue with the zswap reclaim mechanism, which
> > hinders the efficient offloading of cold pages to disk, thereby
> > compromising the preservation of the LRU order and consequently
> > diminishing, if not inverting, its performance benefits.
> >
> > The functioning of the zswap shrink worker was found to be inadequate,
> > as shown by basic benchmark test. For the test, a kernel build was
> > utilized as a reference, with its memory confined to 1G via a cgroup an=
d
> > a 5G swap file provided. The results are presented below, these are
> > averages of three runs without the use of zswap:
> >
> > real 46m26s
> > user 35m4s
> > sys 7m37s
> >
> > With zswap (zbud) enabled and max_pool_percent set to 1 (in a 32G
> > system), the results changed to:
> >
> > real 56m4s
> > user 35m13s
> > sys 8m43s
> >
> > written_back_pages: 18
> > reject_reclaim_fail: 0
> > pool_limit_hit:1478
> >
> > Besides the evident regression, one thing to notice from this data is
> > the extremely low number of written_back_pages and pool_limit_hit.
> >
> > The pool_limit_hit counter, which is increased in zswap_frontswap_store
> > when zswap is completely full, doesn't account for a particular
> > scenario: once zswap hits his limit, zswap_pool_reached_full is set to
> > true; with this flag on, zswap_frontswap_store rejects pages if zswap i=
s
> > still above the acceptance threshold. Once we include the rejections du=
e
> > to zswap_pool_reached_full && !zswap_can_accept(), the number goes from
> > 1478 to a significant 21578266.
> >
> > Zswap is stuck in an undesirable state where it rejects pages because
> > it's above the acceptance threshold, yet fails to attempt memory
> > reclaimation. This happens because the shrink work is only queued when
> > zswap_frontswap_store detects that it's full and the work itself only
> > reclaims one page per run.
> >
> > This state results in hot pages getting written directly to disk,
> > while cold ones remain memory, waiting only to be invalidated. The LRU
> > order is completely broken and zswap ends up being just an overhead
> > without providing any benefits.
> >
> > This commit applies 2 changes: a) the shrink worker is set to reclaim
> > pages until the acceptance threshold is met and b) the task is also
> > enqueued when zswap is not full but still above the threshold.
> >
> > Testing this suggested update showed much better numbers:
> >
> > real 36m37s
> > user 35m8s
> > sys 9m32s
> >
> > written_back_pages: 10459423
> > reject_reclaim_fail: 12896
> > pool_limit_hit: 75653
> >
> > V2:
> > - loop against =3D=3D -EAGAIN rather than !=3D -EINVAL and also break t=
he loop
> > on MAX_RECLAIM_RETRIES (thanks Yosry)
> > - cond_resched() to ensure that the loop doesn't burn the cpu (thanks
> > Vitaly)
> >
> > Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool lim=
it is hit")
> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > ---
> >  mm/zswap.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 59da2a415fbb..f953dceaab34 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/workqueue.h>
> >
> >  #include "swap.h"
> > +#include "internal.h"
> >
> >  /*********************************
> >  * statistics
> > @@ -587,9 +588,17 @@ static void shrink_worker(struct work_struct *w)
> >  {
> >       struct zswap_pool *pool =3D container_of(w, typeof(*pool),
> >                                               shrink_work);
> > +     int ret, failures =3D 0;
> >
> > -     if (zpool_shrink(pool->zpool, 1, NULL))
> > -             zswap_reject_reclaim_fail++;
> > +     do {
> > +             ret =3D zpool_shrink(pool->zpool, 1, NULL);
> > +             if (ret) {
> > +                     zswap_reject_reclaim_fail++;
> > +                     failures++;
> > +             }
> > +             cond_resched();
> > +     } while (!zswap_can_accept() && ret =3D=3D -EAGAIN &&
> > +              failures < MAX_RECLAIM_RETRIES);
>
> It should also loop on !ret, right?
>
> AFAIU Yosry's suggestion was that instead of breaking only on -EINVAL,
> it should break on all failures but -EAGAIN. But it should still keep
> going if the shrink was successful and the pool cannot accept yet.
>
> Basically, something like this?
>
>         do {
>                 ret =3D zpool_shrink(pool->zpool, 1, NULL);
>                 if (ret) {
>                         zswap_reject_reclaim_fail++;
>                         if (ret !=3D -EAGAIN)
>                                 break;
>                         if (++failures =3D=3D MAX_RECLAIM_RETRIES)
>                                 break;
>                 }
>                 cond_resched();
>         } while (!zswap_can_accept());

Yes, that's what I meant. Otherwise if shrink is successful we end up
doing 1 page only, which is exactly what we are trying to avoid here.
