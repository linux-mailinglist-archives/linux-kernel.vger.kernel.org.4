Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2246B5C91
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCKOEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCKOD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:03:57 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D2BE4843
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678543435; x=1710079435;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Pi1L+DfKJ4QRQ20FUJYxIR/4mc0GqTkvUVZRwOjHz9Q=;
  b=UlEAL9vQhJXIN/vaX7pAccfv4fYzU8Yj4J2vPAdJOHTGty4VqXsh1nyy
   3pgYCA7UgXPp1VOYnFd9B09yDJZgXvceS8UbNvh5dyrpOI4TSqCvIa6B3
   w4nYd49ccKI/+rae7h+i1oKrhfnn2/qTwF7E2ELjeSugoJZyHIuO9CK5Y
   vvJd0E05yrpnYEQldbvF3pB26OkKPYDh2k5RsTxVpESQMaYwV9GMI2nNg
   rPtGMHUsGnfkV9dkzMd14nQX3LungzTW9mOzNmuDanUCbJK/Gw1kc1/pf
   jjY91lUNwrwqTLBZ0nes3dxrISdnCKdHXQFfZLq2AdQ7HvMa26Q1M9K3k
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="325262186"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="325262186"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 06:03:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="821408597"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="821408597"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2023 06:03:53 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pazpA-0004cS-2X;
        Sat, 11 Mar 2023 14:03:52 +0000
Date:   Sat, 11 Mar 2023 22:03:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!
Message-ID: <202303112110.YfYi4GtV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ef5f68cc1f829b492b19cd4df5af4454aa816b93
commit: 5750121ae7382ebac8d47ce6d68012d6cd1d7926 kbuild: list sub-directories in ./Kbuild
date:   5 months ago
config: nios2-randconfig-r011-20230310 (https://download.01.org/0day-ci/archive/20230311/202303112110.YfYi4GtV-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5750121ae7382ebac8d47ce6d68012d6cd1d7926
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5750121ae7382ebac8d47ce6d68012d6cd1d7926
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303112110.YfYi4GtV-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__mulsi3" [kernel/rcu/rcuscale.ko] undefined!
ERROR: modpost: "__mulsi3" [kernel/time/time_test.ko] undefined!
ERROR: modpost: "__mulsi3" [fs/nls/nls_euc-jp.ko] undefined!
ERROR: modpost: "__mulsi3" [fs/fuse/virtiofs.ko] undefined!
ERROR: modpost: "__mulsi3" [fs/autofs/autofs4.ko] undefined!
ERROR: modpost: "__mulsi3" [security/keys/encrypted-keys/encrypted-keys.ko] undefined!
ERROR: modpost: "__mulsi3" [lib/lzo/lzo_compress.ko] undefined!
ERROR: modpost: "__mulsi3" [lib/lz4/lz4_compress.ko] undefined!
>> ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!
ERROR: modpost: "__mulsi3" [lib/lz4/lz4hc_compress.ko] undefined!
WARNING: modpost: suppressed 208 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
