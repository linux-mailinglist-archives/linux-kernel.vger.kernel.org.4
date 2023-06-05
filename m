Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774A2722EE2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 20:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbjFESqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 14:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFESqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 14:46:21 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A3DEC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 11:46:16 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2568befcf1dso3868369a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685990776; x=1688582776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaVk6E4U+kAgIxFMy9FI+O5YJ5qeJtYzqpjAD97QKBE=;
        b=LJL3O4+kc/OrgJvlHxYVr5y7cjdPWiDloM3k8mPaQ9dNPTstAbOWQR9avkysmrauhd
         CKdGMLy4Rwkv2Y72N5RjK7Qb2PTVlAtOLcZONZQCW2dTgCjcBDQ0kL1SgFouKnrLstU+
         uq0s7zr1HbySTUxJOFBDM1rlNlc3A/a/7d9SDiFyQxkgZjEc7BrlbF3rEUm9jJlf5UAp
         sMNFbqcR7cRpuwz6i+rUVcz6YMLSg7ZxrlpsHF11ywuQZBr7W6rG21Kwd0oqNJL+aeXl
         QXnokSwPbt8kZo2ijFlEgh7ApJgutt7m40sAxbW4ACIVrwQWlDSTwhfEWQqYBQXxFRro
         QxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685990776; x=1688582776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaVk6E4U+kAgIxFMy9FI+O5YJ5qeJtYzqpjAD97QKBE=;
        b=diDMo53Dd9XcxMnvSM1G2UeYmIDg+HjAFEj1Snda6RBEet1GybqF7i3udkN85SMd6L
         OXZRP+Dps+2F2M+DuATneIOtaLIE85/GMKyQcxWJbmxH/8AMqw4QYmgq2xhNE1Ok863h
         yLstMBn4t4Rz+K0jn/fI86LLz2ar/MtPZaz/qEUmHhiENShfTV2AFbv9oJ4G60GcPXdr
         sh32xFwSkmmmPoVtXDnolkG+bnqXlJ7Os7oBLjrZegp01cANDDIWRfVF37vL7Q6n9Lu8
         VcNH3tzgAuZVgNyNKVPy+9DuTfZRTbqVskW7obSgdAUgdkFIvUrrS5KGgAixdC2mtr8M
         aM5Q==
X-Gm-Message-State: AC+VfDyYUuzgZEe/kLvJKwbL64Rucam84dAvNVJ8Q2j6Auhy+o6ZpaVJ
        u831/wUhCO6uV04OFyeQUc5Oo5EFeosrJSMnSdU=
X-Google-Smtp-Source: ACHHUZ5Ruv+bIACcQOaymAFusISJmR4Ih5yWY0uyOttuPeu2em6CMcdYgMk/6PCPwIHM4rGlPW/G15gsjZ9cHkscikE=
X-Received: by 2002:a17:90a:4006:b0:23f:9445:318e with SMTP id
 u6-20020a17090a400600b0023f9445318emr9263568pjc.3.1685990775937; Mon, 05 Jun
 2023 11:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230602230552.350731-1-peterx@redhat.com> <20230602230552.350731-5-peterx@redhat.com>
