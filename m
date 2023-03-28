Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7EC6CC990
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjC1Rpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjC1Rp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:45:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B2C10DC;
        Tue, 28 Mar 2023 10:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680025524; x=1711561524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zqW36/YvRPeOC23O2ZjyjYHiMdp4yJAYygeFlPzj9Zs=;
  b=Nh8HKsl0UvPUtBefITStNU5ePvvr3T5+tzeTfAuCv5L4nCXo6qKYH5BT
   FOGchrE4bhS1MciBcDOKTOrEbGsPZ+alAnarfnEIvr+04EoAi8LOwucu6
   CrNHublxyTOMp18HnaXdmLpNVcRDxVm31yYwYsOOwwwYUIOk4XT842/lx
   rK2gK/elf4sdLAysdk8calIN0Lap9OmKnuAx/P1YZBoVzhNUHKuRU0vF6
   n1nWAsAoXGBnkBKLIG2ecM5Hh0l+EB3P1jj8FcT7/5pSZy5TPm04dvrfQ
   pbzCYi9+hcOcE7G+szzOYqkR4P1N1suMcAS4JsDzrsynL7t8FiS5WqbRB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320296512"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="320296512"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 10:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="827565190"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="827565190"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2023 10:45:20 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phDNi-000ImF-3C;
        Tue, 28 Mar 2023 17:45:14 +0000
Date:   Wed, 29 Mar 2023 01:44:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Chen <harperchen1110@gmail.com>, tiffany.lin@mediatek.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Wei Chen <harperchen1110@gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: Fix potential array
 out-of-bounds in decoder queue_setup
Message-ID: <202303290153.AP9Oe2GL-lkp@intel.com>
References: <20230328100951.536955-1-harperchen1110@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328100951.536955-1-harperchen1110@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
config: s390-randconfig-r044-20230327 (https://download.01.org/0day-ci/archive/20230329/202303290153.AP9Oe2GL-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/caa43627286fb5f3b0b3af7e01e1baeca5c5f9cc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wei-Chen/media-mediatek-vcodec-Fix-potential-array-out-of-bounds-in-decoder-queue_setup/20230328-181142
        git checkout caa43627286fb5f3b0b3af7e01e1baeca5c5f9cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/media/platform/mediatek/vcodec/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303290153.AP9Oe2GL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c:9:
   In file included from include/media/v4l2-mem2mem.h:16:
   In file included from include/media/videobuf2-v4l2.h:16:
   In file included from include/media/videobuf2-core.h:18:
   In file included from include/linux/dma-buf.h:16:
   In file included from include/linux/iosys-map.h:10:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c:9:
   In file included from include/media/v4l2-mem2mem.h:16:
   In file included from include/media/videobuf2-v4l2.h:16:
   In file included from include/media/videobuf2-core.h:18:
   In file included from include/linux/dma-buf.h:16:
   In file included from include/linux/iosys-map.h:10:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c:9:
   In file included from include/media/v4l2-mem2mem.h:16:
   In file included from include/media/videobuf2-v4l2.h:16:
   In file included from include/media/videobuf2-core.h:18:
   In file included from include/linux/dma-buf.h:16:
   In file included from include/linux/iosys-map.h:10:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c:759:3: warning: add explicit braces to avoid dangling else [-Wdangling-else]
                   else
                   ^
   13 warnings generated.


vim +759 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c

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
   756			if (vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
   757				if (*nplanes != q_data->fmt->num_planes)
   758					return -EINVAL;
 > 759			else
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
