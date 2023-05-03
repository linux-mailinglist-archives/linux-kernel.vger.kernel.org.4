Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA726F5FAD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjECUHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjECUHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:07:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E504C7DA8;
        Wed,  3 May 2023 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683144453; x=1714680453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W2TvSu5by40ZybJina9aajhcjdtA9fS6jM2dAJRRd/o=;
  b=hOrzgCpC7/4liq4VlLytROrmupIUEn2vJimD7tpLEVCp3xqMJYYv0KFf
   cqLtIN6BPyVg7D+38NzeyIdR0uGG2LXzLSEN9UTjEh1/MY+ELWC2dBVAf
   ceOzuLx0v7MKAI/0F2D7BQL9UDFmizzLtzC3I1szMKW4jMvj5+Z6YiH0q
   J7nNG0v6/apy3CQdAeOgEk+OYR58BYtgU2f2B3xqigSWeMg7Ve/HR5h2h
   1NXN/2ozoAn08WLouQc9JLVlE04VbPnJ69alhR2SOfChhIqvTs9YMeiQ6
   TJ8vAI4msgS53ArR7IVvJfA7YlcdmytQX6P9mkVThqif/8txEsLFDcJ8I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="333116937"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="333116937"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 13:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="690833445"
X-IronPort-AV: E=Sophos;i="5.99,248,1677571200"; 
   d="scan'208";a="690833445"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 May 2023 13:07:31 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1puIl8-0002FM-1E;
        Wed, 03 May 2023 20:07:30 +0000
Date:   Thu, 4 May 2023 04:07:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 14/15] block: blk-integrity: change sg-table
 configuration method for integrity
Message-ID: <202305040333.EHY8r49K-lkp@intel.com>
References: <20230503102719epcms2p457434fefd535ee43d502eff854227919@epcms2p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503102719epcms2p457434fefd535ee43d502eff854227919@epcms2p4>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20230503102719epcms2p457434fefd535ee43d502eff854227919%40epcms2p4
patch subject: [PATCH 14/15] block: blk-integrity: change sg-table configuration method for integrity
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230504/202305040333.EHY8r49K-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/7e4810d74ca92ed35bbc73cb09a4baa1dacfbc96
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jinyoung-CHOI/block-blk-integiry-add-helper-functions-for-bio_integrity_add_page/20230503-183015
        git checkout 7e4810d74ca92ed35bbc73cb09a4baa1dacfbc96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305040333.EHY8r49K-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/blk-integrity.h:5,
                    from block/blk-merge.c:9:
   include/linux/blk-mq.h: In function 'blk_rq_bio_prep':
   include/linux/blk-mq.h:972:19: error: 'struct request' has no member named 'nr_integrity_segments'
     972 |                 rq->nr_integrity_segments = bio_integrity(bio)->bip_vcnt;
         |                   ^~
   include/linux/blk-mq.h:972:63: warning: dereferencing 'void *' pointer
     972 |                 rq->nr_integrity_segments = bio_integrity(bio)->bip_vcnt;
         |                                                               ^~
   include/linux/blk-mq.h:972:63: error: request for member 'bip_vcnt' in something not a structure or union
   block/blk-merge.c: At top level:
   block/blk-merge.c:536:5: error: redefinition of 'blk_rq_map_integrity_sg'
     536 | int blk_rq_map_integrity_sg(struct request_queue *q, struct bio *bio,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from block/blk-merge.c:9:
   include/linux/blk-integrity.h:132:19: note: previous definition of 'blk_rq_map_integrity_sg' with type 'int(struct request_queue *, struct bio *, struct scatterlist *)'
     132 | static inline int blk_rq_map_integrity_sg(struct request_queue *q,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   block/blk-merge.c: In function 'blk_rq_map_integrity_sg':
   block/blk-merge.c:546:56: error: 'struct bio' has no member named 'bi_integrity'
     546 |                 struct bio_integrity_payload *bip = bio->bi_integrity;
         |                                                        ^~
   block/blk-merge.c:548:17: error: implicit declaration of function 'bip_for_each_mp_bvec'; did you mean 'for_each_mp_bvec'? [-Werror=implicit-function-declaration]
     548 |                 bip_for_each_mp_bvec(iv, bip, iter) {
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 for_each_mp_bvec
   block/blk-merge.c:548:52: error: expected ';' before '{' token
     548 |                 bip_for_each_mp_bvec(iv, bip, iter) {
         |                                                    ^~
         |                                                    ;
>> block/blk-merge.c:543:14: warning: unused variable 'new_bio' [-Wunused-variable]
     543 |         bool new_bio = false;
         |              ^~~~~~~
>> block/blk-merge.c:539:28: warning: unused variable 'ivprv' [-Wunused-variable]
     539 |         struct bio_vec iv, ivprv = { NULL };
         |                            ^~~~~
   cc1: some warnings being treated as errors


vim +/new_bio +543 block/blk-merge.c

   526	
   527	/**
   528	 * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
   529	 * @q:		request queue
   530	 * @bio:	bio with integrity metadata attached
   531	 * @sglist:	target scatterlist
   532	 *
   533	 * Description: Map the integrity vectors in request into a scatterlist.
   534	 * The scatterlist must be big enough to hold all elements.
   535	 */
   536	int blk_rq_map_integrity_sg(struct request_queue *q, struct bio *bio,
   537				    struct scatterlist *sglist)
   538	{
 > 539		struct bio_vec iv, ivprv = { NULL };
   540		struct scatterlist *sg = NULL;
   541		unsigned int nsegs = 0;
   542		struct bvec_iter iter;
 > 543		bool new_bio = false;
   544	
   545		for_each_bio(bio) {
   546			struct bio_integrity_payload *bip = bio->bi_integrity;
   547	
   548			bip_for_each_mp_bvec(iv, bip, iter) {
   549				/*
   550				 * Only try to merge bvecs from two bios given we
   551				 * have done bio internal merge when adding pages
   552				 * to bio
   553				 */
   554				if (new_bio &&
   555				    __blk_segment_map_sg_merge(q, &iv, &ivprv, &sg))
   556					goto next_iv;
   557	
   558				if (iv.bv_offset + iv.bv_len <= PAGE_SIZE)
   559					nsegs += __blk_bvec_map_sg(iv, sglist, &sg);
   560				else
   561					nsegs += blk_bvec_map_sg(q, &iv, sglist, &sg);
   562	 next_iv:
   563				new_bio = false;
   564			}
   565	
   566			if (likely(bip->bip_iter.bi_size)) {
   567				ivprv = iv;
   568				new_bio = true;
   569			}
   570		}
   571	
   572		if (sg)
   573			sg_mark_end(sg);
   574	
   575		return nsegs;
   576	}
   577	EXPORT_SYMBOL(blk_rq_map_integrity_sg);
   578	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
