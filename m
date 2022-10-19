Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E42604F74
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiJSSRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiJSSRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:17:39 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5841958C0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:17:38 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1324e7a1284so21660569fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NLZVIpo1wUPmESy8vObHizHTLhwmUsqE/4jZENFW4bQ=;
        b=AQHfDgFz7dbho2dY9nLLCmG98TBmMfCrgy5O/RMfQUbWewFOSAxejfTska5RXWxuit
         TmgYI1JWpJLatYjA/YDLfCEmLUEcDggeoOD8kodJ/UX5gSg/846p8E02SXNS0Yipfs8M
         5rIHKtPgbJEuyS8ix0b2i1BarhemRO3v2BwYKGsc8OuPxgJ645SuiQ8/e6g8PDtvEoRh
         5CalzBp3jKb4ttXJCCbuclc+yN02tDmBlCQhP2V7ujj2RfNiTVduzIgbcRZ18Gecq1Q1
         OIZf6B2N3GrX9q+v2DCLt8ZyIRj6POLnls/8fPF5Pj139q1NTOi+EcgRCtbK/BLBu4+6
         0AAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLZVIpo1wUPmESy8vObHizHTLhwmUsqE/4jZENFW4bQ=;
        b=2UsA1cfw0JnsTcnlXtYJyYYWwQYl885w8qHkIZs5bM3FPJ8KA27AAvd0NJQV4ie6Xr
         zO1/J7Fa4AFEeQx3V3I7D9BVgRzD2lb3/1RlitxNDhCm3wbt62AoLPFThUaa6AJssFPG
         m3MPPfst3BD/HGIq6qD9qiM9W0J419lL9PQoM1PWcjoZ0KM8lig2vF3jGE8TexUaUtXO
         P7SMBSr8AYgVLQ9gmnus2dKjdgY0wFkLLlkkX88b4Ddzq2Zmy1BlhPGp4F1g/AYDpq1P
         aqkL7rSGiE1yazmZa65qGEGQ06E/bkFBfXHicAAa7icCXwR9VaiVbg8Tq/3L8Wt763/9
         UlRQ==
X-Gm-Message-State: ACrzQf1Denj09lo+UAh9f/7VG14zrx/Y1sDnLTvR67fa44qjiieJxH+n
        gs6uNs0HCgu2h2O3ptQFfN6NhZveXoSushdVd4ZNEJWBh1I=
X-Google-Smtp-Source: AMsMyM5Cg9WtBnis9FzBJVOaxLw7dEvGnTZzqxdWU5QZ4/E5VynxKfgCNEG9QZxCdS/d0vvz0YShIFgj1TQXYKshhdo=
X-Received: by 2002:a17:90b:4a09:b0:20d:5b67:1496 with SMTP id
 kk9-20020a17090b4a0900b0020d5b671496mr45873787pjb.67.1666203447271; Wed, 19
 Oct 2022 11:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221019134156.zjyyn5aownakvztf@techsingularity.net>
