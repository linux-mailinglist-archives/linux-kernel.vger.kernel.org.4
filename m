Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58437340F8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 14:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjFQM0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 08:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjFQM0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 08:26:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9A2B5;
        Sat, 17 Jun 2023 05:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687004796; x=1718540796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cXD0g1H9E9UuwGms7XxMSDgjreFk+KWaexzmji8c5Sk=;
  b=RDl+b/UbfWizwjLycGZYzmFV+UsAD/FxCzaEp/04NR+X9FA1nlXwqMVd
   JOt/njqMe8Z9Nr+kiN/CjP7R5KmfbWn56t/XVnUlBjT5gIrrJIiPvEjOl
   YqFr7YNJRHCJPolWyupr4QXcjUt0sM/Ex58Atc4aQtTzlujvoctlftYcY
   bJKXME2kp5ow+VAJF+Ikz44OPrHIb44jIt1+AjBv5NOE8f6dADWL2p7BV
   qb5iDuaRqpgn0aVPdV3lHlpUdUK43KylINRm0lsZ0SlKAFCNsrMx4Z/G9
   Pmh7vVHzwiAlCj3Qej2stD1E5h0n6cNbuNlvnRylDYSqcUHorXPhMx8zQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="445765392"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="445765392"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2023 05:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="716339005"
X-IronPort-AV: E=Sophos;i="6.00,250,1681196400"; 
   d="scan'208";a="716339005"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jun 2023 05:26:33 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAV0i-0002kG-1u;
        Sat, 17 Jun 2023 12:26:32 +0000
Date:   Sat, 17 Jun 2023 20:25:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, axboe@kernel.dk,
        brauner@kernel.org, hare@suse.de, dsterba@suse.com,
        jinpu.wang@ionos.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next] block: fix wrong mode for blkdev_get_by_dev() from
 disk_scan_partitions()
Message-ID: <202306172040.1dllc8rx-lkp@intel.com>
References: <20230617103813.3708374-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617103813.3708374-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230616]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/block-fix-wrong-mode-for-blkdev_get_by_dev-from-disk_scan_partitions/20230617-184451
base:   next-20230616
patch link:    https://lore.kernel.org/r/20230617103813.3708374-1-yukuai1%40huaweicloud.com
patch subject: [PATCH -next] block: fix wrong mode for blkdev_get_by_dev() from disk_scan_partitions()
config: alpha-randconfig-r036-20230617 (https://download.01.org/0day-ci/archive/20230617/202306172040.1dllc8rx-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230617/202306172040.1dllc8rx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306172040.1dllc8rx-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/genhd.c: In function 'disk_scan_partitions':
>> block/genhd.c:369:59: error: 'FMODE_EXCL' undeclared (first use in this function); did you mean 'FMODE_EXEC'?
     369 |         bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL,
         |                                                           ^~~~~~~~~~
         |                                                           FMODE_EXEC
   block/genhd.c:369:59: note: each undeclared identifier is reported only once for each function it appears in


vim +369 block/genhd.c

   342	
   343	int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
   344	{
   345		struct block_device *bdev;
   346		int ret = 0;
   347	
   348		if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
   349			return -EINVAL;
   350		if (test_bit(GD_SUPPRESS_PART_SCAN, &disk->state))
   351			return -EINVAL;
   352		if (disk->open_partitions)
   353			return -EBUSY;
   354	
   355		/*
   356		 * If the device is opened exclusively by current thread already, it's
   357		 * safe to scan partitons, otherwise, use bd_prepare_to_claim() to
   358		 * synchronize with other exclusive openers and other partition
   359		 * scanners.
   360		 */
   361		if (!(mode & BLK_OPEN_EXCL)) {
   362			ret = bd_prepare_to_claim(disk->part0, disk_scan_partitions,
   363						  NULL);
   364			if (ret)
   365				return ret;
   366		}
   367	
   368		set_bit(GD_NEED_PART_SCAN, &disk->state);
 > 369		bdev = blkdev_get_by_dev(disk_devt(disk), mode & ~FMODE_EXCL, NULL,
   370					 NULL);
   371		if (IS_ERR(bdev))
   372			ret =  PTR_ERR(bdev);
   373		else
   374			blkdev_put(bdev, NULL);
   375	
   376		/*
   377		 * If blkdev_get_by_dev() failed early, GD_NEED_PART_SCAN is still set,
   378		 * and this will cause that re-assemble partitioned raid device will
   379		 * creat partition for underlying disk.
   380		 */
   381		clear_bit(GD_NEED_PART_SCAN, &disk->state);
   382		if (!(mode & BLK_OPEN_EXCL))
   383			bd_abort_claiming(disk->part0, disk_scan_partitions);
   384		return ret;
   385	}
   386	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
