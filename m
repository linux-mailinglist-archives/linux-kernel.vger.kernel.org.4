Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E6D64E355
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLOVjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLOVjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:39:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F91B2BB10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671140340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9NacCVxVJ3GJc/ioljESemL+AiTK9QAc3Zi0dYSUUF0=;
        b=aZooEvK5X7IcbPy/b4Bm46TIVCPMLYM2RoI/WOBl89hkudbjOl0wfqxrJ9LkhzMCIdTb+9
        8v1I4bqkV3aclPh1CSw0OuXEobCUHzpX3HgWYaOr60O7TH+Y7lJwIoCzDKojBrE5xbdf0D
        rd1h+qQa+/tfn+IVNbM3RU86u0j5/KM=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-658-YDDdDVNrOSSxFRxLlAg-Nw-1; Thu, 15 Dec 2022 16:38:56 -0500
X-MC-Unique: YDDdDVNrOSSxFRxLlAg-Nw-1
Received: by mail-yb1-f198.google.com with SMTP id x188-20020a2531c5000000b00716de19d76bso271688ybx.19
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 13:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NacCVxVJ3GJc/ioljESemL+AiTK9QAc3Zi0dYSUUF0=;
        b=CIHHYVdFCyXG8r6SD9dzNuCwkzlxqVFVs6Y918mtHuZsPmAmw6p124W0n7sTpuic/W
         aNSYfrJbqaq0VR8jrVS9weo7bQCqMJEBRdTodk6maT54g5JpjfsVMvb/XGJlzMBNwEF3
         GYP1iy8HQemCsvvJ0cHaqlp1dXg6BR0hXN2CP0uN4z0AYEn/i7DadIYiP1PQq5Uv09CY
         XNOAhwuPSAJH5i1aIITcipeqx1fuMEyY4zrSnxfJhHOLUI+DyyKXmcgInO+Ftyea1Jro
         gReYvkwPd0OwUNW87Z0lia+dhOPqZ9pAG/MuwB9hya611d7t3y/yOf+U1yZW2BhLF1ew
         qRaQ==
X-Gm-Message-State: ANoB5pkmEV2XanGFTlmtVf4npoXgH4O6OEQE1o9vRJaUcH6eDrbddrSW
        kD1mNL9mOgIGveNgAwSWi0NewxUH+1O3X+U7+Lz6tHHU0U9dm16WaNh7qegGU0IN4TDkUpk4OE+
        cAHZBM/AYV5TZ54H0u+WH5lVPDqOz0k7idgv2ng0V
X-Received: by 2002:a0d:f287:0:b0:3c5:af7:5646 with SMTP id b129-20020a0df287000000b003c50af75646mr2091756ywf.320.1671140335063;
        Thu, 15 Dec 2022 13:38:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf65wJjV8B6XKPgEspTDQNHLYOYYw21NzWvJ6gEgmFI94zhjEAJTBrboFIDQ1LE+J1gXFbxgmBP0BbxnMKK+oeM=
X-Received: by 2002:a0d:f287:0:b0:3c5:af7:5646 with SMTP id
 b129-20020a0df287000000b003c50af75646mr2091750ywf.320.1671140334741; Thu, 15
 Dec 2022 13:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20221213234505.173468-1-npache@redhat.com> <Y5oCD0gFV+Cq1JqJ@casper.infradead.org>
 <CAA1CXcA2dGeG2tzc+-OZ77eMVpnSN2SKkdtz9LqpLPywhJMOwA@mail.gmail.com>
In-Reply-To: <CAA1CXcA2dGeG2tzc+-OZ77eMVpnSN2SKkdtz9LqpLPywhJMOwA@mail.gmail.com>
From:   Nico Pache <npache@redhat.com>
Date:   Thu, 15 Dec 2022 14:38:28 -0700
Message-ID: <CAA1CXcCboCaVNgLv56Pc9ju95Yc9cK4XHCQObGPA_fbVZGxtTg@mail.gmail.com>
Subject: Re: [RFC V2] mm: add the zero case to page[1].compound_nr in set_compound_order
To:     Matthew Wilcox <willy@infradead.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, gerald.schaefer@linux.ibm.com,
        Waiman Long <llong@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 7:48 PM Nico Pache <npache@redhat.com> wrote:
