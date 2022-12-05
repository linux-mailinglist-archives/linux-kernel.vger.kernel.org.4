Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F386428B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiLEMrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiLEMrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:47:16 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011911B7A1;
        Mon,  5 Dec 2022 04:47:14 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id x24so4140814qkf.5;
        Mon, 05 Dec 2022 04:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baH+G8AY91mQWF55QesEv74bsBduWNCzRm1I0MqED+k=;
        b=yjsyc6cPVIKVZ7z2zr5xbkm1BADyoI4t6J1xjRurjIR7OPfZV6sSNEFOi//p5QNV0J
         Rh4t8Pbm6S9q9rFv6OPvBQ96BqVwjJHj6g7h2ODepSZquRXau8FvNS5P9YQkvsDEDtyV
         0/l6iLhHx50dloSn0VypSvQpuCXtRiPoxXgWz55ZDGRt7cJ7nx8Qmj+0MV4oi9AwCySf
         rSajeVcfzIn/DcWm3d431liyRIqpa2Hv70GfsoxO0rGnhQqVvhHvW0JoIxJhvMGt5nQW
         vOHe8T9n//WkT8kCFmdfzE1kW3POVUjB5H61dfeII5+v1fIYWpCyhfVC34FSGWcZdTJN
         X24A==
X-Gm-Message-State: ANoB5pkA33amzQGeQE4u/4LsM7cQJS6ycEGlaZNG4ZQ7SLMnh+fOj95a
        n8qsHfGkSD3sf6RGBVpD7HjD3vlj3HEOS0/XR8w=
X-Google-Smtp-Source: AA0mqf4/Qp74wXJrO0hHpb3xbNPsUYLpg061BojP3GHIyXpK6vfWzLpLvAOX6fVsaeCf0foNoSKMIyI5xm0xtgoPlWw=
X-Received: by 2002:a05:620a:22fa:b0:6fb:c38e:e5dd with SMTP id
 p26-20020a05620a22fa00b006fbc38ee5ddmr72755175qki.23.1670244434016; Mon, 05
 Dec 2022 04:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20221205002804.21225-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20221205002804.21225-1-rick.p.edgecombe@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Dec 2022 13:46:59 +0100
Message-ID: <CAJZ5v0iZ8QdCMca1F+z2NJ8+a-jUkGMSNp2KRovCB-aMjHF7qg@mail.gmail.com>
Subject: Re: [PATCH] x86/hibernate: Use fixmap for saving unmapped pages
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        rppt@kernel.org, peterz@infradead.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 1:28 AM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> Hibernate uses the direct map to read memory it saves to disk. Since
> sometimes pages are not accessible on the direct map ("not present" on
> x86), it has special case logic to temporarily make a page present. On x86
> these direct map addresses can be mapped at various page sizes, but the
> logic works ok as long as the not present pages are always mapped as
> PAGE_SIZE such that they don't require a split to map the region as
> present. If the address was mapped not present by a larger page size, the
> split may fail and hibernate would then try to read an address mapped not
> present.
>
> Today on x86 there are no known cases of this (huge not present pages on
> the direct map), but it has come up from time to time when developing
> things that operate on the direct map. It blocked making
> VM_FLUSH_RESET_PERMS support huge vmalloc when that came up, and also
> has been a complication for various direct map protection efforts.
>
> This dependency is also pretty hidden and easily missed by people poking at
> the direct map. For this reason, there are warnings in place to complain
> but not handle this scenario.
>
> One way to make this more robust would be to create some new CPA
> functionality that can know to map and reset the whole huge page in the
> case of trying to map a subpage. But for simplicity and smaller code, just
> make x86 hibernate have its own fixmap PTE that it can use to point
> to 4k pages when it encounters an unmapped direct map page.
>
> Move do_copy_page() to a header such that it can be used in an arch
> breakout. Rename it hib_copy_page() to be more hibernate specific since
> it could appear in other files.
>
> Use __weak for the arch breakout because there is not a suitable arch
> specific header to use the #define method.
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>
> Hi,
>
> Since none of the module space allocation overhauls ever seem to go smoothly
> and it may be awhile before VM_FLUSH_RESET_PERMS in not needed, I thought I
> would try and fix up some of its deficiencies in the meantime. This is
> pre-work for that, but I thought it was useful enough on it's own.
>
> The testing was hacking up hibernate to load some data to a huge NP mapping
> and making sure the data was there when it came back.

