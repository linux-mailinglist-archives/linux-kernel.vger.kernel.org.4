Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286B368AE09
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 03:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjBECTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 21:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBECTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 21:19:08 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13192241EC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 18:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675563547; x=1707099547;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=S/4d3WwYUB5JCIhlaemGLJEJVA0fyz3n4JB2cUlzqsI=;
  b=lEh0BLgVAtWQAProQk8Su9Db/WCJH+9mxs1Vy9f3VvBANRuduS9XCfPQ
   hbI41RZ+G2Fz1rhBV6ehiJYmGo4giL6ryhq6dnIDSJZXHPN0i3Vq9PhuW
   CayD1M9p67aZHlrDxJMRfHA769DzG8jgsZEbQvEkw152uqmt0NGMdoaMK
   qg8J5ByfGxFwvxMOYF1gSwEbZ7SpJ4Cg7VwxHwq6O0urexBqIlZcZBuks
   4Z3Mq3QQ36rrFNRgY8/gdVrKrE5i3XPGkrmtnkpWpkoVQ2hE5zvI1AfAP
   6edxBCsAPtu9Uqa/8j7QasiwD1OW3lujFeZLbcVA9c1Q7nUYcunlpsKMc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="317015630"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="317015630"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 18:19:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="754888440"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="754888440"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Feb 2023 18:19:05 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOUcS-0001fa-1u;
        Sun, 05 Feb 2023 02:19:04 +0000
Date:   Sun, 05 Feb 2023 10:18:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.02.03a] BUILD REGRESSION
 c722c164d799860f1a31c82e001221df13dccede
Message-ID: <63df11f7.YArGrbpGISJDiQF3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.02.03a
branch HEAD: c722c164d799860f1a31c82e001221df13dccede  locktorture: With nested locks, occasionally skip main lock

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302021723.ucm8d559-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202302021724.SF7KLCrw-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/loongarch/kernel/process.c:67:1: warning: 'noreturn' function does return
arch/powerpc/kernel/smp.c:1768:1: warning: function declared 'noreturn' should not return [-Winvalid-noreturn]
net/netfilter/ipvs/ip_vs_est.c:552:15: error: too few arguments provided to function-like macro invocation
net/netfilter/ipvs/ip_vs_est.c:552:17: error: 'kfree_rcu' undeclared (first use in this function); did you mean 'kfree_skb'?
net/netfilter/ipvs/ip_vs_est.c:552:29: error: macro "kfree_rcu" requires 2 arguments, but only 1 given
net/netfilter/ipvs/ip_vs_est.c:552:3: error: use of undeclared identifier 'kfree_rcu'; did you mean 'kfree_skb'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- loongarch-buildonly-randconfig-r002-20230204
|   `-- arch-loongarch-kernel-process.c:warning:noreturn-function-does-return
|-- m68k-randconfig-r002-20230205
|   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
|   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
`-- sparc-allyesconfig
    |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
    `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
clang_recent_errors
|-- powerpc-randconfig-r003-20230204
|   `-- arch-powerpc-kernel-smp.c:warning:function-declared-noreturn-should-not-return
|-- powerpc-randconfig-r033-20230204
|   `-- arch-powerpc-kernel-smp.c:warning:function-declared-noreturn-should-not-return
`-- s390-randconfig-r044-20230205
    |-- net-netfilter-ipvs-ip_vs_est.c:error:too-few-arguments-provided-to-function-like-macro-invocation
    `-- net-netfilter-ipvs-ip_vs_est.c:error:use-of-undeclared-identifier-kfree_rcu

elapsed time: 1560m

configs tested: 66
configs skipped: 2

gcc tested configs:
x86_64                            allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
um                             i386_defconfig
s390                                defconfig
um                           x86_64_defconfig
s390                             allyesconfig
powerpc                           allnoconfig
ia64                             allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allmodconfig
alpha                            allyesconfig
m68k                             allyesconfig
arc                              allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
arc                  randconfig-r043-20230204
s390                 randconfig-r044-20230204
riscv                randconfig-r042-20230204
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                        randconfig-a013
i386                          randconfig-a001
x86_64                        randconfig-a011
i386                          randconfig-a003
x86_64                        randconfig-a015
i386                          randconfig-a005
i386                                defconfig
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20230205
arm                  randconfig-r046-20230205
arm                                 defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r041-20230204
arm                  randconfig-r046-20230204
hexagon              randconfig-r045-20230204
x86_64                          rhel-8.3-rust
x86_64                        randconfig-a014
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a016
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20230205
hexagon              randconfig-r041-20230205
riscv                randconfig-r042-20230205
s390                 randconfig-r044-20230205

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
