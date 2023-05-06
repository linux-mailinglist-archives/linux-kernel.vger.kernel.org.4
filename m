Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB56F92A9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjEFPT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjEFPTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:19:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A7017DC2
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683386362; x=1714922362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hCkknZAYY5yWFfX8utaB6yqS2c4BWC6sJ7xkLkU5m0o=;
  b=oG3wn6LSVHq7TLbSSKcIDFq0L2i7vzpm8bacf+bZUaCysnI2DM48KQ3J
   jdZATBfvoW7hDuytjP3WqSC62b7EsgADNSmxMhLx0EQ4Tqu+Pzpj0Y3jl
   XYWMLG0M9jGU6wGghHMrG/Ke6awRGmnpuYOsKuJgN2DoICuwUW6CU3AeB
   H3Ee02G29mV+JBlEp1Bhqfo0F8gOb5Bvz/KzBzma9Cx/A1LN6ancgPN64
   82tacVMs08e2tM+JirvcZ/j4gCjGEa+6Q0ZGPvd8OeA53BQ5cJcp435HL
   inGF93ue+G4YvMegF3ctis/WMsfnJO2D8NBv0XEkpioY1AQKuO2RPm/Kn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="329015354"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="329015354"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 08:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10702"; a="730743043"
X-IronPort-AV: E=Sophos;i="5.99,255,1677571200"; 
   d="scan'208";a="730743043"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2023 08:19:18 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvJgr-0000Mn-1k;
        Sat, 06 May 2023 15:19:17 +0000
Date:   Sat, 6 May 2023 23:19:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, p.zabel@pengutronix.de,
        airlied@gmail.com, daniel@ffwll.ch, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 04/11] drm/mediatek: gamma: Improve and simplify HW
 LUT calculation
Message-ID: <202305062349.SFNFiiWv-lkp@intel.com>
References: <20230506123549.101727-5-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506123549.101727-5-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[cannot apply to pza/imx-drm/next mbgg-mediatek/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/drm-mediatek-gamma-Adjust-mtk_drm_gamma_set_common-parameters/20230506-203713
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230506123549.101727-5-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v3 04/11] drm/mediatek: gamma: Improve and simplify HW LUT calculation
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230506/202305062349.SFNFiiWv-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a933258d0ee5c49d54f70fe11d3b1d719d5b6087
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review AngeloGioacchino-Del-Regno/drm-mediatek-gamma-Adjust-mtk_drm_gamma_set_common-parameters/20230506-203713
        git checkout a933258d0ee5c49d54f70fe11d3b1d719d5b6087
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/mediatek/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305062349.SFNFiiWv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/mediatek/mtk_disp_gamma.c: In function 'mtk_gamma_set_common':
>> drivers/gpu/drm/mediatek/mtk_disp_gamma.c:106:48: warning: suggest parentheses around '+' inside '<<' [-Wparentheses]
     106 |                         word = hwlut.red << 20 +
         |                                             ~~~^
     107 |                                hwlut.green << 10 +
         |                                ~~~~~~~~~~~      
   drivers/gpu/drm/mediatek/mtk_disp_gamma.c:107:50: warning: suggest parentheses around '+' inside '<<' [-Wparentheses]
     107 |                                hwlut.green << 10 +
         |                                               ~~~^
     108 |                                hwlut.red;
         |                                ~~~~~~~~~          
   drivers/gpu/drm/mediatek/mtk_disp_gamma.c:119:48: warning: suggest parentheses around '+' inside '<<' [-Wparentheses]
     119 |                         word = diff.blue << 20 +
         |                                             ~~~^
     120 |                                diff.green << 10 +
         |                                ~~~~~~~~~~       
   drivers/gpu/drm/mediatek/mtk_disp_gamma.c:120:49: warning: suggest parentheses around '+' inside '<<' [-Wparentheses]
     120 |                                diff.green << 10 +
         |                                              ~~~^
     121 |                                diff.red;
         |                                ~~~~~~~~          


vim +106 drivers/gpu/drm/mediatek/mtk_disp_gamma.c

    70	
    71	void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crtc_state *state)
    72	{
    73		struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
    74		unsigned int i, reg;
    75		struct drm_color_lut *lut;
    76		void __iomem *lut_base;
    77		bool lut_diff;
    78		u16 lut_size;
    79		u32 word;
    80	
    81		/* If there's no gamma lut there's nothing to do here. */
    82		if (!state->gamma_lut)
    83			return;
    84	
    85		if (gamma && gamma->data) {
    86			lut_diff = gamma->data->lut_diff;
    87			lut_size = gamma->data->lut_size;
    88		} else {
    89			lut_diff = false;
    90			lut_size = LUT_SIZE_DEFAULT;
    91		}
    92	
    93		reg = readl(regs + DISP_GAMMA_CFG);
    94		reg = reg | GAMMA_LUT_EN;
    95		writel(reg, regs + DISP_GAMMA_CFG);
    96		lut_base = regs + DISP_GAMMA_LUT;
    97		lut = (struct drm_color_lut *)state->gamma_lut->data;
    98		for (i = 0; i < lut_size; i++) {
    99			struct drm_color_lut diff, hwlut;
   100	
   101			hwlut.red = drm_color_lut_extract(lut[i].red, 10);
   102			hwlut.green = drm_color_lut_extract(lut[i].green, 10);
   103			hwlut.blue = drm_color_lut_extract(lut[i].blue, 10);
   104	
   105			if (!lut_diff || (i % 2 == 0)) {
 > 106				word = hwlut.red << 20 +
   107				       hwlut.green << 10 +
   108				       hwlut.red;
   109			} else {
   110				diff.red = lut[i].red - lut[i - 1].red;
   111				diff.red = drm_color_lut_extract(diff.red, 10);
   112	
   113				diff.green = lut[i].green - lut[i - 1].green;
   114				diff.green = drm_color_lut_extract(diff.green, 10);
   115	
   116				diff.blue = lut[i].blue - lut[i - 1].blue;
   117				diff.blue = drm_color_lut_extract(diff.blue, 10);
   118	
   119				word = diff.blue << 20 +
   120				       diff.green << 10 +
   121				       diff.red;
   122			}
   123			writel(word, (lut_base + i * 4));
   124		}
   125	}
   126	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
