Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6486F5EE2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjECTGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjECTGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:06:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DBB7EF7;
        Wed,  3 May 2023 12:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683140792; x=1714676792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wsk0nNYE5xsVVwLCvj2n++hfWyTyDUwTHowQExOFJtU=;
  b=jikYK6JhmNC/IAyxsxTUmvfy/yC1DRl1uypO/7Y3Y1VgsNUHqB+tytN7
   vsOaRXvZE+4APlXsl9sicq6uwFTdzNr1hHUuLR3zk4/T22xBzXGVZoY9J
   N6heGPD8MJONTLirERiM+/zweg6o7UNiSOBSHFZL6JYVRfl4E+NzrYQ8f
   fGAMAdXvUVJk+0Gwq6KiSRyrEowgY71JUj8qPJxIXhYvpHvisNVLsTgST
   5q/c2TufdH4/jj1WPHs4KxSVZFAzNxUSHqjj6H2oLq7RtooIKMZbettwc
   rxY7vI6dd4xZuOH0eB3vYc3ju08AEUlOEvHFTfVxAOPfiGqMtP0S7PHKn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="337880837"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="337880837"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 12:06:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="766246117"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="766246117"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 May 2023 12:06:29 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1puHo4-0002DG-1U;
        Wed, 03 May 2023 19:06:28 +0000
Date:   Thu, 4 May 2023 03:06:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 05/15] block: fix not to apply bip information in
 blk_rq_bio_prep()
Message-ID: <202305040206.hTkXRgzQ-lkp@intel.com>
References: <20230503101048epcms2p61d61df1431955d9517c9939999ee3478@epcms2p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503101048epcms2p61d61df1431955d9517c9939999ee3478@epcms2p6>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinyoung,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on mkp-scsi/for-next jejb-scsi/for-next linus/master v6.3 next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinyoung-CHOI/block-blk-integiry-add-helper-functions-for-bio_integrity_add_page/20230503-183015
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230503101048epcms2p61d61df1431955d9517c9939999ee3478%40epcms2p6
patch subject: [PATCH 05/15] block: fix not to apply bip information in blk_rq_bio_prep()
config: hexagon-randconfig-r045-20230503 (https://download.01.org/0day-ci/archive/20230504/202305040206.hTkXRgzQ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b1465cd49efcbc114a75220b153f5a055ce7911f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/584edc6ae9cb23e8a778ee73d711b9143038a047
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jinyoung-CHOI/block-blk-integiry-add-helper-functions-for-bio_integrity_add_page/20230503-183015
        git checkout 584edc6ae9cb23e8a778ee73d711b9143038a047
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305040206.hTkXRgzQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/md/md-bitmap.c:19:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/md/md-bitmap.c:19:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/md/md-bitmap.c:19:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   In file included from drivers/md/md-bitmap.c:31:
   In file included from include/trace/events/block.h:8:
   In file included from include/linux/blktrace_api.h:5:
   include/linux/blk-mq.h:972:7: error: no member named 'nr_integrity_segments' in 'struct request'
                   rq->nr_integrity_segments = bio_integrity(bio)->bip_vcnt;
                   ~~  ^
   include/linux/blk-mq.h:972:49: error: member reference base type 'void' is not a structure or union
                   rq->nr_integrity_segments = bio_integrity(bio)->bip_vcnt;
                                               ~~~~~~~~~~~~~~~~~~^ ~~~~~~~~
>> drivers/md/md-bitmap.c:2564:34: warning: result of comparison of constant 4294967296 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
           if (BITS_PER_LONG > 32 && csize >= (1ULL << (BITS_PER_BYTE *
                                     ~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   7 warnings and 2 errors generated.


vim +2564 drivers/md/md-bitmap.c

43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2549  
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2550  static ssize_t
fd01b88c75a718 drivers/md/bitmap.c    NeilBrown             2011-10-11  2551  chunksize_store(struct mddev *mddev, const char *buf, size_t len)
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2552  {
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2553  	/* Can only be changed when no bitmap is active */
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2554  	int rv;
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2555  	unsigned long csize;
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2556  	if (mddev->bitmap)
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2557  		return -EBUSY;
b29bebd66dbd49 drivers/md/bitmap.c    Jingoo Han            2013-06-01  2558  	rv = kstrtoul(buf, 10, &csize);
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2559  	if (rv)
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2560  		return rv;
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2561  	if (csize < 512 ||
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2562  	    !is_power_of_2(csize))
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2563  		return -EINVAL;
4555211190798b drivers/md/md-bitmap.c Florian-Ewald Mueller 2022-10-25 @2564  	if (BITS_PER_LONG > 32 && csize >= (1ULL << (BITS_PER_BYTE *
4555211190798b drivers/md/md-bitmap.c Florian-Ewald Mueller 2022-10-25  2565  		sizeof(((bitmap_super_t *)0)->chunksize))))
4555211190798b drivers/md/md-bitmap.c Florian-Ewald Mueller 2022-10-25  2566  		return -EOVERFLOW;
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2567  	mddev->bitmap_info.chunksize = csize;
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2568  	return len;
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2569  }
43a705076e51c5 drivers/md/bitmap.c    NeilBrown             2009-12-14  2570  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
