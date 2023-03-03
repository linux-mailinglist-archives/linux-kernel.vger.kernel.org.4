Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB646A9168
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCCHDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCCHDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:03:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7942B10403;
        Thu,  2 Mar 2023 23:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=/5WuhsRDIv/UuTU95tT5UESTyEJuE6jSQoLAmCreiRM=; b=BEh2bMP9VZ5HvOBAZKQFo9TxZl
        GWB9buvFTr/SNNnBAYV5RKgjZUPt1RlmR1MnmxsLqcd7NksUtXxSKH3pH0djkohdm4Nhj5mT2qjzL
        YIqPMoUSQrXvO9Znoz1O6Oc4Wb6jTmJHwJ/C3sDudvVYBlirKrQQ1Fo/UuPqhz+hm1X2yM/lOTrd4
        tXyVoFdh7Onnnc20CeFdN6H0BFicfgPa7/l4PMVXAeES3jEH2AObQeLWgf/hayxx+GGUQZiMPBM2m
        h1COHu5tOheOcup5Ox0q8wQiQE3iS2Dlu7o4LzTm7+vrmdLcM2d07Y+qVymAu2CZ8bR+yuyE0teL3
        4pMh4Ymw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXzS4-002wvW-7l; Fri, 03 Mar 2023 07:03:36 +0000
Date:   Fri, 3 Mar 2023 07:03:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com, arnd@arndb.de,
        linux-api@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v10 2/3] cachestat: implement cachestat syscall
Message-ID: <ZAGbyM8xnLKC/2uX@casper.infradead.org>
References: <20230219073318.366189-1-nphamcs@gmail.com>
 <20230219073318.366189-3-nphamcs@gmail.com>
 <Y/IUTiL03C9OOSFx@casper.infradead.org>
 <CAKEwX=M7HSzSF6GZ_Nv26FQv_j+5UD9FQ_v3CL4=a1q5epyvPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=M7HSzSF6GZ_Nv26FQv_j+5UD9FQ_v3CL4=a1q5epyvPA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 10:55:48PM -0800, Nhat Pham wrote:
> On Sun, Feb 19, 2023 at 4:21 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > +/**
> > > + * filemap_cachestat() - compute the page cache statistics of a mapping
> > > + * @mapping: The mapping to compute the statistics for.
> > > + * @first_index:     The starting page cache index.
> > > + * @last_index:      The final page index (inclusive).
> > > + * @cs:      the cachestat struct to write the result to.
> > > + *
> > > + * This will query the page cache statistics of a mapping in the
> > > + * page range of [first_index, last_index] (inclusive). The statistics
> > > + * queried include: number of dirty pages, number of pages marked for
> > > + * writeback, and the number of (recently) evicted pages.
> > > + */
> >
> > Do we care that this isn't going to work for hugetlbfs?
> 
> I ran a quick test using hugetlbfs. It looks like the current
> implementation is treating it in accordance to the multi-page
> folio case we discussed earlier, i.e:
> 
> - Returned number of "pages" is in terms of the number of
> base/small pages (i.e 512 dirty pages instead of 1 dirty
> huge page etc.)
> - If we touch one byte in the huge page, it would report the
> entire huge page as dirty, but again in terms of the underlying
> pages.
> 
> Is this what you have in mind, or is there another edge
> case that I'm missing...?

Hugetlbfs indexes its pages by hugepage number rather than by smallpage
number.  Imagine you have a 2MB folio at offset 4MB into the file.
Filesystems other than hugetlbfs store it at indices 1024-1535.
hugetlbfs stores it at index 2.

So your report probably seems to work, but if you ask it about a
range, you might be surprised by how wide that range will cover for
hugetlbfs.

I know Sidhartha is working on fixing that, but I'm not sure if what he
has is working yet.
