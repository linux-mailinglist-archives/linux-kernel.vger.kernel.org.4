Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A3E739303
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjFUXbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFUXbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:31:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C275219C;
        Wed, 21 Jun 2023 16:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687390290; x=1718926290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mbA3y/MVYoWo9izwQqDwmacdQ1EryyxrYbMeFFr+8IQ=;
  b=WvcjXg1eHT3I6y+8/VPoaBpMtZqB14GvplVMR6QhSvtzvFmIK3WJqSPt
   zd2XOMy7mZO4HSokcT0wQSkziCu4ou0THvdEQCGGn0o8mPkdHwTGmfoEj
   gCLZhO9JiQSxdh0yqvqZU3IQUk6ic9tcbPw4vn4A9KS6IDJ/nvHL1BkLu
   LwPc40kqXejIbICmT+QteG63qxYDyKZki9etyEla4mYkRS2nmQ02pAmbL
   woK+bpW2P2u9DEd+6aDKCEPXemiScZw5F2YKPCWEICjCVR2s36/SLvNnc
   Td8pBqSq2CXGhbDUOzegFG3oj7QZrhw11IbdbZcp7aqCUiz30ASlr7km6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360352046"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="360352046"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 16:31:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="692034376"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="692034376"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Jun 2023 16:31:22 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qC7IH-00079r-1V;
        Wed, 21 Jun 2023 23:31:21 +0000
Date:   Thu, 22 Jun 2023 07:30:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next 10/12] net: stmmac: replace the int_snapshot_en
 field with a flag
