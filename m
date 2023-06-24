Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C8F73C513
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 02:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjFXAQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 20:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjFXAQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 20:16:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DF02735;
        Fri, 23 Jun 2023 17:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687565784; x=1719101784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pNoCAdk57HxgqNty5nTEh06JfbUOL9kPT7lSrlnTP9M=;
  b=Vuk02p6yaaX7vSCQzgl7+TZTmj2lRiIAqTviVxoVfPUZv7QKtwwZVqME
   isDrGLqds3ORvuNYHgnD6ySgaaOT1qMKbtXlHwOf1DSWXcTSRqbQ9AFzZ
   LNctu7go2Fc8zBQ7zrIev9x2XqS+ckquUBZm+40Ovz3oudc+almKE4XCG
   tli6s1iddLfgGJlg2hjQkp7rgNBnBrv+rZJ6LImmUXmbtpIayevCBCzyF
   xT8NbfJELQzbEtSXMX4EoAwG6FEnQKCIaLhKIAD76jw7Xb0i6/EEQBYbN
   zI+Qfdg09vTsL8FI/1xwU3c+prCgwT5vAGRkmz1Qln6sUhjTm+Xh/jrz6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="447269390"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="447269390"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 17:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="718701484"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="718701484"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2023 17:16:21 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCqwv-0008bT-0J;
        Sat, 24 Jun 2023 00:16:21 +0000
Date:   Sat, 24 Jun 2023 08:15:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 1/3] firmware: qcom_scm: Always try to consume all three
 clocks
Message-ID: <202306240841.iVZhYL4l-lkp@intel.com>
References: <20230623-topic-scm_cleanup-v1-1-383089eae98d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623-topic-scm_cleanup-v1-1-383089eae98d@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c87d46a9e8ebd2f2c3960927b1d21687096d1109]

