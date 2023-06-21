Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F233C73786A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjFUAvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFUAvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:51:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F5F183
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687308710; x=1718844710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=byNNmiRwVHwfrGYMfTJ3x0bUzqPnibOKlP6YriwHef0=;
  b=QGa0Z7R+0lZYs+gT4K18c3FuhA/GFC0r3OdTMEAFLk55FvTWjSVouXSw
   en02yUTbQ78lt2OMFTC99TL8BjYzRB2DsNtbW2ye2e/pAXG0ID6+K9dUJ
   nkED71WyzUWEBZ3W1pkPOTvlF/Mw+E7DMwMEoNC8yCnqnwyOjzAuMY0Qw
   DKe6Ioj4/L07mQO2YzcH5cjHsFy+dzNkC1GvWnjMRzn2hS6TSsmY17jzb
   a6hYchByh3eGvbzXGLmMKeGPfVQI4PhUAXy/mUMYeAO/2ROmEJCgE8SLx
   BELhZjQ5sndFRjqd04fZH50g/xCB7t3TpTyimL/Wdc7svPpsbAbxAoWYk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="344764969"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="344764969"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 17:51:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="717416691"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="717416691"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jun 2023 17:51:47 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBm4Y-0006Nv-1d;
        Wed, 21 Jun 2023 00:51:46 +0000
Date:   Wed, 21 Jun 2023 08:51:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/mediatek: Fix void-pointer-to-enum-cast warning
Message-ID: <202306210852.JWLKcawy-lkp@intel.com>
References: <20230620102804.17585-1-jason-jh.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620102804.17585-1-jason-jh.lin@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason-JH.Lin,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.4-rc7 next-20230620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-JH-Lin/drm-mediatek-Fix-void-pointer-to-enum-cast-warning/20230620-182906
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230620102804.17585-1-jason-jh.lin%40mediatek.com
patch subject: [PATCH] drm/mediatek: Fix void-pointer-to-enum-cast warning
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230621/202306210852.JWLKcawy-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230621/202306210852.JWLKcawy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306210852.JWLKcawy-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c: In function 'ovl_adaptor_comp_init':
>> drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c:429:24: error: incompatible types when assigning to type 'enum mtk_ovl_adaptor_comp_type' from type 'const void *'
     429 |                 type = of_id->data;
         |                        ^~~~~
--
   drivers/gpu/drm/mediatek/mtk_drm_drv.c: In function 'mtk_drm_probe':
>> drivers/gpu/drm/mediatek/mtk_drm_drv.c:831:29: error: incompatible types when assigning to type 'enum mtk_ddp_comp_type' from type 'const void *'
     831 |                 comp_type = of_id->data;
         |                             ^~~~~


vim +429 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c

   405	
   406	static int ovl_adaptor_comp_init(struct device *dev, struct component_match **match)
   407	{
   408		struct mtk_disp_ovl_adaptor *priv = dev_get_drvdata(dev);
   409		struct device_node *node, *parent;
   410		struct platform_device *comp_pdev;
   411	
   412		parent = dev->parent->parent->of_node->parent;
   413	
   414		for_each_child_of_node(parent, node) {
   415			const struct of_device_id *of_id;
   416			enum mtk_ovl_adaptor_comp_type type;
   417			int id;
   418	
   419			of_id = of_match_node(mtk_ovl_adaptor_comp_dt_ids, node);
   420			if (!of_id)
   421				continue;
   422	
   423			if (!of_device_is_available(node)) {
   424				dev_dbg(dev, "Skipping disabled component %pOF\n",
   425					node);
   426				continue;
   427			}
   428	
 > 429			type = of_id->data;
   430			id = ovl_adaptor_comp_get_id(dev, node, type);
   431			if (id < 0) {
   432				dev_warn(dev, "Skipping unknown component %pOF\n",
   433					 node);
   434				continue;
   435			}
   436	
   437			comp_pdev = of_find_device_by_node(node);
   438			if (!comp_pdev)
   439				return -EPROBE_DEFER;
   440	
   441			priv->ovl_adaptor_comp[id] = &comp_pdev->dev;
   442	
   443			drm_of_component_match_add(dev, match, compare_of, node);
   444			dev_dbg(dev, "Adding component match for %pOF\n", node);
   445		}
   446	
   447		if (!*match) {
   448			dev_err(dev, "No match device for ovl_adaptor\n");
   449			return -ENODEV;
   450		}
   451	
   452		return 0;
   453	}
   454	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
