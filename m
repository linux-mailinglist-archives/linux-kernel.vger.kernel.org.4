Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AE574FF72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjGLGem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjGLGeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:34:13 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DE72D40
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:32:31 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4036bd4fff1so134501cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689143550; x=1691735550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZpxFys7nJdvmBPjIJ49j1uiao8v048XzoTDU+vGGrY=;
        b=uyGuYrzeVa5Bc8Dj1mPDQiSMBckJ1dcgG3j7LVGxZ1wlmcdmZsHIo6jNJnlYit7fJ1
         xH2BVbT3dBlHskg1w8DmNVmZuIpItmo6RTWYbvXMg3vGtbEGJ+e4yYK0Iq7BFv5dnVA7
         uGG3nK4TiJRvLJYoz6sV8EYvCNUpyCpm16/SjGJRR4qXZ055HeFwRZBs15YdtKKEpCxF
         UcVH3luQlSPFkvH9WeRTBoLWMoFL+gquZx3y0z/vvV2sR+l9z7TtXgHLJcOywowfc6VW
         FfYLSi4aDV6S1trmPRat3youSjdpEcp/id5GxR4cLAVkvhm5pzfnXJyjCCFKvBtsrHYm
         1aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689143550; x=1691735550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZpxFys7nJdvmBPjIJ49j1uiao8v048XzoTDU+vGGrY=;
        b=enIFthliQlYqaBIbZ1wfYpyTYzVURGxajoaJ6yOFFypi2C4CgaOwLq/itcxdGm9XgA
         loJxW2k4m8FSQInqpT624xVCthGwW0Q96yD40g0clIZ4cmhAtaLcvFvLL5eARSDovLQy
         Yf2SwXy6qCC1HdcyY+wzkhrLwpMIgqn+OBUi5cQ+GzH6L9H4SaIflhVLOzZYAQ1ieSMA
         e2mEUMlsHyFw9wMSNbn1J3mCNvCibbrz0+2EwLvhymk12fQNn+I16+5Ahn+oE0KB8YXv
         TJLNZ+W49lwZWWe7XTbGiT8J4Vh07tCaYXJvh5/1wcq1jt+N168jMapAGsJYyq7yeg0o
         AkLg==
X-Gm-Message-State: ABy/qLaMfhEU1nOgoe+fLZ8heMcUsaPLV+qdb6jgqMszzDsBwqcOxDDH
        Z1C8uWrHXi349Sdb88znLKPAIuJqO4Cvm/jrY3aPMP4NpvZDKhyMT+eZmJR0
X-Google-Smtp-Source: APBJJlHitQTlvL6I4z82gB03QXe0/JP5JePZh/j6YDTLZIyn9YFxONiiRnRDGZg9nAyqPQvt4Prx16OpGyUGDkeOfEI=
X-Received: by 2002:a05:622a:1898:b0:403:b242:3e30 with SMTP id
 v24-20020a05622a189800b00403b2423e30mr80006qtc.1.1689143550478; Tue, 11 Jul
 2023 23:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230712060144.3006358-1-fengwei.yin@intel.com> <20230712060144.3006358-4-fengwei.yin@intel.com>
