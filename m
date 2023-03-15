Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766086BBF9C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjCOWIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCOWIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:08:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D455F6C0;
        Wed, 15 Mar 2023 15:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678918093; x=1710454093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HOUd777ewJii5EcohIHu/Zr8BYfTt1p6GNO5ZeSEJHc=;
  b=nJas0jKcrXwTNBxflAGr7P5o1EzEcHVhHuzjzOF4UX/tIr8yxEZFhgsp
   aJ0Chv2n8RMZfyJX76q9xr+vNULxlG4w/MSHvgsQpzPo0ZfZnd7P3W1uM
   aLEOReB7sFxlHaeEq1s9mW0QDI/01gD3InM5lzo50yZd/v4L7NY1HZRg9
   nCZlYhOUsYvnT1BdPJeQz+mjdUWs/TDAN77J/NlZttfH5+KNkE5ndM3GU
   2CgMw3IDXAIoKB2Mi3rLHQIgQ0IM0yFahOSvi+m8+vF0dpVB+osZdACuN
   MVENSq533AJQzrUANTuNBiRRfDbmM5IQ6CpqIDrwYDPxLvvFxCGkAq9QX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="335313886"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="335313886"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 15:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="803457572"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="803457572"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2023 15:08:09 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcZI1-000845-0T;
        Wed, 15 Mar 2023 22:08:09 +0000
Date:   Thu, 16 Mar 2023 06:07:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2] irqchip/gicv3: Workaround for NVIDIA erratum
 T241-FABRIC-4
Message-ID: <202303160555.3zGOmtIL-lkp@intel.com>
References: <20230314135128.2930580-1-sdonthineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314135128.2930580-1-sdonthineni@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shanker,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on tip/irq/core soc/for-next linus/master v6.3-rc2 next-20230315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shanker-Donthineni/irqchip-gicv3-Workaround-for-NVIDIA-erratum-T241-FABRIC-4/20230314-215648
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230314135128.2930580-1-sdonthineni%40nvidia.com
patch subject: [PATCH v2] irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4
config: arm-buildonly-randconfig-r003-20230312 (https://download.01.org/0day-ci/archive/20230316/202303160555.3zGOmtIL-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/f796361134151057b68a259013204e8fa5516aee
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shanker-Donthineni/irqchip-gicv3-Workaround-for-NVIDIA-erratum-T241-FABRIC-4/20230314-215648
        git checkout f796361134151057b68a259013204e8fa5516aee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303160555.3zGOmtIL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/irqchip/irq-gic-v3.c:1775:21: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   chip_bmask |= BIT(FIELD_GET(T241_CHIPN_MASK,
                                     ^
>> drivers/irqchip/irq-gic-v3.c:1786:12: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           phys |= FIELD_PREP(T241_CHIPN_MASK, i);
                                   ^
   2 errors generated.


vim +/FIELD_GET +1775 drivers/irqchip/irq-gic-v3.c

  1760	
  1761	static bool gic_enable_quirk_nvidia_t241(void *data)
  1762	{
  1763		unsigned long chip_bmask = 0;
  1764		phys_addr_t phys;
  1765		u32 i;
  1766	
  1767		/* Check JEP106 code for NVIDIA T241 chip (036b:0241) */
  1768		if ((smccc_soc_id_version < 0) ||
  1769		    ((smccc_soc_id_version & SMCCC_SOC_ID_MASK) != SMCCC_SOC_ID_T241)) {
  1770			return false;
  1771		}
  1772	
  1773		/* Find the chips based on GICR regions PHYS addr */
  1774		for (i = 0; i < gic_data.nr_redist_regions; i++) {
> 1775			chip_bmask |= BIT(FIELD_GET(T241_CHIPN_MASK,
  1776					  gic_data.redist_regions[i].phys_base));
  1777		}
  1778	
  1779		if (hweight32(chip_bmask) < 3)
  1780			return false;
  1781	
  1782		/* Setup GICD alias regions */
  1783		for (i = 0; i < ARRAY_SIZE(t241_dist_base_alias); i++) {
  1784			if (chip_bmask & BIT(i)) {
  1785				phys = gic_data.dist_phys_base + T241_CHIP_GICDA_OFFSET;
> 1786				phys |= FIELD_PREP(T241_CHIPN_MASK, i);
  1787				t241_dist_base_alias[i] = ioremap(phys, SZ_64K);
  1788				WARN_ON_ONCE(!t241_dist_base_alias[i]);
  1789			}
  1790		}
  1791		static_branch_enable(&gic_nvidia_t241_erratum);
  1792		return true;
  1793	}
  1794	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
