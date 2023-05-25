Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C07E710255
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 03:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjEYBYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 21:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEYBYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 21:24:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262BDF5;
        Wed, 24 May 2023 18:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684977882; x=1716513882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hFml+IFBGpyck4Ofg1pKOuGV669kPAVkwNRi7Imskrg=;
  b=UkZBq5X3kxJsfctjZeq0tsJGYHfMyN2NP8OOs3tmTHZ0bjTSnYOYI5qy
   l8XFoAaqiSeQ8vq1VLvIBspkPKbxie/Q6zlz1UHLSs6piiu0h01yWPWrD
   ySaRNoN/8SvIDmGT6gWRHJMDdutjPIACzYX6f46hCuq1JD9bYo8HrRi5N
   r9pNQtlChbrjVPoO+RVtSEC4SPuM+ey5biF5bVLa+IqsewgSxo3kCc1KK
   a3TqXrEKpO2KgmYv+CWAIC4jTIAUnFo1VBQyjzjAvR/XE6KUqbr+GZdPt
   hmdmVTfd+tuGDHou26bPjsuThhu4phTk+6yTP1yTKRov3ZLETT49Tx0Vg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="343208103"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="343208103"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 18:24:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769672043"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="769672043"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 May 2023 18:24:29 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1ziO-000FLD-0t;
        Thu, 25 May 2023 01:24:28 +0000
Date:   Thu, 25 May 2023 09:23:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Runyang Chen <runyang.chen@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Runyang Chen <runyang.chen@mediatek.com>
Subject: Re: [PATCH v3 2/2] clk: mediatek: reset: add infra_ao reset support
 for MT8188
Message-ID: <202305250908.Uvas9u4E-lkp@intel.com>
References: <20230524133439.20659-3-runyang.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524133439.20659-3-runyang.chen@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Runyang,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on pza/reset/next]
[cannot apply to pza/imx-drm/next mbgg-mediatek/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Runyang-Chen/dt-bindings-reset-mt8188-add-thermal-reset-control-bit/20230524-213538
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20230524133439.20659-3-runyang.chen%40mediatek.com
patch subject: [PATCH v3 2/2] clk: mediatek: reset: add infra_ao reset support for MT8188
config: riscv-randconfig-r042-20230524 (https://download.01.org/0day-ci/archive/20230525/202305250908.Uvas9u4E-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 4faf3aaf28226a4e950c103a14f6fc1d1fdabb1b)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/7d969d160489d561f9b1fb6388adaa1ba8fe06a1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Runyang-Chen/dt-bindings-reset-mt8188-add-thermal-reset-control-bit/20230524-213538
        git checkout 7d969d160489d561f9b1fb6388adaa1ba8fe06a1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/clk/mediatek/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305250908.Uvas9u4E-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clk/mediatek/clk-mt8188-infra_ao.c:196:18: error: initializing 'u16 *' (aka 'unsigned short *') with an expression of type 'const u16[5]' (aka 'const unsigned short[5]') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           .rst_bank_ofs = infra_ao_rst_ofs,
                           ^~~~~~~~~~~~~~~~
   drivers/clk/mediatek/clk-mt8188-infra_ao.c:198:17: error: initializing 'u16 *' (aka 'unsigned short *') with an expression of type 'const u16[3]' (aka 'const unsigned short[3]') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           .rst_idx_map = infra_ao_idx_map,
                          ^~~~~~~~~~~~~~~~
   2 errors generated.


vim +196 drivers/clk/mediatek/clk-mt8188-infra_ao.c

   193	
   194	static const struct mtk_clk_rst_desc infra_ao_rst_desc = {
   195		.version = MTK_RST_SET_CLR,
 > 196		.rst_bank_ofs = infra_ao_rst_ofs,
   197		.rst_bank_nr = ARRAY_SIZE(infra_ao_rst_ofs),
   198		.rst_idx_map = infra_ao_idx_map,
   199		.rst_idx_map_nr = ARRAY_SIZE(infra_ao_idx_map),
   200	};
   201	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
