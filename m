Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B6C70D0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjEWCRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEWCRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:17:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AD4188;
        Mon, 22 May 2023 19:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684808212; x=1716344212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O3Nuri+DG1gTT8nlRY3lmDXYmBR5yEt4so5n7inqQsU=;
  b=R5eZqWu1ta2yvulql3n8+T4oSO0zuy0IFo2KZumh+FrcAdpNqLr89byS
   TIpy9alBf/rUrKAdTYWfhE/mhD2iE7OuAZtjYBdMloUvGWTuvODV8otdE
   3JTxB/Xbg7jQXMGKXUOR9aRLSsGdphJ9MNjzB1jJYl8y3/ul6Xtx2IjyN
   eVUzY75Mx/4n8juRPycE9PFkcDBjSwibmkzR6yJRLB1uwET4H7I3tWcOb
   RebS0MRprygbljhV8lfKKSMPvZd8jOVepN399551S3DiUxNpul8GlPSWe
   DnHwcsz+ol67r0uyBITU3bx4eQI8Vhi3zmMyyl2LE5+ydwiTxCHXjm7Gk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="351949733"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="351949733"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 19:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="654183381"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="654183381"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 May 2023 19:16:38 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1HZl-000DRT-1v;
        Tue, 23 May 2023 02:16:37 +0000
Date:   Tue, 23 May 2023 10:15:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org, neilb@suse.de,
        akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2] md: fix duplicate filename for rdev
Message-ID: <202305230956.Zk6vAYvj-lkp@intel.com>
References: <20230522133225.2983667-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522133225.2983667-1-yukuai1@huaweicloud.com>
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

[auto build test WARNING on song-md/md-next]
[also build test WARNING on linus/master v6.4-rc3 next-20230522]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/md-fix-duplicate-filename-for-rdev/20230522-221940
base:   git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
patch link:    https://lore.kernel.org/r/20230522133225.2983667-1-yukuai1%40huaweicloud.com
patch subject: [PATCH v2] md: fix duplicate filename for rdev
config: i386-defconfig (https://download.01.org/0day-ci/archive/20230523/202305230956.Zk6vAYvj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/b6addfb36d27d4c98b397edec92ed6feeaf7afab
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yu-Kuai/md-fix-duplicate-filename-for-rdev/20230522-221940
        git checkout b6addfb36d27d4c98b397edec92ed6feeaf7afab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305230956.Zk6vAYvj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/md/md.c:90:33: warning: 'md_rdev_misc_wq' defined but not used [-Wunused-variable]
      90 | static struct workqueue_struct *md_rdev_misc_wq;
         |                                 ^~~~~~~~~~~~~~~


vim +/md_rdev_misc_wq +90 drivers/md/md.c

edb39c9deda87d Goldwyn Rodrigues 2014-03-29  86  
90b08710e41a07 Bernd Schubert    2008-05-23  87  static DECLARE_WAIT_QUEUE_HEAD(resync_wait);
e804ac780e2f01 Tejun Heo         2010-10-15  88  static struct workqueue_struct *md_wq;
e804ac780e2f01 Tejun Heo         2010-10-15  89  static struct workqueue_struct *md_misc_wq;
cc1ffe61c026e2 Guoqing Jiang     2020-04-04 @90  static struct workqueue_struct *md_rdev_misc_wq;
90b08710e41a07 Bernd Schubert    2008-05-23  91  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
