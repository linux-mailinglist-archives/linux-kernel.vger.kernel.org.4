Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54945716A16
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjE3QxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjE3QxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:53:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A26B0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:53:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f53c06babso826614866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685465594; x=1688057594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aF7XT/V8A+EmUF4H6TrosCGCD/VolbgayQqm4IfFj8=;
        b=pDuJR480Ut22E+122SeneUS/qZYcQos4cTdGtYoEzTIcNpP5N6GvjOH959lQL+utw4
         a0KaW5Hj0d8m9uR0hLeoPP3DDBC+CahD50PIMQ41DQh5DFvIOtFHUrjBTt05Y4neWqlo
         maSL+ZK97MdtfCV3hBrWlvmANB5SA0uZoLGM+kLpz4sNyhpyMM54I4Tc20q9ANByD2ZN
         XMqqlNY6NrLBObrFxq3lS1vV7/DeVbBCff1EahUpUuve9hdjEnVpYwRx1oUC676g6Tgk
         JDq5xDEGI6G9b06SEtmpaDQeiV8IrYV9adVtBjXmla6zJP8s/ozMhjKiL7siBQxh/Wp4
         nVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685465594; x=1688057594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aF7XT/V8A+EmUF4H6TrosCGCD/VolbgayQqm4IfFj8=;
        b=UHHSXcduB6OUIVmRVdwdn1fyXegSPPxdLnXDQMeCCdS9yFVdNoVUlw/HXJKNspLqjw
         3N5qiSU11MmOCXBgjr/1oW5rFMMu7gTSaSUgMTmpNm8nnNbR6lteLldxl4Hy2BxTqLLh
         T0dMh7wM0kUVYRvM955juTGU/bNHN4CX9xmUaZA7dMGBV4RAZI7lzaIFNGmHjb7KeXik
         2Pf461tB64GrRAQutt0Bc2NKolDoo9AJ9NgWftigsFQp0KB/6qmysQqK5T2M3UUceHeg
         Z5HtviA/f690bqVahcjpncB7z31d58tRr5Krn3txGKeQH2NYR9cgh0WcuJzq8DQad8ax
         LhUQ==
X-Gm-Message-State: AC+VfDzHIm40KXKsui4GBQUfLFp5kZQukNyj3kZ+w9cEHEaLpP9Vd5Xo
        mBqZeobK+EjHhbWgOlr61LNCXJw2lZIVwSb7OqVpRw==
X-Google-Smtp-Source: ACHHUZ5/nDAhDcXoOlJhT1KwpeTwEyHUXOiNccneHAYAYOvfYSB2cThFyg1g+cUdqhp0f5NDo9llx3ymUi/VcCegkok=
X-Received: by 2002:a17:907:868d:b0:957:17c5:8705 with SMTP id
 qa13-20020a170907868d00b0095717c58705mr3119009ejc.51.1685465593698; Tue, 30
 May 2023 09:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230530162153.836565-1-nphamcs@gmail.com>
In-Reply-To: <20230530162153.836565-1-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 30 May 2023 09:52:36 -0700
Message-ID: <CAJD7tkZJttvpYs4mgjL3pt8-jkX0fnWRJP7hVBZmm=i_Ef3Abg@mail.gmail.com>
Subject: Re: [PATCH] zswap: do not shrink when memory.zswap.max is 0
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
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

On Tue, May 30, 2023 at 9:22=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> Before storing a page, zswap first checks if the number of stored pages
> exceeds the limit specified by memory.zswap.max, for each cgroup in the
> hierarchy. If this limit is reached or exceeded, then zswap shrinking is
> triggered and short-circuits the store attempt.
>
> However, if memory.zswap.max =3D 0 for a cgroup, no amount of writeback
> will allow future store attempts from processes in this cgroup to
> succeed. Furthermore, this create a pathological behavior in a system
> where some cgroups have memory.zswap.max =3D 0 and some do not: the
> processes in the former cgroups, under memory pressure, will evict pages
> stored by the latter continually, until the need for swap ceases or the
> pool becomes empty.
>
> As a result of this, we observe a disproportionate amount of zswap
> writeback and a perpetually small zswap pool in our experiments, even
> though the pool limit is never hit.
>
> This patch fixes the issue by rejecting zswap store attempt without
> shrinking the pool when memory.zswap.max is 0.
>
> Fixes: f4840ccfca25 ("zswap: memcg accounting")
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/memcontrol.h | 6 +++---
>  mm/memcontrol.c            | 8 ++++----
>  mm/zswap.c                 | 9 +++++++--
>  3 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 222d7370134c..507bed3a28b0 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1899,13 +1899,13 @@ static inline void count_objcg_event(struct obj_c=
group *objcg,
>  #endif /* CONFIG_MEMCG_KMEM */
>
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> +int obj_cgroup_may_zswap(struct obj_cgroup *objcg);
>  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
>  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
>  #else
> -static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> +static inline int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>  {
> -       return true;
> +       return 0;
>  }
>  static inline void obj_cgroup_charge_zswap(struct obj_cgroup *objcg,
>                                            size_t size)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4b27e245a055..09aad0e6f2ea 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7783,10 +7783,10 @@ static struct cftype memsw_files[] =3D {
>   * spending cycles on compression when there is already no room left
>   * or zswap is disabled altogether somewhere in the hierarchy.
>   */
> -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> +int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>  {
>         struct mem_cgroup *memcg, *original_memcg;
> -       bool ret =3D true;
> +       int ret =3D 0;
>
>         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>                 return true;
> @@ -7800,7 +7800,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>                 if (max =3D=3D PAGE_COUNTER_MAX)
>                         continue;
>                 if (max =3D=3D 0) {
> -                       ret =3D false;
> +                       ret =3D -ENODEV;
>                         break;
>                 }
>
> @@ -7808,7 +7808,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
>                 pages =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_S=
IZE;
>                 if (pages < max)
>                         continue;
> -               ret =3D false;
> +               ret =3D -ENOMEM;
>                 break;
>         }
>         mem_cgroup_put(original_memcg);
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 59da2a415fbb..7b13dc865438 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1175,8 +1175,13 @@ static int zswap_frontswap_store(unsigned type, pg=
off_t offset,
>         }
>
>         objcg =3D get_obj_cgroup_from_page(page);
> -       if (objcg && !obj_cgroup_may_zswap(objcg))
> -               goto shrink;
> +       if (objcg) {
> +               ret =3D obj_cgroup_may_zswap(objcg);
> +               if (ret =3D=3D -ENODEV)
> +                       goto reject;
> +               if (ret =3D=3D -ENOMEM)
> +                       goto shrink;
> +       }

I wonder if we should just make this:

if (objcg && !obj_cgroup_may_zswap(objcg))
        goto reject;

Even if memory.zswap.max is > 0, if the limit is hit, shrinking the
zswap pool will only help if we happen to writeback a page from the
same memcg that hit its limit. Keep in mind that we will only
writeback one page every time we observe that the limit is hit (even
with Domenico's patch, because zswap_can_accept() should be true).

On a system with a handful of memcgs,
it seems likely that we wrongfully writeback pages from other memcgs
because of this. Achieving nothing for this memcg, while hurting
others. OTOH, without invoking writeback when the limit is hit, the
memcg will just not be able to use zswap until some pages are
faulted back in or invalidated.

I am not sure which is better, just thinking out loud.

Seems like this can be solved by having per-memcg LRUs, or at least
providing an argument to the shrinker of which memcg to reclaim from.
This would only be possible when the LRU is moved to zswap.


>
>         /* reclaim space if needed */
>         if (zswap_is_full()) {
> --
> 2.34.1
>
>
