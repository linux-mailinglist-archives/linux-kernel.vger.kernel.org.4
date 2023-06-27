Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0DC73FF5C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjF0PNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjF0PNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:13:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5055F1FD8;
        Tue, 27 Jun 2023 08:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687878794; x=1719414794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HlcACu4NktYvHeJklJldH7nKa6V69m9Xmjro04VfQZ4=;
  b=VMJoIKVCVvHgdVnA8L6/A0oZFlS2Iywyqq9nBMZWnewQpZT4aSBJzamy
   V73wcw8SitXPMbUxINF94msHqzjMQC9Pcw4FvgfygoWI8kJiwd0qBQF3Y
   K7BwAPK4+NtPG+L8aO21kqAJIynQwya0KylabCcnqu+WUoN38MhNdKLPZ
   Oq8futiJ765+NVE67pzK+hxiA3Qvf8llSmonq8nByY8A5xFs04zDxms+R
   nUEXZjW/XHkf+RHJ0z8seXyndUqfXAVm7a8V4H67FfAuoiwMXOgpvhHCT
   bSC1+RXZ12E2cOY31bLVdik4Mfqt9Fht0AcF1B4LPEWiSf9RDKrpsAgCE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="341937583"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="341937583"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 08:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="719801536"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="719801536"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jun 2023 08:13:10 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEANR-000C0j-2z;
        Tue, 27 Jun 2023 15:13:09 +0000
Date:   Tue, 27 Jun 2023 23:12:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, logang@deltatee.com, hch@lst.de,
        song@kernel.org, shli@fb.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next 2/2] md/raid5-cache: fix null-ptr-deref in
 r5l_reclaim_thread()
