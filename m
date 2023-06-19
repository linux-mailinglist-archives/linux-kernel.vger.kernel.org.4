Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C285734D39
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjFSILY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFSILV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:11:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2A4B9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687162280; x=1718698280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ted8Nn1H7GufJzYooU/uOUvQapGTmM3q/NcHCiQQPPk=;
  b=SX+tLhj3nkfsjrcT0SioaLiOec9qrzAj68JtvJ0jzHYWd4PJ+53MB0xe
   grllyPs7jB6kI8T6yvyumbw9MLKdtgFy1HgaZdUsk/K9VYpUWJjY8Q5JZ
   urj/2vw0j75fqNff61yuNwICdLR2Hc85TjWOaW2RlXciKXXe1qnWvz58U
   yj9yKTt//VTXaBCmvKpuYk/kGJ1Kvod8CrpDyLVdn/xbpPT40Cg8W+kl8
   fM8fd6L9WP6rHsjvy/ZuFbe+N6zRwergJ7j7IByD4NWK94WdH+9YtzZjT
   h+xPfuPkqkIKtLIHais9qu/RpEB/r88XFwJ6j4L9JBOcx7g/kEtwIdmyD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="445951727"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="445951727"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 01:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="837787250"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="837787250"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Jun 2023 01:11:18 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qB9yn-0004Xo-1K;
        Mon, 19 Jun 2023 08:11:17 +0000
