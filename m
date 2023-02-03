Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4100F6897C3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjBCLcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBCLcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:32:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB948AE;
        Fri,  3 Feb 2023 03:32:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85CCD61EEC;
        Fri,  3 Feb 2023 11:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161EDC433EF;
        Fri,  3 Feb 2023 11:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675423921;
        bh=EMT4gAM6DFLAx01b5MmVLLZlp58/tPr8Emh4r7uLVYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dMdHRcJF0hM4pWxTxwwRi/eNiQXUxWBkgsUhUIZkbdeVM6RlvKD1XanvN2qCMldP0
         WpG/weQPZik2iwR1ER4nF/qxq5Om2uVH1wxDBGJ1DfAPTrQ6O7lcUzUPLl3mTsWo8G
         fpuXxJhL6L5yCeg1Qf76ED2fit5W1fb+yN0lZ0cCC9ODEphO0B6Tt9Aw64NOtqi+Ov
         gORw+HTwcqx4wdctW26BiNxLuZdOPODLg114LRgU3Ozmj80q9ZR6sGmc/OwajvvjiA
         9s9aRKr6a2w5tAL3IDcEc+yAn/OYIj2aZhNDQQ+oLAPMnO2cFBkDp5aOFB/n5bAb5G
         dHswfjIH8AVzw==
Date:   Fri, 3 Feb 2023 11:31:54 +0000
From:   Will Deacon <will@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V8 5/6] arm64/perf: Add branch stack support in ARMV8 PMU
Message-ID: <20230203113153.GA5927@willie-the-truck>
References: <20230123125956.1350336-6-anshuman.khandual@arm.com>
 <202301310047.b5iv9hM8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301310047.b5iv9hM8-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 12:28:17AM +0800, kernel test robot wrote:
> Hi Anshuman,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on arm64/for-next/core]
> [also build test WARNING on tip/perf/core acme/perf/core linus/master v6.2-rc6 next-20230130]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/drivers-perf-arm_pmu-Add-new-sched_task-callback/20230123-210254
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/20230123125956.1350336-6-anshuman.khandual%40arm.com
> patch subject: [PATCH V8 5/6] arm64/perf: Add branch stack support in ARMV8 PMU
> config: arm64-randconfig-r016-20230130 (https://download.01.org/0day-ci/archive/20230131/202301310047.b5iv9hM8-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/0deba04ac45f8632b8579cb5cbf908b9f4428402
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Anshuman-Khandual/drivers-perf-arm_pmu-Add-new-sched_task-callback/20230123-210254
>         git checkout 0deba04ac45f8632b8579cb5cbf908b9f4428402
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 prepare
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/arm64/kernel/asm-offsets.c:15:
>    In file included from include/linux/kvm_host.h:45:
>    In file included from arch/arm64/include/asm/kvm_host.h:36:
>    In file included from include/kvm/arm_pmu.h:11:
> >> arch/arm64/include/asm/perf_event.h:280:20: warning: function 'has_branch_stack' has internal linkage but is not defined [-Wundefined-internal]
>    static inline bool has_branch_stack(struct perf_event *event);
>                       ^
>    arch/arm64/include/asm/perf_event.h:284:16: note: used here
>            WARN_ON_ONCE(!has_branch_stack(event));
>                          ^
>    1 warning generated.
> --
>    In file included from arch/arm64/kernel/asm-offsets.c:15:
>    In file included from include/linux/kvm_host.h:45:
>    In file included from arch/arm64/include/asm/kvm_host.h:36:
>    In file included from include/kvm/arm_pmu.h:11:
> >> arch/arm64/include/asm/perf_event.h:280:20: warning: function 'has_branch_stack' has internal linkage but is not defined [-Wundefined-internal]
>    static inline bool has_branch_stack(struct perf_event *event);
>                       ^
>    arch/arm64/include/asm/perf_event.h:284:16: note: used here
>            WARN_ON_ONCE(!has_branch_stack(event));
>                          ^
>    1 warning generated.

This looks like it should be fixed. I'd also like to see Mark's ack on the
final series, since he had some detailed comments on the previous version.

Will
