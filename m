Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00DB6B180F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 01:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCIAqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 19:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCIAqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 19:46:13 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C4A82ABC;
        Wed,  8 Mar 2023 16:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678322771; x=1709858771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rr/6zGAp8aqUfWklu+wtdJX92oC9y+5AlYk2V2xbAog=;
  b=gL60WHvd5aQf7/jcjgB5zxEV7cOOxqpHqpIf448JRcX+MU//iMnpwdJc
   YNuuSnqHvZU+GhSpupafJjLLd8CzuLJpAJ6bJ2bkKhvjP2dkSJEWk9WO8
   /ImRqZTNnBdP4RVRWT56ZIZB3TfaxKBN1tSYch3TxArPG1tDLKfvZqdnt
   eIBe/1zoCEtSE6r0uL5X1KQM0bYDamAwSnym1XPBnnDxRfV+Pp6JvFPRZ
   PUt3iKYHNtg5Y6iuKi/+i0o6gIskuvSenqZHyzpONrheP2bgWB7a3+IZL
   f/C2ESeFgKxUQkY9Ln4Q8TCMSFHDP+VtuZKCsi2R/cFhb4MolU7tAgdht
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="315976034"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="315976034"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 16:46:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="707398933"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="707398933"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Mar 2023 16:46:04 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pa4Q0-0002Wr-18;
        Thu, 09 Mar 2023 00:46:04 +0000
Date:   Thu, 9 Mar 2023 08:45:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] soc: samsung: pm_domains: Implement proper I/O
 operations
Message-ID: <202303090824.TjEOnQJ8-lkp@intel.com>
References: <20230308230931.27261-5-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308230931.27261-5-semen.protsenko@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on krzk/for-next]
[also build test WARNING on robh/for-next krzk-dt/for-next linus/master v6.3-rc1 next-20230308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sam-Protsenko/dt-bindings-power-pd-samsung-Add-Exynos850-support/20230309-071202
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
patch link:    https://lore.kernel.org/r/20230308230931.27261-5-semen.protsenko%40linaro.org
patch subject: [PATCH 4/6] soc: samsung: pm_domains: Implement proper I/O operations
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230309/202303090824.TjEOnQJ8-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2dabd70f9264ef6cd044de6c3cbd3d83bfef8442
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sam-Protsenko/dt-bindings-power-pd-samsung-Add-Exynos850-support/20230309-071202
        git checkout 2dabd70f9264ef6cd044de6c3cbd3d83bfef8442
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/soc/samsung/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303090824.TjEOnQJ8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/soc/samsung/pm_domains.c: In function 'exynos_pd_power':
>> drivers/soc/samsung/pm_domains.c:74:23: warning: variable 'base' set but not used [-Wunused-but-set-variable]
      74 |         void __iomem *base;
         |                       ^~~~


vim +/base +74 drivers/soc/samsung/pm_domains.c

2dabd70f9264ef drivers/soc/samsung/pm_domains.c  Sam Protsenko       2023-03-08   70  
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   71  static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   72  {
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   73  	struct exynos_pm_domain *pd;
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27  @74  	void __iomem *base;
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   75  	u32 timeout, pwr;
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   76  	char *op;
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   77  
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   78  	pd = container_of(domain, struct exynos_pm_domain, pd);
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   79  	base = pd->base;
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   80  
c028e175713698 drivers/soc/samsung/pm_domains.c  Krzysztof Kozlowski 2016-05-10   81  	pwr = power_on ? pd->local_pwr_cfg : 0;
2dabd70f9264ef drivers/soc/samsung/pm_domains.c  Sam Protsenko       2023-03-08   82  	exynos_pd_write_conf(pd, pwr);
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   83  
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   84  	/* Wait max 1ms */
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   85  	timeout = 10;
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   86  
2dabd70f9264ef drivers/soc/samsung/pm_domains.c  Sam Protsenko       2023-03-08   87  	while (exynos_pd_read_status(pd) != pwr) {
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   88  		if (!timeout) {
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   89  			op = (power_on) ? "enable" : "disable";
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   90  			pr_err("Power domain %s %s failed\n", domain->name, op);
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   91  			return -ETIMEDOUT;
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   92  		}
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   93  		timeout--;
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   94  		cpu_relax();
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   95  		usleep_range(80, 100);
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   96  	}
c760569d0e9c06 arch/arm/mach-exynos/pm_domains.c Prathyush K         2014-07-11   97  
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   98  	return 0;
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27   99  }
91cfbd4ee0875f arch/arm/mach-exynos/pm_domains.c Thomas Abraham      2012-01-27  100  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
