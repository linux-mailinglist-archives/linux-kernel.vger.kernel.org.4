Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86C5746388
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGCTv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGCTv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:51:27 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C0BE5F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:51:25 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-401f4408955so437301cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 12:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688413885; x=1691005885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGUF+cNy4bxRpiXiVgsKLP+rYgkOF7DepfxvhKxQUiE=;
        b=4vv7r/W3oUFRIp8Pg+MWZ2njnLPT9nJVUjlbcjI2Oe9W41D7xmtuGQKUl+3ELaYqtf
         cf6JAMg/pkVcI935h7HsbRX0IATGAR9LM1NGW9N3vasZDYSUemUGEims1oomd+/DUZbl
         UMTd7Qobp4vXXUn2851yCwrX+MQW/9vbzeDmhAPqqOSLwwVy4L+FUPmIDJCgQzg2TrPi
         tt/Yf4Xe88HQ4iLC4PTDm7QNLoCvCh2TagpYco7SM6na7CDORRvBqw+d9OSe9TCbn7eB
         7npLjl+f7TWwfFtrzUt+xmOgTpIalaIZT5MJNxXx3LLGQbW6AO947d2Yc5kWzlDahMkP
         c0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688413885; x=1691005885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGUF+cNy4bxRpiXiVgsKLP+rYgkOF7DepfxvhKxQUiE=;
        b=DhAXJUhci1BwCJlqk7WkuR7ZCEtC0ZrlN/RRaffU8MvyeaLxPepk5ykQQQaJI/8szS
         AOui7OwqxnzEHbUPwo+qEHWcFGzxOSSjub/X7hljgzbS6PjlqJk/LclAKHSjRW6WXnR+
         CDH/LH/uZItkQWXTlm20SXG3g4ci2oUxOiy9d9+YEhqhQoMucFA2i3aBml3t/OS6t++O
         4m5f71+SnTqY4V6w0XROSY7B6N9sLoX6FBhfZEIZ6LdJ9vZXmoCEqqTXbdUuTGos79bc
         rr2nrkWZPNcA6c8pEGe59/WK0DFwAv6IgxgTT/mEJK4XKIiat0OqFwE2xOPQtMnrkzE1
         ZKDA==
X-Gm-Message-State: ABy/qLZU6+Pj8M2OiOyKqcIoDKUuRS5XUFbPj+yzTDOH3nWOVRkrBG9t
        aW06/NmTiU5IKb1R1eX49tpQBfdxYIZqWsKu9a8zuQ==
X-Google-Smtp-Source: APBJJlG44olgZeCFMxPRIUt625xDAlpyBZINREyO/s3UARKyJzIIaCfcOB8UsIUgIz4XIGe3v5zrgf6PDRggjOGea2w=
X-Received: by 2002:a05:622a:15d5:b0:3ef:2f55:2204 with SMTP id
 d21-20020a05622a15d500b003ef2f552204mr15228qty.6.1688413884752; Mon, 03 Jul
 2023 12:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135330.1865927-1-ryan.roberts@arm.com> <20230703135330.1865927-4-ryan.roberts@arm.com>
In-Reply-To: <20230703135330.1865927-4-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 3 Jul 2023 13:50:48 -0600
Message-ID: <CAOUHufa_xFJvFFvmw1Tkdc9cXaZ1GPA1dVSauH+J9zGX-sO1UA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: Default implementation of arch_wants_pte_order()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Mon, Jul 3, 2023 at 7:53=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> arch_wants_pte_order() can be overridden by the arch to return the
> preferred folio order for pte-mapped memory. This is useful as some
> architectures (e.g. arm64) can coalesce TLB entries when the physical
> memory is suitably contiguous.
>
> The first user for this hint will be FLEXIBLE_THP, which aims to
> allocate large folios for anonymous memory to reduce page faults and
> other per-page operation costs.
>
> Here we add the default implementation of the function, used when the
> architecture does not define it, which returns the order corresponding
> to 64K.

I don't really mind a non-zero default value. But people would ask why
non-zero and why 64KB. Probably you could argue this is the large size
all known archs support if they have TLB coalescing. For x86, AMD CPUs
would want to override this. I'll leave it to Fengwei to decide
whether Intel wants a different default value.

Also I don't like the vma parameter because it makes
arch_wants_pte_order() a mix of hw preference and vma policy. From my
POV, the function should be only about the former; the latter should
be decided by arch-independent MM code. However, I can live with it if
ARM MM people think this is really what you want. ATM, I'm skeptical
they do.

> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

After another CPU vendor, e.g., Fengwei, and an ARM MM person, e.g.,
Will give the green light:
Reviewed-by: Yu Zhao <yuzhao@google.com>

> ---
>  include/linux/pgtable.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index a661a17173fa..f7e38598f20b 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -13,6 +13,7 @@
>  #include <linux/errno.h>
>  #include <asm-generic/pgtable_uffd.h>
>  #include <linux/page_table_check.h>
> +#include <linux/sizes.h>
>
>  #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_FOLDED=
) - \
>         defined(__PAGETABLE_PMD_FOLDED) !=3D CONFIG_PGTABLE_LEVELS
> @@ -336,6 +337,18 @@ static inline bool arch_has_hw_pte_young(void)
>  }
>  #endif
>
> +#ifndef arch_wants_pte_order
> +/*
> + * Returns preferred folio order for pte-mapped memory. Must be in range=
 [0,
> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires larg=
e folios

The warning is helpful.

> + * to be at least order-2.
> + */
> +static inline int arch_wants_pte_order(struct vm_area_struct *vma)
> +{
> +       return ilog2(SZ_64K >> PAGE_SHIFT);
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>                                        unsigned long address,
