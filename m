Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAC465E0E4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjADXYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 18:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbjADXXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 18:23:40 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8900448CDB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 15:22:48 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bn26so15113680wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 15:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rZzfdo0ziPPx2TPaj2KeqRicG6hTBB0FcIoqRc87RUk=;
        b=psyzDoWE8dn3mhEjSUdM6XuCzJlSIkK2IU6izNdCGTNSekIeECgoA1MEej3kHk5Hrg
         8Lc+rkqfq+9jAG5HM6J1de1Kx2nle37+OKcMMvR1LilN9viKDF3MmJlXbUt+3X9O5kau
         Oo4Tdz14ipK9o3Le6+3Bg9Z1niTm5o04QT5OAg623BBqkIEnKHzLbkDDNQLmBje3/Dkb
         UTOHUJAwt6i8WBYMgIIdCyjPp+axosEtGTN/Wo16L5o0qd78TpLc+3QSmxPe8FnMysBW
         0Gix5pgaQJuBiXYZTAyA1aV650sGnrFCykpvLzaqCFtWwC22M4dzwAb1nS40VFfaGjVC
         9aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZzfdo0ziPPx2TPaj2KeqRicG6hTBB0FcIoqRc87RUk=;
        b=BjBWyc95PjTqlJ7il69WhT4UyA0buLctXYYScBFPpZAt+PWOr4BIQytaAemOCrVhHp
         TaAKYRxBM9DzY1hzU9aoPcqjO31hnlmBGoCuL1yU0RxacK5yPf31NgazyrkWXb8Wavnj
         IpWk19jDOxy/BRtmk16AJNPWA2Ong/ry3x2dXHCtl/QdqIZrI8DjjRT4kPnyZAlV9B0T
         NFqXX+FlGQ5OJqOUvGPX8yn9QKD6BPajctbnayk1a1JqCuxZoGr/9Cn/yiOcRue88S6K
         d/OrOewl5LGqT5mijyW+18MKa073AHWAR1AesCsotvyJbYpuwE93BMn7oFyqjPHAnvgm
         BDzQ==
X-Gm-Message-State: AFqh2kpzdtrfS0K62eUDtK74PD6oKHH5FWfYIugsggPdGhhGycT5lpSJ
        J7N2mqUZV+ilXJjAUHGXPj3HlWgTigEKBzu2DMQSppn5AVs=
X-Google-Smtp-Source: AMrXdXunSszWmBf44gTHaI+aiu3RKary3dRCzwUnnDN8xzpFRk/ihE4hFTVdFobDPpUjKu2HrZdc19y/uuEFYaq0EkM=
X-Received: by 2002:a5d:5221:0:b0:2b0:6953:fac6 with SMTP id
 i1-20020a5d5221000000b002b06953fac6mr40522wra.131.1672874566982; Wed, 04 Jan
 2023 15:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20230104222944.2380117-1-nphamcs@gmail.com>
In-Reply-To: <20230104222944.2380117-1-nphamcs@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 4 Jan 2023 15:22:35 -0800
Message-ID: <CAKEwX=Or-OJ=uiYUh88zGJ1bSAYjueTz-UqUEc_cRwCUni_OxQ@mail.gmail.com>
Subject: Re: [PATCH] workingset: fix confusion around eviction vs refault container
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
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

On Wed, Jan 4, 2023 at 2:29 PM Nhat Pham <nphamcs@gmail.com> wrote:
>
> From: Johannes Weiner <hannes@cmpxchg.org>
>
> Refault decisions are made based on the lruvec where the page was
> evicted, as that determined its LRU order while it was alive. Stats
> and workingset aging must then occur on the lruvec of the new page, as
> that's the node and cgroup that experience the refault and that's the
> lruvec whose nonresident info ages out by a new resident page. Those
> lruvecs could be different when a page is shared between cgroups, or
> the refaulting page is allocated on a different node.
>
> There are currently two mix-ups:
>
> 1. When swap is available, the resident anon set must be considered
>    when comparing the refault distance. The comparison is made against
>    the right anon set, but the check for swap is not. When pages get
>    evicted from a cgroup with swap, and refault in one without, this
>    can incorrectly consider a hot refault as cold - and vice
>    versa. Fix that by using the eviction cgroup for the swap check.
>
> 2. The stats and workingset age are updated against the wrong lruvec
>    altogether: the right cgroup but the wrong NUMA node. When a page
>    refaults on a different NUMA node, this will have confusing stats
>    and distort the workingset age on a different lruvec - again
>    possibly resulting in hot/cold misclassifications down the line.
>
> Fix the swap check and the refault pgdat to address both concerns.
>
> This was found during code review. It hasn't caused notable issues in
> production, suggesting that those refault-migrations are relatively
> rare in practice.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Co-developed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/workingset.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/workingset.c b/mm/workingset.c
> index ae7e984b23c6..79585d55c45d 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -457,6 +457,7 @@ void workingset_refault(struct folio *folio, void *shadow)
>          */
>         nr = folio_nr_pages(folio);
>         memcg = folio_memcg(folio);
> +       pgdat = folio_pgdat(folio);
>         lruvec = mem_cgroup_lruvec(memcg, pgdat);
>
>         mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
> @@ -474,7 +475,7 @@ void workingset_refault(struct folio *folio, void *shadow)
>                 workingset_size += lruvec_page_state(eviction_lruvec,
>                                                      NR_INACTIVE_FILE);
>         }
> -       if (mem_cgroup_get_nr_swap_pages(memcg) > 0) {
> +       if (mem_cgroup_get_nr_swap_pages(eviction_memcg) > 0) {
>                 workingset_size += lruvec_page_state(eviction_lruvec,
>                                                      NR_ACTIVE_ANON);
>                 if (file) {
> --
> 2.30.2

Oh this one is sent out twice too... Something is wrong with my pipeline...
Anyway, please disregard the first email and only review this one!
