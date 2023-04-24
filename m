Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381C16ED67E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjDXVEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDXVEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:04:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519796184;
        Mon, 24 Apr 2023 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682370246; x=1713906246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w120y8U0Nl44mL6g4HwtTn60PEDVyOXswzL2W/2Luk0=;
  b=LljMitiSSzDxkNC9TZzposGvInJl40F7NhKryKOPgZpUcLLPpjKihwXZ
   /utwgJsigWA6Iqnc3jD8hC15E+sB9k4Y2xXKkz+Z6mHRkiMc/uWmidJ+N
   RmlEH/xeZ+inUtBWCfsCjYLDLXxiv6km9Bgf+vZxk7VlZWu8vd2OK+3h3
   Ulqct6MQQ6z6JTGN2KdmWH3qBH13cUQ3ViXBhakUN4MFkiD88YWGs2ig0
   WBTDw9J/M9glxeDnmWdnzchWlv7F8eBqGABp7OohMqiIjVaAADHLSIRa7
   OhzurocdQfza4PiVltt1sS/MlpP5/pU8uDj1RSjbvA9ICfe00oA6+0IGu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="326873558"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="326873558"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 14:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="782545860"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="782545860"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Apr 2023 14:04:01 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pr3Ls-000iee-0R;
        Mon, 24 Apr 2023 21:04:00 +0000
Date:   Tue, 25 Apr 2023 05:03:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Donghun Yoon <donghun.yoon@lge.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci-pci: Only run d3cold avoidance quirk for s2idle
Message-ID: <202304250440.oxpMvFPQ-lkp@intel.com>
References: <20230424134926.1416-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424134926.1416-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.3 next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/xhci-pci-Only-run-d3cold-avoidance-quirk-for-s2idle/20230424-215356
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230424134926.1416-1-mario.limonciello%40amd.com
patch subject: [PATCH] xhci-pci: Only run d3cold avoidance quirk for s2idle
config: i386-randconfig-a005-20230424 (https://download.01.org/0day-ci/archive/20230425/202304250440.oxpMvFPQ-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8e287659296330d0cb31e4730daacc92d0467e63
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/xhci-pci-Only-run-d3cold-avoidance-quirk-for-s2idle/20230424-215356
        git checkout 8e287659296330d0cb31e4730daacc92d0467e63
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304250440.oxpMvFPQ-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "pm_suspend_target_state" [drivers/usb/host/xhci-pci.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
