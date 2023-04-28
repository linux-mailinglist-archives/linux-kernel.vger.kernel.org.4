Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B52F6F10CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 05:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345165AbjD1DVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 23:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345099AbjD1DVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 23:21:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FD61FF7;
        Thu, 27 Apr 2023 20:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682652079; x=1714188079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h6aE/EqlUU0K2SkSdtb/XtiwEYBVmbpfhaCac7uerU4=;
  b=YjTfonvX0XQQyIhoMIl5E7Cq8CM6uGdkneIxx49ATgJU8777cRimYJLP
   l/okydbyxJc6olgxqF6NkgYfYuQFrKXzR4zyHrzAEcHjENZmlTRmlWCAc
   0fwQwb5NujKlHN/pxev9S4t1QvuQ6suWCc9+2jtR2TuCO8DOmH9UID+yj
   4mByDIXltCtINd4MkOcJ7e/XfEw8Hme4bBH1uYoKj60Jw8SdYy5PVBX+9
   YFlyOTBAjDn0TNLntyGEzMkg49i0dv77Y6S1Sga0X1MgSeh8wiRfZbjf1
   MmpRJr8w6lvzQHAXRzwRQ+ejL1TPGSGR1lwV3ho0XLIAIsjRwKosoPnu/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="346394243"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="scan'208";a="346394243"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 20:21:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="806215104"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="scan'208";a="806215104"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Apr 2023 20:21:15 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psEfc-00004B-0g;
        Fri, 28 Apr 2023 03:21:16 +0000
Date:   Fri, 28 Apr 2023 11:20:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Genjian <zhanggenjian123@gmail.com>, tsbogend@alpha.franken.de,
        rdunlap@infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhanggenjian123@gmail.com,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH v2] fix ___SYNC () build error when PROFILE_ALL_BRANCHES
 is enabled
Message-ID: <202304281115.mEqaC6GM-lkp@intel.com>
References: <20230427150332.2978867-1-zhanggenjian@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427150332.2978867-1-zhanggenjian@kylinos.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Genjian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3 next-20230427]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Genjian/fix-___SYNC-build-error-when-PROFILE_ALL_BRANCHES-is-enabled/20230427-230626
base:   linus/master
patch link:    https://lore.kernel.org/r/20230427150332.2978867-1-zhanggenjian%40kylinos.cn
patch subject: [PATCH v2] fix ___SYNC () build error when PROFILE_ALL_BRANCHES is enabled
config: mips-randconfig-s053-20230427 (https://download.01.org/0day-ci/archive/20230428/202304281115.mEqaC6GM-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/6eb50851d61ca808629a062e0545704eba5be950
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Genjian/fix-___SYNC-build-error-when-PROFILE_ALL_BRANCHES-is-enabled/20230427-230626
        git checkout 6eb50851d61ca808629a062e0545704eba5be950
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/dec/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304281115.mEqaC6GM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/mips/dec/kn01-berr.c:104:34: sparse: sparse: cast removes address space '__user' of expression

vim +/__user +104 arch/mips/dec/kn01-berr.c

69c75fb458cd81 Maciej W. Rozycki 2005-06-22   59  
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   60  static int dec_kn01_be_backend(struct pt_regs *regs, int is_fixup, int invoker)
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   61  {
a5fc9c0bbee8b9 Maciej W. Rozycki 2005-07-01   62  	volatile u32 *kn01_erraddr = (void *)CKSEG1ADDR(KN01_SLOT_BASE +
a5fc9c0bbee8b9 Maciej W. Rozycki 2005-07-01   63  							KN01_ERRADDR);
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   64  
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   65  	static const char excstr[] = "exception";
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   66  	static const char intstr[] = "interrupt";
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   67  	static const char cpustr[] = "CPU";
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   68  	static const char mreadstr[] = "memory read";
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   69  	static const char readstr[] = "read";
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   70  	static const char writestr[] = "write";
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   71  	static const char timestr[] = "timeout";
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   72  	static const char paritystr[] = "parity error";
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   73  
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   74  	int data = regs->cp0_cause & 4;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   75  	unsigned int __user *pc = (unsigned int __user *)regs->cp0_epc +
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   76  				  ((regs->cp0_cause & CAUSEF_BD) != 0);
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   77  	union mips_instruction insn;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   78  	unsigned long entrylo, offset;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   79  	long asid, entryhi, vaddr;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   80  
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   81  	const char *kind, *agent, *cycle, *event;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   82  	unsigned long address;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   83  
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   84  	u32 erraddr = *kn01_erraddr;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   85  	int action = MIPS_BE_FATAL;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   86  
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   87  	/* Ack ASAP, so that any subsequent errors get caught. */
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   88  	dec_kn01_be_ack();
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   89  
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   90  	kind = invoker ? intstr : excstr;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   91  
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   92  	agent = cpustr;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   93  
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   94  	if (invoker)
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   95  		address = erraddr;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   96  	else {
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   97  		/* Bloody hardware doesn't record the address for reads... */
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   98  		if (data) {
69c75fb458cd81 Maciej W. Rozycki 2005-06-22   99  			/* This never faults. */
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  100  			__get_user(insn.word, pc);
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  101  			vaddr = regs->regs[insn.i_format.rs] +
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  102  				insn.i_format.simmediate;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  103  		} else
69c75fb458cd81 Maciej W. Rozycki 2005-06-22 @104  			vaddr = (long)pc;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  105  		if (KSEGX(vaddr) == CKSEG0 || KSEGX(vaddr) == CKSEG1)
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  106  			address = CPHYSADDR(vaddr);
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  107  		else {
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  108  			/* Peek at what physical address the CPU used. */
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  109  			asid = read_c0_entryhi();
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  110  			entryhi = asid & (PAGE_SIZE - 1);
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  111  			entryhi |= vaddr & ~(PAGE_SIZE - 1);
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  112  			write_c0_entryhi(entryhi);
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  113  			BARRIER;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  114  			tlb_probe();
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  115  			/* No need to check for presence. */
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  116  			tlb_read();
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  117  			entrylo = read_c0_entrylo0();
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  118  			write_c0_entryhi(asid);
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  119  			offset = vaddr & (PAGE_SIZE - 1);
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  120  			address = (entrylo & ~(PAGE_SIZE - 1)) | offset;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  121  		}
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  122  	}
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  123  
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  124  	/* Treat low 256MB as memory, high -- as I/O. */
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  125  	if (address < 0x10000000) {
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  126  		cycle = mreadstr;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  127  		event = paritystr;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  128  	} else {
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  129  		cycle = invoker ? writestr : readstr;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  130  		event = timestr;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  131  	}
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  132  
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  133  	if (is_fixup)
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  134  		action = MIPS_BE_FIXUP;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  135  
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  136  	if (action != MIPS_BE_FIXUP)
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  137  		printk(KERN_ALERT "Bus error %s: %s %s %s at %#010lx\n",
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  138  			kind, agent, cycle, event, address);
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  139  
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  140  	return action;
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  141  }
69c75fb458cd81 Maciej W. Rozycki 2005-06-22  142  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
