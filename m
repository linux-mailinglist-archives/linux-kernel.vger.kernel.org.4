Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB8E701ACB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 01:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjEMXUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 19:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEMXUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 19:20:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA492700;
        Sat, 13 May 2023 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684020020; x=1715556020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rEjsC050EnB334yNVCRh3vB5CJVdTb9qovPvhznaKOM=;
  b=K8eV+aXOeDwwV/lEGYvHO+llmudZmqiV5lij9IHpeD+DT7mRgx2zSZ9f
   X4NsmWG634l0S7fY7mjkD0fW25HxU9oUE/wt3w6x0L+BA+aaGRK61DYmF
   FFRenDA6+0sBsbag176FR7aq75LVgx3DzD0NHBk/5vt2vXC/0S4zNppUd
   hNtrVT/Yec7AgQZyee+DX4qd8xxWdfvJOhjQRZ9yzLQ6YiLgtUFRAPeJU
   CQ04APNQ09/gZfnktwjhGSkEelgF/vHF50t4YsmPjH2Ce/1hGU9DBEDDp
   8q5Ax4ekXCHauT3shxRtsgc3IftMDDU/hxCxTy/twkvrzX6TAGIehgXHn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="353261154"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="353261154"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 16:20:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="812487054"
X-IronPort-AV: E=Sophos;i="5.99,273,1677571200"; 
   d="scan'208";a="812487054"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 May 2023 16:20:18 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxyXB-0005it-1K;
        Sat, 13 May 2023 23:20:17 +0000
Date:   Sun, 14 May 2023 07:19:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Genjian <zhanggenjian123@gmail.com>, tsbogend@alpha.franken.de,
        rdunlap@infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhanggenjian123@gmail.com,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH v2] fix ___SYNC () build error when PROFILE_ALL_BRANCHES
 is enabled
Message-ID: <202305140702.w0bg48FH-lkp@intel.com>
References: <20230427150332.2978867-1-zhanggenjian@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427150332.2978867-1-zhanggenjian@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Genjian,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.4-rc1 next-20230512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Genjian/fix-___SYNC-build-error-when-PROFILE_ALL_BRANCHES-is-enabled/20230427-230626
base:   linus/master
patch link:    https://lore.kernel.org/r/20230427150332.2978867-1-zhanggenjian%40kylinos.cn
patch subject: [PATCH v2] fix ___SYNC () build error when PROFILE_ALL_BRANCHES is enabled
config: mips-decstation_defconfig (https://download.01.org/0day-ci/archive/20230514/202305140702.w0bg48FH-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6eb50851d61ca808629a062e0545704eba5be950
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Genjian/fix-___SYNC-build-error-when-PROFILE_ALL_BRANCHES-is-enabled/20230427-230626
        git checkout 6eb50851d61ca808629a062e0545704eba5be950
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305140702.w0bg48FH-lkp@intel.com/

All errors (new ones prefixed by >>):

   init/main.c:779:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     779 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:791:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     791 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   init/main.c:793:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     793 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:2288: Error: non-constant expression in ".if" statement
>> {standard input}: Error: end of file inside conditional
>> {standard input}:2288: Error: here is the start of the unterminated conditional
   {standard input}: Warning: missing .end at end of assembly
--
   {standard input}: Assembler messages:
   {standard input}:131: Error: non-constant expression in ".if" statement
>> {standard input}: Error: end of file inside conditional
   {standard input}:131: Error: here is the start of the unterminated conditional
   {standard input}: Warning: missing .end at end of assembly
--
   {standard input}: Assembler messages:
   {standard input}:245: Error: non-constant expression in ".if" statement
>> {standard input}: Error: end of file inside conditional
   {standard input}:245: Error: here is the start of the unterminated conditional
   {standard input}: Warning: missing .end at end of assembly
--
   {standard input}: Assembler messages:
   {standard input}:139: Error: non-constant expression in ".if" statement
>> {standard input}: Error: end of file inside conditional
   {standard input}:898: Error: here is the start of the unterminated conditional
   {standard input}: Warning: missing .end at end of assembly
--
   {standard input}: Assembler messages:
   {standard input}:67: Error: non-constant expression in ".if" statement
>> {standard input}: Error: end of file inside conditional
   {standard input}:149: Error: here is the start of the unterminated conditional
   {standard input}: Warning: missing .end at end of assembly
--
   arch/mips/kernel/syscall.c:51:16: warning: no previous prototype for 'sysm_pipe' [-Wmissing-prototypes]
      51 | asmlinkage int sysm_pipe(void)
         |                ^~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:356: Error: non-constant expression in ".if" statement
>> {standard input}: Error: end of file inside conditional
   {standard input}:356: Error: here is the start of the unterminated conditional
   {standard input}: Warning: missing .end at end of assembly
--
   {standard input}: Assembler messages:
   {standard input}:178: Error: non-constant expression in ".if" statement
>> {standard input}: Error: end of file inside conditional
   {standard input}:878: Error: here is the start of the unterminated conditional
   {standard input}: Warning: missing .end at end of assembly
--
   {standard input}: Assembler messages:
   {standard input}:90: Error: non-constant expression in ".if" statement
>> {standard input}: Error: end of file inside conditional
   {standard input}:169: Error: here is the start of the unterminated conditional
   {standard input}: Warning: missing .end at end of assembly
--
   {standard input}: Assembler messages:
   {standard input}:35: Error: non-constant expression in ".if" statement
>> {standard input}: Error: end of file inside conditional
   {standard input}:513: Error: here is the start of the unterminated conditional
   {standard input}: Warning: missing .end at end of assembly
--
   {standard input}: Assembler messages:
   {standard input}:100: Error: non-constant expression in ".if" statement
>> {standard input}: Error: end of file inside conditional
   {standard input}:138: Error: here is the start of the unterminated conditional
   {standard input}: Warning: missing .end at end of assembly
--
   {standard input}: Assembler messages:
   {standard input}:44: Error: non-constant expression in ".if" statement
>> {standard input}: Error: end of file inside conditional
   {standard input}:332: Error: here is the start of the unterminated conditional
   {standard input}: Warning: missing .end at end of assembly
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
