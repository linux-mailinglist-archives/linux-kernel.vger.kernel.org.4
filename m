Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4B85B9C84
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiIOOD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiIOODv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:03:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C041F9AFD7;
        Thu, 15 Sep 2022 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663250629; x=1694786629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LT8k6IODhbyvj0PRs1smEf9taZdf3dNxMQJebj7nVkY=;
  b=E6bboFiuEbcPq2rYHC+ktO5no0ItLl8/KjtrDedJgnreF8xuc0X33o43
   2reuGiEkPeYGe8rm6oZp5Tg9tlLYXPGR4q3x5mpLnpD7V3jSgpN15ndSk
   M6enGdKzeQduWH75kwq+OqHwljnMT1DneOCwzes6foplhkJAD5FGIggqC
   2vrzGGz7ax7GiFd0zKmOiPUzVMatq/Ffe26KNKfbBIeJ6PTPTALVLfJ3z
   6Z+d+IZvOBjUWlGSOPuReeauxmimiKv+eFfOfEP8ClaBOis3lH7V/a+Uw
   DfJTQHWuKycGea8CdOtkDnb4ddMZhfRprVX/Z26LfoHVgNJnytJXLBn+m
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="297447162"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="297447162"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 07:03:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="650482801"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Sep 2022 07:03:14 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYpST-0000dp-17;
        Thu, 15 Sep 2022 14:03:13 +0000
Date:   Thu, 15 Sep 2022 22:02:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Han Xu <han.xu@nxp.com>, Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:NXP i.MX CLOCK DRIVERS" <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        han.xu@nxp.com
Subject: Re: [PATCH] clk: imx: imx6sx: remove the SET_RATE_PARENT flag for
 QSPI clocks
Message-ID: <202209152102.e3II8r5e-lkp@intel.com>
References: <20220914201049.3508104-2-han.xu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914201049.3508104-2-han.xu@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Han,

I love your patch! Yet something to improve:

