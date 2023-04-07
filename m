Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA776DB19E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjDGRaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDGRaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:30:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0167AD14
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680888599; x=1712424599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CYXKLadMU6YmZuv3O6s2W7HbQyKFPZXnKCtATk9B7q0=;
  b=MJYLIxCE0i3eGKklCQjbAyVRDs+mdMx25Xp9bLi3fSbVGBzO/CL2IknO
   zjyYV8r6HzyKcO/SSofcc2qzldtn4vB1RFORnPiMJ0x+nTD7HP1IbWWHY
   uls5XViPyk6NqWub2RLCMTcz7HnQf+50DUi0XnElwVtmzM2W1qNSGiH1m
   IAmwz5yl5vY+1FZ24TRrLw28OX+fNqHYWrh9r8u3z20zkUwUzhnfmRaF+
   Ijp7ee1EnluB4UrRZcAAiEDFJw1SqoZBg51iqMHRKKj9hYl75nDyygwRX
   rEvvaE/07bNcScnI9lzUsBxEaFNIA5MWyzSYgl+2COgMzpiGDkZLV7LBg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="340523053"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="340523053"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="690125363"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="690125363"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 07 Apr 2023 10:29:57 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkpuO-000Sji-1Y;
        Fri, 07 Apr 2023 17:29:56 +0000
Date:   Sat, 8 Apr 2023 01:29:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] erofs: enable long extended attribute name prefixes
Message-ID: <202304080101.D8cyKOoF-lkp@intel.com>
References: <20230407141710.113882-8-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407141710.113882-8-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingbo,

kernel test robot noticed the following build errors:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev]
[cannot apply to xiang-erofs/fixes linus/master v6.3-rc5 next-20230406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jingbo-Xu/erofs-keep-meta-inode-into-erofs_buf/20230407-221839
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20230407141710.113882-8-jefflexu%40linux.alibaba.com
patch subject: [PATCH 7/7] erofs: enable long extended attribute name prefixes
config: alpha-randconfig-r026-20230403 (https://download.01.org/0day-ci/archive/20230408/202304080101.D8cyKOoF-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8cd5bbc6f857d54388099c30c3e3a48fdb15c283
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jingbo-Xu/erofs-keep-meta-inode-into-erofs_buf/20230407-221839
        git checkout 8cd5bbc6f857d54388099c30c3e3a48fdb15c283
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash fs/erofs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304080101.D8cyKOoF-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/erofs/super.c: In function 'erofs_read_superblock':
>> fs/erofs/super.c:394:12: error: 'struct erofs_sb_info' has no member named 'xattr_prefix_start'
     394 |         sbi->xattr_prefix_start = le32_to_cpu(dsb->xattr_prefix_start);
         |            ^~
>> fs/erofs/super.c:395:12: error: 'struct erofs_sb_info' has no member named 'xattr_prefix_count'
     395 |         sbi->xattr_prefix_count = dsb->xattr_prefix_count;
         |            ^~


vim +394 fs/erofs/super.c

   333	
   334	static int erofs_read_superblock(struct super_block *sb)
   335	{
   336		struct erofs_sb_info *sbi;
   337		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
   338		struct erofs_super_block *dsb;
   339		void *data;
   340		int ret;
   341	
   342		data = erofs_read_metabuf(&buf, sb, 0, EROFS_KMAP);
   343		if (IS_ERR(data)) {
   344			erofs_err(sb, "cannot read erofs superblock");
   345			return PTR_ERR(data);
   346		}
   347	
   348		sbi = EROFS_SB(sb);
   349		dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
   350	
   351		ret = -EINVAL;
   352		if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
   353			erofs_err(sb, "cannot find valid erofs superblock");
   354			goto out;
   355		}
   356	
   357		sbi->blkszbits  = dsb->blkszbits;
   358		if (sbi->blkszbits < 9 || sbi->blkszbits > PAGE_SHIFT) {
   359			erofs_err(sb, "blkszbits %u isn't supported", sbi->blkszbits);
   360			goto out;
   361		}
   362		if (dsb->dirblkbits) {
   363			erofs_err(sb, "dirblkbits %u isn't supported", dsb->dirblkbits);
   364			goto out;
   365		}
   366	
   367		sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
   368		if (erofs_sb_has_sb_chksum(sbi)) {
   369			ret = erofs_superblock_csum_verify(sb, data);
   370			if (ret)
   371				goto out;
   372		}
   373	
   374		ret = -EINVAL;
   375		if (!check_layout_compatibility(sb, dsb))
   376			goto out;
   377	
   378		sbi->sb_size = 128 + dsb->sb_extslots * EROFS_SB_EXTSLOT_SIZE;
   379		if (sbi->sb_size > PAGE_SIZE - EROFS_SUPER_OFFSET) {
   380			erofs_err(sb, "invalid sb_extslots %u (more than a fs block)",
   381				  sbi->sb_size);
   382			goto out;
   383		}
   384		sbi->primarydevice_blocks = le32_to_cpu(dsb->blocks);
   385		sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
   386	#ifdef CONFIG_EROFS_FS_XATTR
   387		sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
   388	#endif
   389		sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
   390		sbi->root_nid = le16_to_cpu(dsb->root_nid);
   391		sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
   392		sbi->inos = le64_to_cpu(dsb->inos);
   393	
 > 394		sbi->xattr_prefix_start = le32_to_cpu(dsb->xattr_prefix_start);
 > 395		sbi->xattr_prefix_count = dsb->xattr_prefix_count;
   396	
   397		sbi->build_time = le64_to_cpu(dsb->build_time);
   398		sbi->build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
   399	
   400		memcpy(&sb->s_uuid, dsb->uuid, sizeof(dsb->uuid));
   401	
   402		ret = strscpy(sbi->volume_name, dsb->volume_name,
   403			      sizeof(dsb->volume_name));
   404		if (ret < 0) {	/* -E2BIG */
   405			erofs_err(sb, "bad volume name without NIL terminator");
   406			ret = -EFSCORRUPTED;
   407			goto out;
   408		}
   409	
   410		/* parse on-disk compression configurations */
   411		if (erofs_sb_has_compr_cfgs(sbi))
   412			ret = erofs_load_compr_cfgs(sb, dsb);
   413		else
   414			ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
   415		if (ret < 0)
   416			goto out;
   417	
   418		/* handle multiple devices */
   419		ret = erofs_scan_devices(sb, dsb);
   420	
   421		if (erofs_sb_has_ztailpacking(sbi))
   422			erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
   423		if (erofs_is_fscache_mode(sb))
   424			erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
   425		if (erofs_sb_has_fragments(sbi))
   426			erofs_info(sb, "EXPERIMENTAL compressed fragments feature in use. Use at your own risk!");
   427		if (erofs_sb_has_dedupe(sbi))
   428			erofs_info(sb, "EXPERIMENTAL global deduplication feature in use. Use at your own risk!");
   429	out:
   430		erofs_put_metabuf(&buf);
   431		return ret;
   432	}
   433	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
