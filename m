Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D785BE421
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiITLJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiITLJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:09:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D6FBF4E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663672178; x=1695208178;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nqeGfwzE3RvraBj8s5VXbFNjcB2Hwa1a72V7QrPqjnw=;
  b=nS8VQDT8Voib0dEC75Eirw9qlozIdrd8OpJ7HAxbReZPGj3dNhfODCcW
   XWqb4ieEvc31+qB7QTFD3xQ6m0WPhn6ROvdVVFiTd2xbN3S6xmOqXijN0
   Vb+tkHGtwhFBmOb04Sa/TqLU8+ahY9QlZMOKI3uNG2C/Lbp6qB9f7MoN+
   w7uFD6kxIty95EJP+tiWpw0ANQZYBwgBgzNeTRpEhL0MamU9914j5zVRk
   JKaVJ8gkcS2BxuUiqqpfWKKfIzeee01VOy/8tay2d1WBRKynfhay+524k
   avLinBTyKdsXj4rkxeyFgIu6nglKF9yOloGXsTE97RAjjpGzrtL/t6bHi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363623455"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="363623455"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 04:09:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="652055159"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Sep 2022 04:09:35 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oab8B-0002hz-01;
        Tue, 20 Sep 2022 11:09:35 +0000
Date:   Tue, 20 Sep 2022 19:09:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/arm/boot/compressed/atags_to_fdt.c:129:5: warning: stack frame
 size (1344) exceeds limit (1280) in 'atags_to_fdt'
Message-ID: <202209201858.YLTXHqey-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   521a547ced6477c54b4b0cc206000406c221b4d6
commit: 672513bf583157cc088a32e75bd850dd9f81564c ARM: decompressor: disable stack protector
date:   10 months ago
config: arm-randconfig-r004-20220920 (https://download.01.org/0day-ci/archive/20220920/202209201858.YLTXHqey-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=672513bf583157cc088a32e75bd850dd9f81564c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 672513bf583157cc088a32e75bd850dd9f81564c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm/boot/compressed/atags_to_fdt.c:129:5: warning: no previous prototype for function 'atags_to_fdt' [-Wmissing-prototypes]
   int atags_to_fdt(void *atag_list, void *fdt, int total_space)
       ^
   arch/arm/boot/compressed/atags_to_fdt.c:129:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int atags_to_fdt(void *atag_list, void *fdt, int total_space)
   ^
   static 
>> arch/arm/boot/compressed/atags_to_fdt.c:129:5: warning: stack frame size (1344) exceeds limit (1280) in 'atags_to_fdt' [-Wframe-larger-than]
   int atags_to_fdt(void *atag_list, void *fdt, int total_space)
       ^
   2 warnings generated.


vim +/atags_to_fdt +129 arch/arm/boot/compressed/atags_to_fdt.c

31d0b9f9982f8e Ben Dooks          2018-10-12  120  
b90b9a38251e9c Nicolas Pitre      2011-09-13  121  /*
b90b9a38251e9c Nicolas Pitre      2011-09-13  122   * Convert and fold provided ATAGs into the provided FDT.
b90b9a38251e9c Nicolas Pitre      2011-09-13  123   *
4716e2e34a22a8 Geert Uytterhoeven 2021-05-19  124   * Return values:
b90b9a38251e9c Nicolas Pitre      2011-09-13  125   *    = 0 -> pretend success
b90b9a38251e9c Nicolas Pitre      2011-09-13  126   *    = 1 -> bad ATAG (may retry with another possible ATAG pointer)
b90b9a38251e9c Nicolas Pitre      2011-09-13  127   *    < 0 -> error from libfdt
b90b9a38251e9c Nicolas Pitre      2011-09-13  128   */
b90b9a38251e9c Nicolas Pitre      2011-09-13 @129  int atags_to_fdt(void *atag_list, void *fdt, int total_space)

:::::: The code at line 129 was first introduced by commit
:::::: b90b9a38251e9c89c34179eccde57411ceb5f1aa ARM: zImage: allow supplementing appended DTB with traditional ATAG data

:::::: TO: Nicolas Pitre <nicolas.pitre@linaro.org>
:::::: CC: Nicolas Pitre <nico@fluxnic.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
