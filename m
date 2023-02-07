Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5141E68D016
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjBGHEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjBGHD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:03:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5117120;
        Mon,  6 Feb 2023 23:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675753396; x=1707289396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ptH8NtvzL1DrlH7wz/ndbERaBEk8PIEAMBa7K2WDsg=;
  b=DpalcjRX2V/+FPtEvLYrBGQdl43NWELI+yldHbA54zAOly8mZtliFC5K
   qgT++GfaUyolovgqRtUVxpggvSHC8EU33yctxubGAs9hFAPKJ8r5ysU1B
   gfrAqUWS3Twng70Bv4zUj+2+tNEasoX0Iu0La+WBDO94rAhWmcQ79szNW
   G43n7Jlz9Z0yixWrsDtGA3nHrtEyzY6NVuHMpgFM3+sndmgVxwYPy47bi
   snNqvP3okaZMZtiL3ROW2OUm7GUYHgIgv7W5y1XNDwOpF12/OoBTlQg2+
   73jwqt5FKmvVZgaA8ut5qElJZa1owSLonbbTVRd7p54lpi2H1Tlo9gU7S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327111605"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="327111605"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 23:02:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="644331114"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="644331114"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Feb 2023 23:02:44 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPI03-0003EX-31;
        Tue, 07 Feb 2023 07:02:43 +0000
Date:   Tue, 7 Feb 2023 15:02:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Green <evan@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, Conor Dooley <conor@kernel.org>,
        vineetg@rivosinc.com, heiko@sntech.de, slewis@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 5/6] RISC-V: hwprobe: Support probing of misaligned
 access performance
