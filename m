Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2868367D6DD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjAZUyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjAZUyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:54:03 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0762B3400D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OfQDUeRRQe7ymNiO1iM8vsACcUSW+Tp2ZTEJpAVyajE=; b=L0TCoGxSSuIqwUAE6SCrH0YYj+
        rA8UWbiH0gjPbsyHDDO0r+/4PgXWQqT1Xoycxub8JNFHpwdl68MP4dENJG1+EF77u/ewqWpNd7IO8
        L1/rSHlU6l+gHck2qcTvVw/vI71VP2KMY5Clo0AxNX6rdyFSLjetW/V15B6qQ/K/JtYjiUDpYG7Wj
        ULaIRGnD9gZeQoGSYsczreTKwKdo0uyhixPguiI7WAxbkeMl6Kl7cFX/lpM6VZdxOV2edbH+F6jTP
        zueXL6IdJmSHrpyAg3qCYLU3ZTdEzn0+9/sCqVxubKF2v1rB/SARCdkiv8VQgQ85GaJ3sFeRWeXuA
        twRtBitA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pL9Fd-004JbL-2A;
        Thu, 26 Jan 2023 20:53:42 +0000
Date:   Thu, 26 Jan 2023 20:53:41 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] mm/highmem: Align-down to page the address for
 kunmap_flush_on_unmap()
Message-ID: <Y9LoVRYumhvgjsw5@ZenIV>
References: <20230126143346.12086-1-fmdefrancesco@gmail.com>
 <63d2d97bce4c7_63e3f29442@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d2d97bce4c7_63e3f29442@iweiny-mobl.notmuch>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 11:50:19AM -0800, Ira Weiny wrote:
> Fabio M. De Francesco wrote:
> 
> FWIW I think I would simplify the subject
> [PATCH] mm/highmem: Fix kunmap_local() on flush on unmap architectures
> 
> Or something like that.

Make kunmap_local() handle addresses that are not page-aligned

kunmap_local() removes the temporary CPU-local mapping of a page that
had been created by earlier call of kmap_local_page().  The mapping to
be removed is identified by the pointer returned by kmap_local_page(),
i.e. the virtual address assigned to the first byte within the page
in question.  Often enough the callers had been working with an object
somewhere in the middle of the page; they have to either keep the
pointer to the beginning or to round the pointers they are really
working with down to the beginning of page.

As it is, for the majority of architectures kunmap_local() does such
rounding-down anyway (see kunmap_local_indexed()); the only exception
is if CONFIG_HIGHMEM is *not* defined, but ARCH_HAS_FLUSH_ON_KUNMAP is
(PA-RISC case).  In that case __kumap_local()

> > calls kunmap_flush_on_unmap(). The latter currently flushes the wrong
> > address

if given a pointer that is not page-aligned

> > (as confirmed by Matthew Wilcox and Helge Deller). Al Viro
> > proposed to call kunmap_flush_on_unmap() on an aligned-down to page
> > address in order to fix this issue. Consensus has been reached on this
> > solution.
> > 
> > Therefore, if ARCH_HAS_FLUSH_ON_KUNMAP is defined, call
> > kunmap_flush_on_unmap() on an aligned-down to page address computed with
> > the PTR_ALIGN_DOWN() macro.

That simplifies life for callers (e.g. filesystems that use kmap_local_page()
for directory page cache).

> > 
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Confirmed-by: Helge Deller <deller@gmx.de>
> > Confirmed-by: Matthew Wilcox <willy@infradead.org>
> > Fixes: f3ba3c710ac5 ("mm/highmem: Provide kmap_local*")
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Objections?

> > 
> > I have (at least) two problems with this patch...
> > 
> > 1) checkpatch.pl complains about the use of the non-standard
> > "Confirmed-by" tags. I don't know how else I can give credit to Helge
> > and Matthew. However, this is not the first time that I see non-standard
> > tags in patches applied upstream (I too had a non-standard
> > "Analysed-by" tag in patch which fixes a SAC bug). Any objections?
> 
> I think you can add Matthew and Helge as Suggested-by:  All 3 had input on
> the solution.

Or simply treat these complaints as per https://dilbert.com/strip/1996-10-04...

> > 2) I'm not sure whether or not the "Fixes" tag is appropriate in this
> > patch. Can someone either confirm or deny it?
> 
> This 'fixes' looks correct to me.  I don't know how many folks are running
> highmem with parisc but if they are I am sure they would appreciate the
> extra knowledge.

parisc doesn't have highmem.  That's not what flush_kernel_dcache_page_addr()
call is about; if you look at the kmap() there you'll see that it does
*not* create any new mapping - it simply returns page_address().  It's
really about D-cache flushing there; kunmap() and its ilk serve as
convenient points for doing the flush.

Not sure about the "fixes" tag, TBH - AFAICS, currently all users supply
page-aligned addresses anyway.  Their life would be easier if they could
just pass any pointer within the page in questions and it's easy to overlook
this corner case and assume that kunmap_local() would handle that as it
is, but it's more of a "bug waiting to happen, better get rid of the
corner case and explicitly document that property of kunmap_local()" than
"there's a broken caller in the current mainline kernel, need to fix
that".

Anyway, I would rather keep the sysv etc. series independent from that;
for now dir_put_page() explicitly rounds down there.  Once those series
*and* your patch are both merged we can do a quick followup removing the
explicit round-downs, marked as dependent upon your patch.
