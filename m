Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BE3734B6C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 07:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjFSFpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 01:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjFSFpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 01:45:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA480194;
        Sun, 18 Jun 2023 22:45:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03D822F4;
        Sun, 18 Jun 2023 22:46:00 -0700 (PDT)
Received: from [10.162.40.17] (a077893.blr.arm.com [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBF263F663;
        Sun, 18 Jun 2023 22:45:10 -0700 (PDT)
Message-ID: <f624966d-5973-0aed-bd73-29ef0530e5ce@arm.com>
Date:   Mon, 19 Jun 2023 11:15:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V12 05/10] arm64/perf: Add branch stack support in ARMV8
 PMU
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
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
References: <20230615133239.442736-6-anshuman.khandual@arm.com>
 <202306160706.Uei5XDoi-lkp@intel.com>
 <883f2a20-fe20-4d43-86cf-7847d59e2169@arm.com> <ZIwpma4SAJ/ZUyh5@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZIwpma4SAJ/ZUyh5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/23 14:51, Catalin Marinas wrote:
> On Fri, Jun 16, 2023 at 06:57:52AM +0530, Anshuman Khandual wrote:
>> On 6/16/23 05:12, kernel test robot wrote:
>>> kernel test robot noticed the following build errors:
>>>
>>> [auto build test ERROR on arm64/for-next/core]
>>> [also build test ERROR on tip/perf/core acme/perf/core linus/master v6.4-rc6 next-20230615]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/drivers-perf-arm_pmu-Add-new-sched_task-callback/20230615-223352
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
>>> patch link:    https://lore.kernel.org/r/20230615133239.442736-6-anshuman.khandual%40arm.com
>>> patch subject: [PATCH V12 05/10] arm64/perf: Add branch stack support in ARMV8 PMU
>>> config: arm-randconfig-r004-20230615 (https://download.01.org/0day-ci/archive/20230616/202306160706.Uei5XDoi-lkp@intel.com/config)
>>> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
>>> reproduce (this is a W=1 build):
>>>         mkdir -p ~/bin
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # install arm cross compiling tool for clang build
>>>         # apt-get install binutils-arm-linux-gnueabi
>>>         git remote add arm64 https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
>>>         git fetch arm64 for-next/core
>>>         git checkout arm64/for-next/core
>>>         b4 shazam https://lore.kernel.org/r/20230615133239.442736-6-anshuman.khandual@arm.com
>>>         # save the config file
>>>         mkdir build_dir && cp config build_dir/.config
>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/perf/
>>
>> I am unable to reproduce this on mainline 6.4-rc6 via default cross compiler
>> on a W=1 build. Looking at all other problems reported on the file, it seems
>> something is not right here. Reported build problems around these callbacks,
>> i.e armv8pmu_branch_XXXX() do not make sense as they are available via config
>> CONFIG_PERF_EVENTS which is also enabled along with CONFIG_ARM_PMUV3 in this
>> test config.
> 
> Have you tried applying this series on top of the arm64 for-next/core
> branch? That's what the robot it testing (in the absence of a --base
> option when generating the patches).

Right, it turned out to be a build problem on arm (32 bit) platform instead.
After arm_pmuv3.c moved into common ./drivers/perf from ./arch/arm64/kernel/,
it can no longer access arch/arm64/include/asm/perf_event.h defined functions
without breaking arm (32) bit. The following code block needs to be moved out
from arch/arm64/include/asm/perf_event.h into include/linux/perf/arm_pmuv3.h
(which is preferred as all call sites are inside drivers/perf/arm_pmuv3.c) or
may be arm_pmu.h (which is one step higher in the abstraction).

struct pmu_hw_events;
struct arm_pmu;
struct perf_event;

#ifdef CONFIG_PERF_EVENTS
static inline bool has_branch_stack(struct perf_event *event);

#ifdef CONFIG_ARM64_BRBE
void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event);
bool armv8pmu_branch_attr_valid(struct perf_event *event);
void armv8pmu_branch_enable(struct perf_event *event);
void armv8pmu_branch_disable(struct perf_event *event);
void armv8pmu_branch_probe(struct arm_pmu *arm_pmu);
void armv8pmu_branch_reset(void);
int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu);
void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu);
void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx);
#else
static inline void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
{
        WARN_ON_ONCE(!has_branch_stack(event));
}

static inline bool armv8pmu_branch_attr_valid(struct perf_event *event)
{
        WARN_ON_ONCE(!has_branch_stack(event));
        return false;
}

static inline void armv8pmu_branch_enable(struct perf_event *event)
{
        WARN_ON_ONCE(!has_branch_stack(event));
}

static inline void armv8pmu_branch_disable(struct perf_event *event)
{
        WARN_ON_ONCE(!has_branch_stack(event));
}

static inline void armv8pmu_branch_probe(struct arm_pmu *arm_pmu) { }
static inline void armv8pmu_branch_reset(void) { }
static inline int armv8pmu_task_ctx_cache_alloc(struct arm_pmu *arm_pmu) { return 0; }
static inline void armv8pmu_task_ctx_cache_free(struct arm_pmu *arm_pmu) { }
static inline void armv8pmu_branch_save(struct arm_pmu *arm_pmu, void *ctx) { }
#endif
#endif
