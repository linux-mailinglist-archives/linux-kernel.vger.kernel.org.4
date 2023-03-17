Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0FA6BEEC3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCQQqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCQQqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:46:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5B76C184;
        Fri, 17 Mar 2023 09:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679071582; x=1710607582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o5TmntMhWLq/Xs6nuUE9CYI22RfyrimqZiUkbmYVvCE=;
  b=Gaq/XZqI1UmxspVLDhQZdBSTFTApelWhwM8NS5o8OlTILTIidnLfFKm5
   jUYpoBcEGrS4+rAF0YTk2/aLtymHcXufsK8atR673qhnX/BXhXYiIOkdE
   oLk7jW31MUVMTjYAOadg+U2iPMDt0niNmpAnN2wrWvhTaZlPjGdwbsZK9
   Zd8/zu2rt2OucPW0lJzNe9Pg+MqHXrgb2CM3Tfw8FlkTjvfYEjTCA1tgS
   7L39vJ8Zj+wHC3+33P54R8qRchcSrIqnAUk5RBr/LxSch1imQxi8QDtRu
   bOt6giTUcJv8AHMYFIb+fjREOd8ne3fRXAc7tfwrz8XuAbZwEUNJ4/AMm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="326669662"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="326669662"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 09:46:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="749329465"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="749329465"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2023 09:46:15 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdDDa-0009Ui-2W;
        Fri, 17 Mar 2023 16:46:14 +0000
Date:   Sat, 18 Mar 2023 00:46:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, kyrie wu <kyrie.wu@mediatek.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, Yunfei Dong <yunfei.dong@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>
Subject: Re: [V1] media: mtk-jpeg: fixes use standard huffman table issue
Message-ID: <202303180043.zXYx8GNV-lkp@intel.com>
References: <20230316081925.10247-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316081925.10247-1-irui.wang@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Irui,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on linus/master v6.3-rc2 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Irui-Wang/media-mtk-jpeg-fixes-use-standard-huffman-table-issue/20230316-163606
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230316081925.10247-1-irui.wang%40mediatek.com
patch subject: [V1] media: mtk-jpeg: fixes use standard huffman table issue
config: s390-randconfig-r002-20230312 (https://download.01.org/0day-ci/archive/20230318/202303180043.zXYx8GNV-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/896259d7c51e49e9137901c69ca073ee3ed959b0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Irui-Wang/media-mtk-jpeg-fixes-use-standard-huffman-table-issue/20230316-163606
        git checkout 896259d7c51e49e9137901c69ca073ee3ed959b0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/media/platform/mediatek/jpeg/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303180043.zXYx8GNV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:11:
   In file included from drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.h:11:
   In file included from drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h:12:
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
   In file included from drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:11:
   In file included from drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.h:11:
   In file included from drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h:12:
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
   In file included from drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:11:
   In file included from drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.h:11:
   In file included from drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h:12:
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
>> drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:81:6: warning: variable 'i' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (param->comp_num != 1 && param->comp_num != 3)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:102:11: note: uninitialized use occurs here
           return !(i == param->comp_num);
                    ^
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:81:2: note: remove the 'if' if its condition is always false
           if (param->comp_num != 1 && param->comp_num != 3)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:76:6: warning: variable 'i' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (read_word_be(stream, &word))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:102:11: note: uninitialized use occurs here
           return !(i == param->comp_num);
                    ^
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:76:2: note: remove the 'if' if its condition is always false
           if (read_word_be(stream, &word))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:72:6: warning: variable 'i' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (read_word_be(stream, &word))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:102:11: note: uninitialized use occurs here
           return !(i == param->comp_num);
                    ^
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:72:2: note: remove the 'if' if its condition is always false
           if (read_word_be(stream, &word))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:69:6: warning: variable 'i' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (read_byte(stream) == -1)
               ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:102:11: note: uninitialized use occurs here
           return !(i == param->comp_num);
                    ^
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:69:2: note: remove the 'if' if its condition is always false
           if (read_byte(stream) == -1)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:65:6: warning: variable 'i' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (read_word_be(stream, &word))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:102:11: note: uninitialized use occurs here
           return !(i == param->comp_num);
                    ^
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:65:2: note: remove the 'if' if its condition is always false
           if (read_word_be(stream, &word))
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:61:7: note: initialize the variable 'i' to silence this warning
           int i, byte;
                ^
                 = 0
   drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:117:7: warning: unused variable 'i' [-Wunused-variable]
                   int i, length, byte;
                       ^
   18 warnings generated.


vim +81 drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c

    57	
    58	static bool parse_header(struct mtk_jpeg_stream *stream,
    59				 struct mtk_jpeg_dec_param *param)
    60	{
    61		int i, byte;
    62		u32 word;
    63	
    64		/* length */
    65		if (read_word_be(stream, &word))
    66			goto parse_end;
    67	
    68		/* precision */
    69		if (read_byte(stream) == -1)
    70			goto parse_end;
    71	
    72		if (read_word_be(stream, &word))
    73			goto parse_end;
    74		param->pic_h = word;
    75	
    76		if (read_word_be(stream, &word))
    77			goto parse_end;
    78		param->pic_w = word;
    79	
    80		param->comp_num = read_byte(stream);
  > 81		if (param->comp_num != 1 && param->comp_num != 3)
    82			goto parse_end;
    83	
    84		for (i = 0; i < param->comp_num; i++) {
    85			param->comp_id[i] = read_byte(stream);
    86			if (param->comp_id[i] == -1)
    87				break;
    88	
    89			/* sampling */
    90			byte = read_byte(stream);
    91			if (byte == -1)
    92				break;
    93			param->sampling_w[i] = (byte >> 4) & 0x0F;
    94			param->sampling_h[i] = byte & 0x0F;
    95	
    96			param->qtbl_num[i] = read_byte(stream);
    97			if (param->qtbl_num[i] == -1)
    98				break;
    99		}
   100	
   101	parse_end:
   102		return !(i == param->comp_num);
   103	}
   104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
