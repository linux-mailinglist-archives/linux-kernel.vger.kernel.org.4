Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34B97044DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 07:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjEPFuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 01:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEPFuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 01:50:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1B03C33
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 22:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684216198; x=1715752198;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4D/Rsg3HiBDcEacWw3ICgWm108OoAb9aeIMOa50d+7o=;
  b=PdM8qzn2OO27rdADqvXt/7Q5b5ml9a++ND2MIX4sauklqrI/J6UPfGr8
   D+wh2gEzaElBRO8BFOAp6HeYVUl2HvahED1zO6X/ZNWvQwnNBGLm96kDK
   67gT5pB+069uyS5Vh5eEF7FrdWyCEErTFXvwFLGWJBcIrwbSwCGhv+4B5
   5Esu3U+c3VdCtpGUfnrxxGtt8Z3R+sqTNrAaKNUhnlkfCf7+Xseri8O1i
   /gcneDMTAdyDYaF6d4U+B8643rS7OuQuiVK5SrsLi3wAWMeGzz9tbpVVH
   71erW/6pv1XkEBYQxl/C4FeWz2ovRtEboxriIWvZsfNxl/LsgtuBmIIm4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="351422553"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="351422553"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 22:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="770902105"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="770902105"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 15 May 2023 22:49:56 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pynZL-00072M-2d;
        Tue, 16 May 2023 05:49:55 +0000
Date:   Tue, 16 May 2023 13:49:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: arch/powerpc/kexec/relocate_32.o: warning: objtool: .text+0x2bc:
 unannotated intra-function call
Message-ID: <202305161316.4TNTsLUj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sathvika,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
commit: c984aef8c8326035570ff6e01d0ff9e79a5dfa76 objtool/powerpc: Add --mcount specific implementation
date:   6 months ago
config: powerpc-randconfig-r006-20230516 (https://download.01.org/0day-ci/archive/20230516/202305161316.4TNTsLUj-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c984aef8c8326035570ff6e01d0ff9e79a5dfa76
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c984aef8c8326035570ff6e01d0ff9e79a5dfa76
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305161316.4TNTsLUj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/powerpc/kexec/relocate_32.o: warning: objtool: .text+0x2bc: unannotated intra-function call

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
