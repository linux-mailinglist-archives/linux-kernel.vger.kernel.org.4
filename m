Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60176A2755
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 06:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjBYFJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 00:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYFJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 00:09:22 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A435822A09
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 21:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677301760; x=1708837760;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f6uC0/79wJsurMPrZcTV4Yz2DF6Y8vLj+maeBcPWamM=;
  b=k1h/cFX6+jLFXK0qk3HJn++kaeFHnOYZ/ONPpSOmNZCjV7xl/iAz66K2
   +9Hn4GqMDACutXucO+FAThnHsCHcMzWGHDOmQi5Yr1FDrAfr4T5aXiTpu
   OTbfSWynKpqNlHdb+NITpZBlPTkQHGj+bvwy3smnOvYf7zUFzXZRpqLM+
   VpJ+EV6Gw4tR2QRzvPc0QyTiv8p1zruqOHluJDZ5UjM9c/hCCfHbxtbdT
   o9LJn21XTfWtFzhB42xBhmLKUgWuzMtoLBLFTDtm+hKDGaOa9fg51LUu9
   H/sP+3lewlas6tHYNhCgGZ1Q6fB5GzHoZiq5iCdYIE2cYel3RSmrhUjNa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="361143556"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="361143556"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 21:09:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="741875204"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="741875204"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Feb 2023 21:09:18 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVmo9-0002wD-38;
        Sat, 25 Feb 2023 05:09:17 +0000
Date:   Sat, 25 Feb 2023 13:08:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: arch/arm/mm/copypage-fa.c:38:6: warning: no previous prototype for
 function 'fa_copy_user_highpage'
Message-ID: <202302251326.LmxaMXY3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   595fa4e313fee3c0b69c10bbed6fffb803237306
commit: 5eb6e280432ddc9b755193552f3a070da8d7455c ARM: 9289/1: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer
date:   4 weeks ago
config: arm-buildonly-randconfig-r004-20230225 (https://download.01.org/0day-ci/archive/20230225/202302251326.LmxaMXY3-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5eb6e280432ddc9b755193552f3a070da8d7455c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5eb6e280432ddc9b755193552f3a070da8d7455c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302251326.LmxaMXY3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/mm/copypage-fa.c:38:6: warning: no previous prototype for function 'fa_copy_user_highpage' [-Wmissing-prototypes]
   void fa_copy_user_highpage(struct page *to, struct page *from,
        ^
   arch/arm/mm/copypage-fa.c:38:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void fa_copy_user_highpage(struct page *to, struct page *from,
   ^
   static 
>> arch/arm/mm/copypage-fa.c:55:6: warning: no previous prototype for function 'fa_clear_user_highpage' [-Wmissing-prototypes]
   void fa_clear_user_highpage(struct page *page, unsigned long vaddr)
        ^
   arch/arm/mm/copypage-fa.c:55:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void fa_clear_user_highpage(struct page *page, unsigned long vaddr)
   ^
   static 
   2 warnings generated.


vim +/fa_copy_user_highpage +38 arch/arm/mm/copypage-fa.c

28853ac8fe5221 Paulius Zaleckas 2009-03-25  37  
28853ac8fe5221 Paulius Zaleckas 2009-03-25 @38  void fa_copy_user_highpage(struct page *to, struct page *from,
a3be6327163c22 Hans Ulli Kroll  2010-04-27  39  	unsigned long vaddr, struct vm_area_struct *vma)
28853ac8fe5221 Paulius Zaleckas 2009-03-25  40  {
28853ac8fe5221 Paulius Zaleckas 2009-03-25  41  	void *kto, *kfrom;
28853ac8fe5221 Paulius Zaleckas 2009-03-25  42  
5472e862de2bc4 Cong Wang        2011-11-25  43  	kto = kmap_atomic(to);
5472e862de2bc4 Cong Wang        2011-11-25  44  	kfrom = kmap_atomic(from);
28853ac8fe5221 Paulius Zaleckas 2009-03-25  45  	fa_copy_user_page(kto, kfrom);
5472e862de2bc4 Cong Wang        2011-11-25  46  	kunmap_atomic(kfrom);
5472e862de2bc4 Cong Wang        2011-11-25  47  	kunmap_atomic(kto);
28853ac8fe5221 Paulius Zaleckas 2009-03-25  48  }
28853ac8fe5221 Paulius Zaleckas 2009-03-25  49  
28853ac8fe5221 Paulius Zaleckas 2009-03-25  50  /*
28853ac8fe5221 Paulius Zaleckas 2009-03-25  51   * Faraday optimised clear_user_page
28853ac8fe5221 Paulius Zaleckas 2009-03-25  52   *
28853ac8fe5221 Paulius Zaleckas 2009-03-25  53   * Same story as above.
28853ac8fe5221 Paulius Zaleckas 2009-03-25  54   */
28853ac8fe5221 Paulius Zaleckas 2009-03-25 @55  void fa_clear_user_highpage(struct page *page, unsigned long vaddr)
28853ac8fe5221 Paulius Zaleckas 2009-03-25  56  {
5472e862de2bc4 Cong Wang        2011-11-25  57  	void *ptr, *kaddr = kmap_atomic(page);
28853ac8fe5221 Paulius Zaleckas 2009-03-25  58  	asm volatile("\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  59  	mov	r1, %2				@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  60  	mov	r2, #0				@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  61  	mov	r3, #0				@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  62  	mov	ip, #0				@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  63  	mov	lr, #0				@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  64  1:	stmia	%0, {r2, r3, ip, lr}		@ 4\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  65  	mcr	p15, 0, %0, c7, c14, 1		@ 1   clean and invalidate D line\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  66  	add	%0, %0, #16			@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  67  	stmia	%0, {r2, r3, ip, lr}		@ 4\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  68  	mcr	p15, 0, %0, c7, c14, 1		@ 1   clean and invalidate D line\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  69  	add	%0, %0, #16			@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  70  	subs	r1, r1, #1			@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  71  	bne	1b				@ 1\n\
28853ac8fe5221 Paulius Zaleckas 2009-03-25  72  	mcr	p15, 0, r1, c7, c10, 4		@ 1   drain WB"
28853ac8fe5221 Paulius Zaleckas 2009-03-25  73  	: "=r" (ptr)
28853ac8fe5221 Paulius Zaleckas 2009-03-25  74  	: "0" (kaddr), "I" (PAGE_SIZE / 32)
28853ac8fe5221 Paulius Zaleckas 2009-03-25  75  	: "r1", "r2", "r3", "ip", "lr");
5472e862de2bc4 Cong Wang        2011-11-25  76  	kunmap_atomic(kaddr);
28853ac8fe5221 Paulius Zaleckas 2009-03-25  77  }
28853ac8fe5221 Paulius Zaleckas 2009-03-25  78  

:::::: The code at line 38 was first introduced by commit
:::::: 28853ac8fe5221de74a14f1182d7b2b383dfd85c ARM: Add support for FA526 v2

:::::: TO: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
:::::: CC: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
