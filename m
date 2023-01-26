Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E107967D844
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjAZWRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjAZWRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:17:49 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E55DB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RpR41kvGYjpBYQtXapQ3XU33vxpfaI0JWc3v8JbFCC4=; b=jQxxxyXcoOryVWvJ7Mq7djXSeP
        0e3o16zTP8W0dWtfz0/JURhq+rVHc8PjVqaomETP/4eWlRXnv5x9wdHe/N1SHJto1iUfZxtS6afX5
        moAVvqAPfsWp2t2vuijclvAjQb3WeWcrJk9AlXIZOFTC3CzJJoD0E4DBcJ00wkCBConYxQlEMrmq6
        4uFHepBcsa6xJ+PZCROdsLbumw6VayCGv9ErJl+wArTKlgrYlPizVLikllJBH2LhC7VCWW6IQd3Mi
        V8D4Z0YPBc7j/BGCGi7lecZPwTSMlmuKGVCzHJnPP/HgLI2tqL5wUqwZ/Np+GOeTsA9WzviEQGp97
        XYWyANTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pLAYn-004KHr-0d;
        Thu, 26 Jan 2023 22:17:33 +0000
Date:   Thu, 26 Jan 2023 22:17:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] mm/highmem: Align-down to page the address for
 kunmap_flush_on_unmap()
Message-ID: <Y9L7/b/33mXvRsyX@ZenIV>
References: <20230126143346.12086-1-fmdefrancesco@gmail.com>
 <20230126123858.42d9377ad6e352a58c81668b@linux-foundation.org>
 <Y9LnAzUP2K/cmqa5@casper.infradead.org>
 <Y9LqwvXy+gpFBerE@ZenIV>
 <Y9L291ySSSRHD3uB@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9L291ySSSRHD3uB@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 09:56:07PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 26, 2023 at 09:04:02PM +0000, Al Viro wrote:
> > On Thu, Jan 26, 2023 at 08:48:03PM +0000, Matthew Wilcox wrote:
> > > On Thu, Jan 26, 2023 at 12:38:58PM -0800, Andrew Morton wrote:
> > > > On Thu, 26 Jan 2023 15:33:46 +0100 "Fabio M. De Francesco" <fmdefrancesco@gmail.com> wrote:
> > > > 
> > > > > If ARCH_HAS_FLUSH_ON_KUNMAP is defined (PA-RISC case), __kunmap_local()
> > > > > calls kunmap_flush_on_unmap(). The latter currently flushes the wrong
> > > > > address (as confirmed by Matthew Wilcox and Helge Deller). Al Viro
> > > > > proposed to call kunmap_flush_on_unmap() on an aligned-down to page
> > > > > address in order to fix this issue. Consensus has been reached on this
> > > > > solution.
> > > > 
> > > > What are the user-visible runtime effects of this flaw?
> > > 
> > > The version of this patch I sent out includes this information,
> > > as well as the missed alignment for kunmap_atomic().
> > 
> > One point: AFAICS, the situation right now is
> > 	* all callers of kunmap_local() pass page-aligned pointers
> 
> Ah, no.  kmap_local_folio() accepts a byte offset within the folio
> and returns a pointer to that byte.  I hadn't noticed the parisc
> case and thought it was already allowed to pass a misaligned pointer
> to kunmap_local() since it is allowed for the highmem case.  It
> simplified the callers, so it looked like a good tradeoff.
> 
> See, eg 338f379cf7c2:
> 
> -               src_addr = kmap_atomic(src_page);
> -               dest_addr = kmap_atomic(dest_page);
> +               src_addr = kmap_local_folio(src_folio,
> +                                       offset_in_folio(src_folio, srcoff));
> +               dst_addr = kmap_local_folio(dst_folio,
> +                                       offset_in_folio(dst_folio, dstoff));
> 
> -               if (memcmp(src_addr + src_poff, dest_addr + dest_poff, cmp_len))
> +               if (memcmp(src_addr, dst_addr, cmp_len))
> 
> -               kunmap_atomic(dest_addr);
> -               kunmap_atomic(src_addr);
> +               kunmap_local(dst_addr);
> +               kunmap_local(src_addr);

Argh...  Missed that.

OK, then Fixes: on the patch makes a lot of sense.  And it still
needs a chunk in D/m/highmem.rst...
