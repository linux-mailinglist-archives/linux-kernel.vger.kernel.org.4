Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52815646430
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiLGWku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGWks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:40:48 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F118324D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 14:40:47 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s196so17690594pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 14:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YJzcWSpisZxsvZ51YIrLkcT67WEbgQAyYGf6F8KVYIQ=;
        b=UvK3396Gn/1nQ8kfhBk1nh5KPnRyp77nuDWpnLNzkFiEWSVpX7j1BmSCAqCOr6oxLq
         PCbbmYy7H1jfQyifTZ3W+NlyG3vxHMS6bdxr8L6RrKl1uABUuajcHpKkvVVIVTADiKdX
         hppndK07TsPVzebvK66bkxJ8otsdo90xJy18pezX0UvGYj3bzsa8Exk1iShCxW7WZdeh
         4hyxKzOpiTeuognJxLPFCEoZVvaXC6/tTYxFwqRVq/1AiOsqsI6otY+toAtj+7cwKlCO
         QXlwwyz/DD5gcMa5aNNhTAsvKFa5xMC8Y8z6+t4CQYY3R+qUK/msmhOPmgZo1V76lPWH
         TjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJzcWSpisZxsvZ51YIrLkcT67WEbgQAyYGf6F8KVYIQ=;
        b=utbGCdcRYtLYmXDHH1s/0yaWCXNqak0bYnjAGK2ZJ/6Er6jUpRxioP2lO3kdMbl/5w
         NhV//6e0Vvq1rmD85KvRyRjWl3H4W7I+ATulmpb3upHyisBvogXq33nt14ZHqLeFVtF9
         Lxzp/rCqMlg8CIkdGCL4/PcA+FfddOhwRsxCwty8TXW83YMEpZuMU0C7xiJZ+aG6EHy3
         VRisC/uv8wFI6JOjAmF3QEl+NOsqcsxLWBRSOhQ9BidxKSeUVc12hK+gjUJzkCLZGe5S
         VGFR3qUwEBDIEbueZ22zxWLR//dm+ty44RGM9vBxE33kJ10SDWToRNkH5cOuMwWT8+Oe
         cWmw==
X-Gm-Message-State: ANoB5pmDyHMkAL31v3a26Mm2SJnZxs1WXxkr9ZhmQThJO+smrJI9VijE
        GsDr9AuhwLnCat9Zq+T5ebPd6fwTEsl3eMEBd+M0iFJv
X-Google-Smtp-Source: AA0mqf4OIo0Mqi1EcLdKGX2GW3GQkWpHDE8XylXCgxwfvqHx/0ItM5ykHtqjqH/QaIz7xVjQ1YSd0mTVVaZ+RmznT7Q=
X-Received: by 2002:a63:1f48:0:b0:439:db5:f817 with SMTP id
 q8-20020a631f48000000b004390db5f817mr67696547pgm.310.1670452846776; Wed, 07
 Dec 2022 14:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20221206105737.69478-1-david@redhat.com>
In-Reply-To: <20221206105737.69478-1-david@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 7 Dec 2022 14:40:34 -0800
Message-ID: <CAHbLzkra0mjn4utzYPNp+-e77W3tb6yJiJMhkK9Kg=Ra_3rQnQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix SWP_PFN_BITS with CONFIG_PHYS_ADDR_T_64BIT
 on 32bit
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 2:57 AM David Hildenbrand <david@redhat.com> wrote:
>
> We use "unsigned long" to store a PFN in the kernel and phys_addr_t to
> store a physical address.
>
> On a 64bit system, both are 64bit wide. However, on a 32bit system, the
> latter might be 64bit wide. This is, for example, the case on x86 with
> PAE: phys_addr_t and PTEs are 64bit wide, while "unsigned long" only
> spans 32bit.
>
> The current definition of SWP_PFN_BITS without MAX_PHYSMEM_BITS misses
> that case, and assumes that the maximum PFN is limited by an 32bit
> phys_addr_t. This implies, that SWP_PFN_BITS will currently only be able to
> cover 4 GiB - 1 on any 32bit system with 4k page size, which is wrong.

Thanks for debugging this. IIUC this means even swap is actually
broken on x86_32 + PAE?

