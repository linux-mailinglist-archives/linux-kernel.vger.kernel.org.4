Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76866A44EE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjB0Onb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjB0On0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:43:26 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13BE1C324;
        Mon, 27 Feb 2023 06:43:24 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id h19so6801818qtk.7;
        Mon, 27 Feb 2023 06:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtpzGlheMp9cWEjldclbCx07Trvxzhn2kfeNTxmqNPE=;
        b=0d7VzSbB2QjcM+JwGWlY0L+Tm/Mq0TXhQL1cMGRM4qIDS6UoQhqUFagmrx9B1sRbuT
         mDg9ZV0LX1nY6PrAAPOlT6jfEYzkZKvx+OurAeQmoBF3zQCHom473kB+R1Kssr/oWz1R
         RC8gC4bYJlMEqOefYRcdbrBjISh4PX8d7DrHS/oeqZgRIz/qN/6WL9U3ZuOKzXHPP9xY
         9a3iHVZeAdKhztTwC2Qlpd/Yt8G2QoMASvFwFvG6QZD7troqVrDRluBANMtEhE9A1+m5
         lf/GeRX6/exFnRMILBCtZmFTnviOwcHcsp18ZXdZGuu29iwcdD5b54gYfMUewkMDxdSe
         CimQ==
X-Gm-Message-State: AO0yUKXd4xD+GQ8XtKsHQSCA+xUk4FvrytcTXwsKAIBx7sTs7Q5USl5M
        0U8ZP5PBdDBKcWX71YCnwl0eir7Udc3Hfg==
X-Google-Smtp-Source: AK7set9We5Z0vLSftO4T5muTMknh9wYOTcj1wk7DuXbVXu+PLfyQO+2DEknsnL2f4afmUh7ilVhu/g==
X-Received: by 2002:a05:622a:452:b0:3b9:f4a0:e600 with SMTP id o18-20020a05622a045200b003b9f4a0e600mr46133365qtx.60.1677509003534;
        Mon, 27 Feb 2023 06:43:23 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id bm26-20020a05620a199a00b007424376ca4bsm5056781qkb.18.2023.02.27.06.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 06:43:22 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-536cb25982eso180866447b3.13;
        Mon, 27 Feb 2023 06:43:21 -0800 (PST)
X-Received: by 2002:a81:ad43:0:b0:533:91d2:9d94 with SMTP id
 l3-20020a81ad43000000b0053391d29d94mr10571733ywk.5.1677509001567; Mon, 27 Feb
 2023 06:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20230113171026.582290-1-david@redhat.com> <20230113171026.582290-12-david@redhat.com>
 <CAMuHMdX-FDga8w=pgg1myskEx6wp+oyZifhPPPFnWrc1zW7ZpQ@mail.gmail.com> <9ed766a6-cf06-535d-3337-ea6ff25c2362@redhat.com>
In-Reply-To: <9ed766a6-cf06-535d-3337-ea6ff25c2362@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Feb 2023 15:43:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWSaoKqO1Nx7QMDCcXrRmFbqqX8uwDRezXs8g+HdEFjKA@mail.gmail.com>
Message-ID: <CAMuHMdWSaoKqO1Nx7QMDCcXrRmFbqqX8uwDRezXs8g+HdEFjKA@mail.gmail.com>
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

