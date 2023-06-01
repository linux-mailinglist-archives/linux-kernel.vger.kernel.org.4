Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CA47194F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjFAICm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjFAIC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:02:29 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5F1E4D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:02:13 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1a2188fdf17so539111fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685606523; x=1688198523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRZjZYxlKfmozXKP41fYYZOiKNIE71+gHVM0u7M437U=;
        b=KoqoJfijI4kXQtFyXjro5tEMpsXudDi9NBfO3/NnE9oRN+G9VdXaDV+kWN3hCvPNgX
         H01p3afdbrn/3T/FOkBZgEADIM5qu5/zDF3hLyY8SB0sayT0I7OQOIaQqajlM7iv44lU
         ohSQxDvC3dyqXDHF+R+ZHXC5rA7UIwtJZ2iBhnemQwFZRDli0mx5kRsGULql3L8eLxWz
         ybNvpx3vdiwITO3tJThUchWTAdOXpoWjN/Gqtja4VNd99yBh7djy7XMNI8Jx5kYIJz6h
         U1M0p0clm9Xnd81hJ1B1CWSDmd/u10XJ4kuoTDc9vTEvUhDIxlPMheaR9wOf+qlDtSjx
         Nl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685606523; x=1688198523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRZjZYxlKfmozXKP41fYYZOiKNIE71+gHVM0u7M437U=;
        b=XsJXfhS82B3HLK6L7WnDsuw3O66HVMxK8NfzQa80JDDliM7Hewj4RUvgozmfhyVx+g
         U7PEmDULxwzCIT5RHVSzQY12x2OZJRKd0CifvZ/ZPhkPEDWiznCoVMeJz9UqQ4cgP10t
         +PHYN3GxZ72T1Cm8NXJD0dwmEo0nMtqjrtZ3/kuj3dnk47PoDgh0pzChS0xhS4aTh6VR
         U0uuAPrWVymSye9WDWvElS05NzBamr1zUs3vYdRwYdrHVCxcEqIxFJ6taDb4muhs0vU0
         +aTPCxfHztwp4lqVxS6yJEbKAF5v8agbfAAkyHYxyNCcWsQXqR/eGXBRL8NxYBEwQsze
         Escg==
X-Gm-Message-State: AC+VfDwAz7E03b3tfvWtGcY9ghNl8RgJPrAVx+5N4bSwiCrAbe7k3h8D
        gO+1t5s/ayGfUPATvOPeKm6giZvoQ0hpWecv+nqbbw==
X-Google-Smtp-Source: ACHHUZ6tXNmDjsRHI+jeobC1q7S70Lux0KBOV/EkIeFfLX/4vW8c/r1AL35d2Z/3qgBRKFDtvtsfPV4imG35yN8bJ/s=
X-Received: by 2002:a05:6870:e606:b0:192:7320:ce with SMTP id
 q6-20020a056870e60600b00192732000cemr4703852oag.40.1685606522700; Thu, 01 Jun
 2023 01:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230522112058.2965866-1-talumbau@google.com> <20230522112058.2965866-2-talumbau@google.com>
In-Reply-To: <20230522112058.2965866-2-talumbau@google.com>
From:   Yuanchu Xie <yuanchu@google.com>
Date:   Thu, 1 Jun 2023 16:01:51 +0800
Message-ID: <CAJj2-QG0cobX72VCOnbyZcb9FREvfj87Dr=6WR0dSHD0u03gDQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 2/4] mm: multi-gen LRU: cleanup lru_gen_soft_reclaim()
To:     "T.J. Alumbaugh" <talumbau@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com
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

Reviewed-by: Yuanchu Xie <yuanchu@google.com>

On Mon, May 22, 2023 at 7:21=E2=80=AFPM T.J. Alumbaugh <talumbau@google.com=
> wrote:
>
> lru_gen_soft_reclaim() gets the lruvec from the memcg and node ID to keep=
 a
> cleaner interface on the caller side.
>
> Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
> ---
>  include/linux/mmzone.h | 4 ++--
>  mm/memcontrol.c        | 2 +-
>  mm/vmscan.c            | 4 +++-
>  3 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 3a68326c9989..5a7ada0413da 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -534,7 +534,7 @@ void lru_gen_exit_memcg(struct mem_cgroup *memcg);
>  void lru_gen_online_memcg(struct mem_cgroup *memcg);
>  void lru_gen_offline_memcg(struct mem_cgroup *memcg);
>  void lru_gen_release_memcg(struct mem_cgroup *memcg);
> -void lru_gen_soft_reclaim(struct lruvec *lruvec);
> +void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid);
>
>  #else /* !CONFIG_MEMCG */
>
> @@ -585,7 +585,7 @@ static inline void lru_gen_release_memcg(struct mem_c=
group *memcg)
>  {
>  }
>
> -static inline void lru_gen_soft_reclaim(struct lruvec *lruvec)
> +static inline void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int ni=
d)
>  {
>  }
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d31fb1e2cb33..738ba18f3a0c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -485,7 +485,7 @@ static void mem_cgroup_update_tree(struct mem_cgroup =
*memcg, int nid)
>
>         if (lru_gen_enabled()) {
>                 if (soft_limit_excess(memcg))
> -                       lru_gen_soft_reclaim(&memcg->nodeinfo[nid]->lruve=
c);
> +                       lru_gen_soft_reclaim(memcg, nid);
>                 return;
>         }
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index cf18873a36b9..e088db138f5f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4846,8 +4846,10 @@ void lru_gen_release_memcg(struct mem_cgroup *memc=
g)
>         }
>  }
>
> -void lru_gen_soft_reclaim(struct lruvec *lruvec)
> +void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
>  {
> +       struct lruvec *lruvec =3D get_lruvec(memcg, nid);
> +
>         /* see the comment on MEMCG_NR_GENS */
>         if (lru_gen_memcg_seg(lruvec) !=3D MEMCG_LRU_HEAD)
>                 lru_gen_rotate_memcg(lruvec, MEMCG_LRU_HEAD);
> --
> 2.40.1.698.g37aff9b760-goog
>
