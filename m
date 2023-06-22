Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566E77395D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjFVDai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjFVDae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:30:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A111BCD;
        Wed, 21 Jun 2023 20:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687404633; x=1718940633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AZvU9ZeEZYTZ0Y5lwWUlf/o2NDHD8zNYuhg9CSqAe5k=;
  b=S7N4uPTuEfnhAyiyKuqGsGbcgYt6BwO4m0sdQtjfTKZmn02lAJybrm/I
   VSse/psOBbPu/hL8/OB3LROWp4Z2qfOYJ4MGxvZ0EzSZyksqeJkMctpSg
   pfN+88f0Zoi0ExQXW5OYvqqG2bG+1IYfq3HbUix1K8ExaiD+y7BkJJYdk
   YgFo/E5f1eN+n8pR13e3l+4YOJAZHDfhR6JGTpDbUVi+5T9549mQGmySc
   bcTijXW0cikqhvjesN5WE79MtJZkUOXHTfeXVSI1OTiDpKQG5xn3wofwp
   Fl86pdGBBIKBj0Gx0LfmHztllJsUWeSCdRGm1BomOzC46QjE3FOEemQES
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="357869008"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="357869008"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 20:30:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="827727304"
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="827727304"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2023 20:30:28 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCB1f-0007In-31;
        Thu, 22 Jun 2023 03:30:27 +0000
Date:   Thu, 22 Jun 2023 11:29:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jack.zhu@starfivetech.com,
        changhuang.liang@starfivetech.com
Subject: Re: [PATCH v7 5/6] media: starfive: camss: Add ISP driver
Message-ID: <202306221112.MnLtMzRo-lkp@intel.com>
References: <20230619112838.19797-6-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619112838.19797-6-jack.zhu@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

kernel test robot noticed the following build warnings:

[auto build test WARNING on media-tree/master]
[also build test WARNING on robh/for-next linus/master v6.4-rc7 next-20230621]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jack-Zhu/media-dt-bindings-Add-JH7110-Camera-Subsystem/20230619-193105
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230619112838.19797-6-jack.zhu%40starfivetech.com
patch subject: [PATCH v7 5/6] media: starfive: camss: Add ISP driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230622/202306221112.MnLtMzRo-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230622/202306221112.MnLtMzRo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306221112.MnLtMzRo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/platform/starfive/camss/stf_camss.c:173:13: warning: variable 'pad_num' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           } else if (port == STF_PORT_DVP) {
                      ^~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/starfive/camss/stf_camss.c:178:18: note: uninitialized use occurs here
           for (i = 0; i < pad_num; ++i) {
                           ^~~~~~~
   drivers/media/platform/starfive/camss/stf_camss.c:173:9: note: remove the 'if' if its condition is always true
           } else if (port == STF_PORT_DVP) {
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/starfive/camss/stf_camss.c:168:25: note: initialize the variable 'pad_num' to silence this warning
           unsigned int i, pad_num;
                                  ^
                                   = 0
   1 warning generated.
--
>> drivers/media/platform/starfive/camss/stf_isp.c:113:13: warning: variable 'formats' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           } else if (pad == STF_ISP_PAD_SRC) {
                      ^~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/starfive/camss/stf_isp.c:127:18: note: uninitialized use occurs here
           for (i = 0; i < formats->nfmts; i++) {
                           ^~~~~~~
   drivers/media/platform/starfive/camss/stf_isp.c:113:9: note: remove the 'if' if its condition is always true
           } else if (pad == STF_ISP_PAD_SRC) {
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/starfive/camss/stf_isp.c:105:40: note: initialize the variable 'formats' to silence this warning
           const struct isp_format_table *formats;
                                                 ^
                                                  = NULL
   1 warning generated.


vim +173 drivers/media/platform/starfive/camss/stf_camss.c

   156	
   157	static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
   158						  struct v4l2_subdev *subdev,
   159						  struct v4l2_async_subdev *asd)
   160	{
   161		struct stfcamss *stfcamss =
   162			container_of(async, struct stfcamss, notifier);
   163		struct stfcamss_async_subdev *csd =
   164			container_of(asd, struct stfcamss_async_subdev, asd);
   165		enum stf_port_num port = csd->port;
   166		struct stf_isp_dev *isp_dev = &stfcamss->isp_dev;
   167		struct media_pad *pad[STF_PADS_NUM];
   168		unsigned int i, pad_num;
   169	
   170		if (port == STF_PORT_CSI2RX) {
   171			pad[0] = &isp_dev->pads[STF_PAD_SINK];
   172			pad_num = 1;
 > 173		} else if (port == STF_PORT_DVP) {
   174			dev_err(stfcamss->dev, "Not support DVP sensor\n");
   175			return -EPERM;
   176		}
   177	
   178		for (i = 0; i < pad_num; ++i) {
   179			int ret;
   180	
   181			ret = v4l2_create_fwnode_links_to_pad(subdev, pad[i], 0);
   182			if (ret < 0)
   183				return ret;
   184		}
   185	
   186		return 0;
   187	}
   188	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
