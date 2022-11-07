Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE7761F656
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiKGOlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiKGOlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:41:16 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C281A05D;
        Mon,  7 Nov 2022 06:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667832075; x=1699368075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u3e6+JJ5A3zX1Hk0G74jg5cr+39BSLGe2g515DJqP0M=;
  b=ZnyKKamfg9C/tojgiRre23ItnUFX4z1pEe+e6ah2bLO+q8tMQYjFIu9p
   Crhi7NzOKW8OGazR0/6g/OsQrtJbesipBWL7uhQYioGRM4qkAG6Tx8cvT
   Fc/Hy6mMdmMJRDFmynbp9yhr63DzfuhoCsqbfRKQGN8gYpNl+OVKA1ku0
   5b8dNbeTpsmaBmkelZ0XqwElvxjjd9qA0jw3dLShWBlqteIuRbWgLvsIA
   6DRxMxLE+Vwnhj3ZfoQi0d2UDA9C7w8uof/mOrf+CDVcOVWr/IsCG5Zgt
   rm9MAstwqBOBcCNP5QVbaJHLsOJwA6y3xlSYIFGmi40w3emmJKL/wMQy5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="374674887"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="374674887"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 06:41:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="704894936"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="704894936"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 07 Nov 2022 06:41:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1os3JB-008hYc-2r;
        Mon, 07 Nov 2022 16:41:05 +0200
Date:   Mon, 7 Nov 2022 16:41:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
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
Message-ID: <Y2kZAZPgOqryar8G@smile.fi.intel.com>
References: <20221106140355.294845-1-42.hyeyoo@gmail.com>
 <20221106140355.294845-4-42.hyeyoo@gmail.com>
 <Y2jpnBLFOgP8+RZ7@smile.fi.intel.com>
 <Y2kUMsHNyTCN8EaN@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2kUMsHNyTCN8EaN@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:20:34PM +0100, Petr Mladek wrote:
> On Mon 2022-11-07 13:18:52, Andy Shevchenko wrote:
> > On Sun, Nov 06, 2022 at 11:03:55PM +0900, Hyeonggon Yoo wrote:
> > > dump_page() uses %pGp format to print 'flags' field of struct page.

...

> > > [    1.816443] page_type: 0xffffffff()
> > 
> > Why do we have empty parentheses? I would expect either something there, or no
> > parentheses at all.
> 
> This looks fine. format_page_flags() does the same for %pGp.

...

> > > +	%pGt	0xffefffff(slab)
> > 
> > No space before ( ?
> 
> Also looks fine. %pGp does the same.

Maybe we can modify them before or after this change?

-- 
With Best Regards,
Andy Shevchenko


