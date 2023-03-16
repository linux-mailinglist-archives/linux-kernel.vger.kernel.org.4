Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6606BDCB3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjCPXJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjCPXJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:09:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5F82069C;
        Thu, 16 Mar 2023 16:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679008190; x=1710544190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UH68FltZn58LYhbziPJqYiYePEpTo7vpEi3kwULtdnI=;
  b=BtsWUG1XRfc65DFGs/aK9+iFwTEmMh784ohtsvkCaxULYFl46oEK4i1R
   23Roav25DUFOurvXGOJMt2X4ke4XIvgJw3K8wrbpJ7wmhqF7O7k5G0T18
   +mBPW1r3jATtpUE3pHvVNsjcEhdvOxZ3lmrUaChsIGeqXwUx1VcN+uDPe
   kVoSw0FcChYsPFn9z88XJZCjEQbWuOD+McGGRT5KXbFgCUmZvKsqjyW8m
   a+aSFQOjsDIdVEc9lGQ5uR16Ytbp8HpF0dFelaHlbgqvlQ2+jC03W3DlZ
   UeDRuYYIDgTwFjkodaziKl9yZ5yFjp4HjU4xlgdmpqYMErK1C2Xs2jhBH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="400717989"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="400717989"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 16:09:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="925933479"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="925933479"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2023 16:09:46 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcwjB-0008sY-2t;
        Thu, 16 Mar 2023 23:09:45 +0000
Date:   Fri, 17 Mar 2023 07:08:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zheng Wang <zyytlz.wz@163.com>, valentina.manea.m@gmail.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        skhan@linuxfoundation.org, Zheng Wang <zyytlz.wz@163.com>
Subject: Re: [PATCH v2] usbip: vudc: Fix use after free bug in vudc_remove
 due to race condition
Message-ID: <202303170604.MoMGMPvW-lkp@intel.com>
References: <20230316180940.1601515-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316180940.1601515-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.3-rc2 next-20230316]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zheng-Wang/usbip-vudc-Fix-use-after-free-bug-in-vudc_remove-due-to-race-condition/20230317-021228
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230316180940.1601515-1-zyytlz.wz%40163.com
patch subject: [PATCH v2] usbip: vudc: Fix use after free bug in vudc_remove due to race condition
config: i386-randconfig-a015-20230313 (https://download.01.org/0day-ci/archive/20230317/202303170604.MoMGMPvW-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/46cc0947344ed93f7f1f4639209c5c6cce16fad3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zheng-Wang/usbip-vudc-Fix-use-after-free-bug-in-vudc_remove-due-to-race-condition/20230317-021228
        git checkout 46cc0947344ed93f7f1f4639209c5c6cce16fad3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/usb/usbip/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303170604.MoMGMPvW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/usbip/vudc_dev.c:636:28: error: no member named 'timer' in 'struct vudc'
           timer_shutdown_sync(&udc->timer);
                                ~~~  ^
   1 error generated.


vim +636 drivers/usb/usbip/vudc_dev.c

   631	
   632	int vudc_remove(struct platform_device *pdev)
   633	{
   634		struct vudc *udc = platform_get_drvdata(pdev);
   635	
 > 636		timer_shutdown_sync(&udc->timer);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
