Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32C86F5D07
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjECRYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjECRYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:24:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EFF5BAB;
        Wed,  3 May 2023 10:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683134671; x=1714670671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hcKCVFXhx3yMViZSecHcsu0Oh2KFBf8Ahfru86Q4miE=;
  b=cpDDkIRFbEJuyEWvOOuRkSKwqeP6Eo2tGqX548FSQosEvldD9iLeiUPA
   pTWcpKXXZosQ++hhh6gQHk1UY+6aRCiexpEub8FA7C8JpYEEcihpAp24U
   jQSX2EHkHzsSXQEtGEOLWHNzJcCKNN7YXdLkjYTSWYq9hitVI25cWAOrH
   07eaD42IQEl2NhAcL4p7h25FeX7GeJ2TwbfvGiRTDx9vwigyw4HgmzS1G
   ZVaY1B9dQKrsMmaybWxMij9W9nj0t818jGow9AenXHYnhCgqJ+hVNaU7d
   pa8t/2Pa7A2E3gOV/CZ2sYV20FStb8fbRyHCJf+VIUCd/By6f75q66/ZH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="328337466"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="328337466"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 10:24:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="808353884"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="808353884"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 May 2023 10:24:26 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1puGDJ-0002AK-1e;
        Wed, 03 May 2023 17:24:25 +0000
Date:   Thu, 4 May 2023 01:23:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 05/15] block: fix not to apply bip information in
 blk_rq_bio_prep()
Message-ID: <202305040157.ZWiorthB-lkp@intel.com>
References: <20230503101048epcms2p61d61df1431955d9517c9939999ee3478@epcms2p6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503101048epcms2p61d61df1431955d9517c9939999ee3478@epcms2p6>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinyoung,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on mkp-scsi/for-next jejb-scsi/for-next linus/master v6.3 next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinyoung-CHOI/block-blk-integiry-add-helper-functions-for-bio_integrity_add_page/20230503-183015
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230503101048epcms2p61d61df1431955d9517c9939999ee3478%40epcms2p6
patch subject: [PATCH 05/15] block: fix not to apply bip information in blk_rq_bio_prep()
config: riscv-randconfig-r042-20230503 (https://download.01.org/0day-ci/archive/20230504/202305040157.ZWiorthB-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b1465cd49efcbc114a75220b153f5a055ce7911f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/584edc6ae9cb23e8a778ee73d711b9143038a047
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jinyoung-CHOI/block-blk-integiry-add-helper-functions-for-bio_integrity_add_page/20230503-183015
        git checkout 584edc6ae9cb23e8a778ee73d711b9143038a047
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash block/ drivers/mtd/ubi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305040157.ZWiorthB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from block/bdev.c:15:
   In file included from include/linux/blk-integrity.h:5:
>> include/linux/blk-mq.h:972:7: error: no member named 'nr_integrity_segments' in 'struct request'
                   rq->nr_integrity_segments = bio_integrity(bio)->bip_vcnt;
                   ~~  ^
>> include/linux/blk-mq.h:972:49: error: member reference base type 'void' is not a structure or union
                   rq->nr_integrity_segments = bio_integrity(bio)->bip_vcnt;
                                               ~~~~~~~~~~~~~~~~~~^ ~~~~~~~~
   2 errors generated.


vim +972 include/linux/blk-mq.h

   962	
   963	static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,
   964			unsigned int nr_segs)
   965	{
   966		rq->nr_phys_segments = nr_segs;
   967		rq->__data_len = bio->bi_iter.bi_size;
   968		rq->bio = rq->biotail = bio;
   969		rq->ioprio = bio_prio(bio);
   970	
   971		if (bio_integrity(bio)) {
 > 972			rq->nr_integrity_segments = bio_integrity(bio)->bip_vcnt;
   973			rq->cmd_flags |= REQ_INTEGRITY;
   974		}
   975	}
   976	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
