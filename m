Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BDF73F0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjF0C1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjF0C1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:27:42 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316C91993
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 19:27:41 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-401f4408955so85651cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 19:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687832860; x=1690424860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOhy3g1phCLJAkpl2TbZcPe+XFOt300zTop8dH8V1+o=;
        b=SjT+NGU/KYp0j20S0Aem+ucWhH5rMWKMTvqrWJZGHCXKNk/LoqG+k6xJDmv+G7pu6D
         36lTPzR3ohTT2iCmphZKpBld1mzuq6LD9UPdJrMSOKVZrcoMrbToMUK05vMKSq7Mqco1
         ngdqtresiHFCt8k60Ed9MKzMJXlF1YO1/KSGjmI4plvCYnWxPaPtbifQP5Dr0f9dUdkE
         GOFP80hxOfsDuSqNAN8sVcWkRnMvxffTxmCL0n1l8BnOLfZyjhJ7DL36iVd+FjFhPi7M
         T7Qm+yGTZOGslzbLI83m17T3pWe5b3GUGHWu43CR9f/xk0/lyDWAL09H8sRgioiTAqyD
         rSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687832860; x=1690424860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOhy3g1phCLJAkpl2TbZcPe+XFOt300zTop8dH8V1+o=;
        b=MWj4TW3rN9cXA6fmQUOHCZdt/N3XabSZ2OkueWfZEAl2LXzTuBv8jY1lWforl2VA+c
         EatejNJmTObXFZhs7xvHZtavv2GsmmmAe+MCMFZce6U3wisU1DMtYjXU4pvHYWlpU3OV
         a+0TUzRxD3I1PQuTkr8KkyJw4T/klLx0I6vijJei3uLz4VObBCW7p1YtDIWtvPGaMFmB
         77avZvKTPJEN1Zd3xTRH+HEmRCYuA7WeNekseJFl5ilD00pyraK7BpibxicO2aU+Wy0A
         AHfPvwj8cuTCTHXn7Aei9mr0TUC2gbsKhRyJRiwihZQTdRJzoxgSY49to88RYgjJYnJ4
         vjXg==
X-Gm-Message-State: AC+VfDw0yTZngJ2bRz2mZTJMM8Heq2/5Fius7sIIueeYLrU4JERON/au
        FP8O4lN36PUq1L+ixZMu3qHdKapBxJ22ONj+E5qFBw==
X-Google-Smtp-Source: ACHHUZ6l05CmUEMzgTGl8UFFHdDjs7Y9vlJ1taFM6n42hpudP5U+bVa5aa314ArfBd4UutHG2EoqXB2PidC9xtlm7Ag=
X-Received: by 2002:ac8:5912:0:b0:3f8:1db6:201c with SMTP id
 18-20020ac85912000000b003f81db6201cmr581747qty.13.1687832860133; Mon, 26 Jun
 2023 19:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com> <20230626171430.3167004-3-ryan.roberts@arm.com>
In-Reply-To: <20230626171430.3167004-3-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 26 Jun 2023 20:27:04 -0600
Message-ID: <CAOUHufYWtsAU4PvKpVhzJUeQb9cd+BifY9KzgceBXHp2F2dDRg@mail.gmail.com>
Subject: Re: [PATCH v1 02/10] mm: pass gfp flags and order to vma_alloc_zeroed_movable_folio()
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 11:14=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> Allow allocation of large folios with vma_alloc_zeroed_movable_folio().
> This prepares the ground for large anonymous folios. The generic
> implementation of vma_alloc_zeroed_movable_folio() now uses
> clear_huge_page() to zero the allocated folio since it may now be a
> non-0 order.
>
> Currently the function is always called with order 0 and no extra gfp
> flags, so no functional change intended. But a subsequent commit will
> take advantage of the new parameters to allocate large folios. The extra
> gfp flags will be used to control the reclaim policy.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/alpha/include/asm/page.h   |  5 +++--
>  arch/arm64/include/asm/page.h   |  3 ++-
>  arch/arm64/mm/fault.c           |  7 ++++---
>  arch/ia64/include/asm/page.h    |  5 +++--
>  arch/m68k/include/asm/page_no.h |  7 ++++---
>  arch/s390/include/asm/page.h    |  5 +++--
>  arch/x86/include/asm/page.h     |  5 +++--
>  include/linux/highmem.h         | 23 +++++++++++++----------
>  mm/memory.c                     |  5 +++--
>  9 files changed, 38 insertions(+), 27 deletions(-)
>
> diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.=
h
> index 4db1ebc0ed99..6fc7fe91b6cb 100644
> --- a/arch/alpha/include/asm/page.h
> +++ b/arch/alpha/include/asm/page.h
> @@ -17,8 +17,9 @@
>  extern void clear_page(void *page);
>  #define clear_user_page(page, vaddr, pg)       clear_page(page)
>
> -#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
> -       vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr,=
 false)
> +#define vma_alloc_zeroed_movable_folio(vma, vaddr, gfp, order) \
> +       vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO | (gfp), \
> +                       order, vma, vaddr, false)

I don't think we need to worry about gfp if we want to make a minimum
series. There would be many discussion points around it, e.g., I
already disagree with what you chose: GFP_TRANSHUGE_LIGHT would be
more suitable than __GFP_NORETRY, and there are even better options
than GFP_TRANSHUGE_LIGHT.
