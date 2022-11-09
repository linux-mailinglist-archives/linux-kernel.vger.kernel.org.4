Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EB76223A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 07:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKIGEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 01:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIGEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 01:04:34 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84EC13D63;
        Tue,  8 Nov 2022 22:04:32 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l6so15823323pjj.0;
        Tue, 08 Nov 2022 22:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NrHD8wLzW2vOh67ueVVQM6HR2KgSCKRKBNGUVxIg0Xw=;
        b=KkK14nw7ANwd2Yzpl+m5rI4utFgMgZs7bo5F3vx1zQK7ozGIVQcz4WVswUtpEnXbMy
         hNd+nkUnqk5qo92hDJAxeq7tdYnE3fb7sbeM7N1lrc6fRc2NYhCMMDJvuz7KxUJpEkML
         b6j3pBgJBB2daq7mu7/8xVkieNrmUkfxunK1s6LZRce5UM0ksefwEt0MukxqSMS2MPVR
         r3yYla3JIy/X8U4RIkGI22e+j9zF6neB4c++651AI1Xn1FvZNfkprrwt7uKbUEgsUZer
         ov4JptMbBS2dBD6loiZhngvap1EzjUCJVY8vOw92RJBhhbSN7dp6O9jthuIWCPu+Rjt4
         aGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrHD8wLzW2vOh67ueVVQM6HR2KgSCKRKBNGUVxIg0Xw=;
        b=ZoG1gOk7mitaX592tHcltyV4c8YyGzhrpZeFbxCf1ShldjDLwe7yl1ZwTlH6bii8Lp
         3JYY4kHZ5zscQrvxoKY1YnEeFFm6avU7Zi3ky0+A779813iXa/hHWaS2TenSwxzogRYv
         wUyIHl5/LwwlBdbXj+3QAAaajJGw0wgVyDni8XnwslGQKg4g0lSAMCXDwU2PYwj3Zrem
         pH+WNg96SPMsIFN+zKPgvFryzihSq9xr6lgMabRrj2xqZYZjiEHGKm4ypfWmLX3aR/mA
         yyiXvjYP4IbQga/9vRmbR3r26VJMwRu/wO7x8gUYNpR0XGA1y6XwpzTTbm0iIMzfStdG
         t7qw==
X-Gm-Message-State: ACrzQf07oGUd4cRlP5sfZ1EKLJ4PDgTScWZKSBzANOBfloHsPFCtCHzK
        nUwpQsfnngat3hYzBbifYpo=
X-Google-Smtp-Source: AMsMyM7v2kLUmw8TIrBi4FO6Texz6tMiK5p4/wsREpvhZgUjwNBJ7ijTl3LcD+Ry/CZ9EYsNL1jlbQ==
X-Received: by 2002:a17:90b:388f:b0:215:f01f:7975 with SMTP id mu15-20020a17090b388f00b00215f01f7975mr32961783pjb.53.1667973872294;
        Tue, 08 Nov 2022 22:04:32 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090a899300b0020063e7d63asm331124pjn.30.2022.11.08.22.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 22:04:31 -0800 (PST)
Date:   Wed, 9 Nov 2022 15:04:23 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <Y2tC5yXqCo++q71w@hyeyoo>
References: <20221106140355.294845-1-42.hyeyoo@gmail.com>
 <20221106140355.294845-4-42.hyeyoo@gmail.com>
 <Y2jpnBLFOgP8+RZ7@smile.fi.intel.com>
 <Y2kUMsHNyTCN8EaN@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2kUMsHNyTCN8EaN@alley>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:20:34PM +0100, Petr Mladek wrote:
> On Mon 2022-11-07 13:18:52, Andy Shevchenko wrote:
> > On Sun, Nov 06, 2022 at 11:03:55PM +0900, Hyeonggon Yoo wrote:
> > > dump_page() uses %pGp format to print 'flags' field of struct page.
> > > As some page flags (e.g. PG_buddy, see page-flags.h for more details)
> > > are set in page_type field, introduce %pGt format which provides
> > > human readable output of page_type. And use it in dump_page().
> > > 
> > > Note that the sense of bits are different in page_type. if page_type is
> > > 0xffffffff, no flags are set. if PG_slab (0x00100000) flag is set,
> > > page_type is 0xffefffff. Clearing a bit means we set the bit. Bits in
> > > page_type are inverted when printing type names.
> > > 
> > > Below is examples of dump_page(). One is just after alloc_pages() and
> > > the other is after __SetPageSlab().
> > > 
> > > [    1.814728] page:ffffea000415e200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x105788
> > > [    1.815961] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
> > 
> > > [    1.816443] page_type: 0xffffffff()
> > 


Thank you both for looking at this! :-)

> > Why do we have empty parentheses? I would expect either something there, or no
> > parentheses at all.
> 
> This looks fine. format_page_flags() does the same for %pGp.
> 
> > ...
> > 
> > > +	%pGt	0xffefffff(slab)
> > 
> > No space before ( ?
> 
> Also looks fine. %pGp does the same.
> 
> > ...
> > 
> > > +static
> > > +char *format_page_type(char *buf, char *end, unsigned int page_type)
> > > +{
> > > +	if (!(page_type & PAGE_TYPE_BASE))
> > > +		return string(buf, end, "no type for user-mapped page", default_str_spec);
> > 
> > It's too long, can we make it shorten?
> 
> I wonder if it would help to write the value. Something like:
> 
>       page_type: 0x0ace5768(no type)
>
> That said. I am not familiar with the page types and am not sure
> about the semantic of this value. MM people should decide what they
> want to see in this case.

Hmm, then for consistency let's try:

- 0xffefffff(slab)
- 0xffffffff()
- 0x0ace5768()

this way.

> > ...
> > 
> > >  	pr_warn("%sflags: %pGp%s\n", type, &head->flags,
> > >  		page_cma ? " CMA" : "");
> > > +	pr_warn("page_type: %pGt\n", &head->page_type);
> > > +
> > >  	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
> > >  			sizeof(unsigned long), page,
> > >  			sizeof(struct page), false);
> > > diff --git a/mm/internal.h b/mm/internal.h
> > > index cb4c663a714e..956eaa9f12c0 100644
> > > --- a/mm/internal.h
> > > +++ b/mm/internal.h
> > > @@ -773,6 +773,7 @@ static inline void flush_tlb_batched_pending(struct mm_struct *mm)
> > >  #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
> > >  
> > >  extern const struct trace_print_flags pageflag_names[];
> > > +extern const struct trace_print_flags pagetype_names[];
> > >  extern const struct trace_print_flags vmaflag_names[];
> > >  extern const struct trace_print_flags gfpflag_names[];
> > 
> > I would split this to a separate change, but it's up to PRINTK maintainers.
> 
> I guess that you are talking about the line:
> 
> +	pr_warn("page_type: %pGt\n", &head->page_type);
> 
> 
> Yes, it would be better to have implementation of %pGt modifier
> in one patch and add the user in another one.

Sounds reasonable.
Will split its caller into another patch next to this one.

-- 
Thanks,
Hyeonggon
