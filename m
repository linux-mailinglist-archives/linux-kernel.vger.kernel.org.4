Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209485FFE65
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 11:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJPJK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 05:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiJPJKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 05:10:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A4832040
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 02:10:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h12so8640420pjk.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 02:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CLyMeXzmotkiR8j5Gpy9vXymc5jaUcrTQlSZ8Ryl3Ug=;
        b=pLCXPAQfZB5t+OnsYhA9LPn/MAn97Opqa6IgzFWza6gcOAf+tRph5dnuSppcco5wOk
         Hae/j+WykDaCwqtjbeS/Ow5AZkb8VsdyrHumnecPUuSHNIeVRLlM5M97VtUAzhnsskxm
         ONsaGDY4nikPal5zxmyyI4odJjG0NfG3gfxe3ocFEi76KEdxl3qdn+/mZHGzUp2cbHgM
         gLIIiGaMNELbR9lEquePgyFG6ifXhBK5iFX9j1OwnO6Rupn8owJiFnRWk20aZgHTa7KE
         0Quj/bOSxT6dLZR09/2V0aEYPKoQMpK1ZpmEibTcAxcC3fmAudZ2TnfrJrG7sW2hyWyw
         PoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLyMeXzmotkiR8j5Gpy9vXymc5jaUcrTQlSZ8Ryl3Ug=;
        b=xyzze8cNkTqaYvAPsbrEWRvWo7D8BZjpbSrR+EPy/75L15dClKUVAme+utUS4qmB6I
         oUYNaL5vwXtEAs/1jgg7npgpEKp8hZm5ot9JWwMKCTPImxbKUAoY+MhgR6MrIpmFcVO4
         IEylJ7jbltyNlLdmFGZ4mNaw3GKVN+WPnhmx3Er6bBHmr9pQxZ6mRLuPndGSP2XOa6LN
         JtH5bLKmGrhBgCba1KZf/pI2RRqyYGNeBB+hc+2/HJtNOaRIQvesty9LUXlIk45Ebw9e
         MLVoosPTy/waakoUCc/F/ionEorVcYoViwMAEQ9c7LIIIgnGwZTG5ztMks7No//JhMr8
         5v1g==
X-Gm-Message-State: ACrzQf3AGTFJF9Ed59Z+6lppL9NVGt6q64fft46qQIEVquSFmcuiyZyY
        IMgT79PF8NeTajEe00aM+bA=
X-Google-Smtp-Source: AMsMyM6jnh2QfXY198Icbz7Y0ot32GA/pYALs5HjjqoyMyj80qqOyEp5f6swFeo2IIhIjJkckxqAFA==
X-Received: by 2002:a17:90a:a401:b0:20a:da56:b073 with SMTP id y1-20020a17090aa40100b0020ada56b073mr7437677pjp.1.1665911422528;
        Sun, 16 Oct 2022 02:10:22 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id p65-20020a625b44000000b0053e4296e1d3sm4709558pfb.198.2022.10.16.02.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 02:10:21 -0700 (PDT)
Date:   Sun, 16 Oct 2022 18:10:15 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/17] mm/slab: kmalloc: pass requests larger than
 order-1 page to page allocator
Message-ID: <Y0vKd8/9lrI8T+Wk@hyeyoo>
References: <20220817101826.236819-1-42.hyeyoo@gmail.com>
 <20220817101826.236819-11-42.hyeyoo@gmail.com>
 <20221014205818.GA1428667@roeck-us.net>
 <Y0n1WxxwbgSOmMwJ@hyeyoo>
 <7ad9081b-9082-2cbb-5732-f87366dca801@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad9081b-9082-2cbb-5732-f87366dca801@suse.cz>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2022 at 09:39:08PM +0200, Vlastimil Babka wrote:
