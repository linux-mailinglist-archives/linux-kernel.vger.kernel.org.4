Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE1E6C37B0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjCURFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCURFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:05:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A976A1C597;
        Tue, 21 Mar 2023 10:05:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66598B818F2;
        Tue, 21 Mar 2023 17:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA37AC433EF;
        Tue, 21 Mar 2023 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679418321;
        bh=Ryw9NYRw0nuNy8NwEf/bKxispBgwhvwn0lTPeZyjXcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oL42GHvfEsWUzRKNG87NgkvhI1PET29tURiRCoi3ZogYqnWbm/hu/pS6qDRFQsRTF
         IrwlH3ccAEJZMWzv8IwEwDrfvOg+Sw1pvqvOF0tZ2uHu4KKf4eUdop3LURETFosEST
         5J9QmmdKijrNm8eeerFyujJqss1jIbNT6VbeeS9zhc44B5wf5i3Z2fkCQzV+Uq6kI0
         Fe5HLROINgDk2gZciIRpZ0oRboIQyR3jOWJ27m+4Clat0MC97n8X03WpiMU/u4e0j6
         zS9JjQ/dkqJuFbc7p1AXc9meplxY89qJKy3XH7IKpBeyi2UwkZr8tCYzAayzf1zDgz
         FVPh29N1B6NDg==
Date:   Tue, 21 Mar 2023 19:05:01 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 00/14] mm: move core MM initialization to mm/mm_init.c
Message-ID: <ZBnjvRcAiqsS0K3F@kernel.org>
References: <20230321141907.2401089-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321141907.2401089-1-rppt@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Something went wrong, I'll resend the whole set.

On Tue, Mar 21, 2023 at 04:19:07PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Also in git:
> https://git.kernel.org/rppt/h/mm-init/v2
> 
> v2:
> * move init_cma_reserved_pageblock() from cma.c to mm_init.c
> * rename init_mem_debugging_and_hardening() to
>   mem_debugging_and_hardening_init()
> * inline pgtable_init() into mem_core_init()
> * add Acked and Reviewed tags (thanks David, hopefully I've picked them
>   right)
> 
> v1: https://lore.kernel.org/all/20230319220008.2138576-1-rppt@kernel.org
> This set moves most of the core MM initialization to mm/mm_init.c.
> 
> This largely includes free_area_init() and its helpers, functions used at
> boot time, mm_init() from init/main.c and some of the functions it calls.
> 
> Aside from gaining some more space before mm/page_alloc.c hits 10k lines,
> this makes mm/page_alloc.c to be mostly about buddy allocator and moves the
> init code out of the way, which IMO improves maintainability.
> 
> Besides, this allows to move a couple of declarations out of include/linux
> and make them private to mm/.
> 
> And as an added bonus there a slight decrease in vmlinux size.
> For tinyconfig and defconfig on x86 I've got
> 
> tinyconfig:
>    text	   data	    bss	    dec	    hex	filename
>  853206	 289376	1200128	2342710	 23bf36	a/vmlinux
>  853198	 289344	1200128	2342670	 23bf0e	b/vmlinux
> 
> defconfig:
>     text   	   data	    bss	    dec	    	    hex	filename
> 26152959	9730634	2170884	38054477	244aa4d	a/vmlinux
> 26152945	9730602	2170884	38054431	244aa1f	b/vmlinux
> 
> 
> Mike Rapoport (IBM) (14):
>   mips: fix comment about pgtable_init()
>   mm/page_alloc: add helper for checking if check_pages_enabled
>   mm: move most of core MM initialization to mm/mm_init.c
>   mm: handle hashdist initialization in mm/mm_init.c
>   mm/page_alloc: rename page_alloc_init() to page_alloc_init_cpuhp()
>   init: fold build_all_zonelists() and page_alloc_init_cpuhp() to mm_init()
>   init,mm: move mm_init() to mm/mm_init.c and rename it to mm_core_init()
>   mm: call {ptlock,pgtable}_cache_init() directly from mm_core_init()
>   mm: move init_mem_debugging_and_hardening() to mm/mm_init.c
>   init,mm: fold late call to page_ext_init() to page_alloc_init_late()
>   mm: move mem_init_print_info() to mm_init.c
>   mm: move kmem_cache_init() declaration to mm/slab.h
>   mm: move vmalloc_init() declaration to mm/internal.h
>   MAINTAINERS: extend memblock entry to include MM initialization
> 
>  MAINTAINERS                    |    3 +-
>  arch/mips/include/asm/fixmap.h |    2 +-
>  include/linux/gfp.h            |    7 +-
>  include/linux/mm.h             |    9 +-
>  include/linux/page_ext.h       |    2 -
>  include/linux/slab.h           |    1 -
>  include/linux/vmalloc.h        |    4 -
>  init/main.c                    |   74 +-
>  mm/cma.c                       |    1 +
>  mm/internal.h                  |   52 +-
>  mm/mm_init.c                   | 2547 +++++++++++++++++++++++++++
>  mm/page_alloc.c                | 2981 +++-----------------------------
>  mm/slab.h                      |    1 +
>  13 files changed, 2856 insertions(+), 2828 deletions(-)
> 
> 
> base-commit: 4018ab1f7cec061b8425737328edefebdc0ab832
> -- 
> 2.35.1
> 

-- 
Sincerely yours,
Mike.