On Mon, Feb 27, 2023 at 2:31 PM David Hildenbrand <david@redhat.com> wrote:
> On 26.02.23 21:13, Geert Uytterhoeven wrote:
> > On Fri, Jan 13, 2023 at 6:16 PM David Hildenbrand <david@redhat.com> wrote:
> >> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit
> >> from the type. Generic MM currently only uses 5 bits for the type
> >> (MAX_SWAPFILES_SHIFT), so the stolen bit is effectively unused.
> >>
> >> The shift by 2 when converting between PTE and arch-specific swap entry
> >> makes the swap PTE layout a little bit harder to decipher.
> >>
> >> While at it, drop the comment from paulus---copy-and-paste leftover
> >> from powerpc where we actually have _PAGE_HASHPTE---and mask the type in
> >> __swp_entry_to_pte() as well.
> >>
> >> Cc: Michal Simek <monstr@monstr.eu>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >
> > Thanks for your patch, which is now commit b5c88f21531c3457
> > ("microblaze/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE") in
> >
>
> Right, it went upstream, so we can only fixup.
>
> >>   arch/m68k/include/asm/mcf_pgtable.h   |  4 +--
> >
> > What is this m68k change doing here?
> > Sorry for not noticing this earlier.
>
> Thanks for the late review, still valuable :)
>
> That hunk should have gone into the previous patch, looks like I messed
> that up when reworking.
>
> >
> > Furthermore, several things below look strange to me...
> >
> >>   arch/microblaze/include/asm/pgtable.h | 45 +++++++++++++++++++++------
> >>   2 files changed, 37 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
> >> index 3f8f4d0e66dd..e573d7b649f7 100644
> >> --- a/arch/m68k/include/asm/mcf_pgtable.h
> >> +++ b/arch/m68k/include/asm/mcf_pgtable.h
> >> @@ -46,8 +46,8 @@
> >>   #define _CACHEMASK040          (~0x060)
> >>   #define _PAGE_GLOBAL040                0x400   /* 68040 global bit, used for kva descs */
> >>
> >> -/* We borrow bit 7 to store the exclusive marker in swap PTEs. */
> >> -#define _PAGE_SWP_EXCLUSIVE    0x080
> >> +/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
> >> +#define _PAGE_SWP_EXCLUSIVE    CF_PAGE_NOCACHE
> >
> > CF_PAGE_NOCACHE is 0x80, so this is still bit 7, thus the new comment
> > is wrong?
>
> You're right, it's still bit 7 (and we use LSB-0 bit numbering in that
> file). I'll send a fixup.

OK.

> >>   /*
> >>    * Externally used page protection values.
> >> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
> >> index 42f5988e998b..7e3de54bf426 100644
> >> --- a/arch/microblaze/include/asm/pgtable.h
> >> +++ b/arch/microblaze/include/asm/pgtable.h
> >> @@ -131,10 +131,10 @@ extern pte_t *va_to_pte(unsigned long address);
> >>    * of the 16 available.  Bit 24-26 of the TLB are cleared in the TLB
> >>    * miss handler.  Bit 27 is PAGE_USER, thus selecting the correct
> >>    * zone.
> >> - * - PRESENT *must* be in the bottom two bits because swap cache
> >> - * entries use the top 30 bits.  Because 4xx doesn't support SMP
> >> - * anyway, M is irrelevant so we borrow it for PAGE_PRESENT.  Bit 30
> >> - * is cleared in the TLB miss handler before the TLB entry is loaded.
> >> + * - PRESENT *must* be in the bottom two bits because swap PTEs use the top
> >> + * 30 bits.  Because 4xx doesn't support SMP anyway, M is irrelevant so we
> >> + * borrow it for PAGE_PRESENT.  Bit 30 is cleared in the TLB miss handler
> >> + * before the TLB entry is loaded.
> >
> > So the PowerPC 4xx comment is still here?
>
> I only dropped the comment above __swp_type(). I guess you mean that we
> could also drop the "Because 4xx doesn't support SMP anyway, M is
> irrelevant so we borrow it for PAGE_PRESENT." sentence, correct? Not

Yes, that's what I meant.

> sure about the "Bit 30 is cleared in the TLB miss handler" comment, if
> that can similarly be dropped.

No idea, didn't check. But if it was copied from PPC, chances are
high it's no longer true....

> >>    * - All other bits of the PTE are loaded into TLBLO without
> >>    *  * modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
> >>    * software PTE bits.  We actually use bits 21, 24, 25, and
> >> @@ -155,6 +155,9 @@ extern pte_t *va_to_pte(unsigned long address);
> >>   #define _PAGE_ACCESSED 0x400   /* software: R: page referenced */
> >>   #define _PMD_PRESENT   PAGE_MASK
> >>
> >> +/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
> >> +#define _PAGE_SWP_EXCLUSIVE    _PAGE_DIRTY
> >
> > _PAGE_DIRTY is 0x80, so this is also bit 7, thus the new comment is
> > wrong?
>
> In the example, I use MSB-0 bit numbering (which I determined to be
> correct in microblaze context eventually, but I got confused a couple a
> times because it's very inconsistent). That should be MSB-0 bit 24.

Thanks, TIL microblaze uses IBM bit numbering...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
