Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28916A2892
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 10:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBYJnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 04:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBYJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 04:43:43 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5D211172
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 01:43:41 -0800 (PST)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PP1sq6lYRzKmMJ;
        Sat, 25 Feb 2023 17:38:39 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Sat, 25 Feb
 2023 17:43:34 +0800
Message-ID: <4c7d3a16-eaa9-4277-8d7e-8db944cf2c40@huawei.com>
Date:   Sat, 25 Feb 2023 17:43:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] x86: profiling: Set prof_cpu_mask to NULL after free
To:     kernel test robot <lkp@intel.com>, <linux-kernel@vger.kernel.org>
CC:     <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <akpm@linux-foundation.org>, <wuchi.zero@gmail.com>,
        <ben-linux@fluff.org>, <rusty@rustcorp.com.au>
References: <20230224084945.134038-1-chenzhongjin@huawei.com>
 <202302250609.vmze90DB-lkp@intel.com>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <202302250609.vmze90DB-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prof_cpu_mask can't be set to NULL when CONFIG_CPUMASK_OFFSTACK=n, 
because it is an array.

But checking prof_buffer still can prevent prof_cpu_mask be used in 
profile_tick() and fix this problem.

Will push another version for this.


On 2023/2/25 6:16, kernel test robot wrote:
> Hi Chen,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.2 next-20230224]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Zhongjin/x86-profiling-Set-prof_cpu_mask-to-NULL-after-free/20230224-165419
> patch link:    https://lore.kernel.org/r/20230224084945.134038-1-chenzhongjin%40huawei.com
> patch subject: [PATCH] x86: profiling: Set prof_cpu_mask to NULL after free
> config: arm-randconfig-r004-20230222 (https://download.01.org/0day-ci/archive/20230225/202302250609.vmze90DB-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install arm cross compiling tool for clang build
>          # apt-get install binutils-arm-linux-gnueabi
>          # https://github.com/intel-lab-lkp/linux/commit/ed9b4879e816862f4f6210b1c429bcbebac6d317
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Chen-Zhongjin/x86-profiling-Set-prof_cpu_mask-to-NULL-after-free/20230224-165419
>          git checkout ed9b4879e816862f4f6210b1c429bcbebac6d317
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202302250609.vmze90DB-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>>> kernel/profile.c:136:16: error: array type 'cpumask_var_t' (aka 'struct cpumask[1]') is not assignable
>             prof_cpu_mask = NULL;
>             ~~~~~~~~~~~~~ ^
>     1 error generated.
>
>
> vim +136 kernel/profile.c
>
>      98	
>      99	
>     100	int __ref profile_init(void)
>     101	{
>     102		int buffer_bytes;
>     103		if (!prof_on)
>     104			return 0;
>     105	
>     106		/* only text is profiled */
>     107		prof_len = (_etext - _stext) >> prof_shift;
>     108	
>     109		if (!prof_len) {
>     110			pr_warn("profiling shift: %u too large\n", prof_shift);
>     111			prof_on = 0;
>     112			return -EINVAL;
>     113		}
>     114	
>     115		buffer_bytes = prof_len*sizeof(atomic_t);
>     116	
>     117		if (!alloc_cpumask_var(&prof_cpu_mask, GFP_KERNEL))
>     118			return -ENOMEM;
>     119	
>     120		cpumask_copy(prof_cpu_mask, cpu_possible_mask);
>     121	
>     122		prof_buffer = kzalloc(buffer_bytes, GFP_KERNEL|__GFP_NOWARN);
>     123		if (prof_buffer)
>     124			return 0;
>     125	
>     126		prof_buffer = alloc_pages_exact(buffer_bytes,
>     127						GFP_KERNEL|__GFP_ZERO|__GFP_NOWARN);
>     128		if (prof_buffer)
>     129			return 0;
>     130	
>     131		prof_buffer = vzalloc(buffer_bytes);
>     132		if (prof_buffer)
>     133			return 0;
>     134	
>     135		free_cpumask_var(prof_cpu_mask);
>   > 136		prof_cpu_mask = NULL;
>     137		return -ENOMEM;
>     138	}
>     139	
>
