Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26861712C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbjEZSQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjEZSQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:16:14 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCFC13A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:16:13 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso527137a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685124972; x=1687716972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3E6S2mM6CKLQzbuu/q83DyJGvh7y+SEqYfjm7CdY24=;
        b=G0pp9WctRsgz45ukCKl9wUvKsvWotCxcQEfElWkLGLBYk9llA1wZ0zEBLqLPTN+PU9
         aIYxsXTkGBcAcLFsvQXqIlDG5LcZO1/EOPWyBz1g2a/f7LYJXyp/gw4cNVQgWgncdhyY
         X57I9HEkPGdTmJgZMujMr4yUuzI6GJd9f0Bq6OvNgZpo4pzb/B3Kqcp/CMjEa8QWbWwN
         5CHrexm8JWB1KLVJSVGpapKpcdSIcfjOP2Gb+XA8LvZY5QAQqhVmRb2TbnfwX1l8EFAZ
         KhDupETZDaihBK9nhXmFN514jn2qIGyWv+AZOWo9dz9UB4pzVC7sMVrE5nH2o8F64VTJ
         uwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685124972; x=1687716972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3E6S2mM6CKLQzbuu/q83DyJGvh7y+SEqYfjm7CdY24=;
        b=XB/bBM2P7joOpc8wwNm1qFL+BnympYEpzXMSQIoGupXEXc07T+OcifshFED7JVmrOq
         afbFln6MLhx/CHc1vTBxHh8k+Idj50rAIk6gvBG3+QLO2U1pJ4hXcq39R3hM3zsxsthn
         84GvKJx/tnEwE8leNo37JbYu+dhiEgkC2HSj0aId4Oc5x142Gd/7VJqwZNrqc6LhzxyB
         llNYOrnqr/dvhbCnKonBq/fgvpIjSXsGnnCxefIqhqLdQ2Cu2CfObGSeEo+ZhTHDHKOs
         zY3pktWH2kMJLAPPTZGIXTpgIFgMzKB/LKQAIlRCeJRGk28TKt/4wdnCZRLhBgnccfA8
         w91w==
X-Gm-Message-State: AC+VfDy+h3hCCFZ7OR+tdpeKYJVuclQxN4HbiFbdcrAOnQvIFFt1BtSV
        wWKm3nxW5z/2EyThl8OfV7l+/YrMDwivKFLu3wQ=
X-Google-Smtp-Source: ACHHUZ5eexjIsYmcMEI3H+7tghlQehLLGFr8SBjDEPeb9Ngd3i98/SWbBcX6UMX22WgXj3XDKmMkmp9EOUT+g5rcy7A=
X-Received: by 2002:a17:902:d488:b0:1b0:26e:7648 with SMTP id
 c8-20020a170902d48800b001b0026e7648mr4118135plg.11.1685124972346; Fri, 26 May
 2023 11:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230526173955.781115-1-cerasuolodomenico@gmail.com> <20230526181023.GA49039@cmpxchg.org>
In-Reply-To: <20230526181023.GA49039@cmpxchg.org>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Fri, 26 May 2023 20:16:01 +0200
Message-ID: <CA+CLi1iziVVPmfZxjE=_7JaJRPJ5kk2q0KZv+AyEYdJ3iZDLog@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: shrink until can accept
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 8:10=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
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

Thanks, !ret should indeed keep it going.