url:    https://github.com/intel-lab-lkp/linux/commits/Konrad-Dybcio/firmware-qcom_scm-Always-try-to-consume-all-three-clocks/20230624-055215
base:   c87d46a9e8ebd2f2c3960927b1d21687096d1109
patch link:    https://lore.kernel.org/r/20230623-topic-scm_cleanup-v1-1-383089eae98d%40linaro.org
patch subject: [PATCH 1/3] firmware: qcom_scm: Always try to consume all three clocks
config: arm64-randconfig-r023-20230622 (https://download.01.org/0day-ci/archive/20230624/202306240841.iVZhYL4l-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230624/202306240841.iVZhYL4l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306240841.iVZhYL4l-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/qcom_scm.c: In function 'qcom_scm_probe':
>> drivers/firmware/qcom_scm.c:1404:23: warning: variable 'clks' set but not used [-Wunused-but-set-variable]
    1404 |         unsigned long clks;
         |                       ^~~~


vim +/clks +1404 drivers/firmware/qcom_scm.c

6bf32599223634 Guru Das Srinagesh 2023-01-13  1400  
d0f6fa7ba2d624 Andy Gross         2016-06-03  1401  static int qcom_scm_probe(struct platform_device *pdev)
d0f6fa7ba2d624 Andy Gross         2016-06-03  1402  {
d0f6fa7ba2d624 Andy Gross         2016-06-03  1403  	struct qcom_scm *scm;
ab0822d57d8ccd Sarangdhar Joshi   2016-11-15 @1404  	unsigned long clks;
6bf32599223634 Guru Das Srinagesh 2023-01-13  1405  	int irq, ret;
d0f6fa7ba2d624 Andy Gross         2016-06-03  1406  
d0f6fa7ba2d624 Andy Gross         2016-06-03  1407  	scm = devm_kzalloc(&pdev->dev, sizeof(*scm), GFP_KERNEL);
d0f6fa7ba2d624 Andy Gross         2016-06-03  1408  	if (!scm)
d0f6fa7ba2d624 Andy Gross         2016-06-03  1409  		return -ENOMEM;
d0f6fa7ba2d624 Andy Gross         2016-06-03  1410  
8c1b7dc9ba2294 Bjorn Andersson    2017-08-14  1411  	ret = qcom_scm_find_dload_address(&pdev->dev, &scm->dload_mode_addr);
8c1b7dc9ba2294 Bjorn Andersson    2017-08-14  1412  	if (ret < 0)
8c1b7dc9ba2294 Bjorn Andersson    2017-08-14  1413  		return ret;
8c1b7dc9ba2294 Bjorn Andersson    2017-08-14  1414  
65b7ebda502861 Sibi Sankar        2022-05-23  1415  	mutex_init(&scm->scm_bw_lock);
65b7ebda502861 Sibi Sankar        2022-05-23  1416  
ab0822d57d8ccd Sarangdhar Joshi   2016-11-15  1417  	clks = (unsigned long)of_device_get_match_data(&pdev->dev);
60cd420c91e28c Bjorn Andersson    2018-08-29  1418  
65b7ebda502861 Sibi Sankar        2022-05-23  1419  	scm->path = devm_of_icc_get(&pdev->dev, NULL);
65b7ebda502861 Sibi Sankar        2022-05-23  1420  	if (IS_ERR(scm->path))
65b7ebda502861 Sibi Sankar        2022-05-23  1421  		return dev_err_probe(&pdev->dev, PTR_ERR(scm->path),
65b7ebda502861 Sibi Sankar        2022-05-23  1422  				     "failed to acquire interconnect path\n");
65b7ebda502861 Sibi Sankar        2022-05-23  1423  
06987a4b9a3c31 Konrad Dybcio      2023-06-23  1424  	scm->core_clk = devm_clk_get_optional(&pdev->dev, "core");
d0f6fa7ba2d624 Andy Gross         2016-06-03  1425  	if (IS_ERR(scm->core_clk)) {
60cd420c91e28c Bjorn Andersson    2018-08-29  1426  		if (PTR_ERR(scm->core_clk) == -EPROBE_DEFER)
60cd420c91e28c Bjorn Andersson    2018-08-29  1427  			return PTR_ERR(scm->core_clk);
ab0822d57d8ccd Sarangdhar Joshi   2016-11-15  1428  	}
d0f6fa7ba2d624 Andy Gross         2016-06-03  1429  
06987a4b9a3c31 Konrad Dybcio      2023-06-23  1430  	scm->iface_clk = devm_clk_get_optional(&pdev->dev, "iface");
d0f6fa7ba2d624 Andy Gross         2016-06-03  1431  	if (IS_ERR(scm->iface_clk)) {
60cd420c91e28c Bjorn Andersson    2018-08-29  1432  		if (PTR_ERR(scm->iface_clk) == -EPROBE_DEFER)
60cd420c91e28c Bjorn Andersson    2018-08-29  1433  			return PTR_ERR(scm->iface_clk);
d0f6fa7ba2d624 Andy Gross         2016-06-03  1434  	}
60cd420c91e28c Bjorn Andersson    2018-08-29  1435  
06987a4b9a3c31 Konrad Dybcio      2023-06-23  1436  	scm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
d0f6fa7ba2d624 Andy Gross         2016-06-03  1437  	if (IS_ERR(scm->bus_clk)) {
60cd420c91e28c Bjorn Andersson    2018-08-29  1438  		if (PTR_ERR(scm->bus_clk) == -EPROBE_DEFER)
60cd420c91e28c Bjorn Andersson    2018-08-29  1439  			return PTR_ERR(scm->bus_clk);
d0f6fa7ba2d624 Andy Gross         2016-06-03  1440  	}
d0f6fa7ba2d624 Andy Gross         2016-06-03  1441  
dd4fe5b292226f Bjorn Andersson    2016-06-17  1442  	scm->reset.ops = &qcom_scm_pas_reset_ops;
dd4fe5b292226f Bjorn Andersson    2016-06-17  1443  	scm->reset.nr_resets = 1;
dd4fe5b292226f Bjorn Andersson    2016-06-17  1444  	scm->reset.of_node = pdev->dev.of_node;
bd4760ca031567 Wei Yongjun        2016-08-28  1445  	ret = devm_reset_controller_register(&pdev->dev, &scm->reset);
bd4760ca031567 Wei Yongjun        2016-08-28  1446  	if (ret)
bd4760ca031567 Wei Yongjun        2016-08-28  1447  		return ret;
dd4fe5b292226f Bjorn Andersson    2016-06-17  1448  
d0f6fa7ba2d624 Andy Gross         2016-06-03  1449  	/* vote for max clk rate for highest performance */
d0f6fa7ba2d624 Andy Gross         2016-06-03  1450  	ret = clk_set_rate(scm->core_clk, INT_MAX);
d0f6fa7ba2d624 Andy Gross         2016-06-03  1451  	if (ret)
d0f6fa7ba2d624 Andy Gross         2016-06-03  1452  		return ret;
d0f6fa7ba2d624 Andy Gross         2016-06-03  1453  
d0f6fa7ba2d624 Andy Gross         2016-06-03  1454  	__scm = scm;
d0f6fa7ba2d624 Andy Gross         2016-06-03  1455  	__scm->dev = &pdev->dev;
d0f6fa7ba2d624 Andy Gross         2016-06-03  1456  
6bf32599223634 Guru Das Srinagesh 2023-01-13  1457  	init_completion(&__scm->waitq_comp);
6bf32599223634 Guru Das Srinagesh 2023-01-13  1458  
f3d0fbad6765da Johan Hovold       2023-03-09  1459  	irq = platform_get_irq_optional(pdev, 0);
6bf32599223634 Guru Das Srinagesh 2023-01-13  1460  	if (irq < 0) {
6bf32599223634 Guru Das Srinagesh 2023-01-13  1461  		if (irq != -ENXIO)
6bf32599223634 Guru Das Srinagesh 2023-01-13  1462  			return irq;
6bf32599223634 Guru Das Srinagesh 2023-01-13  1463  	} else {
6bf32599223634 Guru Das Srinagesh 2023-01-13  1464  		ret = devm_request_threaded_irq(__scm->dev, irq, NULL, qcom_scm_irq_handler,
6bf32599223634 Guru Das Srinagesh 2023-01-13  1465  						IRQF_ONESHOT, "qcom-scm", __scm);
6bf32599223634 Guru Das Srinagesh 2023-01-13  1466  		if (ret < 0)
6bf32599223634 Guru Das Srinagesh 2023-01-13  1467  			return dev_err_probe(scm->dev, ret, "Failed to request qcom-scm irq\n");
6bf32599223634 Guru Das Srinagesh 2023-01-13  1468  	}
6bf32599223634 Guru Das Srinagesh 2023-01-13  1469  
f6ea568f0ddcdf Stephen Boyd       2021-02-23  1470  	__get_convention();
6b1751a86ce2eb Kumar Gala         2016-06-03  1471  
8c1b7dc9ba2294 Bjorn Andersson    2017-08-14  1472  	/*
8c1b7dc9ba2294 Bjorn Andersson    2017-08-14  1473  	 * If requested enable "download mode", from this point on warmboot
c19698a9e41bd6 Jiang Jian         2022-06-21  1474  	 * will cause the boot stages to enter download mode, unless
8c1b7dc9ba2294 Bjorn Andersson    2017-08-14  1475  	 * disabled below by a clean shutdown/reboot.
8c1b7dc9ba2294 Bjorn Andersson    2017-08-14  1476  	 */
8c1b7dc9ba2294 Bjorn Andersson    2017-08-14  1477  	if (download_mode)
8c1b7dc9ba2294 Bjorn Andersson    2017-08-14  1478  		qcom_scm_set_download_mode(true);
8c1b7dc9ba2294 Bjorn Andersson    2017-08-14  1479  
d0f6fa7ba2d624 Andy Gross         2016-06-03  1480  	return 0;
d0f6fa7ba2d624 Andy Gross         2016-06-03  1481  }
d0f6fa7ba2d624 Andy Gross         2016-06-03  1482  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
