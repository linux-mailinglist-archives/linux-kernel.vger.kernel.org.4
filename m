Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582007135C0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 18:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjE0QoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 12:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjE0QoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 12:44:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528229E;
        Sat, 27 May 2023 09:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685205852; x=1716741852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vljc/Pd6Io02Ai7XcnqcqUOa6Gb26xpAfOgGNEwIJt0=;
  b=UOKWhAZd/73bxZJd1uTydAyi1qC5G/1StHbrrvM7bdtD4VDcCuh2YOo0
   p1SZasme0hvDD2NoijHQt5Ddjwti2+n8g/dozpx8VXEHERTKqSzwYxNGj
   B1zWidQzyZDkHer+dIf6UdEZfrdhL3kC64Gwj+3YPvIENMlO8tWL2+5xV
   WkA1HDmD4WbKDfB4CoTMiMf924SAfbYKB8Bxhc155htHYCAUPXKF/4q+w
   qFrpoTRJed6EKO5AJHBN0OqBW4YIzjYE4yTEffDCNFRQLZp7BD/nWCeGS
   NNJXDxaGhYh58bYiFZnGTcYucUN1bP+Nwv3nkXktdh/RlUJLlrmu8q1jT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="351922436"
X-IronPort-AV: E=Sophos;i="6.00,197,1681196400"; 
   d="scan'208";a="351922436"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 09:44:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="795420700"
X-IronPort-AV: E=Sophos;i="6.00,197,1681196400"; 
   d="scan'208";a="795420700"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 May 2023 09:44:07 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2x1S-000K4o-3B;
        Sat, 27 May 2023 16:44:06 +0000
Date:   Sun, 28 May 2023 00:43:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Subject: Re: [PATCH v1 2/3] coresight-tmc: byte-cntr: Add support for
 streaming interface for ETR