In-Reply-To: <20230712060144.3006358-4-fengwei.yin@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 12 Jul 2023 00:31:54 -0600
Message-ID: <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
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
> Current kernel only lock base size folio during mlock syscall.
> Add large folio support with following rules:
>   - Only mlock large folio when it's in VM_LOCKED VMA range
>
>   - If there is cow folio, mlock the cow folio as cow folio
>     is also in VM_LOCKED VMA range.
>
>   - munlock will apply to the large folio which is in VMA range
>     or cross the VMA boundary.
>
> The last rule is used to handle the case that the large folio is
> mlocked, later the VMA is split in the middle of large folio
> and this large folio become cross VMA boundary.
>
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
>  mm/mlock.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 99 insertions(+), 5 deletions(-)
>
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 0a0c996c5c214..f49e079066870 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -305,6 +305,95 @@ void munlock_folio(struct folio *folio)
>         local_unlock(&mlock_fbatch.lock);
>  }
>
> +static inline bool should_mlock_folio(struct folio *folio,
> +                                       struct vm_area_struct *vma)
> +{
> +       if (vma->vm_flags & VM_LOCKED)
> +               return (!folio_test_large(folio) ||
> +                               folio_within_vma(folio, vma));
> +
> +       /*
> +        * For unlock, allow munlock large folio which is partially
> +        * mapped to VMA. As it's possible that large folio is
> +        * mlocked and VMA is split later.
> +        *
> +        * During memory pressure, such kind of large folio can
> +        * be split. And the pages are not in VM_LOCKed VMA
> +        * can be reclaimed.
> +        */
> +
> +       return true;

Looks good, or just

should_mlock_folio() // or whatever name you see fit, can_mlock_folio()?
{
  return !(vma->vm_flags & VM_LOCKED) || folio_within_vma();
}

> +}
> +
> +static inline unsigned int get_folio_mlock_step(struct folio *folio,
> +                       pte_t pte, unsigned long addr, unsigned long end)
> +{
> +       unsigned int nr;
> +
> +       nr =3D folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte);
> +       return min_t(unsigned int, nr, (end - addr) >> PAGE_SHIFT);
> +}
> +
> +void mlock_folio_range(struct folio *folio, struct vm_area_struct *vma,
> +               pte_t *pte, unsigned long addr, unsigned int nr)
> +{
> +       struct folio *cow_folio;
> +       unsigned int step =3D 1;
> +
> +       mlock_folio(folio);
> +       if (nr =3D=3D 1)
> +               return;
> +
> +       for (; nr > 0; pte +=3D step, addr +=3D (step << PAGE_SHIFT), nr =
-=3D step) {
> +               pte_t ptent;
> +
> +               step =3D 1;
> +               ptent =3D ptep_get(pte);
> +
> +               if (!pte_present(ptent))
> +                       continue;
> +
> +               cow_folio =3D vm_normal_folio(vma, addr, ptent);
> +               if (!cow_folio || cow_folio =3D=3D folio) {
> +                       continue;
> +               }
> +
> +               mlock_folio(cow_folio);
> +               step =3D get_folio_mlock_step(folio, ptent,
> +                               addr, addr + (nr << PAGE_SHIFT));
> +       }
> +}
> +
> +void munlock_folio_range(struct folio *folio, struct vm_area_struct *vma=
,
> +               pte_t *pte, unsigned long addr, unsigned int nr)
> +{
> +       struct folio *cow_folio;
> +       unsigned int step =3D 1;
> +
> +       munlock_folio(folio);
> +       if (nr =3D=3D 1)
> +               return;
> +
> +       for (; nr > 0; pte +=3D step, addr +=3D (step << PAGE_SHIFT), nr =
-=3D step) {
> +               pte_t ptent;
> +
> +               step =3D 1;
> +               ptent =3D ptep_get(pte);
> +
> +               if (!pte_present(ptent))
> +                       continue;
> +
> +               cow_folio =3D vm_normal_folio(vma, addr, ptent);
> +               if (!cow_folio || cow_folio =3D=3D folio) {
> +                       continue;
> +               }
> +
> +               munlock_folio(cow_folio);
> +               step =3D get_folio_mlock_step(folio, ptent,
> +                               addr, addr + (nr << PAGE_SHIFT));
> +       }
> +}

I'll finish the above later.

>  static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
>                            unsigned long end, struct mm_walk *walk)
>
> @@ -314,6 +403,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long =
addr,
>         pte_t *start_pte, *pte;
>         pte_t ptent;
>         struct folio *folio;
> +       unsigned int step =3D 1;
>
>         ptl =3D pmd_trans_huge_lock(pmd, vma);
>         if (ptl) {
> @@ -329,24 +419,28 @@ static int mlock_pte_range(pmd_t *pmd, unsigned lon=
g addr,
>                 goto out;
>         }
>
> -       start_pte =3D pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +       pte =3D start_pte =3D pte_offset_map_lock(vma->vm_mm, pmd, addr, =
&ptl);
>         if (!start_pte) {
>                 walk->action =3D ACTION_AGAIN;
>                 return 0;
>         }
> -       for (pte =3D start_pte; addr !=3D end; pte++, addr +=3D PAGE_SIZE=
) {
> +
> +       for (; addr !=3D end; pte +=3D step, addr +=3D (step << PAGE_SHIF=
T)) {
> +               step =3D 1;
>                 ptent =3D ptep_get(pte);
>                 if (!pte_present(ptent))
>                         continue;
>                 folio =3D vm_normal_folio(vma, addr, ptent);
>                 if (!folio || folio_is_zone_device(folio))
>                         continue;
> -               if (folio_test_large(folio))
> +               if (!should_mlock_folio(folio, vma))
>                         continue;
> +
> +               step =3D get_folio_mlock_step(folio, ptent, addr, end);
>                 if (vma->vm_flags & VM_LOCKED)
> -                       mlock_folio(folio);
> +                       mlock_folio_range(folio, vma, pte, addr, step);
>                 else
> -                       munlock_folio(folio);
> +                       munlock_folio_range(folio, vma, pte, addr, step);
>         }
>         pte_unmap(start_pte);
>  out:

Looks good.
