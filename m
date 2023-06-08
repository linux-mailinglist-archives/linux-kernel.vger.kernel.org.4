Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707A772848D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjFHQEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjFHQDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:03:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77AA30F3;
        Thu,  8 Jun 2023 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686240210; x=1717776210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1MRnlppyZ7daGfrggdDXnfQ0xNGZl1S17/wP4Qk7OmM=;
  b=NNEi6b2GrkjpHRrJKrFfHCeCvt6OSeSRm4O2H0jzTwsFhOUrDftFNFI7
   rzFAqysRSOHuRdThVo8hUzlhHN0X9WrlatLWY8vyFktSw/v7Z6QJn6G2c
   F5TqWrkACkKAJkhKrV1Is3P8ZAJ5r6w/UWGWrgeCuRO/tGIeNXSB3ckdv
   AZo6M4X6y8QRaqAiN7j7uP2sANcilm6U5tAOiVZpnRaHZOh1559ko9mBf
   9x4I8Qpt/Q04CVarpnucsgPX6PBeQjYbC94sWIOhdCJTFLVGua2SKseN2
   yYIzz8XHKNHkqou+Wcuf2shDZXOZjrDhDUIm5aJw51/YMODaC1f6i6p3E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="360699893"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="360699893"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 09:03:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="822664803"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="822664803"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2023 09:03:24 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7I6e-00080q-00;
        Thu, 08 Jun 2023 16:03:24 +0000
Date:   Fri, 9 Jun 2023 00:02:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, axboe@kernel.dk,
        dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH v3 1/2] scsi: sg: fix blktrace debugfs entries leakage
Message-ID: <202306082353.o2lpbQcL-lkp@intel.com>
References: <20230608024159.1282953-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608024159.1282953-2-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.4-rc5 next-20230608]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/scsi-sg-fix-blktrace-debugfs-entries-leakage/20230608-104735
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230608024159.1282953-2-yukuai1%40huaweicloud.com
patch subject: [PATCH v3 1/2] scsi: sg: fix blktrace debugfs entries leakage
config: i386-randconfig-r002-20230608 (https://download.01.org/0day-ci/archive/20230608/202306082353.o2lpbQcL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch axboe-block for-next
        git checkout axboe-block/for-next
        b4 shazam https://lore.kernel.org/r/20230608024159.1282953-2-yukuai1@huaweicloud.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306082353.o2lpbQcL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/scsi/sg.c:45:
   drivers/scsi/sg.c: In function 'sg_device_destroy':
>> include/linux/blktrace_api.h:88:57: warning: statement with no effect [-Wunused-value]
      88 | # define blk_trace_remove(q)                            (-ENOTTY)
         |                                                         ^
   drivers/scsi/sg.c:1575:9: note: in expansion of macro 'blk_trace_remove'
    1575 |         blk_trace_remove(sdp->device->request_queue);
         |         ^~~~~~~~~~~~~~~~


vim +88 include/linux/blktrace_api.h

157f9c00e88529 Arnaldo Carvalho de Melo 2009-01-26  81  
2056a782f8e7e6 Jens Axboe               2006-03-23  82  #else /* !CONFIG_BLK_DEV_IO_TRACE */
2056a782f8e7e6 Jens Axboe               2006-03-23  83  # define blk_trace_ioctl(bdev, cmd, arg)		(-ENOTTY)
2056a782f8e7e6 Jens Axboe               2006-03-23  84  # define blk_trace_shutdown(q)				do { } while (0)
a54895fa057c67 Christoph Hellwig        2020-12-03  85  # define blk_add_driver_data(rq, data, len)		do {} while (0)
d0deef5b14af7d Shawn Du                 2009-04-14  86  # define blk_trace_setup(q, name, dev, bdev, arg)	(-ENOTTY)
6da127ad0918f9 Christof Schmitt         2008-01-11  87  # define blk_trace_startstop(q, start)			(-ENOTTY)
6da127ad0918f9 Christof Schmitt         2008-01-11 @88  # define blk_trace_remove(q)				(-ENOTTY)
9d5f09a424a67d Alan D. Brunelle         2008-05-27  89  # define blk_add_trace_msg(q, fmt, ...)			do { } while (0)
35fe6d763229e8 Shaohua Li               2017-07-12  90  # define blk_add_cgroup_trace_msg(q, cg, fmt, ...)	do { } while (0)
59fa0224cfea31 Shaohua Li               2016-05-09  91  # define blk_trace_note_message_enabled(q)		(false)
2056a782f8e7e6 Jens Axboe               2006-03-23  92  #endif /* CONFIG_BLK_DEV_IO_TRACE */
d0deef5b14af7d Shawn Du                 2009-04-14  93  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
