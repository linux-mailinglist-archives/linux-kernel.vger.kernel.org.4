Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185FD67D692
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjAZUjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjAZUjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:39:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCDE7AB0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:39:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C22F4CE259D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 20:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F90FC433EF;
        Thu, 26 Jan 2023 20:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674765539;
        bh=eqCm1yGf+yfktl0RDMe042s02iMXVNx/WsE1kqwweJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=03/Rs4NqdOvG8k51Xy1Ddo7iNB2UHGqimSa4IDuaWsW575lmMkFEMbLJBaEfSvP3B
         PTvunZQwaQObaUNpWnAlq5lZtYduS054WH38K4VA0JnA90K9DRovq+BUiq/bClvkxi
         7j2hYHNmCb4nC0hMitC7HDb0s5t2s0n5MpaGXKJo=
Date:   Thu, 26 Jan 2023 12:38:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
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
        Al Viro <viro@zeniv.linux.org.uk>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] mm/highmem: Align-down to page the address for
 kunmap_flush_on_unmap()
Message-Id: <20230126123858.42d9377ad6e352a58c81668b@linux-foundation.org>
In-Reply-To: <20230126143346.12086-1-fmdefrancesco@gmail.com>
References: <20230126143346.12086-1-fmdefrancesco@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 15:33:46 +0100 "Fabio M. De Francesco" <fmdefrancesco@gmail.com> wrote:

> If ARCH_HAS_FLUSH_ON_KUNMAP is defined (PA-RISC case), __kunmap_local()
> calls kunmap_flush_on_unmap(). The latter currently flushes the wrong
> address (as confirmed by Matthew Wilcox and Helge Deller). Al Viro
> proposed to call kunmap_flush_on_unmap() on an aligned-down to page
> address in order to fix this issue. Consensus has been reached on this
> solution.

What are the user-visible runtime effects of this flaw?

> Therefore, if ARCH_HAS_FLUSH_ON_KUNMAP is defined, call
> kunmap_flush_on_unmap() on an aligned-down to page address computed with
> the PTR_ALIGN_DOWN() macro.
> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Confirmed-by: Helge Deller <deller@gmx.de>
> Confirmed-by: Matthew Wilcox <willy@infradead.org>
> Fixes: f3ba3c710ac5 ("mm/highmem: Provide kmap_local*")
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> I have (at least) two problems with this patch...
> 
> 1) checkpatch.pl complains about the use of the non-standard
> "Confirmed-by" tags. I don't know how else I can give credit to Helge
> and Matthew. However, this is not the first time that I see non-standard
> tags in patches applied upstream (I too had a non-standard
> "Analysed-by" tag in patch which fixes a SAC bug). Any objections?

Add a paragraph "this was confirmed by X and Y", then add Cc:X, Cc:y?

This gives you an opportunity to tell us what "confirmed" actually
means!  Did they confirm that it's a bug?  Or that the fix is correct? 
I dunno.

> 2) I'm not sure whether or not the "Fixes" tag is appropriate in this
> patch. Can someone either confirm or deny it?
> 
>  include/linux/highmem-internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index 034b1106d022..e247c9ac4583 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -200,7 +200,7 @@ static inline void *kmap_local_pfn(unsigned long pfn)
>  static inline void __kunmap_local(const void *addr)
>  {
>  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
> -	kunmap_flush_on_unmap(addr);
> +	kunmap_flush_on_unmap(PTR_ALIGN_DOWN(addr, PAGE_SIZE));
>  #endif
>  }
>  
> -- 
> 2.39.0
