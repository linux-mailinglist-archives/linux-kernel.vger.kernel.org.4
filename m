Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF45D67D6CD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjAZUt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjAZUtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:49:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA33324C89
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tKn2FbCSheX63Gc83N+mJiyTsO1Rof6KpvRAhcKRMXA=; b=eReNto/6GQG9ZldWfsYM2jeeTv
        VN5na836baexetsBhbs2wKu6G0qvYQbN8fzRxaXYQ8MSYw2RGT2291Q1D2bN0KpjKi1XVZBD1q+4r
        LnA8f9OI53PPStRwJm4zSkQ/2i3fjOiA9qNe+Re5JwTX4FKvQg6DJzrSHuDir3WVTTTFl2zR51KLj
        HRLFeYfW2FDCJfFHYquFjPtPi5Aj05OJjNMPYji4Fmcca429J/UbQwSsy6Vvi/qRjBoRoyFlfmB4n
        Q3wE5xNbbmcOWHiX0TzjOaDJQr6779BhLwdYfTpROOg/4roi2AeuvRBBAnwosw5/bYISITA+qAHkp
        VVIArc4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL9Bn-0074is-KA; Thu, 26 Jan 2023 20:49:43 +0000
Date:   Thu, 26 Jan 2023 20:49:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] mm/highmem: Align-down to page the address for
 kunmap_flush_on_unmap()
Message-ID: <Y9LnZ5wS9Sh3pwSH@casper.infradead.org>
References: <20230126143346.12086-1-fmdefrancesco@gmail.com>
 <63d2d97bce4c7_63e3f29442@iweiny-mobl.notmuch>
 <804f9617-cdad-d3cb-f4c0-7d99d12f49d6@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <804f9617-cdad-d3cb-f4c0-7d99d12f49d6@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 09:37:08PM +0100, Helge Deller wrote:
> > This 'fixes' looks correct to me.  I don't know how many folks are running
> > highmem with parisc but if they are I am sure they would appreciate the
> > extra knowledge.
> 
> It seems nobody is running highmem on parisc, because it can't be enabled.
> AFAICS, it's not in any parisc related Kconfig file.

But this isn't being used for highmem on parisc; it's being used for
cache coherency.

> > I do wonder if this should be cc'ed to stable to ensure it gets
> > backported?  Helge do you think there is a need for that?
> 
> For correctness I think it's nevertheless good to backport it.

I cc'd stable on my version of this patch, and included a Fixes tag
to indicate how far back to backport it.

> That would be another possibility:
> 
> diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
> index 0bdee6724132..ce5d1f8a23bd 100644
> --- a/arch/parisc/include/asm/cacheflush.h
> +++ b/arch/parisc/include/asm/cacheflush.h
> @@ -77,6 +77,7 @@ void flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned lon
>  #define ARCH_HAS_FLUSH_ON_KUNMAP
>  static inline void kunmap_flush_on_unmap(const void *addr)
>  {
> +       addr = PTR_ALIGN_DOWN(addr, PAGE_SIZE);

I considered that, but thought it a shame to do it here when all the
other users are passing in a page-aligned address.