In-Reply-To: <20230602230552.350731-5-peterx@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 5 Jun 2023 11:46:04 -0700
Message-ID: <CAHbLzkp_tzN8SZVeWTKxtMAnFSzUvk2064KFg3quj=raOSHPrA@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: Make most walk page paths with
 pmd_trans_unstable() to retry
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 4:06=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> For most of the page walk paths, logically it'll always be good to have t=
he
> pmd retries if hit pmd_trans_unstable() race.  We can treat it as none
> pmd (per comment above pmd_trans_unstable()), but in most cases we're not
> even treating that as a none pmd.  If to fix it anyway, a retry will be t=
he
> most accurate.
>
> I've went over all the pmd_trans_unstable() special cases and this patch
> should cover all the rest places where we should retry properly with
> unstable pmd.  With the newly introduced ACTION_AGAIN since 2020 we can
> easily achieve that.
>
> These are the call sites that I think should be fixed with it:
>
> *** fs/proc/task_mmu.c:
> smaps_pte_range[634]           if (pmd_trans_unstable(pmd))
> clear_refs_pte_range[1194]     if (pmd_trans_unstable(pmd))
> pagemap_pmd_range[1542]        if (pmd_trans_unstable(pmdp))
> gather_pte_stats[1891]         if (pmd_trans_unstable(pmd))
> *** mm/memcontrol.c:
> mem_cgroup_count_precharge_pte_range[6024] if (pmd_trans_unstable(pmd))
> mem_cgroup_move_charge_pte_range[6244] if (pmd_trans_unstable(pmd))
> *** mm/memory-failure.c:
> hwpoison_pte_range[794]        if (pmd_trans_unstable(pmdp))
> *** mm/mempolicy.c:
> queue_folios_pte_range[517]    if (pmd_trans_unstable(pmd))
> *** mm/madvise.c:
> madvise_cold_or_pageout_pte_range[425] if (pmd_trans_unstable(pmd))
> madvise_free_pte_range[625]    if (pmd_trans_unstable(pmd))
>
> IIUC most of them may or may not be a big issue even without a retry,
> either because they're already not strict (smaps, pte_stats, MADV_COLD,
> .. it can mean e.g. the statistic may be inaccurate or one less 2M chunk =
to
> cold worst case), but some of them could have functional error without th=
e
> retry afaiu (e.g. pagemap, where we can have the output buffer shifted ov=
er
> the unstable pmd range.. so IIUC the pagemap result can be wrong).
>
> While these call sites all look fine, and don't need any change:
>
> *** include/linux/pgtable.h:
> pmd_devmap_trans_unstable[1418] return pmd_devmap(*pmd) || pmd_trans_unst=
able(pmd);
> *** mm/gup.c:
> follow_pmd_mask[695]           if (pmd_trans_unstable(pmd))
> *** mm/mapping_dirty_helpers.c:
> wp_clean_pmd_entry[131]        if (!pmd_trans_unstable(&pmdval))
> *** mm/memory.c:
> do_anonymous_page[4060]        if (unlikely(pmd_trans_unstable(vmf->pmd))=
)
> *** mm/migrate_device.c:
> migrate_vma_insert_page[616]   if (unlikely(pmd_trans_unstable(pmdp)))
> *** mm/mincore.c:
> mincore_pte_range[116]         if (pmd_trans_unstable(pmd)) {
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/proc/task_mmu.c  | 17 +++++++++++++----
>  mm/madvise.c        |  8 ++++++--
>  mm/memcontrol.c     |  8 ++++++--
>  mm/memory-failure.c |  4 +++-
>  mm/mempolicy.c      |  4 +++-
>  5 files changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 6259dd432eeb..823eaba5c6bf 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -631,8 +631,11 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long=
 addr, unsigned long end,
>                 goto out;
>         }
>
> -       if (pmd_trans_unstable(pmd))
> +       if (pmd_trans_unstable(pmd)) {
> +               walk->action =3D ACTION_AGAIN;
>                 goto out;
> +       }
> +
>         /*
>          * The mmap_lock held all the way back in m_start() is what
>          * keeps khugepaged out of here and from collapsing things
> @@ -1191,8 +1194,10 @@ static int clear_refs_pte_range(pmd_t *pmd, unsign=
ed long addr,
>                 return 0;
>         }
>
> -       if (pmd_trans_unstable(pmd))
> +       if (pmd_trans_unstable(pmd)) {
> +               walk->action =3D ACTION_AGAIN;
>                 return 0;
> +       }
>
>         pte =3D pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
>         for (; addr !=3D end; pte++, addr +=3D PAGE_SIZE) {
> @@ -1539,8 +1544,10 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned=
 long addr, unsigned long end,
>                 return err;
>         }
>
> -       if (pmd_trans_unstable(pmdp))
> +       if (pmd_trans_unstable(pmdp)) {
> +               walk->action =3D ACTION_AGAIN;
>                 return 0;

Had a quick look at the pagemap code, I agree with your analysis,
"returning 0" may mess up pagemap, retry should be fine. But I'm
wondering whether we should just fill in empty entries. Anyway I don't
have a  strong opinion on this, just a little bit concerned by
potential indefinite retry.

> +       }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>         /*
> @@ -1888,8 +1895,10 @@ static int gather_pte_stats(pmd_t *pmd, unsigned l=
ong addr,
>                 return 0;
>         }
>
> -       if (pmd_trans_unstable(pmd))
> +       if (pmd_trans_unstable(pmd)) {
> +               walk->action =3D ACTION_AGAIN;
>                 return 0;
> +       }
>  #endif
>         orig_pte =3D pte =3D pte_offset_map_lock(walk->mm, pmd, addr, &pt=
l);
>         do {
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 78cd12581628..0fd81712022c 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -424,8 +424,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *=
pmd,
>         }
>
>  regular_folio:
> -       if (pmd_trans_unstable(pmd))
> +       if (pmd_trans_unstable(pmd)) {
> +               walk->action =3D ACTION_AGAIN;
>                 return 0;
> +       }
>  #endif
>         tlb_change_page_size(tlb, PAGE_SIZE);
>         orig_pte =3D pte =3D pte_offset_map_lock(vma->vm_mm, pmd, addr, &=
ptl);
> @@ -626,8 +628,10 @@ static int madvise_free_pte_range(pmd_t *pmd, unsign=
ed long addr,
>                 if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
>                         goto next;
>
> -       if (pmd_trans_unstable(pmd))
> +       if (pmd_trans_unstable(pmd)) {
> +               walk->action =3D ACTION_AGAIN;
>                 return 0;
> +       }
>
>         tlb_change_page_size(tlb, PAGE_SIZE);
>         orig_pte =3D pte =3D pte_offset_map_lock(mm, pmd, addr, &ptl);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6ee433be4c3b..15e50f033e41 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6021,8 +6021,10 @@ static int mem_cgroup_count_precharge_pte_range(pm=
d_t *pmd,
>                 return 0;
>         }
>
> -       if (pmd_trans_unstable(pmd))
> +       if (pmd_trans_unstable(pmd)) {
> +               walk->action =3D ACTION_AGAIN;
>                 return 0;

Either retry or keep as is is fine to me. I'm not aware of anyone
complaining about noticeable inaccurate charges due to this. But we
may have potential indefinite retry anyway, so if you don't want to
risk this, it may be better just keep it as is.

> +       }
>         pte =3D pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
>         for (; addr !=3D end; pte++, addr +=3D PAGE_SIZE)
>                 if (get_mctgt_type(vma, addr, *pte, NULL))
> @@ -6241,8 +6243,10 @@ static int mem_cgroup_move_charge_pte_range(pmd_t =
*pmd,
>                 return 0;
>         }
>
> -       if (pmd_trans_unstable(pmd))
> +       if (pmd_trans_unstable(pmd)) {
> +               walk->action =3D ACTION_AGAIN;
>                 return 0;
> +       }
>  retry:
>         pte =3D pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
>         for (; addr !=3D end; addr +=3D PAGE_SIZE) {
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 004a02f44271..c97fb2b7ab4a 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -791,8 +791,10 @@ static int hwpoison_pte_range(pmd_t *pmdp, unsigned =
long addr,
>                 goto out;
>         }
>
> -       if (pmd_trans_unstable(pmdp))
> +       if (pmd_trans_unstable(pmdp)) {
> +               walk->action =3D ACTION_AGAIN;
>                 goto out;
> +       }

This may be worth retrying IMHO.

>
>         mapped_pte =3D ptep =3D pte_offset_map_lock(walk->vma->vm_mm, pmd=
p,
>                                                 addr, &ptl);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index f06ca8c18e62..af8907b4aad1 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -514,8 +514,10 @@ static int queue_folios_pte_range(pmd_t *pmd, unsign=
ed long addr,
>         if (ptl)
>                 return queue_folios_pmd(pmd, ptl, addr, end, walk);
>
> -       if (pmd_trans_unstable(pmd))
> +       if (pmd_trans_unstable(pmd)) {
> +               walk->action =3D ACTION_AGAIN;
>                 return 0;
> +       }

Either retry or keep it as is is fine.

>
>         mapped_pte =3D pte =3D pte_offset_map_lock(walk->mm, pmd, addr, &=
ptl);
>         for (; addr !=3D end; pte++, addr +=3D PAGE_SIZE) {
> --
> 2.40.1
>
>
