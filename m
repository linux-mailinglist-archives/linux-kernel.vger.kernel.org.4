Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFE568DA4B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjBGOQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjBGOP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:15:59 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E9036093
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675779357; x=1707315357;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FjqABgRehrlJAf7ToNpBvIbsFQwsPHPhaP6xKYoLmAU=;
  b=N0Usygi1SCRtgPUpjTa3C5zDysrrGl71uNcVE2JEssz7NXSX2j+TUEMq
   +B5QghRf1lP58NsNRE7FN2pS11wKrGXuhdyMMeb9yGE4IrSlbOf8bWE1B
   zdF1soMg2dQ2d5sNDUPm7WxSb7CWsHUhqGcQ2MSJ6tRN5gRILgX47urgm
   6j63ptIPOQh8eD4G+Qrvxdp9SXPFIdMMpiMidRdXL182qICuPvU4T7GbO
   Z3wWwitXyzwqnYf7IbOuep/KW86Uh9rlWVI9xqI9Nz39OV3ZQ8a5+TXFu
   EyeoqiQAFVoBMH/DJZ50CsyVBIV8Tyejpumc+8ss/TMfabFw2obyXKCS0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="356884483"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="356884483"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 06:15:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="730446748"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="730446748"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Feb 2023 06:15:04 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPOkS-0003bK-0M;
        Tue, 07 Feb 2023 14:15:04 +0000
Date:   Tue, 07 Feb 2023 22:14:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.02.06a] BUILD REGRESSION
 2ba8863ce28484e97f0ff1987c634147fedb14fc
Message-ID: <63e25cce.q8y0JN9RDnU2PZc8%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.02.06a
branch HEAD: 2ba8863ce28484e97f0ff1987c634147fedb14fc  objtool: Fix for unreachable instruction warning

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202302021723.ucm8d559-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

net/netfilter/ipvs/ip_vs_est.c:552:17: error: 'kfree_rcu' undeclared (first use in this function); did you mean 'kfree_skb'?
net/netfilter/ipvs/ip_vs_est.c:552:29: error: macro "kfree_rcu" requires 2 arguments, but only 1 given

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- sparc-allyesconfig
    |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
    `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given

elapsed time: 868m

configs tested: 55
configs skipped: 3

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                            allnoconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
sh                               allmodconfig
arm                                 defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
powerpc                          allmodconfig
x86_64                           rhel-8.3-kvm
mips                             allyesconfig
x86_64                           rhel-8.3-bpf
x86_64                              defconfig
arm                              allyesconfig
arm64                            allyesconfig
x86_64                               rhel-8.3
arc                  randconfig-r043-20230205
arm                  randconfig-r046-20230205
i386                 randconfig-a011-20230206
i386                 randconfig-a014-20230206
i386                 randconfig-a012-20230206
i386                 randconfig-a013-20230206
i386                 randconfig-a015-20230206
i386                 randconfig-a016-20230206
i386                                defconfig
x86_64                           allyesconfig
ia64                             allmodconfig
i386                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a002-20230206
x86_64               randconfig-a003-20230206
x86_64               randconfig-a001-20230206
x86_64               randconfig-a004-20230206
x86_64               randconfig-a005-20230206
x86_64               randconfig-a006-20230206
hexagon              randconfig-r045-20230205
hexagon              randconfig-r041-20230205
i386                 randconfig-a004-20230206
i386                 randconfig-a001-20230206
i386                 randconfig-a005-20230206
riscv                randconfig-r042-20230205
i386                 randconfig-a002-20230206
i386                 randconfig-a003-20230206
s390                 randconfig-r044-20230205
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
