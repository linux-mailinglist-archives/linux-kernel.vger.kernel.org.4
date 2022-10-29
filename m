Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA909612560
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 23:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJ2VA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 17:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJ2VAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 17:00:40 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27D529CBA
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 14:00:38 -0700 (PDT)
Received: from letrec.thunk.org ([142.44.75.242])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 29TKxXms024528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Oct 2022 16:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1667077177; bh=EZKkqCeXaLZ8T9HRw8I9LaqHcaQSMf+IL4bg8ajaLlA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KoosaJyX9zI91btp1+85K5o0uLnH71GTcXpZSBZDpk8b5H7h6kosS66F3YxoZx4Gi
         hOVJ3m4IJavsFvBREuh97JJA27i8y/cTE/plnmn9v9cz6PUx0kRjvUH/5iesCB/HCN
         cauIMA+3IPh9edqP0VH08VGbdfOxp6HR0SdLG8LefJ9BdhQF677+EwFuHDFpHv0FMh
         ll0+Ez0otlvNHLVX1Dw9+AbPeFjih5XCvTh658w7Tpuk0dIaOrgM7YbWmRQ6PneIA0
         iZ7Z5NU0FHqd7ckaIQ9aCmRkA832CDKASCRoS5oTm0qp5Z8/XOsJpd+htkUVXi9Nbm
         Did1wMpw2oVtQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 3AC608C29FD; Sat, 29 Oct 2022 16:59:30 -0400 (EDT)
Date:   Sat, 29 Oct 2022 16:59:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
Message-ID: <Y12UMjHOw9ZBaNMv@mit.edu>
References: <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com>
 <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com>
 <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com>
 <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <3a57cfc5-5db4-bdc9-1ddf-5305a37ffa62@nvidia.com>
 <CAHk-=wj6EJvTtTeYQvkX3aOw6Q1SRYRV6xJP1+uHNvfAocO1hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj6EJvTtTeYQvkX3aOw6Q1SRYRV6xJP1+uHNvfAocO1hw@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 01:15:26PM -0700, Linus Torvalds wrote:
> On Sat, Oct 29, 2022 at 12:39 PM John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > ext4 has since papered over the problem, by soldiering on if it finds a
> > page without writeback buffers when it expected to be able to writeback
> > a dirty page. But you get the idea.
> 
> I suspect that "soldiering on" is the right thing to do, but yes, our
> 'mkdirty' vs 'mkclean' thing has always been problematic.
>
> ...
>
>  (a) filesystems just deal with it

It should be noted that "soldiering on" just means that the kernel
will not crash or BUG.  It may mean that the dirty page will not
gotten written back (since at the time when it is discovered we are in
a context we may not allocate memory or block if there is a need to
allocate blocks if the file system uses delayed allocation).

Furthermore, since the file system does not know that one or more
pages have dirtied behind it's back, if the file system is almost
full, some writes may silently fail --- including writes where the
usesrspace application was implicitly promised that the write would
succeed by having the write(2) system call return without errors.

If people are OK with that, it's fine.  Just don't complain to the
file system maintainers.  :-)

						- Ted

P.S.  The reason why this isn't an utter disaster is because normally
users of remote RMA use preallocated and pre-written/initialized
files.  And there aren't _that_ many other users of gup.  So long as
this remains the case, we might be happy to let sleeping canines lie.
Just please dear $DEITY, let's not have any additional users of gup
until we have a better solution.