>
> Let's rely on the number of bits in phys_addr_t instead, but make sure to
> not exceed the maximum swap offset, to not make the  BUILD_BUG_ON() in
> is_pfn_swap_entry() unhappy. Note that swp_entry_t is effectively an
> unsigned long and the maximum swap offset shares that value with the
> swap type.
>
> For example, on an 8 GiB x86 PAE system with a kernel config based on
> Debian 11.5 (-> CONFIG_FLATMEM=y, CONFIG_X86_PAE=y), we will currently fail
> removing migration entries (remove_migration_ptes()), because
> mm/page_vma_mapped.c:check_pte() will fail to identify a PFN match as
> swp_offset_pfn() wrongly masks off PFN bits. For example,
> split_huge_page_to_list()->...->remap_page() will leave migration
> entries in place and continue to unlock the page.
>
> Later, when we stumble over these migration entries (e.g., via
> /proc/self/pagemap), pfn_swap_entry_to_page() will BUG_ON() because
> these migration entries shouldn't exist anymore and the page was
> unlocked.
>
> [   33.067591] kernel BUG at include/linux/swapops.h:497!
> [   33.067597] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   33.067602] CPU: 3 PID: 742 Comm: cow Tainted: G            E      6.1.0-rc8+ #16
> [   33.067605] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
> [   33.067606] EIP: pagemap_pmd_range+0x644/0x650
> [   33.067612] Code: 00 00 00 00 66 90 89 ce b9 00 f0 ff ff e9 ff fb ff ff 89 d8 31 db e8 48 c6 52 00 e9 23 fb ff ff e8 61 83 56 00 e9 b6 fe ff ff <0f> 0b bf 00 f0 ff ff e9 38 fa ff ff 3e 8d 74 26 00 55 89 e5 57 31
> [   33.067615] EAX: ee394000 EBX: 00000002 ECX: ee394000 EDX: 00000000
> [   33.067617] ESI: c1b0ded4 EDI: 00024a00 EBP: c1b0ddb4 ESP: c1b0dd68
> [   33.067619] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010246
> [   33.067624] CR0: 80050033 CR2: b7a00000 CR3: 01bbbd20 CR4: 00350ef0
> [   33.067625] Call Trace:
> [   33.067628]  ? madvise_free_pte_range+0x720/0x720
> [   33.067632]  ? smaps_pte_range+0x4b0/0x4b0
> [   33.067634]  walk_pgd_range+0x325/0x720
> [   33.067637]  ? mt_find+0x1d6/0x3a0
> [   33.067641]  ? mt_find+0x1d6/0x3a0
> [   33.067643]  __walk_page_range+0x164/0x170
> [   33.067646]  walk_page_range+0xf9/0x170
> [   33.067648]  ? __kmem_cache_alloc_node+0x2a8/0x340
> [   33.067653]  pagemap_read+0x124/0x280
> [   33.067658]  ? default_llseek+0x101/0x160
> [   33.067662]  ? smaps_account+0x1d0/0x1d0
> [   33.067664]  vfs_read+0x90/0x290
> [   33.067667]  ? do_madvise.part.0+0x24b/0x390
> [   33.067669]  ? debug_smp_processor_id+0x12/0x20
> [   33.067673]  ksys_pread64+0x58/0x90
> [   33.067675]  __ia32_sys_ia32_pread64+0x1b/0x20
> [   33.067680]  __do_fast_syscall_32+0x4c/0xc0
> [   33.067683]  do_fast_syscall_32+0x29/0x60
> [   33.067686]  do_SYSENTER_32+0x15/0x20
> [   33.067689]  entry_SYSENTER_32+0x98/0xf1
>
> Decrease the indentation level of SWP_PFN_BITS and SWP_PFN_MASK to keep
> it readable and consistent.
>
> Fixes: 0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>
> v1 -> v2:
> * Rely on sizeof(phys_addr_t) and min_t() instead.
> * Survives my various cross compilations and testing on x86 PAE.

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> ---
>  include/linux/swapops.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 86b95ccb81bb..424d586ed1ca 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -33,11 +33,13 @@
>   * can use the extra bits to store other information besides PFN.
>   */
>  #ifdef MAX_PHYSMEM_BITS
> -#define SWP_PFN_BITS                   (MAX_PHYSMEM_BITS - PAGE_SHIFT)
> +#define SWP_PFN_BITS           (MAX_PHYSMEM_BITS - PAGE_SHIFT)
>  #else  /* MAX_PHYSMEM_BITS */
> -#define SWP_PFN_BITS                   (BITS_PER_LONG - PAGE_SHIFT)
> +#define SWP_PFN_BITS           min_t(phys_addr_t, \
> +                                     sizeof(phys_addr_t) * 8 - PAGE_SHIFT, \
> +                                     SWP_TYPE_SHIFT)
>  #endif /* MAX_PHYSMEM_BITS */
> -#define SWP_PFN_MASK                   (BIT(SWP_PFN_BITS) - 1)
> +#define SWP_PFN_MASK           (BIT(SWP_PFN_BITS) - 1)
>
>  /**
>   * Migration swap entry specific bitfield definitions.  Layout:
>
> base-commit: 76dcd734eca23168cb008912c0f69ff408905235
> --
> 2.38.1
>
