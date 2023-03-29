Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5466CF69E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjC2W4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjC2W4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:56:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652A03C11;
        Wed, 29 Mar 2023 15:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680130578; x=1711666578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UMadLe8/Q98PSmEX0kA8aCgiUC6P+hNGYoBK15brJ8o=;
  b=lAOqjGZzAFiKdk5J+NpU4m6567tGXrQ1n/xa9OvTgYc5lagW387VFAs5
   iBgLvGXEucF7+RbducB5t6GydibWVFtKTDRr9kuK5cCs2mHuznBALBj1s
   b5MOXdk3WB1/ChoVpsZbO7ERRo+0+Pmmekn8TQ1OnfvJJgFQPyGQ/wxSX
   +zC+HmQnL+ubFUD38cSHiUwmsLD57rAhWsbK9hZd9CtgyjRHJ7eLVPzYd
   6BbECC2B5DUqwkKPobZC5iw5dV24ZNoVcsjVLTFsLj1NOg12JGVoIaxye
   ItuNbdhMEG/H4bu0d6balqVoW3eZ5w6A8IH86VyHOpwHRUMGU2CK6CpIa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="339741330"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="339741330"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 15:56:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="858672261"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="858672261"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Mar 2023 15:56:16 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pheiF-000K24-1B;
        Wed, 29 Mar 2023 22:56:15 +0000
Date:   Thu, 30 Mar 2023 06:56:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dennis Zhou <dennis@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dennis Zhou <dennis@kernel.org>
Subject: Re: [PATCH] mmc: inline the first mmc_scan() on mmc_start_host()
Message-ID: <202303300639.UEUl5xWY-lkp@intel.com>
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
config: arm-randconfig-r046-20230329 (https://download.01.org/0day-ci/archive/20230330/202303300639.UEUl5xWY-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d2de7314d2198df0c7a452546af0c15799b2d864
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dennis-Zhou/mmc-inline-the-first-mmc_scan-on-mmc_start_host/20230330-042213
        git checkout d2de7314d2198df0c7a452546af0c15799b2d864
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/mmc/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303300639.UEUl5xWY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mmc/core/core.c:2202:6: warning: no previous prototype for '__mmc_rescan' [-Wmissing-prototypes]
    2202 | void __mmc_rescan(struct mmc_host *host)
         |      ^~~~~~~~~~~~


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
