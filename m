Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80D268AE12
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 03:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjBECuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 21:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBECuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 21:50:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C475222FD
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 18:50:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2FA06068B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 02:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27269C433D2;
        Sun,  5 Feb 2023 02:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675565400;
        bh=CBh/6MzWxbKpNciJfeyCCUWMvho7uEX+F5qLgdfK2kY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PKZUeMkLrrAva659h7gBunbe/r2uldehMwpM9+BNkDNqTcezjWry20iTt3nRZtnd9
         ohDFA8JDdjdYLSYMtuxhMB+nVvJHS6ETECwU5HmXC7WaMbgI7Ri5fc9eRyUfghG/TH
         vipJojiNaYsK4l9tDRRj+KH3zdOEgHUR2G9xG0PLE4uIZHc7gv1dkiwdzmWAEe1R7n
         B59MHzXpmLtijfETVzUS+stC0ypSHmydNJsVgel4f09kTAMl38Tu6XmWsSACu9G+zs
         5KEJTNlaPxC8oqqXzdAS9HzN/3E6BMmMJEWr8J/vMDd4EAWMbjxmbsi9HuLrBgsArh
         0Eu/jq3G2To5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B239F5C0B8F; Sat,  4 Feb 2023 18:49:59 -0800 (PST)
Date:   Sat, 4 Feb 2023 18:49:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2023.02.03a] BUILD REGRESSION
 c722c164d799860f1a31c82e001221df13dccede
Message-ID: <20230205024959.GG2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <63df11f7.YArGrbpGISJDiQF3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63df11f7.YArGrbpGISJDiQF3%lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 10:18:31AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.02.03a
> branch HEAD: c722c164d799860f1a31c82e001221df13dccede  locktorture: With nested locks, occasionally skip main lock
> 
> Error/Warning reports:
> 
> https://lore.kernel.org/oe-kbuild-all/202302021723.ucm8d559-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202302021724.SF7KLCrw-lkp@intel.com
> 
> Error/Warning: (recently discovered and may have been fixed)
> 
> arch/loongarch/kernel/process.c:67:1: warning: 'noreturn' function does return
> arch/powerpc/kernel/smp.c:1768:1: warning: function declared 'noreturn' should not return [-Winvalid-noreturn]
> net/netfilter/ipvs/ip_vs_est.c:552:15: error: too few arguments provided to function-like macro invocation
> net/netfilter/ipvs/ip_vs_est.c:552:17: error: 'kfree_rcu' undeclared (first use in this function); did you mean 'kfree_skb'?
> net/netfilter/ipvs/ip_vs_est.c:552:29: error: macro "kfree_rcu" requires 2 arguments, but only 1 given
> net/netfilter/ipvs/ip_vs_est.c:552:3: error: use of undeclared identifier 'kfree_rcu'; did you mean 'kfree_skb'?

These are due to a patch that has been handed off to its maintainer,
and should be fixed once that is in place.

As always, thank you for your testing efforts!

							Thanx, Paul

> Error/Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> |-- loongarch-buildonly-randconfig-r002-20230204
> |   `-- arch-loongarch-kernel-process.c:warning:noreturn-function-does-return
> |-- m68k-randconfig-r002-20230205
> |   |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
> |   `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
> `-- sparc-allyesconfig
>     |-- net-netfilter-ipvs-ip_vs_est.c:error:kfree_rcu-undeclared-(first-use-in-this-function)
>     `-- net-netfilter-ipvs-ip_vs_est.c:error:macro-kfree_rcu-requires-arguments-but-only-given
> clang_recent_errors
> |-- powerpc-randconfig-r003-20230204
> |   `-- arch-powerpc-kernel-smp.c:warning:function-declared-noreturn-should-not-return
> |-- powerpc-randconfig-r033-20230204
> |   `-- arch-powerpc-kernel-smp.c:warning:function-declared-noreturn-should-not-return
> `-- s390-randconfig-r044-20230205
>     |-- net-netfilter-ipvs-ip_vs_est.c:error:too-few-arguments-provided-to-function-like-macro-invocation
>     `-- net-netfilter-ipvs-ip_vs_est.c:error:use-of-undeclared-identifier-kfree_rcu
> 
> elapsed time: 1560m
> 
> configs tested: 66
> configs skipped: 2
> 
> gcc tested configs:
> x86_64                            allnoconfig
> arc                                 defconfig
> s390                             allmodconfig
> alpha                               defconfig
> um                             i386_defconfig
> s390                                defconfig
> um                           x86_64_defconfig
> s390                             allyesconfig
> powerpc                           allnoconfig
> ia64                             allmodconfig
> x86_64                        randconfig-a004
> x86_64                        randconfig-a002
> x86_64                        randconfig-a006
> sh                               allmodconfig
> mips                             allyesconfig
> powerpc                          allmodconfig
> m68k                             allmodconfig
> alpha                            allyesconfig
> m68k                             allyesconfig
> arc                              allyesconfig
> x86_64                           rhel-8.3-syz
> x86_64                         rhel-8.3-kunit
> x86_64                           rhel-8.3-kvm
> x86_64                           rhel-8.3-bpf
> arc                  randconfig-r043-20230204
> s390                 randconfig-r044-20230204
> riscv                randconfig-r042-20230204
> x86_64                              defconfig
> x86_64                               rhel-8.3
> x86_64                           allyesconfig
> x86_64                    rhel-8.3-kselftests
> x86_64                          rhel-8.3-func
> x86_64                        randconfig-a013
> i386                          randconfig-a001
> x86_64                        randconfig-a011
> i386                          randconfig-a003
> x86_64                        randconfig-a015
> i386                          randconfig-a005
> i386                                defconfig
> i386                             allyesconfig
> i386                          randconfig-a014
> i386                          randconfig-a012
> i386                          randconfig-a016
> arc                  randconfig-r043-20230205
> arm                  randconfig-r046-20230205
> arm                                 defconfig
> 
> clang tested configs:
> x86_64                        randconfig-a001
> x86_64                        randconfig-a003
> x86_64                        randconfig-a005
> hexagon              randconfig-r041-20230204
> arm                  randconfig-r046-20230204
> hexagon              randconfig-r045-20230204
> x86_64                          rhel-8.3-rust
> x86_64                        randconfig-a014
> x86_64                        randconfig-a012
> i386                          randconfig-a002
> i386                          randconfig-a004
> x86_64                        randconfig-a016
> i386                          randconfig-a006
> i386                          randconfig-a013
> i386                          randconfig-a011
> i386                          randconfig-a015
> hexagon              randconfig-r045-20230205
> hexagon              randconfig-r041-20230205
> riscv                randconfig-r042-20230205
> s390                 randconfig-r044-20230205
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