[auto build test ERROR on abelvesa/clk/imx]
[also build test ERROR on clk/clk-next shawnguo/for-next linus/master v6.0-rc5 next-20220915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Han-Xu/clk-imx-imx6sx-remove-the-SET_RATE_PARENT-flag-for-QSPI-clocks/20220915-041341
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
config: arm-randconfig-r035-20220914 (https://download.01.org/0day-ci/archive/20220915/202209152102.e3II8r5e-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/d246f7033318f9fc1ef41666c450034ad8de6916
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Han-Xu/clk-imx-imx6sx-remove-the-SET_RATE_PARENT-flag-for-QSPI-clocks/20220915-041341
        git checkout d246f7033318f9fc1ef41666c450034ad8de6916
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/clk/imx/clk-imx6sx.c:283:39: error: unterminated function-like macro invocation
           hws[IMX6SX_CLK_QSPI1_SEL]          = imx_clk_hw_mux("qspi1_sel",        base + 0x1c,  7,      3,      qspi1_sels,        ARRAY_SIZE(qspi1_sels);
                                                ^
   drivers/clk/imx/clk.h:198:9: note: macro 'imx_clk_hw_mux' defined here
   #define imx_clk_hw_mux(name, reg, shift, width, parents, num_parents) \
           ^
>> drivers/clk/imx/clk-imx6sx.c:553:62: error: expected expression
   CLK_OF_DECLARE(imx6sx, "fsl,imx6sx-ccm", imx6sx_clocks_init);
                                                                ^
>> drivers/clk/imx/clk-imx6sx.c:553:62: error: expected '}'
   drivers/clk/imx/clk-imx6sx.c:121:1: note: to match this '{'
   {
   ^
   3 errors generated.


vim +283 drivers/clk/imx/clk-imx6sx.c

   119	
   120	static void __init imx6sx_clocks_init(struct device_node *ccm_node)
   121	{
   122		struct device_node *np;
   123		void __iomem *base;
   124	
   125		clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
   126						  IMX6SX_CLK_CLK_END), GFP_KERNEL);
   127		if (WARN_ON(!clk_hw_data))
   128			return;
   129	
   130		clk_hw_data->num = IMX6SX_CLK_CLK_END;
   131		hws = clk_hw_data->hws;
   132	
   133		hws[IMX6SX_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0);
   134	
   135		hws[IMX6SX_CLK_CKIL] = imx_obtain_fixed_clk_hw(ccm_node, "ckil");
   136		hws[IMX6SX_CLK_OSC] = imx_obtain_fixed_clk_hw(ccm_node, "osc");
   137	
   138		/* ipp_di clock is external input */
   139		hws[IMX6SX_CLK_IPP_DI0] = imx_obtain_fixed_clk_hw(ccm_node, "ipp_di0");
   140		hws[IMX6SX_CLK_IPP_DI1] = imx_obtain_fixed_clk_hw(ccm_node, "ipp_di1");
   141	
   142		/* Clock source from external clock via CLK1/2 PAD */
   143		hws[IMX6SX_CLK_ANACLK1] = imx_obtain_fixed_clk_hw(ccm_node, "anaclk1");
   144		hws[IMX6SX_CLK_ANACLK2] = imx_obtain_fixed_clk_hw(ccm_node, "anaclk2");
   145	
   146		np = of_find_compatible_node(NULL, NULL, "fsl,imx6sx-anatop");
   147		base = of_iomap(np, 0);
   148		WARN_ON(!base);
   149		of_node_put(np);
   150	
   151		hws[IMX6SX_PLL1_BYPASS_SRC] = imx_clk_hw_mux("pll1_bypass_src", base + 0x00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
   152		hws[IMX6SX_PLL2_BYPASS_SRC] = imx_clk_hw_mux("pll2_bypass_src", base + 0x30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
   153		hws[IMX6SX_PLL3_BYPASS_SRC] = imx_clk_hw_mux("pll3_bypass_src", base + 0x10, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
   154		hws[IMX6SX_PLL4_BYPASS_SRC] = imx_clk_hw_mux("pll4_bypass_src", base + 0x70, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
   155		hws[IMX6SX_PLL5_BYPASS_SRC] = imx_clk_hw_mux("pll5_bypass_src", base + 0xa0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
   156		hws[IMX6SX_PLL6_BYPASS_SRC] = imx_clk_hw_mux("pll6_bypass_src", base + 0xe0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
   157		hws[IMX6SX_PLL7_BYPASS_SRC] = imx_clk_hw_mux("pll7_bypass_src", base + 0x20, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
   158	
   159		/*                                    type               name    parent_name        base         div_mask */
   160		hws[IMX6SX_CLK_PLL1] = imx_clk_hw_pllv3(IMX_PLLV3_SYS,     "pll1", "osc", base + 0x00, 0x7f);
   161		hws[IMX6SX_CLK_PLL2] = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc", base + 0x30, 0x1);
   162		hws[IMX6SX_CLK_PLL3] = imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll3", "osc", base + 0x10, 0x3);
   163		hws[IMX6SX_CLK_PLL4] = imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll4", "osc", base + 0x70, 0x7f);
   164		hws[IMX6SX_CLK_PLL5] = imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll5", "osc", base + 0xa0, 0x7f);
   165		hws[IMX6SX_CLK_PLL6] = imx_clk_hw_pllv3(IMX_PLLV3_ENET,    "pll6", "osc", base + 0xe0, 0x3);
   166		hws[IMX6SX_CLK_PLL7] = imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll7", "osc", base + 0x20, 0x3);
   167	
   168		hws[IMX6SX_PLL1_BYPASS] = imx_clk_hw_mux_flags("pll1_bypass", base + 0x00, 16, 1, pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PARENT);
   169		hws[IMX6SX_PLL2_BYPASS] = imx_clk_hw_mux_flags("pll2_bypass", base + 0x30, 16, 1, pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PARENT);
   170		hws[IMX6SX_PLL3_BYPASS] = imx_clk_hw_mux_flags("pll3_bypass", base + 0x10, 16, 1, pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PARENT);
   171		hws[IMX6SX_PLL4_BYPASS] = imx_clk_hw_mux_flags("pll4_bypass", base + 0x70, 16, 1, pll4_bypass_sels, ARRAY_SIZE(pll4_bypass_sels), CLK_SET_RATE_PARENT);
   172		hws[IMX6SX_PLL5_BYPASS] = imx_clk_hw_mux_flags("pll5_bypass", base + 0xa0, 16, 1, pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PARENT);
   173		hws[IMX6SX_PLL6_BYPASS] = imx_clk_hw_mux_flags("pll6_bypass", base + 0xe0, 16, 1, pll6_bypass_sels, ARRAY_SIZE(pll6_bypass_sels), CLK_SET_RATE_PARENT);
   174		hws[IMX6SX_PLL7_BYPASS] = imx_clk_hw_mux_flags("pll7_bypass", base + 0x20, 16, 1, pll7_bypass_sels, ARRAY_SIZE(pll7_bypass_sels), CLK_SET_RATE_PARENT);
   175	
   176		/* Do not bypass PLLs initially */
   177		clk_set_parent(hws[IMX6SX_PLL1_BYPASS]->clk, hws[IMX6SX_CLK_PLL1]->clk);
   178		clk_set_parent(hws[IMX6SX_PLL2_BYPASS]->clk, hws[IMX6SX_CLK_PLL2]->clk);
   179		clk_set_parent(hws[IMX6SX_PLL3_BYPASS]->clk, hws[IMX6SX_CLK_PLL3]->clk);
   180		clk_set_parent(hws[IMX6SX_PLL4_BYPASS]->clk, hws[IMX6SX_CLK_PLL4]->clk);
   181		clk_set_parent(hws[IMX6SX_PLL5_BYPASS]->clk, hws[IMX6SX_CLK_PLL5]->clk);
   182		clk_set_parent(hws[IMX6SX_PLL6_BYPASS]->clk, hws[IMX6SX_CLK_PLL6]->clk);
   183		clk_set_parent(hws[IMX6SX_PLL7_BYPASS]->clk, hws[IMX6SX_CLK_PLL7]->clk);
   184	
   185		hws[IMX6SX_CLK_PLL1_SYS]      = imx_clk_hw_gate("pll1_sys",      "pll1_bypass", base + 0x00, 13);
   186		hws[IMX6SX_CLK_PLL2_BUS]      = imx_clk_hw_gate("pll2_bus",      "pll2_bypass", base + 0x30, 13);
   187		hws[IMX6SX_CLK_PLL3_USB_OTG]  = imx_clk_hw_gate("pll3_usb_otg",  "pll3_bypass", base + 0x10, 13);
   188		hws[IMX6SX_CLK_PLL4_AUDIO]    = imx_clk_hw_gate("pll4_audio",    "pll4_bypass", base + 0x70, 13);
   189		hws[IMX6SX_CLK_PLL5_VIDEO]    = imx_clk_hw_gate("pll5_video",    "pll5_bypass", base + 0xa0, 13);
   190		hws[IMX6SX_CLK_PLL6_ENET]     = imx_clk_hw_gate("pll6_enet",     "pll6_bypass", base + 0xe0, 13);
   191		hws[IMX6SX_CLK_PLL7_USB_HOST] = imx_clk_hw_gate("pll7_usb_host", "pll7_bypass", base + 0x20, 13);
   192	
   193		/*
   194		 * Bit 20 is the reserved and read-only bit, we do this only for:
   195		 * - Do nothing for usbphy clk_enable/disable
   196		 * - Keep refcount when do usbphy clk_enable/disable, in that case,
   197		 * the clk framework may need to enable/disable usbphy's parent
   198		 */
   199		hws[IMX6SX_CLK_USBPHY1] = imx_clk_hw_gate("usbphy1", "pll3_usb_otg",  base + 0x10, 20);
   200		hws[IMX6SX_CLK_USBPHY2] = imx_clk_hw_gate("usbphy2", "pll7_usb_host", base + 0x20, 20);
   201	
   202		/*
   203		 * usbphy*_gate needs to be on after system boots up, and software
   204		 * never needs to control it anymore.
   205		 */
   206		hws[IMX6SX_CLK_USBPHY1_GATE] = imx_clk_hw_gate("usbphy1_gate", "dummy", base + 0x10, 6);
   207		hws[IMX6SX_CLK_USBPHY2_GATE] = imx_clk_hw_gate("usbphy2_gate", "dummy", base + 0x20, 6);
   208	
   209		/* FIXME 100MHz is used for pcie ref for all imx6 pcie, excepted imx6q */
   210		hws[IMX6SX_CLK_PCIE_REF] = imx_clk_hw_fixed_factor("pcie_ref", "pll6_enet", 1, 5);
   211		hws[IMX6SX_CLK_PCIE_REF_125M] = imx_clk_hw_gate("pcie_ref_125m", "pcie_ref", base + 0xe0, 19);
   212	
   213		hws[IMX6SX_CLK_LVDS1_OUT] = imx_clk_hw_gate_exclusive("lvds1_out", "lvds1_sel", base + 0x160, 10, BIT(12));
   214		hws[IMX6SX_CLK_LVDS2_OUT] = imx_clk_hw_gate_exclusive("lvds2_out", "lvds2_sel", base + 0x160, 11, BIT(13));
   215		hws[IMX6SX_CLK_LVDS1_IN]  = imx_clk_hw_gate_exclusive("lvds1_in",  "anaclk1",   base + 0x160, 12, BIT(10));
   216		hws[IMX6SX_CLK_LVDS2_IN]  = imx_clk_hw_gate_exclusive("lvds2_in",  "anaclk2",   base + 0x160, 13, BIT(11));
   217	
   218		hws[IMX6SX_CLK_ENET_REF] = clk_hw_register_divider_table(NULL, "enet_ref", "pll6_enet", 0,
   219				base + 0xe0, 0, 2, 0, clk_enet_ref_table,
   220				&imx_ccm_lock);
   221		hws[IMX6SX_CLK_ENET2_REF] = clk_hw_register_divider_table(NULL, "enet2_ref", "pll6_enet", 0,
   222				base + 0xe0, 2, 2, 0, clk_enet_ref_table,
   223				&imx_ccm_lock);
   224		hws[IMX6SX_CLK_ENET2_REF_125M] = imx_clk_hw_gate("enet2_ref_125m", "enet2_ref", base + 0xe0, 20);
   225	
   226		hws[IMX6SX_CLK_ENET_PTP_REF] = imx_clk_hw_fixed_factor("enet_ptp_ref", "pll6_enet", 1, 20);
   227		hws[IMX6SX_CLK_ENET_PTP] = imx_clk_hw_gate("enet_ptp_25m", "enet_ptp_ref", base + 0xe0, 21);
   228	
   229		/*                                       name              parent_name     reg           idx */
   230		hws[IMX6SX_CLK_PLL2_PFD0] = imx_clk_hw_pfd("pll2_pfd0_352m", "pll2_bus",     base + 0x100, 0);
   231		hws[IMX6SX_CLK_PLL2_PFD1] = imx_clk_hw_pfd("pll2_pfd1_594m", "pll2_bus",     base + 0x100, 1);
   232		hws[IMX6SX_CLK_PLL2_PFD2] = imx_clk_hw_pfd("pll2_pfd2_396m", "pll2_bus",     base + 0x100, 2);
   233		hws[IMX6SX_CLK_PLL2_PFD3] = imx_clk_hw_pfd("pll2_pfd3_594m", "pll2_bus",     base + 0x100, 3);
   234		hws[IMX6SX_CLK_PLL3_PFD0] = imx_clk_hw_pfd("pll3_pfd0_720m", "pll3_usb_otg", base + 0xf0,  0);
   235		hws[IMX6SX_CLK_PLL3_PFD1] = imx_clk_hw_pfd("pll3_pfd1_540m", "pll3_usb_otg", base + 0xf0,  1);
   236		hws[IMX6SX_CLK_PLL3_PFD2] = imx_clk_hw_pfd("pll3_pfd2_508m", "pll3_usb_otg", base + 0xf0,  2);
   237		hws[IMX6SX_CLK_PLL3_PFD3] = imx_clk_hw_pfd("pll3_pfd3_454m", "pll3_usb_otg", base + 0xf0,  3);
   238	
   239		/*                                                name         parent_name       mult div */
   240		hws[IMX6SX_CLK_PLL2_198M] = imx_clk_hw_fixed_factor("pll2_198m", "pll2_pfd2_396m", 1,   2);
   241		hws[IMX6SX_CLK_PLL3_120M] = imx_clk_hw_fixed_factor("pll3_120m", "pll3_usb_otg",   1,   4);
   242		hws[IMX6SX_CLK_PLL3_80M]  = imx_clk_hw_fixed_factor("pll3_80m",  "pll3_usb_otg",   1,   6);
   243		hws[IMX6SX_CLK_PLL3_60M]  = imx_clk_hw_fixed_factor("pll3_60m",  "pll3_usb_otg",   1,   8);
   244		hws[IMX6SX_CLK_TWD]       = imx_clk_hw_fixed_factor("twd",       "arm",            1,   2);
   245		hws[IMX6SX_CLK_GPT_3M]    = imx_clk_hw_fixed_factor("gpt_3m",    "osc",            1,   8);
   246	
   247		hws[IMX6SX_CLK_PLL4_POST_DIV]  = clk_hw_register_divider_table(NULL, "pll4_post_div", "pll4_audio",
   248					CLK_SET_RATE_PARENT, base + 0x70, 19, 2, 0, post_div_table, &imx_ccm_lock);
   249		hws[IMX6SX_CLK_PLL4_AUDIO_DIV] = clk_hw_register_divider(NULL, "pll4_audio_div", "pll4_post_div",
   250					CLK_SET_RATE_PARENT, base + 0x170, 15, 1, 0, &imx_ccm_lock);
   251		hws[IMX6SX_CLK_PLL5_POST_DIV]  = clk_hw_register_divider_table(NULL, "pll5_post_div", "pll5_video",
   252					CLK_SET_RATE_PARENT, base + 0xa0, 19, 2, 0, post_div_table, &imx_ccm_lock);
   253		hws[IMX6SX_CLK_PLL5_VIDEO_DIV] = clk_hw_register_divider_table(NULL, "pll5_video_div", "pll5_post_div",
   254					CLK_SET_RATE_PARENT, base + 0x170, 30, 2, 0, video_div_table, &imx_ccm_lock);
   255	
   256		/*                                                name                reg           shift   width   parent_names       num_parents */
   257		hws[IMX6SX_CLK_LVDS1_SEL]          = imx_clk_hw_mux("lvds1_sel",        base + 0x160, 0,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
   258		hws[IMX6SX_CLK_LVDS2_SEL]          = imx_clk_hw_mux("lvds2_sel",        base + 0x160, 5,      5,      lvds_sels,         ARRAY_SIZE(lvds_sels));
   259	
   260		np = ccm_node;
   261		base = of_iomap(np, 0);
   262		WARN_ON(!base);
   263	
   264		/*                                                name                reg           shift   width   parent_names       num_parents */
   265		hws[IMX6SX_CLK_STEP]               = imx_clk_hw_mux("step",             base + 0xc,   8,      1,      step_sels,         ARRAY_SIZE(step_sels));
   266		hws[IMX6SX_CLK_PLL1_SW]            = imx_clk_hw_mux("pll1_sw",          base + 0xc,   2,      1,      pll1_sw_sels,      ARRAY_SIZE(pll1_sw_sels));
   267		hws[IMX6SX_CLK_OCRAM_SEL]          = imx_clk_hw_mux("ocram_sel",        base + 0x14,  6,      2,      ocram_sels,        ARRAY_SIZE(ocram_sels));
   268		hws[IMX6SX_CLK_PERIPH_PRE]         = imx_clk_hw_mux("periph_pre",       base + 0x18,  18,     2,      periph_pre_sels,   ARRAY_SIZE(periph_pre_sels));
   269		hws[IMX6SX_CLK_PERIPH2_PRE]        = imx_clk_hw_mux("periph2_pre",      base + 0x18,  21,     2,      periph2_pre_sels,   ARRAY_SIZE(periph2_pre_sels));
   270		hws[IMX6SX_CLK_PERIPH_CLK2_SEL]    = imx_clk_hw_mux("periph_clk2_sel",  base + 0x18,  12,     2,      periph_clk2_sels,  ARRAY_SIZE(periph_clk2_sels));
   271		hws[IMX6SX_CLK_PERIPH2_CLK2_SEL]   = imx_clk_hw_mux("periph2_clk2_sel", base + 0x18,  20,     1,      periph2_clk2_sels, ARRAY_SIZE(periph2_clk2_sels));
   272		hws[IMX6SX_CLK_PCIE_AXI_SEL]       = imx_clk_hw_mux("pcie_axi_sel",     base + 0x18,  10,     1,      pcie_axi_sels,     ARRAY_SIZE(pcie_axi_sels));
   273		hws[IMX6SX_CLK_GPU_AXI_SEL]        = imx_clk_hw_mux("gpu_axi_sel",      base + 0x18,  8,      2,      gpu_axi_sels,      ARRAY_SIZE(gpu_axi_sels));
   274		hws[IMX6SX_CLK_GPU_CORE_SEL]       = imx_clk_hw_mux("gpu_core_sel",     base + 0x18,  4,      2,      gpu_core_sels,     ARRAY_SIZE(gpu_core_sels));
   275		hws[IMX6SX_CLK_EIM_SLOW_SEL]       = imx_clk_hw_mux("eim_slow_sel",     base + 0x1c,  29,     2,      eim_slow_sels,     ARRAY_SIZE(eim_slow_sels));
   276		hws[IMX6SX_CLK_USDHC1_SEL]         = imx_clk_hw_mux("usdhc1_sel",       base + 0x1c,  16,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
   277		hws[IMX6SX_CLK_USDHC2_SEL]         = imx_clk_hw_mux("usdhc2_sel",       base + 0x1c,  17,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
   278		hws[IMX6SX_CLK_USDHC3_SEL]         = imx_clk_hw_mux("usdhc3_sel",       base + 0x1c,  18,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
   279		hws[IMX6SX_CLK_USDHC4_SEL]         = imx_clk_hw_mux("usdhc4_sel",       base + 0x1c,  19,     1,      usdhc_sels,        ARRAY_SIZE(usdhc_sels));
   280		hws[IMX6SX_CLK_SSI3_SEL]           = imx_clk_hw_mux("ssi3_sel",         base + 0x1c,  14,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
   281		hws[IMX6SX_CLK_SSI2_SEL]           = imx_clk_hw_mux("ssi2_sel",         base + 0x1c,  12,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
   282		hws[IMX6SX_CLK_SSI1_SEL]           = imx_clk_hw_mux("ssi1_sel",         base + 0x1c,  10,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
 > 283		hws[IMX6SX_CLK_QSPI1_SEL]          = imx_clk_hw_mux("qspi1_sel",        base + 0x1c,  7,      3,      qspi1_sels,        ARRAY_SIZE(qspi1_sels);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
