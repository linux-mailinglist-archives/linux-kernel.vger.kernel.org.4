Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4A46E0712
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 08:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDMGkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 02:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMGkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:40:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B550B6EA0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 23:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681368041; x=1712904041;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JPER1IPvFzvIr3r02eSr/qgy8467UVnTjxa1UldoJp8=;
  b=GkciGk/M0BZhTUWIiKYtE8jdt3/Y3LiFyNaAhr8ibcl5bC5if+lQIG0M
   JKwFP71ZOLTAG4+wC49ymzLzVsXETmfgLss3Np01gyYC+wgOp/fhb3Ygt
   XvKY/tQz2+/XXaPwUWnFbdxlF7oVzG0EF9ZQVekdjGoyAMu4m7QpxI8bU
   5wN8ORCYPYNnBC2/BWMf0lXb73KBSheg+xTESPfOroIILJlyhXkxMScXe
   GPps6qdx+Fui9M5dKpVyYVblfk0MNTiiPBSE9EQHhXrvEOpEIKRBnw3On
   ncYmU5OvOMKiyTnO3mdT6kL/gihnLAPRIi66aly4aewczh/nBrVx7ghdp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="328216282"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="328216282"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 23:40:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="778625448"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="778625448"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2023 23:40:38 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmqdK-000YQt-0B;
        Thu, 13 Apr 2023 06:40:38 +0000
Date:   Thu, 13 Apr 2023 14:39:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: undefined reference to `ftrace_likely_update'
Message-ID: <202304131400.BLPkK6sC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de4664485abbc0529b1eec44d0061bbfe58a28fb
commit: 54d9469bc515dc5fcbc20eecbe19cea868b70d68 fortify: Add run-time WARN for cross-field memcpy()
date:   7 months ago
config: s390-buildonly-randconfig-r001-20230413 (https://download.01.org/0day-ci/archive/20230413/202304131400.BLPkK6sC-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 2c57868e2e877f73c339796c3374ae660bb77f0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=54d9469bc515dc5fcbc20eecbe19cea868b70d68
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 54d9469bc515dc5fcbc20eecbe19cea868b70d68
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304131400.BLPkK6sC-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390x-linux-ld: arch/s390/purgatory/purgatory: in function `sha256_update':
>> (.text+0x23f2): undefined reference to `ftrace_likely_update'
>> s390x-linux-ld: (.text+0x2aa8): undefined reference to `ftrace_likely_update'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
