Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8006C747006
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 13:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGDLfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 07:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjGDLfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:35:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196AA173C;
        Tue,  4 Jul 2023 04:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688470495; x=1720006495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HoyMiecTvAIewpBpm2nGQPq0wLlvOPMReqG2mgwWzZw=;
  b=l4r00dbd1S+wmxjIlDrbvKiFM/4yrrgQnd4SkRe9rEId2bKLzPcbfmf5
   l6IW3TFi/9+qWPdP86PfAI96iBu8xSZjZ6/KrU2l9PVa2MFuHZ8/rZn9q
   o5XLBNjkTvd0ZJOucKb/UUdCpHD6gK7G/QOL390OWsn/ke4vm+J0AW+1N
   Hz3hR/u4Vy0e3hYATjOVN2C3HAsdtjImUTWgluB1qZJ/otyNjKZCNPo5b
   TDa2QOd9c597ygVsKzDlLVVSdKwXyAF1cL7UWFavg8sO0LaTj4fAGM9WG
   ECVde+a8pAd1kVD2+4VHpiXbY/Ua3yUN1gc4WHXVK6GA1BFroZCx6e3Vu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="426785415"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="426785415"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 04:34:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="1049372747"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="1049372747"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jul 2023 04:34:52 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGeJ1-000IDz-0h;
        Tue, 04 Jul 2023 11:34:51 +0000
Date:   Tue, 4 Jul 2023 19:34:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roan van Dijk <roan@protonic.nl>, jic23@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, roan@protonic.nl
Subject: Re: [PATCH] iio: chemical: scd4x: Add pressure compensation
Message-ID: <202307041943.RlL71CKd-lkp@intel.com>
References: <20230704084706.370637-1-roan@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704084706.370637-1-roan@protonic.nl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.4 next-20230704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Roan-van-Dijk/iio-chemical-scd4x-Add-pressure-compensation/20230704-170621
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20230704084706.370637-1-roan%40protonic.nl
patch subject: [PATCH] iio: chemical: scd4x: Add pressure compensation
config: powerpc-randconfig-r001-20230704 (https://download.01.org/0day-ci/archive/20230704/202307041943.RlL71CKd-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230704/202307041943.RlL71CKd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307041943.RlL71CKd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:677:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      47 | DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      48 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:674:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     674 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:139:1: note: expanded from here
     139 | __do_insl
         | ^
   arch/powerpc/include/asm/io.h:616:56: note: expanded from macro '__do_insl'
     616 | #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
         |                                        ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/iio/chemical/scd4x.c:18:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:677:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      49 | DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      50 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:674:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     674 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:143:1: note: expanded from here
     143 | __do_outsb
         | ^
   arch/powerpc/include/asm/io.h:617:58: note: expanded from macro '__do_outsb'
     617 | #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
         |                                         ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/iio/chemical/scd4x.c:18:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:677:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      51 | DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      52 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:674:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     674 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:147:1: note: expanded from here
     147 | __do_outsw
         | ^
   arch/powerpc/include/asm/io.h:618:58: note: expanded from macro '__do_outsw'
     618 | #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
         |                                         ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/iio/chemical/scd4x.c:18:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:677:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
      53 | DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      54 |                  (p, b, c), pio, p)
         |                  ~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:674:3: note: expanded from macro 'DEF_PCI_AC_NORET'
     674 |                 __do_##name al;                                 \
         |                 ^~~~~~~~~~~~~~
   <scratch space>:151:1: note: expanded from here
     151 | __do_outsl
         | ^
   arch/powerpc/include/asm/io.h:619:58: note: expanded from macro '__do_outsl'
     619 | #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
         |                                         ~~~~~~~~~~~~~~~~~~~~~^
>> drivers/iio/chemical/scd4x.c:382:8: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     382 |                 else if (chan->type == IIO_PRESSURE)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/chemical/scd4x.c:385:7: note: uninitialized use occurs here
     385 |                 if (ret)
         |                     ^~~
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                                               ^~~~
   include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/iio/chemical/scd4x.c:382:8: note: remove the 'if' if its condition is always true
     382 |                 else if (chan->type == IIO_PRESSURE)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     383 |                         ret = scd4x_read(state, CMD_GET_AMB_PRESSURE, &tmp, sizeof(tmp));
         | ~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   drivers/iio/chemical/scd4x.c:340:9: note: initialize the variable 'ret' to silence this warning
     340 |         int ret;
         |                ^
         |                 = 0
   7 warnings generated.


vim +382 drivers/iio/chemical/scd4x.c

   334	
   335	static int scd4x_read_raw(struct iio_dev *indio_dev,
   336				struct iio_chan_spec const *chan, int *val,
   337				int *val2, long mask)
   338	{
   339		struct scd4x_state *state = iio_priv(indio_dev);
   340		int ret;
   341		__be16 tmp;
   342	
   343		switch (mask) {
   344		case IIO_CHAN_INFO_RAW:
   345			ret = iio_device_claim_direct_mode(indio_dev);
   346			if (ret)
   347				return ret;
   348	
   349			mutex_lock(&state->lock);
   350			ret = scd4x_read_channel(state, chan->address);
   351			mutex_unlock(&state->lock);
   352	
   353			iio_device_release_direct_mode(indio_dev);
   354			if (ret < 0)
   355				return ret;
   356	
   357			*val = ret;
   358			return IIO_VAL_INT;
   359		case IIO_CHAN_INFO_SCALE:
   360			if (chan->type == IIO_CONCENTRATION) {
   361				*val = 0;
   362				*val2 = 100;
   363				return IIO_VAL_INT_PLUS_MICRO;
   364			} else if (chan->type == IIO_TEMP) {
   365				*val = 175000;
   366				*val2 = 65536;
   367				return IIO_VAL_FRACTIONAL;
   368			} else if (chan->type == IIO_HUMIDITYRELATIVE) {
   369				*val = 100000;
   370				*val2 = 65536;
   371				return IIO_VAL_FRACTIONAL;
   372			}
   373			return -EINVAL;
   374		case IIO_CHAN_INFO_OFFSET:
   375			*val = -16852;
   376			*val2 = 114286;
   377			return IIO_VAL_INT_PLUS_MICRO;
   378		case IIO_CHAN_INFO_CALIBBIAS:
   379			mutex_lock(&state->lock);
   380			if (chan->type == IIO_TEMP)
   381				ret = scd4x_read(state, CMD_GET_TEMP_OFFSET, &tmp, sizeof(tmp));
 > 382			else if (chan->type == IIO_PRESSURE)
   383				ret = scd4x_read(state, CMD_GET_AMB_PRESSURE, &tmp, sizeof(tmp));
   384			mutex_unlock(&state->lock);
   385			if (ret)
   386				return ret;
   387	
   388			*val = be16_to_cpu(tmp);
   389	
   390			return IIO_VAL_INT;
   391		default:
   392			return -EINVAL;
   393		}
   394	}
   395	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
