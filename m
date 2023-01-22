Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E27E677368
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 00:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjAVXNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 18:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjAVXNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 18:13:51 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817111ABD0;
        Sun, 22 Jan 2023 15:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674429230; x=1705965230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p4zihUGlUVon576ZG2MBamybWBvtrWsAIn3m0PxR2aY=;
  b=mGhb+qUhRzbiyuT8zA6xr7ynWRrkQJ8jTweRZjDYFzvbu9pbNU6Quqbv
   Bs2rfUA1Xxn9/yAnGDD2Zv5STp37eGjUeky8ckig9rTn9EHVMc1eYlllD
   D3s4i/tbuUdQRofGiPrDDt0ZP6vVD82Q/L3u8URPdfgKBzSMwdy3mDAnK
   /suatnXa2Yw5MIqpEHAjILiZB/clQj8ZeN12Oz+aX/bbDaNk/wbNjfHBS
   ejtbdR/b7xawvCrRzuyx1dWdfTbxVTWzfXGt5qCUDdsiTAa4D0x2mbg5H
   eFJmi11c25XMySq+nYlNPwgQFY/WAkIDXbQ7LiZnLA4k6tGxhnUrck0wG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="305611252"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="305611252"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 15:13:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="750137575"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="750137575"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jan 2023 15:13:45 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJjWy-0005Ho-2A;
        Sun, 22 Jan 2023 23:13:44 +0000
Date:   Mon, 23 Jan 2023 07:13:06 +0800
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
Subject: Re: [PATCH v3] media: verisilicon: HEVC: Only propose 10 bits
 compatible pixels formats
Message-ID: <202301230653.0LvIKTcP-lkp@intel.com>
References: <20230119084723.133576-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119084723.133576-1-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

I love your patch! Yet something to improve:

[auto build test ERROR on media-tree/master]
[also build test ERROR on sailus-media-tree/streams linus/master v6.2-rc5 next-20230120]
[cannot apply to pza/reset/next pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/media-verisilicon-HEVC-Only-propose-10-bits-compatible-pixels-formats/20230119-164844
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230119084723.133576-1-benjamin.gaignard%40collabora.com
patch subject: [PATCH v3] media: verisilicon: HEVC: Only propose 10 bits compatible pixels formats
config: arm-randconfig-r022-20230122 (https://download.01.org/0day-ci/archive/20230123/202301230653.0LvIKTcP-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/11b698515c987afb9699f60be773dd7c52cea592
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Benjamin-Gaignard/media-verisilicon-HEVC-Only-propose-10-bits-compatible-pixels-formats/20230119-164844
        git checkout 11b698515c987afb9699f60be773dd7c52cea592
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/media/platform/verisilicon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/media/platform/verisilicon/hantro_drv.c:20:
   In file included from include/linux/videodev2.h:61:
   include/uapi/linux/videodev2.h:1779:2: warning: field  within 'struct v4l2_ext_control' is less aligned than 'union v4l2_ext_control::(anonymous at include/uapi/linux/videodev2.h:1779:2)' and is usually due to 'struct v4l2_ext_control' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           union {
           ^
>> drivers/media/platform/verisilicon/hantro_drv.c:293:3: error: expected expression
                   const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
                   ^
>> drivers/media/platform/verisilicon/hantro_drv.c:294:19: error: use of undeclared identifier 'sps'
                   int bit_depth = sps->bit_depth_luma_minus8 + 8;
                                   ^
   drivers/media/platform/verisilicon/hantro_drv.c:294:7: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                   int bit_depth = sps->bit_depth_luma_minus8 + 8;
                       ^
   drivers/media/platform/verisilicon/hantro_drv.c:1004:46: warning: implicit conversion from 'unsigned long long' to 'unsigned int' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
           vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~             ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:40: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                          ^~~~~
   3 warnings and 2 errors generated.


vim +293 drivers/media/platform/verisilicon/hantro_drv.c

   281	
   282	static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
   283	{
   284		struct hantro_ctx *ctx;
   285	
   286		ctx = container_of(ctrl->handler,
   287				   struct hantro_ctx, ctrl_handler);
   288	
   289		vpu_debug(1, "s_ctrl: id = %d, val = %d\n", ctrl->id, ctrl->val);
   290	
   291		switch (ctrl->id) {
   292		case V4L2_CID_STATELESS_HEVC_SPS:
 > 293			const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
 > 294			int bit_depth = sps->bit_depth_luma_minus8 + 8;
   295	
   296			if (ctx->bit_depth != bit_depth) {
   297				ctx->bit_depth = bit_depth;
   298				return hantro_reset_raw_fmt(ctx);
   299			}
   300			break;
   301		default:
   302			return -EINVAL;
   303		}
   304	
   305		return 0;
   306	}
   307	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
