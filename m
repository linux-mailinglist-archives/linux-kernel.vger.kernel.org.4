Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEA4722147
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjFEIoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjFEIoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:44:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22B8CD;
        Mon,  5 Jun 2023 01:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685954639; x=1717490639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZKd1hojcEofK8WgGk5N5pRnS4q4s9sbyMNImCRd9UFk=;
  b=No7eyxf1TBfHbNvYBLrWeXeFa7NGZMCPqMnYhcZhieyb9xnjGVEZ3Ai9
   lEKYD8qBoRV1reOjfh7E0byobdHwfuxrTx0FCPmVhY+yyemoF+Rjv2ZL+
   aMBwDSzjj6FGnTD4mY5dmBMR26spboF9UB7g6WAr+7KZtk7evwjkdGB1g
   zq+dsDFkK/iHmNI8mzK7eT/ZhHY+v/x5qsdQL5u/HlmYp46NaKp2W63GW
   2yMBTSn+QXTWkI3wvh18a0PPdaXD+/sViufmXCo0xz5sSgx1obwBSn2Uh
   Ldqejq3OC0QTDk1S14g76lJ2TCE9/svMar7A3tUBnQL2LBL/oHyBII98j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="356327448"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="356327448"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 01:43:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="798340337"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="798340337"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jun 2023 01:43:54 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q65of-00042B-25;
        Mon, 05 Jun 2023 08:43:53 +0000
