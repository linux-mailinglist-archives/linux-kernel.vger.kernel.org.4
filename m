Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E1E6F7E4F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjEEICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjEEICi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:02:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D8217FE5
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 01:02:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso1692947e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 01:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683273756; x=1685865756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fbuRo3h5EmOX7ozGvJB42czu0NHSlI3RqyThUj5mBo=;
        b=r2tm8XmZ8I2daChoV5gdUed5f/GdQhQp0Gw+vyyTdKUsv3/nrqG1ZT2kH8kk5aeUYG
         koVXIrk3/GAivaLXsgDBcw6QZxK8V9Ie/n5jkd6VKS1aXRgEgYoUI81vCJ9k8Kd1P/q2
         41blV+kv+oPPdG0yFc1OiZ+x5BfyRFCEMlifpiLygIrtsBA5ZGrf210AUGEOSmz+BE/9
         irkUZxH5+MBkkdFjrDKMtMVioEC9W/R4nFWIZxJp+fs19MCD9JZRPVpivDzjfoGo6/4p
         lcpY2Vv0XgAi1uubBRBBMcp2NAGaltkPVYedTn6N0EDB/Xtg2clBiz6ZMMF3mh2DqqC9
         u0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683273756; x=1685865756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fbuRo3h5EmOX7ozGvJB42czu0NHSlI3RqyThUj5mBo=;
        b=Vu2hYqDkmxnsEGtjZjuuRMCirBIiIX3Lb/tCaPv4+2AGqN0NjBHjRKR1xFEaurUW6x
         CGzmA2lD0kbPxH7V4KichHAfz3Qzibk/VXUjhKZ9+qLHGUknHQ9uYuB7YZwyztyf39+z
         iAa1/2knWbWjsSLFpmZ6qL7aOqkl3LkEbsrZNvgjCWwPTq8ngYja+oLff+t/IcRjpUrj
         /97oDpM+oHnD95vBN/YXE/PJRLYty+I0ruTNI8a3IjWyT1kgOGibN0Q/1SBlxpuR15gH
         zEG+KsSunsanGyF3IhF2/Q3EAivLWRgM2HZ3+wb49SdGkh1XtEL4uVsHWCsHt6wbY9FH
         AsCw==
X-Gm-Message-State: AC+VfDwel/YYANSt4sw0HsbVDIi6tNFNC3i47jLlizkcUtjjCISNfEGz
        aHz4suFJXx5/ycev3AE8uGnOMTMuSTTZ2GF9TRg+xRWc
X-Google-Smtp-Source: ACHHUZ6vDolii3Aki9T/T+8AbhJCLGMwK00GXMfo3btxwH5gcAQwdLK3TfAVH7q4YvHsEGzVaGPSgMsakMEZAmYqwAY=
X-Received: by 2002:ac2:4846:0:b0:4f0:15dc:4f23 with SMTP id
 6-20020ac24846000000b004f015dc4f23mr292344lfy.29.1683273755424; Fri, 05 May
 2023 01:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <1683194994-3070-1-git-send-email-zhaoyang.huang@unisoc.com>
In-Reply-To: <1683194994-3070-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 5 May 2023 16:02:12 +0800
Message-ID: <CAGWkznEqH3b5VbgEa0CFKcZPharKx=wrT0iEea3fGfEoVf0n-A@mail.gmail.com>
Subject: Re: [PATCHv2] mm: optimization on page allocation when CMA enabled
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, kernel-team@fb.com,
        Qian Cai <cai@lca.pw>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
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

add more reviewer

On Thu, May 4, 2023 at 6:11=E2=80=AFPM zhaoyang.huang <zhaoyang.huang@uniso=
c.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Let us look at the series of scenarios below with WMARK_LOW=3D25MB,WMARK_=
MIN=3D5MB
> (managed pages 1.9GB). We can know that current 'fixed 1/2 ratio' start t=
o use
> CMA since C which actually has caused U&R lower than WMARK_LOW (this shou=
ld be
> deemed as against current memory policy, that is, U&R should either stay =
around
> WATERMARK_LOW when no allocation or do reclaim via enter slowpath)
>
> free_cma/free_pages(MB)      A(12/30)     B(12/25)     C(12/20)
> fixed 1/2 ratio                 N             N           Y
> this commit                     Y             Y           Y
>
> Suggested-by: Roman Gushchin <roman.gushchin@linux.dev>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: do proportion check when zone_watermark_ok, update commit message
> ---
> ---
>  mm/page_alloc.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0745aed..d0baeab 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3071,6 +3071,34 @@ static bool unreserve_highatomic_pageblock(const s=
truct alloc_context *ac,
>
>  }
>
> +#ifdef CONFIG_CMA
> +static bool __if_use_cma_first(struct zone *zone, unsigned int order, un=
signed int alloc_flags)
> +{
> +       unsigned long cma_proportion =3D 0;
> +       unsigned long cma_free_proportion =3D 0;
> +       unsigned long watermark =3D 0;
> +       long count =3D 0;
> +       bool cma_first =3D false;
> +
> +       watermark =3D wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> +       /*check if GFP_MOVABLE pass previous watermark check via the help=
 of CMA*/
> +       if (!zone_watermark_ok(zone, order, watermark, 0, alloc_flags & (=
~ALLOC_CMA)))
> +               /* WMARK_LOW failed lead to using cma first, this helps U=
&R stay
> +                * around low when being drained by GFP_MOVABLE
> +                */
> +               cma_first =3D true;
> +       else {
> +               /*check proportion when zone_watermark_ok*/
> +               count =3D atomic_long_read(&zone->managed_pages);
> +               cma_proportion =3D zone->cma_pages * 100 / count;
> +               cma_free_proportion =3D zone_page_state(zone, NR_FREE_CMA=
_PAGES) * 100
> +                       /  zone_page_state(zone, NR_FREE_PAGES);
> +               cma_first =3D (cma_free_proportion >=3D cma_proportion * =
2
> +                               || cma_free_proportion >=3D 50);
> +       }
> +       return cma_first;
> +}
> +#endif
>  /*
>   * Do the hard work of removing an element from the buddy allocator.
>   * Call me with the zone->lock already held.
> @@ -3087,10 +3115,10 @@ static bool unreserve_highatomic_pageblock(const =
struct alloc_context *ac,
>                  * allocating from CMA when over half of the zone's free =
memory
>                  * is in the CMA area.
>                  */
> -               if (alloc_flags & ALLOC_CMA &&
> -                   zone_page_state(zone, NR_FREE_CMA_PAGES) >
> -                   zone_page_state(zone, NR_FREE_PAGES) / 2) {
> -                       page =3D __rmqueue_cma_fallback(zone, order);
> +               if (migratetype =3D=3D MIGRATE_MOVABLE) {
> +                       bool cma_first =3D __if_use_cma_first(zone, order=
, alloc_flags);
> +
> +                       page =3D cma_first ? __rmqueue_cma_fallback(zone,=
 order) : NULL;
>                         if (page)
>                                 return page;
>                 }
> --
> 1.9.1
>
