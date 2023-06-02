Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112BA71F950
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 06:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjFBE0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 00:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjFBE0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 00:26:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7BFD3;
        Thu,  1 Jun 2023 21:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685679970; x=1717215970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=csfhNafk9mF6E6/qV6/dDOIICipEWAC/QtetxLOCpoE=;
  b=DtvXacJt38TpYeW6iEIPfIhK4Ggs15hkVuhYVND5EN8maCUD+RLZC79E
   ZC7wfh43XjcP0llzCf3UYQwttmoWYasdl3nNHWl7d1ZPuLJLKsSY8d2q3
   Xb2XI8pekMt2NDqgvUIc81GfB8PXA3t5X339Fmmepx7HNJ7hKbkopo4RG
   tpuKlqz2eOTXxQJF0ZOCJEL0iYYJrIRpIjO/8t9/4MI0c1X/4n4eRp46o
   xRpXVjfIWW60rmiAyTH+gtXg6uNyRapseWRVfwDVvMVqTw9YiYbCWLiGz
   4yZsRYH5HwuSA57MXqmavEzs3gZTmUIxRyXmHtVH73Cc0n19nRa1qeAcP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358196902"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="358196902"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 21:26:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="1037763083"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="1037763083"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jun 2023 21:26:06 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4wMY-00003r-01;
        Fri, 02 Jun 2023 04:26:06 +0000
Date:   Fri, 2 Jun 2023 12:25:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     oe-kbuild-all@lists.linux.dev, dlemoal@kernel.org,
        bblock@linux.ibm.com, acelan.kao@canonical.com,
        linux-pm@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] scsi: core: Wait until device is fully resumed before
 doing rescan
Message-ID: <202306021251.amkU7A6P-lkp@intel.com>
References: <20230601155652.1157611-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601155652.1157611-1-kai.heng.feng@canonical.com>
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

Hi Kai-Heng,

kernel test robot noticed the following build errors:

[auto build test ERROR on mkp-scsi/for-next]
[also build test ERROR on jejb-scsi/for-next linus/master v6.4-rc4 next-20230601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kai-Heng-Feng/scsi-core-Wait-until-device-is-fully-resumed-before-doing-rescan/20230601-235821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230601155652.1157611-1-kai.heng.feng%40canonical.com
patch subject: [PATCH v5] scsi: core: Wait until device is fully resumed before doing rescan
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20230602/202306021251.amkU7A6P-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/fe2b65dd8204442bd73db8a6e40d8307e11fcd04
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kai-Heng-Feng/scsi-core-Wait-until-device-is-fully-resumed-before-doing-rescan/20230601-235821
        git checkout fe2b65dd8204442bd73db8a6e40d8307e11fcd04
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306021251.amkU7A6P-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/scsi/scsi_scan.c: In function 'scsi_rescan_device':
>> drivers/scsi/scsi_scan.c:1627:48: error: 'struct dev_pm_info' has no member named 'completion'
    1627 |                 wait_for_completion(&dev->power.completion);
         |                                                ^


vim +1627 drivers/scsi/scsi_scan.c

  1621	
  1622	void scsi_rescan_device(struct device *dev)
  1623	{
  1624		struct scsi_device *sdev = to_scsi_device(dev);
  1625	
  1626		if (dev->power.is_suspended)
> 1627			wait_for_completion(&dev->power.completion);
  1628	
  1629		device_lock(dev);
  1630	
  1631		scsi_attach_vpd(sdev);
  1632		scsi_cdl_check(sdev);
  1633	
  1634		if (sdev->handler && sdev->handler->rescan)
  1635			sdev->handler->rescan(sdev);
  1636	
  1637		if (dev->driver && try_module_get(dev->driver->owner)) {
  1638			struct scsi_driver *drv = to_scsi_driver(dev->driver);
  1639	
  1640			if (drv->rescan)
  1641				drv->rescan(dev);
  1642			module_put(dev->driver->owner);
  1643		}
  1644		device_unlock(dev);
  1645	}
  1646	EXPORT_SYMBOL(scsi_rescan_device);
  1647	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
