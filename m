Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927C77281E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbjFHN5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjFHN5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:57:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813D0E2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686232622; x=1717768622;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7mRXeG9wK0kgCJ051kzG00OwoIM5zBwy4fSNDiQyl0M=;
  b=JBRoPhDTO8FQBR8v5OZyBR126Ebg8yjfPgdW0jYjatqRYoWnKWlStIyk
   C1lD/o7FU4wIYIEkkUEpSFSe8REYDHC4XipGRXJvyM6VmhXtWKDRPExND
   mkMmTToOWa+rvbwzGbxzahVvdoyzmYn8tXT8oQdZoD97bbT1nnm95QsKX
   vB4uBg527tICPoRRy8y2HsUy+pUSZV3aG4Wm2huRfQJ2a1NJ8SxVmGi/8
   YBvaiqcyMMb7Bh4iEYoc9U55jMog7N6pD0syyoEsG/JiRzLErRtZ5FxvU
   6a7kFJg8466dJ4i4GKbTlzNBRY0BAiAlIxsXgYVTyDWXMFUEol3udszEz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="423171741"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="423171741"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 06:25:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956703637"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="956703637"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2023 06:25:12 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7FdX-0007p0-1m;
        Thu, 08 Jun 2023 13:25:11 +0000
Date:   Thu, 8 Jun 2023 21:24:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: fs/ext4/inode.c:2715:12: warning: stack frame size (2656) exceeds
 limit (2048) in 'ext4_do_writepages'
