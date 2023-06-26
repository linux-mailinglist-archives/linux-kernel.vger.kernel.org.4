Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A24073D5AD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjFZCCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZCCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:02:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723DEC2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 19:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687744922; x=1719280922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gnkp5LohmQ7mxtSM9otU7q+Yt38d3qrFodovkYf3rYw=;
  b=DJCN82zZAC4SSctyqssDvrklK20jVDEo/rhtbHXFZ/ZW3HnnzGqZND8/
   MqbHC3pOJkE26xoGAgiRsHUKWTy9qJuE2lDjO+ByoQPI1fRrqzmZXNssQ
   oUEhOuT7cQ9PYQvDs5kMRuySu3Bk/ezSNv2TcY5Pvz9IsyblMCliX5xCF
   JCADXvyRLL0WCltTO29w1Jox+rn9+6tznDLfsRkDPxkQKHBhLilTPLJTg
   L4RJFXHGU1DHBxRen2knoYqevl4komTJ7lxm0cryF9n1nwfkkrTCju601
   lh/QjI8y+4k5yn4nCY+FVNmU2kgE6cuxTeKlxHwrTrumkPs+EpadIMQ9Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="345901973"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="345901973"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 19:02:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="1046315819"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="1046315819"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jun 2023 19:01:59 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDbYE-000AOn-1K;
        Mon, 26 Jun 2023 02:01:58 +0000
Date:   Mon, 26 Jun 2023 10:01:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     D Scott Phillips <scott@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Subject: Re: [PATCH v4] arm64: sdei: abort running SDEI handlers during crash
Message-ID: <202306260925.6Qm42hTs-lkp@intel.com>
References: <20230625234033.672594-1-scott@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625234033.672594-1-scott@os.amperecomputing.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on arm/for-next arm/fixes kvmarm/next soc/for-next linus/master v6.4 next-20230623]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/D-Scott-Phillips/arm64-sdei-abort-running-SDEI-handlers-during-crash/20230626-074210
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230625234033.672594-1-scott%40os.amperecomputing.com
patch subject: [PATCH v4] arm64: sdei: abort running SDEI handlers during crash
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230626/202306260925.6Qm42hTs-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230626/202306260925.6Qm42hTs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306260925.6Qm42hTs-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/arm64/kernel/smp.c: In function 'crash_smp_send_stop':
>> arch/arm64/kernel/smp.c:1073:9: error: implicit declaration of function 'sdei_handler_abort'; did you mean 'acpi_handle_alert'? [-Werror=implicit-function-declaration]
    1073 |         sdei_handler_abort();
         |         ^~~~~~~~~~~~~~~~~~
         |         acpi_handle_alert
   cc1: some warnings being treated as errors


vim +1073 arch/arm64/kernel/smp.c

  1030	
  1031	#ifdef CONFIG_KEXEC_CORE
  1032	void crash_smp_send_stop(void)
  1033	{
  1034		static int cpus_stopped;
  1035		cpumask_t mask;
  1036		unsigned long timeout;
  1037	
  1038		/*
  1039		 * This function can be called twice in panic path, but obviously
  1040		 * we execute this only once.
  1041		 */
  1042		if (cpus_stopped)
  1043			return;
  1044	
  1045		cpus_stopped = 1;
  1046	
  1047		/*
  1048		 * If this cpu is the only one alive at this point in time, online or
  1049		 * not, there are no stop messages to be sent around, so just back out.
  1050		 */
  1051		if (num_other_online_cpus() == 0)
  1052			goto skip_ipi;
  1053	
  1054		cpumask_copy(&mask, cpu_online_mask);
  1055		cpumask_clear_cpu(smp_processor_id(), &mask);
  1056	
  1057		atomic_set(&waiting_for_crash_ipi, num_other_online_cpus());
  1058	
  1059		pr_crit("SMP: stopping secondary CPUs\n");
  1060		smp_cross_call(&mask, IPI_CPU_CRASH_STOP);
  1061	
  1062		/* Wait up to one second for other CPUs to stop */
  1063		timeout = USEC_PER_SEC;
  1064		while ((atomic_read(&waiting_for_crash_ipi) > 0) && timeout--)
  1065			udelay(1);
  1066	
  1067		if (atomic_read(&waiting_for_crash_ipi) > 0)
  1068			pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
  1069				cpumask_pr_args(&mask));
  1070	
  1071	skip_ipi:
  1072		sdei_mask_local_cpu();
> 1073		sdei_handler_abort();
  1074	}
  1075	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
