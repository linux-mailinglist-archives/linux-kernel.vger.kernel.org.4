Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3524739715
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjFVFyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjFVFyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:54:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F5019F;
        Wed, 21 Jun 2023 22:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687413275; x=1718949275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jy5vFsG2+MNEmk0tpbKWKurn8cOSrOpyMyFkUcj6Vyg=;
  b=k5h4vla+jI1e9ZF9g/LL7/3SRQbvdNeOjEoCOidCU9CvaS9XETBniaPB
   3RCuCAc09ncGJTn62szs74cnALGOxRpEsxd/4mXZxj2TebclUrLivYSpO
   2EZjkpNGOyGekIFhSE1RLgnIfnkcceMYy7V4d9njjBR+F7v9MPaCROy2j
   Bg5p+Vo/jXLjmfp7hf8+dwt3Y7pGwnJfCRe94cPkC30Gw3T83Yfrmlncu
   eoKP/UFTHpQkzubYJYbrG+l9AS+aCqlGIK31xzWWuXs+1b4JR4H/jKvPs
   8Z7TdRV3V+vwptelnuEwTtE5nJH5qOXTWqd+v2Is8D9NIOCERGdlciUnk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="390052297"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="390052297"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 22:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="664909879"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="664909879"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2023 22:54:31 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCDH4-0007Mj-11;
        Thu, 22 Jun 2023 05:54:30 +0000
Date:   Thu, 22 Jun 2023 13:53:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     oe-kbuild-all@lists.linux.dev,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH 3/5] spi: Add support for Renesas CSI
Message-ID: <202306221354.9ZWHS3y1-lkp@intel.com>
References: <20230621140944.257352-4-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621140944.257352-4-fabrizio.castro.jz@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on robh/for-next geert-renesas-drivers/renesas-clk geert-renesas-devel/next arm64/for-next/core linus/master v6.4-rc7 next-20230621]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabrizio-Castro/spi-dt-bindings-Add-bindings-for-RZ-V2M-CSI/20230621-221233
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20230621140944.257352-4-fabrizio.castro.jz%40renesas.com
patch subject: [PATCH 3/5] spi: Add support for Renesas CSI
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20230622/202306221354.9ZWHS3y1-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230622/202306221354.9ZWHS3y1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306221354.9ZWHS3y1-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-rzv2m-csi.c: In function 'rzv2m_csi_probe':
>> drivers/spi/spi-rzv2m-csi.c:608:15: error: implicit declaration of function 'devm_request_irq'; did you mean 'devm_request_region'? [-Werror=implicit-function-declaration]
     608 |         ret = devm_request_irq(dev, irq, rzv2m_csi_irq_handler, 0,
         |               ^~~~~~~~~~~~~~~~
         |               devm_request_region
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
   Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
   Selected by [y]:
   - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]


vim +608 drivers/spi/spi-rzv2m-csi.c

   557	
   558	static int rzv2m_csi_probe(struct platform_device *pdev)
   559	{
   560		struct spi_controller *controller;
   561		struct device *dev = &pdev->dev;
   562		struct rzv2m_csi_priv *csi;
   563		struct reset_control *rstc;
   564		int irq;
   565		int ret;
   566	
   567		controller = devm_spi_alloc_master(dev, sizeof(*csi));
   568		if (!controller)
   569			return -ENOMEM;
   570	
   571		csi = spi_controller_get_devdata(controller);
   572		platform_set_drvdata(pdev, csi);
   573	
   574		csi->dev = dev;
   575		csi->controller = controller;
   576	
   577		csi->base = devm_platform_ioremap_resource(pdev, 0);
   578		if (IS_ERR(csi->base))
   579			return PTR_ERR(csi->base);
   580	
   581		irq = platform_get_irq(pdev, 0);
   582		if (irq < 0)
   583			return irq;
   584	
   585		csi->csiclk = devm_clk_get(dev, "csiclk");
   586		if (IS_ERR(csi->csiclk))
   587			return dev_err_probe(dev, PTR_ERR(csi->csiclk),
   588					     "could not get csiclk\n");
   589	
   590		csi->pclk = devm_clk_get(dev, "pclk");
   591		if (IS_ERR(csi->pclk))
   592			return dev_err_probe(dev, PTR_ERR(csi->pclk),
   593					     "could not get pclk\n");
   594	
   595		rstc = devm_reset_control_get_shared(dev, NULL);
   596		if (IS_ERR(rstc))
   597			return dev_err_probe(dev, PTR_ERR(rstc), "Missing reset ctrl\n");
   598	
   599		init_waitqueue_head(&csi->wait);
   600	
   601		controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
   602		controller->dev.of_node = pdev->dev.of_node;
   603		controller->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
   604		controller->setup = rzv2m_csi_setup;
   605		controller->transfer_one = rzv2m_csi_transfer_one;
   606		controller->use_gpio_descriptors = true;
   607	
 > 608		ret = devm_request_irq(dev, irq, rzv2m_csi_irq_handler, 0,
   609				       dev_name(dev), csi);
   610		if (ret)
   611			return dev_err_probe(dev, ret, "cannot request IRQ\n");
   612	
   613		/*
   614		 * The reset also affects other HW that is not under the control
   615		 * of Linux. Therefore, all we can do is make sure the reset is
   616		 * deasserted.
   617		 */
   618		reset_control_deassert(rstc);
   619	
   620		/* Make sure the IP is in SW reset state */
   621		ret = rzv2m_csi_sw_reset(csi, 1);
   622		if (ret)
   623			return ret;
   624	
   625		ret = clk_prepare_enable(csi->csiclk);
   626		if (ret)
   627			return dev_err_probe(dev, ret, "could not enable csiclk\n");
   628	
   629		ret = spi_register_controller(controller);
   630		if (ret) {
   631			clk_disable_unprepare(csi->csiclk);
   632			return dev_err_probe(dev, ret, "register controller failed\n");
   633		}
   634	
   635		return 0;
   636	}
   637	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
