Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0088D6C4EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCVPBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjCVPBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:01:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C51915557;
        Wed, 22 Mar 2023 08:01:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0492B81CF4;
        Wed, 22 Mar 2023 15:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7036AC433EF;
        Wed, 22 Mar 2023 15:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679497264;
        bh=rK4fyj+3bFI3UORG7apfsrTb82JTbZ64Z4g0fMI2vnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JYwOpSXlIN5RJomg9drFUx2vQ9A1FIwpMJJj+jIZJnC0cpiClSkUb30pJZARvG9NS
         +wvSQkt0iZp/xLOWqCihJUOjCuNpug1wTHldt2eCzEOZ7WaaQO2Tew4SJCWAm/xA+1
         d7ZpLgkCz91H/cmsBzNIEXGLbsOZ/XIg2DdQjLHo5uhaiP6C5XoqkynRV+t02OKvqU
         ylGiRXI83yigTTWx3DJBU/IvKwUiFIE0AH/rcCqtuP4S8FWRX74PGUvg+PnBqLNAIi
         OM7KaY0l4ep0U2crJqPBDnDnc/16og4esog0Co2NoXnH1tlBf+F/OXVIp/Px4Gmgwe
         JQLPAnw8c/6qA==
Date:   Wed, 22 Mar 2023 17:00:49 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Doug Berger <opendmb@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 04/14] mm: handle hashdist initialization in
 mm/mm_init.c
Message-ID: <ZBsYIeIEjuYwyiTO@kernel.org>
References: <20230321170513.2401534-1-rppt@kernel.org>
 <20230321170513.2401534-5-rppt@kernel.org>
 <ed44b114-36f3-1ca6-726d-5187314aea49@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed44b114-36f3-1ca6-726d-5187314aea49@suse.cz>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 03:49:24PM +0100, Vlastimil Babka wrote:
> On 3/21/23 18:05, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > The hashdist variable must be initialized before the first call to
> > alloc_large_system_hash() and free_area_init() looks like a better place
> > for it than page_alloc_init().
> > 
> > Move hashdist handling to mm/mm_init.c
> > 
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > Acked-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Looks like this will move the fixup_hashdist() call earlier, but can't
> result in seeing less N_MEMORY nodes than before, right?

hashdist must be set before the first call to alloc_large_system_hash() and
after the nodes present at boot time are initialized, so setting it in the
end of free_area_init() is Ok.

> I wonder if the whole thing lacks hotplug support anyway, what if system
> boots with one node and more are added later? Hmm.

alloc_large_system_hash() is called really early even for !HASH_EARLY
cases. Not sure it's feasible to redistribute the hashes allocated with it
when new node is added.
 
> > ---
> >  mm/mm_init.c    | 22 ++++++++++++++++++++++
> >  mm/page_alloc.c | 18 ------------------
> >  2 files changed, 22 insertions(+), 18 deletions(-)
> > 
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 68d0187c7886..2e60c7186132 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -607,6 +607,25 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
> >  
> >  	return nid;
> >  }
> > +
> > +int hashdist = HASHDIST_DEFAULT;
> > +
> > +static int __init set_hashdist(char *str)
> > +{
> > +	if (!str)
> > +		return 0;
> > +	hashdist = simple_strtoul(str, &str, 0);
> > +	return 1;
> > +}
> > +__setup("hashdist=", set_hashdist);
> > +
> > +static inline void fixup_hashdist(void)
> > +{
> > +	if (num_node_state(N_MEMORY) == 1)
> > +		hashdist = 0;
> > +}
> > +#else
> > +static inline void fixup_hashdist(void) {}
> >  #endif /* CONFIG_NUMA */
> >  
> >  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> > @@ -1855,6 +1874,9 @@ void __init free_area_init(unsigned long *max_zone_pfn)
> >  	}
> >  
> >  	memmap_init();
> > +
> > +	/* disable hash distribution for systems with a single node */
> > +	fixup_hashdist();
> >  }
> >  
> >  /**
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index c56c147bdf27..ff6a2fff2880 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6383,28 +6383,10 @@ static int page_alloc_cpu_online(unsigned int cpu)
> >  	return 0;
> >  }
> >  
> > -#ifdef CONFIG_NUMA
> > -int hashdist = HASHDIST_DEFAULT;
> > -
> > -static int __init set_hashdist(char *str)
> > -{
> > -	if (!str)
> > -		return 0;
> > -	hashdist = simple_strtoul(str, &str, 0);
> > -	return 1;
> > -}
> > -__setup("hashdist=", set_hashdist);
> > -#endif
> > -
> >  void __init page_alloc_init(void)
> >  {
> >  	int ret;
> >  
> > -#ifdef CONFIG_NUMA
> > -	if (num_node_state(N_MEMORY) == 1)
> > -		hashdist = 0;
> > -#endif
> > -
> >  	ret = cpuhp_setup_state_nocalls(CPUHP_PAGE_ALLOC,
> >  					"mm/page_alloc:pcp",
> >  					page_alloc_cpu_online,
> 

-- 
Sincerely yours,
Mike.