OK, so I don't feel like it is 6.2 material at this point.

Please resend it when 6.2-rc1 is out so it gets some more significant
linux-next coverage before going into the mainline.

Thanks!

>
>  arch/x86/include/asm/fixmap.h |  3 +++
>  arch/x86/power/hibernate.c    | 10 ++++++++++
>  include/linux/suspend.h       | 13 +++++++++++++
>  kernel/power/snapshot.c       | 21 +++++++--------------
>  4 files changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
> index d0dcefb5cc59..0fceed9a4152 100644
> --- a/arch/x86/include/asm/fixmap.h
> +++ b/arch/x86/include/asm/fixmap.h
> @@ -108,6 +108,9 @@ enum fixed_addresses {
>  #ifdef CONFIG_PARAVIRT_XXL
>         FIX_PARAVIRT_BOOTMAP,
>  #endif
> +#ifdef CONFIG_HIBERNATION
> +       FIX_HIBERNATE,
> +#endif
>
>  #ifdef CONFIG_ACPI_APEI_GHES
>         /* Used for GHES mapping from assorted contexts */
> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> index 6f955eb1e163..473b6b5f6b7e 100644
> --- a/arch/x86/power/hibernate.c
> +++ b/arch/x86/power/hibernate.c
> @@ -147,6 +147,16 @@ int arch_hibernation_header_restore(void *addr)
>         return 0;
>  }
>
> +void copy_unmapped_page(void *dst, struct page *page)
> +{
> +       WARN_ON(!preempt_count());
> +
> +       set_fixmap(FIX_HIBERNATE, page_to_phys(page));
> +       __flush_tlb_all();
> +       hib_copy_page(dst, (void *)fix_to_virt(FIX_HIBERNATE));
> +       clear_fixmap(FIX_HIBERNATE);
> +}
> +
>  int relocate_restore_code(void)
>  {
>         pgd_t *pgd;
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index cfe19a028918..0b19b910526e 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -447,6 +447,19 @@ extern bool hibernation_available(void);
>  asmlinkage int swsusp_save(void);
>  extern struct pbe *restore_pblist;
>  int pfn_is_nosave(unsigned long pfn);
> +void copy_unmapped_page(void *dst, struct page *page);
> +
> +/*
> + * This is needed, because copy_page and memcpy are not usable for copying
> + * task structs.
> + */
> +static inline void hib_copy_page(long *dst, long *src)
> +{
> +       int n;
> +
> +       for (n = PAGE_SIZE / sizeof(long); n; n--)
> +               *dst++ = *src++;
> +}
>
>  int hibernate_quiet_exec(int (*func)(void *data), void *data);
>  #else /* CONFIG_HIBERNATION */
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 2a406753af90..ccf123b5019c 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1369,16 +1369,11 @@ static unsigned int count_data_pages(void)
>         return n;
>  }
>
> -/*
> - * This is needed, because copy_page and memcpy are not usable for copying
> - * task structs.
> - */
> -static inline void do_copy_page(long *dst, long *src)
> +void __weak copy_unmapped_page(void *dst, struct page *page)
>  {
> -       int n;
> -
> -       for (n = PAGE_SIZE / sizeof(long); n; n--)
> -               *dst++ = *src++;
> +       hibernate_map_page(page);
> +       hib_copy_page(dst, page_address(page));
> +       hibernate_unmap_page(page);
>  }
>
>  /**
> @@ -1392,11 +1387,9 @@ static inline void do_copy_page(long *dst, long *src)
>  static void safe_copy_page(void *dst, struct page *s_page)
>  {
>         if (kernel_page_present(s_page)) {
> -               do_copy_page(dst, page_address(s_page));
> +               hib_copy_page(dst, page_address(s_page));
>         } else {
> -               hibernate_map_page(s_page);
> -               do_copy_page(dst, page_address(s_page));
> -               hibernate_unmap_page(s_page);
> +               copy_unmapped_page(dst, s_page);
>         }
>  }
>
> @@ -1417,7 +1410,7 @@ static void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
>         if (PageHighMem(s_page)) {
>                 src = kmap_atomic(s_page);
>                 dst = kmap_atomic(d_page);
> -               do_copy_page(dst, src);
> +               hib_copy_page(dst, src);
>                 kunmap_atomic(dst);
>                 kunmap_atomic(src);
>         } else {
> --
> 2.17.1
>
