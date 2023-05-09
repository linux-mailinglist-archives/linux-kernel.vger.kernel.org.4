Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391286FD17F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbjEIVfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbjEIVf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:35:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747E16EA1;
        Tue,  9 May 2023 14:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683668102; x=1715204102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LxfhN7twkbsXW4buKGDFp0m82yxZW5uwWpLzdxIpSC8=;
  b=WMuC4KjgMwxqwDvM/1pmoDjSgK/AtbZSwQbn7LVelF7qFebmNviFT70p
   NY3+qHW/g36bDFNLACWkv9tpKaAQZTQNd0yI4OT38bx2JV8Z88XnDj7hL
   nNFsT93Y7pTjFhSI3gOPfBueZx7kzInnPR+8FMQc08ODxTVl0FY+D8jTo
   gKcmxnO20xz+myJj4hN2UkiapwNj15XOdVcklVft9dQa9EgkJRB84iSvO
   UOZuSkt4lr8Y1qOQ4rKpzxghAqkJw2B3wVEGfDc7LE2PypcWY77pBa5ga
   17MlM221rksGc1F+0UqdN667wmHzbVjFXIhCGalKV6zhf1BEau4xL4h25
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="330421325"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="330421325"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 14:33:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="729693392"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="729693392"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 May 2023 14:33:52 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwUxz-0002WE-0b;
        Tue, 09 May 2023 21:33:51 +0000
Date:   Wed, 10 May 2023 05:33:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ed Tsai <ed.tsai@mediatek.com>, axboe@kernel.dk
Cc:     oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, bvanassche@acm.org,
        stanley.chu@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, alice.chao@mediatek.com,
        powen.kao@mediatek.com, naomi.chu@mediatek.com,
        wsd_upstream@mediatek.com, Ed Tsai <ed.tsai@mediatek.com>
Subject: Re: [PATCH 1/2] block: make the fair sharing of tag configurable
Message-ID: <202305100557.gdIvlzRS-lkp@intel.com>
References: <20230509065230.32552-2-ed.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509065230.32552-2-ed.tsai@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on jejb-scsi/for-next mkp-scsi/for-next linus/master v6.4-rc1 next-20230509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ed-Tsai/block-make-the-fair-sharing-of-tag-configurable/20230509-145439
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230509065230.32552-2-ed.tsai%40mediatek.com
patch subject: [PATCH 1/2] block: make the fair sharing of tag configurable
config: openrisc-randconfig-r022-20230509 (https://download.01.org/0day-ci/archive/20230510/202305100557.gdIvlzRS-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b1081024bc6d1cdaf5b39994b19040cd8e6099ec
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ed-Tsai/block-make-the-fair-sharing-of-tag-configurable/20230509-145439
        git checkout b1081024bc6d1cdaf5b39994b19040cd8e6099ec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305100557.gdIvlzRS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from block/blk-mq.c:12:
   block/blk-mq.c: In function 'blk_mq_init_allocated_queue':
>> include/linux/blkdev.h:569:39: warning: left shift count >= width of type [-Wshift-count-overflow]
     569 |                                  (1UL << QUEUE_FLAG_FAIR_TAG_SHARING))
         |                                       ^~
   block/blk-mq.c:4232:27: note: in expansion of macro 'QUEUE_FLAG_MQ_DEFAULT'
    4232 |         q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
         |                           ^~~~~~~~~~~~~~~~~~~~~


vim +569 include/linux/blkdev.h

   565	
   566	#define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
   567					 (1UL << QUEUE_FLAG_SAME_COMP) |	\
   568					 (1UL << QUEUE_FLAG_NOWAIT) |		\
 > 569					 (1UL << QUEUE_FLAG_FAIR_TAG_SHARING))
   570	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
