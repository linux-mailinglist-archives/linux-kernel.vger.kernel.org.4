Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305226F585D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjECM5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjECM5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:57:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD2A5262;
        Wed,  3 May 2023 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683118640; x=1714654640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NXY93xhwaopT17+l0/EjS3Gx663sl7IzwqUBhRClEhQ=;
  b=niq7nSFYAexaS4quCt4tFqhcsXNKUfNeJw7kgrQoOSu5CBlWNkN0VHaY
   FRpp0E+tFSpd7OtCdXxviunL6Uln2hXw1E0PvJeOBPrlJYwV+Qg/DTsbC
   bV+CY4KxdZzmAp5KoM4cHqsFyQqgyyKU8cWAz4QJJ+RUtcg6Qf30CfUz5
   y5C/HklawLCDAsZYX5dgK8M5GBFmfDLTVwY83E+aOhEjSNArsQiXhhVH9
   J/gOjGswCvkHp2O/wWL9/A17iWeCZojZ+HkuU8+VjakXe5j2eHA/jLjre
   WH6DHKbA/qc3Svs1TBqxShZswvoNaj12LmOJiUwe88xd57SFoQ0+l8/lY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="350723207"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="350723207"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 05:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="1026491301"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="1026491301"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 May 2023 05:57:18 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1puC2n-000212-0g;
        Wed, 03 May 2023 12:57:17 +0000
Date:   Wed, 3 May 2023 20:56:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 05/15] block: fix not to apply bip information in
 blk_rq_bio_prep()
Message-ID: <202305032008.NxgqlW9X-lkp@intel.com>
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
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20230503/202305032008.NxgqlW9X-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/584edc6ae9cb23e8a778ee73d711b9143038a047
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jinyoung-CHOI/block-blk-integiry-add-helper-functions-for-bio_integrity_add_page/20230503-183015
        git checkout 584edc6ae9cb23e8a778ee73d711b9143038a047
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash arch/um/drivers/ block/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305032008.NxgqlW9X-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from arch/um/drivers/ubd_kern.c:27:
   include/linux/blk-mq.h: In function 'blk_rq_bio_prep':
>> include/linux/blk-mq.h:972:19: error: 'struct request' has no member named 'nr_integrity_segments'
     972 |                 rq->nr_integrity_segments = bio_integrity(bio)->bip_vcnt;
         |                   ^~
>> include/linux/blk-mq.h:972:63: warning: dereferencing 'void *' pointer
     972 |                 rq->nr_integrity_segments = bio_integrity(bio)->bip_vcnt;
         |                                                               ^~
>> include/linux/blk-mq.h:972:63: error: request for member 'bip_vcnt' in something not a structure or union


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
