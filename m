Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D9E6D1A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjCaIla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjCaIlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:41:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D6E1BF4B;
        Fri, 31 Mar 2023 01:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680252035; x=1711788035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vjsxNgm+Yo+kyFtOqk7avep7z4eeJQqXk9gGOTwQj3o=;
  b=Wl7rVennfUhl4rQyRz72w9T9W9kbfdol1cQaJZutTrJOEDyhD2lablUT
   bxRZMrrxkmTyjMylbEQWmWQzSZhlYgYbynFBjkmwoX8rytZlhIJi79Hig
   9/y1DQRryxq98s3tACnQqxWXWsiJDons1rJzXgKY4EE40iAxlfdK4j+Tj
   Iey67L+SdoVFtKl/Fn1HgAiuWe/DP477dnOsj6NZR8FyqLAocWdVjTfLi
   CQmvv6StG9+tIXj5eHLn5STSBsHLv7S9rhEVvgz22NB1IFSW8gzLH396a
   GObArsaGgJIs3Zd6xyHUD5QtNuKXKaU+PdhOA350KiIwMi7UkanXYCl7u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="406410013"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="406410013"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 01:40:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="635216891"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="635216891"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 31 Mar 2023 01:40:30 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piAJB-000LcQ-0Q;
        Fri, 31 Mar 2023 08:40:29 +0000
Date:   Fri, 31 Mar 2023 16:39:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, abelvesa@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 4/6] clk: imx: fracn-gppll: support integer pll
Message-ID: <202303311642.0nlzpIER-lkp@intel.com>
References: <20230331064629.2475338-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331064629.2475338-5-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

I love your patch! Perhaps something to improve:

[auto build test WARNING on abelvesa/clk/imx]
[also build test WARNING on linus/master v6.3-rc4 next-20230331]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/clk-imx-fracn-gppll-fix-the-rate-table/20230331-144314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
patch link:    https://lore.kernel.org/r/20230331064629.2475338-5-peng.fan%40oss.nxp.com
patch subject: [PATCH 4/6] clk: imx: fracn-gppll: support integer pll
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230331/202303311642.0nlzpIER-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b80cff81a332a2005b90c5c1fbab96e732c03494
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/clk-imx-fracn-gppll-fix-the-rate-table/20230331-144314
        git checkout b80cff81a332a2005b90c5c1fbab96e732c03494
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/clk/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303311642.0nlzpIER-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/imx/clk-fracn-gppll.c:340:16: warning: no previous prototype for '_imx_clk_fracn_gppll' [-Wmissing-prototypes]
     340 | struct clk_hw *_imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
         |                ^~~~~~~~~~~~~~~~~~~~


vim +/_imx_clk_fracn_gppll +340 drivers/clk/imx/clk-fracn-gppll.c

   339	
 > 340	struct clk_hw *_imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
   341					    const struct imx_fracn_gppll_clk *pll_clk, u32 pll_flags)
   342	{
   343		struct clk_fracn_gppll *pll;
   344		struct clk_hw *hw;
   345		struct clk_init_data init;
   346		int ret;
   347	
   348		pll = kzalloc(sizeof(*pll), GFP_KERNEL);
   349		if (!pll)
   350			return ERR_PTR(-ENOMEM);
   351	
   352		init.name = name;
   353		init.flags = pll_clk->flags;
   354		init.parent_names = &parent_name;
   355		init.num_parents = 1;
   356		init.ops = &clk_fracn_gppll_ops;
   357	
   358		pll->base = base;
   359		pll->hw.init = &init;
   360		pll->rate_table = pll_clk->rate_table;
   361		pll->rate_count = pll_clk->rate_count;
   362		pll->flags = pll_flags;
   363	
   364		hw = &pll->hw;
   365	
   366		ret = clk_hw_register(NULL, hw);
   367		if (ret) {
   368			pr_err("%s: failed to register pll %s %d\n", __func__, name, ret);
   369			kfree(pll);
   370			return ERR_PTR(ret);
   371		}
   372	
   373		return hw;
   374	}
   375	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
