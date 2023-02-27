Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D936A4B80
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjB0TrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjB0TrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:47:16 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EA028202;
        Mon, 27 Feb 2023 11:46:48 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id w23so8016473qtn.6;
        Mon, 27 Feb 2023 11:46:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgbfP6t1iEXlYeQDHgpgkGKrmlu/wPbkfmiZJDZsq5c=;
        b=PeklCc/BUNFCM4ElJPmsx7n8MV2Iwl7q5/6ZPW3lCqlV0dMVC71bUn6ySKhihacRzX
         IhLjkT0taaowmeHkjhqcFjY42CZF3KDVUY920L/intcsjFkVCc92QmU6ESE91dLH9qqs
         V3sLiIIK128WszIJ9B7tbufuqevD12qezThCbonkuk3CPRtE9KNzSf+rSsBX0KMmXCT3
         +Yjkpx/NDjxKtTNEsS7Lw4xz/pqZVVRInUsB7OPGfgDt+AWZsfiYWcwVyZRQoHcUkzDM
         zBLMNGBSVhgNGmNAK4cWhJW8rVsEcT3kNheHkBquP/cEltZS6iHTNcLNoBthBFvRZfmE
         406w==
X-Gm-Message-State: AO0yUKU2kiVR8Z6e10D3Yg2rJy4ajsfSR3Icpd5EZkzuMmyjFb/fVh/f
        9rbA4MyhoEEmv4O+n6cUCizaH3lW93uHzw==
X-Google-Smtp-Source: AK7set/pQ6JDnl+0gvg72l8iO9kyYF90JvlZkNPQjMM+HJ4miR7SQEsMKDfQzYgWmCLw7AgxTXFqhg==
X-Received: by 2002:a05:622a:50:b0:3bf:ce27:e1fc with SMTP id y16-20020a05622a005000b003bfce27e1fcmr1053059qtw.7.1677527206826;
        Mon, 27 Feb 2023 11:46:46 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id s184-20020a372cc1000000b0073bb00eb0besm5463580qkh.22.2023.02.27.11.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 11:46:45 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-536cb25982eso206302047b3.13;
        Mon, 27 Feb 2023 11:46:45 -0800 (PST)
X-Received: by 2002:a5b:d4e:0:b0:967:f8b2:7a42 with SMTP id
 f14-20020a5b0d4e000000b00967f8b27a42mr7816406ybr.7.1677527205039; Mon, 27 Feb
 2023 11:46:45 -0800 (PST)
MIME-Version: 1.0
References: <20230113171026.582290-1-david@redhat.com> <20230113171026.582290-12-david@redhat.com>
 <CAMuHMdX-FDga8w=pgg1myskEx6wp+oyZifhPPPFnWrc1zW7ZpQ@mail.gmail.com>
 <9ed766a6-cf06-535d-3337-ea6ff25c2362@redhat.com> <CAMuHMdWSaoKqO1Nx7QMDCcXrRmFbqqX8uwDRezXs8g+HdEFjKA@mail.gmail.com>
 <c145a2db-f92c-65aa-3e68-07dbb2e097a6@redhat.com>
In-Reply-To: <c145a2db-f92c-65aa-3e68-07dbb2e097a6@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Feb 2023 20:46:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX7MND++KXgTpx4jscfctQA_-zPt3EN9-+79EWE7e+OjA@mail.gmail.com>
Message-ID: <CAMuHMdX7MND++KXgTpx4jscfctQA_-zPt3EN9-+79EWE7e+OjA@mail.gmail.com>
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

On Mon, Feb 27, 2023 at 6:01 PM David Hildenbrand <david@redhat.com> wrote:
> >>>>    /*
> >>>>     * Externally used page protection values.
> >>>> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
> >>>> index 42f5988e998b..7e3de54bf426 100644
> >>>> --- a/arch/microblaze/include/asm/pgtable.h
> >>>> +++ b/arch/microblaze/include/asm/pgtable.h

> >>>>     * - All other bits of the PTE are loaded into TLBLO without
> >>>>     *  * modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
> >>>>     * software PTE bits.  We actually use bits 21, 24, 25, and
> >>>> @@ -155,6 +155,9 @@ extern pte_t *va_to_pte(unsigned long address);
> >>>>    #define _PAGE_ACCESSED 0x400   /* software: R: page referenced */
> >>>>    #define _PMD_PRESENT   PAGE_MASK
> >>>>
> >>>> +/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
> >>>> +#define _PAGE_SWP_EXCLUSIVE    _PAGE_DIRTY
> >>>
> >>> _PAGE_DIRTY is 0x80, so this is also bit 7, thus the new comment is
> >>> wrong?
> >>
> >> In the example, I use MSB-0 bit numbering (which I determined to be
> >> correct in microblaze context eventually, but I got confused a couple a
> >> times because it's very inconsistent). That should be MSB-0 bit 24.
> >
> > Thanks, TIL microblaze uses IBM bit numbering...
>
> I assume IBM bit numbering corresponds to MSB-0 bit numbering, correct?

Correct, as seen in s370 and PowerPC manuals...

> I recall that I used the comment above "/* Definitions for MicroBlaze.
> */" as an orientation.
>
> 0  1  2  3  4  ... 18 19 20 21 22 23 24 25 26 27 28 29 30 31
> RPN.....................  0  0 EX WR ZSEL.......  W  I  M  G

Indeed, that's where I noticed the "unconventional" numbering...

> So ... either we adjust both or we leave it as is. (again, depends on
> what the right thing to to is -- which I don't know :) )

It depends whether you want to match the hardware documentation,
or the Linux BIT() macro and friends...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
