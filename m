Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C75BB0E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 18:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiIPQHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 12:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIPQHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 12:07:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A79B5E76;
        Fri, 16 Sep 2022 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663344430; x=1694880430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=txXFG6pxRQXR5LBhZBt+ObfjH9wJQexQ6BpqZeDAbo4=;
  b=LWCQm/E754V4p8RGoHqwFpZ1gFwDcHiiMYykqnTmiqRqrraz1OpD6jZG
   siEi8uVJFGlZjkTeTsUnEN8rYUOAYQthctkbF7ylzpgHAXBPV2LSEh+Hp
   RtxBV7+kLaamxnc4Dl1rp4c7TtEvt5AGsFCS5kKZnazxCc3NX4I81rW1f
   zclKXMtzztjY7vxymCONHPIEn/E74VT5NCTpGK6h3N9GzpZJp94LFdr/w
   RMp9JGbNBkerRqlFkE0Kb9wo97sXeOqXFUK9usRYdHja5S1pS2418UAKH
   avclpGqb6hp5OSGuaSnMfMiPiBRlRqCHKk9CwBWZR1UQoXXGugPBPSIXH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="299015230"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="299015230"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 09:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="743387423"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2022 09:07:07 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZDru-0001vt-2c;
        Fri, 16 Sep 2022 16:07:06 +0000
Date:   Sat, 17 Sep 2022 00:06:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        broonie@kernel.org, krzysztof.kozlowski@linaro.org,
        andi@etezian.org
Cc:     kbuild-all@lists.01.org, kernel@axis.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] spi: Fix cache corruption due to DMA/PIO overlap
Message-ID: <202209162337.7NbxJFXD-lkp@intel.com>
References: <20220916113951.228398-4-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916113951.228398-4-vincent.whitchurch@axis.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on krzk/for-next linus/master v6.0-rc5 next-20220916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Whitchurch/spi-Fix-DMA-bugs-in-not-only-spi-s3c64xx/20220916-194234
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220916/202209162337.7NbxJFXD-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d9c81b85380dadb07e24d2f5dd6b27bacb72845a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vincent-Whitchurch/spi-Fix-DMA-bugs-in-not-only-spi-s3c64xx/20220916-194234
        git checkout d9c81b85380dadb07e24d2f5dd6b27bacb72845a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/spi/spi.c:1243:6: warning: no previous prototype for 'spi_dma_sync_for_device' [-Wmissing-prototypes]
    1243 | void spi_dma_sync_for_device(struct spi_controller *ctrl, struct spi_transfer *xfer)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/spi/spi.c:1247:6: warning: no previous prototype for 'spi_dma_sync_for_cpu' [-Wmissing-prototypes]
    1247 | void spi_dma_sync_for_cpu(struct spi_controller *ctrl, struct spi_transfer *xfer)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/spi_dma_sync_for_device +1243 drivers/spi/spi.c

  1242	
> 1243	void spi_dma_sync_for_device(struct spi_controller *ctrl, struct spi_transfer *xfer)
  1244	{
  1245	}
  1246	
> 1247	void spi_dma_sync_for_cpu(struct spi_controller *ctrl, struct spi_transfer *xfer)
  1248	{
  1249	}
  1250	#endif /* !CONFIG_HAS_DMA */
  1251	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
