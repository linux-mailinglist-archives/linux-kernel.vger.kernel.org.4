Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5822C712CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243491AbjEZSxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbjEZSxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:53:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BF513A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:53:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96aae59bbd6so186649766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685127223; x=1687719223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dhx1N1TGbdvEAeyn+I2yRhyKZQXdgWDNWhZQJTXxzk=;
        b=JlR2KKEcvO4TYDGY/qCKJnnEN1I6+TVVKBVzDxAwUXL5Szv6TJ2BVB1WoekEuG3xwd
         92bYotG3atN7k+AOlirMP/bjRx41mEGDm6Hs29/0Ni5KVTd3uObR9WwN58p+4YlsFNPF
         iSFsghph/aeCwCTO0MPEqjeK03a0YWsV0fCQnUUr/IxQ9q+rk9UdsFCt64+IQwXg3wCN
         DtKNyXOlFQ9vcgiVhkyRz2Gzlm6yacd40kCKPe14XLLqdZw5V+hGqPw6v4wyVfl+jmVH
         e9i2L4aHCUwiK5pNxBNRpY1AuI6W5YhV/mHV/ZrrHCBrA6Epu3tohkQI/A7PqcIMJ/C/
         ZM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685127223; x=1687719223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dhx1N1TGbdvEAeyn+I2yRhyKZQXdgWDNWhZQJTXxzk=;
        b=PUiq93qqVc0IayottC5a2IMC3+DuvTB0U99ErDc13FysVshAEMl4lL6FngMGpClr0C
         4vozCzWRA/wJWeSGe5Sar3JFOPnb6U2vwTgx9fk3eBUibeniD49FQaHsffRpU3Gnl1cf
         JqFFK0n+ypQK4H2MP5IBQmXP+Ikres4X/ISmiyYLsBcu9YbEhOYNrvGu8MtPNUzOKvdS
         lPJuuGokiucOGAO11xPOxlbpRD1dk+zmiicAV012D/vUKfQszHcnpbs3SComWjVDMsJI
         C4LLdtL8GQmucbQPOdrokyhPKMSaJnRtIIH/8RG63NHyEHpCCOmI54cKYYIgkZrjjbzQ
         wblw==
X-Gm-Message-State: AC+VfDw87zJ6JIUZg7a1posiTLk7mMAaMANg1b+5X/kmrp1P0cl0m+y0
        jcsDOg5B+kxydBW5J+pTP5O5HKg/mZchdzgDEB8LGmNbNNSllUftSEA=
X-Google-Smtp-Source: ACHHUZ6IVKQsBrbRNLeTcBFPaNMVlPmDaJp7qf/a111fJNpbkC18GhU7zCZA2OXBXfrqmOqbLk+7iZoOJaWCQeF+uqo=
X-Received: by 2002:a17:906:5d0c:b0:965:7fba:6bcf with SMTP id
 g12-20020a1709065d0c00b009657fba6bcfmr3288218ejt.67.1685127222651; Fri, 26
 May 2023 11:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230526183227.793977-1-cerasuolodomenico@gmail.com>
In-Reply-To: <20230526183227.793977-1-cerasuolodomenico@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 26 May 2023 11:53:05 -0700
Message-ID: <CAJD7tkbh5k_sLtSFFJ9GmffiW2iB8kz7+0JjLA-Q3at4Z33aAA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: zswap: shrink until can accept
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        hannes@cmpxchg.org, kernel-team@fb.com
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

On Fri, May 26, 2023 at 11:32=E2=80=AFAM Domenico Cerasuolo
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

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

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