Date:   Mon, 19 Jun 2023 16:11:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Glauber <jglauber@digitalocean.com>, akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jan Glauber <jglauber@digitalocean.com>
Subject: Re: [PATCH] mm: Fix shmem THP counters on migration
Message-ID: <202306191621.KNBoT2wn-lkp@intel.com>
References: <20230619055735.141740-1-jglauber@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619055735.141740-1-jglauber@digitalocean.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Glauber/mm-Fix-shmem-THP-counters-on-migration/20230619-135947
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230619055735.141740-1-jglauber%40digitalocean.com
patch subject: [PATCH] mm: Fix shmem THP counters on migration
config: csky-randconfig-r006-20230619 (https://download.01.org/0day-ci/archive/20230619/202306191621.KNBoT2wn-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230619/202306191621.KNBoT2wn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306191621.KNBoT2wn-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/migrate.c: In function 'folio_migrate_mapping':
>> mm/migrate.c:491:64: error: 'NR_SHMEM_THP' undeclared (first use in this function); did you mean 'NR_SHMEM_THPS'?
     491 |                                 __mod_lruvec_state(old_lruvec, NR_SHMEM_THP, -nr);
         |                                                                ^~~~~~~~~~~~
         |                                                                NR_SHMEM_THPS
   mm/migrate.c:491:64: note: each undeclared identifier is reported only once for each function it appears in


vim +491 mm/migrate.c

   389	
   390	/*
   391	 * Replace the page in the mapping.
   392	 *
   393	 * The number of remaining references must be:
   394	 * 1 for anonymous pages without a mapping
   395	 * 2 for pages with a mapping
   396	 * 3 for pages with a mapping and PagePrivate/PagePrivate2 set.
   397	 */
   398	int folio_migrate_mapping(struct address_space *mapping,
   399			struct folio *newfolio, struct folio *folio, int extra_count)
   400	{
   401		XA_STATE(xas, &mapping->i_pages, folio_index(folio));
   402		struct zone *oldzone, *newzone;
   403		int dirty;
   404		int expected_count = folio_expected_refs(mapping, folio) + extra_count;
   405		long nr = folio_nr_pages(folio);
   406	
   407		if (!mapping) {
   408			/* Anonymous page without mapping */
   409			if (folio_ref_count(folio) != expected_count)
   410				return -EAGAIN;
   411	
   412			/* No turning back from here */
   413			newfolio->index = folio->index;
   414			newfolio->mapping = folio->mapping;
   415			if (folio_test_swapbacked(folio))
   416				__folio_set_swapbacked(newfolio);
   417	
   418			return MIGRATEPAGE_SUCCESS;
   419		}
   420	
   421		oldzone = folio_zone(folio);
   422		newzone = folio_zone(newfolio);
   423	
   424		xas_lock_irq(&xas);
   425		if (!folio_ref_freeze(folio, expected_count)) {
   426			xas_unlock_irq(&xas);
   427			return -EAGAIN;
   428		}
   429	
   430		/*
   431		 * Now we know that no one else is looking at the folio:
   432		 * no turning back from here.
   433		 */
   434		newfolio->index = folio->index;
   435		newfolio->mapping = folio->mapping;
   436		folio_ref_add(newfolio, nr); /* add cache reference */
   437		if (folio_test_swapbacked(folio)) {
   438			__folio_set_swapbacked(newfolio);
   439			if (folio_test_swapcache(folio)) {
   440				folio_set_swapcache(newfolio);
   441				newfolio->private = folio_get_private(folio);
   442			}
   443		} else {
   444			VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
   445		}
   446	
   447		/* Move dirty while page refs frozen and newpage not yet exposed */
   448		dirty = folio_test_dirty(folio);
   449		if (dirty) {
   450			folio_clear_dirty(folio);
   451			folio_set_dirty(newfolio);
   452		}
   453	
   454		xas_store(&xas, newfolio);
   455	
   456		/*
   457		 * Drop cache reference from old page by unfreezing
   458		 * to one less reference.
   459		 * We know this isn't the last reference.
   460		 */
   461		folio_ref_unfreeze(folio, expected_count - nr);
   462	
   463		xas_unlock(&xas);
   464		/* Leave irq disabled to prevent preemption while updating stats */
   465	
   466		/*
   467		 * If moved to a different zone then also account
   468		 * the page for that zone. Other VM counters will be
   469		 * taken care of when we establish references to the
   470		 * new page and drop references to the old page.
   471		 *
   472		 * Note that anonymous pages are accounted for
   473		 * via NR_FILE_PAGES and NR_ANON_MAPPED if they
   474		 * are mapped to swap space.
   475		 */
   476		if (newzone != oldzone) {
   477			struct lruvec *old_lruvec, *new_lruvec;
   478			struct mem_cgroup *memcg;
   479	
   480			memcg = folio_memcg(folio);
   481			old_lruvec = mem_cgroup_lruvec(memcg, oldzone->zone_pgdat);
   482			new_lruvec = mem_cgroup_lruvec(memcg, newzone->zone_pgdat);
   483	
   484			__mod_lruvec_state(old_lruvec, NR_FILE_PAGES, -nr);
   485			__mod_lruvec_state(new_lruvec, NR_FILE_PAGES, nr);
   486			if (folio_test_swapbacked(folio) && !folio_test_swapcache(folio)) {
   487				__mod_lruvec_state(old_lruvec, NR_SHMEM, -nr);
   488				__mod_lruvec_state(new_lruvec, NR_SHMEM, nr);
   489	
   490				if (folio_test_transhuge(folio)) {
 > 491					__mod_lruvec_state(old_lruvec, NR_SHMEM_THP, -nr);
   492					__mod_lruvec_state(new_lruvec, NR_SHMEM_THP, nr);
   493				}
   494			}
   495	#ifdef CONFIG_SWAP
   496			if (folio_test_swapcache(folio)) {
   497				__mod_lruvec_state(old_lruvec, NR_SWAPCACHE, -nr);
   498				__mod_lruvec_state(new_lruvec, NR_SWAPCACHE, nr);
   499			}
   500	#endif
   501			if (dirty && mapping_can_writeback(mapping)) {
   502				__mod_lruvec_state(old_lruvec, NR_FILE_DIRTY, -nr);
   503				__mod_zone_page_state(oldzone, NR_ZONE_WRITE_PENDING, -nr);
   504				__mod_lruvec_state(new_lruvec, NR_FILE_DIRTY, nr);
   505				__mod_zone_page_state(newzone, NR_ZONE_WRITE_PENDING, nr);
   506			}
   507		}
   508		local_irq_enable();
   509	
   510		return MIGRATEPAGE_SUCCESS;
   511	}
   512	EXPORT_SYMBOL(folio_migrate_mapping);
   513	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
