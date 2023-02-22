Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6BF69FEC2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjBVWxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBVWxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:53:52 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8557323326
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:53:51 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z20-20020a17090a8b9400b002372d7f823eso6633369pjn.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qBffIwTztrqMjd4SIOIwzjYt81ApPf0fN0mbs28jX0w=;
        b=lTEvWjjrAo2cie3FcwaWfr/xo0w2p4esTYomQUcFUA7VRBODHb4nv5M7BpaJAts/UK
         MXGew0uVlAwNQUdWGBgxPkHqO7gvQExZQV0gkccHh3HFVgA8NsBjn9HwzFRJiRbd/1kr
         kGdUnU8ED2Il7d+ozO6mgkFyEnlPlAyJVrLfXy7Dhkg3u6p5Tw5DSTsNpKzGQw8Wz0fF
         vfCT0wCabZR4fOW/PrHPHxxsa6aG7RYotxk6LL7TU0EE2xrTL0JylLKHpFMDQGnCJ1sT
         sD7tBfD3zoSagHNcaXcecNNPNJqc0CFYqOWDcU/lSZn4sbMbZCyjqhhXUZJoIoh4DJCw
         0vFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBffIwTztrqMjd4SIOIwzjYt81ApPf0fN0mbs28jX0w=;
        b=IGGbAw8dzizqvvD9V35+FUlkeYe32202KhM3gW5T+ntq16fqkwXC1dXC90EG+qeRCq
         PKOUG8NHHVYW/rLaaYPvccO3s/t6BmXaGMvGBuV36+SqTO0pnd0DPAGOtYv2RXVt/uyu
         6tM9lbWcG0GpDNhXe8/NzVT8Nh1ySMg8qjxTSa9SmxPoyr3LQlWty/PYA1WIC8kE8dyT
         T6QEvDuh1IM7J1EVREQlCGhTH8CtcwdHpggrQyc1CyEzYhvrAXzaK5CmNTA8VMy8vymm
         Gbfb+KN9/DTgr8Qy1kUrXFSHRSM8fo/GAzl+Wwsid7JWMcj5CpZSQpY2SUBLCbOi2Mzi
         gnnA==
X-Gm-Message-State: AO0yUKX4ebn3YvULGT7eRvMkiv8+3U6sMdmtOdyS5RIPLwfVmlsor0vU
        sF9lb+IE3MKeIFf4bPIQCLRQMHVyMvYE/wgQMr0=
X-Google-Smtp-Source: AK7set+TgmUpyzwff8XB0hFcAB2olWd+Wrp0IvgJpKiiNRUlhtNd/fCTqTg14BGwS54Q8rKlmYTMqDMCZGCaG2O/QPA=
X-Received: by 2002:a17:902:f80c:b0:19a:a411:92ba with SMTP id
 ix12-20020a170902f80c00b0019aa41192bamr1387502plb.8.1677106431012; Wed, 22
 Feb 2023 14:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20230222195247.791227-1-peterx@redhat.com>
In-Reply-To: <20230222195247.791227-1-peterx@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 22 Feb 2023 14:53:39 -0800
Message-ID: <CAHbLzkp3PwpXir=YUuWmxpW5VXEba81UKb3YOyq+snKTZGjqDA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/khugepaged: alloc_charge_hpage() take care of mem
 charge errors
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Stevens <stevensd@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 11:52 AM Peter Xu <peterx@redhat.com> wrote:
>
> If memory charge failed, instead of returning the hpage but with an error,
> allow the function to cleanup the folio properly, which is normally what a
> function should do in this case - either return successfully, or return
> with no side effect of partial runs with an indicated error.
>
> This will also avoid the caller calling mem_cgroup_uncharge() unnecessarily
> with either anon or shmem path (even if it's safe to do so).

Thanks for the cleanup. Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Cc: Yang Shi <shy828301@gmail.com>
> Reviewed-by: David Stevens <stevensd@chromium.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v1->v2:
> - Enhance commit message, drop "Fixes:" and "Cc: stable" tag, add R-bs.
> ---
>  mm/khugepaged.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 8dbc39896811..941d1c7ea910 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1063,12 +1063,19 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
>         gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
>                      GFP_TRANSHUGE);
>         int node = hpage_collapse_find_target_node(cc);
> +       struct folio *folio;
>
>         if (!hpage_collapse_alloc_page(hpage, gfp, node, &cc->alloc_nmask))
>                 return SCAN_ALLOC_HUGE_PAGE_FAIL;
> -       if (unlikely(mem_cgroup_charge(page_folio(*hpage), mm, gfp)))
> +
> +       folio = page_folio(*hpage);
> +       if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
> +               folio_put(folio);
> +               *hpage = NULL;
>                 return SCAN_CGROUP_CHARGE_FAIL;
> +       }
>         count_memcg_page_event(*hpage, THP_COLLAPSE_ALLOC);
> +
>         return SCAN_SUCCEED;
>  }
>
> --
> 2.39.1
>
