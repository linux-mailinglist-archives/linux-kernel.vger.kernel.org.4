Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93200687549
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 06:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjBBFie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 00:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjBBFiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 00:38:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993067F6B9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 21:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675316113; x=1706852113;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PDbEuUmwp+V/2lN4nebIRxklWGbX08aAHigqONFSZvo=;
  b=Q1Of8ipqbBdettKrtbGpQ2saQbhTXuhwSLAKuiaUeEbgsgPjelht4t1w
   OlZe9alPFCIdN4sJSOfeTKnqta6NBT/ecIl9OHMDLEJRCIx4B0wMZbC/5
   wYCuOA6JenC3amOdA91im9tqU7AcbgD4jmlSW1LB2S6B0tImFPFjv/zs/
   lixHJyE3umIynfsGMTH7NyonFIDVLCAjQ0C35T/Pf86yWK2L/Zr5cNgcQ
   mvsRhFg2vM7yYpthGX+V3P6qxKXKupKEFDRdJ3TkHGuykcbYwsgS4i/4Y
   xrI3bqJVRrJnvorPfuO7sKvpOBAKaU4yea1i8jFtgrVMjVk/WMx6uQ83J
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="327008155"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="327008155"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 21:35:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="665149076"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="665149076"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2023 21:35:12 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNSFb-0006Bv-1C;
        Thu, 02 Feb 2023 05:35:11 +0000
Date:   Thu, 2 Feb 2023 13:34:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: undefined reference to `ftrace_likely_update'
Message-ID: <202302021357.6J6gmGma-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f266ccaa2f5228bfe67ad58a94ca4e0109b954a
commit: 54d9469bc515dc5fcbc20eecbe19cea868b70d68 fortify: Add run-time WARN for cross-field memcpy()
date:   5 months ago
config: s390-randconfig-r044-20230202 (https://download.01.org/0day-ci/archive/20230202/202302021357.6J6gmGma-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=54d9469bc515dc5fcbc20eecbe19cea868b70d68
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 54d9469bc515dc5fcbc20eecbe19cea868b70d68
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: arch/s390/purgatory/purgatory: in function `sha256_update':
>> (.text+0x248c): undefined reference to `ftrace_likely_update'
>> s390-linux-ld: (.text+0x24a4): undefined reference to `ftrace_likely_update'
   s390-linux-ld: (.text+0x24bc): undefined reference to `ftrace_likely_update'
   s390-linux-ld: (.text+0x29b4): undefined reference to `ftrace_likely_update'
   s390-linux-ld: (.text+0x29cc): undefined reference to `ftrace_likely_update'
   s390-linux-ld: arch/s390/purgatory/purgatory:(.text+0x29e4): more undefined references to `ftrace_likely_update' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
