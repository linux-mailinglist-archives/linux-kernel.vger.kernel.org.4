Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF76E5046
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjDQSdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjDQSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:33:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254F919A0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:33:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94a34a0b531so607319466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681756379; x=1684348379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzpHOK90fOGsax3+uctbvy5okdN/PImGhFs2yhf2bQ8=;
        b=WnJy3uruy1xNvNJQEv6CEwVBKBSKSxtsyLl7lWNpE2T6NotgnKmEPc1FHhuzOT67fg
         UM7fexdqCt5BKSz5vjQHGsGJaA9YnU4bust+HIB/TcfoIAWA+Yw1yRksm1jhP8TpBzES
         JPWjpwE7rrdvClsIhGYYsoZZFjG6Tpy1LFJngI5obMA7yrmIOd+9t4Ny4NWr8uSImZuh
         ClFfHRe/oPE4CaktDzkaBFxn0T2WosNKnUh4fm6w5l6zv3vhlzt7V/xCcaqBt6/JPsiu
         LAG4ZLyjXvO7eo8dXkgaei3mnOqLv1ZY/C0PuLJY3DFLvibiCWZXL0dPHHkJyqwgUwag
         0wHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681756379; x=1684348379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzpHOK90fOGsax3+uctbvy5okdN/PImGhFs2yhf2bQ8=;
        b=Qwt281I0Vh1M3JRGUzTH9Cct824Kd3b+w5dSon58Z5ZXaOrKDX/DaoSXTGX+9cqn+H
         qhZQMc6wFXxF+8usK5LTle2yC3NbokbFKKOoGLm/Wn58OB+t6VJM1bHexz+F5O2rqZNu
         HI4uL7zpgBugSWVNWTAliHnxIQb3x9IjIzHAxmPRwoufAqVL35SxFCqSKvN9GXDpye+T
         S7IQzpVg90Emw7BNLG9Y7hag6Qp80CUDE05M2V4HzuMvssXGZrk9128ZXrj8rTFoLx1C
         6A1zyx+PxCoQcwL1rJ2/tHdZpIpw6/fxRCbegybAP7UP3u9kCcRDVvoyVaIImMqFm2k0
         qZwg==
X-Gm-Message-State: AAQBX9ciINEXY1YJjjtzr00asScFNmMydNZwRCSfYgtC2ZKI6OQPq7jk
        8t2v6E2bwR7oCp0OXi9PTfaABYu4z0DBrgn2+ct9/GjEqQ0tr9zVJMU=
X-Google-Smtp-Source: AKy350Y4Y151kI2stQPw0OPxfnrCNgp/vXvL7SOXx5UOeFUsRfMXKZPL48wlBo92r+gGNeZdNlbg9Huh4E+PVBi+34c=
X-Received: by 2002:a50:9319:0:b0:502:1d1c:7d37 with SMTP id
 m25-20020a509319000000b005021d1c7d37mr7725076eda.8.1681756379333; Mon, 17 Apr
 2023 11:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230417135420.1836741-1-senozhatsky@chromium.org>
In-Reply-To: <20230417135420.1836741-1-senozhatsky@chromium.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 17 Apr 2023 11:32:22 -0700
Message-ID: <CAJD7tkbENFJ3YVrt9fs7AzHVfN+9oCA_4j+9qnpJHrFVEjqhug@mail.gmail.com>
Subject: Re: [PATCHv2] zsmalloc: allow only one active pool compaction context
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Mon, Apr 17, 2023 at 6:54=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> zsmalloc pool can be compacted concurrently by many contexts,
> e.g.
>
>  cc1 handle_mm_fault()
>       do_anonymous_page()
>        __alloc_pages_slowpath()
>         try_to_free_pages()
>          do_try_to_free_pages(
>           lru_gen_shrink_node()
>            shrink_slab()
>             do_shrink_slab()
>              zs_shrinker_scan()
>               zs_compact()
>
> This creates unnecessary contention as all those processes
> compete for access to the same classes. A single compaction
> process is enough. Moreover contention that is created by
> multiple compaction processes impact other zsmalloc functions,
> e.g. zs_malloc(), since zsmalloc uses "global" pool->lock to
> synchronize access to pool.
>
> Introduce pool compaction mutex and permit only one compaction
> context at a time. This reduces overall pool->lock contention.
>
> /proc/lock-stat after make -j$((`nproc`+1)) linux kernel for
> &pool->lock#3:
>
>                 Base           Patched
> ------------------------------------------
> con-bounces     2035730        1540066
> contentions     2343871        1774348
> waittime-min    0.10           0.10
> waittime-max    4004216.24     2745.22
> waittime-total  101334168.29   67865414.91
> waittime-avg    43.23          38.25
> acq-bounces     2895765        2186745
> acquisitions    6247686        5136943
> holdtime-min    0.07           0.07
> holdtime-max    2605507.97     482439.16
> holdtime-total  9998599.59     5107151.01
> holdtime-avg    1.60           0.99

The numbers seem to be better when using an atomic vs. a mutex, is
this just noise or significant difference? (I am not familiar with
lock-stat).

>
> Test run time:
> Base
> 2775.15user 1709.13system 2:13.82elapsed 3350%CPU
>
> Patched
> 2608.25user 1439.03system 2:03.63elapsed 3273%CPU
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

FWIW,
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zsmalloc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index cc81dfba05a0..dfec2fc6a30f 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -264,6 +264,7 @@ struct zs_pool {
>         struct work_struct free_work;
>  #endif
>         spinlock_t lock;
> +       atomic_t compaction_in_progress;
>  };
>
>  struct zspage {
> @@ -2274,6 +2275,9 @@ unsigned long zs_compact(struct zs_pool *pool)
>         struct size_class *class;
>         unsigned long pages_freed =3D 0;
>
> +       if (atomic_xchg(&pool->compaction_in_progress, 1))
> +               return 0;
> +
>         for (i =3D ZS_SIZE_CLASSES - 1; i >=3D 0; i--) {
>                 class =3D pool->size_class[i];
>                 if (class->index !=3D i)
> @@ -2281,6 +2285,7 @@ unsigned long zs_compact(struct zs_pool *pool)
>                 pages_freed +=3D __zs_compact(pool, class);
>         }
>         atomic_long_add(pages_freed, &pool->stats.pages_compacted);
> +       atomic_set(&pool->compaction_in_progress, 0);
>
>         return pages_freed;
>  }
> @@ -2388,6 +2393,7 @@ struct zs_pool *zs_create_pool(const char *name)
>
>         init_deferred_free(pool);
>         spin_lock_init(&pool->lock);
> +       atomic_set(&pool->compaction_in_progress, 0);
>
>         pool->name =3D kstrdup(name, GFP_KERNEL);
>         if (!pool->name)
> --
> 2.40.0.634.g4ca3ef3211-goog
>
