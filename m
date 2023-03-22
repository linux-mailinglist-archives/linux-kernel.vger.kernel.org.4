Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5C86C403A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCVCPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCVCPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:15:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433972197E;
        Tue, 21 Mar 2023 19:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679451314; x=1710987314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zkutf1Yva2S5sDuaQ/5qW6PUkaAWInQ2qoCKwvKC4ms=;
  b=ngoliHaeLt1Y+P6lYAdLTsywVnMHl5e0q4sCR5gguv/z984nD+i7tZbV
   dG5NOMengz6l1TEK1d8N2ZJIk2O2zNxyfPIrbc0PJDKtlnIiZJmQzQkGU
   82sjy+jP6fqa9NdIUPgn4s7DjYWMTtSsSRy7380i3fGWxkSBAooDv8y1S
   HJpaHcz1awg1T2mcFNRwkVaRdqvo+WwCTqurrIiC+87515mZKdX12KqHm
   x9IAdNmjfQmp6/V6WFsYukf82f+48FjFYPO7Nnm/68V/xfAJDkMc+iTSl
   VYN8kSHDNjNP++pztto0lz9I+kf2WSpz4BH9KQ5qCOC+KHJvVQYq/NIjJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="401677803"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="401677803"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 19:15:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="746127578"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="746127578"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Mar 2023 19:15:09 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peo0K-000Ch8-0k;
        Wed, 22 Mar 2023 02:15:08 +0000
Date:   Wed, 22 Mar 2023 10:14:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        xen-devel@lists.xenproject.org,
        Roger Pau Monne <roger.pau@citrix.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5] ACPI: processor: Fix evaluating _PDC method when
 running as Xen dom0
Message-ID: <202303221035.BFY5kyh1-lkp@intel.com>
References: <20230321141904.49177-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321141904.49177-1-roger.pau@citrix.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on xen-tip/linux-next]
[also build test ERROR on rafael-pm/linux-next linus/master v6.3-rc3 next-20230321]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roger-Pau-Monne/ACPI-processor-Fix-evaluating-_PDC-method-when-running-as-Xen-dom0/20230321-221950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git linux-next
patch link:    https://lore.kernel.org/r/20230321141904.49177-1-roger.pau%40citrix.com
patch subject: [PATCH v5] ACPI: processor: Fix evaluating _PDC method when running as Xen dom0
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20230322/202303221035.BFY5kyh1-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4232c8b37a0415e1e828fef4ce522c93a0b925fc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Roger-Pau-Monne/ACPI-processor-Fix-evaluating-_PDC-method-when-running-as-Xen-dom0/20230321-221950
        git checkout 4232c8b37a0415e1e828fef4ce522c93a0b925fc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303221035.BFY5kyh1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/xen/suspend_hvm.c:4:
>> include/xen/xen.h:79:2: error: implicit declaration of function 'BUG' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           BUG();
           ^
   1 error generated.


vim +/BUG +79 include/xen/xen.h

    73	
    74	#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI) && defined(CONFIG_X86)
    75	bool __init xen_processor_present(uint32_t acpi_id);
    76	#else
    77	static inline bool xen_processor_present(uint32_t acpi_id)
    78	{
  > 79		BUG();
    80		return false;
    81	}
    82	#endif
    83	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
