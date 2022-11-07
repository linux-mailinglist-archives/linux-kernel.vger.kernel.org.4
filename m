Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B954E61F1AD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiKGLTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiKGLTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:19:02 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83830CE3C;
        Mon,  7 Nov 2022 03:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667819941; x=1699355941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cvxDWNtZzVvqQ3+pEhs6dDAy1QCbFhG4zWxy+4oWNiI=;
  b=VO97Et4glXrjgp9o+bUUfEFcFseC3yRQxuxCex045QWMNqPTc7Q+Yfn9
   p6Uis3aGMRXMFSxqB/IsZHCuZWQ10rtQHHCB9DU2MKB1inE1DMK3sSbl1
   +4bw9vPo/yRNsaqhdoz8+jKRxwROTN63LYy8+zaMSLi4GZjVu+cVU98F4
   zY8SjUr2LN/DwT4UNzRg6MNfDgyVQk6jMl/22+CQQh4zhI6L9m1ucL2R7
   VpZ+U/F8RvohmrzfFFwx5yqH75o1HyEFpsEdv/rZ80VJuWMOS4RmxlkPs
   jInmaxKpC/3yOd1XafPxYjyCcSrQACUROdtR6tSfC/36lkGkmlcisLj85
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="297878464"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="297878464"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:19:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="725106215"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="725106215"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Nov 2022 03:18:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os09U-008bap-0v;
        Mon, 07 Nov 2022 13:18:52 +0200
Date:   Mon, 7 Nov 2022 13:18:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 3/3] mm, printk: introduce new format %pGt for page_type
Message-ID: <Y2jpnBLFOgP8+RZ7@smile.fi.intel.com>
References: <20221106140355.294845-1-42.hyeyoo@gmail.com>
 <20221106140355.294845-4-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106140355.294845-4-42.hyeyoo@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 11:03:55PM +0900, Hyeonggon Yoo wrote:
> dump_page() uses %pGp format to print 'flags' field of struct page.
> As some page flags (e.g. PG_buddy, see page-flags.h for more details)
> are set in page_type field, introduce %pGt format which provides
> human readable output of page_type. And use it in dump_page().
> 
> Note that the sense of bits are different in page_type. if page_type is
> 0xffffffff, no flags are set. if PG_slab (0x00100000) flag is set,
> page_type is 0xffefffff. Clearing a bit means we set the bit. Bits in
> page_type are inverted when printing type names.
> 
> Below is examples of dump_page(). One is just after alloc_pages() and
> the other is after __SetPageSlab().
> 
> [    1.814728] page:ffffea000415e200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x105788
> [    1.815961] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)

> [    1.816443] page_type: 0xffffffff()

Why do we have empty parentheses? I would expect either something there, or no
parentheses at all.

> [    1.816704] raw: 0017ffffc0000000 0000000000000000 dead000000000122 0000000000000000
> [    1.817291] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> [    1.817870] page dumped because: Before __SetPageSlab()
> 
> [    1.818258] page:ffffea000415e200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x105788
> [    1.818857] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
> [    1.819250] page_type: 0xffefffff(slab)
> [    1.819483] raw: 0017ffffc0000000 0000000000000000 dead000000000122 0000000000000000
> [    1.819947] raw: 0000000000000000 0000000000000000 00000001ffefffff 0000000000000000
> [    1.820410] page dumped because: After __SetPageSlab()

> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org

Can you utilize --cc parameter next time and avoid polluting commit message
with this? We have archives where anybody can check this (and usually maintainers
add a Link tag for that purpose).

...

> +	%pGt	0xffefffff(slab)

No space before ( ?

...

> +static
> +char *format_page_type(char *buf, char *end, unsigned int page_type)
> +{
> +	if (!(page_type & PAGE_TYPE_BASE))
> +		return string(buf, end, "no type for user-mapped page", default_str_spec);

It's too long, can we make it shorten?

> +	buf = number(buf, end, page_type, default_flag_spec);
> +
> +	if (buf < end)
> +		*buf = '(';
> +	buf++;

> +	if (page_type_has_type(page_type))

This should be check for the entire function.

> +		buf = format_flags(buf, end, ~page_type, pagetype_names);
> +
> +	if (buf < end)
> +		*buf = ')';
> +	buf++;
> +
> +	return buf;
> +}

...

> @@ -36,6 +36,11 @@ const struct trace_print_flags pageflag_names[] = {
>  	{0, NULL}
>  };
>  
> +const struct trace_print_flags pagetype_names[] = {
> +	__def_pagetype_names,


> +	{0, NULL}

Hmm... I see it's already done like this above, but {}  would suffice, why not
to convert the rest first to the {} and use it here?

> +};

...

>  	pr_warn("%sflags: %pGp%s\n", type, &head->flags,
>  		page_cma ? " CMA" : "");
> +	pr_warn("page_type: %pGt\n", &head->page_type);
> +
>  	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
>  			sizeof(unsigned long), page,
>  			sizeof(struct page), false);
> diff --git a/mm/internal.h b/mm/internal.h
> index cb4c663a714e..956eaa9f12c0 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -773,6 +773,7 @@ static inline void flush_tlb_batched_pending(struct mm_struct *mm)
>  #endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
>  
>  extern const struct trace_print_flags pageflag_names[];
> +extern const struct trace_print_flags pagetype_names[];
>  extern const struct trace_print_flags vmaflag_names[];
>  extern const struct trace_print_flags gfpflag_names[];

I would split this to a separate change, but it's up to PRINTK maintainers.

-- 
With Best Regards,
Andy Shevchenko


