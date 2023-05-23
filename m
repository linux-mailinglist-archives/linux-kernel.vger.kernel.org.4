Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0886470D09B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjEWBj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjEWBjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:39:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8FA90
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:39:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1285614466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 18:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684805982; x=1687397982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrcX1CSiLCXeFc2H8bMb+WXn6DJRSUX5JYbVI8Ce8+Q=;
        b=m/aDe7Z8+MwMc0JlHAOIYgvj/qIESOpABmRKmKOfl5e7SfUra0W1xbgUv84ZOB58P/
         /lKH0zLU80c+fAWrKlJSQcpvGWUnfUX8SzoKYTsgK/qq+FL8dSwmW3YUrLhBdKwHNOIz
         TZ6mqbiPAtXC0kS4paOtDd/55crKjPAqqs/VGjWGPRwhM4iFfxuRiqzygT53mHbDr4Ud
         jEz+uLFBEkslB4HqDrl0/19IjKiG0Bum4dEyTSTk3VqMxeKWyG5MLQK/1Di3zT2NY+aw
         mz7sQXfIjt8uZFuB7W5ARadesmjM+t7axKd74dlHmh4rAmsv1pTdxDv8z9FWxCUeokHI
         LrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684805982; x=1687397982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrcX1CSiLCXeFc2H8bMb+WXn6DJRSUX5JYbVI8Ce8+Q=;
        b=E2ILiKA+XSqAAU5J+oiMkE3Tpt4qk3akMOCJ9KjQr8J5edJeAxZgLdEoyZMOQI0Wqb
         0u5YBcbXNPQrjdABgaUoIuhX/SfDF65zVoBnmC8QYdIA7B0t2EVZwzeObgwvOf8B//fp
         vfdCdyT+9goOnmw5fqMrwZebp0uy9JkPzqJw5yJ+YELqrr37VZn1n3ouPM7b2ZhpEsnJ
         2R6lSkA6w6yTb3NEWO4MVKFmcpkfugDK5m/AOvuHWwlYZm5Hp0dsatauTbZJR1Uigj+V
         OW0Km5+n+WuweTYKpw4JpNcj3oi56dscecltXmt3zZTo4aI4JxdyVdB7UOzQOxT/2Y+4
         vgDA==
X-Gm-Message-State: AC+VfDy8ntYX0bLjvN7oYPcvcBGmxwK3BXfYzM8on1YNdWzno2wsXr2z
        lTQBbg6301a14+dYOKy5SMKwGAq6y+ufEHe0YLMrtA==
X-Google-Smtp-Source: ACHHUZ4oTAFpYmzEnxnqIpP3J/+qMbmQqG5Hjz2KbdOplyMhgUeFHEcGjCybPEmifB0Lu9OWBHnMmKNWEK7R9VMhEdE=
X-Received: by 2002:a17:907:a407:b0:96f:daf3:c66b with SMTP id
 sg7-20020a170907a40700b0096fdaf3c66bmr6073621ejc.30.1684805982125; Mon, 22
 May 2023 18:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230522070905.16773-1-ying.huang@intel.com> <20230522070905.16773-5-ying.huang@intel.com>
In-Reply-To: <20230522070905.16773-5-ying.huang@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 22 May 2023 18:39:05 -0700
Message-ID: <CAJD7tkYnN23h0N3chqEu_DesSsOaFE6MTQ4Yw3eAZZb=ohWM4g@mail.gmail.com>
Subject: Re: [PATCH -V2 4/5] swap: remove get/put_swap_device() in __swap_duplicate()
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
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

On Mon, May 22, 2023 at 12:09=E2=80=AFAM Huang Ying <ying.huang@intel.com> =
wrote:
>
> __swap_duplicate() is called by
>
> - swap_shmem_alloc(): the page lock of the swap cache is held.
>
> - copy_nonpresent_pte() -> swap_duplicate() and try_to_unmap_one() ->
>   swap_duplicate(): the page table lock is held.
>
> - __read_swap_cache_async() -> swapcache_prepare(): enclosed with
>   get/put_swap_device() in __read_swap_cache_async() already.
>
> So, it's safe to remove get/put_swap_device() in __swap_duplicate().
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> ---
>  mm/swapfile.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index e9cce775fb25..4dbaea64635d 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3264,9 +3264,7 @@ static int __swap_duplicate(swp_entry_t entry, unsi=
gned char usage)

I would add a comment above this function stating that the caller
needs to provide protection against swapoff, and refer to the comment
above get_swap_device().

Otherwise, LGTM with David's comment.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

>         unsigned char has_cache;
>         int err;
>
> -       p =3D get_swap_device(entry);
> -       if (!p)
> -               return -EINVAL;
> +       p =3D swp_swap_info(entry);
>
>         offset =3D swp_offset(entry);
>         ci =3D lock_cluster_or_swap_info(p, offset);
> @@ -3313,7 +3311,6 @@ static int __swap_duplicate(swp_entry_t entry, unsi=
gned char usage)
>
>  unlock_out:
>         unlock_cluster_or_swap_info(p, ci);
> -       put_swap_device(p);
>         return err;
>  }
>
> --
> 2.39.2
>
>