Message-ID: <202306272247.VWiGIFDe-lkp@intel.com>
References: <20230627085611.4186951-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627085611.4186951-3-yukuai1@huaweicloud.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20230626]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/md-raid5-cache-Revert-md-raid5-cache-Clear-conf-log-after-finishing-work/20230627-165746
base:   next-20230626
patch link:    https://lore.kernel.org/r/20230627085611.4186951-3-yukuai1%40huaweicloud.com
patch subject: [PATCH -next 2/2] md/raid5-cache: fix null-ptr-deref in r5l_reclaim_thread()
config: x86_64-buildonly-randconfig-r003-20230627 (https://download.01.org/0day-ci/archive/20230627/202306272247.VWiGIFDe-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230627/202306272247.VWiGIFDe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306272247.VWiGIFDe-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/md/raid5-cache.c: In function 'r5l_do_reclaim':
>> drivers/md/raid5-cache.c:1496:24: warning: unused variable 'conf' [-Wunused-variable]
    1496 |         struct r5conf *conf = log->rdev->mddev->private;
         |                        ^~~~


vim +/conf +1496 drivers/md/raid5-cache.c

a39f7afde358ca Song Liu          2016-11-17  1493  
0576b1c618ef22 Shaohua Li        2015-08-13  1494  static void r5l_do_reclaim(struct r5l_log *log)
0576b1c618ef22 Shaohua Li        2015-08-13  1495  {
a39f7afde358ca Song Liu          2016-11-17 @1496  	struct r5conf *conf = log->rdev->mddev->private;
0576b1c618ef22 Shaohua Li        2015-08-13  1497  	sector_t reclaim_target = xchg(&log->reclaim_target, 0);
170364619ac21c Christoph Hellwig 2015-10-05  1498  	sector_t reclaimable;
170364619ac21c Christoph Hellwig 2015-10-05  1499  	sector_t next_checkpoint;
a39f7afde358ca Song Liu          2016-11-17  1500  	bool write_super;
0576b1c618ef22 Shaohua Li        2015-08-13  1501  
0576b1c618ef22 Shaohua Li        2015-08-13  1502  	spin_lock_irq(&log->io_list_lock);
a39f7afde358ca Song Liu          2016-11-17  1503  	write_super = r5l_reclaimable_space(log) > log->max_free_space ||
a39f7afde358ca Song Liu          2016-11-17  1504  		reclaim_target != 0 || !list_empty(&log->no_space_stripes);
0576b1c618ef22 Shaohua Li        2015-08-13  1505  	/*
0576b1c618ef22 Shaohua Li        2015-08-13  1506  	 * move proper io_unit to reclaim list. We should not change the order.
0576b1c618ef22 Shaohua Li        2015-08-13  1507  	 * reclaimable/unreclaimable io_unit can be mixed in the list, we
0576b1c618ef22 Shaohua Li        2015-08-13  1508  	 * shouldn't reuse space of an unreclaimable io_unit
0576b1c618ef22 Shaohua Li        2015-08-13  1509  	 */
0576b1c618ef22 Shaohua Li        2015-08-13  1510  	while (1) {
170364619ac21c Christoph Hellwig 2015-10-05  1511  		reclaimable = r5l_reclaimable_space(log);
170364619ac21c Christoph Hellwig 2015-10-05  1512  		if (reclaimable >= reclaim_target ||
0576b1c618ef22 Shaohua Li        2015-08-13  1513  		    (list_empty(&log->running_ios) &&
0576b1c618ef22 Shaohua Li        2015-08-13  1514  		     list_empty(&log->io_end_ios) &&
a8c34f915976e3 Shaohua Li        2015-09-02  1515  		     list_empty(&log->flushing_ios) &&
04732f741dce5e Christoph Hellwig 2015-10-05  1516  		     list_empty(&log->finished_ios)))
0576b1c618ef22 Shaohua Li        2015-08-13  1517  			break;
0576b1c618ef22 Shaohua Li        2015-08-13  1518  
170364619ac21c Christoph Hellwig 2015-10-05  1519  		md_wakeup_thread(log->rdev->mddev->thread);
170364619ac21c Christoph Hellwig 2015-10-05  1520  		wait_event_lock_irq(log->iounit_wait,
170364619ac21c Christoph Hellwig 2015-10-05  1521  				    r5l_reclaimable_space(log) > reclaimable,
170364619ac21c Christoph Hellwig 2015-10-05  1522  				    log->io_list_lock);
0576b1c618ef22 Shaohua Li        2015-08-13  1523  	}
170364619ac21c Christoph Hellwig 2015-10-05  1524  
f2ca7c4bb59762 Yu Kuai           2023-06-27  1525  	next_checkpoint = r5c_calculate_new_cp(log);
0576b1c618ef22 Shaohua Li        2015-08-13  1526  	spin_unlock_irq(&log->io_list_lock);
0576b1c618ef22 Shaohua Li        2015-08-13  1527  
a39f7afde358ca Song Liu          2016-11-17  1528  	if (reclaimable == 0 || !write_super)
0576b1c618ef22 Shaohua Li        2015-08-13  1529  		return;
0576b1c618ef22 Shaohua Li        2015-08-13  1530  
0576b1c618ef22 Shaohua Li        2015-08-13  1531  	/*
0576b1c618ef22 Shaohua Li        2015-08-13  1532  	 * write_super will flush cache of each raid disk. We must write super
0576b1c618ef22 Shaohua Li        2015-08-13  1533  	 * here, because the log area might be reused soon and we don't want to
0576b1c618ef22 Shaohua Li        2015-08-13  1534  	 * confuse recovery
0576b1c618ef22 Shaohua Li        2015-08-13  1535  	 */
4b482044d24f3d Shaohua Li        2015-10-08  1536  	r5l_write_super_and_discard_space(log, next_checkpoint);
0576b1c618ef22 Shaohua Li        2015-08-13  1537  
0576b1c618ef22 Shaohua Li        2015-08-13  1538  	mutex_lock(&log->io_mutex);
170364619ac21c Christoph Hellwig 2015-10-05  1539  	log->last_checkpoint = next_checkpoint;
a39f7afde358ca Song Liu          2016-11-17  1540  	r5c_update_log_state(log);
0576b1c618ef22 Shaohua Li        2015-08-13  1541  	mutex_unlock(&log->io_mutex);
0576b1c618ef22 Shaohua Li        2015-08-13  1542  
170364619ac21c Christoph Hellwig 2015-10-05  1543  	r5l_run_no_space_stripes(log);
0576b1c618ef22 Shaohua Li        2015-08-13  1544  }
0576b1c618ef22 Shaohua Li        2015-08-13  1545  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
