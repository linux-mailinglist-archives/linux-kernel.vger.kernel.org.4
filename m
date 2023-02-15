Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9FC6981F5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjBOR1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBOR1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:27:40 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1484AD31
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676482058; x=1708018058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PBPnPi0qro1VlO3swfBP/0cTMsG0vJodGSvXgwx++3Q=;
  b=WfDYNIHRmeIstiPku26lZhUkbFiZviImpTI9r1tj6o4Zu/6IPtHi3Eeg
   g++Ls5c7EGzhYdN84EOuyKU/GnlVkwqA+0Gl+PuzMVsObewiK+J7+BIwo
   /9lD54ZJXQI/r/H+BJ6d7fG9FjXReycyb6vVScEjBK0Z26Ggzsr2l5iCH
   BklY8gTbyFThrR8eSoHgzY0RSWNt1j24W6jHAmeINk43LMTX2y63FZe6l
   HniHS/Qt4/q5bXfrrOL+22m2nlXCZHYQ9I5aNLuRClsdIxtWrt3qnFdAo
   ugorPOYnGJj6o3xx4d7f73fEHC0B5tE6BXeiNYiT6e8kpF8MCOk/mNIbT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="315145453"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="315145453"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 09:24:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="738433319"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="738433319"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 15 Feb 2023 09:24:56 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSLWZ-0009ar-1n;
        Wed, 15 Feb 2023 17:24:55 +0000
Date:   Thu, 16 Feb 2023 01:24:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH 2/3] irqchip/gic-v3: Propagate gic_cpu_pm_init() return
 code
Message-ID: <202302160113.Sfcg9tC9-lkp@intel.com>
References: <20230214233426.2994501-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214233426.2994501-3-f.fainelli@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on soc/for-next linus/master v6.2-rc8 next-20230215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Fainelli/irqchip-gic-v3-Use-switch-case-statements-in-gic_cpu_pm_notifier/20230215-073628
patch link:    https://lore.kernel.org/r/20230214233426.2994501-3-f.fainelli%40gmail.com
patch subject: [PATCH 2/3] irqchip/gic-v3: Propagate gic_cpu_pm_init() return code
config: arm64-randconfig-r011-20230213 (https://download.01.org/0day-ci/archive/20230216/202302160113.Sfcg9tC9-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8657e4fd7d9714934c7660bc3693d9ad507679a0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Florian-Fainelli/irqchip-gic-v3-Use-switch-case-statements-in-gic_cpu_pm_notifier/20230215-073628
        git checkout 8657e4fd7d9714934c7660bc3693d9ad507679a0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302160113.Sfcg9tC9-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-gic-v3.c: In function 'gic_init_bases':
>> drivers/irqchip/irq-gic-v3.c:1896:13: error: void value not ignored as it ought to be
    1896 |         err = gic_cpu_pm_init();
         |             ^


vim +1896 drivers/irqchip/irq-gic-v3.c

  1825	
  1826	static int __init gic_init_bases(void __iomem *dist_base,
  1827					 struct redist_region *rdist_regs,
  1828					 u32 nr_redist_regions,
  1829					 u64 redist_stride,
  1830					 struct fwnode_handle *handle)
  1831	{
  1832		u32 typer;
  1833		int err;
  1834	
  1835		if (!is_hyp_mode_available())
  1836			static_branch_disable(&supports_deactivate_key);
  1837	
  1838		if (static_branch_likely(&supports_deactivate_key))
  1839			pr_info("GIC: Using split EOI/Deactivate mode\n");
  1840	
  1841		gic_data.fwnode = handle;
  1842		gic_data.dist_base = dist_base;
  1843		gic_data.redist_regions = rdist_regs;
  1844		gic_data.nr_redist_regions = nr_redist_regions;
  1845		gic_data.redist_stride = redist_stride;
  1846	
  1847		/*
  1848		 * Find out how many interrupts are supported.
  1849		 */
  1850		typer = readl_relaxed(gic_data.dist_base + GICD_TYPER);
  1851		gic_data.rdists.gicd_typer = typer;
  1852	
  1853		gic_enable_quirks(readl_relaxed(gic_data.dist_base + GICD_IIDR),
  1854				  gic_quirks, &gic_data);
  1855	
  1856		pr_info("%d SPIs implemented\n", GIC_LINE_NR - 32);
  1857		pr_info("%d Extended SPIs implemented\n", GIC_ESPI_NR);
  1858	
  1859		/*
  1860		 * ThunderX1 explodes on reading GICD_TYPER2, in violation of the
  1861		 * architecture spec (which says that reserved registers are RES0).
  1862		 */
  1863		if (!(gic_data.flags & FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539))
  1864			gic_data.rdists.gicd_typer2 = readl_relaxed(gic_data.dist_base + GICD_TYPER2);
  1865	
  1866		gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
  1867							 &gic_data);
  1868		gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
  1869		gic_data.rdists.has_rvpeid = true;
  1870		gic_data.rdists.has_vlpis = true;
  1871		gic_data.rdists.has_direct_lpi = true;
  1872		gic_data.rdists.has_vpend_valid_dirty = true;
  1873	
  1874		if (WARN_ON(!gic_data.domain) || WARN_ON(!gic_data.rdists.rdist)) {
  1875			err = -ENOMEM;
  1876			goto out_free;
  1877		}
  1878	
  1879		irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
  1880	
  1881		gic_data.has_rss = !!(typer & GICD_TYPER_RSS);
  1882	
  1883		if (typer & GICD_TYPER_MBIS) {
  1884			err = mbi_init(handle, gic_data.domain);
  1885			if (err)
  1886				pr_err("Failed to initialize MBIs\n");
  1887		}
  1888	
  1889		set_handle_irq(gic_handle_irq);
  1890	
  1891		gic_update_rdist_properties();
  1892	
  1893		gic_dist_init();
  1894		gic_cpu_init();
  1895		gic_smp_init();
> 1896		err = gic_cpu_pm_init();
  1897		if (err)
  1898			goto out_set_handle;
  1899	
  1900		if (gic_dist_supports_lpis()) {
  1901			its_init(handle, &gic_data.rdists, gic_data.domain);
  1902			its_cpu_init();
  1903			its_lpi_memreserve_init();
  1904		} else {
  1905			if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
  1906				gicv2m_init(handle, gic_data.domain);
  1907		}
  1908	
  1909		gic_enable_nmi_support();
  1910	
  1911		return 0;
  1912	
  1913	out_set_handle:
  1914		set_handle_irq(NULL);
  1915	out_free:
  1916		if (gic_data.domain)
  1917			irq_domain_remove(gic_data.domain);
  1918		free_percpu(gic_data.rdists.rdist);
  1919		return err;
  1920	}
  1921	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
