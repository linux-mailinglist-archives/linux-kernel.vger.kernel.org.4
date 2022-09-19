Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06945BCC5B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiISM7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiISM7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:59:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384CB20F77
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:59:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id l65so27987421pfl.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=zQfDWI1igyb60y77p+jlrfSAaSINkE3aQ82qQHnkWJw=;
        b=NfN2cN6zcQbs0Cod7IguKf68/HnL0b1H6aLswTrPbve4XL1uiXf+R4jBP9tvBMGG0F
         Ju28dyfy6gc8DCIRHVJqNsxID2WpH5tCa/mD3swMVtylKH0Q7VnIWMNqxByrxdvtzrPW
         qSA5k/jdHmE9miOqxGxo6BQ1YaMGseuYkgHnSXjozBCDvvOmuvTDTgU6H93a+kQxAmeA
         Vu5ApXtBzew6nb8DIM5haw/+dHIfk03w94YquuVD7GlSqa7UPIsDw0TDzGxmcpiJChrj
         3eI4Zl1E5VxL3JzB6NnApYxgpSc1Fg/6iTKgJ5yTtaYNhbn7je6w3fn54MX/X40OhTar
         OY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zQfDWI1igyb60y77p+jlrfSAaSINkE3aQ82qQHnkWJw=;
        b=BtyhsakB+52f6eM871B5xhzWgmxd0undpLOQxr9TkZpFJevSnuIz/nPljaOFNG6h1s
         hba7XuZTU38h4fiGSJqfUahc8Ee/uIDMGLRcYuMf/JZxnOsGeAH4ceV0EToGqGaGj/IM
         GYpgiMnat+BZBJD3Ps5DrPvWf/EM2C39zm8h+Qzi7HiDjc4hzhdWWDWQlOTJtGObeR0+
         ry2lMBt9oVjnjnAuA6Yr5co5PSMrBiGHafq94Pp+wYcVn8lvuYZb0hTST9mITHZUrWJ4
         pmlRs8voNCYh0nPsU1B2FIRSCEa/EoyawlU9ik33bvqjATaafMNu2lsg2wXPHZDtmfC3
         RHgA==
X-Gm-Message-State: ACrzQf1uERWSjbowojEEelwZhU6atixpHXHpi2J5v17O7FE9sLmFnw87
        9FYu/hczWu5V4ud56yU2Rwg=
X-Google-Smtp-Source: AMsMyM6gClp1WpJ2wREiuYk1/TuSNNXVpItw6DhT52ypFLSfHeWk91C0yfmoMho+tP0I13bH9z+IMQ==
X-Received: by 2002:a05:6a00:140d:b0:52a:d561:d991 with SMTP id l13-20020a056a00140d00b0052ad561d991mr18431245pfu.46.1663592348613;
        Mon, 19 Sep 2022 05:59:08 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id n10-20020a170903404a00b00172d9f6e22bsm20267744pla.15.2022.09.19.05.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 05:59:08 -0700 (PDT)
Date:   Mon, 19 Sep 2022 21:59:00 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>
Subject: Re: [RFC PATCH] mm: move PG_slab flag to page_type
Message-ID: <YyhnlHcIsQyaUScf@hyeyoo>
References: <20220919125708.276864-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919125708.276864-1-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 09:57:08PM +0900, Hyeonggon Yoo wrote:
> For now, only SLAB uses _mapcount field as a number of active objects in
> a slab, and other slab allocators do not use it. As 16 bits are enough
> for that, use remaining 16 bits of _mapcount as page_type even when
> SLAB is used. And then move PG_slab flag to page_type!
> 
> Note that page_type is always placed in upper 16 bits of _mapcount to
> avoid confusing normal _mapcount as page_type. As underflow (actually
> I mean, yeah, overflow) is not a concern anymore, use more lower bits
> except bit zero.
> 
> Add more folio helpers for PAGE_TYPE_OPS() not to break existing
> slab implementations.
> 
> Remove PG_slab check from PAGE_FLAGS_CHECK_AT_FREE. buddy will still
> check if _mapcount is properly set at free.
> 
> Exclude PG_slab from hwpoison and show_page_flags() for now.
> 
> Note that with this patch, page_mapped() and folio_mapped() always return
> false for slab page.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Marco Elver <elver@google.com>
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
> 
> I think this gives us two benefits:
> - it frees a bit in flags field
> - it makes it simpler to distinguish user-mapped pages and
>   not-user-mapped pages.
> 
> Plus I'm writing a bit more of code including:
> 	0) a few cleanup for code that checks
> 	   !PageSlab() && page_mapped() or that does similar thing
> 	1) provide human-readale string of page_type in dump_page
> 	2) add show_page_types() for tracepoint
> 	3) fix hwpoison ...etc.
> 
> Anyway This is an early RFC, I will very appreciate feedbacks!

Looks like I forgot to add RFC in subject :)