>
> On Wed, Dec 14, 2022 at 10:04 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Dec 13, 2022 at 04:45:05PM -0700, Nico Pache wrote:
> > > Since commit 1378a5ee451a ("mm: store compound_nr as well as
> > > compound_order") the page[1].compound_nr must be explicitly set to 0 if
> > > calling set_compound_order(page, 0).
> > >
> > > This can lead to bugs if the caller of set_compound_order(page, 0) forgets
> > > to explicitly set compound_nr=0. An example of this is commit ba9c1201beaa
> > > ("mm/hugetlb: clear compound_nr before freeing gigantic pages")
> > >
> > > Collapse these calls into the set_compound_order by utilizing branchless
> > > bitmaths [1].
> > >
> > > [1] https://graphics.stanford.edu/~seander/bithacks.html#ConditionalSetOrClearBitsWithoutBranching
> > >
> > > V2: slight changes to commit log and remove extra '//' in the comments
> >
> > We don't usually use // comments anywhere in the kernel other than
> > the SPDX header.
>
> Whoops!
>
> > >  static inline void set_compound_order(struct page *page, unsigned int order)
> > >  {
> > > +     unsigned long shift = (1U << order);
> >
> > Shift is a funny name for this variable.  order is the shift.  this is 'nr'.
>
> Good point! Waiman found an even better/cleaner solution that would
> avoid needing an extra variable.
>     page[1].compound_nr = (1U << order) & ~1U;
>
> > >       page[1].compound_order = order;
> > >  #ifdef CONFIG_64BIT
> > > -     page[1].compound_nr = 1U << order;
> > > +     // Branchless conditional:
> > > +     // order  > 0 --> compound_nr = shift
> > > +     // order == 0 --> compound_nr = 0
> > > +     page[1].compound_nr = shift ^ (-order  ^ shift) & shift;
> >
> > Can the compiler see through this?  Before, the compiler sees:
> >
> >         page[1].compound_order = 0;
> >         page[1].compound_nr = 1U << 0;
> > ...
> >         page[1].compound_nr = 0;
> >
> > and it can eliminate the first store.
>
> This may be the case at the moment, but with:
> https://lore.kernel.org/linux-mm/20221213212053.106058-1-sidhartha.kumar@oracle.com/
> we will have a branch instead. Sidhartha tested it and found no
> regression; the concern is that if THPs get implemented using this
> callpath then we may end up seeing a slowdown.
>
> After doing my analysis below I dont think this is the case for the
> destroy case(at least on x86).
> In the destroy case for both the branch and branchless approach we see
> the compiler optimizing away the bitmath and the branch and setting
> the variable to zero.
> In the prep case we see the introduction of a test and cmovne
> instruction, implying a branch.
>
> > Now the compiler sees:
> >         unsigned long shift = (1U << 0);
> >         page[1].compound_order = order;
> >         page[1].compound_nr = shift ^ (0  ^ shift) & shift;
> >
> > Does it do the maths at compile-time, knowing that order is 0 at this
> > callsite and deducing that it can just store a 0?
> >
> > I think it might, since shift is constant-1,
> >
> >         page[1].compound_nr = 1 ^ (0 ^ 1) & 1;
> > ->      page[1].compound_nr = 1 ^ 1 & 1;
> > ->      page[1].compound_nr = 0 & 1;
> > ->      page[1].compound_nr = 0;
> >
> > But you should run it through the compiler and check the assembly
> > output for __destroy_compound_gigantic_page().
>
> Yep it does look like it gets optimized away for the destroy case:
>
> Bitmath Case (destroy)
> ---------------------------------
> Dump of assembler code for function __update_and_free_page:
> ...
> mov    %rsi,%rbp //move 2nd arg (page) to rbp
> ...
> movb   $0x0,0x51(%rbp) //page[1].compound_order = 0
> movl   $0x0,0x5c(%rbp)  //page[1].compound_nr = 0
> ...
>
> Math for movl : 0x5c (92) - 64 (sizeof page[0]) = 28
> pahole page: unsigned int compound_nr;        /*    28     4 */
>
> Bitmath Case (prep)
> ---------------------------------
> In the case of prep_compound_gigantic_page the bitmath is being computed
>    0xffffffff8134f17d <+13>:    mov    %rdi,%r12
>    0xffffffff8134f180 <+16>:    push   %rbp
>    0xffffffff8134f181 <+17>:    mov    $0x1,%ebp
>    0xffffffff8134f186 <+22>:    shl    %cl,%ebp
>    0xffffffff8134f188 <+24>:    neg    %ecx
>    0xffffffff8134f18a <+26>:    push   %rbx
>    0xffffffff8134f18b <+27>:    and    %ebp,%ecx
>    0xffffffff8134f18d <+29>:    mov    %sil,0x51(%rdi)
>    0xffffffff8134f191 <+33>:    mov    %ecx,0x5c(%rdi) //set page[1].compound_nr
>
> Now to break down the approach with the branch:
>
> Branch Case (destroy)
> ---------------------------------
>   No branch utilized to determine the following instructions.
>    0xffffffff813507bc <+236>:    movb   $0x0,0x51(%rbp)
>    0xffffffff813507c0 <+240>:    movl   $0x0,0x5c(%rbp)
>
> Branch  Case (prep)
> ---------------------------------
> The branch is being computed with the introduction of a cmovne instruction.
>    0xffffffff8134f15d <+13>:    mov    %rdi,%r12
>    0xffffffff8134f160 <+16>:    push   %rbp
>    0xffffffff8134f161 <+17>:    mov    $0x1,%ebp
>    0xffffffff8134f166 <+22>:    shl    %cl,%ebp
>    0xffffffff8134f168 <+24>:    test   %esi,%esi             //test
>    0xffffffff8134f16a <+26>:    push   %rbx
>    0xffffffff8134f16b <+27>:    cmovne %ebp,%ecx     //branch evaluation
>    0xffffffff8134f16e <+30>:    mov    %sil,0x51(%rdi)
>    0xffffffff8134f172 <+34>:    mov    %ecx,0x5c(%rdi)
>
To expand a little more on the analysis:
I computed the latency/throughput between <+24> and <+27> using
intel's manual (APPENDIX D):

The bitmath solutions shows a total latency of 2.5 with a Throughput of 0.5.
The branch solution show a total latency of 4 and throughput of 1.5.

Given this is not a tight loop, and the next instruction is requiring
the data computed, better (lower) latency is the more ideal situation.

Just wanted to add that little piece :)
 -- Nico

> So it looks like in the destruction of compound pages we'll see no
> gain or loss between the bitmath or branch approach.
> However, in the prep case we may see some performance loss once/if THP
> utilizes this path due to the branch and the loss of CPU
> parallelization that can be achieved utilizing the bitmath approach.
>
> Cheers,
> -- Nico