Date:   Mon, 5 Jun 2023 16:43:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Wenbin Mei <wenbin.mei@mediatek.com>
Subject: Re: [PATCH v3] mmc: mtk-sd: reduce CIT for better performance
Message-ID: <202306051634.orHLaQ9t-lkp@intel.com>
References: <20230605060107.22044-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605060107.22044-1-wenbin.mei@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenbin,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on ulf-hansson-mmc-mirror/next v6.4-rc5 next-20230605]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wenbin-Mei/mmc-mtk-sd-reduce-CIT-for-better-performance/20230605-140238
base:   linus/master
patch link:    https://lore.kernel.org/r/20230605060107.22044-1-wenbin.mei%40mediatek.com
patch subject: [PATCH v3] mmc: mtk-sd: reduce CIT for better performance
config: x86_64-randconfig-a004-20230605 (https://download.01.org/0day-ci/archive/20230605/202306051634.orHLaQ9t-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/225e46f420d48f7ad73253636a0553bd5f986435
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wenbin-Mei/mmc-mtk-sd-reduce-CIT-for-better-performance/20230605-140238
        git checkout 225e46f420d48f7ad73253636a0553bd5f986435
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306051634.orHLaQ9t-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/host/mtk-sd.c:2489:4: error: expected expression
           } else {
             ^
>> drivers/mmc/host/mtk-sd.c:2495:1: error: function definition is not allowed here
   {
   ^
   drivers/mmc/host/mtk-sd.c:2513:1: error: function definition is not allowed here
   {
   ^
   drivers/mmc/host/mtk-sd.c:2539:1: error: function definition is not allowed here
   {
   ^
   drivers/mmc/host/mtk-sd.c:2549:1: error: function definition is not allowed here
   {
   ^
>> drivers/mmc/host/mtk-sd.c:2577:20: error: use of undeclared identifier 'msdc_cqe_enable'
           .enable         = msdc_cqe_enable,
                             ^
>> drivers/mmc/host/mtk-sd.c:2578:20: error: use of undeclared identifier 'msdc_cqe_disable'
           .disable        = msdc_cqe_disable,
                             ^
>> drivers/mmc/host/mtk-sd.c:2579:16: error: use of undeclared identifier 'msdc_cqe_pre_enable'; did you mean 'msdc_cqe_cit_cal'?
           .pre_enable = msdc_cqe_pre_enable,
                         ^~~~~~~~~~~~~~~~~~~
                         msdc_cqe_cit_cal
   drivers/mmc/host/mtk-sd.c:2454:13: note: 'msdc_cqe_cit_cal' declared here
   static void msdc_cqe_cit_cal(struct msdc_host *host, u64 timer_ns)
               ^
>> drivers/mmc/host/mtk-sd.c:2580:18: error: use of undeclared identifier 'msdc_cqe_post_disable'
           .post_disable = msdc_cqe_post_disable,
                           ^
   drivers/mmc/host/mtk-sd.c:2585:1: error: function definition is not allowed here
   {
   ^
   drivers/mmc/host/mtk-sd.c:2616:1: error: function definition is not allowed here
   {
   ^
   drivers/mmc/host/mtk-sd.c:2668:1: error: function definition is not allowed here
   {
   ^
   drivers/mmc/host/mtk-sd.c:2892:1: error: function definition is not allowed here
   {
   ^
   drivers/mmc/host/mtk-sd.c:2920:1: error: function definition is not allowed here
   {
   ^
   drivers/mmc/host/mtk-sd.c:2947:1: error: function definition is not allowed here
   {
   ^
   drivers/mmc/host/mtk-sd.c:2978:1: error: function definition is not allowed here
   {
   ^
   drivers/mmc/host/mtk-sd.c:2997:1: error: function definition is not allowed here
   {
   ^
   drivers/mmc/host/mtk-sd.c:3016:1: error: function definition is not allowed here
   {
   ^
   drivers/mmc/host/mtk-sd.c:3041:1: error: function definition is not allowed here
   {
   ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +2489 drivers/mmc/host/mtk-sd.c

  2453	
  2454	static void msdc_cqe_cit_cal(struct msdc_host *host, u64 timer_ns)
  2455	{
  2456		struct mmc_host *mmc = mmc_from_priv(host);
  2457		struct cqhci_host *cq_host = mmc->cqe_private;
  2458		u8 itcfmul;
  2459		u32 hclk_freq;
  2460		u64 value;
  2461	
  2462		/* Since MSDC CQE uses msdc_hclk as ITCFVAL, so driver should use hclk
  2463		 * frequency to get the actual time for CIT.
  2464		 */
  2465		if (host->h_clk) {
  2466			hclk_freq = clk_get_rate(host->h_clk);
  2467			itcfmul = CQHCI_CAP_ITCFMUL(cqhci_readl(cq_host, CQHCI_CAP));
  2468			switch (itcfmul) {
  2469			case 0x0:
  2470				do_div(hclk_freq, 1000);
  2471				break;
  2472			case 0x1:
  2473				do_div(hclk_freq, 100);
  2474				break;
  2475			case 0x2:
  2476				do_div(hclk_freq, 10);
  2477				break;
  2478			case 0x3:
  2479				break;
  2480			case 0x4:
  2481				hclk_freq = hclk_freq * 10;
  2482				break;
  2483			default:
  2484				host->cq_ssc1_time = 0x40;
  2485				return;
  2486			value = hclk_freq * timer_ns;
  2487			do_div(value, 1000000000ULL);
  2488			host->cq_ssc1_time = value;
> 2489		} else {
  2490			host->cq_ssc1_time = 0x40;
  2491		}
  2492	}
  2493	
  2494	static void msdc_cqe_enable(struct mmc_host *mmc)
> 2495	{
  2496		struct msdc_host *host = mmc_priv(mmc);
  2497		struct cqhci_host *cq_host = mmc->cqe_private;
  2498	
  2499		/* enable cmdq irq */
  2500		writel(MSDC_INT_CMDQ, host->base + MSDC_INTEN);
  2501		/* enable busy check */
  2502		sdr_set_bits(host->base + MSDC_PATCH_BIT1, MSDC_PB1_BUSY_CHECK_SEL);
  2503		/* default write data / busy timeout 20s */
  2504		msdc_set_busy_timeout(host, 20 * 1000000000ULL, 0);
  2505		/* default read data timeout 1s */
  2506		msdc_set_timeout(host, 1000000000ULL, 0);
  2507	
  2508		/* Set the send status command idle timer */
  2509		cqhci_writel(cq_host, host->cq_ssc1_time, CQHCI_SSC1);
  2510	}
  2511	
  2512	static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
  2513	{
  2514		struct msdc_host *host = mmc_priv(mmc);
  2515		unsigned int val = 0;
  2516	
  2517		/* disable cmdq irq */
  2518		sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INT_CMDQ);
  2519		/* disable busy check */
  2520		sdr_clr_bits(host->base + MSDC_PATCH_BIT1, MSDC_PB1_BUSY_CHECK_SEL);
  2521	
  2522		val = readl(host->base + MSDC_INT);
  2523		writel(val, host->base + MSDC_INT);
  2524	
  2525		if (recovery) {
  2526			sdr_set_field(host->base + MSDC_DMA_CTRL,
  2527				      MSDC_DMA_CTRL_STOP, 1);
  2528			if (WARN_ON(readl_poll_timeout(host->base + MSDC_DMA_CTRL, val,
  2529				!(val & MSDC_DMA_CTRL_STOP), 1, 3000)))
  2530				return;
  2531			if (WARN_ON(readl_poll_timeout(host->base + MSDC_DMA_CFG, val,
  2532				!(val & MSDC_DMA_CFG_STS), 1, 3000)))
  2533				return;
  2534			msdc_reset_hw(host);
  2535		}
  2536	}
  2537	
  2538	static void msdc_cqe_pre_enable(struct mmc_host *mmc)
  2539	{
  2540		struct cqhci_host *cq_host = mmc->cqe_private;
  2541		u32 reg;
  2542	
  2543		reg = cqhci_readl(cq_host, CQHCI_CFG);
  2544		reg |= CQHCI_ENABLE;
  2545		cqhci_writel(cq_host, reg, CQHCI_CFG);
  2546	}
  2547	
  2548	static void msdc_cqe_post_disable(struct mmc_host *mmc)
  2549	{
  2550		struct cqhci_host *cq_host = mmc->cqe_private;
  2551		u32 reg;
  2552	
  2553		reg = cqhci_readl(cq_host, CQHCI_CFG);
  2554		reg &= ~CQHCI_ENABLE;
  2555		cqhci_writel(cq_host, reg, CQHCI_CFG);
  2556	}
  2557	
  2558	static const struct mmc_host_ops mt_msdc_ops = {
  2559		.post_req = msdc_post_req,
  2560		.pre_req = msdc_pre_req,
  2561		.request = msdc_ops_request,
  2562		.set_ios = msdc_ops_set_ios,
  2563		.get_ro = mmc_gpio_get_ro,
  2564		.get_cd = msdc_get_cd,
  2565		.hs400_enhanced_strobe = msdc_hs400_enhanced_strobe,
  2566		.enable_sdio_irq = msdc_enable_sdio_irq,
  2567		.ack_sdio_irq = msdc_ack_sdio_irq,
  2568		.start_signal_voltage_switch = msdc_ops_switch_volt,
  2569		.card_busy = msdc_card_busy,
  2570		.execute_tuning = msdc_execute_tuning,
  2571		.prepare_hs400_tuning = msdc_prepare_hs400_tuning,
  2572		.execute_hs400_tuning = msdc_execute_hs400_tuning,
  2573		.card_hw_reset = msdc_hw_reset,
  2574	};
  2575	
  2576	static const struct cqhci_host_ops msdc_cmdq_ops = {
> 2577		.enable         = msdc_cqe_enable,
> 2578		.disable        = msdc_cqe_disable,
> 2579		.pre_enable = msdc_cqe_pre_enable,
> 2580		.post_disable = msdc_cqe_post_disable,
  2581	};
  2582	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
