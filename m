Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FA26F9369
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 19:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjEFRm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 13:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFRm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 13:42:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF59617FD0;
        Sat,  6 May 2023 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683394945; x=1714930945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oT8CwAw0/pgt47zXZltnYILo21BzxQh30+v5OGLUHNI=;
  b=l/fFlR0cyAglwDYrvgPKFMUYL4BC9EMgjpf9y5eQxXmn9+9EDYRRPVy3
   3mT15tV9c3+vZGqzZlwI64sTPc06AxNzQ7kvdj1X/0jjudAhzHxcD/lfJ
   riFScC7Xu3xreAdleRLlwMpD6Ld4+ljY0aPhjt8tuODtEo1b3VO+TwpXU
   B1m0dCQz5xnVjR3G9umXWP6X006o+KXy8FDbeaPZD3ftT2VyQV7AfDMKw
   wSCvatUM3qoJV3Lq5QREAQhTWihdd3P1jLHgGFPai69Pv19rVVoA9sIwx
   tqV4hpsiVMknF3z9mKQ+aXvJTwoEWLwv8B7iMlhUEWoB9KNL2Q+dL2yyF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="329760996"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="329760996"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 10:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="872289514"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="872289514"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 May 2023 10:42:21 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvLvJ-0000QR-0i;
        Sat, 06 May 2023 17:42:21 +0000
Date:   Sun, 7 May 2023 01:41:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: composite-8m: Add imx8m_divider_determine_rate
Message-ID: <202305070143.iTqgbS75-lkp@intel.com>
References: <20230506162403.375212-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506162403.375212-1-aford173@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v6.3 next-20230505]
[cannot apply to abelvesa/clk/imx linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adam-Ford/clk-imx-composite-8m-Add-imx8m_divider_determine_rate/20230507-002453
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20230506162403.375212-1-aford173%40gmail.com
patch subject: [PATCH] clk: imx: composite-8m: Add imx8m_divider_determine_rate
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230507/202305070143.iTqgbS75-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d92df3b38fc20beb735cb3b75f118b45d1ae304b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Adam-Ford/clk-imx-composite-8m-Add-imx8m_divider_determine_rate/20230507-002453
        git checkout d92df3b38fc20beb735cb3b75f118b45d1ae304b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/clk/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305070143.iTqgbS75-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/imx/clk-composite-8m.c:122:5: warning: no previous prototype for 'imx8m_divider_determine_rate' [-Wmissing-prototypes]
     122 | int imx8m_divider_determine_rate(struct clk_hw *hw,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/imx8m_divider_determine_rate +122 drivers/clk/imx/clk-composite-8m.c

   121	
 > 122	int imx8m_divider_determine_rate(struct clk_hw *hw,
   123					      struct clk_rate_request *req)
   124	{
   125		struct clk_divider *divider = to_clk_divider(hw);
   126		int prediv_value;
   127		int div_value;
   128	
   129		/* if read only, just return current value */
   130		if (divider->flags & CLK_DIVIDER_READ_ONLY) {
   131			u32 val;
   132	
   133			val = readl(divider->reg);
   134			prediv_value = val >> divider->shift;
   135			prediv_value &= clk_div_mask(divider->width);
   136	
   137			div_value = val >> PCG_DIV_SHIFT;
   138			div_value &= clk_div_mask(PCG_DIV_WIDTH);
   139	
   140			return divider_ro_determine_rate(hw, req, divider->table,
   141							 PCG_PREDIV_WIDTH + PCG_DIV_WIDTH,
   142							 divider->flags, prediv_value * div_value);
   143		}
   144	
   145		return divider_determine_rate(hw, req, divider->table,
   146					      PCG_PREDIV_WIDTH + PCG_DIV_WIDTH,
   147					      divider->flags);
   148	}
   149	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
