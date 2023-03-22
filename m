Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A096C441E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCVHcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCVHca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:32:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6585FED;
        Wed, 22 Mar 2023 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679470349; x=1711006349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TvjfNRcHDkuEr+44MH6cZnJ0qM5gMaDlNVzAz9jGtTY=;
  b=cXEmXXLXhylWSeZ1Mke4Lsn6jxc3uUdSlpfG3eB0bakQ7C/Yx6kYrFt9
   pDuBcZcEiC0kgibEttCza8LhiyjQC8ooBNIiImHC2/sjWvsgtgCiEfrOR
   UaM35ioyBqMUSyihdXjbcC2/pZjH5zCEF4/PxSLI//RBs2netRGPl9fSc
   GmM+LjY2Qsqmwhh5MgAmtlrGdJ/uZGxUR2ivRqu3SuaKW+1I6aO5d096k
   SO0Xz3CCJ+kEW46P4x3fv1GjvqPTL9uHJ3hPWIfDXk5fvMYfqgczF3uP+
   qwIkwjuY45ds8OOov0REUCv6XrxrbbQtA8zgYCcX+Ykaq3GttOtoiI6l2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="340685697"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="340685697"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 00:32:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="805727862"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="805727862"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Mar 2023 00:32:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pesxN-000D3e-2n;
        Wed, 22 Mar 2023 07:32:25 +0000
Date:   Wed, 22 Mar 2023 15:31:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tanmay Shah <tanmay.shah@amd.com>,
        Tarak Reddy <tarak.reddy@amd.com>
Subject: Re: [PATCH v2 2/2] remoteproc: enhance rproc_put() for clusters
Message-ID: <202303221514.3xIiCbpk-lkp@intel.com>
References: <20230322040933.924813-3-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322040933.924813-3-tanmay.shah@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tanmay,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on e19967994d342a5986d950a1bfddf19d7e1191b7]

url:    https://github.com/intel-lab-lkp/linux/commits/Tanmay-Shah/remoteproc-Make-rproc_get_by_phandle-work-for-clusters/20230322-121102
base:   e19967994d342a5986d950a1bfddf19d7e1191b7
patch link:    https://lore.kernel.org/r/20230322040933.924813-3-tanmay.shah%40amd.com
patch subject: [PATCH v2 2/2] remoteproc: enhance rproc_put() for clusters
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230322/202303221514.3xIiCbpk-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/573d22d13a697097d02d6c29a75fb0fb1ac6d8fe
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tanmay-Shah/remoteproc-Make-rproc_get_by_phandle-work-for-clusters/20230322-121102
        git checkout 573d22d13a697097d02d6c29a75fb0fb1ac6d8fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303221514.3xIiCbpk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/remoteproc/remoteproc_core.c: In function 'rproc_put':
>> drivers/remoteproc/remoteproc_core.c:2563:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    2563 |         struct platform_device *cluster_pdev;
         |         ^~~~~~


vim +2563 drivers/remoteproc/remoteproc_core.c

  2550	
  2551	/**
  2552	 * rproc_put() - release rproc reference
  2553	 * @rproc: the remote processor handle
  2554	 *
  2555	 * This function decrements the rproc dev refcount.
  2556	 *
  2557	 * If no one holds any reference to rproc anymore, then its refcount would
  2558	 * now drop to zero, and it would be freed.
  2559	 */
  2560	void rproc_put(struct rproc *rproc)
  2561	{
  2562		module_put(rproc->dev.parent->driver->owner);
> 2563		struct platform_device *cluster_pdev;
  2564	
  2565		if (rproc->dev.parent) {
  2566			if (rproc->dev.parent->driver) {
  2567				module_put(rproc->dev.parent->driver->owner);
  2568			} else {
  2569				cluster_pdev = of_find_device_by_node(rproc->dev.parent->of_node->parent);
  2570				if (cluster_pdev) {
  2571					module_put(cluster_pdev->dev.driver->owner);
  2572					put_device(&cluster_pdev->dev);
  2573				}
  2574			}
  2575		}
  2576		put_device(&rproc->dev);
  2577	}
  2578	EXPORT_SYMBOL(rproc_put);
  2579	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
