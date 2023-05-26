Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB41C712D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbjEZTOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjEZTOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:14:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683D213A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:14:31 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b011cffef2so9171985ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1685128471; x=1687720471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5x3XJWx1/nmx62cve4XckRaGFykR4ZpnsebTaJ31FU=;
        b=TMqInZcA6suiFfe0+hyfa9q5CSrRxFnc803hnqBHTivD4iyiKD3DDDQwcBOGY36bNP
         Ff7owmywwGkLncogN43ovQHWk+DpFXSwOspnU2AT8yx0XMd/21FLtq2P2Qh3/qiBhCC3
         xP9p8LTdAsn/0yxFjhdaKiSsXCljDY3tNVOq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685128471; x=1687720471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5x3XJWx1/nmx62cve4XckRaGFykR4ZpnsebTaJ31FU=;
        b=gumqdanv3BHAnm0srruSubOL9U5coNjcc7qEJWAwuYfgtt6EJ3WZ3WgQp8zU8CBeuF
         Vh1uC44pMyJJcCGMc8345qUfqYlaOobuzOOjjuhAhdP3/s39f2Ar5WblUjqVVEfVtad8
         USL6+EDoKmbENPkX9deasT699hcZc+IPsMi0fuZ2ZUTZrfUmGifCzL/6qV4CYjUZ7EfM
         TlBkGmLexRGigUaXAeekD+7zCnb0eZWNtCrAoutVC4deYBVD96yI+6CIrQBSQ/PI7dmq
         RLjBaCIR43oe6Fh/u34YqNNbnXhgI/TKFKUfo/7gWy2xDgrwM+fgYYylbIXOesTbyBGb
         0KEg==
X-Gm-Message-State: AC+VfDyPljddcvR4PdrNwvAaLsRj/ZS/knVPAUzNGzu6N84F5JsG+ePk
        72Tx1jU2lE5tT5B5q8aAN1QSMUCcDLO0QmubNnvfKA==
X-Google-Smtp-Source: ACHHUZ55SmRVQfgWXX7XDjjkUEr0Y5hLZsamcIz8yyUNqpwpuRDwUQXDdOelxW4oWR+IE6SHQsX3IAqJ+V97kx+u8Jc=
X-Received: by 2002:a17:903:280f:b0:1ac:a6b0:1c87 with SMTP id
 kp15-20020a170903280f00b001aca6b01c87mr3098912plb.48.1685128470662; Fri, 26
 May 2023 12:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230526183227.793977-1-cerasuolodomenico@gmail.com>
In-Reply-To: <20230526183227.793977-1-cerasuolodomenico@gmail.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Fri, 26 May 2023 21:14:19 +0200
Message-ID: <CAM4kBBKmJfONpxakG=0jrH+PRzZJtUFZGtZqUzcexHWYTtYv_g@mail.gmail.com>
Subject: Re: [PATCH v3] mm: zswap: shrink until can accept
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, yosryahmed@google.com,
        hannes@cmpxchg.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 8:32=E2=80=AFPM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> This update addresses an issue with the zswap reclaim mechanism, which
> hinders the efficient offloading of cold pages to disk, thereby
> compromising the preservation of the LRU order and consequently
> diminishing, if not inverting, its performance benefits.
>
> The functioning of the zswap shrink worker was found to be inadequate,
> as shown by basic benchmark test. For the test, a kernel build was
> utilized as a reference, with its memory confined to 1G via a cgroup and
> a 5G swap file provided. The results are presented below, these are
> averages of three runs without the use of zswap:
>
> real 46m26s
> user 35m4s
> sys 7m37s
>
> With zswap (zbud) enabled and max_pool_percent set to 1 (in a 32G
> system), the results changed to:
>
> real 56m4s
> user 35m13s
> sys 8m43s
>
> written_back_pages: 18
> reject_reclaim_fail: 0
> pool_limit_hit:1478
>
> Besides the evident regression, one thing to notice from this data is
> the extremely low number of written_back_pages and pool_limit_hit.
>
> The pool_limit_hit counter, which is increased in zswap_frontswap_store
> when zswap is completely full, doesn't account for a particular
> scenario: once zswap hits his limit, zswap_pool_reached_full is set to
> true; with this flag on, zswap_frontswap_store rejects pages if zswap is
> still above the acceptance threshold. Once we include the rejections due
> to zswap_pool_reached_full && !zswap_can_accept(), the number goes from
> 1478 to a significant 21578266.
>
> Zswap is stuck in an undesirable state where it rejects pages because
> it's above the acceptance threshold, yet fails to attempt memory
> reclaimation. This happens because the shrink work is only queued when
> zswap_frontswap_store detects that it's full and the work itself only
> reclaims one page per run.
>
> This state results in hot pages getting written directly to disk,
> while cold ones remain memory, waiting only to be invalidated. The LRU
> order is completely broken and zswap ends up being just an overhead
> without providing any benefits.
>
> This commit applies 2 changes: a) the shrink worker is set to reclaim
> pages until the acceptance threshold is met and b) the task is also
> enqueued when zswap is not full but still above the threshold.
>
> Testing this suggested update showed much better numbers:
>
> real 36m37s
> user 35m8s
> sys 9m32s
>
> written_back_pages: 10459423
> reject_reclaim_fail: 12896
> pool_limit_hit: 75653
>
> V2:
> - loop against =3D=3D -EAGAIN rather than !=3D -EINVAL and also break the=
 loop
> on MAX_RECLAIM_RETRIES (thanks Yosry)
> - cond_resched() to ensure that the loop doesn't burn the cpu (thanks
> Vitaly)
>
> V3:
> - fix wrong loop break, should continue on !ret (thanks Johannes)
>
> Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool limit=
 is hit")
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>

> ---
>  mm/zswap.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 59da2a415fbb..bcb82e09eb64 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -37,6 +37,7 @@
>  #include <linux/workqueue.h>
>
>  #include "swap.h"
> +#include "internal.h"
>
>  /*********************************
>  * statistics
> @@ -587,9 +588,19 @@ static void shrink_worker(struct work_struct *w)
>  {
>         struct zswap_pool *pool =3D container_of(w, typeof(*pool),
>                                                 shrink_work);
> +       int ret, failures =3D 0;
>
> -       if (zpool_shrink(pool->zpool, 1, NULL))
> -               zswap_reject_reclaim_fail++;
> +       do {
> +               ret =3D zpool_shrink(pool->zpool, 1, NULL);
> +               if (ret) {
> +                       zswap_reject_reclaim_fail++;
> +                       if (ret !=3D -EAGAIN)
> +                               break;
> +                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> +                               break;
> +               }
> +               cond_resched();
> +       } while (!zswap_can_accept());
>         zswap_pool_put(pool);
>  }
>
> @@ -1188,7 +1199,7 @@ static int zswap_frontswap_store(unsigned type, pgo=
ff_t offset,
>         if (zswap_pool_reached_full) {
>                if (!zswap_can_accept()) {
>                         ret =3D -ENOMEM;
> -                       goto reject;
> +                       goto shrink;
>                 } else
>                         zswap_pool_reached_full =3D false;
>         }
> --
> 2.34.1
>
