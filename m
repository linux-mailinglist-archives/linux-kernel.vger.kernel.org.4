Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF1B73446B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 01:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjFQXMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 19:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjFQXMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 19:12:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3909910C3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 16:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ytibkPk92NfEdLTeVIuLAzYel0JJOXPs+PxXpWBltLE=; b=PBP6StKJwPTIeQTi83oeTfrNwh
        IVFmOEvNnp/t3yCYf29K3tvbhxZwOb2TEPi+IWXE2+ZBiAIst9wgT8S1Wf5xuTX3iJcyO35UzsnTv
        ikf8+qoOrhvgAA1i6Pb1cBsaE2TxHoa4jnDYbm6lsLMF/s0I7451y2gJ+rbZ3gvMHUw9Q46TzRZdF
        4pcLfPvcwZmeTOkwkEYUih3gnY2A5+nI8Y2EDf/nHFUn+oBwEnnCEv7j9zs64VETMUruCEc848HNU
        EhJsnr2rx3h5yhjKUdXavTdrDnLC93k6546cEUNnQGiH5bHN929IkOD/2EymamMEMM95IhhiQk9Xd
        27nBbhjg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qAf55-004ax0-0r;
        Sat, 17 Jun 2023 23:11:43 +0000
Message-ID: <41ff75d4-aef4-cfec-2bef-afc8223e548e@infradead.org>
Date:   Sat, 17 Jun 2023 16:11:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: arch/riscv/mm/init.c:1204:48: sparse: sparse: cast truncates bits
 from constant value (100000000 becomes 0)
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Yimin Gu <ustcymgu@gmail.com>,
        Nick Kossifidis <mick@ics.forth.gr>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <202305171743.3LP5XWzV-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202305171743.3LP5XWzV-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Nick
+ linux-riscv

On 5/17/23 03:09, kernel test robot wrote:
> Hi Yimin,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
> commit: b5e2c507b06c9d36411845149162a804ae7b04a9 riscv: Kconfig: Allow RV32 to build with no MMU
> date:   7 weeks ago
> config: riscv-randconfig-s041-20230517
> compiler: riscv32-linux-gcc (GCC) 12.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-39-gce1a6720-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b5e2c507b06c9d36411845149162a804ae7b04a9
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout b5e2c507b06c9d36411845149162a804ae7b04a9
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/ fs/ext4/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305171743.3LP5XWzV-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>    WARNING: invalid argument to '-march': '_zihintpause'
>>> arch/riscv/mm/init.c:1204:48: sparse: sparse: cast truncates bits from constant value (100000000 becomes 0)

^^^ please see below.

