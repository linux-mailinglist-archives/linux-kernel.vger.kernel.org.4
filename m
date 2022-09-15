Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A11F5B9B81
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiIONBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiIONBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:01:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95739C227
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 06:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663246871; x=1694782871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GWNiP8wVuLx7SUVQZvvlRmgGYxo8q7rd3NkKaIEJzRA=;
  b=Yg5GC/FCjlhi8MOxTIEW2s/d9EoHKCkb6TOzsjYD/FywNahQCGe3W84R
   1P+9UMUcfJs22/4z+/MreJQI5TWk2I9nRbTqDHeITl5905DktJo+15Y5j
   d1wv1u1sOI9xGKkKbXQmM32HbMcD+ybVx5xIDZq5bbE+Hv8E2WjeEiKSX
   THmFs/KLTUkOF/gSMBBMLxlzzWD5h9gXln5X+Zoq9f/p2NC+7z1/Exs/a
   xJ+7lziH8XvoIJh47+Ibj9UTM6jyTluQVG7xq6+IcOLk4jEz3f5393ZzL
   FDmUFtM/7Aq19voVeNUoZ5QLnViX6rjCBRFDN7jpWL3GE32Py2E7h1teJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="324966256"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="324966256"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 06:01:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="568418338"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Sep 2022 06:01:10 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYoUP-0000aC-1N;
        Thu, 15 Sep 2022 13:01:09 +0000
Date:   Thu, 15 Sep 2022 21:00:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gianfranco <gianfranco.dutka@arista.com>,
        hirofumi@mail.parknet.co.jp
Cc:     kbuild-all@lists.01.org, gianfranco.dutka@arista.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]     fat: device-level-flush-after-sync
Message-ID: <202209152048.xURrWxEC-lkp@intel.com>
References: <20220914174015.7158-1-gianfranco.dutka@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914174015.7158-1-gianfranco.dutka@arista.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gianfranco,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc5 next-20220915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gianfranco/fat-device-level-flush-after-sync/20220915-014337
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3245cb65fd91cd514801bf91f5a3066d562f0ac4
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220915/202209152048.xURrWxEC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/b1130c74311f7b8c0713f373a8dc20b572883fca
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gianfranco/fat-device-level-flush-after-sync/20220915-014337
        git checkout b1130c74311f7b8c0713f373a8dc20b572883fca
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/fat/inode.c: In function 'fat_sync_fs':
>> fs/fat/inode.c:829:24: error: too many arguments to function 'blkdev_issue_flush'
     829 |                 return blkdev_issue_flush(sb->s_bdev, GFP_KERNEL, NULL);
         |                        ^~~~~~~~~~~~~~~~~~
   In file included from fs/fat/inode.c:21:
   include/linux/blkdev.h:1031:5: note: declared here
    1031 | int blkdev_issue_flush(struct block_device *bdev);
         |     ^~~~~~~~~~~~~~~~~~


vim +/blkdev_issue_flush +829 fs/fat/inode.c

   825	
   826	static int fat_sync_fs(struct super_block *sb, int wait)
   827	{
   828		if (wait)
 > 829			return blkdev_issue_flush(sb->s_bdev, GFP_KERNEL, NULL);
   830		else
   831			return 0;
   832	}
   833	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