> On 10/15/22 01:48, Hyeonggon Yoo wrote:
> > On Fri, Oct 14, 2022 at 01:58:18PM -0700, Guenter Roeck wrote:
> >> Hi,
> >> 
> >> On Wed, Aug 17, 2022 at 07:18:19PM +0900, Hyeonggon Yoo wrote:
> >> > There is not much benefit for serving large objects in kmalloc().
> >> > Let's pass large requests to page allocator like SLUB for better
> >> > maintenance of common code.
> >> > 
> >> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> >> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> >> > ---
> >> 
> >> This patch results in a WARNING backtrace in all mips and sparc64
> >> emulations.
> >> 
> >> ------------[ cut here ]------------
> >> WARNING: CPU: 0 PID: 0 at mm/slab_common.c:729 kmalloc_slab+0xc0/0xdc
> >> Modules linked in:
> >> CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-11990-g9c9155a3509a #1
> >> Stack : ffffffff 801b2a18 80dd0000 00000004 00000000 00000000 81023cd4 00000000
> >>         81040000 811a9930 81040000 8104a628 81101833 00000001 81023c78 00000000
> >>         00000000 00000000 80f5d858 81023b98 00000001 00000023 00000000 ffffffff
> >>         00000000 00000064 00000002 81040000 81040000 00000001 80f5d858 000002d9
> >>         00000000 00000000 80000000 80002000 00000000 00000000 00000000 00000000
> >>         ...
> >> Call Trace:
> >> [<8010a2bc>] show_stack+0x38/0x118
> >> [<80cf5f7c>] dump_stack_lvl+0xac/0x104
> >> [<80130d7c>] __warn+0xe0/0x224
> >> [<80cdba5c>] warn_slowpath_fmt+0x64/0xb8
> >> [<8028c058>] kmalloc_slab+0xc0/0xdc
> >> 
> >> irq event stamp: 0
> >> hardirqs last  enabled at (0): [<00000000>] 0x0
> >> hardirqs last disabled at (0): [<00000000>] 0x0
> >> softirqs last  enabled at (0): [<00000000>] 0x0
> >> softirqs last disabled at (0): [<00000000>] 0x0
> >> ---[ end trace 0000000000000000 ]---
> >> 
> >> Guenter
> > 
> > Hi.
> > 
> > Thank you so much for this report!
> > 
> > Hmm so SLAB tries to find kmalloc cache for freelist index array using
> > kmalloc_slab() directly, and it becomes problematic when size of the
> > array is larger than PAGE_SIZE * 2.
> 
> Hmm interesting, did you find out how exactly that can happen in practice,

> or what's special about mips and sparc64 here?

IIUC if page size is large, number of objects per slab is quite large and so
the possiblity of failing to use objfreelist slab is higher, and then it
tries to use off slab.

> Because normally
> calculate_slab_order() will only go up to slab_max_order, which AFAICS can
> only go up to SLAB_MAX_ORDER_HI, thus 1, unless there's a boot command line
> override.

AFAICS with mips default configuration and without setting slab_max_order,
It seems SLAB actually does not use too big freelist index array.

But it hits the warning because of tricky logic.

For example if the condition is true on


>	if (freelist_cache->size > cachep->size / 2)
>		continue;

or on (before kmalloc is up, in case of kmem_cache)
>	freelist_cache = kmalloc_slab(freelist_size, 0u);
>       if (!freelist_cache)
>		continue;

it increases gfporder over and over until 'num' becomes larger than SLAB_MAX_OBJS.
(regardless of slab_max_order).

I think adding below would be more robust.

diff --git a/mm/slab.c b/mm/slab.c
index d1f6e2c64c2e..1321aca1887c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1679,7 +1679,7 @@ static size_t calculate_slab_order(struct kmem_cache *cachep,
 			} else {
 				freelist_cache = kmalloc_slab(freelist_size, 0u);
 				if (!freelist_cache)
-					continue;
+					break;
 				freelist_cache_size = freelist_cache->size;
 
 				/*
@@ -1692,7 +1692,7 @@ static size_t calculate_slab_order(struct kmem_cache *cachep,
 
 			/* check if off slab has enough benefit */
 			if (freelist_cache_size > cachep->size / 2)
-				continue;
+				break;
 		}
 
 		/* Found something acceptable - save it away */


> And if we have two pages for objects, surely even with small objects they
> can't be smaller than freelist_idx_t, so if the number of objects fits into
> two pages (order 1), then the freelist array should also fit in two pages?

That's right but on certain condition it seem to go larger than slab_max_order.
(from code inspection)

> 
> Thanks,
> Vlastimil
> 
> > Will send a fix soon.
> > 

-- 
Thanks,
Hyeonggon
