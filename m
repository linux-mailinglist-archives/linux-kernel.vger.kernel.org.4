Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095386CC0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjC1N3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjC1N3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:29:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57133A5C9;
        Tue, 28 Mar 2023 06:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680010168; x=1711546168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tQTkT+hUldu+rXz3mb+LVVHL+mcEWhZt7e4D4RyAuNs=;
  b=PnwKNHjOwDrC9pV3GmBuNyiTYk/IwWo9ZoeACKyvj4dA0yDpWloViYuk
   H9X2jORUdfDuq2lVwvw9046wTy76gg2Ru3Fa2BraIKQA+HGzh5cUumgt/
   xmpP1hZPU55YOljumq9PO7KknlTvEg0oztYHAxunhdzxgNX2gdB6KNiRS
   SFNbGOikncGVaSmbrZTrOYo/A4rS9rGA/CJ9MsMzk65i7L7EU4DkAmzWr
   JQndu0JCDSZeNpYVH9Gxc68P2vx8McHe4oD893Gij0wPIWG8rgLXcpbC7
   9lCiahsZdFcPU3sgwWO7BC9MzxQc21m1mE/2gX1A5SG3+7uItkjPiKZbF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="403174813"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="403174813"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 06:29:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="794803518"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="794803518"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2023 06:29:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ph9No-000IYf-2B;
        Tue, 28 Mar 2023 13:29:04 +0000
Date:   Tue, 28 Mar 2023 21:28:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Chen <harperchen1110@gmail.com>, tiffany.lin@mediatek.com
Cc:     oe-kbuild-all@lists.linux.dev, andrew-ct.chen@mediatek.com,
        yunfei.dong@mediatek.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Wei Chen <harperchen1110@gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Fix potential array
 out-of-bounds in decoder queue_setup
Message-ID: <202303282152.CXxK3RNH-lkp@intel.com>
References: <20230328100951.536955-1-harperchen1110@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328100951.536955-1-harperchen1110@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on linus/master v6.3-rc4 next-20230328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Chen/media-mediatek-vcodec-Fix-potential-array-out-of-bounds-in-decoder-queue_setup/20230328-181142
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230328100951.536955-1-harperchen1110%40gmail.com
patch subject: [PATCH] media: mediatek: vcodec: Fix potential array out-of-bounds in decoder queue_setup
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20230328/202303282152.CXxK3RNH-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/caa43627286fb5f3b0b3af7e01e1baeca5c5f9cc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wei-Chen/media-mediatek-vcodec-Fix-potential-array-out-of-bounds-in-decoder-queue_setup/20230328-181142
        git checkout caa43627286fb5f3b0b3af7e01e1baeca5c5f9cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/media/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303282152.CXxK3RNH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c: In function 'vb2ops_vdec_queue_setup':
>> drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c:756:20: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
     756 |                 if (vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
         |                    ^


vim +/else +756 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c

   739	
   740	int vb2ops_vdec_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
   741				    unsigned int *nplanes, unsigned int sizes[],
   742				    struct device *alloc_devs[])
   743	{
   744		struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vq);
   745		struct mtk_q_data *q_data;
   746		unsigned int i;
   747	
   748		q_data = mtk_vdec_get_q_data(ctx, vq->type);
   749	
   750		if (q_data == NULL) {
   751			mtk_v4l2_err("vq->type=%d err\n", vq->type);
   752			return -EINVAL;
   753		}
   754	
   755		if (*nplanes) {
 > 756			if (vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
   757				if (*nplanes != q_data->fmt->num_planes)
   758					return -EINVAL;
   759			else
   760				if (*nplanes != 1)
   761					return -EINVAL;
   762	
   763			for (i = 0; i < *nplanes; i++) {
   764				if (sizes[i] < q_data->sizeimage[i])
   765					return -EINVAL;
   766			}
   767		} else {
   768			if (vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
   769				*nplanes = q_data->fmt->num_planes;
   770			else
   771				*nplanes = 1;
   772	
   773			for (i = 0; i < *nplanes; i++)
   774				sizes[i] = q_data->sizeimage[i];
   775		}
   776	
   777		mtk_v4l2_debug(1,
   778				"[%d]\t type = %d, get %d plane(s), %d buffer(s) of size 0x%x 0x%x ",
   779				ctx->id, vq->type, *nplanes, *nbuffers,
   780				sizes[0], sizes[1]);
   781	
   782		return 0;
   783	}
   784	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
