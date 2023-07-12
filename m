Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A36574FF25
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjGLGYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjGLGYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:24:01 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7855810C2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:24:00 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-403b622101bso128621cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689143039; x=1691735039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogDTocmjdnSJBzO5jS03IkwUPvdzM4qsYFLSfwaNw2c=;
        b=0wW4+rFZWUn48j1wSeqL+TD0e+Wah6NZ17W0Rk7rtflQOvgc3dzjRQVQo2btFCGgUY
         +otwdvO8r3nLl7el2+HDA9ZxNvA8mmbOHqhXOW5K2wF5Jm9KLnD32O2Q126QVlJd+DC0
         iMbz/MKdWmIbYaqKOFKzhMQKDmnXWpI9nBF9r2Cl2Gj7qVs0cz+6q1t6vlVGXgfwyqlu
         Fz/cJnRJL1STnPDPAHY9WHqIuwSobzOgcOJwMJnWV21ERN7tXyj3SAoixjay2/MBnkzV
         /CSyaCnF+GqRpVKpZHuA3vAiViYsAs5Bk4z22Bo+iqwBQUcPBtxyCpreYS9huaTbvVU4
         36Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689143039; x=1691735039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogDTocmjdnSJBzO5jS03IkwUPvdzM4qsYFLSfwaNw2c=;
        b=Q3MyakjF07W/SrSFi4tWe0t7QW8kZGHgMpboMyrGATD4QW9zxZQlZ2W2Hl4annZGjG
         ZeyVI7asFw9yZVBZ+TgAggD2qxVFWwQhPrludYc+dgf3G8OWqV13Fl/iwfPg0VBzAZ00
         kTYIUYleACA7hUUmt+WJ1Neado90j0ENgKxdSL7c84a5Ylc+fqXKAZuKWP+TjdyJ2dRy
         QHCbuf78lj193T2iqM8KeSkLfKNKIGv9SQiTmpy4NE5huu0o1BPCESql4OOXPL3Zf/sB
         E9z/vGwhyiD3iPxqjm3Zueh4S8DB8DfA5/rA49wukm6jJhJULNjYwaRUguKZ+kYiIPrf
         WEbQ==
X-Gm-Message-State: ABy/qLasvnr/4gBTZuiQ/c5KeN16e7/7Rz3lveG82QOCrw0J783imVZh
        c99wVvtjulfstqcPO2ZR/oYjIWjCZA/ec3Thf0vrdw==
X-Google-Smtp-Source: APBJJlF/wzGEFxsGQuAId1W1Jr0FjvUxt9dmS2lBIZNPtptznWl/zhbQ+mPEOajxg+2S6tHbWJ3gCv8HOBxgULojg3o=
X-Received: by 2002:ac8:58c3:0:b0:3f9:b81c:3a0f with SMTP id
 u3-20020ac858c3000000b003f9b81c3a0fmr98013qta.17.1689143039538; Tue, 11 Jul
 2023 23:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230712060144.3006358-1-fengwei.yin@intel.com> <20230712060144.3006358-3-fengwei.yin@intel.com>
In-Reply-To: <20230712060144.3006358-3-fengwei.yin@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 12 Jul 2023 00:23:23 -0600
Message-ID: <CAOUHufZQ0EpyRZ_jAMxs8uNSQOz6uAkzVjvvgD+4wBvmgHJoCA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] mm: handle large folio when large folio in
 VM_LOCKED VMA range
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 12:02=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com=
> wrote:
>
> If large folio is in the range of VM_LOCKED VMA, it should be
> mlocked to avoid being picked by page reclaim. Which may split
> the large folio and then mlock each pages again.
>
> Mlock this kind of large folio to prevent them being picked by
> page reclaim.
>
> For the large folio which cross the boundary of VM_LOCKED VMA,
> we'd better not to mlock it. So if the system is under memory
> pressure, this kind of large folio will be split and the pages
> ouf of VM_LOCKED VMA can be reclaimed.
>
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
>  mm/internal.h | 11 ++++++++---
>  mm/rmap.c     | 34 +++++++++++++++++++++++++++-------
>  2 files changed, 35 insertions(+), 10 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index c7dd15d8de3ef..776141de2797a 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -643,7 +643,8 @@ static inline void mlock_vma_folio(struct folio *foli=
o,
>          *    still be set while VM_SPECIAL bits are added: so ignore it =
then.
>          */
>         if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) =3D=3D VM_L=
OCKED) &&
> -           (compound || !folio_test_large(folio)))
> +           (compound || !folio_test_large(folio) ||
> +           folio_in_range(folio, vma, vma->vm_start, vma->vm_end)))
>                 mlock_folio(folio);
>  }

