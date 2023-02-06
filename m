Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B8468B4CF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 05:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjBFEQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 23:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBFEQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 23:16:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD2A79027;
        Sun,  5 Feb 2023 20:16:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67FE2113E;
        Sun,  5 Feb 2023 20:17:16 -0800 (PST)
Received: from [10.162.40.17] (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A4DA3F71E;
        Sun,  5 Feb 2023 20:16:28 -0800 (PST)
Message-ID: <143549b7-6f16-209f-b1be-c8202fd55d05@arm.com>
Date:   Mon, 6 Feb 2023 09:46:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V8 5/6] arm64/perf: Add branch stack support in ARMV8 PMU
Content-Language: en-US
To:     Will Deacon <will@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
References: <20230123125956.1350336-6-anshuman.khandual@arm.com>
 <202301310047.b5iv9hM8-lkp@intel.com>
 <20230203113153.GA5927@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230203113153.GA5927@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/23 17:01, Will Deacon wrote:
> On Tue, Jan 31, 2023 at 12:28:17AM +0800, kernel test robot wrote:
>> Hi Anshuman,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on arm64/for-next/core]
>> [also build test WARNING on tip/perf/core acme/perf/core linus/master v6.2-rc6 next-20230130]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/drivers-perf-arm_pmu-Add-new-sched_task-callback/20230123-210254
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
>> patch link:    https://lore.kernel.org/r/20230123125956.1350336-6-anshuman.khandual%40arm.com
>> patch subject: [PATCH V8 5/6] arm64/perf: Add branch stack support in ARMV8 PMU
>> config: arm64-randconfig-r016-20230130 (https://download.01.org/0day-ci/archive/20230131/202301310047.b5iv9hM8-lkp@intel.com/config)
>> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # install arm64 cross compiling tool for clang build
>>         # apt-get install binutils-aarch64-linux-gnu
>>         # https://github.com/intel-lab-lkp/linux/commit/0deba04ac45f8632b8579cb5cbf908b9f4428402
>>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>>         git fetch --no-tags linux-review Anshuman-Khandual/drivers-perf-arm_pmu-Add-new-sched_task-callback/20230123-210254
>>         git checkout 0deba04ac45f8632b8579cb5cbf908b9f4428402
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 prepare
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>    In file included from arch/arm64/kernel/asm-offsets.c:15:
>>    In file included from include/linux/kvm_host.h:45:
>>    In file included from arch/arm64/include/asm/kvm_host.h:36:
>>    In file included from include/kvm/arm_pmu.h:11:
>>>> arch/arm64/include/asm/perf_event.h:280:20: warning: function 'has_branch_stack' has internal linkage but is not defined [-Wundefined-internal]
>>    static inline bool has_branch_stack(struct perf_event *event);
>>                       ^
>>    arch/arm64/include/asm/perf_event.h:284:16: note: used here
>>            WARN_ON_ONCE(!has_branch_stack(event));
>>                          ^
>>    1 warning generated.
>> --
>>    In file included from arch/arm64/kernel/asm-offsets.c:15:
>>    In file included from include/linux/kvm_host.h:45:
>>    In file included from arch/arm64/include/asm/kvm_host.h:36:
>>    In file included from include/kvm/arm_pmu.h:11:
>>>> arch/arm64/include/asm/perf_event.h:280:20: warning: function 'has_branch_stack' has internal linkage but is not defined [-Wundefined-internal]
>>    static inline bool has_branch_stack(struct perf_event *event);
>>                       ^
>>    arch/arm64/include/asm/perf_event.h:284:16: note: used here
>>            WARN_ON_ONCE(!has_branch_stack(event));
>>                          ^
>>    1 warning generated.
> 
> This looks like it should be fixed. I'd also like to see Mark's ack on the

This build warning is triggered when CONFIG_PERF_EVENTS is not enabled, when
all the fallback stubs in there try to use has_branch_stack() which does not
get defined. The following change, fixes the problem.

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 97db96326e13..1f68c125eb1a 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -277,8 +277,6 @@ struct pmu_hw_events;
 struct arm_pmu;
 struct perf_event;
 
-static inline bool has_branch_stack(struct perf_event *event);
-
 #ifdef CONFIG_ARM64_BRBE
 void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event);
 bool armv8pmu_branch_valid(struct perf_event *event);
@@ -289,6 +287,9 @@ void armv8pmu_branch_reset(void);
 int armv8pmu_private_alloc(struct arm_pmu *arm_pmu);
 void armv8pmu_private_free(struct arm_pmu *arm_pmu);
 #else
+#ifdef CONFIG_PERF_EVENTS
+static inline bool has_branch_stack(struct perf_event *event);
+
 static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
 {
        WARN_ON_ONCE(!has_branch_stack(event));
@@ -316,3 +317,4 @@ static inline int armv8pmu_private_alloc(struct arm_pmu *arm_pmu) { return 0; }
 static inline void armv8pmu_private_free(struct arm_pmu *arm_pmu) { }
 #endif
 #endif
+#endif

> final series, since he had some detailed comments on the previous version.
> 
> Will
