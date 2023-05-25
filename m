Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30840710223
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 02:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjEYA7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 20:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEYA7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 20:59:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50AFE6
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:59:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-970056276acso230812566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684976354; x=1687568354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7O+MGtW5STi1cURc/ErCWnTNocNwaHwGgp9OHGvjA0=;
        b=pMz8ll0IxQ5yt8R9P6I8xCZPu9I+cRgIgR3+fBngOI9Ig7lCBR4bBb/ZreCFBEkV6I
         z1iRo+NksYKieTfBkmU3SyzoD2QJOsgfqfcIRY0PDC+eACyWOCuOJRRWBFQxiGPnkjah
         M+ftVkksFE5B+LjOvF3WOD1XmL3LFnNKQ298IIzheeE1ZE+BhKJUZvYfcJ0ZtLcGSRLV
         l9SL1FNMexJgROK9Y7FQ8oA3Y8QHee8NcG36fTnUZK+2KsCpvsCHxtz/br+LuimwjIK1
         xzhYwcUIcXcXO2dw8X6NEcZ5OUsYiz8sG3snAVD+IK8WwuO0TEwZ1YFnHy2zTNB8876U
         HPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684976354; x=1687568354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7O+MGtW5STi1cURc/ErCWnTNocNwaHwGgp9OHGvjA0=;
        b=jQ7U0kqwjD8IdblfBSQexxIdBuoqbqE/y7gV/KXpoZrRolPR4f+8hD27jGrGxvinfs
         c75x5dYpqUP7B6h7wjV8rr2ER5n+kjzLLWd7RtnVSCY8m5oNqPAalr20RrE6zafAivUq
         ex57m9gxFvp5Cr7v7vyi6b3nGPAGlQTSk2AyXZX+7JRqQfwqB+ZKR6An6sMcQkQbWDZU
         A4S/I1glkis0av8fVff5CcKQPaYVAVl9BJswO1Gkcqntv9nJ+PFkXS8M5zW5PwopATut
         BBZxR3zU41bC3MbzAJ1OIqzvhp1k4RV9ZcwJBF4Jbn+CzEzuT0BkG4wtXhHLfohhM8ha
         Op5w==
X-Gm-Message-State: AC+VfDx7gT7bkW/y6iEs71vCeigVT7RdVNpQ3e4nWeUzIRu9U+90MFEp
        L3AtMVLhzv+CfwaznERHwerXK3TnpctDUbNtxQgCiZXuUA2mdA3HcG7EEw==
X-Google-Smtp-Source: ACHHUZ6659Z/p96w9VxQsaT1zGhL4bqwzwOESDGtnuFvYDxmymXnSko3zu+QU9Z/qu7PVPXu2hAOlCCWlMaiIs+pVDo=
X-Received: by 2002:a17:907:3206:b0:94f:6058:4983 with SMTP id
 xg6-20020a170907320600b0094f60584983mr16257342ejb.76.1684976353990; Wed, 24
 May 2023 17:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
In-Reply-To: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 24 May 2023 17:58:37 -0700
Message-ID: <CAJD7tkY0j4xzstf=OCX-k-mujzbXf_nt=H4F5JCZNZ8N1iEEcg@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: shrink until can accept
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

Hi Domenico,

On Tue, May 23, 2023 at 11:50=E2=80=AFPM Domenico Cerasuolo
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

Impressive numbers, and great find in general!

I wonder how other workloads benefit/regress from this change.
Anything else that you happened to run? :)

>
> Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool limit=
 is hit")
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  mm/zswap.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 59da2a415fbb..2ee0775d8213 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -587,9 +587,13 @@ static void shrink_worker(struct work_struct *w)
>  {
>         struct zswap_pool *pool =3D container_of(w, typeof(*pool),
>                                                 shrink_work);
> +       int ret;
>
> -       if (zpool_shrink(pool->zpool, 1, NULL))
> -               zswap_reject_reclaim_fail++;
> +       do {
> +               ret =3D zpool_shrink(pool->zpool, 1, NULL);
> +               if (ret)
> +                       zswap_reject_reclaim_fail++;
> +       } while (!zswap_can_accept() && ret !=3D -EINVAL);

One question/comment here about the retry logic.

So I looked through the awfully convoluted writeback code, and there
are multiple layers, and some of them tend to overwrite the return
value of the layer underneath :(

For zsmalloc (as an example):
zpool_shrink()->zs_zpool_shrink()->zs_reclaim_page()->zpool_ops.evict()->zs=
wap_writeback_entry().

First of all, that zpool_ops is an unnecessarily confusing
indirection, but anyway.

- zswap_writeback_entry() will either return -ENOMEM or -EEXIST on error
- zs_reclaim_page()/zbud_reclaim_page() will return -EINVAL if the lru
is empty, and -EAGAIN on other errors.
- zs_zpool_shrink()/zbud_zpool_shrink() will mostly propagate the
return value of  zs_reclaim_page()/zbud_reclaim_page().
- zpool_shrink() will return -EINVAL if the driver does not support
shrinking, otherwise it will propagate the return value from the
driver.

So it looks like we will get -EINVAL only if the driver lru is empty
or the driver does not support writeback, so rightfully we should not
retry.

If zswap_writeback_entry() returns -EEXIST, it probably means that we
raced with another task decompressing the page, so rightfully we
should retry to writeback another page instead.

If zswap_writeback_entry() returns -ENOMEM, it doesn't necessarily
mean that we couldn't allocate memory (unfortunately), it looks like
we will return -ENOMEM in other cases as well. Arguably, we can retry
in all cases, because even if we were actually out of memory, we are
trying to make an allocation that will eventually free more memory.

In all cases, I think it would be nicer if we retry if ret =3D=3D -EAGAIN
instead. It is semantically more sane. In this specific case it is
functionally NOP as zs_reclaim_page()/zbud_reclaim_page() will mostly
return -EAGAIN anyway, but in case someone tries to use saner errnos
in the future, this will age better.

Also, do we intentionally want to keep retrying forever on failure? Do
we want to add a max number of retries?

>         zswap_pool_put(pool);
>  }
>
> @@ -1188,7 +1192,7 @@ static int zswap_frontswap_store(unsigned type, pgo=
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