In-Reply-To: <20221019134156.zjyyn5aownakvztf@techsingularity.net>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 19 Oct 2022 11:17:14 -0700
Message-ID: <CAHbLzkras5SV95-J4r=nbGx5u_5JS2u8KG=23hzVvFBqCnMA5g@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/huge_memory: Do not clobber swp_entry_t during THP split
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Oct 19, 2022 at 6:42 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> The following has been observed when running stressng mmap since commit
> b653db77350c ("mm: Clear page->private when splitting or migrating a page")
>
>    watchdog: BUG: soft lockup - CPU#75 stuck for 26s! [stress-ng:9546]
>    CPU: 75 PID: 9546 Comm: stress-ng Tainted: G            E      6.0.0-revert-b653db77-fix+ #29 0357d79b60fb09775f678e4f3f64ef0579ad1374
>    Hardware name: SGI.COM C2112-4GP3/X10DRT-P-Series, BIOS 2.0a 05/09/2016
>    RIP: 0010:xas_descend+0x28/0x80
>    Code: cc cc 0f b6 0e 48 8b 57 08 48 d3 ea 83 e2 3f 89 d0 48 83 c0 04 48 8b 44 c6 08 48 89 77 18 48 89 c1 83 e1 03 48 83 f9 02 75 08 <48> 3d fd 00 00 00 76 08 88 57 12 c3 cc cc cc cc 48 c1 e8 02 89 c2
>    RSP: 0018:ffffbbf02a2236a8 EFLAGS: 00000246
>    RAX: ffff9cab7d6a0002 RBX: ffffe04b0af88040 RCX: 0000000000000002
>    RDX: 0000000000000030 RSI: ffff9cab60509b60 RDI: ffffbbf02a2236c0
>    RBP: 0000000000000000 R08: ffff9cab60509b60 R09: ffffbbf02a2236c0
>    R10: 0000000000000001 R11: ffffbbf02a223698 R12: 0000000000000000
>    R13: ffff9cab4e28da80 R14: 0000000000039c01 R15: ffff9cab4e28da88
>    FS:  00007fab89b85e40(0000) GS:ffff9cea3fcc0000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 00007fab84e00000 CR3: 00000040b73a4003 CR4: 00000000003706e0
>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    Call Trace:
>     <TASK>
>     xas_load+0x3a/0x50
>     __filemap_get_folio+0x80/0x370
>     ? put_swap_page+0x163/0x360
>     pagecache_get_page+0x13/0x90
>     __try_to_reclaim_swap+0x50/0x190
>     scan_swap_map_slots+0x31e/0x670
>     get_swap_pages+0x226/0x3c0
>     folio_alloc_swap+0x1cc/0x240
>     add_to_swap+0x14/0x70
>     shrink_page_list+0x968/0xbc0
>     reclaim_page_list+0x70/0xf0
>     reclaim_pages+0xdd/0x120
>     madvise_cold_or_pageout_pte_range+0x814/0xf30
>     walk_pgd_range+0x637/0xa30
>     __walk_page_range+0x142/0x170
>     walk_page_range+0x146/0x170
>     madvise_pageout+0xb7/0x280
>     ? asm_common_interrupt+0x22/0x40
>     madvise_vma_behavior+0x3b7/0xac0
>     ? find_vma+0x4a/0x70
>     ? find_vma+0x64/0x70
>     ? madvise_vma_anon_name+0x40/0x40
>     madvise_walk_vmas+0xa6/0x130
>     do_madvise+0x2f4/0x360
>     __x64_sys_madvise+0x26/0x30
>     do_syscall_64+0x5b/0x80
>     ? do_syscall_64+0x67/0x80
>     ? syscall_exit_to_user_mode+0x17/0x40
>     ? do_syscall_64+0x67/0x80
>     ? syscall_exit_to_user_mode+0x17/0x40
>     ? do_syscall_64+0x67/0x80
>     ? do_syscall_64+0x67/0x80
>     ? common_interrupt+0x8b/0xa0
>     entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> The problem can be reproduced with the mmtests config
> config-workload-stressng-mmap. It does not always happen and when it
> triggers is variable but it has happened on multiple machines.
>
> The intent of commit b653db77350c patch was to avoid the case where
> PG_private is clear but folio->private is not-NULL. However, THP tail
> pages uses page->private for "swp_entry_t if folio_test_swapcache()" as
> stated in the documentation for struct folio. This patch only clobbers
> page->private for tail pages if the head page was not in swapcache and
> warns once if page->private had an unexpected value.

It looks like the same issue fixed by
https://lore.kernel.org/linux-mm/20220906190602.1626037-1-bfoster@redhat.com/

>
> Fixes: b653db77350c ("mm: Clear page->private when splitting or migrating a page")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/huge_memory.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1cc4a5f4791e..03fc7e5edf07 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2455,7 +2455,16 @@ static void __split_huge_page_tail(struct page *head, int tail,
>                         page_tail);
>         page_tail->mapping = head->mapping;
>         page_tail->index = head->index + tail;
> -       page_tail->private = 0;
> +
> +       /*
> +        * page->private should not be set in tail pages with the exception
> +        * of swap cache pages that store the swp_entry_t in tail pages.
> +        * Fix up and warn once if private is unexpectedly set.
> +        */
> +       if (!folio_test_swapcache(page_folio(head))) {
> +               VM_WARN_ON_ONCE_PAGE(page_tail->private != 0, head);
> +               page_tail->private = 0;
> +       }
>
>         /* Page flags must be visible before we make the page non-compound. */
>         smp_wmb();
>
