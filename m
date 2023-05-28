Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4874A7138CC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 10:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjE1IyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 04:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjE1IyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 04:54:03 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653E7B4
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 01:54:02 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5304913530fso2066951a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685264041; x=1687856041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTNnEKjsWf93jMarUJhL2TSgg0Eu0fVUjkEcBR2z2aE=;
        b=hbPqke+WmacLdkNB+dPWppjHdcIR1P2gNFdwrYrOz9Gzx1W/cAtQTkNjXSpKLoTo6g
         MFao17XomXbR0tjG3Enp/ZQ0S/nzdp6ji3oD+OiPSe+OsJ/ZAJNKIaua754C1Wqy64Rd
         qBiHmrgcQUi/CGgujmt8y2puIaueVC5QvxSm3r1Ou1kvgdxJK32iwEEb79FF0q2iWy3D
         ZB5KlwtwkD+D51usS+d35iqiTFCvbKdSFFrLE4Gcfzltw+/juzObF0qKYgGCO2eyA0rL
         iVQywffAUyH9a9CMbEC2IW1borYQyqgyN21DEzcHdHDHzjrSkbC/m7XnH7w1rKOweEer
         DpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685264041; x=1687856041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTNnEKjsWf93jMarUJhL2TSgg0Eu0fVUjkEcBR2z2aE=;
        b=eS84iuj6X9+Kn2QlHcI/UHYaRxlKPoBy5zHSrGG7XfKe0g5cKKCQhiLgzmEzqq84rA
         5/3L/oOyEMuYqgf/jlBAF0RXWTiTsGgdRyCxlGpec7ahNFj2pDu/LM9msjBKY8hcB1mL
         CIzr+3hTUDXNkU6as7o72EjZKE6e9e7eziY4vfh7H8YKjUOwmgnTsoZp3spdA4TowhCU
         JMLFdmOsgAFNXQoEZAkIRKPEBfoBULequeueZthy7jyKpyCpyCds/wCAexE0nxjwHTTI
         uRNjZVOR7VVqKmE3ZmMP0NwETMWWreilDjncSjoyxMDvR3YYH6S5lXl8rHCFQuqyPJy3
         VboA==
X-Gm-Message-State: AC+VfDwH8Iel/mcJmkvh/nIvf5FVF8tjVm4SEH4hUnYfCMsNVgQBzX6O
        kg0DiYOdv1I/h26bI4e1ZGXNa4kAcvbZ0uZBmO0=
X-Google-Smtp-Source: ACHHUZ7j7tE+7vfXkZ/cH6iNrKVJucsYLdVKjYbOkhT5oYrXuM6iDZLa8Rdy4rY166t9/MSX9mdh7KOslmVki204oL4=
X-Received: by 2002:a17:903:1c4:b0:1ab:109e:a553 with SMTP id
 e4-20020a17090301c400b001ab109ea553mr9983613plh.62.1685264040912; Sun, 28 May
 2023 01:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230524065051.6328-1-cerasuolodomenico@gmail.com> <ZHE7KWId1fvXLpUy@google.com>
In-Reply-To: <ZHE7KWId1fvXLpUy@google.com>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Sun, 28 May 2023 10:53:49 +0200
Message-ID: <CA+CLi1iC35exSaKaCmVmTWtna=9xBKHSyGNGmHFo=OqiSECGoA@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: shrink until can accept
To:     Chris Li <chrisl@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, hannes@cmpxchg.org, kernel-team@fb.com
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

On Sat, May 27, 2023 at 1:05=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Wed, May 24, 2023 at 08:50:51AM +0200, Domenico Cerasuolo wrote:
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
> > Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool lim=
it is hit")
> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > ---
> >  mm/zswap.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 59da2a415fbb..2ee0775d8213 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -587,9 +587,13 @@ static void shrink_worker(struct work_struct *w)
> >  {
> >       struct zswap_pool *pool =3D container_of(w, typeof(*pool),
> >                                               shrink_work);
> > +     int ret;
> Very minor nit pick, you can move the declare inside the do
> statement where it get used.
>
> >
> > -     if (zpool_shrink(pool->zpool, 1, NULL))
> > -             zswap_reject_reclaim_fail++;
> > +     do {
> > +             ret =3D zpool_shrink(pool->zpool, 1, NULL);
> > +             if (ret)
> > +                     zswap_reject_reclaim_fail++;
> > +     } while (!zswap_can_accept() && ret !=3D -EINVAL);
>
> As others point out, this while loop can be problematic.

Do you have some specific concern that's not been already addressed followi=
ng
other reviewers' suggestions?

>
> Have you find out what was the common reason causing the
> reclaim fail? Inside the shrink function there is a while
> loop that would be the place to perform try harder conditions.
> For example, if all the page in the LRU are already try once
> there's no reason to keep on calling the shrink function.
> The outer loop actually doesn't have this kind of visibilities.
>

The most common cause I saw during testing was concurrent operations
on the swap entry, if an entry is being loaded/invalidated at the same time
as the zswap writeback, then errors will be returned. This scenario doesn't
seem harmful at all because the failure doesn't indicate that memory
cannot be allocated, just that that particular page should not be written b=
ack.

As far as I understood the voiced concerns, the problem could arise if the
writeback fails due to an impossibility to allocate memory, that could indi=
cate
that the system is in extremely high memory pressure and this loop could
aggravate the situation by adding more contention on the already scarce
available memory.

Since both these cases are treated equally with the retries limit, we're
adopting a conservative approach in considering non-harmful errors as if
they were harmful. This could certainly be improved, but I don't see it as =
an
issue because a differentiation of the errors would actually make the loop =
run
longer than it would without the differentiation.

As I was writing to Yosry, the differentiation would be a great improvement
here, I just have a patch set in the queue that moves the inner reclaim loo=
p
from the zpool driver up to zswap. With that, updating the error handling
would be more convenient as it would be done in one place instead of three.

>
> Chris
>
> >       zswap_pool_put(pool);
> >  }
> >
> > @@ -1188,7 +1192,7 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
> >       if (zswap_pool_reached_full) {
> >              if (!zswap_can_accept()) {
> >                       ret =3D -ENOMEM;
> > -                     goto reject;
> > +                     goto shrink;
> >               } else
> >                       zswap_pool_reached_full =3D false;
> >       }
> > --
> > 2.34.1
> >
