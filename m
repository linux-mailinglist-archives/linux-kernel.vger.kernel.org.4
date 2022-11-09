Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164B862251F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiKIINW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKIINS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:13:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7EE1902F;
        Wed,  9 Nov 2022 00:13:17 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A64331F8C4;
        Wed,  9 Nov 2022 08:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667981595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iZ41zAxuFab1VbpZbOqMuhHV5p0NUYaSK2sGuoKt9j4=;
        b=A39M7ugjky4HJHQHpgupgCpSL4sIzdbSNnEklOL1SK2k8fgTBZ0UquiKGpX2rsgBpG5RKd
        fiWl+ZiIHC1FiY5c5gjE2ZFIKCevpdQ/RaPk3QCEmR1nQV6KTg/HAY0deZ95bnD5JxnHpP
        9qW8VmwXRjZZy3Ymanng8AOAF0PFh8o=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B9CAB2C141;
        Wed,  9 Nov 2022 08:13:13 +0000 (UTC)
Date:   Wed, 9 Nov 2022 09:13:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Joe Perches <joe@perches.com>, linux-mm@kvack.org,
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 3/3] mm, printk: introduce new format %pGt for page_type
Message-ID: <Y2thF8NS4DX69Uq7@alley>
References: <20221106140355.294845-1-42.hyeyoo@gmail.com>
 <20221106140355.294845-4-42.hyeyoo@gmail.com>
 <c038e06504733e8dc6830f082c8522c60895fd8e.camel@perches.com>
 <Y2tFLQ/w9siSwy+M@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2tFLQ/w9siSwy+M@hyeyoo>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-11-09 15:14:05, Hyeonggon Yoo wrote:
> On Sun, Nov 06, 2022 at 10:04:25AM -0800, Joe Perches wrote:
> > On Sun, 2022-11-06 at 23:03 +0900, Hyeonggon Yoo wrote:
> > > dump_page() uses %pGp format to print 'flags' field of struct page.
> > > As some page flags (e.g. PG_buddy, see page-flags.h for more details)
> > > are set in page_type field, introduce %pGt format which provides
> > > human readable output of page_type. And use it in dump_page().
> > []
> > > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > []
> > > @@ -2056,6 +2056,28 @@ char *format_page_flags(char *buf, char *end, unsigned long flags)
> > >  	return buf;
> > >  }
> > >  
> > > +static
> 
> Thanks for looking at this.
> 
> > 
> > noinline_for_stack ?

Honestly, I do not like much adding this without numbers. It has been added
to some functions in vsprintf.c long time ago because it reduced
the stack usage. But I think that it is a compiler and an architecture
specific. And it is not clear if it would really help in this
particular case.

Feel free to omit it.

Best Regards,
Petr
