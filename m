Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEBA61F5DE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiKGO11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiKGO0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:26:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9903B27CD1;
        Mon,  7 Nov 2022 06:20:40 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C9E4E1F8B4;
        Mon,  7 Nov 2022 14:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667830838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mh/Y3uwvq82Px8GTLeRTukZSQVpPtpYrFg2LuLtAC6g=;
        b=EQW19GhDUzPsCd4Jz5cKGqQ9/exV3P6JT8YYRVmXcz/SccfGnGdy07BLLKO9tYe7EhF8uF
        UbUKVxCTeFzj6i3iOYUpTnh44F8bcM3NFDw5ddx3qkuGX9qwxS25arPDYByTmGR7PhN7Fe
        PLr68l6X7abgt2o9dKSEjf1glswpnPg=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3FB7E2C141;
        Mon,  7 Nov 2022 14:20:35 +0000 (UTC)
Date:   Mon, 7 Nov 2022 15:20:34 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 3/3] mm, printk: introduce new format %pGt for page_type
Message-ID: <Y2kUMsHNyTCN8EaN@alley>
References: <20221106140355.294845-1-42.hyeyoo@gmail.com>
 <20221106140355.294845-4-42.hyeyoo@gmail.com>
 <Y2jpnBLFOgP8+RZ7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2jpnBLFOgP8+RZ7@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-07 13:18:52, Andy Shevchenko wrote:
> On Sun, Nov 06, 2022 at 11:03:55PM +0900, Hyeonggon Yoo wrote:
> > dump_page() uses %pGp format to print 'flags' field of struct page.
> > As some page flags (e.g. PG_buddy, see page-flags.h for more details)
> > are set in page_type field, introduce %pGt format which provides
> > human readable output of page_type. And use it in dump_page().
> > 
> > Note that the sense of bits are different in page_type. if page_type is
> > 0xffffffff, no flags are set. if PG_slab (0x00100000) flag is set,
> > page_type is 0xffefffff. Clearing a bit means we set the bit. Bits in
> > page_type are inverted when printing type names.
> > 
> > Below is examples of dump_page(). One is just after alloc_pages() and
> > the other is after __SetPageSlab().
> > 
> > [    1.814728] page:ffffea000415e200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x105788
> > [    1.815961] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
> 
> > [    1.816443] page_type: 0xffffffff()
> 
> Why do we have empty parentheses? I would expect either something there, or no
> parentheses at all.

This looks fine. format_page_flags() does the same for %pGp.

> ...
> 
> > +	%pGt	0xffefffff(slab)
> 
> No space before ( ?

Also looks fine. %pGp does the same.

> ...
> 
> > +static
> > +char *format_page_type(char *buf, char *end, unsigned int page_type)
> > +{
> > +	if (!(page_type & PAGE_TYPE_BASE))
> > +		return string(buf, end, "no type for user-mapped page", default_str_spec);
> 
> It's too long, can we make it shorten?

I wonder if it would help to write the value. Something like:

      page_type: 0x0ace5768(no type)

That said. I am not familiar with the page types and am not sure
about the semantic of this value. MM people should decide what they
want to see in this case.

> ...
> 
> >  	pr_warn("%sflags: %pGp%s\n", type, &head->flags,
> >  		page_cma ? " CMA" : "");
> > +	pr_warn("page_type: %pGt\n", &head->page_type);
> > +
> >  	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
> >  			sizeof(unsigned long), page,
> >  			sizeof(struct page), false);
> > diff --git a/mm/internal.h b/mm/internal.h
> > index cb4c663a714e..956eaa9f12c0 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -773,6 +773,7 @@ static inline void flush_tlb_batched_pending(struct mm_struct *mm)
> >  #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
> >  
> >  extern const struct trace_print_flags pageflag_names[];
> > +extern const struct trace_print_flags pagetype_names[];
> >  extern const struct trace_print_flags vmaflag_names[];
> >  extern const struct trace_print_flags gfpflag_names[];
> 
> I would split this to a separate change, but it's up to PRINTK maintainers.

I guess that you are talking about the line:

+	pr_warn("page_type: %pGt\n", &head->page_type);


Yes, it would be better to have implementation of %pGt modifier
in one patch and add the user in another one.

Best Regards,
Petr
