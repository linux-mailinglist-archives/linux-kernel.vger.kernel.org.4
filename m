Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2A86C4300
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCVGV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCVGV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:21:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FD4442CA;
        Tue, 21 Mar 2023 23:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679466085; x=1711002085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sV9yrowQ+RnaJFvNng0mNFOKmQMIaJRRqKuH1yOHxSk=;
  b=JabRBkoxTUoPkGmhfqbRlA3OSegdz/lXRUwE80rgojBwPyozXbSfmTRP
   8qlUN5Fnt7lLMbOUYCRpsHp0f7b0H2hI5dIlNQt65AvzF8NbjJMj7jiwf
   bindiJMbeDlqI9AkmBsFHPRZbYF+ZcrI95aLURDlh0k3OOMLmBpg5pSgL
   dt+hBK6MOcLO9P2pPlH2M892rbq/X8a2Vzm7CSMSn/kdVJrEsrQ4spH75
   9GRnjrzMeYNb8WRAS3/wmfV/SYv5INyIxlEm7xFYykKzLP8NYSdcVFYG6
   6jDTQrie49z0Ogt06TXbilbAK6a44oata+xX89hsj0NMl3X91Wq1cHlh4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="339177967"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="339177967"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 23:21:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="770936644"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="770936644"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Mar 2023 23:21:22 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1perqc-000CyQ-13;
        Wed, 22 Mar 2023 06:21:22 +0000
Date:   Wed, 22 Mar 2023 14:20:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tanmay Shah <tanmay.shah@amd.com>,
        Tarak Reddy <tarak.reddy@amd.com>
Subject: Re: [PATCH v2 2/2] remoteproc: enhance rproc_put() for clusters
Message-ID: <202303221441.cuBnpvye-lkp@intel.com>
References: <20230322040933.924813-3-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322040933.924813-3-tanmay.shah@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
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
config: arm-randconfig-r013-20230322 (https://download.01.org/0day-ci/archive/20230322/202303221441.cuBnpvye-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/573d22d13a697097d02d6c29a75fb0fb1ac6d8fe
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tanmay-Shah/remoteproc-Make-rproc_get_by_phandle-work-for-clusters/20230322-121102
        git checkout 573d22d13a697097d02d6c29a75fb0fb1ac6d8fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303221441.cuBnpvye-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/remoteproc_core.c:2563:26: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           struct platform_device *cluster_pdev;
                                   ^
   1 warning generated.


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
