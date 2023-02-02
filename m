Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04BE688943
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjBBVwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjBBVv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:51:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052B910C6;
        Thu,  2 Feb 2023 13:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675374717; x=1706910717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TpaqqMkhZ4cpZKxODCg9/NjjGOHDmYf9F5jCwNIn3Og=;
  b=HJUXqZ+uQ6LoSEzXgAbBd5cG5mLaElHPJCwoQiOKmLs7xPJmdA6TlECv
   yuzn8iIGNRFLlo9eaxJd3bq/pEWipWG+uGKjJtHYeKSdmoDKralNBFYnI
   yM+TmLAdj6JHHqYdntjSI5artKt8lQlxJQZ9GUT9/G33uPdLXd5qRyERq
   ttJYLByJgoNCQCyktrYtzlJwBurhHYpcWdgsek7jgFJW4HsCdXpSN5RIJ
   GOnnyCRZhmXRKyp1xr4hj9IjijQSu+bOSySkLAd1LtDtLRoA2UkDN3yU6
   L/XndmFWb7uGDvdRi+qW/Q3GaDIOEw1WKw6zl/eSd/aafMw3KfkSdEkim
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="316574609"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="316574609"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 13:51:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="729044313"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="729044313"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Feb 2023 13:51:52 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNhUl-0006tY-2s;
        Thu, 02 Feb 2023 21:51:51 +0000
Date:   Fri, 3 Feb 2023 05:51:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v6 3/5] media: verisilicon: Do not set ctx->bit_depth in
 hantro_try_ctrl()
Message-ID: <202302030526.YN9Piae4-lkp@intel.com>
References: <20230130135802.744743-4-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130135802.744743-4-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on sailus-media-tree/streams linus/master pza/reset/next]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/media-verisilicon-Do-not-set-context-src-dst-formats-in-reset-functions/20230130-220204
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230130135802.744743-4-benjamin.gaignard%40collabora.com
patch subject: [PATCH v6 3/5] media: verisilicon: Do not set ctx->bit_depth in hantro_try_ctrl()
config: arm64-randconfig-r005-20230202 (https://download.01.org/0day-ci/archive/20230203/202302030526.YN9Piae4-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/aecd2de6feaeb163aa78d82f1172b0020b64b174
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Benjamin-Gaignard/media-verisilicon-Do-not-set-context-src-dst-formats-in-reset-functions/20230130-220204
        git checkout aecd2de6feaeb163aa78d82f1172b0020b64b174
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/media/platform/verisilicon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/verisilicon/hantro_drv.c:254:21: warning: variable 'ctx' set but not used [-Wunused-but-set-variable]
           struct hantro_ctx *ctx;
                              ^
   1 warning generated.


vim +/ctx +254 drivers/media/platform/verisilicon/hantro_drv.c

775fec69008d30 drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c Ezequiel Garcia       2018-12-05  251  
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  252  static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  253  {
4bec03301ecd81 drivers/media/platform/verisilicon/hantro_drv.c       Benjamin Gaignard     2022-08-29 @254  	struct hantro_ctx *ctx;
4bec03301ecd81 drivers/media/platform/verisilicon/hantro_drv.c       Benjamin Gaignard     2022-08-29  255  
4bec03301ecd81 drivers/media/platform/verisilicon/hantro_drv.c       Benjamin Gaignard     2022-08-29  256  	ctx = container_of(ctrl->handler,
4bec03301ecd81 drivers/media/platform/verisilicon/hantro_drv.c       Benjamin Gaignard     2022-08-29  257  			   struct hantro_ctx, ctrl_handler);
4bec03301ecd81 drivers/media/platform/verisilicon/hantro_drv.c       Benjamin Gaignard     2022-08-29  258  
46a309d2751787 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-11-26  259  	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  260  		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  261  
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  262  		if (sps->chroma_format_idc > 1)
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  263  			/* Only 4:0:0 and 4:2:0 are supported */
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  264  			return -EINVAL;
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  265  		if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  266  			/* Luma and chroma bit depth mismatch */
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  267  			return -EINVAL;
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  268  		if (sps->bit_depth_luma_minus8 != 0)
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  269  			/* Only 8-bit is supported */
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  270  			return -EINVAL;
b92de2f91821ce drivers/staging/media/hantro/hantro_drv.c             Benjamin Gaignard     2022-07-08  271  	} else if (ctrl->id == V4L2_CID_STATELESS_HEVC_SPS) {
8968cfc282955c drivers/staging/media/hantro/hantro_drv.c             Benjamin Gaignard     2021-06-03  272  		const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
8968cfc282955c drivers/staging/media/hantro/hantro_drv.c             Benjamin Gaignard     2021-06-03  273  
d040a24b5aaede drivers/media/platform/verisilicon/hantro_drv.c       Benjamin Gaignard     2022-08-29  274  		if (sps->bit_depth_luma_minus8 != 0 && sps->bit_depth_luma_minus8 != 2)
d040a24b5aaede drivers/media/platform/verisilicon/hantro_drv.c       Benjamin Gaignard     2022-08-29  275  			/* Only 8-bit and 10-bit are supported */
df9ec2fc8e70e0 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2022-07-18  276  			return -EINVAL;
e2da465455ce48 drivers/staging/media/hantro/hantro_drv.c             Andrzej Pietrasiewicz 2021-11-16  277  	} else if (ctrl->id == V4L2_CID_STATELESS_VP9_FRAME) {
e2da465455ce48 drivers/staging/media/hantro/hantro_drv.c             Andrzej Pietrasiewicz 2021-11-16  278  		const struct v4l2_ctrl_vp9_frame *dec_params = ctrl->p_new.p_vp9_frame;
e2da465455ce48 drivers/staging/media/hantro/hantro_drv.c             Andrzej Pietrasiewicz 2021-11-16  279  
e2da465455ce48 drivers/staging/media/hantro/hantro_drv.c             Andrzej Pietrasiewicz 2021-11-16  280  		/* We only support profile 0 */
e2da465455ce48 drivers/staging/media/hantro/hantro_drv.c             Andrzej Pietrasiewicz 2021-11-16  281  		if (dec_params->profile != 0)
e2da465455ce48 drivers/staging/media/hantro/hantro_drv.c             Andrzej Pietrasiewicz 2021-11-16  282  			return -EINVAL;
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  283  	}
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  284  	return 0;
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  285  }
d70cca73234420 drivers/staging/media/hantro/hantro_drv.c             Ezequiel Garcia       2020-07-09  286  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
