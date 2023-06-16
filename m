Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8340732B45
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244923AbjFPJVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjFPJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:21:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B130EA;
        Fri, 16 Jun 2023 02:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AABF361B86;
        Fri, 16 Jun 2023 09:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238A6C433C0;
        Fri, 16 Jun 2023 09:21:31 +0000 (UTC)
Date:   Fri, 16 Jun 2023 10:21:29 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V12 05/10] arm64/perf: Add branch stack support in ARMV8
 PMU
Message-ID: <ZIwpma4SAJ/ZUyh5@arm.com>
References: <20230615133239.442736-6-anshuman.khandual@arm.com>
 <202306160706.Uei5XDoi-lkp@intel.com>
 <883f2a20-fe20-4d43-86cf-7847d59e2169@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883f2a20-fe20-4d43-86cf-7847d59e2169@arm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 06:57:52AM +0530, Anshuman Khandual wrote:
> On 6/16/23 05:12, kernel test robot wrote:
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on arm64/for-next/core]
> > [also build test ERROR on tip/perf/core acme/perf/core linus/master v6.4-rc6 next-20230615]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/drivers-perf-arm_pmu-Add-new-sched_task-callback/20230615-223352
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> > patch link:    https://lore.kernel.org/r/20230615133239.442736-6-anshuman.khandual%40arm.com
> > patch subject: [PATCH V12 05/10] arm64/perf: Add branch stack support in ARMV8 PMU
> > config: arm-randconfig-r004-20230615 (https://download.01.org/0day-ci/archive/20230616/202306160706.Uei5XDoi-lkp@intel.com/config)
> > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > reproduce (this is a W=1 build):
> >         mkdir -p ~/bin
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm cross compiling tool for clang build
> >         # apt-get install binutils-arm-linux-gnueabi
> >         git remote add arm64 https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> >         git fetch arm64 for-next/core
> >         git checkout arm64/for-next/core
> >         b4 shazam https://lore.kernel.org/r/20230615133239.442736-6-anshuman.khandual@arm.com
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/perf/
> 
> I am unable to reproduce this on mainline 6.4-rc6 via default cross compiler
> on a W=1 build. Looking at all other problems reported on the file, it seems
> something is not right here. Reported build problems around these callbacks,
> i.e armv8pmu_branch_XXXX() do not make sense as they are available via config
> CONFIG_PERF_EVENTS which is also enabled along with CONFIG_ARM_PMUV3 in this
> test config.

Have you tried applying this series on top of the arm64 for-next/core
branch? That's what the robot it testing (in the absence of a --base
option when generating the patches).

-- 
Catalin