Message-ID: <202306082121.YlBwfVAE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f63595ebd82f56a2dd36ca013dd7f5ff2e2416a
commit: 15648d599cd1c15cc678039dcab65599276fe407 ext4: provide ext4_do_writepages()
date:   6 months ago
config: riscv-randconfig-r012-20230608 (https://download.01.org/0day-ci/archive/20230608/202306082121.YlBwfVAE-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=15648d599cd1c15cc678039dcab65599276fe407
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 15648d599cd1c15cc678039dcab65599276fe407
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/ fs/ext4/ fs/f2fs/ kernel/bpf/ lib/zstd/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306082121.YlBwfVAE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ext4/inode.c:2715:12: warning: stack frame size (2656) exceeds limit (2048) in 'ext4_do_writepages' [-Wframe-larger-than]
   static int ext4_do_writepages(struct mpage_da_data *mpd)
              ^
   1 warning generated.


vim +/ext4_do_writepages +2715 fs/ext4/inode.c

  2714	
> 2715	static int ext4_do_writepages(struct mpage_da_data *mpd)
  2716	{
  2717		struct writeback_control *wbc = mpd->wbc;
  2718		pgoff_t	writeback_index = 0;
  2719		long nr_to_write = wbc->nr_to_write;
  2720		int range_whole = 0;
  2721		int cycled = 1;
  2722		handle_t *handle = NULL;
  2723		struct inode *inode = mpd->inode;
  2724		struct address_space *mapping = inode->i_mapping;
  2725		int needed_blocks, rsv_blocks = 0, ret = 0;
  2726		struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
  2727		struct blk_plug plug;
  2728		bool give_up_on_write = false;
  2729	
  2730		if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
  2731			return -EIO;
  2732	
  2733		percpu_down_read(&sbi->s_writepages_rwsem);
  2734		trace_ext4_writepages(inode, wbc);
  2735	
  2736		/*
  2737		 * No pages to write? This is mainly a kludge to avoid starting
  2738		 * a transaction for special inodes like journal inode on last iput()
  2739		 * because that could violate lock ordering on umount
  2740		 */
  2741		if (!mapping->nrpages || !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
  2742			goto out_writepages;
  2743	
  2744		if (ext4_should_journal_data(inode)) {
  2745			ret = generic_writepages(mapping, wbc);
  2746			goto out_writepages;
  2747		}
  2748	
  2749		/*
  2750		 * If the filesystem has aborted, it is read-only, so return
  2751		 * right away instead of dumping stack traces later on that
  2752		 * will obscure the real source of the problem.  We test
  2753		 * EXT4_MF_FS_ABORTED instead of sb->s_flag's SB_RDONLY because
  2754		 * the latter could be true if the filesystem is mounted
  2755		 * read-only, and in that case, ext4_writepages should
  2756		 * *never* be called, so if that ever happens, we would want
  2757		 * the stack trace.
  2758		 */
  2759		if (unlikely(ext4_forced_shutdown(EXT4_SB(mapping->host->i_sb)) ||
  2760			     ext4_test_mount_flag(inode->i_sb, EXT4_MF_FS_ABORTED))) {
  2761			ret = -EROFS;
  2762			goto out_writepages;
  2763		}
  2764	
  2765		/*
  2766		 * If we have inline data and arrive here, it means that
  2767		 * we will soon create the block for the 1st page, so
  2768		 * we'd better clear the inline data here.
  2769		 */
  2770		if (ext4_has_inline_data(inode)) {
  2771			/* Just inode will be modified... */
  2772			handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
  2773			if (IS_ERR(handle)) {
  2774				ret = PTR_ERR(handle);
  2775				goto out_writepages;
  2776			}
  2777			BUG_ON(ext4_test_inode_state(inode,
  2778					EXT4_STATE_MAY_INLINE_DATA));
  2779			ext4_destroy_inline_data(handle, inode);
  2780			ext4_journal_stop(handle);
  2781		}
  2782	
  2783		if (ext4_should_dioread_nolock(inode)) {
  2784			/*
  2785			 * We may need to convert up to one extent per block in
  2786			 * the page and we may dirty the inode.
  2787			 */
  2788			rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
  2789							PAGE_SIZE >> inode->i_blkbits);
  2790		}
  2791	
  2792		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
  2793			range_whole = 1;
  2794	
  2795		if (wbc->range_cyclic) {
  2796			writeback_index = mapping->writeback_index;
  2797			if (writeback_index)
  2798				cycled = 0;
  2799			mpd->first_page = writeback_index;
  2800			mpd->last_page = -1;
  2801		} else {
  2802			mpd->first_page = wbc->range_start >> PAGE_SHIFT;
  2803			mpd->last_page = wbc->range_end >> PAGE_SHIFT;
  2804		}
  2805	
  2806		ext4_io_submit_init(&mpd->io_submit, wbc);
  2807	retry:
  2808		if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
  2809			tag_pages_for_writeback(mapping, mpd->first_page,
  2810						mpd->last_page);
  2811		blk_start_plug(&plug);
  2812	
  2813		/*
  2814		 * First writeback pages that don't need mapping - we can avoid
  2815		 * starting a transaction unnecessarily and also avoid being blocked
  2816		 * in the block layer on device congestion while having transaction
  2817		 * started.
  2818		 */
  2819		mpd->do_map = 0;
  2820		mpd->scanned_until_end = 0;
  2821		mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
  2822		if (!mpd->io_submit.io_end) {
  2823			ret = -ENOMEM;
  2824			goto unplug;
  2825		}
  2826		ret = mpage_prepare_extent_to_map(mpd);
  2827		/* Unlock pages we didn't use */
  2828		mpage_release_unused_pages(mpd, false);
  2829		/* Submit prepared bio */
  2830		ext4_io_submit(&mpd->io_submit);
  2831		ext4_put_io_end_defer(mpd->io_submit.io_end);
  2832		mpd->io_submit.io_end = NULL;
  2833		if (ret < 0)
  2834			goto unplug;
  2835	
  2836		while (!mpd->scanned_until_end && wbc->nr_to_write > 0) {
  2837			/* For each extent of pages we use new io_end */
  2838			mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
  2839			if (!mpd->io_submit.io_end) {
  2840				ret = -ENOMEM;
  2841				break;
  2842			}
  2843	
  2844			WARN_ON_ONCE(!mpd->can_map);
  2845			/*
  2846			 * We have two constraints: We find one extent to map and we
  2847			 * must always write out whole page (makes a difference when
  2848			 * blocksize < pagesize) so that we don't block on IO when we
  2849			 * try to write out the rest of the page. Journalled mode is
  2850			 * not supported by delalloc.
  2851			 */
  2852			BUG_ON(ext4_should_journal_data(inode));
  2853			needed_blocks = ext4_da_writepages_trans_blocks(inode);
  2854	
  2855			/* start a new transaction */
  2856			handle = ext4_journal_start_with_reserve(inode,
  2857					EXT4_HT_WRITE_PAGE, needed_blocks, rsv_blocks);
  2858			if (IS_ERR(handle)) {
  2859				ret = PTR_ERR(handle);
  2860				ext4_msg(inode->i_sb, KERN_CRIT, "%s: jbd2_start: "
  2861				       "%ld pages, ino %lu; err %d", __func__,
  2862					wbc->nr_to_write, inode->i_ino, ret);
  2863				/* Release allocated io_end */
  2864				ext4_put_io_end(mpd->io_submit.io_end);
  2865				mpd->io_submit.io_end = NULL;
  2866				break;
  2867			}
  2868			mpd->do_map = 1;
  2869	
  2870			trace_ext4_da_write_pages(inode, mpd->first_page, wbc);
  2871			ret = mpage_prepare_extent_to_map(mpd);
  2872			if (!ret && mpd->map.m_len)
  2873				ret = mpage_map_and_submit_extent(handle, mpd,
  2874						&give_up_on_write);
  2875			/*
  2876			 * Caution: If the handle is synchronous,
  2877			 * ext4_journal_stop() can wait for transaction commit
  2878			 * to finish which may depend on writeback of pages to
  2879			 * complete or on page lock to be released.  In that
  2880			 * case, we have to wait until after we have
  2881			 * submitted all the IO, released page locks we hold,
  2882			 * and dropped io_end reference (for extent conversion
  2883			 * to be able to complete) before stopping the handle.
  2884			 */
  2885			if (!ext4_handle_valid(handle) || handle->h_sync == 0) {
  2886				ext4_journal_stop(handle);
  2887				handle = NULL;
  2888				mpd->do_map = 0;
  2889			}
  2890			/* Unlock pages we didn't use */
  2891			mpage_release_unused_pages(mpd, give_up_on_write);
  2892			/* Submit prepared bio */
  2893			ext4_io_submit(&mpd->io_submit);
  2894	
  2895			/*
  2896			 * Drop our io_end reference we got from init. We have
  2897			 * to be careful and use deferred io_end finishing if
  2898			 * we are still holding the transaction as we can
  2899			 * release the last reference to io_end which may end
  2900			 * up doing unwritten extent conversion.
  2901			 */
  2902			if (handle) {
  2903				ext4_put_io_end_defer(mpd->io_submit.io_end);
  2904				ext4_journal_stop(handle);
  2905			} else
  2906				ext4_put_io_end(mpd->io_submit.io_end);
  2907			mpd->io_submit.io_end = NULL;
  2908	
  2909			if (ret == -ENOSPC && sbi->s_journal) {
  2910				/*
  2911				 * Commit the transaction which would
  2912				 * free blocks released in the transaction
  2913				 * and try again
  2914				 */
  2915				jbd2_journal_force_commit_nested(sbi->s_journal);
  2916				ret = 0;
  2917				continue;
  2918			}
  2919			/* Fatal error - ENOMEM, EIO... */
  2920			if (ret)
  2921				break;
  2922		}
  2923	unplug:
  2924		blk_finish_plug(&plug);
  2925		if (!ret && !cycled && wbc->nr_to_write > 0) {
  2926			cycled = 1;
  2927			mpd->last_page = writeback_index - 1;
  2928			mpd->first_page = 0;
  2929			goto retry;
  2930		}
  2931	
  2932		/* Update index */
  2933		if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
  2934			/*
  2935			 * Set the writeback_index so that range_cyclic
  2936			 * mode will write it back later
  2937			 */
  2938			mapping->writeback_index = mpd->first_page;
  2939	
  2940	out_writepages:
  2941		trace_ext4_writepages_result(inode, wbc, ret,
  2942					     nr_to_write - wbc->nr_to_write);
  2943		percpu_up_read(&sbi->s_writepages_rwsem);
  2944		return ret;
  2945	}
  2946	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
