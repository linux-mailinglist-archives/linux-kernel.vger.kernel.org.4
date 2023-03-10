Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9E76B539E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjCJV7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjCJV7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:59:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3474234EB;
        Fri, 10 Mar 2023 13:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678485351; x=1710021351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ZQRLQu84HAORpFHSfVd3rSzKA87bHH+2cYOQb+pAc8=;
  b=cKPvoFCu3BHq4Pj1XLkiqTzU5+baBfqFmaICWrGJ5F5DSZ6FnLUF8Fzk
   eEB6IDjLBbTeGhZw2lEq2SfMzedAfpa06OZ1muQ59vx/UTJGPDaKnKNGh
   0hnkRFbupNX9RsUoOLcHHXf0B0N9OUW0AOHxDhxL6cDPOPfH23Z2Pn9I8
   h2nwa2+uKY5HFJFz5bxWRV/FJsPJXS9kz8ha1mIrLNibmfEvDj8BpDxUf
   wwiSz0sJ9AgeCkrPScusq4YABbEp7PfSbnPsHHE71I58FNpV26E9J7pBp
   LVou8L7Z8M0+d+z5vo+G0j3XsxNn4tYjfiJb9GjpKzxg638sSYmLHMhDM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="335534002"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="335534002"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 13:52:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="677977037"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="677977037"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Mar 2023 13:52:29 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pakf7-000471-0G;
        Fri, 10 Mar 2023 21:52:29 +0000
Date:   Sat, 11 Mar 2023 05:51:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 1/4] PCI: Introduce pci_dev_for_each_resource()
Message-ID: <202303110550.BLo6P5dS-lkp@intel.com>
References: <20230310171416.23356-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310171416.23356-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus powerpc/next powerpc/fixes linus/master v6.3-rc1 next-20230310]
[cannot apply to soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/PCI-Introduce-pci_dev_for_each_resource/20230311-011642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230310171416.23356-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v4 1/4] PCI: Introduce pci_dev_for_each_resource()
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230311/202303110550.BLo6P5dS-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/059b4a086017fbf2baacdbe0cc454f569f618ffd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/PCI-Introduce-pci_dev_for_each_resource/20230311-011642
        git checkout 059b4a086017fbf2baacdbe0cc454f569f618ffd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303110550.BLo6P5dS-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pnp/quirks.c: In function 'quirk_system_pci_resources':
>> drivers/pnp/quirks.c:245:17: error: implicit declaration of function 'pci_dev_for_each_resource' [-Werror=implicit-function-declaration]
     245 |                 pci_dev_for_each_resource(pdev, r, i) {
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pnp/quirks.c:245:54: error: expected ';' before '{' token
     245 |                 pci_dev_for_each_resource(pdev, r, i) {
         |                                                      ^~
         |                                                      ;
   drivers/pnp/quirks.c:233:16: warning: unused variable 'j' [-Wunused-variable]
     233 |         int i, j;
         |                ^
   drivers/pnp/quirks.c:232:26: warning: unused variable 'res' [-Wunused-variable]
     232 |         struct resource *res, *r;
         |                          ^~~
   cc1: some warnings being treated as errors


vim +/pci_dev_for_each_resource +245 drivers/pnp/quirks.c

   228	
   229	static void quirk_system_pci_resources(struct pnp_dev *dev)
   230	{
   231		struct pci_dev *pdev = NULL;
   232		struct resource *res, *r;
   233		int i, j;
   234	
   235		/*
   236		 * Some BIOSes have PNP motherboard devices with resources that
   237		 * partially overlap PCI BARs.  The PNP system driver claims these
   238		 * motherboard resources, which prevents the normal PCI driver from
   239		 * requesting them later.
   240		 *
   241		 * This patch disables the PNP resources that conflict with PCI BARs
   242		 * so they won't be claimed by the PNP system driver.
   243		 */
   244		for_each_pci_dev(pdev) {
 > 245			pci_dev_for_each_resource(pdev, r, i) {
   246				unsigned long type = resource_type(r);
   247	
   248				if (type != IORESOURCE_IO || type != IORESOURCE_MEM ||
   249				    resource_size(r) == 0)
   250					continue;
   251	
   252				if (r->flags & IORESOURCE_UNSET)
   253					continue;
   254	
   255				for (j = 0;
   256				     (res = pnp_get_resource(dev, type, j)); j++) {
   257					if (res->start == 0 && res->end == 0)
   258						continue;
   259	
   260					/*
   261					 * If the PNP region doesn't overlap the PCI
   262					 * region at all, there's no problem.
   263					 */
   264					if (!resource_overlaps(res, r))
   265						continue;
   266	
   267					/*
   268					 * If the PNP region completely encloses (or is
   269					 * at least as large as) the PCI region, that's
   270					 * also OK.  For example, this happens when the
   271					 * PNP device describes a bridge with PCI
   272					 * behind it.
   273					 */
   274					if (res->start <= r->start && res->end >= r->end)
   275						continue;
   276	
   277					/*
   278					 * Otherwise, the PNP region overlaps *part* of
   279					 * the PCI region, and that might prevent a PCI
   280					 * driver from requesting its resources.
   281					 */
   282					dev_warn(&dev->dev,
   283						 "disabling %pR because it overlaps %s BAR %d %pR\n",
   284						 res, pci_name(pdev), i, r);
   285					res->flags |= IORESOURCE_DISABLED;
   286				}
   287			}
   288		}
   289	}
   290	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