Message-ID: <202306220657.ikVUl0zU-lkp@intel.com>
References: <20230621182558.544417-11-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621182558.544417-11-brgl@bgdev.pl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/net-stmmac-replace-has_integrated_pcs-field-with-a-flag/20230622-022944
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230621182558.544417-11-brgl%40bgdev.pl
patch subject: [PATCH net-next 10/12] net: stmmac: replace the int_snapshot_en field with a flag
config: i386-randconfig-i012-20230621 (https://download.01.org/0day-ci/archive/20230622/202306220657.ikVUl0zU-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230622/202306220657.ikVUl0zU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306220657.ikVUl0zU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c:612:2: error: use of undeclared identifier 'priv'
           priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
           ^
   1 error generated.


vim +/priv +612 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c

   446	
   447	static int intel_mgbe_common_data(struct pci_dev *pdev,
   448					  struct plat_stmmacenet_data *plat)
   449	{
   450		struct fwnode_handle *fwnode;
   451		char clk_name[20];
   452		int ret;
   453		int i;
   454	
   455		plat->pdev = pdev;
   456		plat->phy_addr = -1;
   457		plat->clk_csr = 5;
   458		plat->has_gmac = 0;
   459		plat->has_gmac4 = 1;
   460		plat->force_sf_dma_mode = 0;
   461		plat->flags |= (STMMAC_FLAG_TSO_EN | STMMAC_FLAG_SPH_DISABLE);
   462	
   463		/* Multiplying factor to the clk_eee_i clock time
   464		 * period to make it closer to 100 ns. This value
   465		 * should be programmed such that the clk_eee_time_period *
   466		 * (MULT_FACT_100NS + 1) should be within 80 ns to 120 ns
   467		 * clk_eee frequency is 19.2Mhz
   468		 * clk_eee_time_period is 52ns
   469		 * 52ns * (1 + 1) = 104ns
   470		 * MULT_FACT_100NS = 1
   471		 */
   472		plat->mult_fact_100ns = 1;
   473	
   474		plat->rx_sched_algorithm = MTL_RX_ALGORITHM_SP;
   475	
   476		for (i = 0; i < plat->rx_queues_to_use; i++) {
   477			plat->rx_queues_cfg[i].mode_to_use = MTL_QUEUE_DCB;
   478			plat->rx_queues_cfg[i].chan = i;
   479	
   480			/* Disable Priority config by default */
   481			plat->rx_queues_cfg[i].use_prio = false;
   482	
   483			/* Disable RX queues routing by default */
   484			plat->rx_queues_cfg[i].pkt_route = 0x0;
   485		}
   486	
   487		for (i = 0; i < plat->tx_queues_to_use; i++) {
   488			plat->tx_queues_cfg[i].mode_to_use = MTL_QUEUE_DCB;
   489	
   490			/* Disable Priority config by default */
   491			plat->tx_queues_cfg[i].use_prio = false;
   492			/* Default TX Q0 to use TSO and rest TXQ for TBS */
   493			if (i > 0)
   494				plat->tx_queues_cfg[i].tbs_en = 1;
   495		}
   496	
   497		/* FIFO size is 4096 bytes for 1 tx/rx queue */
   498		plat->tx_fifo_size = plat->tx_queues_to_use * 4096;
   499		plat->rx_fifo_size = plat->rx_queues_to_use * 4096;
   500	
   501		plat->tx_sched_algorithm = MTL_TX_ALGORITHM_WRR;
   502		plat->tx_queues_cfg[0].weight = 0x09;
   503		plat->tx_queues_cfg[1].weight = 0x0A;
   504		plat->tx_queues_cfg[2].weight = 0x0B;
   505		plat->tx_queues_cfg[3].weight = 0x0C;
   506		plat->tx_queues_cfg[4].weight = 0x0D;
   507		plat->tx_queues_cfg[5].weight = 0x0E;
   508		plat->tx_queues_cfg[6].weight = 0x0F;
   509		plat->tx_queues_cfg[7].weight = 0x10;
   510	
   511		plat->dma_cfg->pbl = 32;
   512		plat->dma_cfg->pblx8 = true;
   513		plat->dma_cfg->fixed_burst = 0;
   514		plat->dma_cfg->mixed_burst = 0;
   515		plat->dma_cfg->aal = 0;
   516		plat->dma_cfg->dche = true;
   517	
   518		plat->axi = devm_kzalloc(&pdev->dev, sizeof(*plat->axi),
   519					 GFP_KERNEL);
   520		if (!plat->axi)
   521			return -ENOMEM;
   522	
   523		plat->axi->axi_lpi_en = 0;
   524		plat->axi->axi_xit_frm = 0;
   525		plat->axi->axi_wr_osr_lmt = 1;
   526		plat->axi->axi_rd_osr_lmt = 1;
   527		plat->axi->axi_blen[0] = 4;
   528		plat->axi->axi_blen[1] = 8;
   529		plat->axi->axi_blen[2] = 16;
   530	
   531		plat->ptp_max_adj = plat->clk_ptp_rate;
   532		plat->eee_usecs_rate = plat->clk_ptp_rate;
   533	
   534		/* Set system clock */
   535		sprintf(clk_name, "%s-%s", "stmmac", pci_name(pdev));
   536	
   537		plat->stmmac_clk = clk_register_fixed_rate(&pdev->dev,
   538							   clk_name, NULL, 0,
   539							   plat->clk_ptp_rate);
   540	
   541		if (IS_ERR(plat->stmmac_clk)) {
   542			dev_warn(&pdev->dev, "Fail to register stmmac-clk\n");
   543			plat->stmmac_clk = NULL;
   544		}
   545	
   546		ret = clk_prepare_enable(plat->stmmac_clk);
   547		if (ret) {
   548			clk_unregister_fixed_rate(plat->stmmac_clk);
   549			return ret;
   550		}
   551	
   552		plat->ptp_clk_freq_config = intel_mgbe_ptp_clk_freq_config;
   553	
   554		/* Set default value for multicast hash bins */
   555		plat->multicast_filter_bins = HASH_TABLE_SIZE;
   556	
   557		/* Set default value for unicast filter entries */
   558		plat->unicast_filter_entries = 1;
   559	
   560		/* Set the maxmtu to a default of JUMBO_LEN */
   561		plat->maxmtu = JUMBO_LEN;
   562	
   563		plat->flags |= STMMAC_FLAG_VLAN_FAIL_Q_EN;
   564	
   565		/* Use the last Rx queue */
   566		plat->vlan_fail_q = plat->rx_queues_to_use - 1;
   567	
   568		/* For fixed-link setup, we allow phy-mode setting */
   569		fwnode = dev_fwnode(&pdev->dev);
   570		if (fwnode) {
   571			int phy_mode;
   572	
   573			/* "phy-mode" setting is optional. If it is set,
   574			 *  we allow either sgmii or 1000base-x for now.
   575			 */
   576			phy_mode = fwnode_get_phy_mode(fwnode);
   577			if (phy_mode >= 0) {
   578				if (phy_mode == PHY_INTERFACE_MODE_SGMII ||
   579				    phy_mode == PHY_INTERFACE_MODE_1000BASEX)
   580					plat->phy_interface = phy_mode;
   581				else
   582					dev_warn(&pdev->dev, "Invalid phy-mode\n");
   583			}
   584		}
   585	
   586		/* Intel mgbe SGMII interface uses pcs-xcps */
   587		if (plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
   588		    plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
   589			plat->mdio_bus_data->has_xpcs = true;
   590			plat->mdio_bus_data->xpcs_an_inband = true;
   591		}
   592	
   593		/* For fixed-link setup, we clear xpcs_an_inband */
   594		if (fwnode) {
   595			struct fwnode_handle *fixed_node;
   596	
   597			fixed_node = fwnode_get_named_child_node(fwnode, "fixed-link");
   598			if (fixed_node)
   599				plat->mdio_bus_data->xpcs_an_inband = false;
   600	
   601			fwnode_handle_put(fixed_node);
   602		}
   603	
   604		/* Ensure mdio bus scan skips intel serdes and pcs-xpcs */
   605		plat->mdio_bus_data->phy_mask = 1 << INTEL_MGBE_ADHOC_ADDR;
   606		plat->mdio_bus_data->phy_mask |= 1 << INTEL_MGBE_XPCS_ADDR;
   607	
   608		plat->int_snapshot_num = AUX_SNAPSHOT1;
   609		plat->ext_snapshot_num = AUX_SNAPSHOT0;
   610	
   611		plat->crosststamp = intel_crosststamp;
 > 612		priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
   613	
   614		/* Setup MSI vector offset specific to Intel mGbE controller */
   615		plat->msi_mac_vec = 29;
   616		plat->msi_lpi_vec = 28;
   617		plat->msi_sfty_ce_vec = 27;
   618		plat->msi_sfty_ue_vec = 26;
   619		plat->msi_rx_base_vec = 0;
   620		plat->msi_tx_base_vec = 1;
   621	
   622		return 0;
   623	}
   624	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