This can be simplified:
1. remove the compound parameter
2. make the if
        if (unlikely((vma->vm_flags & (VM_LOCKED|VM_SPECIAL)) =3D=3D VM_LOC=
KED) &&
            folio_within_vma())
                mlock_folio(folio);

> @@ -651,8 +652,12 @@ void munlock_folio(struct folio *folio);
>  static inline void munlock_vma_folio(struct folio *folio,
>                         struct vm_area_struct *vma, bool compound)

Remove the compound parameter here too.

>  {
> -       if (unlikely(vma->vm_flags & VM_LOCKED) &&
> -           (compound || !folio_test_large(folio)))
> +       /*
> +        * To handle the case that a mlocked large folio is unmapped from=
 VMA
> +        * piece by piece, allow munlock the large folio which is partial=
ly
> +        * mapped to VMA.
> +        */
> +       if (unlikely(vma->vm_flags & VM_LOCKED))
>                 munlock_folio(folio);
>  }
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2668f5ea35342..455f415d8d9ca 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -803,6 +803,14 @@ struct folio_referenced_arg {
>         unsigned long vm_flags;
>         struct mem_cgroup *memcg;
>  };
> +
> +static inline bool should_restore_mlock(struct folio *folio,
> +               struct vm_area_struct *vma, bool pmd_mapped)
> +{
> +       return !folio_test_large(folio) ||
> +                       pmd_mapped || folio_within_vma(folio, vma);
> +}

This is just folio_within_vma() :)

>  /*
>   * arg: folio_referenced_arg will be passed
>   */
> @@ -816,13 +824,25 @@ static bool folio_referenced_one(struct folio *foli=
o,
>         while (page_vma_mapped_walk(&pvmw)) {
>                 address =3D pvmw.address;
>
> -               if ((vma->vm_flags & VM_LOCKED) &&
> -                   (!folio_test_large(folio) || !pvmw.pte)) {
> -                       /* Restore the mlock which got missed */
> -                       mlock_vma_folio(folio, vma, !pvmw.pte);
> -                       page_vma_mapped_walk_done(&pvmw);
> -                       pra->vm_flags |=3D VM_LOCKED;
> -                       return false; /* To break the loop */
> +               if (vma->vm_flags & VM_LOCKED) {
> +                       if (should_restore_mlock(folio, vma, !pvmw.pte)) =
{
> +                               /* Restore the mlock which got missed */
> +                               mlock_vma_folio(folio, vma, !pvmw.pte);
> +                               page_vma_mapped_walk_done(&pvmw);
> +                               pra->vm_flags |=3D VM_LOCKED;
> +                               return false; /* To break the loop */
> +                       } else {

There is no need for "else", or just

  if (!folio_within_vma())
    goto dec_pra_mapcount;

> +                               /*
> +                                * For large folio cross VMA boundaries, =
it's
> +                                * expected to be picked  by page reclaim=
. But
> +                                * should skip reference of pages which a=
re in
> +                                * the range of VM_LOCKED vma. As page re=
claim
> +                                * should just count the reference of pag=
es out
> +                                * the range of VM_LOCKED vma.
> +                                */
> +                               pra->mapcount--;
> +                               continue;
> +                       }
>                 }
