Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515C071267E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243398AbjEZMWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjEZMWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:22:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C32D8
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685103753; x=1716639753;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WoAHVXyuE6np/EKIFTHT4tNOz1b9QNRjA+bAUCpRqjM=;
  b=g7AeT6LgxrMJJpMFFAHly+02/uslUWuTGxjG4uw58CcDsyuCSU59ovmD
   mlu3nhu9ZbCCJwzCC92CCu8mA4Z8zimId5OIiRFbNIYNV5jtl6uboLwpV
   M9g4yfaz1RGotlJYaif39gWutCsST6N7sxFuc6AMbyjzo+HeF6eKZTXAq
   d7gz2kAEvY+iCUO/svl1i+Jou+b/SwVRbPxVtpjpMvG/7CHwo8XsrQ1BS
   xFoKzRxlIScvJNWV/dtltjzm3okSUkw3pzTz1kb0Hqk7sld2AABcqpnOY
   Ayw0PkUvUzKp9B4dNg4DY+hhn8HObPJ18IRvBUzfmNuJsUHBBis1nOKW1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="354204788"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="354204788"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 05:22:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="735990589"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="735990589"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 May 2023 05:22:31 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2WSk-000JKW-1B;
        Fri, 26 May 2023 12:22:30 +0000
Date:   Fri, 26 May 2023 20:22:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [tip:x86/misc 1/1] arch/x86/lib/csum-partial_64.c:74:20: warning:
 variable 'result' is uninitialized when used here
