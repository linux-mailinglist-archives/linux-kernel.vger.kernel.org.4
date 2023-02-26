Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E7B6A33E1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 21:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjBZUNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 15:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZUNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:13:51 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6BAD301;
        Sun, 26 Feb 2023 12:13:50 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id cf14so4701877qtb.10;
        Sun, 26 Feb 2023 12:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gg5lD1thnSOjSPD2ugSmhhuDJpRIfjxQ4WV4ji/sEm4=;
        b=b4fvqlKEnKtSkihrg55JYq+ke0pEzfiymXjhN3I6/fQybr+DvLraWGgthf8ZtPjCuQ
         6xXuuE3Y+TLKzGA8BaKIGqVv49ebOFSGwJQ+h5Ngr2W1Xu8xllIDi1ZXlwoERY0x45ra
         ReBdvXHBsf3RgUvVSazqK8baSqpxGG3NGPUro9cfOO02NMuyy4/uhKWAxVoiMIuXrV88
         l+K48IrSMo4w6Z6EThjVQfC/gdYNb460HM6nurUHmXYspkS4R1cQLrryx70FCmqQntv1
         tsgV9ECV6YcDKfNlVpnl2VYdVjOSEMg41u2aMYCXM5p6wALfJw9b8DSaeoYU8tB/ukpo
         ZDqg==
X-Gm-Message-State: AO0yUKXVUfRCo9lua3f27kFTNtm06jvdTBQ/z3wEd2OdaiblPaBAWZyw
        jPnSQ54eFzaQTRJV29N2cVkUnHiCg/Uz/w==
X-Google-Smtp-Source: AK7set/moY1L6F+ebE6HKWgvhvMgP5uM2L9z7Rmqe5nF1PsdDFF11lerf3DY0AEL23MzZqU7yIzsFA==
X-Received: by 2002:ac8:5907:0:b0:3b8:3629:7cb7 with SMTP id 7-20020ac85907000000b003b836297cb7mr39427624qty.64.1677442428848;
        Sun, 26 Feb 2023 12:13:48 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id k8-20020a05620a142800b0073ba211e765sm3591529qkj.19.2023.02.26.12.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 12:13:47 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-536af432ee5so124981857b3.0;
        Sun, 26 Feb 2023 12:13:47 -0800 (PST)
X-Received: by 2002:a81:af5f:0:b0:536:38b4:f51 with SMTP id
 x31-20020a81af5f000000b0053638b40f51mr8731562ywj.5.1677442427017; Sun, 26 Feb
 2023 12:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20230113171026.582290-1-david@redhat.com> <20230113171026.582290-12-david@redhat.com>
In-Reply-To: <20230113171026.582290-12-david@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 26 Feb 2023 21:13:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-FDga8w=pgg1myskEx6wp+oyZifhPPPFnWrc1zW7ZpQ@mail.gmail.com>
Message-ID: <CAMuHMdX-FDga8w=pgg1myskEx6wp+oyZifhPPPFnWrc1zW7ZpQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 11/26] microblaze/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, Jan 13, 2023 at 6:16 PM David Hildenbrand <david@redhat.com> wrote:
> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit
> from the type. Generic MM currently only uses 5 bits for the type
> (MAX_SWAPFILES_SHIFT), so the stolen bit is effectively unused.
>
> The shift by 2 when converting between PTE and arch-specific swap entry
> makes the swap PTE layout a little bit harder to decipher.
>
> While at it, drop the comment from paulus---copy-and-paste leftover
> from powerpc where we actually have _PAGE_HASHPTE---and mask the type in
> __swp_entry_to_pte() as well.
>
> Cc: Michal Simek <monstr@monstr.eu>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Thanks for your patch, which is now commit b5c88f21531c3457
("microblaze/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE") in

>  arch/m68k/include/asm/mcf_pgtable.h   |  4 +--

What is this m68k change doing here?
Sorry for not noticing this earlier.

Furthermore, several things below look strange to me...

>  arch/microblaze/include/asm/pgtable.h | 45 +++++++++++++++++++++------
>  2 files changed, 37 insertions(+), 12 deletions(-)
>
> diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
> index 3f8f4d0e66dd..e573d7b649f7 100644
> --- a/arch/m68k/include/asm/mcf_pgtable.h
> +++ b/arch/m68k/include/asm/mcf_pgtable.h
> @@ -46,8 +46,8 @@
>  #define _CACHEMASK040          (~0x060)
>  #define _PAGE_GLOBAL040                0x400   /* 68040 global bit, used for kva descs */
>
> -/* We borrow bit 7 to store the exclusive marker in swap PTEs. */
> -#define _PAGE_SWP_EXCLUSIVE    0x080
> +/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
> +#define _PAGE_SWP_EXCLUSIVE    CF_PAGE_NOCACHE

CF_PAGE_NOCACHE is 0x80, so this is still bit 7, thus the new comment
is wrong?

>
>  /*
>   * Externally used page protection values.
> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
> index 42f5988e998b..7e3de54bf426 100644
> --- a/arch/microblaze/include/asm/pgtable.h
> +++ b/arch/microblaze/include/asm/pgtable.h
> @@ -131,10 +131,10 @@ extern pte_t *va_to_pte(unsigned long address);
>   * of the 16 available.  Bit 24-26 of the TLB are cleared in the TLB
>   * miss handler.  Bit 27 is PAGE_USER, thus selecting the correct
>   * zone.
> - * - PRESENT *must* be in the bottom two bits because swap cache
> - * entries use the top 30 bits.  Because 4xx doesn't support SMP
> - * anyway, M is irrelevant so we borrow it for PAGE_PRESENT.  Bit 30
> - * is cleared in the TLB miss handler before the TLB entry is loaded.
> + * - PRESENT *must* be in the bottom two bits because swap PTEs use the top
> + * 30 bits.  Because 4xx doesn't support SMP anyway, M is irrelevant so we
> + * borrow it for PAGE_PRESENT.  Bit 30 is cleared in the TLB miss handler
> + * before the TLB entry is loaded.

So the PowerPC 4xx comment is still here?

>   * - All other bits of the PTE are loaded into TLBLO without
>   *  * modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
>   * software PTE bits.  We actually use bits 21, 24, 25, and
> @@ -155,6 +155,9 @@ extern pte_t *va_to_pte(unsigned long address);
>  #define _PAGE_ACCESSED 0x400   /* software: R: page referenced */
>  #define _PMD_PRESENT   PAGE_MASK
>
> +/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
> +#define _PAGE_SWP_EXCLUSIVE    _PAGE_DIRTY

_PAGE_DIRTY is 0x80, so this is also bit 7, thus the new comment is
wrong?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
