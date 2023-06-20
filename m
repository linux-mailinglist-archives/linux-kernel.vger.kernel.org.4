Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA6D736368
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 08:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjFTGHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 02:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFTGHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 02:07:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37EAC6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 23:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687241269; x=1718777269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dveNRvgnk0T7wEHMtgIvyEJb90QX++cVm6POy0ZjG+I=;
  b=mA151xN43EaDJNMh8Kk7dZz7JPyht2r6gjRaVqBCLk1Yh4ptT2ruq1c1
   viI22dRiV7IGnW++DfKqG/d4Zo7NES9jSLIcHtXMcN2QS5S2ZTXUV7XHt
   FSlkex2SBk/P3FUoTj5aSUetB75th0lSOta5B+TeGzN11/zp7tgwjmSXc
   AgAPTwowFo8qlZpqc+Jx5q9h6s4Zfy3r3qLtgdbAGKS0FZz8yxb7NJ7dm
   J7p2GRsfWZS27f6LIGVIWmRArhNdZV6/dnC3J0oxJ4/NVOcKzDcvi4iid
   tZPTLcuXGjz/+UpM0g128g1W2jDxnsQ6eCLvexpmll9Wdxr59HVZbNxJm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="446154049"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="446154049"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 23:07:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838092896"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838092896"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Jun 2023 23:06:58 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBUW1-0005Zo-1Y;
        Tue, 20 Jun 2023 06:06:57 +0000
Date:   Tue, 20 Jun 2023 14:06:22 +0800
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
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH v2 4/4] mtd: rawnand: brcmnand: Fix potential
 out-of-bounds access in oob write
Message-ID: <202306201340.C2Y4kmFL-lkp@intel.com>
References: <20230617022920.67173-5-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617022920.67173-5-william.zhang@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on linus/master v6.4-rc7 next-20230619]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/William-Zhang/mtd-rawnand-brcmnand-Fix-ECC-level-field-setting-for-v7-2-controller/20230617-103050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20230617022920.67173-5-william.zhang%40broadcom.com
patch subject: [PATCH v2 4/4] mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob write
config: arm64-randconfig-s043-20230619 (https://download.01.org/0day-ci/archive/20230620/202306201340.C2Y4kmFL-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230620/202306201340.C2Y4kmFL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306201340.C2Y4kmFL-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mtd/nand/raw/brcmnand/brcmnand.c:1500:54: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] data @@     got restricted __be32 [usertype] @@
   drivers/mtd/nand/raw/brcmnand/brcmnand.c:1500:54: sparse:     expected unsigned int [usertype] data
   drivers/mtd/nand/raw/brcmnand/brcmnand.c:1500:54: sparse:     got restricted __be32 [usertype]
   drivers/mtd/nand/raw/brcmnand/brcmnand.c:1836:42: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/brcmnand/brcmnand.c:1836:42: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/brcmnand/brcmnand.c:1836:42: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/brcmnand/brcmnand.c:1836:42: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/brcmnand/brcmnand.c:1836:42: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/brcmnand/brcmnand.c:1836:42: sparse: sparse: cast to restricted __be32
   drivers/mtd/nand/raw/brcmnand/brcmnand.c:2065:41: sparse: sparse: dubious: x | !y

vim +1500 drivers/mtd/nand/raw/brcmnand/brcmnand.c

  1468	
  1469	/*
  1470	 * write_oob_to_regs - write data to OOB registers
  1471	 * @i: sub-page sector index
  1472	 * @oob: buffer to write from
  1473	 * @sas: spare area sector size (i.e., OOB size per FLASH_CACHE)
  1474	 * @sector_1k: 1 for 1KiB sectors, 0 for 512B, other values are illegal
  1475	 */
  1476	static int write_oob_to_regs(struct brcmnand_controller *ctrl, int i,
  1477				     const u8 *oob, int sas, int sector_1k)
  1478	{
  1479		int tbytes = sas << sector_1k;
  1480		int j, k = 0;
  1481		u32 last = 0xffffffff;
  1482		u8 *plast = (u8 *)&last;
  1483	
  1484		/* Adjust OOB values for 1K sector size */
  1485		if (sector_1k && (i & 0x01))
  1486			tbytes = max(0, tbytes - (int)ctrl->max_oob);
  1487		tbytes = min_t(int, tbytes, ctrl->max_oob);
  1488	
  1489		for (j = 0; (j + 3) < tbytes; j += 4)
  1490			oob_reg_write(ctrl, j,
  1491					(oob[j + 0] << 24) |
  1492					(oob[j + 1] << 16) |
  1493					(oob[j + 2] <<  8) |
  1494					(oob[j + 3] <<  0));
  1495	
  1496		while (j < tbytes)
  1497			plast[k++] = oob[j++];
  1498	
  1499		if (tbytes & 0x3)
> 1500			oob_reg_write(ctrl, (tbytes & ~0x3), cpu_to_be32(last));
  1501	
  1502		return tbytes;
  1503	}
  1504	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
