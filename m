Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E462A6C5828
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjCVUwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjCVUwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:52:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443E0421B;
        Wed, 22 Mar 2023 13:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679518259; x=1711054259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uabzrRActvWORDWX39WS5JMj9IpucxbkVMI4llVLkMk=;
  b=QDUuHIcinZyJ+EKMBTc2stcun2bu8PRtBXq7zNZQ36WoZv+ewx1OQhB2
   wJb+6LbK3YYcSTvlmCyc86hIoyn5ldC/bVho4/23aZc8NEHrDrKYDRHc3
   WEOFTDrD2w3wfadUl9oIDl7fu7VD5AvJTFi6aAU6LfrC7c4kAK5JYNwb7
   Q4vp2C84Lysp9Yf/zSpsYhFz0HGbgsGVO3+VkhjJC+XKRfG33Vn6Zb8H+
   4cJRgSWdkTaxioaERShIcDfhV/1QyFnS65FYxMD9BcTfpzdf8qIR37d6r
   w0ZfJDKU1mIomwp2dFqbNt/HUWuNdKlNIEAMAb1KcBb7OfcvuckcC/hTH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341688257"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="341688257"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 13:50:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="682055417"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="682055417"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2023 13:50:54 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pf5Q6-000DeK-02;
        Wed, 22 Mar 2023 20:50:54 +0000
Date:   Thu, 23 Mar 2023 04:50:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: Re: [PATCH v1 2/2] spi: add support for Meson A1 SPI Flash Controller
Message-ID: <202303230442.lGIrV8PZ-lkp@intel.com>
References: <20230322150458.783901-3-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322150458.783901-3-mmkurbanov@sberdevices.ru>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on robh/for-next krzk-dt/for-next linus/master v6.3-rc3 next-20230322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Kurbanov/dt-bindings-spi-add-binding-for-meson-spifc-a1/20230322-230744
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20230322150458.783901-3-mmkurbanov%40sberdevices.ru
patch subject: [PATCH v1 2/2] spi: add support for Meson A1 SPI Flash Controller
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230323/202303230442.lGIrV8PZ-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7d8d54cc0b563efb979caf17507b29c0bb3efde0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Martin-Kurbanov/dt-bindings-spi-add-binding-for-meson-spifc-a1/20230322-230744
        git checkout 7d8d54cc0b563efb979caf17507b29c0bb3efde0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303230442.lGIrV8PZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-meson-spifc-a1.c: In function 'a1_spifc_read':
>> drivers/spi/spi-meson-spifc-a1.c:204:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     204 |         val |= FIELD_PREP(A1_SPIFC_USER_DIN_MODE, mode);
         |                ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +204 drivers/spi/spi-meson-spifc-a1.c

   196	
   197	static int a1_spifc_read(struct a1_spifc *spifc, void *buf, u32 size, u32 mode)
   198	{
   199		u32 val = readl(spifc->base + A1_SPIFC_USER_CTRL3_REG);
   200		int ret;
   201	
   202		val &= ~(A1_SPIFC_USER_DIN_MODE | A1_SPIFC_USER_DIN_BYTES);
   203		val |= A1_SPIFC_USER_DIN_ENABLE;
 > 204		val |= FIELD_PREP(A1_SPIFC_USER_DIN_MODE, mode);
   205		val |= FIELD_PREP(A1_SPIFC_USER_DIN_BYTES, size);
   206		writel(val, spifc->base + A1_SPIFC_USER_CTRL3_REG);
   207	
   208		ret = a1_spifc_request(spifc, true);
   209		if (!ret)
   210			a1_spifc_drain_buffer(spifc, buf, size);
   211	
   212		return ret;
   213	}
   214	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
