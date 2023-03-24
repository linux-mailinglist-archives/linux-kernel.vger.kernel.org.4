Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939DE6C763A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCXDan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCXDal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:30:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B263B18AB9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 20:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=5HhTrG9WcEQAcau8U0gWMW/XrW+irv7dgvDxj7LMXiI=; b=RvtSOW0rmTphxl0QHdUuMRLfxA
        MVbWm4euMSexZgthyfOOjs5NnDNFFuwYQzrClXzhEIi1/CHbbOYlAgEp12LFvmVSeM6p+0sC45qv+
        MmhtYIwDHpFai/J0QNRGn9Tx40uWmD0tO0oDq9ti6CiKalBL+XwSjvy3P9vRP1xOCiO6WIFOcqcHR
        UZKyS0m+etof/p/S7mwvpjtqLEjVhwFR8creVzx4T+qf7Lf4W2B6ibMgAoGPjfgiTgpelheJ6o502
        hJf4/Dm3Yg1zZ/aeiov2u+2OS/O/pxMyQH6RIlcnQCrVISap107u7f+Pxp/8+CNJa6FeEawG1PluM
        6ahb9Apw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfY8A-004X9T-Tg; Fri, 24 Mar 2023 03:30:19 +0000
Date:   Fri, 24 Mar 2023 03:30:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Song Liu <song@kernel.org>, Song Liu <songliubraving@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] mm/khugepaged: maintain page cache uptodate flag
Message-ID: <ZB0ZSqw1TTp3/ec3@casper.infradead.org>
References: <20230307052036.1520708-1-stevensd@google.com>
 <20230307052036.1520708-4-stevensd@google.com>
 <866d1a75-d462-563-dfd7-1aa2971a285b@google.com>
 <ZBzK99dSmbPB7vjA@casper.infradead.org>
 <CAPhsuW5pTh2+S7VjRbRy=WUAb7-GLQpi6HKCW0ehxs5HAup_dQ@mail.gmail.com>
 <b49b118d-893c-c749-61f6-9441539418a5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b49b118d-893c-c749-61f6-9441539418a5@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 06:56:34PM -0700, Hugh Dickins wrote:
> On Thu, 23 Mar 2023, Song Liu wrote:
> > On Thu, Mar 23, 2023 at 2:56 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Mar 23, 2023 at 12:07:46PM -0700, Hugh Dickins wrote:
> > > > On an earlier audit, for different reasons, I did also run across
> > > > lib/buildid.c build_id_parse() using find_get_page() without checking
> > > > PageUptodate() - looks as if it might do the wrong thing if it races
> > > > with khugepaged collapsing text to huge, and should probably have a
> > > > similar fix.
> > >
> > > That shouldn't be using find_get_page().  It should probably use
> > > read_cache_folio() which will actually read in the data if it's not
> > > present in the page cache, and return an ERR_PTR if the data couldn't
> > > be read.
> > 
> > build_id_parse() can be called from NMI, so I don't think we can let
> > read_cache_folio() read-in the data.
> 
> Interesting.
> 
> This being the same Layering_Violation_ID which is asking for a home in
> everyone's struct file?  (Okay, I'm being disagreeable, no need to answer!)

Yes, that's the one.  Part of the BPF "splatter stuff all across the
kernel that we don't really understand" (see, I can be just as
disagreeable!)

> I think even the current find_get_page() is unsafe from NMI: imagine that
> NMI interrupting a sequence (maybe THP collapse or splitting, maybe page
> migration, maybe others) when the page refcount has been frozen to 0:
> you'll just have to reboot the machine?

Correct; if it's been frozen by this CPU, we'll spin forever.  I think
the other conditions where we retry are temporary and caused by
something _another_ CPU is doing.  For example, if _this_ CPU is in the
middle of modifying the tree when an NMI happens, we won't hit the
xas_retry() case.  That can only happen if we've observed something
another CPU did, and then a second write happened from that same other
CPU.  The easiest example of that would be that we hit this kind of
race:

CPU 0				CPU 1
load root of tree, points to node
				store entry in root of tree
				wmb();
				store RETRY entry in node
load entry from node, observe RETRY entry

The retry will happen and we'll observe the new state of the tree with
the entry we're looking for in the root.

If CPU 1 takes an NMI and interrupts itself, it will always see a
consistent tree.

> I guess the RCU-safety of find_get_page() implies that its XArray basics
> are safe in NMI; but you need a low-level variant (xas_find()?) which
> does none of the "goto retry"s, and fails immediately if anything is
> wrong - including !PageUptodate.

The Uptodate flag check needs to be done by the caller; the
find_get_page() family return !uptodate pages.

But find_get_page() does not advertise itself as NMI-safe.  And I
think it's wrong to try to make it NMI-safe.  Most of the kernel is
not NMI-safe.  I think it's incumbent on the BPF people to get the
information they need ahead of taking the NMI.  NMI handlers are not
supposed to be doing a huge amount of work!  I don't really understand
why it needs to do work in NMI context; surely it can note the location of
the fault and queue work to be done later (eg on irq-enable, task-switch
or return-to-user)

