Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B96ABF46
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCFMPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjCFMPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:15:03 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D20C2749A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:14:48 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d36so9265990lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 04:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678104886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lDgbGDQMjYNNdIj2GXwPS1VlBs4ZeaosIAUC97tjICg=;
        b=hvrLxvqzZIdeFQHhSWe0oyHuYd0eK+GJn8Pv7BCcjvlFgVDJqeHG7SF7j/SB9oVRXj
         w3/aDlLEGe2eSwLUQ9ocGmhzEDbjaua4QYXSf1WoDUTFsGOi4+LSIg/8eZsLqoysNS1j
         ZJxCoqevilHx43Rex5H3ATW8IUkOx83kv8U5CSnvfv3aFlxPlNG60tG9CND2cG6NOj+b
         65KHr7ip73EG+03tQcQ108aD9RV9RABg8sBKe7YOQa1OPfe+dZ05Jj3ArfmVtSIzmEIV
         lQzoDmYx/Xmo4th2uoEgajS85UL3nrBaPh1YuZDcnt4Vi61DR8NShiKo84yiYFXKR4bF
         Pt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678104886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDgbGDQMjYNNdIj2GXwPS1VlBs4ZeaosIAUC97tjICg=;
        b=cqaiZ5bpl6Lbs2a898BuKr7QPZGZguF1tNMpQSVxWO1WRISvexyR7noJ/IsSL+u7KJ
         yKUy7Axub5KkcvilkAMQzOCKrj3Q1pX97iWceCyayq56RlCuG9DSJXwRbHeqvbHUzJGi
         AM6qYnmOaCmgjmDXrAPiPwvmkrHyQUkXqs2YHn5Uvktvp7a2fzS3R4asPtjU2OvKXQZL
         18MXoa4E0FCys/j91bz5xri+oGNb8MgGq6AcItstH+PBR34FLJG5uIa8Dm7fwyRAOXFc
         Ar1KQjLSKZTBEG5p/YXWOcDKraVtJ0qdnvFt4gTMejvQwbyaWJIQpTnJw4c8Im54kTK0
         o3cA==
X-Gm-Message-State: AO0yUKVgBgVTEAk8Ooci9VpsGis7V9UTynbctbQFC/63JGy4oBUm7hjT
        PTTPls2KRKsH1vmD2NnYA6A=
X-Google-Smtp-Source: AK7set9nGlGcM9Vr7UqiFYQTqnQkLiSMt3lOGsDKRFfHi/0nksyJv7OH0ToAvt4MTv8TarDmqFl0UQ==
X-Received: by 2002:ac2:593b:0:b0:4a4:68b7:deab with SMTP id v27-20020ac2593b000000b004a468b7deabmr2654882lfi.7.1678104886486;
        Mon, 06 Mar 2023 04:14:46 -0800 (PST)
Received: from pc636 (host-90-235-0-207.mobileonline.telia.com. [90.235.0.207])
        by smtp.gmail.com with ESMTPSA id b23-20020ac25637000000b004d5ae3f5e9bsm1597412lff.130.2023.03.06.04.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 04:14:46 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 6 Mar 2023 13:14:43 +0100
To:     Michal Hocko <mhocko@suse.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] mm/page_alloc: avoid high-order page allocation warn
 with __GFP_NOFAIL
Message-ID: <ZAXZMz0n+CpWPVqy@pc636>
References: <20230305053035.1911-1-hsiangkao@linux.alibaba.com>
 <ZAWbjIJCarmxGa8k@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAWbjIJCarmxGa8k@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 08:51:40AM +0100, Michal Hocko wrote:
> [Cc couple of more people recently involved with vmalloc code]
> 
> On Sun 05-03-23 13:30:35, Gao Xiang wrote:
> > My knowledge of this is somewhat limited, however, since vmalloc already
> > supported __GFP_NOFAIL in commit 9376130c390a ("mm/vmalloc: add
> > support for __GFP_NOFAIL").  __GFP_NOFAIL could trigger the following
> > stack and allocate high-order pages when CONFIG_HAVE_ARCH_HUGE_VMALLOC
> > is enabled:
> > 
> >  __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
> >  alloc_pages+0x1aa/0x270 mm/mempolicy.c:2286
> >  vm_area_alloc_pages mm/vmalloc.c:2989 [inline]
> >
> >  __vmalloc_area_node mm/vmalloc.c:3057 [inline]
> >  __vmalloc_node_range+0x978/0x13c0 mm/vmalloc.c:3227
> >  kvmalloc_node+0x156/0x1a0 mm/util.c:606
> >  kvmalloc include/linux/slab.h:737 [inline]
> >  kvmalloc_array include/linux/slab.h:755 [inline]
> >  kvcalloc include/linux/slab.h:760 [inline]
> >  (codebase: Linux 6.2-rc2)
> > 
> > Don't warn such cases since high-order pages with __GFP_NOFAIL is
> > somewhat legel.
> 
> OK, this is definitely a bug and it seems my 9376130c390a was
> incomplete because it hasn't covered the high order case. Not sure how
> that happened but removing the warning is not the right thing to do
> here. The higher order allocation is an optimization rather than a must.
> So it is perfectly fine to fail that allocation and retry rather than
> go into a very expensive and potentially impossible higher order
> allocation that must not fail.
>
> 
> The proper fix should look like this unless I am missing something. I
> would appreciate another pair of eyes on this because I am not fully
> familiar with the high order optimization part much.
> 
> Thanks!
> --- 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ef910bf349e1..a8aa2765618a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2883,6 +2883,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		unsigned int order, unsigned int nr_pages, struct page **pages)
>  {
>  	unsigned int nr_allocated = 0;
> +	gfp_t alloc_gfp = gfp;
> +	bool nofail = false;
>  	struct page *page;
>  	int i;
>  
> @@ -2931,20 +2933,30 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			if (nr != nr_pages_request)
>  				break;
>  		}
> +	} else {
> +		alloc_gfp &= ~__GFP_NOFAIL;
> +		nofail = true;
>  	}
>  
>  	/* High-order pages or fallback path if "bulk" fails. */
> -
>  	while (nr_allocated < nr_pages) {
>  		if (fatal_signal_pending(current))
>  			break;
>  
>  		if (nid == NUMA_NO_NODE)
> -			page = alloc_pages(gfp, order);
> +			page = alloc_pages(alloc_gfp, order);
>  		else
> -			page = alloc_pages_node(nid, gfp, order);
> -		if (unlikely(!page))
> -			break;
> +			page = alloc_pages_node(nid, alloc_gfp, order);
> +		if (unlikely(!page)) {
> +			if (!nofail)
> +				break;
> +
> +			/* fall back to the zero order allocations */
> +			alloc_gfp |= __GFP_NOFAIL;
> +			order = 0;
> +			continue;
> +		}
> +
>  		/*
>  		 * Higher order allocations must be able to be treated as
>  		 * indepdenent small pages by callers (as they can with

Some questions:

1. Could you please add a comment why you want the bulk_gfp without the __GFP_NOFAIL(bulk path)?
2. Could you please add a comment why a high order pages do not want __GFP_NOFAIL? You have already explained.
3. Looking at the patch:

<snip>
+       } else {
+               alloc_gfp &= ~__GFP_NOFAIL;
+               nofail = true;
<snip>

if user does not want to go with __GFP_NOFAIL flag why you force it in
case a high order allocation fails and you switch to 0 order allocations? 
(for high order-pages scenario you always use __GFP_NOFAIL in the order-0 recovery path).

Thanks!

--
Uladzislau Rezki
