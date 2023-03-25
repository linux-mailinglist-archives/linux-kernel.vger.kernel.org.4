Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD596C89AC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 01:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjCYAhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 20:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCYAho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 20:37:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04778EB6F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 17:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679704663; x=1711240663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EDmSn0BoNS6C36guPoIH97rCDRjlnX5uzMGFKE4QSsc=;
  b=B58W2at5TL1J7qC6Uyr4xfSWfRliOTF3o7aKiAYDIMhBFmRTNc45ZPHB
   aGaisdv+4qYjAxOrudHwjJorSwUKiexIOKZPPo3uP3k4UCPyrDbkSQu3S
   9hC7FBNdtUhq05HSmOZoT+5jRO6YRhEaRFw8yi1YLodsyXnQ0nbVWBlhu
   oKVYsP/Rr7cpCwDfsekNYpiyN16H+9qRpXbEFaOn2kWHXMVJ2r+1iNNqb
   2n8R/yxsOe+/xcFMp/SIDTaIm0GWdVDV9owSdfuRsnZoL2xKByjfmWOSy
   LG6zQ18D5sDNpC6knYR0+AtxeFGpt0q/zznXlSx4Szy/PxulTVA+O40Pv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="339941400"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="339941400"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 17:37:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="826436446"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="826436446"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2023 17:37:40 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfrud-000FoJ-31;
        Sat, 25 Mar 2023 00:37:39 +0000
Date:   Sat, 25 Mar 2023 08:37:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Disable EL2 traps for BRBE instructions executed
 in EL1
Message-ID: <202303250802.KytExIHw-lkp@intel.com>
References: <20230324055127.2228330-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324055127.2228330-1-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on arm/for-next arm/fixes kvmarm/next soc/for-next xilinx-xlnx/master linus/master v6.3-rc3 next-20230324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/arm64-Disable-EL2-traps-for-BRBE-instructions-executed-in-EL1/20230324-135312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230324055127.2228330-1-anshuman.khandual%40arm.com
patch subject: [PATCH] arm64: Disable EL2 traps for BRBE instructions executed in EL1
config: arm64-randconfig-r001-20230322 (https://download.01.org/0day-ci/archive/20230325/202303250802.KytExIHw-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/457bbac085c7f83be1a63b54f6caf32b820503eb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anshuman-Khandual/arm64-Disable-EL2-traps-for-BRBE-instructions-executed-in-EL1/20230324-135312
        git checkout 457bbac085c7f83be1a63b54f6caf32b820503eb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303250802.KytExIHw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> <instantiation>:36:14: error: expected compatible register or logical immediate
    orr x0, x0, #HFGITR_EL2_nBRBIALL
                ^
   <instantiation>:10:2: note: while in macro instantiation
    __init_el2_fgt
    ^
   arch/arm64/kernel/head.S:577:2: note: while in macro instantiation
    init_el2_state
    ^
   <instantiation>:37:14: error: expected compatible register or logical immediate
    orr x0, x0, #HFGITR_EL2_nBRBINJ
                ^
   <instantiation>:10:2: note: while in macro instantiation
    __init_el2_fgt
    ^
   arch/arm64/kernel/head.S:577:2: note: while in macro instantiation
    init_el2_state
    ^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
