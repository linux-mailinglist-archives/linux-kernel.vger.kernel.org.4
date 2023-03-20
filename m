Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577CC6C113B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjCTLwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjCTLws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:52:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A211EFEC;
        Mon, 20 Mar 2023 04:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679313167; x=1710849167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qaX/W4NW8LL69k/iCe59nSe6R3T+aQljmr/TjYHn54c=;
  b=UnfgcegOda+EfPRQmwtg4l8On0WJymWGxQObON3G/lbte4X57hA/gwr6
   RlzjFoE1mOZc4Ce8c2vrd+3XHYDXFXz50iU2SOt1+ZePqgfOL4Z/pFpoU
   G/YQMEJrnpwDWaj6W3eOUipwlXJvQTNhiw771RezCW/uUuVMl8QFOSGzG
   /KHm6IzVqhwYNZisnbPt2SZkzaBmjoSdmHYKk9120+GWLPTnlwvQna+Q1
   SVHDGRCufFOO54oL4Wo8tqPracNp6kK88qZS6RLHc1eASG/2syu3Ryqj5
   qaWhg7qxht3vMHfJ4MpK2rGezA7Ckb7g66A4z+IC3mhNcid6a0pJ4/+No
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="319040808"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="319040808"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 04:52:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="631096984"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="631096984"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Mar 2023 04:52:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peE49-000B1J-0x;
        Mon, 20 Mar 2023 11:52:41 +0000
Date:   Mon, 20 Mar 2023 19:51:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yu Zhe <yuzhe@nfschina.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org,
        angelogioacchino.delregno@collabora.com, agross@kernel.org,
        konrad.dybcio@linaro.org, patrice.chotard@foss.st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: Re: [PATCH v2] remoteproc: remove unnecessary (void*) conversions
Message-ID: <202303201947.sffcGruP-lkp@intel.com>
References: <20230320061157.29660-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320061157.29660-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v6.3-rc3]
[also build test WARNING on linus/master]
[cannot apply to remoteproc/rproc-next next-20230320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Zhe/remoteproc-remove-unnecessary-void-conversions/20230320-141403
patch link:    https://lore.kernel.org/r/20230320061157.29660-1-yuzhe%40nfschina.com
patch subject: [PATCH v2] remoteproc: remove unnecessary (void*) conversions
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230320/202303201947.sffcGruP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/38335303eda6c4de037cd00e20c9065a76f82291
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yu-Zhe/remoteproc-remove-unnecessary-void-conversions/20230320-141403
        git checkout 38335303eda6c4de037cd00e20c9065a76f82291
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303201947.sffcGruP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/remoteproc/st_remoteproc.c: In function 'st_rproc_probe':
>> drivers/remoteproc/st_remoteproc.c:361:23: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     361 |         ddata->config = match->data;
         |                       ^


vim +/const +361 drivers/remoteproc/st_remoteproc.c

   337	
   338	static int st_rproc_probe(struct platform_device *pdev)
   339	{
   340		struct device *dev = &pdev->dev;
   341		const struct of_device_id *match;
   342		struct st_rproc *ddata;
   343		struct device_node *np = dev->of_node;
   344		struct rproc *rproc;
   345		struct mbox_chan *chan;
   346		int enabled;
   347		int ret, i;
   348	
   349		match = of_match_device(st_rproc_match, dev);
   350		if (!match || !match->data) {
   351			dev_err(dev, "No device match found\n");
   352			return -ENODEV;
   353		}
   354	
   355		rproc = rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
   356		if (!rproc)
   357			return -ENOMEM;
   358	
   359		rproc->has_iommu = false;
   360		ddata = rproc->priv;
 > 361		ddata->config = match->data;
   362	
   363		platform_set_drvdata(pdev, rproc);
   364	
   365		ret = st_rproc_parse_dt(pdev);
   366		if (ret)
   367			goto free_rproc;
   368	
   369		enabled = st_rproc_state(pdev);
   370		if (enabled < 0) {
   371			ret = enabled;
   372			goto free_clk;
   373		}
   374	
   375		if (enabled) {
   376			atomic_inc(&rproc->power);
   377			rproc->state = RPROC_RUNNING;
   378		} else {
   379			clk_set_rate(ddata->clk, ddata->clk_rate);
   380		}
   381	
   382		if (of_get_property(np, "mbox-names", NULL)) {
   383			ddata->mbox_client_vq0.dev		= dev;
   384			ddata->mbox_client_vq0.tx_done		= NULL;
   385			ddata->mbox_client_vq0.tx_block	= false;
   386			ddata->mbox_client_vq0.knows_txdone	= false;
   387			ddata->mbox_client_vq0.rx_callback	= st_rproc_mbox_callback_vq0;
   388	
   389			ddata->mbox_client_vq1.dev		= dev;
   390			ddata->mbox_client_vq1.tx_done		= NULL;
   391			ddata->mbox_client_vq1.tx_block	= false;
   392			ddata->mbox_client_vq1.knows_txdone	= false;
   393			ddata->mbox_client_vq1.rx_callback	= st_rproc_mbox_callback_vq1;
   394	
   395			/*
   396			 * To control a co-processor without IPC mechanism.
   397			 * This driver can be used without mbox and rpmsg.
   398			 */
   399			chan = mbox_request_channel_byname(&ddata->mbox_client_vq0, "vq0_rx");
   400			if (IS_ERR(chan)) {
   401				dev_err(&rproc->dev, "failed to request mbox chan 0\n");
   402				ret = PTR_ERR(chan);
   403				goto free_clk;
   404			}
   405			ddata->mbox_chan[ST_RPROC_VQ0 * MBOX_MAX + MBOX_RX] = chan;
   406	
   407			chan = mbox_request_channel_byname(&ddata->mbox_client_vq0, "vq0_tx");
   408			if (IS_ERR(chan)) {
   409				dev_err(&rproc->dev, "failed to request mbox chan 0\n");
   410				ret = PTR_ERR(chan);
   411				goto free_mbox;
   412			}
   413			ddata->mbox_chan[ST_RPROC_VQ0 * MBOX_MAX + MBOX_TX] = chan;
   414	
   415			chan = mbox_request_channel_byname(&ddata->mbox_client_vq1, "vq1_rx");
   416			if (IS_ERR(chan)) {
   417				dev_err(&rproc->dev, "failed to request mbox chan 1\n");
   418				ret = PTR_ERR(chan);
   419				goto free_mbox;
   420			}
   421			ddata->mbox_chan[ST_RPROC_VQ1 * MBOX_MAX + MBOX_RX] = chan;
   422	
   423			chan = mbox_request_channel_byname(&ddata->mbox_client_vq1, "vq1_tx");
   424			if (IS_ERR(chan)) {
   425				dev_err(&rproc->dev, "failed to request mbox chan 1\n");
   426				ret = PTR_ERR(chan);
   427				goto free_mbox;
   428			}
   429			ddata->mbox_chan[ST_RPROC_VQ1 * MBOX_MAX + MBOX_TX] = chan;
   430		}
   431	
   432		ret = rproc_add(rproc);
   433		if (ret)
   434			goto free_mbox;
   435	
   436		return 0;
   437	
   438	free_mbox:
   439		for (i = 0; i < ST_RPROC_MAX_VRING * MBOX_MAX; i++)
   440			mbox_free_channel(ddata->mbox_chan[i]);
   441	free_clk:
   442		clk_unprepare(ddata->clk);
   443	free_rproc:
   444		rproc_free(rproc);
   445		return ret;
   446	}
   447	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
