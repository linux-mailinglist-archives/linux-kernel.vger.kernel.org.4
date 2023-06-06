Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F303872390F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjFFHcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjFFHcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:32:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A55106;
        Tue,  6 Jun 2023 00:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686036726; x=1717572726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y0tUjBJZQc0NgAH98sMioZbdb4zlFj8YB+VyFvWw5EE=;
  b=XEEIG0l+vNVPSiI17XepmY0z93wqNlCBSfRdA4zLstaiV9ctXmFdvJfs
   N7/IS388OaswN0zP1qy8/GkhYC1XaXM4041fbH045oibDtDba3gwWI7xl
   Xx1rJE3Aa8ebS5+Wx9blAejyPR9vI6SGmpEWeQHazmkCVPetcamyYAnlg
   WmZVJ8+ZF5z6EI/zRWAspi8rrvntSmnR7oob1ilYTpk8yO+gYYGiV5hCK
   E5RYO7ZEJx4wxzDjH/7/GMmE5BGsJY13I5K6FmBKfGcJsog0mTcfr0+Wa
   FOCbZgQUqgbIdL8Dz0BpDuKbUoF4uN1qTdBE3+OkGWxgoCHaI5ziTiPM7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="420139166"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="420139166"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:32:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="833118130"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="833118130"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Jun 2023 00:32:04 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6RAh-0004yV-1p;
        Tue, 06 Jun 2023 07:32:03 +0000
Date:   Tue, 6 Jun 2023 15:31:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Kent Overstreet <kmo@daterainc.com>
Subject: Re: [PATCH v2 4/5] block: Change memcpy_(to|from)_bvec to pass bvec
 by value
Message-ID: <202306061511.LwAxWAce-lkp@intel.com>
References: <20230605212717.2570570-4-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605212717.2570570-4-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kent,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[cannot apply to kdave/for-next device-mapper-dm/for-next gfs2/for-next tytso-ext4/dev linus/master v6.4-rc5 next-20230606]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kent-Overstreet/block-Rework-bio_for_each_folio_all/20230606-052850
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230605212717.2570570-4-kent.overstreet%40linux.dev
patch subject: [PATCH v2 4/5] block: Change memcpy_(to|from)_bvec to pass bvec by value
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230606/202306061511.LwAxWAce-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch axboe-block for-next
        git checkout axboe-block/for-next
        b4 shazam https://lore.kernel.org/r/20230605212717.2570570-4-kent.overstreet@linux.dev
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306061511.LwAxWAce-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/scsi/aha1542.c: In function 'aha1542_free_cmd':
>> drivers/scsi/aha1542.c:270:40: error: incompatible type for argument 1 of 'memcpy_to_bvec'
     270 |                         memcpy_to_bvec(&bv, buf);
         |                                        ^~~
         |                                        |
         |                                        struct bio_vec *
   In file included from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from include/scsi/scsi_cmnd.h:6,
                    from drivers/scsi/aha1542.c:23:
   include/linux/bvec.h:271:50: note: expected 'struct bio_vec' but argument is of type 'struct bio_vec *'
     271 | static inline void memcpy_to_bvec(struct bio_vec bvec, const char *from)
         |                                   ~~~~~~~~~~~~~~~^~~~


vim +/memcpy_to_bvec +270 drivers/scsi/aha1542.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  258  
1794ef2b150dd5 Christoph Hellwig 2018-11-10  259  static void aha1542_free_cmd(struct scsi_cmnd *cmd)
1794ef2b150dd5 Christoph Hellwig 2018-11-10  260  {
1794ef2b150dd5 Christoph Hellwig 2018-11-10  261  	struct aha1542_cmd *acmd = scsi_cmd_priv(cmd);
1794ef2b150dd5 Christoph Hellwig 2018-11-10  262  
2f2fef022c3e7a Christoph Hellwig 2021-03-31  263  	if (cmd->sc_data_direction == DMA_FROM_DEVICE) {
11bf4ec580737c Bart Van Assche   2021-08-09  264  		struct request *rq = scsi_cmd_to_rq(cmd);
2f2fef022c3e7a Christoph Hellwig 2021-03-31  265  		void *buf = acmd->data_buffer;
2f2fef022c3e7a Christoph Hellwig 2021-03-31  266  		struct req_iterator iter;
2f2fef022c3e7a Christoph Hellwig 2021-03-31  267  		struct bio_vec bv;
2f2fef022c3e7a Christoph Hellwig 2021-03-31  268  
11bf4ec580737c Bart Van Assche   2021-08-09  269  		rq_for_each_segment(bv, rq, iter) {
e6ab6113526aa4 Christoph Hellwig 2021-10-18 @270  			memcpy_to_bvec(&bv, buf);
2f2fef022c3e7a Christoph Hellwig 2021-03-31  271  			buf += bv.bv_len;
2f2fef022c3e7a Christoph Hellwig 2021-03-31  272  		}
1794ef2b150dd5 Christoph Hellwig 2018-11-10  273  	}
1794ef2b150dd5 Christoph Hellwig 2018-11-10  274  
1794ef2b150dd5 Christoph Hellwig 2018-11-10  275  	scsi_dma_unmap(cmd);
1794ef2b150dd5 Christoph Hellwig 2018-11-10  276  }
1794ef2b150dd5 Christoph Hellwig 2018-11-10  277  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