> --
>    WARNING: invalid argument to '-march': '_zihintpause'
>    fs/ext4/mballoc.c: note: in included file (through include/linux/timex.h, include/linux/time32.h, include/linux/time.h, ...):
>>> arch/riscv/include/asm/timex.h:25:16: sparse: sparse: cast removes address space '__iomem' of expression
>>> arch/riscv/include/asm/timex.h:25:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
>    arch/riscv/include/asm/timex.h:25:16: sparse:     expected void const volatile [noderef] __iomem *addr
>    arch/riscv/include/asm/timex.h:25:16: sparse:     got unsigned int [usertype] *
>>> arch/riscv/include/asm/timex.h:25:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
>    arch/riscv/include/asm/timex.h:25:16: sparse:     expected void const volatile [noderef] __iomem *addr
>    arch/riscv/include/asm/timex.h:25:16: sparse:     got unsigned int [usertype] *
>    fs/ext4/mballoc.c:2942:13: sparse: sparse: context imbalance in 'ext4_mb_seq_structs_summary_start' - wrong count at exit
> 
> vim +1204 arch/riscv/mm/init.c
> 
> 671f9a3e2e24cd Anup Patel      2019-06-28  1154  
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1155  /*
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1156   * reserve_crashkernel() - reserves memory for crash kernel
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1157   *
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1158   * This function reserves memory area given in "crashkernel=" kernel command
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1159   * line parameter. The memory reserved is used by dump capture kernel when
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1160   * primary kernel is crashing.
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1161   */
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1162  static void __init reserve_crashkernel(void)
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1163  {
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1164  	unsigned long long crash_base = 0;
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1165  	unsigned long long crash_size = 0;
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1166  	unsigned long search_start = memblock_start_of_DRAM();
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1167  	unsigned long search_end = memblock_end_of_DRAM();
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1168  
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1169  	int ret = 0;
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1170  
> d414cb379ac35e Jisheng Zhang   2022-03-23  1171  	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
> d414cb379ac35e Jisheng Zhang   2022-03-23  1172  		return;
> 5640975003d023 Nick Kossifidis 2021-04-19  1173  	/*
> 5640975003d023 Nick Kossifidis 2021-04-19  1174  	 * Don't reserve a region for a crash kernel on a crash kernel
> 5640975003d023 Nick Kossifidis 2021-04-19  1175  	 * since it doesn't make much sense and we have limited memory
> 5640975003d023 Nick Kossifidis 2021-04-19  1176  	 * resources.
> 5640975003d023 Nick Kossifidis 2021-04-19  1177  	 */
> 5640975003d023 Nick Kossifidis 2021-04-19  1178  	if (is_kdump_kernel()) {
> 5640975003d023 Nick Kossifidis 2021-04-19  1179  		pr_info("crashkernel: ignoring reservation request\n");
> 5640975003d023 Nick Kossifidis 2021-04-19  1180  		return;
> 5640975003d023 Nick Kossifidis 2021-04-19  1181  	}
> 5640975003d023 Nick Kossifidis 2021-04-19  1182  
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1183  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1184  				&crash_size, &crash_base);
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1185  	if (ret || !crash_size)
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1186  		return;
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1187  
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1188  	crash_size = PAGE_ALIGN(crash_size);
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1189  
> a7259df7670240 Mike Rapoport   2021-09-02  1190  	if (crash_base) {
> a7259df7670240 Mike Rapoport   2021-09-02  1191  		search_start = crash_base;
> a7259df7670240 Mike Rapoport   2021-09-02  1192  		search_end = crash_base + crash_size;
> a7259df7670240 Mike Rapoport   2021-09-02  1193  	}
> a7259df7670240 Mike Rapoport   2021-09-02  1194  
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1195  	/*
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1196  	 * Current riscv boot protocol requires 2MB alignment for
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1197  	 * RV64 and 4MB alignment for RV32 (hugepage size)
> decf89f86ecd3c Nick Kossifidis 2021-11-26  1198  	 *
> decf89f86ecd3c Nick Kossifidis 2021-11-26  1199  	 * Try to alloc from 32bit addressible physical memory so that
> decf89f86ecd3c Nick Kossifidis 2021-11-26  1200  	 * swiotlb can work on the crash kernel.
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1201  	 */
> decf89f86ecd3c Nick Kossifidis 2021-11-26  1202  	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
> decf89f86ecd3c Nick Kossifidis 2021-11-26  1203  					       search_start,
> decf89f86ecd3c Nick Kossifidis 2021-11-26 @1204  					       min(search_end, (unsigned long) SZ_4G));

SZ_4G = 0x100000000, truncated to unsigned long (32 bits), becomes 0, so min() is 0.
Or am I not following this correctly?

Should the second param to min() be changed to SZ_4G - 1
or is this not an issue?

> decf89f86ecd3c Nick Kossifidis 2021-11-26  1205  	if (crash_base == 0) {
> decf89f86ecd3c Nick Kossifidis 2021-11-26  1206  		/* Try again without restricting region to 32bit addressible memory */
> a7259df7670240 Mike Rapoport   2021-09-02  1207  		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
> a7259df7670240 Mike Rapoport   2021-09-02  1208  						search_start, search_end);
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1209  		if (crash_base == 0) {
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1210  			pr_warn("crashkernel: couldn't allocate %lldKB\n",
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1211  				crash_size >> 10);
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1212  			return;
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1213  		}
> decf89f86ecd3c Nick Kossifidis 2021-11-26  1214  	}
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1215  
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1216  	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1217  		crash_base, crash_base + crash_size, crash_size >> 20);
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1218  
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1219  	crashk_res.start = crash_base;
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1220  	crashk_res.end = crash_base + crash_size - 1;
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1221  }
> e53d28180d4d0f Nick Kossifidis 2021-04-19  1222  
> 
> :::::: The code at line 1204 was first introduced by commit
> :::::: decf89f86ecd3c3c3de81c562010d5797bea3de1 riscv: try to allocate crashkern region from 32bit addressible memory
> 
> :::::: TO: Nick Kossifidis <mick@ics.forth.gr>
> :::::: CC: Palmer Dabbelt <palmer@rivosinc.com>
> 

Thanks.
-- 
~Randy
