Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330EC74BBEC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 07:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjGHFMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 01:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHFMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 01:12:34 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5161FEC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 22:12:32 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4036bd4fff1so71821cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 22:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688793152; x=1691385152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXUkY077M68MN6utXvlpO6chGtWE53cWZb+Nx2rn9lY=;
        b=W/BORHzeOA6Eaw0EPkEjw+VQZX9O6vOyeYyaLRz7I2NsrvbLY8cXSi1HNlDg2GWQTP
         oQ6Gt8yW7EpBVV78uA0XeD1G3cahWrJ4/pJezavlfC6uyNUqJhvk5pBMYMamsvu0tfRn
         1GtPrQEKEOW7KhDuHEqf0Ax30T6mxctoa4TsyoM5ZHbkDOpO2e9ERhskEajsDDcHPC0D
         2fgF8u9n+1TfOSduMeZ9/hJzX4TRgVLKm3w58bQUh4EBEe1//f3psq7cAQK9Cvv5h4DY
         Lxsci0uIvAP0yoIbbLyArLYWCS6trNPQvhYizVznTJFwnC6O+at4QUHefAcXytHozS+7
         G7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688793152; x=1691385152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXUkY077M68MN6utXvlpO6chGtWE53cWZb+Nx2rn9lY=;
        b=krSQfd5eUUz5ApUaeFQMBj4VfH+n2ewoyszxpiJpRXeZqd+BhJQowlCXk5hVfxab1c
         OfoGQeT/f0vCWqhsNphuYDdEkUiinHJe3X7W8q3rtHxunPDpU8vNqwVRoxodT6QCfjdx
         6+SkTfcPLVE3L90f259FXfoGap/ZX7pL+N/5kjedf6ziqPkSnzbt8/gqOj6fOOzw6YSk
         s3P/gbH8LenKPtU4aEKSFowm9QQvJhPZIJCAytgE2X1nDrXXP9wjfnIMpXg/g+61rHjB
         Gh934RwFsSXRfFy34DbnE8v5QuzK94sPYohfjz+62WBHv2zB7T/wYbBUUhxLiuRzLjyp
         49yg==
X-Gm-Message-State: ABy/qLaCsYX79bFD/wGfvRZwHP3Bvi8Zxez51tdw2BTVUVy2rZBNjVlF
        l095xygTUlQGIYpWtn3ug8LBK0t2ip8hH1r/FBFoOA==
X-Google-Smtp-Source: APBJJlHuQTOPWRtl7jg/V4OnXW/ZTFrOSW3+quFXTBdITUsD5EFZO5SZW/dIe0qnjbxQ48tUMYpxEwDUPuFScMqjhYU=
X-Received: by 2002:ac8:4e8e:0:b0:3f9:a770:7279 with SMTP id
 14-20020ac84e8e000000b003f9a7707279mr62041qtp.9.1688793151715; Fri, 07 Jul
 2023 22:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230707165221.4076590-1-fengwei.yin@intel.com> <20230707165221.4076590-3-fengwei.yin@intel.com>
In-Reply-To: <20230707165221.4076590-3-fengwei.yin@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 7 Jul 2023 23:11:55 -0600
Message-ID: <CAOUHufZWYo4DMNgu4VtGsPtHR3LQmYRH9rC9inMAn+-4oZSyCw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] mm: handle large folio when large folio in
 VM_LOCKED VMA range
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com
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

On Fri, Jul 7, 2023 at 10:52=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
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
>  mm/rmap.c     |  3 ++-
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 66117523d7d71..c7b8f0b008d81 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -637,7 +637,8 @@ static inline void mlock_vma_folio(struct folio *foli=
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
>
> @@ -645,8 +646,12 @@ void munlock_folio(struct folio *folio);
>  static inline void munlock_vma_folio(struct folio *folio,
>                         struct vm_area_struct *vma, bool compound)
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
> index 2668f5ea35342..7d6547d1bd096 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -817,7 +817,8 @@ static bool folio_referenced_one(struct folio *folio,
>                 address =3D pvmw.address;
>
>                 if ((vma->vm_flags & VM_LOCKED) &&
> -                   (!folio_test_large(folio) || !pvmw.pte)) {
> +                   (!folio_test_large(folio) || !pvmw.pte ||
> +                   folio_in_range(folio, vma, vma->vm_start, vma->vm_end=
))) {
>                         /* Restore the mlock which got missed */
>                         mlock_vma_folio(folio, vma, !pvmw.pte);
>                         page_vma_mapped_walk_done(&pvmw);

It needs to bail out if large but not within range so that the
references within the locked VMA can be ignored. Otherwise, a hot
locked portion can prevent a cold unlocked portion from getting
reclaimed.
