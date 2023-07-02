Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E732A74521F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjGBUJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjGBUI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:08:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D601FCD;
        Sun,  2 Jul 2023 13:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688328439; x=1719864439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KomjQBb5bvym6eCrKFp6yiJMpgWdmolf6Tuzqi2QmWI=;
  b=KxWoj2iaxu4pjfVV+ZJ2w0dVli/8keY7rglHlOCbNFARikE6i/+s+MB3
   bpu4HUXHehF9wJj78zNAPq4vDPg03TeEt7hfNrjfU0aBPJm29fZnsArIp
   9ORFB3NWpbo04qYsx+PuyORMS4tc9Njl5UJ62APKkaECTr6trneTreaEE
   rYJb6nG78LF+gf5OkLTJ8H90zL99g3mH9eiZOXSIW7xQkztSd7eevhdI6
   P2Xkd1Uc5S5RWi31M/wwvo0DolFVkTfy8OZFu1beZ8coqmF8cBaHkYd0J
   x8N8ifUYHXR60wWQNVkX4DRRqKRWG+XKvlRWrXo7+IHSOK08S9kvPr0OI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="449115564"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="449115564"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 13:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="842447071"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="842447071"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Jul 2023 13:06:47 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qG3LK-000GrJ-2i;
        Sun, 02 Jul 2023 20:06:46 +0000
Date:   Mon, 3 Jul 2023 04:06:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Oltmanns <frank@oltmanns.dev>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
Subject: Re: [PATCH v3 5/8] clk: sunxi-ng: nkm: Support finding closest rate
Message-ID: <202307030302.s1bheEun-lkp@intel.com>
References: <20230702-pll-mipi_set_rate_parent-v3-5-46dcb8aa9cbc@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702-pll-mipi_set_rate_parent-v3-5-46dcb8aa9cbc@oltmanns.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6995e2de6891c724bfeb2db33d7b87775f913ad1]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Oltmanns/clk-sunxi-ng-nkm-consider-alternative-parent-rates-when-determining-rate/20230703-015726
base:   6995e2de6891c724bfeb2db33d7b87775f913ad1
patch link:    https://lore.kernel.org/r/20230702-pll-mipi_set_rate_parent-v3-5-46dcb8aa9cbc%40oltmanns.dev
patch subject: [PATCH v3 5/8] clk: sunxi-ng: nkm: Support finding closest rate
config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20230703/202307030302.s1bheEun-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230703/202307030302.s1bheEun-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307030302.s1bheEun-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/sunxi-ng/ccu_nkm.c:46:24: warning: variable 'tmp_diff' is uninitialized when used here [-Wuninitialized]
      46 |                                         tmp_diff = rate - tmp_diff;
         |                                                           ^~~~~~~~
   drivers/clk/sunxi-ng/ccu_nkm.c:33:27: note: initialize the variable 'tmp_diff' to silence this warning
      33 |                                 unsigned long tmp_diff;
         |                                                       ^
         |                                                        = 0
   drivers/clk/sunxi-ng/ccu_nkm.c:93:24: warning: variable 'tmp_diff' is uninitialized when used here [-Wuninitialized]
      93 |                                         tmp_diff = rate - tmp_diff;
         |                                                           ^~~~~~~~
   drivers/clk/sunxi-ng/ccu_nkm.c:82:27: note: initialize the variable 'tmp_diff' to silence this warning
      82 |                                 unsigned long tmp_diff;
         |                                                       ^
         |                                                        = 0
   2 warnings generated.


vim +/tmp_diff +46 drivers/clk/sunxi-ng/ccu_nkm.c

    19	
    20	static unsigned long ccu_nkm_find_best_with_parent_adj(unsigned long *parent, unsigned long rate,
    21							       struct _ccu_nkm *nkm, struct clk_hw *phw,
    22							       unsigned long features)
    23	{
    24		unsigned long best_rate = 0, best_parent_rate = 0, tmp_parent = *parent;
    25		unsigned long best_diff = ULONG_MAX;
    26		unsigned long best_n = 0, best_k = 0, best_m = 0;
    27		unsigned long _n, _k, _m;
    28	
    29		for (_k = nkm->min_k; _k <= nkm->max_k; _k++) {
    30			for (_n = nkm->min_n; _n <= nkm->max_n; _n++) {
    31				for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
    32					unsigned long tmp_rate;
    33					unsigned long tmp_diff;
    34	
    35					tmp_parent = clk_hw_round_rate(phw, rate * _m / (_n * _k));
    36	
    37					tmp_rate = tmp_parent * _n * _k / _m;
    38	
    39					if (features & CCU_FEATURE_CLOSEST_RATE) {
    40						tmp_diff = rate > tmp_rate ?
    41							   rate - tmp_rate :
    42							   tmp_rate - rate;
    43					} else {
    44						if (tmp_rate > rate)
    45							continue;
  > 46						tmp_diff = rate - tmp_diff;
    47					}
    48	
    49					if (tmp_diff < best_diff) {
    50						best_rate = tmp_rate;
    51						best_parent_rate = tmp_parent;
    52						best_diff = tmp_diff;
    53						best_n = _n;
    54						best_k = _k;
    55						best_m = _m;
    56					}
    57				}
    58			}
    59		}
    60	
    61		nkm->n = best_n;
    62		nkm->k = best_k;
    63		nkm->m = best_m;
    64	
    65		*parent = best_parent_rate;
    66	
    67		return best_rate;
    68	}
    69	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