Message-ID: <202305262039.3HUYjWJk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
head:   688eb8191b475db5acfd48634600b04fd3dda9ad
commit: 688eb8191b475db5acfd48634600b04fd3dda9ad [1/1] x86/csum: Improve performance of `csum_partial`
config: x86_64-randconfig-x073-20230525 (https://download.01.org/0day-ci/archive/20230526/202305262039.3HUYjWJk-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=688eb8191b475db5acfd48634600b04fd3dda9ad
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip x86/misc
        git checkout 688eb8191b475db5acfd48634600b04fd3dda9ad
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305262039.3HUYjWJk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/lib/csum-partial_64.c:74:20: warning: variable 'result' is uninitialized when used here [-Wuninitialized]
                   return csum_tail(result, temp64, odd);
                                    ^~~~~~
   arch/x86/lib/csum-partial_64.c:48:22: note: initialize the variable 'result' to silence this warning
           unsigned odd, result;
                               ^
                                = 0
   1 warning generated.


vim +/result +74 arch/x86/lib/csum-partial_64.c

    33	
    34	/*
    35	 * Do a checksum on an arbitrary memory area.
    36	 * Returns a 32bit checksum.
    37	 *
    38	 * This isn't as time critical as it used to be because many NICs
    39	 * do hardware checksumming these days.
    40	 *
    41	 * Still, with CHECKSUM_COMPLETE this is called to compute
    42	 * checksums on IPv6 headers (40 bytes) and other small parts.
    43	 * it's best to have buff aligned on a 64-bit boundary
    44	 */
    45	__wsum csum_partial(const void *buff, int len, __wsum sum)
    46	{
    47		u64 temp64 = (__force u64)sum;
    48		unsigned odd, result;
    49	
    50		odd = 1 & (unsigned long) buff;
    51		if (unlikely(odd)) {
    52			if (unlikely(len == 0))
    53				return sum;
    54			temp64 = ror32((__force u32)sum, 8);
    55			temp64 += (*(unsigned char *)buff << 8);
    56			len--;
    57			buff++;
    58		}
    59	
    60		/*
    61		 * len == 40 is the hot case due to IPv6 headers, but annotating it likely()
    62		 * has noticeable negative affect on codegen for all other cases with
    63		 * minimal performance benefit here.
    64		 */
    65		if (len == 40) {
    66			asm("addq 0*8(%[src]),%[res]\n\t"
    67			    "adcq 1*8(%[src]),%[res]\n\t"
    68			    "adcq 2*8(%[src]),%[res]\n\t"
    69			    "adcq 3*8(%[src]),%[res]\n\t"
    70			    "adcq 4*8(%[src]),%[res]\n\t"
    71			    "adcq $0,%[res]"
    72			    : [res] "+r"(temp64)
    73			    : [src] "r"(buff), "m"(*(const char(*)[40])buff));
  > 74			return csum_tail(result, temp64, odd);
    75		}
    76		if (unlikely(len >= 64)) {
    77			/*
    78			 * Extra accumulators for better ILP in the loop.
    79			 */
    80			u64 tmp_accum, tmp_carries;
    81	
    82			asm("xorl %k[tmp_accum],%k[tmp_accum]\n\t"
    83			    "xorl %k[tmp_carries],%k[tmp_carries]\n\t"
    84			    "subl $64, %[len]\n\t"
    85			    "1:\n\t"
    86			    "addq 0*8(%[src]),%[res]\n\t"
    87			    "adcq 1*8(%[src]),%[res]\n\t"
    88			    "adcq 2*8(%[src]),%[res]\n\t"
    89			    "adcq 3*8(%[src]),%[res]\n\t"
    90			    "adcl $0,%k[tmp_carries]\n\t"
    91			    "addq 4*8(%[src]),%[tmp_accum]\n\t"
    92			    "adcq 5*8(%[src]),%[tmp_accum]\n\t"
    93			    "adcq 6*8(%[src]),%[tmp_accum]\n\t"
    94			    "adcq 7*8(%[src]),%[tmp_accum]\n\t"
    95			    "adcl $0,%k[tmp_carries]\n\t"
    96			    "addq $64, %[src]\n\t"
    97			    "subl $64, %[len]\n\t"
    98			    "jge 1b\n\t"
    99			    "addq %[tmp_accum],%[res]\n\t"
   100			    "adcq %[tmp_carries],%[res]\n\t"
   101			    "adcq $0,%[res]"
   102			    : [tmp_accum] "=&r"(tmp_accum),
   103			      [tmp_carries] "=&r"(tmp_carries), [res] "+r"(temp64),
   104			      [len] "+r"(len), [src] "+r"(buff)
   105			    : "m"(*(const char *)buff));
   106		}
   107	
   108		if (len & 32) {
   109			asm("addq 0*8(%[src]),%[res]\n\t"
   110			    "adcq 1*8(%[src]),%[res]\n\t"
   111			    "adcq 2*8(%[src]),%[res]\n\t"
   112			    "adcq 3*8(%[src]),%[res]\n\t"
   113			    "adcq $0,%[res]"
   114			    : [res] "+r"(temp64)
   115			    : [src] "r"(buff), "m"(*(const char(*)[32])buff));
   116			buff += 32;
   117		}
   118		if (len & 16) {
   119			asm("addq 0*8(%[src]),%[res]\n\t"
   120			    "adcq 1*8(%[src]),%[res]\n\t"
   121			    "adcq $0,%[res]"
   122			    : [res] "+r"(temp64)
   123			    : [src] "r"(buff), "m"(*(const char(*)[16])buff));
   124			buff += 16;
   125		}
   126		if (len & 8) {
   127			asm("addq 0*8(%[src]),%[res]\n\t"
   128			    "adcq $0,%[res]"
   129			    : [res] "+r"(temp64)
   130			    : [src] "r"(buff), "m"(*(const char(*)[8])buff));
   131			buff += 8;
   132		}
   133		if (len & 7) {
   134			unsigned int shift = (-len << 3) & 63;
   135			unsigned long trail;
   136	
   137			trail = (load_unaligned_zeropad(buff) << shift) >> shift;
   138	
   139			asm("addq %[trail],%[res]\n\t"
   140			    "adcq $0,%[res]"
   141			    : [res] "+r"(temp64)
   142			    : [trail] "r"(trail));
   143		}
   144		return csum_tail(result, temp64, odd);
   145	}
   146	EXPORT_SYMBOL(csum_partial);
   147	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
