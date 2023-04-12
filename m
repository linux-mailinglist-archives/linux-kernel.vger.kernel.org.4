Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80FA6DE8ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjDLBcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDLBcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:32:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA5B49FD;
        Tue, 11 Apr 2023 18:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681263162; x=1712799162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NpHSJadvgON+Y54a3OFsI9t8u2jTudA5HtPGaVo/gvg=;
  b=nyIaRmCmgn1fPrIAaCb1pY7uYYiCZqpqEc66o/vEhIV9fF72E5qxXhXw
   x8onCJ3xsNZq5HeLvfiFeW/DKzgUh3TNNeQCNHxjBcz8WXRSYReRpJ5uj
   8PZuWlh7fbGJv2XgUPCvUj3efdmqfYiZLUv2PEK++jyEWobs3BSy461JJ
   D5kzEbJiMShC1zHMN+cpgRajzHo7qSLFGU5i20wwXUQS6EwupH4dMDkCJ
   hTMB2TvLXnvMvOfvm3XDJCO+NNes1IO1Tv9QYgz8GF7MbtHImhaXwnrfb
   ufFcuOvCZOywmLyLt29xso7c+zRwA7NU4OxwYoVUYOXIgHW7oyESn2ilE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="345565035"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="345565035"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 18:32:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="1018571587"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018571587"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Apr 2023 18:32:38 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmPLh-000Ww5-0j;
        Wed, 12 Apr 2023 01:32:37 +0000
Date:   Wed, 12 Apr 2023 09:32:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, terry.bowman@amd.com,
        rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v3 4/6] cxl/pci: Add RCH downstream port error logging
Message-ID: <202304120926.dekDF6um-lkp@intel.com>
References: <20230411180302.2678736-5-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411180302.2678736-5-terry.bowman@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Terry,

kernel test robot noticed the following build errors:

[auto build test ERROR on ca712e47054678c5ce93a0e0f686353ad5561195]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Bowman/cxl-pci-Add-RCH-downstream-port-AER-and-RAS-register-discovery/20230412-020957
base:   ca712e47054678c5ce93a0e0f686353ad5561195
patch link:    https://lore.kernel.org/r/20230411180302.2678736-5-terry.bowman%40amd.com
patch subject: [PATCH v3 4/6] cxl/pci: Add RCH downstream port error logging
config: loongarch-buildonly-randconfig-r004-20230409 (https://download.01.org/0day-ci/archive/20230412/202304120926.dekDF6um-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7f1c5cefb1e75bd709dc35c7f5e3e29dd5df65e1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Terry-Bowman/cxl-pci-Add-RCH-downstream-port-AER-and-RAS-register-discovery/20230412-020957
        git checkout 7f1c5cefb1e75bd709dc35c7f5e3e29dd5df65e1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304120926.dekDF6um-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/cxl/core/pci.o: in function `cxl_rch_log_error':
   drivers/cxl/core/pci.c:768: undefined reference to `cper_print_aer'
>> loongarch64-linux-ld: drivers/cxl/core/pci.c:768: undefined reference to `cper_print_aer'
>> loongarch64-linux-ld: drivers/cxl/core/pci.c:768: undefined reference to `cper_print_aer'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
