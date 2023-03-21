Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E106C306D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCULan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCULal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:30:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74239421C;
        Tue, 21 Mar 2023 04:30:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CABDDAD7;
        Tue, 21 Mar 2023 04:31:21 -0700 (PDT)
Received: from [10.57.19.235] (unknown [10.57.19.235])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E06683F71E;
        Tue, 21 Mar 2023 04:30:34 -0700 (PDT)
Message-ID: <695e97b5-754b-1364-ec71-2550eeaca6e9@arm.com>
Date:   Tue, 21 Mar 2023 11:30:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 13/17] PM: EM: Refactor struct em_perf_domain and add
 default_table
Content-Language: en-US
To:     rafael@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org, linux-pm@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20230314103357.26010-14-lukasz.luba@arm.com>
 <202303151927.WD6O0PWN-lkp@intel.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <202303151927.WD6O0PWN-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 3/15/23 11:32, kernel test robot wrote:
> Hi Lukasz,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on rafael-pm/linux-next]
> [also build test WARNING on rafael-pm/thermal linus/master pavel-leds/for-next v6.3-rc2 next-20230315]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Lukasz-Luba/PM-EM-Refactor-em_cpufreq_update_efficiencies-arguments/20230314-184448
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> patch link:    https://lore.kernel.org/r/20230314103357.26010-14-lukasz.luba%40arm.com
> patch subject: [PATCH 13/17] PM: EM: Refactor struct em_perf_domain and add default_table
> config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20230315/202303151927.WD6O0PWN-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/ce3aad5db08006a2a6b6d52f9c26b11448cd8bb4
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Lukasz-Luba/PM-EM-Refactor-em_cpufreq_update_efficiencies-arguments/20230314-184448
>          git checkout ce3aad5db08006a2a6b6d52f9c26b11448cd8bb4
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/thermal/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303151927.WD6O0PWN-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/thermal/cpufreq_cooling.c:381:24: warning: unused variable 'table' [-Wunused-variable]
>             struct em_perf_state *table;
>                                   ^
>     1 warning generated.
> 
> 
> vim +/table +381 drivers/thermal/cpufreq_cooling.c
> 
>     376	
>     377	static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>     378					   unsigned long state)
>     379	{
>     380		struct cpufreq_policy *policy;
>   > 381		struct em_perf_state *table;
>     382		unsigned long idx;
>     383	
> 

I'll move that variable into the below section which has the #ifdef,
so it won't complain when there isn't IPA config set.

Thus, the change for this get_state_freq() in v2 would be like:
------------------------------8<----------------------

  #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
         /* Use the Energy Model table if available */
         if (cpufreq_cdev->em) {
+               struct em_perf_state *table;
+               table = cpufreq_cdev->em->default_table->state;
                 idx = cpufreq_cdev->max_level - state;
-               return cpufreq_cdev->em->table[idx].frequency;
+               return table[idx].frequency;
         }
  #endif

------------------->8---------------------------------


BTW, I might refactor this cpufreq_cooling.c file later,
since there is a lot of this #ifdef sections spread around...
But that would be after OSPM in Ancona.

Regards,
Lukasz
