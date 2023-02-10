Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194696924FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjBJSC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjBJSC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:02:56 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0BD5FE44
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676052175; x=1707588175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ga/44LVjbV6mU/2wo9st/9uoyErb7dNgMErkJHuhkWU=;
  b=nxjV3ceScT0hm/0NK8vM28gpYUY82pycSUhPeweudM9eR5kPniAwG1At
   GRkAxuOT5AqKAzv95rmGR43vzJuzlZnfdBttbzRT4w8mlugoTOA6JAFdv
   zmQhDV5FsWKYxlL/V/qgSEpsmymkaA9rYy/Ht1gX5KhyRDsRYIszjB4C/
   u8uPaGVvf4D3moxRMyiEev6KrZIU+Um6+cyO2TF8FGmUseff4bBsYv5JB
   FQY6AHfSgD6U+GnKvEMv0QXpEGJvOREk3S2JxplkO5kddffaOktZS0nh2
   NVh6P2cNkcO38SLVuRmqapr9c0d8X4ucZnroOZoztsgrqZMq5F/3RDxXV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="329116699"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="329116699"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 10:01:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="997007731"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="997007731"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Feb 2023 10:01:42 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQXiP-0005xM-39;
        Fri, 10 Feb 2023 18:01:41 +0000
Date:   Sat, 11 Feb 2023 02:01:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] LoongArch: Add support for kernel relocation
Message-ID: <202302110150.tIuRIiTp-lkp@intel.com>
References: <1676018856-26520-5-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676018856-26520-5-git-send-email-tangyouling@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Youling,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.2-rc7 next-20230210]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Youling-Tang/LoongArch-Use-la-pcrel-instead-of-la-abs-when-it-s-trivially-possible/20230210-165022
patch link:    https://lore.kernel.org/r/1676018856-26520-5-git-send-email-tangyouling%40loongson.cn
patch subject: [PATCH v4 4/5] LoongArch: Add support for kernel relocation
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20230211/202302110150.tIuRIiTp-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/26dc7750408c7f232632db44fab905df7b48d83c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Youling-Tang/LoongArch-Use-la-pcrel-instead-of-la-abs-when-it-s-trivially-possible/20230210-165022
        git checkout 26dc7750408c7f232632db44fab905df7b48d83c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash arch/loongarch/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302110150.tIuRIiTp-lkp@intel.com/

Note: functions only called from assembly code should be annotated with the asmlinkage attribute
All warnings (new ones prefixed by >>):

>> arch/loongarch/kernel/relocate.c:21:13: warning: no previous prototype for 'relocate_kernel' [-Wmissing-prototypes]
      21 | void __init relocate_kernel(void)
         |             ^~~~~~~~~~~~~~~


vim +/relocate_kernel +21 arch/loongarch/kernel/relocate.c

    20	
  > 21	void __init relocate_kernel(void)
    22	{
    23		reloc_offset = (unsigned long)_text - VMLINUX_LOAD_ADDRESS;
    24	
    25		if (reloc_offset) {
    26			Elf64_Rela *rela, *rela_end;
    27			rela = (Elf64_Rela *)&__rela_dyn_start;
    28			rela_end = (Elf64_Rela *)&__rela_dyn_end;
    29	
    30			for ( ; rela < rela_end; rela++) {
    31				Elf64_Addr addr = rela->r_offset;
    32				Elf64_Addr relocated_addr = rela->r_addend;
    33	
    34				if (rela->r_info != R_LARCH_RELATIVE)
    35					continue;
    36	
    37				if (relocated_addr >= VMLINUX_LOAD_ADDRESS)
    38					relocated_addr =
    39						(Elf64_Addr)RELOCATED(relocated_addr);
    40	
    41				*(Elf64_Addr *)RELOCATED(addr) = relocated_addr;
    42			}
    43		}
    44	}
    45	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
