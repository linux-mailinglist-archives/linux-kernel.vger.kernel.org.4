Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC946D1FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjCaMPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjCaMPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:15:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC01D1DF90;
        Fri, 31 Mar 2023 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680264940; x=1711800940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MDqfavBp0xhE9zr6CTvKsp9hMprvzZOnmnyhz/PHj+8=;
  b=XdyqMmaxy9mdQX8UmVRgRM3gEEcYc+Zis2igX6pWfcLhertv0EzzwRQ4
   JR3Cu/aszxmoDw2NKhUBGMW4fmCZWcD/ZtdkZuWPwuZWEADt3SP5mtKla
   uzQLOXpgwlFIexyxHlWKxsgHX28ghfh2WfBVjjabHuufIzDImOxnGeHzv
   dgZ9kDWH5u7flPd6T8r2ajxIZfjpReXOmB40LirkKM36G0H1YcXVJWSJ0
   mvGTkmDPyRBY4nxWYx/TuHbQjyEeWfUFT/utT5Ua+79wMxL9/Z5tmx4y9
   8h/UUreewXZuyZkvET7q2QB43D7TmNgSdwgmWJtywMU07fH48GZqyHl0U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="404155580"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="404155580"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 05:15:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="809018313"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="809018313"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2023 05:15:36 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piDfL-000LlO-1i;
        Fri, 31 Mar 2023 12:15:35 +0000
Date:   Fri, 31 Mar 2023 20:14:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, abelvesa@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 4/6] clk: imx: fracn-gppll: support integer pll
Message-ID: <202303312017.I9c9cLVj-lkp@intel.com>
References: <20230331064629.2475338-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331064629.2475338-5-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
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
config: hexagon-randconfig-r045-20230329 (https://download.01.org/0day-ci/archive/20230331/202303312017.I9c9cLVj-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b80cff81a332a2005b90c5c1fbab96e732c03494
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/clk-imx-fracn-gppll-fix-the-rate-table/20230331-144314
        git checkout b80cff81a332a2005b90c5c1fbab96e732c03494
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/clk/imx/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303312017.I9c9cLVj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/imx/clk-fracn-gppll.c:10:
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
   In file included from drivers/clk/imx/clk-fracn-gppll.c:10:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/clk/imx/clk-fracn-gppll.c:10:
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
>> drivers/clk/imx/clk-fracn-gppll.c:340:16: warning: no previous prototype for function '_imx_clk_fracn_gppll' [-Wmissing-prototypes]
   struct clk_hw *_imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
                  ^
   drivers/clk/imx/clk-fracn-gppll.c:340:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct clk_hw *_imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
   ^
   static 
   7 warnings generated.


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
