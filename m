Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9D5708C38
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 01:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjERXUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 19:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjERXUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 19:20:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E450AE49
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:20:26 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f42397f41fso13145e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684452025; x=1687044025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJYCzmsxGe3XadmHdoY3BjZEttTV9cjxHheRcEXc8pI=;
        b=Qo8Fd9UVjLA5wDOWZyMhv7XSWo/l9odl2UB/pRyuLKCGJ9QaQm8mrzXc92qF1Tj/vi
         lhU3yjKbyG9kdDg4amhJdGPsTRzBgIIUywxFqaDU6TpJq4mNJNh3b5rqgfYS+1Ic+KWR
         m6cUcThAN4sf3TkjRa6x33ba0j2k/yZC7BtQb4yTFRXVEKT1vejd8ONjeONZiT1/cQan
         DxnM1buLmZ/uez72mjo1RmUwv7BXwJIj7L1oPTLDISXobLn9KdE8m0KG8KW2r8Yalx86
         gip9/aMpN1eYBAMHDbTOgFnaJRAGKI9dS4/t7vmEPDdgSp6Sd7T51AWYcE1Yc6qjA5Lx
         QWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684452025; x=1687044025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJYCzmsxGe3XadmHdoY3BjZEttTV9cjxHheRcEXc8pI=;
        b=QteeU2S+vKkwdUtvqVTHi1ePESwWRaGYHIh4zXUf/PL8t9+BWhnIlZaieYnvizANTu
         cOQTrPLdQfX0ZIFtJu92FhO29QPFC+438pXfYk2Z7rKV2jr7ehbkG7FSaqxGjuaQDvWM
         8y/7Q6QRqXjnoFCUtjx7GoohXDcuhkbjVcv9Mc/a/3KSIWK1CzuBwNgph4Vak3siu0An
         yG5cubQbJQYV/k7y/aeF45PdzyPfq8CwGPlQZlTCzJ1uyiBwoH4OIUmdIpt+Rh0gzxTX
         0hNZT7kQhXkafPozWS03ZkVQAOWlFy7YIwVv0ABaz2weqXD+MZJ4wRPxvdaqd6VrD3Mz
         2Sbg==
X-Gm-Message-State: AC+VfDxEdlEb7CTbg6TLT3Gd+Z4lHucK00+Ifjv2bfrZW1p1vCU50KEA
        ZBakwDR2YEZK438W9plLt/tp26GTPmQIn1ZYAmPiFg==
X-Google-Smtp-Source: ACHHUZ7M54BsEHMo9QjezJJD7FpRp2hq0zHfe/ZaWXANjZPO4pzpy4ews+hVsaI9pbSnPGvmL6U5TqRjLytqp01+g/Q=
X-Received: by 2002:a05:600c:3ba3:b0:3f1:73b8:b5fe with SMTP id
 n35-20020a05600c3ba300b003f173b8b5femr31383wms.3.1684452025268; Thu, 18 May
 2023 16:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230518110727.2106156-1-ryan.roberts@arm.com> <20230518110727.2106156-3-ryan.roberts@arm.com>
In-Reply-To: <20230518110727.2106156-3-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 18 May 2023 17:19:48 -0600
Message-ID: <CAOUHufYXuH+mUNAtiRbAqqKTKO-nGR248Z2MVgGzMJqYu8yawQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm: damon must atomically clear young on ptes and pmds
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev
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

On Thu, May 18, 2023 at 5:07=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> It is racy to non-atomically read a pte, then clear the young bit, then
> write it back as this could discard dirty information. Further, it is
> bad practice to directly set a pte entry within a table. Instead
> clearing young must go through the arch-provided helper,
> ptep_test_and_clear_young() to ensure it is modified atomically and to
> give the arch code visibility and allow it to check (and potentially
> modify) the operation.
>
> Fixes: 46c3a0accdc4 ("mm/damon/vaddr: separate commonly usable functions"=
)

This should be a separate patch, since it's independent from what the
series tries to do.

And that patch should cc stable, since it fixes user data corruption.

> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/damon/ops-common.c | 16 ++++++----------
>  mm/damon/ops-common.h |  4 ++--
>  mm/damon/paddr.c      |  4 ++--
>  mm/damon/vaddr.c      |  4 ++--
>  4 files changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index cc63cf953636..acc264b97903 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -37,7 +37,7 @@ struct folio *damon_get_folio(unsigned long pfn)
>         return folio;
>  }
>
> -void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long ad=
dr)
> +void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned l=
ong addr)
>  {
>         bool referenced =3D false;
>         struct folio *folio =3D damon_get_folio(pte_pfn(*pte));
> @@ -45,13 +45,11 @@ void damon_ptep_mkold(pte_t *pte, struct mm_struct *m=
m, unsigned long addr)
>         if (!folio)
>                 return;
>
> -       if (pte_young(*pte)) {
> +       if (ptep_test_and_clear_young(vma, addr, pte))
>                 referenced =3D true;
> -               *pte =3D pte_mkold(*pte);
> -       }
>
>  #ifdef CONFIG_MMU_NOTIFIER
> -       if (mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE))
> +       if (mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE))
>                 referenced =3D true;
>  #endif /* CONFIG_MMU_NOTIFIER */

Use ptep_clear_young_notify(). Similar below.
