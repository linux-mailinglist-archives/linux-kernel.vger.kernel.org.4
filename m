Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657D66CF786
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjC2XhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 19:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjC2XhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:37:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048B05260;
        Wed, 29 Mar 2023 16:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680133039; x=1711669039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0HvsDv4WB1iBA2t6SV9xl2qiHbdTwL5+Hyq6lxcFQ7s=;
  b=UwyCYcPx9LdGwESiKvkOrZCkOgaL6QgbS2gw1fH3lJL13ylNWOA+nPSC
   BO5h02uStKETeUEmRqzYZ9UMouI6rWQ9urwo/xTq1hTJTCgqCA7nBRDCq
   8DsPIMTbGeEMkY0PjvA+FDdmW8IkUwjsVryx9wby6BbHhFl1egzBOVw0i
   yJfHXvf9KyH/+2yPgl9X1ypOP/l1A+KtzMmp3C0X7ScfoxbfubvE5UMfe
   bjQ7itmg28a9G0rItnzaqkH1QCMSy71b6JIzHjS8t64RLyWYwA8mf0Bqm
   R1b/+9bVcwszUF/bQmk2Ses7zkH3k1pgWvd3kcn2212YERPZ9gRJop7Zi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="427300065"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="427300065"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 16:37:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="858690302"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="858690302"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Mar 2023 16:37:16 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phfLw-000K36-03;
        Wed, 29 Mar 2023 23:37:16 +0000
Date:   Thu, 30 Mar 2023 07:36:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dennis Zhou <dennis@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH] mmc: inline the first mmc_scan() on mmc_start_host()
Message-ID: <202303300728.pAr0H6ZJ-lkp@intel.com>
References: <20230329202148.71107-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329202148.71107-1-dennis@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dennis,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ulf-hansson-mmc-mirror/next]
[also build test WARNING on linus/master v6.3-rc4 next-20230329]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dennis-Zhou/mmc-inline-the-first-mmc_scan-on-mmc_start_host/20230330-042213
base:   https://git.linaro.org/people/ulf.hansson/mmc-mirror.git next
patch link:    https://lore.kernel.org/r/20230329202148.71107-1-dennis%40kernel.org
patch subject: [PATCH] mmc: inline the first mmc_scan() on mmc_start_host()
config: hexagon-randconfig-r045-20230329 (https://download.01.org/0day-ci/archive/20230330/202303300728.pAr0H6ZJ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d2de7314d2198df0c7a452546af0c15799b2d864
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dennis-Zhou/mmc-inline-the-first-mmc_scan-on-mmc_start_host/20230330-042213
        git checkout d2de7314d2198df0c7a452546af0c15799b2d864
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/mmc/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303300728.pAr0H6ZJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/mmc/core/core.c:12:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/mmc/core/core.c:12:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/mmc/core/core.c:12:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/mmc/core/core.c:2202:6: warning: no previous prototype for function '__mmc_rescan' [-Wmissing-prototypes]
   void __mmc_rescan(struct mmc_host *host)
        ^
   drivers/mmc/core/core.c:2202:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __mmc_rescan(struct mmc_host *host)
   ^
   static 
   7 warnings generated.


vim +/__mmc_rescan +2202 drivers/mmc/core/core.c

  2201	
> 2202	void __mmc_rescan(struct mmc_host *host)
  2203	{
  2204		int i;
  2205	
  2206		if (host->rescan_disable)
  2207			return;
  2208	
  2209		/* If there is a non-removable card registered, only scan once */
  2210		if (!mmc_card_is_removable(host) && host->rescan_entered)
  2211			return;
  2212		host->rescan_entered = 1;
  2213	
  2214		if (host->trigger_card_event && host->ops->card_event) {
  2215			mmc_claim_host(host);
  2216			host->ops->card_event(host);
  2217			mmc_release_host(host);
  2218			host->trigger_card_event = false;
  2219		}
  2220	
  2221		/* Verify a registered card to be functional, else remove it. */
  2222		if (host->bus_ops)
  2223			host->bus_ops->detect(host);
  2224	
  2225		host->detect_change = 0;
  2226	
  2227		/* if there still is a card present, stop here */
  2228		if (host->bus_ops != NULL)
  2229			goto out;
  2230	
  2231		mmc_claim_host(host);
  2232		if (mmc_card_is_removable(host) && host->ops->get_cd &&
  2233				host->ops->get_cd(host) == 0) {
  2234			mmc_power_off(host);
  2235			mmc_release_host(host);
  2236			goto out;
  2237		}
  2238	
  2239		/* If an SD express card is present, then leave it as is. */
  2240		if (mmc_card_sd_express(host)) {
  2241			mmc_release_host(host);
  2242			goto out;
  2243		}
  2244	
  2245		for (i = 0; i < ARRAY_SIZE(freqs); i++) {
  2246			unsigned int freq = freqs[i];
  2247			if (freq > host->f_max) {
  2248				if (i + 1 < ARRAY_SIZE(freqs))
  2249					continue;
  2250				freq = host->f_max;
  2251			}
  2252			if (!mmc_rescan_try_freq(host, max(freq, host->f_min)))
  2253				break;
  2254			if (freqs[i] <= host->f_min)
  2255				break;
  2256		}
  2257	
  2258		/*
  2259		 * Ignore the command timeout errors observed during
  2260		 * the card init as those are excepted.
  2261		 */
  2262		host->err_stats[MMC_ERR_CMD_TIMEOUT] = 0;
  2263		mmc_release_host(host);
  2264	
  2265	 out:
  2266		if (host->caps & MMC_CAP_NEEDS_POLL)
  2267			mmc_schedule_delayed_work(&host->detect, HZ);
  2268	}
  2269	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
