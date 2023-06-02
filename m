Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A515720227
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjFBMf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbjFBMf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:35:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230E918C;
        Fri,  2 Jun 2023 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685709325; x=1717245325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RFn4lE0CnHg+BrpP8BhtcKygS1L2eOihwOiPLsc1C4Y=;
  b=a4+vzQw4d8FHqp8ptwFER1BFbTbiYG2oJ+d+BfVy8OgCiaSQVpn8UnXT
   8lUeUHxSzSGAMlpjqgmBGbwelTB2gp2RfqTwVPu5oD2LsMrKbogKj3nD5
   s4ddlGLMPe43zImRnDyl3Lx45LyTsRo3IZvy3ry8g/D2THg8Pf/8uQ6Zj
   CG8X5pBB0DowR/t+VqsLkcHdQ5Xsy6jQVlloAV2DP0zS6OpO5R/TVioGI
   LRsW3onPt7o9l+iFzGgmHoIJRWZ0uSsvnpl2tR3nWYf8hJcluTmc38dP0
   XKA+M0zJah0DZK5lOdl/N9eOlkzrSXGJx39jLplhUzhbENWll5imIRetQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="353352674"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="353352674"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 05:34:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="737515174"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="737515174"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Jun 2023 05:34:30 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q53zB-0000RJ-16;
        Fri, 02 Jun 2023 12:34:29 +0000
Date:   Fri, 2 Jun 2023 20:33:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>
Subject: Re: [PATCH v2 2/3] spi: cadence-quadspi: Add clock configuration for
 StarFive JH7110 QSPI
Message-ID: <202306022017.UbwjjWRN-lkp@intel.com>
References: <20230602084925.215411-3-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602084925.215411-3-william.qiu@starfivetech.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on linus/master v6.4-rc4 next-20230602]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/William-Qiu/dt-bindings-qspi-cdns-qspi-nor-Add-clocks-for-StarFive-JH7110-SoC/20230602-165251
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20230602084925.215411-3-william.qiu%40starfivetech.com
patch subject: [PATCH v2 2/3] spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20230602/202306022017.UbwjjWRN-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6bbd49e32d407d210b6ea322696cef2e49bf3fa1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review William-Qiu/dt-bindings-qspi-cdns-qspi-nor-Add-clocks-for-StarFive-JH7110-SoC/20230602-165251
        git checkout 6bbd49e32d407d210b6ea322696cef2e49bf3fa1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306022017.UbwjjWRN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spi/spi-cadence-quadspi.c: In function 'cqspi_resume':
>> drivers/spi/spi-cadence-quadspi.c:1873:17: warning: ignoring return value of 'clk_bulk_prepare_enable' declared with attribute 'warn_unused_result' [-Wunused-result]
    1873 |                 clk_bulk_prepare_enable(cqspi->num_clks, cqspi->clks);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1873 drivers/spi/spi-cadence-quadspi.c

  1865	
  1866	static int cqspi_resume(struct device *dev)
  1867	{
  1868		struct cqspi_st *cqspi = dev_get_drvdata(dev);
  1869		struct spi_master *master = dev_get_drvdata(dev);
  1870	
  1871		clk_prepare_enable(cqspi->clk);
  1872		if (of_device_is_compatible(dev->of_node, "starfive,jh7110-qspi"))
> 1873			clk_bulk_prepare_enable(cqspi->num_clks, cqspi->clks);
  1874		cqspi_wait_idle(cqspi);
  1875		cqspi_controller_init(cqspi);
  1876	
  1877		cqspi->current_cs = -1;
  1878		cqspi->sclk = 0;
  1879	
  1880		return spi_master_resume(master);
  1881	}
  1882	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
