Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927D873F512
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjF0HJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjF0HJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:09:18 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D90A1BE4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:09:16 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-401d1d967beso177341cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687849755; x=1690441755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HieCM9bprQuKzTV5MIdIK9yRrt8+ns3v3zkTmfeSLKc=;
        b=52XxEQkLZfNDLpT9HTPeOhwHeMUcO2f29g7st6oKFDRLgRJgZOggFrQHqpH5BTCO0l
         JiyQDR0m2a+yyKPjncLVMV+D7XmYNbJQDN2PHlbjG9NXua2kajsdQFbworKBUGSrXA1K
         3DtJiI5SVYTOagC5pmHJtRL9YHvXmJwIw5Gxk3XcbYjDmtnHKtOQFG1C0AcTUUnrjrF4
         gq0Bm0ndRuWGwDD4beBWtg+ML0ILBdznqOXSZHKp/eP+LTLKEvZx4Q3xAeKlCVjYI8Gd
         eMX8j57znm88QiYubcYdMSC948zjulA+TPATPOWPEnTNb8HW/R/UmZcH01LkBb081EJt
         Pn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687849755; x=1690441755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HieCM9bprQuKzTV5MIdIK9yRrt8+ns3v3zkTmfeSLKc=;
        b=TxuRWcHFfOooNtLRnJwxVYdtFXQGLd+MSKzCEVuIczo04DEqU2IFJSsVV2mHTSSp92
         nhzYxlcxRTPoWVkMG/YN2SVHB+KEHR7OXmMtX2RoYPs136BNGH1HSlaG0ETz/bmXAt6P
         7Ep7rm7nYOv0kdzZBfn/cGrcDIpMTMLcAnIMUEjT8Vpq+S7DwoadPVp5Y63s2aukj4gs
         y6ydfNHtGrEdPUoLIgadLoIQzNF7dlbuFUkh8L2RtXMcTiwcSqgdOCPu48tcXDRfj+9B
         ISnGRcyP7KlAaq6/T/xCRfcdmxslT3reuesC4lkoIocGdEHQ2uFDjZ20RFmZsl0TtDEC
         Ms1Q==
X-Gm-Message-State: AC+VfDxqAu3yEM8rBq82YUZvhoci+5sSLqkO9hMOFLkOJSj/T75HILwM
        qXReWsrb0pne/43HyOVdd4AXloqvnKWXMtQUklbBxw==
X-Google-Smtp-Source: ACHHUZ4PKTvNibPpiBw9Yw6RXxVIG2HKehlwY+KnLEMPY8PhvxrvGj0uBU4UnF9B4YdnnCPTS8uK4kxL+UpjhiOsPPU=
X-Received: by 2002:a05:622a:285:b0:3f8:5b2:aef2 with SMTP id
 z5-20020a05622a028500b003f805b2aef2mr100813qtw.26.1687849755160; Tue, 27 Jun
 2023 00:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com> <20230626171430.3167004-5-ryan.roberts@arm.com>
In-Reply-To: <20230626171430.3167004-5-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 27 Jun 2023 01:08:39 -0600
Message-ID: <CAOUHufZ0ZzHoJXwbzNyZOv74L=XYdZzcxA8SXxLX0MXdykuWRA@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] mm: Implement folio_add_new_anon_rmap_range()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
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

On Mon, Jun 26, 2023 at 11:14=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> Like folio_add_new_anon_rmap() but batch-rmaps a range of pages
> belonging to a folio, for effciency savings. All pages are accounted as
> small pages.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/rmap.h |  2 ++
>  mm/rmap.c            | 43 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index a3825ce81102..15433a3d0cbf 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -196,6 +196,8 @@ void page_add_new_anon_rmap(struct page *, struct vm_=
area_struct *,
>                 unsigned long address);
>  void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>                 unsigned long address);
> +void folio_add_new_anon_rmap_range(struct folio *folio, struct page *pag=
e,
> +               int nr, struct vm_area_struct *vma, unsigned long address=
);

We should update folio_add_new_anon_rmap() to support large() &&
!folio_test_pmd_mappable() folios instead.

I double checked all places currently using folio_add_new_anon_rmap(),
and as expected, none actually allocates large() &&
!folio_test_pmd_mappable() and maps it one by one, which makes the
cases simpler, i.e.,
  if (!large())
    // the existing basepage case
  else if (!folio_test_pmd_mappable())
    // our new case
  else
    // the existing THP case

>  void page_add_file_rmap(struct page *, struct vm_area_struct *,
>                 bool compound);
>  void folio_add_file_rmap_range(struct folio *, struct page *, unsigned i=
nt nr,
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1d8369549424..4050bcea7ae7 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1305,6 +1305,49 @@ void folio_add_new_anon_rmap(struct folio *folio, =
struct vm_area_struct *vma,
>         __page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>  }
>
> +/**
> + * folio_add_new_anon_rmap_range - Add mapping to a set of pages within =
a new
> + * anonymous potentially large folio.
> + * @folio:      The folio containing the pages to be mapped
> + * @page:       First page in the folio to be mapped
> + * @nr:         Number of pages to be mapped
> + * @vma:        the vm area in which the mapping is added
> + * @address:    the user virtual address of the first page to be mapped
> + *
> + * Like folio_add_new_anon_rmap() but batch-maps a range of pages within=
 a folio
> + * using non-THP accounting. Like folio_add_new_anon_rmap(), the inc-and=
-test is
> + * bypassed and the folio does not have to be locked. All pages in the f=
olio are
> + * individually accounted.
> + *
> + * As the folio is new, it's assumed to be mapped exclusively by a singl=
e
> + * process.
> + */
> +void folio_add_new_anon_rmap_range(struct folio *folio, struct page *pag=
e,
> +               int nr, struct vm_area_struct *vma, unsigned long address=
)
> +{
> +       int i;
> +
> +       VM_BUG_ON_VMA(address < vma->vm_start ||
> +                     address + (nr << PAGE_SHIFT) > vma->vm_end, vma);

BTW, VM_BUG_ON* shouldn't be used in new code:
Documentation/process/coding-style.rst
