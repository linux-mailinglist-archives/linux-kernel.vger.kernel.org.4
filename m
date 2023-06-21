Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3904D738346
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjFUL6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjFUL6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:58:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AD71713
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687348690; x=1718884690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/UaZYJmBVZXLtrLONhqjC70JFtiBLSaQl6d55pahEGM=;
  b=FMzzKCjkwSUYr/ghBLZAYV41amfUwbZJekA2sz7eL3p6ghgV87FWFEn7
   ckiA95bH5Wm9Lhumgv0blPjsYzwJ6IguIpkv0ADB5kuUi+N5QsfAf01Uv
   FEOpPXz34Xj6tdZI6KoVpSDg6Znc1nd0LPyM3DM4mZqlGTEWora3WXw2X
   AQfEHyVqGTwc1IisTeiodHv9lfNAe2sI37Hy45K84+dpqTcBSMaW5z7Lt
   9PSUy1l+PIftze12i4cCaoLkxOh7W68Su96An8saZg4e3IHIGpHQKUtZb
   RlRcBnw/wesbtXW74jo1FzyN9iDfDk2qgt+zq5iImmqvPQ4fNeegUyk79
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="340493091"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="340493091"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 04:58:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838591996"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="838591996"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Jun 2023 04:58:07 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBwTO-0006op-0a;
        Wed, 21 Jun 2023 11:58:06 +0000
Date:   Wed, 21 Jun 2023 19:57:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ptrace: Split gpr32_set_common
Message-ID: <202306211940.y4kIhSei-lkp@intel.com>
References: <3086d189fa629e6c7bf800832921669450cc09bf.1687343697.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3086d189fa629e6c7bf800832921669450cc09bf.1687343697.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes linus/master v6.4-rc7 next-20230621]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/powerpc-ptrace-Split-gpr32_set_common/20230621-183932
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/3086d189fa629e6c7bf800832921669450cc09bf.1687343697.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH] powerpc/ptrace: Split gpr32_set_common
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20230621/202306211940.y4kIhSei-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211940.y4kIhSei-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306211940.y4kIhSei-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/kernel/ptrace/ptrace-view.c:719:5: error: no previous prototype for 'gpr32_set_common_kernel' [-Werror=missing-prototypes]
     719 | int gpr32_set_common_kernel(struct task_struct *target,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/ptrace/ptrace-view.c:757:5: error: no previous prototype for 'gpr32_set_common_user' [-Werror=missing-prototypes]
     757 | int gpr32_set_common_user(struct task_struct *target,
         |     ^~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/gpr32_set_common_kernel +719 arch/powerpc/kernel/ptrace/ptrace-view.c

   718	
 > 719	int gpr32_set_common_kernel(struct task_struct *target,
   720				    const struct user_regset *regset,
   721				    unsigned int pos, unsigned int count,
   722				    const void *kbuf, unsigned long *regs)
   723	{
   724		const compat_ulong_t *k = kbuf;
   725	
   726		pos /= sizeof(compat_ulong_t);
   727		count /= sizeof(compat_ulong_t);
   728	
   729		for (; count > 0 && pos < PT_MSR; --count)
   730			regs[pos++] = *k++;
   731	
   732		if (count > 0 && pos == PT_MSR) {
   733			set_user_msr(target, *k++);
   734			++pos;
   735			--count;
   736		}
   737	
   738		for (; count > 0 && pos <= PT_MAX_PUT_REG; --count)
   739			regs[pos++] = *k++;
   740		for (; count > 0 && pos < PT_TRAP; --count, ++pos)
   741			++k;
   742	
   743		if (count > 0 && pos == PT_TRAP) {
   744			set_user_trap(target, *k++);
   745			++pos;
   746			--count;
   747		}
   748	
   749		kbuf = k;
   750		pos *= sizeof(compat_ulong_t);
   751		count *= sizeof(compat_ulong_t);
   752		user_regset_copyin_ignore(&pos, &count, &kbuf, NULL,
   753					  (PT_TRAP + 1) * sizeof(compat_ulong_t), -1);
   754		return 0;
   755	}
   756	
 > 757	int gpr32_set_common_user(struct task_struct *target,
   758				  const struct user_regset *regset,
   759				  unsigned int pos, unsigned int count,
   760				  const void __user *ubuf, unsigned long *regs)
   761	{
   762		const compat_ulong_t __user *u = ubuf;
   763		compat_ulong_t reg;
   764	
   765		if (!user_read_access_begin(u, count))
   766			return -EFAULT;
   767	
   768		pos /= sizeof(reg);
   769		count /= sizeof(reg);
   770	
   771		for (; count > 0 && pos < PT_MSR; --count) {
   772			unsafe_get_user(reg, u++, Efault);
   773			regs[pos++] = reg;
   774		}
   775	
   776		if (count > 0 && pos == PT_MSR) {
   777			unsafe_get_user(reg, u++, Efault);
   778			set_user_msr(target, reg);
   779			++pos;
   780			--count;
   781		}
   782	
   783		for (; count > 0 && pos <= PT_MAX_PUT_REG; --count) {
   784			unsafe_get_user(reg, u++, Efault);
   785			regs[pos++] = reg;
   786		}
   787		for (; count > 0 && pos < PT_TRAP; --count, ++pos)
   788			unsafe_get_user(reg, u++, Efault);
   789	
   790		if (count > 0 && pos == PT_TRAP) {
   791			unsafe_get_user(reg, u++, Efault);
   792			set_user_trap(target, reg);
   793			++pos;
   794			--count;
   795		}
   796		user_read_access_end();
   797	
   798		ubuf = u;
   799		pos *= sizeof(reg);
   800		count *= sizeof(reg);
   801		user_regset_copyin_ignore(&pos, &count, NULL, &ubuf,
   802					  (PT_TRAP + 1) * sizeof(reg), -1);
   803		return 0;
   804	
   805	Efault:
   806		user_read_access_end();
   807		return -EFAULT;
   808	}
   809	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
