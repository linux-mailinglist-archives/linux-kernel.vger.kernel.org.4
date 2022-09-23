Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED9B5E7815
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiIWKRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiIWKRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:17:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D348EBBF6;
        Fri, 23 Sep 2022 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663928268; x=1695464268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3RF8R4gI3IQLjr5ETA1xsRBMuHXlhbOb1bpBik0p/Cw=;
  b=iQC7OFJ0SFulET7fr7rRy6p/wsy2ySX2NcObsEVZzqyOVvfeLV/OXDQI
   AlkWibtQhFBnH8a82Lg14Dx6p0ydBh0JtzUYZmpaDM8TPmrY1ia+rxwTu
   QK89xLwD5hQ1DptpSuCcYQPQJitgyHGrkTidfwHSeuTdfbjck6AICRcEq
   v1lI32jJrdLe50L+hm5qxxuWyPgMPCoxJ+1dQe0k/ybqeDc+6KRTNl88+
   te0LXQeLio22qpeEV1Q85oB/YGuWxM9t3ymJOmM4FucgoIRJrfEWxe8jU
   jyPziwisxufXnkzRqM8VjbKQ6KgPvEebzgl+nVoVk0+1HlLxlyGPB66lC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="386852591"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="386852591"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 03:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="865249540"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Sep 2022 03:17:45 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obfke-0005ZE-2K;
        Fri, 23 Sep 2022 10:17:44 +0000
Date:   Fri, 23 Sep 2022 18:17:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gpio: tegra: Convert to immutable irq chip
Message-ID: <202209231809.KsxZvnZk-lkp@intel.com>
References: <20220922100339.12565-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922100339.12565-2-clamor95@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Svyatoslav,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tegra/for-next]
[also build test ERROR on brgl/gpio/for-next tegra-drm/drm/tegra/for-next linus/master v6.0-rc6 next-20220921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/gpio-tegra-Convert-to-immutable-irq-chip/20220922-180544
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
config: arm64-randconfig-r013-20220922 (https://download.01.org/0day-ci/archive/20220923/202209231809.KsxZvnZk-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/11723f8236100feb12775c232d66668969dde7fc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Svyatoslav-Ryhel/gpio-tegra-Convert-to-immutable-irq-chip/20220922-180544
        git checkout 11723f8236100feb12775c232d66668969dde7fc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpio/gpio-tegra.c:616:32: error: use of undeclared identifier 'tegra_gpio_irq_set_wake'; did you mean 'tegra_gpio_irq_set_type'?
           .irq_set_wake           = pm_sleep_ptr(tegra_gpio_irq_set_wake),
                                                  ^~~~~~~~~~~~~~~~~~~~~~~
                                                  tegra_gpio_irq_set_type
   include/linux/pm.h:439:65: note: expanded from macro 'pm_sleep_ptr'
   #define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
                                                                   ^
   include/linux/kernel.h:57:38: note: expanded from macro 'PTR_IF'
   #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
                                              ^
   drivers/gpio/gpio-tegra.c:304:12: note: 'tegra_gpio_irq_set_type' declared here
   static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
              ^
   drivers/gpio/gpio-tegra.c:630:32: error: use of undeclared identifier 'tegra_gpio_irq_set_wake'; did you mean 'tegra_gpio_irq_set_type'?
           .irq_set_wake           = pm_sleep_ptr(tegra_gpio_irq_set_wake),
                                                  ^~~~~~~~~~~~~~~~~~~~~~~
                                                  tegra_gpio_irq_set_type
   include/linux/pm.h:439:65: note: expanded from macro 'pm_sleep_ptr'
   #define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))
                                                                   ^
   include/linux/kernel.h:57:38: note: expanded from macro 'PTR_IF'
   #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
                                              ^
   drivers/gpio/gpio-tegra.c:304:12: note: 'tegra_gpio_irq_set_type' declared here
   static int tegra_gpio_irq_set_type(struct irq_data *d, unsigned int type)
              ^
   2 errors generated.


vim +616 drivers/gpio/gpio-tegra.c

   609	
   610	static const struct irq_chip tegra_gpio_irq_chip = {
   611		.irq_shutdown		= tegra_gpio_irq_shutdown,
   612		.irq_ack		= tegra_gpio_irq_ack,
   613		.irq_mask		= tegra_gpio_irq_mask,
   614		.irq_unmask		= tegra_gpio_irq_unmask,
   615		.irq_set_type		= tegra_gpio_irq_set_type,
 > 616		.irq_set_wake		= pm_sleep_ptr(tegra_gpio_irq_set_wake),
   617		.irq_print_chip		= tegra_gpio_irq_print_chip,
   618		.irq_request_resources	= tegra_gpio_irq_request_resources,
   619		.irq_release_resources	= tegra_gpio_irq_release_resources,
   620		.flags			= IRQCHIP_IMMUTABLE,
   621	};
   622	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
