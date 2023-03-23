Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45816C67CB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjCWMOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCWMNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:13:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71FC25E35
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:13:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA940B820D2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E32C433D2;
        Thu, 23 Mar 2023 12:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679573615;
        bh=VrZ76/K+qnBYkpivWrPpdgSgXcTT5Pl1m97K58JOUTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eE1qaI+iAHutGSCR4EmqjCFJak3sgf3INqi4iKUvH8yKF1SnB+RjxiaSkePKDMZv+
         EGMAYCmOLY57TXtgwDKIwhrayaGKyDlL+K+u7kIuJ+xI+3W1JTsbEfUuRkbdpwswwV
         LyGhon8bh+XeQXcBYZZTh86Q3qigU1NnB8M9Wbx4TBsELids0Uukm3JUyXAJxm7XVC
         SoYwmnLGQTvOClsoas3BB8+FSRUHZdmHzN9QimizXgXs6wElLEiCkvuzoNwA0GnyaU
         pbHOpWL+wMOl82Ctm6de2QphYLXVxbMPp+mqzpOBrNHR1YJAF3Pr0o0nGirZv3dV+v
         VraJHQf0rC1gg==
Date:   Thu, 23 Mar 2023 14:13:22 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: arch/sparc/mm/tsb.c:405:39: error: left shift count is negative
Message-ID: <ZBxCYk6O6M9p9wB0@kernel.org>
References: <202303231810.eJX8zyTf-lkp@intel.com>
 <91E887E4-0867-421F-9C75-FB9CFF15C33A@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91E887E4-0867-421F-9C75-FB9CFF15C33A@nvidia.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 07:50:01AM -0400, Zi Yan wrote:
