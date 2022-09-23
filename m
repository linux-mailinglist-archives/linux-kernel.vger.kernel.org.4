Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4605E7171
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiIWBg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIWBg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:36:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C9EED5F4;
        Thu, 22 Sep 2022 18:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663897015; x=1695433015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WZdTk9T1PthgIdg0kjCHkHEqJf2vaI7cgaqZMy5Jl2E=;
  b=gAXMpo1eKRZ623vwlpbYf+IoV+W4lExb3iMgw2PUpZWJokoMTcX+O+6k
   TnFAj6tjM9SGAtNtnQcDk65/Wzydm4yTMuJIpVffMsdmx2XMnadf52xYT
   D0Xkrfwqh3+HsxKmGlJsda6NqlAxyZBUcdBemx0bdVNvH9ZxrIRwxew/S
   HDDtPGdZMRcGXdL5UzwZb/c7w1EqdpqfS8NUNEmQyUUiNQybQeCDRK9Li
   x6Lk+k6U3VTcXNHSe0SMazyjT21WPTWYuAvWDoFqbWUeWeaQ7O3WeUiId
   W0bFx5OYQjo4QYlNlLOdL8pz/3uoY4h7YNDqF8dxUa3nJnYXBFq0wm78f
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="280850946"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="280850946"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 18:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="688545613"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2022 18:36:51 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obXcY-00059w-2U;
        Fri, 23 Sep 2022 01:36:50 +0000
Date:   Fri, 23 Sep 2022 09:36:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, sboyd@kernel.org,
        mturquette@baylibre.com, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        runyang.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: Re: [PATCH] reset: mediatek: Move mediatek system clock reset to
 reset folder
Message-ID: <202209230910.DSbTCgBL-lkp@intel.com>
References: <20220922141107.10203-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922141107.10203-1-rex-bc.chen@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bo-Chen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v6.0-rc6]
[also build test WARNING on linus/master]
[cannot apply to clk/clk-next pza/reset/next mbgg-mediatek/for-next next-20220921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bo-Chen-Chen/reset-mediatek-Move-mediatek-system-clock-reset-to-reset-folder/20220922-221303
base:    521a547ced6477c54b4b0cc206000406c221b4d6
config: s390-randconfig-r044-20220922 (https://download.01.org/0day-ci/archive/20220923/202209230910.DSbTCgBL-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/69ce72445492a02115b1e7c7527a8a107f48aab8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bo-Chen-Chen/reset-mediatek-Move-mediatek-system-clock-reset-to-reset-folder/20220922-221303
        git checkout 69ce72445492a02115b1e7c7527a8a107f48aab8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/reset/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/reset/reset-mediatek-sysclk.c:11:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
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
   In file included from drivers/reset/reset-mediatek-sysclk.c:11:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
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
   In file included from drivers/reset/reset-mediatek-sysclk.c:11:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
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
>> drivers/reset/reset-mediatek-sysclk.c:539:5: warning: no previous prototype for function 'mtk_reset_init_with_node' [-Wmissing-prototypes]
   int mtk_reset_init_with_node(struct device_node *np, const char *name)
       ^
   drivers/reset/reset-mediatek-sysclk.c:539:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int mtk_reset_init_with_node(struct device_node *np, const char *name)
   ^
   static 
>> drivers/reset/reset-mediatek-sysclk.c:550:6: warning: no previous prototype for function 'mtk_rst_remove_with_node' [-Wmissing-prototypes]
   void mtk_rst_remove_with_node(struct device_node *np, const char *name)
        ^
   drivers/reset/reset-mediatek-sysclk.c:550:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mtk_rst_remove_with_node(struct device_node *np, const char *name)
   ^
   static 
   14 warnings generated.


vim +/mtk_reset_init_with_node +539 drivers/reset/reset-mediatek-sysclk.c

   538	
 > 539	int mtk_reset_init_with_node(struct device_node *np, const char *name)
   540	{
   541		struct mtk_clk_rst_data *data = find_rst_data(name);
   542	
   543		if (!np || !data)
   544			return -EINVAL;
   545	
   546		return register_rst_ctrl_with_node(np, data);
   547	}
   548	EXPORT_SYMBOL_GPL(mtk_reset_init_with_node);
   549	
 > 550	void mtk_rst_remove_with_node(struct device_node *np, const char *name)
   551	{
   552		struct mtk_clk_rst_data *data = find_rst_data(name);
   553	
   554		if (!np || !data)
   555			return;
   556	
   557		reset_controller_unregister(&data->rcdev);
   558	}
   559	EXPORT_SYMBOL_GPL(mtk_rst_remove_with_node);
   560	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
