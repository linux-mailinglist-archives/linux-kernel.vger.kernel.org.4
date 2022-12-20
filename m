Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C3E65239A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiLTPUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiLTPUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:20:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FB01C936
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:20:31 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 985C75FC3C;
        Tue, 20 Dec 2022 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671549630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ReOLkeBvlnpQy6Jl1i4qyjNaQfRlZg2tYB2xamiOUCw=;
        b=jYfg7x70vsavP9KVww9ZxBsR8BVHyCw+j1qRM3QSUIksqowPj5Wg3FA+O63hQ+FzF+1214
        l8U0K/MkvM6azr7HRDLlhHAbMwKvMTshlfX4xwUs7aV30p+wrrxCCSTnL6PlhYxVeppx8u
        lK6VMNJstFDjBXFvdoSxI6xvcCKlNF0=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B75742C141;
        Tue, 20 Dec 2022 15:20:26 +0000 (UTC)
Date:   Tue, 20 Dec 2022 16:20:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 3/4] mm, printk: introduce new format %pGt for page_type
Message-ID: <Y6HSutM8pmoKxQWp@alley>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-4-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218101901.373450-4-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-12-18 19:19:00, Hyeonggon Yoo wrote:
> %pGp format is used to print 'flags' field of struct page.
> As some page flags (e.g. PG_buddy, see page-flags.h for more details)
> are set in page_type field, introduce %pGt format which provides
> human readable output of page_type.
> 
> Note that the sense of bits are different in page_type. if page_type is
> 0xffffffff, no flags are set. if PG_slab (0x00100000) flag is set,
> page_type is 0xffefffff. Clearing a bit means we set the bit.
> 
> Bits in page_type are inverted when printing page type names.
> 
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -575,12 +575,13 @@ The field width is passed by value, the bitmap is passed by reference.
>  Helper macros cpumask_pr_args() and nodemask_pr_args() are available to ease
>  printing cpumask and nodemask.
>  
> -Flags bitfields such as page flags, gfp_flags
> +Flags bitfields such as page flags, page_type, gfp_flags
>  ---------------------------------------------

Please, underline the entire title. Otherwise, "make htmldoc"
complains ;-)

    /prace/kernel/linux/Documentation/core-api/printk-formats.rst:579: WARNING: Title underline too short.
    Flags bitfields such as page flags, page_type, gfp_flags


>  
>  ::
>  
>  	%pGp	0x17ffffc0002036(referenced|uptodate|lru|active|private|node=0|zone=2|lastcpupid=0x1fffff)
> +	%pGt	0xffefffff(slab)
>  	%pGg	GFP_USER|GFP_DMA32|GFP_NOWARN
>  	%pGv	read|exec|mayread|maywrite|mayexec|denywrite
>  

Please, explain this also in the paragraph below these examples.
I would personally refactor it to an itemized list, something like:

<proposal>
For printing flags bitfields as a collection of symbolic constants that
would construct the value. The type of flags is given by the third
character. Currently supported are:

	- p - [p]age flags, expects value of type (``unsigned long *``)
	- t - page [t]ype, expects value of type (``unsigned int *``)
	- v - [v]ma_flags, expects value of type (``unsigned long *``)
	- g - [g]fp_flags, expects value of type (``gfp_t *``)

The flag names and print order depends on the particular type.
</proposal>

Rant:
Sigh, it looks a bit error prone when similar pointer modifiers
expects pointers to different types. I wish there was a way how
to check the passed pointer type at compilation time. But it
is generic problem with these %p* modifiers.


Otherwise the patch looks fine for the vsprinf side.

Best Regards,
Petr