Message-ID: <202305280032.8rkzzoXH-lkp@intel.com>
References: <20230526153508.6208-3-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526153508.6208-3-quic_jinlmao@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mao,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.4-rc3 next-20230525]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mao-Jinlong/Coresight-Add-driver-to-support-for-CSR/20230526-233705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230526153508.6208-3-quic_jinlmao%40quicinc.com
patch subject: [PATCH v1 2/3] coresight-tmc: byte-cntr: Add support for streaming interface for ETR
config: arm-randconfig-r034-20230526 (https://download.01.org/0day-ci/archive/20230528/202305280032.8rkzzoXH-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 4faf3aaf28226a4e950c103a14f6fc1d1fdabb1b)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/3c44cc3f9a93e12d206b9428b5ed959c46cf08b5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mao-Jinlong/Coresight-Add-driver-to-support-for-CSR/20230526-233705
        git checkout 3c44cc3f9a93e12d206b9428b5ed959c46cf08b5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/hwtracing/coresight/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305280032.8rkzzoXH-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/hwtracing/coresight/coresight-tmc-core.c:527:9: error: call to undeclared function 'of_get_coresight_csr_name'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   ret = of_get_coresight_csr_name(adev->dev.of_node, &drvdata->csr_name);
                         ^
   1 error generated.
--
>> drivers/hwtracing/coresight/coresight-byte-cntr.c:139:48: error: too few arguments to function call, expected 3, have 2
           coresight_csr_set_byte_cntr(tmcdrvdata->csr, 0);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~                   ^
   drivers/hwtracing/coresight/coresight-csr.h:53:20: note: 'coresight_csr_set_byte_cntr' declared here
   static inline void coresight_csr_set_byte_cntr(struct coresight_csr *csr, int irqctrl_offset,
                      ^
   drivers/hwtracing/coresight/coresight-byte-cntr.c:154:49: error: too few arguments to function call, expected 3, have 2
                   coresight_csr_set_byte_cntr(tmcdrvdata->csr, 0);
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~                   ^
   drivers/hwtracing/coresight/coresight-csr.h:53:20: note: 'coresight_csr_set_byte_cntr' declared here
   static inline void coresight_csr_set_byte_cntr(struct coresight_csr *csr, int irqctrl_offset,
                      ^
   drivers/hwtracing/coresight/coresight-byte-cntr.c:187:79: error: too few arguments to function call, expected 3, have 2
           coresight_csr_set_byte_cntr(tmcdrvdata->csr, (byte_cntr_data->block_size) / 8);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~                                                  ^
   drivers/hwtracing/coresight/coresight-csr.h:53:20: note: 'coresight_csr_set_byte_cntr' declared here
   static inline void coresight_csr_set_byte_cntr(struct coresight_csr *csr, int irqctrl_offset,
                      ^
>> drivers/hwtracing/coresight/coresight-byte-cntr.c:297:6: warning: no previous prototype for function 'byte_cntr_remove' [-Wmissing-prototypes]
   void byte_cntr_remove(struct byte_cntr *byte_cntr_data)
        ^
   drivers/hwtracing/coresight/coresight-byte-cntr.c:297:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void byte_cntr_remove(struct byte_cntr *byte_cntr_data)
   ^
   static 
   1 warning and 3 errors generated.


vim +/of_get_coresight_csr_name +527 drivers/hwtracing/coresight/coresight-tmc-core.c

   481	
   482	static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
   483	{
   484		int ret = 0;
   485		u32 devid;
   486		void __iomem *base;
   487		struct device *dev = &adev->dev;
   488		struct coresight_platform_data *pdata = NULL;
   489		struct tmc_drvdata *drvdata;
   490		struct resource *res = &adev->res;
   491		struct coresight_desc desc = { 0 };
   492		struct coresight_dev_list *dev_list = NULL;
   493	
   494		ret = -ENOMEM;
   495		drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
   496		if (!drvdata)
   497			goto out;
   498	
   499		dev_set_drvdata(dev, drvdata);
   500	
   501		/* Validity for the resource is already checked by the AMBA core */
   502		base = devm_ioremap_resource(dev, res);
   503		if (IS_ERR(base)) {
   504			ret = PTR_ERR(base);
   505			goto out;
   506		}
   507	
   508		drvdata->base = base;
   509		desc.access = CSDEV_ACCESS_IOMEM(base);
   510	
   511		spin_lock_init(&drvdata->spinlock);
   512	
   513		devid = readl_relaxed(drvdata->base + CORESIGHT_DEVID);
   514		drvdata->config_type = BMVAL(devid, 6, 7);
   515		drvdata->memwidth = tmc_get_memwidth(devid);
   516		/* This device is not associated with a session */
   517		drvdata->pid = -1;
   518	
   519		if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
   520			drvdata->size = tmc_etr_get_default_buffer_size(dev);
   521			drvdata->max_burst_size = tmc_etr_get_max_burst_size(dev);
   522		} else {
   523			drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
   524		}
   525	
   526		if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
 > 527			ret = of_get_coresight_csr_name(adev->dev.of_node, &drvdata->csr_name);
   528			if (ret)
   529				dev_dbg(dev, "No csr data\n");
   530			else {
   531				drvdata->csr = coresight_csr_get(drvdata->csr_name);
   532				if (IS_ERR(drvdata->csr)) {
   533					dev_dbg(dev, "failed to get csr, defer probe\n");
   534					return -EPROBE_DEFER;
   535				}
   536	
   537			}
   538	
   539		}
   540	
   541		desc.dev = dev;
   542		desc.groups = coresight_tmc_groups;
   543	
   544		switch (drvdata->config_type) {
   545		case TMC_CONFIG_TYPE_ETB:
   546			desc.type = CORESIGHT_DEV_TYPE_SINK;
   547			desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
   548			desc.ops = &tmc_etb_cs_ops;
   549			dev_list = &etb_devs;
   550			break;
   551		case TMC_CONFIG_TYPE_ETR:
   552			desc.type = CORESIGHT_DEV_TYPE_SINK;
   553			desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
   554			desc.ops = &tmc_etr_cs_ops;
   555			ret = tmc_etr_setup_caps(dev, devid,
   556						 coresight_get_uci_data(id));
   557			if (ret)
   558				goto out;
   559			idr_init(&drvdata->idr);
   560			drvdata->byte_cntr = byte_cntr_init(adev, drvdata);
   561			mutex_init(&drvdata->idr_mutex);
   562			dev_list = &etr_devs;
   563			break;
   564		case TMC_CONFIG_TYPE_ETF:
   565			desc.type = CORESIGHT_DEV_TYPE_LINKSINK;
   566			desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
   567			desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
   568			desc.ops = &tmc_etf_cs_ops;
   569			dev_list = &etf_devs;
   570			break;
   571		default:
   572			pr_err("%s: Unsupported TMC config\n", desc.name);
   573			ret = -EINVAL;
   574			goto out;
   575		}
   576	
   577		desc.name = coresight_alloc_device_name(dev_list, dev);
   578		if (!desc.name) {
   579			ret = -ENOMEM;
   580			goto out;
   581		}
   582	
   583		pdata = coresight_get_platform_data(dev);
   584		if (IS_ERR(pdata)) {
   585			ret = PTR_ERR(pdata);
   586			goto out;
   587		}
   588		adev->dev.platform_data = pdata;
   589		desc.pdata = pdata;
   590	
   591		drvdata->csdev = coresight_register(&desc);
   592		if (IS_ERR(drvdata->csdev)) {
   593			ret = PTR_ERR(drvdata->csdev);
   594			goto out;
   595		}
   596	
   597		drvdata->miscdev.name = desc.name;
   598		drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
   599		drvdata->miscdev.fops = &tmc_fops;
   600		ret = misc_register(&drvdata->miscdev);
   601		if (ret)
   602			coresight_unregister(drvdata->csdev);
   603		else
   604			pm_runtime_put(&adev->dev);
   605	out:
   606		return ret;
   607	}
   608	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
