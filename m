Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973725BC28E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 07:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiISFiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 01:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiISFiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 01:38:11 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2654C18340
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 22:38:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a2so21172353lfb.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 22:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ar1cIlsH2x7/veNswkzicYr/hnf1XxcaKOODh9BJCmY=;
        b=WkhsiXuqhaYpAiR2Tu3CRIkIZrpKktHxL/gX/Cg1galoMiacJW/wjWzMSpuoN1pf8B
         tmoSVgzIjPKAVP7rguPGmVlobPrH3ukFXHYscmEMGq+QJ14+hZ/OW3WEMUp2cyJUgMMr
         +EizWtqsgKuze+wzagF3XC/4qBCV7wmNo4R3x6XnglPtHXmMsR3JMfB3ZkOgdeu2o7H3
         5HitPMl0rsYckMZN8w/Q7xNHeaaYV2218wn6P2zjhR22+ThfSvX+Y1g33aZf4KaZ9vl3
         2HNbm5qHNjxA39FfjT/JXXbyCnCx5/1vfFDjk/uSNllWML+F5M0hgxEgggEI5TbZEZJP
         VwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ar1cIlsH2x7/veNswkzicYr/hnf1XxcaKOODh9BJCmY=;
        b=x7zPWtLhCKKJvGhsuV7C/fnXqN8MbHnMe1RbnKZX2V4dJaoJ3M5ySgU/S+BuCU+4FQ
         kCebFNkPa3EK0avgiBfoBgjfYi7HD8P2hfY1vzc6MPO3gNkH+z5P8sloO46TWjBsZlP1
         MpDS0XZxzfdnkpD+Mkw5BaSndJPtior2f6AfPet4tiYYATJgkjuKl6havuY5QNJqhALw
         WZfQUNBZIt7ZA/MkAvbvvU/GEd+/T0RAnqj4hMND+uMhqJvJRBRYLpqce0teSuK83NBL
         /dyePCWWOhpRCqHDhwo4165Y50vEPJ/nX2zZeNn10bxelbxNh/WE+K3GKE5VRwAuxpni
         8LVA==
X-Gm-Message-State: ACrzQf0EVAePEWojiVrQaD2emRTb1jAEAcD+jSZ8kV6dO4zvGiFOasdm
        cof/l8XxIpQqOd4W77i4SLqXlVzwoHIg2py7U5mk5cO+p80=
X-Google-Smtp-Source: AMsMyM7eze1r52dBg67odLQkS6NRBmYKUMTkBTSg+QRoZ37nm81kdPkXPo500kjR6rm0d6iVkkxbeBta3vlV4GcP2lQ=
X-Received: by 2002:a05:6512:159a:b0:49f:6357:971 with SMTP id
 bp26-20020a056512159a00b0049f63570971mr3218085lfb.81.1663565888427; Sun, 18
 Sep 2022 22:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <1663559238-22918-1-git-send-email-zhaoyang.huang@unisoc.com>
In-Reply-To: <1663559238-22918-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 19 Sep 2022 13:37:40 +0800
Message-ID: <CAGWkznHPBTChePBRZ-kf8Db88Hm9SCNZfV_BeOU-Q7NtUgrFpQ@mail.gmail.com>
Subject: Re: [PATCH] mm: check high-order page when free it to pcp
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current free_pcp_prepare logic should be inherited from the code
before 44042b4498, where high order pages only reside in the global
list and will be checked during free and alloc.

On Mon, Sep 19, 2022 at 11:47 AM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> High-order pcp page escaped from checking when both of DEBUG_VM and debug_pagealloc
> are all disabled if it allocated again from pcp_list without going to global
> free list, which should be introduced by 44042b4498.
>
> fix:44042b4498
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e008a3d..e77f3a7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1437,7 +1437,7 @@ static bool bulkfree_pcp_prepare(struct page *page)
>   */
>  static bool free_pcp_prepare(struct page *page, unsigned int order)
>  {
> -       if (debug_pagealloc_enabled_static())
> +       if (debug_pagealloc_enabled_static() || order)
>                 return free_pages_prepare(page, order, true, FPI_NONE);
>         else
>                 return free_pages_prepare(page, order, false, FPI_NONE);
> --
> 1.9.1
>
