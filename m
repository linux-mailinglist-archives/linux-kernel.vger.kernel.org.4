Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9F672B140
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 11:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjFKJzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 05:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFKJzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 05:55:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3BBE56
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 02:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686477302; x=1718013302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9xFoy8YY2bEQ2njjFFeAn0PsmVd441wz0nYBOh9GH98=;
  b=YcQG3Btv9PUCrQ2tMZCIkjWLTBwtraJ92fm6M2rLFrw4xCl8TELOlIhp
   Ceq3FJ6Yt0ZZIoxhVxPdpmuwK7r+H5qB4V/7XvgCEghzrXBt/XhQ2prmp
   pZoi28X207SjvefDaha2/I18ij+XNmY9EYZVmejkj4yz16in6UyHgR4Xg
   SkagBjRUIPIcbL8fH6HN135NfrLtngLcsqA9Q2xWHcLRvJ8l3U0JCFP8j
   bK0dF2oAFkYJ3EnYLv2S6DiR0P/GW+L4irvnjuunxJYKzfil0XKWLcMCE
   cM4CaR/rLT/J3YJIwzc7TRSngjHqRcB8Pv/g8xL5C9OzreBita/huDg4B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="444215437"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="444215437"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 02:55:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="1040991129"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="1040991129"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jun 2023 02:54:57 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8Hmi-000An6-2x;
        Sun, 11 Jun 2023 09:54:56 +0000
Date:   Sun, 11 Jun 2023 17:54:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     William Zhang <william.zhang@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, f.fainelli@gmail.com,
        rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/12] mtd: rawnand: brcmnand: Add BCMBCA read data bus
 interface
Message-ID: <202306111741.1Hs0TVE4-lkp@intel.com>
References: <20230606231252.94838-11-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606231252.94838-11-william.zhang@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on mtd/mtd/next mtd/mtd/fixes linus/master v6.4-rc5 next-20230609]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/William-Zhang/mtd-rawnand-brcmnand-Fix-ECC-level-field-setting-for-v7-2-controller/20230607-071834
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20230606231252.94838-11-william.zhang%40broadcom.com
patch subject: [PATCH 10/12] mtd: rawnand: brcmnand: Add BCMBCA read data bus interface
config: arm-randconfig-s052-20230611 (https://download.01.org/0day-ci/archive/20230611/202306111741.1Hs0TVE4-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce:
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/2fce7300f3e21ad0cb55442e1acfeaf60f41bf7d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review William-Zhang/mtd-rawnand-brcmnand-Fix-ECC-level-field-setting-for-v7-2-controller/20230607-071834
        git checkout 2fce7300f3e21ad0cb55442e1acfeaf60f41bf7d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/mtd/nand/raw/brcmnand/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306111741.1Hs0TVE4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:83:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *flash_cache @@     got void [noderef] __iomem *flash_cache @@
   drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:83:48: sparse:     expected void *flash_cache
   drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:83:48: sparse:     got void [noderef] __iomem *flash_cache
   drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:84:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:84:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:84:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:86:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:86:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got void * @@
   drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:86:25: sparse:     expected void const volatile [noderef] __iomem *from
   drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:86:25: sparse:     got void *

vim +86 drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c

    70	
    71	static void bcmbca_read_data_bus(struct brcmnand_soc *soc,
    72					 void __iomem *flash_cache,  u32 *buffer,
    73					 int fc_words, bool is_param)
    74	{
    75		int i;
    76	
    77		if (!is_param) {
    78			/*
    79			 * memcpy can do unaligned aligned access depending on source
    80			 * and dest address, which is incompatible with nand cache. Fallback
    81			 * to the memcpy for io version
    82			 */
  > 83			if (bcmbca_nand_is_buf_aligned(flash_cache, buffer))
    84				memcpy((void *)buffer, (void *)flash_cache, fc_words * 4);
    85			else
  > 86				memcpy_fromio((void *)buffer, (void *)flash_cache, fc_words * 4);
    87		} else {
    88			/* Flash cache has same endian as the host for parameter pages */
    89			for (i = 0; i < fc_words; i++, buffer++)
    90				*buffer = __raw_readl(flash_cache + i * 4);
    91		}
    92	}
    93	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
