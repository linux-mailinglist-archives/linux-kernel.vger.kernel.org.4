Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AE76FBA44
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjEHVwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjEHVws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:52:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235A8422A;
        Mon,  8 May 2023 14:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=eRQGnZvNHAr7ZLmQ2c/n160+Xuj4wnfU8/X1ZrpT+os=; b=bzbCx8ugyvY+QOYywH7H37/+g2
        L3UlTqZW4KEM6EjuOdAfAU9Clp7mjXnEOgUUQ52/5zLYoeSyG1mVamDlE4ZmxQBbkk5oAaHlr/YQD
        jcVjXjqh+lvf1A7HdoLOIt11lp6coTQeTsfl1lZMJ/tXzABh2bohq0wr4Br3GWKXwkFc01y1X0zOX
        aSvz7xjzo1gA1P96FZqIRKqmVblm40fIVzM11Fa8VoE3+27G7tS5PDYsfR7f8tATYEglIgJx40eVL
        463E8gCJm4q5Nu8exndie2IYIGB8uVSEC/4SfWlYim5/J0N69aTSVni9d0c76uX+XYfhBHa0bwmYQ
        NaCs/FLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pw8ma-00EXAU-Mn; Mon, 08 May 2023 21:52:36 +0000
Date:   Mon, 8 May 2023 22:52:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Ruihan Li <lrh2000@pku.edu.cn>,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: usbdev_mmap causes type confusion in page_table_check
Message-ID: <ZFlvJEfs1ufh1UUD@casper.infradead.org>
References: <000000000000258e5e05fae79fc1@google.com>
 <20230507135844.1231056-1-lrh2000@pku.edu.cn>
 <CA+CK2bBe2YKYM3rUTCnZ0RF=NFUR9VqO-QYn3ygPsFJWLY1MUA@mail.gmail.com>
 <ZFlrbDft1QfMyIDc@casper.infradead.org>
 <CA+CK2bDVjovwB9v-Zv4Fn7EUfp5FV2XK36iJKYKY7pYNOFfOGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDVjovwB9v-Zv4Fn7EUfp5FV2XK36iJKYKY7pYNOFfOGA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 02:48:59PM -0700, Pasha Tatashin wrote:
> On Mon, May 8, 2023 at 2:36 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, May 08, 2023 at 05:27:10PM -0400, Pasha Tatashin wrote:
> > > > static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
> > > >                                  unsigned long pfn, unsigned long pgcnt,
> > > >                                  bool rw)
> > > > {
> > > >         // ...
> > > >         anon = PageAnon(page);
> > > >         for (i = 0; i < pgcnt; i++) {
> > > >                 // ...
> > > >                 if (anon) {
> > > >                         BUG_ON(atomic_read(&ptc->file_map_count));
> > > >                         BUG_ON(atomic_inc_return(&ptc->anon_map_count) > 1 && rw);
> > > >                 } else {
> > > >                         BUG_ON(atomic_read(&ptc->anon_map_count));
> > > >                         BUG_ON(atomic_inc_return(&ptc->file_map_count) < 0);
> > > >                 }
> > > >                 // ...
> > > >         }
> > > >         // ...
> > > > }
> > > >
> > > > This call to PageAnon is invalid for slab pages because slab reuses the bits
> > > > in struct page/folio to store its internal states, and the anonymity bit only
> > > > exists in struct page/folio. As a result, the counters are incorrectly updated
> > > > and checked in page_table_check_set and page_table_check_clear, leading to the
> > > > bug being raised.
> > >
> > > We should change anon boolean to be:
> > >
> > > anon = !PageSlab(page) && PageAnon(page);
> >
> > No.  Slab pages are not elegible for mapping into userspace.  That's
> 
> Sure, I can add BUG_ON(PageSlab(page)); to page_table_check_set.
> 
> > all.  There should be a BUG() for that.  And I do mean BUG(), not
> > "return error to user".  Something has gone horribly wrong, and it's
> > time to crash.
> 
>  It is just too easy to make slab available via remap_pfn_range(), but
> I do not think we want to add BUG() into the remap function, otherwise
> we will break devices such as /dev/mem.

Slab pages can't be mmaped.  Really, no matter what interface you're
using.  page->_mapcount is necessarily incremented by mapping to
userspace, and slab uses that space for its own purposes (and has
for decades).  It's similar for page tables and other allocations that
use PageType.
