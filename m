Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3360E6EE637
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbjDYQ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjDYQ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:58:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E950F6A4B;
        Tue, 25 Apr 2023 09:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682441895; x=1713977895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YqqMtoC9cWi/0V4GCglSo1y9g8dhnon56YoIruvJfJw=;
  b=BogFYqJEfIEKMXgkxWpruTnPRnURQPHEhyeGAGE80D8T913wntjvL79D
   6NdeDaQwp3YBfmPRAiCsOT5iEhmeflPromNhvTlMfJ1HvufdrWYM1PHHp
   kbw2Y3F6p0CzGMv1giCHPstxtXIljcv4CK1ytFmIE3CyYHyjzrvu2+jxm
   dwXZFSX96CKAcfhnlXPbWm2s5HR9U02U606GfDF3GHy5xvnGjtCF0rrV5
   wezesDAX3h1YYmkTIbo69Dvzef1lhGJqb2HTedzk6bHnI3YMKuPc4EUpI
   uwqFFDvsWdZHg357I5DGS3iBNLtYlTayPmP6ASaz1q3c2eunSj4oTp+kd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="335736973"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="335736973"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 09:58:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="696262494"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="696262494"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Apr 2023 09:57:52 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prLzD-000jbM-1u;
        Tue, 25 Apr 2023 16:57:51 +0000
Date:   Wed, 26 Apr 2023 00:56:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ziqin Liu <ziqin_l@hust.edu.cn>, dzm91@hust.edu.cn,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        hust-os-kernel-patches@googlegroups.com,
        Ziqin Liu <ziqin_l@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] clk: mediatek: clk-mt8173: fix memory leak in
 clk_mt8173_apmixed_probe
Message-ID: <202304260006.3Am8FGjt-lkp@intel.com>
References: <20230425132601.106181-1-ziqin_l@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425132601.106181-1-ziqin_l@hust.edu.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ziqin,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linus/master v6.3 next-20230425]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ziqin-Liu/clk-mediatek-clk-mt8173-fix-memory-leak-in-clk_mt8173_apmixed_probe/20230425-212917
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20230425132601.106181-1-ziqin_l%40hust.edu.cn
patch subject: [PATCH] clk: mediatek: clk-mt8173: fix memory leak in clk_mt8173_apmixed_probe
config: arm64-randconfig-r011-20230423 (https://download.01.org/0day-ci/archive/20230426/202304260006.3Am8FGjt-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/cb4be4dcd48924984a6d0e3df7809cfc26286032
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ziqin-Liu/clk-mediatek-clk-mt8173-fix-memory-leak-in-clk_mt8173_apmixed_probe/20230425-212917
        git checkout cb4be4dcd48924984a6d0e3df7809cfc26286032
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/clk/mediatek/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304260006.3Am8FGjt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clk/mediatek/clk-mt8173-apmixedsys.c:149:23: error: passing 'struct device' to parameter of incompatible type 'struct device *'; take the address with &
           base = devm_of_iomap(pdev->dev, node, 0, NULL);
                                ^~~~~~~~~
                                &
   include/linux/device.h:241:44: note: passing argument to parameter 'dev' here
   void __iomem *devm_of_iomap(struct device *dev,
                                              ^
   1 error generated.


vim +149 drivers/clk/mediatek/clk-mt8173-apmixedsys.c

   139	
   140	static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
   141	{
   142		const u8 *fhctl_node = "mediatek,mt8173-fhctl";
   143		struct device_node *node = pdev->dev.of_node;
   144		struct clk_hw_onecell_data *clk_data;
   145		void __iomem *base;
   146		struct clk_hw *hw;
   147		int r;
   148	
 > 149		base = devm_of_iomap(pdev->dev, node, 0, NULL);
   150		if (!base)
   151			return PTR_ERR(base);
   152	
   153		clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
   154		if (IS_ERR_OR_NULL(clk_data))
   155			return -ENOMEM;
   156	
   157		fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
   158		r = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
   159					    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
   160		if (r)
   161			goto free_clk_data;
   162	
   163		hw = mtk_clk_register_ref2usb_tx("ref2usb_tx", "clk26m", base + REGOFF_REF2USB);
   164		if (IS_ERR(hw)) {
   165			r = PTR_ERR(hw);
   166			dev_err(&pdev->dev, "Failed to register ref2usb_tx: %d\n", r);
   167			goto unregister_plls;
   168		}
   169		clk_data->hws[CLK_APMIXED_REF2USB_TX] = hw;
   170	
   171		hw = devm_clk_hw_register_divider(&pdev->dev, "hdmi_ref", "tvdpll_594m", 0,
   172						  base + REGOFF_HDMI_REF, 16, 3,
   173						  CLK_DIVIDER_POWER_OF_TWO, NULL);
   174		clk_data->hws[CLK_APMIXED_HDMI_REF] = hw;
   175	
   176		r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
   177		if (r)
   178			goto unregister_ref2usb;
   179	
   180		return 0;
   181	
   182	unregister_ref2usb:
   183		mtk_clk_unregister_ref2usb_tx(clk_data->hws[CLK_APMIXED_REF2USB_TX]);
   184	unregister_plls:
   185		mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
   186					  ARRAY_SIZE(pllfhs), clk_data);
   187	free_clk_data:
   188		mtk_free_clk_data(clk_data);
   189		return r;
   190	}
   191	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
