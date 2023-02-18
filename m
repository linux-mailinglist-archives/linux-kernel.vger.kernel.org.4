Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010E669B178
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjBQQ4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjBQQ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:56:33 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB1C3A868
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676652991; x=1708188991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3aIo2q4rrbz+QhAty9dbB6TAzju45I5+EuDMZYyHTsk=;
  b=hhPmIvE30YeuY/DnJQPoHRiSbXROfCIGl8JMnsu6mKz5ikS5NUz2Fnqy
   Red0VODCaC1I14skbVju2cvB9QXCAe80oICJ77Lxdf7UPBsgAyqHdhup2
   wirlGUF1otXJa0IWDuPamU8/DVxVm2k41B0fmd3p1yniLwSmypcTE27kE
   3X/oPo/qxlH65OpfVHJQkUFFmtFuNZ8Ob0FW7mAewNQVssxzmPuBYWzPk
   WzYoTypyERVmdAmjlepvMDuGHPz6u1r2b32qEvpHv758ESsyOirEdNqzM
   ZBN0Wop1I0/ZCWrgqqBEJHDgHm+KiZZFdukzcXvU0J2uTcjZ44xkpR0lM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="312399196"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="312399196"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 08:56:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="794450450"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="794450450"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Feb 2023 08:56:28 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pT427-000Bf3-25;
        Fri, 17 Feb 2023 16:56:27 +0000
Date:   Sat, 18 Feb 2023 00:56:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.or,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] erofs: avoid hardcoded blocksize for subpage
 block support
Message-ID: <202302180056.Qg8HFrkU-lkp@intel.com>
References: <20230217055016.71462-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217055016.71462-1-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingbo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev next-20230217]
[cannot apply to xiang-erofs/fixes linus/master v6.2-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jingbo-Xu/erofs-set-block-size-to-the-on-disk-block-size/20230217-135145
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20230217055016.71462-1-jefflexu%40linux.alibaba.com
patch subject: [PATCH v2 1/2] erofs: avoid hardcoded blocksize for subpage block support
config: i386-randconfig-a014 (https://download.01.org/0day-ci/archive/20230218/202302180056.Qg8HFrkU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f3fa173833cc0b885d46a6c71796687a03ce25e1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jingbo-Xu/erofs-set-block-size-to-the-on-disk-block-size/20230217-135145
        git checkout f3fa173833cc0b885d46a6c71796687a03ce25e1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302180056.Qg8HFrkU-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: fs/erofs/data.o: in function `erofs_map_blocks_flatmode':
>> fs/erofs/data.c:89: undefined reference to `__divdi3'
   ld: fs/erofs/namei.o: in function `erofs_find_target_block':
>> fs/erofs/namei.c:93: undefined reference to `__divdi3'
   ld: fs/erofs/zmap.o: in function `compacted_load_cluster_from_disk':
>> fs/erofs/zmap.c:252: undefined reference to `__divdi3'


vim +89 fs/erofs/data.c

    79	
    80	static int erofs_map_blocks_flatmode(struct inode *inode,
    81					     struct erofs_map_blocks *map)
    82	{
    83		erofs_blk_t nblocks, lastblk;
    84		u64 offset = map->m_la;
    85		struct erofs_inode *vi = EROFS_I(inode);
    86		struct super_block *sb = inode->i_sb;
    87		bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
    88	
  > 89		nblocks = DIV_ROUND_UP(inode->i_size, sb->s_blocksize);
    90		lastblk = nblocks - tailendpacking;
    91	
    92		/* there is no hole in flatmode */
    93		map->m_flags = EROFS_MAP_MAPPED;
    94		if (offset < erofs_pos(sb, lastblk)) {
    95			map->m_pa = erofs_pos(sb, vi->raw_blkaddr) + map->m_la;
    96			map->m_plen = erofs_pos(sb, lastblk) - offset;
    97		} else if (tailendpacking) {
    98			map->m_pa = erofs_iloc(inode) + vi->inode_isize +
    99				vi->xattr_isize + erofs_blkoff(sb, offset);
   100			map->m_plen = inode->i_size - offset;
   101	
   102			/* inline data should be located in the same meta block */
   103			if (erofs_blkoff(sb, map->m_pa) + map->m_plen > sb->s_blocksize) {
   104				erofs_err(sb,
   105					  "inline data cross block boundary @ nid %llu",
   106					  vi->nid);
   107				DBG_BUGON(1);
   108				return -EFSCORRUPTED;
   109			}
   110			map->m_flags |= EROFS_MAP_META;
   111		} else {
   112			erofs_err(sb,
   113				  "internal error @ nid: %llu (size %llu), m_la 0x%llx",
   114				  vi->nid, inode->i_size, map->m_la);
   115			DBG_BUGON(1);
   116			return -EIO;
   117		}
   118		return 0;
   119	}
   120	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
