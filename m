Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7866081BF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJUWgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJUWgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:36:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819F42958D9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jbA5d1lgaEXO+4QZTUA12B0RXm0tJuHDtZjIwatPzE8=; b=WzRZvhoiPeuFx+Ec7xavHXmL6I
        QhQcgtDRrF5PBw/7kvFZCJswXRzKsLlQABCtobzCn/yxONSTGQWhBme6yr6kw/PmC0mdR9y+/nhJq
        3uezeZIgUBM0YN9vxWoL/aDw14iPyvv6P700i0SMq39tIQFAh+CifAGtxu7ueMhdeCFJy0DvTXnRv
        l4t3VhtKugTJh307PUCr3Kg5ifEVxXz7a09DE4Y2FxUjvJsGLkZ/FYjBiFj3NUwa/s2vy76VV2MBr
        Kye1NNsvFu4O7yOPrmssHGWcY5A6YID2l6yYZSYP4Lz6n3LSjO5OfyiXqqFczxLe4X9lxY0VtuMYW
        /IXCUwyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1om0cU-00DT4K-OP; Fri, 21 Oct 2022 22:36:03 +0000
Date:   Fri, 21 Oct 2022 23:36:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <yujie.liu@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        lkp@lists.01.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>
Subject: Re: [shmem] 7a7256d5f5: WARNING:possible_recursive_locking_detected
Message-ID: <Y1Me0pmC5LrzPAaY@casper.infradead.org>
References: <202210211215.9dc6efb5-yujie.liu@intel.com>
 <Y1KZ/NF5bNG1wykf@casper.infradead.org>
 <20221021133041.5811e1fb291eb6aaf122a59c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021133041.5811e1fb291eb6aaf122a59c@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:30:41PM -0700, Andrew Morton wrote:
> On Fri, 21 Oct 2022 14:09:16 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Fri, Oct 21, 2022 at 12:10:17PM +0800, kernel test robot wrote:
> > > FYI, we noticed WARNING:possible_recursive_locking_detected due to commit (built with gcc-11):
> > > 
> > > commit: 7a7256d5f512b6c17957df7f59cf5e281b3ddba3 ("shmem: convert shmem_mfill_atomic_pte() to use a folio")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > Ummm.  Looks to me like this now occurs because of this part of the
> > change:
> > 
> >                 if (!zeropage) {        /* COPY */
> > -                       page_kaddr = kmap_atomic(page);
> > +                       page_kaddr = kmap_local_folio(folio, 0);
> >                         ret = copy_from_user(page_kaddr,
> >                                              (const void __user *)src_addr,
> >                                              PAGE_SIZE);
> > -                       kunmap_atomic(page_kaddr);
> > +                       kunmap_local(page_kaddr);
> > 
> > Should I be using __copy_from_user_inatomic() here?
> 
> Caller __mcopy_atomic() is holding mmap_read_lock(dst_mm) and this
> copy_from_user() calls
> might_fault()->might_lock_read(current->mm->mmap_lock).
> 
> And I guess might_lock_read() gets upset because we're holding another
> mm's mmap_lock.  Which sounds OK to me, unless a concurrent
> mmap_write_lock() could jam things up.

Well, are we sure that dst_mm and current->mm are necessarily different?
If so, we could tell lockdep that.

> But I cannot see why your patch would suddenly trigger this warning -
> kmap_local_folio() and kmap_atomic() are basically the same thing.

Except for the important call in kmap_atomic_prot() to
pagefault_disable().  I mean, we could open-code that in the uffd code?

