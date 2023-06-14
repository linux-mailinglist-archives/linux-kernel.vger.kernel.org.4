Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D95E72FBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbjFNLKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243690AbjFNLKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:10:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68533199B;
        Wed, 14 Jun 2023 04:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686741003; x=1718277003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sKUKsnbp/6owMK8pQSW/r9IccTSZ64R2EVqQyGjuXRU=;
  b=Lfky4yi52FPK2cU/ToJxd9A6X9/iB4AwAIi8xApurCjArHH0lelBqXn+
   z4cl4NEtj20JTh9O0QoU1ImjbjWmdqsgiFcGE9sMwtjpO2TIeSBRsUFNK
   L/QjLPIkIhRbzLyqb8hLmJ5zDdiizVsiBeJEkrwDMBD84CPWodyK0uRvx
   4nL2VnuaZps6TdJmXqw6RuBr94YXOoVjr3T76T3iGHD/eRsnYB+v2kutW
   eBQ+qh+JCWSceXUQmawlmZMpz8261AeRUb49AAYITOlegnWjmws+nahhL
   L8XoCJl/83hX1jSoJxVERE29F27iUYLrsimcKHY+Yo2zlYuZc0W6Jk/k7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="424468897"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="424468897"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 04:10:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="689377072"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="689377072"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Jun 2023 04:10:00 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9OMs-0000Xd-1F;
        Wed, 14 Jun 2023 11:09:08 +0000
Date:   Wed, 14 Jun 2023 19:07:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>, linux@roeck-us.net,
        jdelvare@suse.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: Re: [PATCH 2/3] hwmon: (sht3x) add medium repeatability support
Message-ID: <202306141807.dzcXTxhF-lkp@intel.com>
References: <DB4PR10MB62615481D91BA8A598234A18925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB4PR10MB62615481D91BA8A598234A18925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi JuenKit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.4-rc6 next-20230614]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/JuenKit-Yip/hwmon-sht3x-add-medium-repeatability-support/20230614-143100
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/DB4PR10MB62615481D91BA8A598234A18925AA%40DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
patch subject: [PATCH 2/3] hwmon: (sht3x) add medium repeatability support
config: hexagon-randconfig-r045-20230612 (https://download.01.org/0day-ci/archive/20230614/202306141807.dzcXTxhF-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add groeck-staging https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
        git fetch groeck-staging hwmon-next
        git checkout groeck-staging/hwmon-next
        b4 shazam https://lore.kernel.org/r/DB4PR10MB62615481D91BA8A598234A18925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/hwmon/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306141807.dzcXTxhF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/hwmon/sht3x.c:17:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/hwmon/sht3x.c:17:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/hwmon/sht3x.c:17:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   drivers/hwmon/sht3x.c:25:28: warning: unused variable 'sht3x_cmd_measure_blocking_hpm' [-Wunused-const-variable]
      25 | static const unsigned char sht3x_cmd_measure_blocking_hpm[]    = { 0x2c, 0x06 };
         |                            ^
>> drivers/hwmon/sht3x.c:29:28: warning: unused variable 'sht3x_cmd_measure_blocking_mpm' [-Wunused-const-variable]
      29 | static const unsigned char sht3x_cmd_measure_blocking_mpm[]    = { 0x2c, 0x0d };
         |                            ^
   drivers/hwmon/sht3x.c:33:28: warning: unused variable 'sht3x_cmd_measure_blocking_lpm' [-Wunused-const-variable]
      33 | static const unsigned char sht3x_cmd_measure_blocking_lpm[]    = { 0x2c, 0x10 };
         |                            ^
   9 warnings generated.


vim +/sht3x_cmd_measure_blocking_mpm +29 drivers/hwmon/sht3x.c

    27	
    28	/* commands (medium repeatability mode) */
  > 29	static const unsigned char sht3x_cmd_measure_blocking_mpm[]    = { 0x2c, 0x0d };
    30	static const unsigned char sht3x_cmd_measure_nonblocking_mpm[] = { 0x24, 0x0b };
    31	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