Message-ID: <202302071444.L48pajcK-lkp@intel.com>
References: <20230206201455.1790329-6-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206201455.1790329-6-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shuah-kselftest/next]
[also build test ERROR on shuah-kselftest/fixes robh/for-next soc/for-next linus/master v6.2-rc7]
[cannot apply to next-20230207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Evan-Green/RISC-V-Move-struct-riscv_cpuinfo-to-new-header/20230207-041746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
patch link:    https://lore.kernel.org/r/20230206201455.1790329-6-evan%40rivosinc.com
patch subject: [PATCH v2 5/6] RISC-V: hwprobe: Support probing of misaligned access performance
config: riscv-randconfig-s052-20230206 (https://download.01.org/0day-ci/archive/20230207/202302071444.L48pajcK-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/9e77be253d64809a98f31c17abd12761dd9fad8e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Evan-Green/RISC-V-Move-struct-riscv_cpuinfo-to-new-header/20230207-041746
        git checkout 9e77be253d64809a98f31c17abd12761dd9fad8e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/kernel/cpufeature.c: In function 'riscv_fill_hwcap':
>> arch/riscv/kernel/cpufeature.c:258:23: error: implicit declaration of function 'hartid_to_cpuid_map' [-Werror=implicit-function-declaration]
     258 |                 cpu = hartid_to_cpuid_map(hartid);
         |                       ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/hartid_to_cpuid_map +258 arch/riscv/kernel/cpufeature.c

    93	
    94	void __init riscv_fill_hwcap(void)
    95	{
    96		struct device_node *node;
    97		const char *isa, *misaligned;
    98		char print_str[NUM_ALPHA_EXTS + 1];
    99		int i, j, rc;
   100		unsigned long isa2hwcap[26] = {0};
   101		unsigned long hartid, cpu;
   102	
   103		isa2hwcap['i' - 'a'] = COMPAT_HWCAP_ISA_I;
   104		isa2hwcap['m' - 'a'] = COMPAT_HWCAP_ISA_M;
   105		isa2hwcap['a' - 'a'] = COMPAT_HWCAP_ISA_A;
   106		isa2hwcap['f' - 'a'] = COMPAT_HWCAP_ISA_F;
   107		isa2hwcap['d' - 'a'] = COMPAT_HWCAP_ISA_D;
   108		isa2hwcap['c' - 'a'] = COMPAT_HWCAP_ISA_C;
   109	
   110		elf_hwcap = 0;
   111	
   112		bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
   113	
   114		for_each_of_cpu_node(node) {
   115			unsigned long this_hwcap = 0;
   116			DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
   117			const char *temp;
   118	
   119			rc = riscv_of_processor_hartid(node, &hartid);
   120			if (rc < 0)
   121				continue;
   122	
   123			if (of_property_read_string(node, "riscv,isa", &isa)) {
   124				pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
   125				continue;
   126			}
   127	
   128			temp = isa;
   129	#if IS_ENABLED(CONFIG_32BIT)
   130			if (!strncmp(isa, "rv32", 4))
   131				isa += 4;
   132	#elif IS_ENABLED(CONFIG_64BIT)
   133			if (!strncmp(isa, "rv64", 4))
   134				isa += 4;
   135	#endif
   136			/* The riscv,isa DT property must start with rv64 or rv32 */
   137			if (temp == isa)
   138				continue;
   139			bitmap_zero(this_isa, RISCV_ISA_EXT_MAX);
   140			for (; *isa; ++isa) {
   141				const char *ext = isa++;
   142				const char *ext_end = isa;
   143				bool ext_long = false, ext_err = false;
   144	
   145				switch (*ext) {
   146				case 's':
   147					/**
   148					 * Workaround for invalid single-letter 's' & 'u'(QEMU).
   149					 * No need to set the bit in riscv_isa as 's' & 'u' are
   150					 * not valid ISA extensions. It works until multi-letter
   151					 * extension starting with "Su" appears.
   152					 */
   153					if (ext[-1] != '_' && ext[1] == 'u') {
   154						++isa;
   155						ext_err = true;
   156						break;
   157					}
   158					fallthrough;
   159				case 'x':
   160				case 'z':
   161					ext_long = true;
   162					/* Multi-letter extension must be delimited */
   163					for (; *isa && *isa != '_'; ++isa)
   164						if (unlikely(!islower(*isa)
   165							     && !isdigit(*isa)))
   166							ext_err = true;
   167					/* Parse backwards */
   168					ext_end = isa;
   169					if (unlikely(ext_err))
   170						break;
   171					if (!isdigit(ext_end[-1]))
   172						break;
   173					/* Skip the minor version */
   174					while (isdigit(*--ext_end))
   175						;
   176					if (ext_end[0] != 'p'
   177					    || !isdigit(ext_end[-1])) {
   178						/* Advance it to offset the pre-decrement */
   179						++ext_end;
   180						break;
   181					}
   182					/* Skip the major version */
   183					while (isdigit(*--ext_end))
   184						;
   185					++ext_end;
   186					break;
   187				default:
   188					if (unlikely(!islower(*ext))) {
   189						ext_err = true;
   190						break;
   191					}
   192					/* Find next extension */
   193					if (!isdigit(*isa))
   194						break;
   195					/* Skip the minor version */
   196					while (isdigit(*++isa))
   197						;
   198					if (*isa != 'p')
   199						break;
   200					if (!isdigit(*++isa)) {
   201						--isa;
   202						break;
   203					}
   204					/* Skip the major version */
   205					while (isdigit(*++isa))
   206						;
   207					break;
   208				}
   209				if (*isa != '_')
   210					--isa;
   211	
   212	#define SET_ISA_EXT_MAP(name, bit)						\
   213				do {							\
   214					if ((ext_end - ext == sizeof(name) - 1) &&	\
   215					     !memcmp(ext, name, sizeof(name) - 1) &&	\
   216					     riscv_isa_extension_check(bit))		\
   217						set_bit(bit, this_isa);			\
   218				} while (false)						\
   219	
   220				if (unlikely(ext_err))
   221					continue;
   222				if (!ext_long) {
   223					int nr = *ext - 'a';
   224	
   225					if (riscv_isa_extension_check(nr)) {
   226						this_hwcap |= isa2hwcap[nr];
   227						set_bit(nr, this_isa);
   228					}
   229				} else {
   230					SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
   231					SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
   232					SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
   233					SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
   234					SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
   235					SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
   236				}
   237	#undef SET_ISA_EXT_MAP
   238			}
   239	
   240			/*
   241			 * All "okay" hart should have same isa. Set HWCAP based on
   242			 * common capabilities of every "okay" hart, in case they don't
   243			 * have.
   244			 */
   245			if (elf_hwcap)
   246				elf_hwcap &= this_hwcap;
   247			else
   248				elf_hwcap = this_hwcap;
   249	
   250			if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
   251				bitmap_copy(riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
   252			else
   253				bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
   254	
   255			/*
   256			 * Check for the performance of misaligned accesses.
   257			 */
 > 258			cpu = hartid_to_cpuid_map(hartid);
   259			if (cpu < 0)
   260				continue;
   261	
   262			if (!of_property_read_string(node, "riscv,misaligned-access-performance",
   263						     &misaligned)) {
   264				if (strcmp(misaligned, "emulated") == 0)
   265					per_cpu(misaligned_access_speed, cpu) =
   266						RISCV_HWPROBE_MISALIGNED_EMULATED;
   267	
   268				if (strcmp(misaligned, "slow") == 0)
   269					per_cpu(misaligned_access_speed, cpu) =
   270						RISCV_HWPROBE_MISALIGNED_SLOW;
   271	
   272				if (strcmp(misaligned, "fast") == 0)
   273					per_cpu(misaligned_access_speed, cpu) =
   274						RISCV_HWPROBE_MISALIGNED_FAST;
   275			}
   276		}
   277	
   278		/* We don't support systems with F but without D, so mask those out
   279		 * here. */
   280		if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
   281			pr_info("This kernel does not support systems with F but not D\n");
   282			elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
   283		}
   284	
   285		memset(print_str, 0, sizeof(print_str));
   286		for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
   287			if (riscv_isa[0] & BIT_MASK(i))
   288				print_str[j++] = (char)('a' + i);
   289		pr_info("riscv: base ISA extensions %s\n", print_str);
   290	
   291		memset(print_str, 0, sizeof(print_str));
   292		for (i = 0, j = 0; i < NUM_ALPHA_EXTS; i++)
   293			if (elf_hwcap & BIT_MASK(i))
   294				print_str[j++] = (char)('a' + i);
   295		pr_info("riscv: ELF capabilities %s\n", print_str);
   296	
   297		for_each_set_bit(i, riscv_isa, RISCV_ISA_EXT_MAX) {
   298			j = riscv_isa_ext2key(i);
   299			if (j >= 0)
   300				static_branch_enable(&riscv_isa_ext_keys[j]);
   301		}
   302	}
   303	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
