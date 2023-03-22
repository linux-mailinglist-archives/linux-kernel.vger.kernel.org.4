Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9CE6C57C0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjCVUfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCVUfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:35:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C61A7339D;
        Wed, 22 Mar 2023 13:26:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52401B81DE2;
        Wed, 22 Mar 2023 20:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72244C433EF;
        Wed, 22 Mar 2023 20:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679516784;
        bh=d2Ig0qp9C4JQPK9LopAdYR68a+310yC5P6WoSDTJOgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRiPLodAq6f4uCSI3TC/00b08o49Tfq6FViXnn68WMduZEVdp0rBhKGBRcjoD5sz7
         wMvnfTAwIKlRSvUqVl67wbpBP8Q9cQGlJ+QDCk6jInemOvwhPVz56qq+tG+mdBYel/
         JT/2SmAAcan/O1+n+FGGc1lY3dAfIuXWr7DUZlzf17U70VyqIlizhTeCGfG8gouLSY
         3Fkyre5yFoiEgOei9aNJweDRam1X4YoBB9moNRgNS2pJereEDBS+/XIASFzs258FEk
         Tov3cpttLPwXXKPJCKkSSO/iu29h3W6dSlzUuSnZlXNh4TvCFdfxPP9DYLlCHdapca
         aNVKYaeDdvYgg==
Date:   Wed, 22 Mar 2023 22:26:09 +0200
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
Subject: Re: [PATCH v2 06/14] init: fold build_all_zonelists() and
 page_alloc_init_cpuhp() to mm_init()
Message-ID: <ZBtkYQyxulcNV8gG@kernel.org>
References: <20230321170513.2401534-1-rppt@kernel.org>
 <20230321170513.2401534-7-rppt@kernel.org>
 <f712fa24-91f7-38e7-fd6e-b33ab52ce88c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f712fa24-91f7-38e7-fd6e-b33ab52ce88c@suse.cz>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 05:10:10PM +0100, Vlastimil Babka wrote:
> On 3/21/23 18:05, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > Both build_all_zonelists() and page_alloc_init_cpuhp() must be called
> > after SMP setup is complete but before the page allocator is set up.
> > 
> > Still, they both are a part of memory management initialization, so move
> > them to mm_init().
> 
> Well, logic grouping is one thing, but not breaking a functional order is
> more important. So this moves both calls to happen later than theyw ere. I
> guess it could only matter for page_alloc_init_cpuhp() in case cpu hotplugs
> would be processed in some of the calls we "skipped" over by moving this
> later. And one of them is setup_arch()... so are we sure no arch does some
> cpu hotplug for non-boot cpus there?

mm_init() happens after the point build_all_zonelists() and
page_alloc_init_cpuhp() were originally, so they are essentially moved
later in the init sequence and in either case called after setup_arch().

We skip the code below and it does not do neither cpu hotplug nor
non-memblock allocations.

	jump_label_init();
	parse_early_param();
	after_dashes = parse_args("Booting kernel",
				  static_command_line, __start___param,
				  __stop___param - __start___param,
				  -1, -1, NULL, &unknown_bootoption);
	print_unknown_bootoptions();
	if (!IS_ERR_OR_NULL(after_dashes))
		parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
			   NULL, set_init_arg);
	if (extra_init_args)
		parse_args("Setting extra init args", extra_init_args,
			   NULL, 0, -1, -1, NULL, set_init_arg);

	/* Architectural and non-timekeeping rng init, before allocator init */
	random_init_early(command_line);

	/*
	 * These use large bootmem allocations and must precede
	 * kmem_cache_init()
	 */
	setup_log_buf(0);
	vfs_caches_init_early();
	sort_main_extable();
	trap_init();

 
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > ---
> >  init/main.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/init/main.c b/init/main.c
> > index b2499bee7a3c..4423906177c1 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -833,6 +833,10 @@ static void __init report_meminit(void)
> >   */
> >  static void __init mm_init(void)
> >  {
> > +	/* Initializations relying on SMP setup */
> > +	build_all_zonelists(NULL);
> > +	page_alloc_init_cpuhp();
> > +
> >  	/*
> >  	 * page_ext requires contiguous pages,
> >  	 * bigger than MAX_ORDER unless SPARSEMEM.
> > @@ -968,9 +972,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
> >  	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
> >  	boot_cpu_hotplug_init();
> >  
> > -	build_all_zonelists(NULL);
> > -	page_alloc_init_cpuhp();
> > -
> >  	pr_notice("Kernel command line: %s\n", saved_command_line);
> >  	/* parameters may set static keys */
> >  	jump_label_init();
> 

-- 
Sincerely yours,
Mike.