> On 23 Mar 2023, at 6:40, kernel test robot wrote:
> 
> > Hi Zi,
> >
> > FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   fff5a5e7f528b2ed2c335991399a766c2cf01103
> > commit: 0192445cb2f7ed1cd7a95a0fc8c7645480baba25 arch: mm: rename FORCE_MAX_ZONEORDER to ARCH_FORCE_MAX_ORDER
> > date:   6 months ago
> > config: sparc64-buildonly-randconfig-r002-20230322 (https://download.01.org/0day-ci/archive/20230323/202303231810.eJX8zyTf-lkp@intel.com/config)
> 
> Cc Mike, since he is working on ARCH_FORCE_MAX_ORDER.
> 
> This random config sets CONFIG_ARCH_FORCE_MAX_ORDER to -1, causing this error. I am not sure if we need to always set a range for ARCH_FORCE_MAX_ORDER or random config generator should be changed to not use non-positive values.

I believe it's the same issue as with Kirill's MAX_ORDER change [1].
Apparently kbuild used an old config as the template and renaming of
Kconfig option caused it to be set to -1.
_
[1] https://lore.kernel.org/all/202303201615.Qfu18nWV-lkp@intel.com/
 
> BTW, this issue pre-exists my changes.
> 
> > compiler: sparc64-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0192445cb2f7ed1cd7a95a0fc8c7645480baba25
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 0192445cb2f7ed1cd7a95a0fc8c7645480baba25
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 olddefconfig
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash arch/sparc/mm/ drivers/base/regmap/ drivers/media/usb/em28xx/
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link: https://lore.kernel.org/oe-kbuild-all/202303231810.eJX8zyTf-lkp@intel.com/
> >
> > All error/warnings (new ones prefixed by >>):
> >
> >    In file included from include/linux/gfp.h:7,
> >                     from include/linux/slab.h:15,
> >                     from arch/sparc/mm/tsb.c:9:
> >    include/linux/mmzone.h:636:33: error: size of array 'free_area' is negative
> >      636 |         struct free_area        free_area[MAX_ORDER];
> >          |                                 ^~~~~~~~~
> >    arch/sparc/mm/tsb.c: In function 'tsb_grow':
> >>> arch/sparc/mm/tsb.c:405:39: error: left shift count is negative [-Werror=shift-count-negative]
> >      405 |         if (max_tsb_size > (PAGE_SIZE << MAX_ORDER))
> >          |                                       ^~
> >    arch/sparc/mm/tsb.c:406:43: error: left shift count is negative [-Werror=shift-count-negative]
> >      406 |                 max_tsb_size = (PAGE_SIZE << MAX_ORDER);
> >          |                                           ^~
> >    cc1: all warnings being treated as errors
> > --
> >    In file included from include/linux/gfp.h:7,
> >                     from include/linux/slab.h:15,
> >                     from drivers/base/regmap/regmap-debugfs.c:9:
> >    include/linux/mmzone.h:636:33: error: size of array 'free_area' is negative
> >      636 |         struct free_area        free_area[MAX_ORDER];
> >          |                                 ^~~~~~~~~
> >    drivers/base/regmap/regmap-debugfs.c: In function 'regmap_read_debugfs':
> >>> drivers/base/regmap/regmap-debugfs.c:229:32: warning: left shift count is negative [-Wshift-count-negative]
> >      229 |         if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
> >          |                                ^~
> >    drivers/base/regmap/regmap-debugfs.c:230:35: warning: left shift count is negative [-Wshift-count-negative]
> >      230 |                 count = PAGE_SIZE << (MAX_ORDER - 1);
> >          |                                   ^~
> >    drivers/base/regmap/regmap-debugfs.c: In function 'regmap_reg_ranges_read_file':
> >    drivers/base/regmap/regmap-debugfs.c:376:32: warning: left shift count is negative [-Wshift-count-negative]
> >      376 |         if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
> >          |                                ^~
> >    drivers/base/regmap/regmap-debugfs.c:377:35: warning: left shift count is negative [-Wshift-count-negative]
> >      377 |                 count = PAGE_SIZE << (MAX_ORDER - 1);
> >          |                                   ^~
> > --
> >    In file included from include/linux/gfp.h:7,
> >                     from include/linux/xarray.h:15,
> >                     from include/linux/radix-tree.h:21,
> >                     from include/linux/idr.h:15,
> >                     from include/linux/kernfs.h:12,
> >                     from include/linux/sysfs.h:16,
> >                     from include/linux/kobject.h:20,
> >                     from include/linux/of.h:17,
> >                     from include/linux/irqdomain.h:35,
> >                     from include/linux/acpi.h:13,
> >                     from include/linux/i2c.h:13,
> >                     from drivers/media/usb/em28xx/em28xx.h:22,
> >                     from drivers/media/usb/em28xx/em28xx-audio.c:14:
> >    include/linux/mmzone.h:636:33: error: size of array 'free_area' is negative
> >      636 |         struct free_area        free_area[MAX_ORDER];
> >          |                                 ^~~~~~~~~
> >    drivers/media/usb/em28xx/em28xx-audio.c: In function 'em28xx_audio_init':
> >>> drivers/media/usb/em28xx/em28xx-audio.c:808:29: warning: variable 'devnr' set but not used [-Wunused-but-set-variable]
> >      808 |         static int          devnr;
> >          |                             ^~~~~
> >    drivers/media/usb/em28xx/em28xx-audio.c: At top level:
> >    drivers/media/usb/em28xx/em28xx-audio.c:47:12: warning: 'index' defined but not used [-Wunused-variable]
> >       47 | static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
> >          |            ^~~~~
> >
> >
> > vim +405 arch/sparc/mm/tsb.c
> >
> > 0871420fad5844 arch/sparc/mm/tsb.c   David S. Miller 2008-11-16  379
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  380  /* When the RSS of an address space exceeds tsb_rss_limit for a TSB,
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  381   * do_sparc64_fault() invokes this routine to try and grow it.
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  382   *
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  383   * When we reach the maximum TSB size supported, we stick ~0UL into
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  384   * tsb_rss_limit for that TSB so the grow checks in do_sparc64_fault()
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  385   * will not trigger any longer.
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  386   *
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  387   * The TSB can be anywhere from 8K to 1MB in size, in increasing powers
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  388   * of two.  The TSB must be aligned to it's size, so f.e. a 512K TSB
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  389   * must be 512K aligned.  It also must be physically contiguous, so we
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  390   * cannot use vmalloc().
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  391   *
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  392   * The idea here is to grow the TSB when the RSS of the process approaches
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  393   * the number of entries that the current TSB can hold at once.  Currently,
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  394   * we trigger when the RSS hits 3/4 of the TSB capacity.
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  395   */
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  396  void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  397  {
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  398  	unsigned long max_tsb_size = 1 * 1024 * 1024;
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  399  	unsigned long new_size, old_size, flags;
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  400  	struct tsb *old_tsb, *new_tsb;
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  401  	unsigned long new_cache_index, old_cache_index;
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  402  	unsigned long new_rss_limit;
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  403  	gfp_t gfp_flags;
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  404
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31 @405  	if (max_tsb_size > (PAGE_SIZE << MAX_ORDER))
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  406  		max_tsb_size = (PAGE_SIZE << MAX_ORDER);
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  407
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  408  	new_cache_index = 0;
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  409  	for (new_size = 8192; new_size < max_tsb_size; new_size <<= 1UL) {
> > 0871420fad5844 arch/sparc/mm/tsb.c   David S. Miller 2008-11-16  410  		new_rss_limit = tsb_size_to_rss_limit(new_size);
> > 0871420fad5844 arch/sparc/mm/tsb.c   David S. Miller 2008-11-16  411  		if (new_rss_limit > rss)
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  412  			break;
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  413  		new_cache_index++;
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  414  	}
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  415
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  416  	if (new_size == max_tsb_size)
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  417  		new_rss_limit = ~0UL;
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  418
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  419  retry_tsb_alloc:
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  420  	gfp_flags = GFP_KERNEL;
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  421  	if (new_size > (PAGE_SIZE * 2))
> > a55ee1ff751f88 arch/sparc/mm/tsb.c   David S. Miller 2013-02-19  422  		gfp_flags |= __GFP_NOWARN | __GFP_NORETRY;
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  423
> > 1f261ef53ba066 arch/sparc64/mm/tsb.c David S. Miller 2008-03-19  424  	new_tsb = kmem_cache_alloc_node(tsb_caches[new_cache_index],
> > 1f261ef53ba066 arch/sparc64/mm/tsb.c David S. Miller 2008-03-19  425  					gfp_flags, numa_node_id());
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  426  	if (unlikely(!new_tsb)) {
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  427  		/* Not being able to fork due to a high-order TSB
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  428  		 * allocation failure is very bad behavior.  Just back
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  429  		 * down to a 0-order allocation and force no TSB
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  430  		 * growing for this address space.
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  431  		 */
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  432  		if (mm->context.tsb_block[tsb_index].tsb == NULL &&
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  433  		    new_cache_index > 0) {
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  434  			new_cache_index = 0;
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  435  			new_size = 8192;
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  436  			new_rss_limit = ~0UL;
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  437  			goto retry_tsb_alloc;
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  438  		}
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  439
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  440  		/* If we failed on a TSB grow, we are under serious
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  441  		 * memory pressure so don't try to grow any more.
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  442  		 */
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  443  		if (mm->context.tsb_block[tsb_index].tsb != NULL)
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  444  			mm->context.tsb_block[tsb_index].tsb_rss_limit = ~0UL;
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  445  		return;
> > b52439c22c63db arch/sparc64/mm/tsb.c David S. Miller 2006-03-17  446  	}
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  447
> > 8b234274418d6d arch/sparc64/mm/tsb.c David S. Miller 2006-02-17  448  	/* Mark all tags as invalid.  */
> > bb8646d8340fa7 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  449  	tsb_init(new_tsb, new_size);
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  450
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  451  	/* Ok, we are about to commit the changes.  If we are
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  452  	 * growing an existing TSB the locking is very tricky,
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  453  	 * so WATCH OUT!
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  454  	 *
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  455  	 * We have to hold mm->context.lock while committing to the
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  456  	 * new TSB, this synchronizes us with processors in
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  457  	 * flush_tsb_user() and switch_mm() for this address space.
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  458  	 *
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  459  	 * But even with that lock held, processors run asynchronously
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  460  	 * accessing the old TSB via TLB miss handling.  This is OK
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  461  	 * because those actions are just propagating state from the
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  462  	 * Linux page tables into the TSB, page table mappings are not
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  463  	 * being changed.  If a real fault occurs, the processor will
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  464  	 * synchronize with us when it hits flush_tsb_user(), this is
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  465  	 * also true for the case where vmscan is modifying the page
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  466  	 * tables.  The only thing we need to be careful with is to
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  467  	 * skip any locked TSB entries during copy_tsb().
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  468  	 *
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  469  	 * When we finish committing to the new TSB, we have to drop
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  470  	 * the lock and ask all other cpus running this address space
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  471  	 * to run tsb_context_switch() to see the new TSB table.
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  472  	 */
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  473  	spin_lock_irqsave(&mm->context.lock, flags);
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  474
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  475  	old_tsb = mm->context.tsb_block[tsb_index].tsb;
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  476  	old_cache_index =
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  477  		(mm->context.tsb_block[tsb_index].tsb_reg_val & 0x7UL);
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  478  	old_size = (mm->context.tsb_block[tsb_index].tsb_nentries *
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  479  		    sizeof(struct tsb));
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  480
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  481
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  482  	/* Handle multiple threads trying to grow the TSB at the same time.
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  483  	 * One will get in here first, and bump the size and the RSS limit.
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  484  	 * The others will get in here next and hit this check.
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  485  	 */
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  486  	if (unlikely(old_tsb &&
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  487  		     (rss < mm->context.tsb_block[tsb_index].tsb_rss_limit))) {
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  488  		spin_unlock_irqrestore(&mm->context.lock, flags);
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  489
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  490  		kmem_cache_free(tsb_caches[new_cache_index], new_tsb);
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  491  		return;
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  492  	}
> > 8b234274418d6d arch/sparc64/mm/tsb.c David S. Miller 2006-02-17  493
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  494  	mm->context.tsb_block[tsb_index].tsb_rss_limit = new_rss_limit;
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  495
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  496  	if (old_tsb) {
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  497  		extern void copy_tsb(unsigned long old_tsb_base,
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  498  				     unsigned long old_tsb_size,
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  499  				     unsigned long new_tsb_base,
> > 654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  500  				     unsigned long new_tsb_size,
> > 654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  501  				     unsigned long page_size_shift);
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  502  		unsigned long old_tsb_base = (unsigned long) old_tsb;
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  503  		unsigned long new_tsb_base = (unsigned long) new_tsb;
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  504
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  505  		if (tlb_type == cheetah_plus || tlb_type == hypervisor) {
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  506  			old_tsb_base = __pa(old_tsb_base);
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  507  			new_tsb_base = __pa(new_tsb_base);
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  508  		}
> > 654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  509  		copy_tsb(old_tsb_base, old_size, new_tsb_base, new_size,
> > 654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  510  			tsb_index == MM_TSB_BASE ?
> > 654f4807624a65 arch/sparc/mm/tsb.c   Mike Kravetz    2017-06-02  511  			PAGE_SHIFT : REAL_HPAGE_SHIFT);
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  512  	}
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  513
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  514  	mm->context.tsb_block[tsb_index].tsb = new_tsb;
> > dcc1e8dd88d4bc arch/sparc64/mm/tsb.c David S. Miller 2006-03-22  515  	setup_tsb_params(mm, tsb_index, new_size);
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  516
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  517  	spin_unlock_irqrestore(&mm->context.lock, flags);
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  518
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  519  	/* If old_tsb is NULL, we're being invoked for the first time
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  520  	 * from init_new_context().
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  521  	 */
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  522  	if (old_tsb) {
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  523  		/* Reload it on the local cpu.  */
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  524  		tsb_context_switch(mm);
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  525
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  526  		/* Now force other processors to do the same.  */
> > a3cf5e6b6f2548 arch/sparc64/mm/tsb.c David S. Miller 2008-08-03  527  		preempt_disable();
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  528  		smp_tsb_sync(mm);
> > a3cf5e6b6f2548 arch/sparc64/mm/tsb.c David S. Miller 2008-08-03  529  		preempt_enable();
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  530
> > 7a1ac5264108fc arch/sparc64/mm/tsb.c David S. Miller 2006-03-16  531  		/* Now it is safe to free the old tsb.  */
> > 9b4006dcf6a8c4 arch/sparc64/mm/tsb.c David S. Miller 2006-03-18  532  		kmem_cache_free(tsb_caches[old_cache_index], old_tsb);
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  533  	}
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  534  }
> > bd40791e1d289d arch/sparc64/mm/tsb.c David S. Miller 2006-01-31  535
> >
> > :::::: The code at line 405 was first introduced by commit
> > :::::: bd40791e1d289d807b8580abe1f117e9c62894e4 [SPARC64]: Dynamically grow TSB in response to RSS growth.
> >
> > :::::: TO: David S. Miller <davem@davemloft.net>
> > :::::: CC: David S. Miller <davem@sunset.davemloft.net>
> >
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests
> 
> --
> Best Regards,
> Yan, Zi



-- 
Sincerely yours,
Mike.
