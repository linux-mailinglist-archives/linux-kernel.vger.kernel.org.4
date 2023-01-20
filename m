Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8A1675BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjATRhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjATRha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:37:30 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2E74209;
        Fri, 20 Jan 2023 09:37:28 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id mg12so15798020ejc.5;
        Fri, 20 Jan 2023 09:37:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGkDVIxsqubX5WE2V1v1oe6bCNNiRkn1j1V9aISQ8xw=;
        b=1fIBNvl2Pil7M7imVhkSdF8qdjgkKPjvTWrsuc7ZxyArYrneK2xzWnm3XWo/zOo4Np
         HKL7aOjtl00FZeTBD9eKowsJ/UjCBk0TJAsPXMNcPjV8QPTjAmc73Y7kuYgcYN8+Lmne
         gM9lcdo87SLao2uBKkqKhIf0/eoPvq3JGAimwREaIqfMV1gOGWi7Gb/8o31/TMyNDNEv
         nAADxrUEkto6Ir/GnZRqXqcZreaMKue4GzTHx3yRtHATXPvsohEQetmOzfwvj+AADOcQ
         YG9Q+DROOtg71mMoppfe3EA871CaryoOL1ehUigohHxcTcMTh5BdxN2cZKBF9qHrGjq+
         jlWA==
X-Gm-Message-State: AFqh2krSaC0fUktrKATpHo/GXAuRmOJJGzJpdtCmqVlhWmcax1/xTEzs
        zJUHiabpgZ7YlZJHMHtSPNw1LAnwD6Pg5fFVgFNNu6RR
X-Google-Smtp-Source: AMrXdXs37y8BTEY9zVoeV+YMDXtcEFumP/IOtQPHUotZl+HgIdCWNB/NiGpNMe+uN+B1s5mg48aABhNBfVaNV+gtLro=
X-Received: by 2002:a17:906:2c4b:b0:870:3557:160e with SMTP id
 f11-20020a1709062c4b00b008703557160emr1231864ejh.78.1674236247378; Fri, 20
 Jan 2023 09:37:27 -0800 (PST)
MIME-Version: 1.0
References: <20230119235145.22740-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20230119235145.22740-1-rick.p.edgecombe@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 18:37:16 +0100
Message-ID: <CAJZ5v0jNN7ZDti7h=jzbwFzP-PLGDE-2beO5Eh9hW_WGpZMN=A@mail.gmail.com>
Subject: Re: [PATCH v3] x86/hibernate: Use fixmap for saving unmapped pages
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
        rppt@kernel.org, peterz@infradead.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 12:52 AM Rick Edgecombe
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
> So create arch breakouts for hibernate_map_page() and
> hibernate_unmap_page() so that the mapping of unmapped pages can be
> off the direct map. Change hibernate_map_page() to return an address,
> and implement an arch breakout on x86 on that uses the fixmap.
>
> Since now hibernate_map_page() can return a value, have it return NULL
> when the page fails to map, and have safe_copy_page() skip copying the
> page if it fails to map. The existing behavior should crash in this case,
> so this way there is a chance the system would be recoverable.
>
> Use __weak for the arch breakout because there is not a suitable arch
> specific header to use the #define method.
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>
> v3:
>  - Switch from hib_copy_page() breakout to hibernate_un/map_page()
>    breakouts.
>  - Since there is an error to use now, skip copying for unmappable pages

Much better than before.

In case the x86 folks want to take this

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and otherwise please let me know that I need to take care of it.

>
> v2:
>  - Rebase
>
>  arch/x86/include/asm/fixmap.h |  3 +++
>  arch/x86/power/hibernate.c    | 12 ++++++++++++
>  include/linux/suspend.h       |  2 ++
>  kernel/power/snapshot.c       | 22 ++++++++++++++--------
>  4 files changed, 31 insertions(+), 8 deletions(-)
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
> index 6f955eb1e163..e7cde7cd529d 100644
> --- a/arch/x86/power/hibernate.c
> +++ b/arch/x86/power/hibernate.c
> @@ -147,6 +147,18 @@ int arch_hibernation_header_restore(void *addr)
>         return 0;
>  }
>
> +long *hibernate_map_page(struct page *page)
> +{
> +       set_fixmap(FIX_HIBERNATE, page_to_phys(page));
> +       __flush_tlb_all();
> +       return (long *)fix_to_virt(FIX_HIBERNATE);
> +}
> +
> +void hibernate_unmap_page(struct page *page)
> +{
> +       clear_fixmap(FIX_HIBERNATE);
> +}
> +
>  int relocate_restore_code(void)
>  {
>         pgd_t *pgd;
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index cfe19a028918..a6c3f7dac9e1 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -447,6 +447,8 @@ extern bool hibernation_available(void);
>  asmlinkage int swsusp_save(void);
>  extern struct pbe *restore_pblist;
>  int pfn_is_nosave(unsigned long pfn);
> +long *hibernate_map_page(struct page *page);
> +void hibernate_unmap_page(struct page *page);
>
>  int hibernate_quiet_exec(int (*func)(void *data), void *data);
>  #else /* CONFIG_HIBERNATION */
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index cd8b7b35f1e8..8cc16114da75 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -83,19 +83,18 @@ static inline void hibernate_restore_unprotect_page(void *page_address) {}
>   * It is still worth to have a warning here if something changes and this
>   * will no longer be the case.
>   */
> -static inline void hibernate_map_page(struct page *page)
> +long * __weak hibernate_map_page(struct page *page)
>  {
>         if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
> -               int ret = set_direct_map_default_noflush(page);
> -
> -               if (ret)
> -                       pr_warn_once("Failed to remap page\n");
> +               if (set_direct_map_default_noflush(page))
> +                       return NULL;
>         } else {
>                 debug_pagealloc_map_pages(page, 1);
>         }
> +       return page_address(page);
>  }
>
> -static inline void hibernate_unmap_page(struct page *page)
> +void __weak hibernate_unmap_page(struct page *page)
>  {
>         if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
>                 unsigned long addr = (unsigned long)page_address(page);
> @@ -1394,8 +1393,15 @@ static void safe_copy_page(void *dst, struct page *s_page)
>         if (kernel_page_present(s_page)) {
>                 do_copy_page(dst, page_address(s_page));
>         } else {
> -               hibernate_map_page(s_page);
> -               do_copy_page(dst, page_address(s_page));
> +               long *src = hibernate_map_page(s_page);
> +
> +               if (!src) {
> +                       pr_warn_once("Failed to remap page\n");
> +                       return;
> +               }
> +
> +               do_copy_page(dst, src);
> +
>                 hibernate_unmap_page(s_page);
>         }
>  }
> --
