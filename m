Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4C66C2A40
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjCUGNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjCUGNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:13:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BCB3B0FC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679379206; x=1710915206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hnBlNT0JYpHA6OdQF99prdk7E/49EUK1i8+eAnrjHcQ=;
  b=HrxHBDaUKKqUp+z50IYs+YI7v8g4DV1JbP7FWgIn0F9qUFWn1YvqQnd5
   urn/4/Qmdh9aDTlkK4mwlRO37BboJOnr5phfOvsRU52Xbnx5wvKO+4oxo
   HNAOycWXrGXoxG8u7ItzlxJlxmwofCaLx0+KQEGRjgGkF4JvXOhvZxXqc
   1TUus8pY6YUsK5V6ewnS4iCHQXRVJj7IqDIC96zYvx7hsa9igbq3iNvhH
   kSTmpZqgHrslE4WjNZHYiXLTeva9IuaqOrIR1V0oQe/TEHLu31Tg8Thg6
   11pPpLEYwzCLf8ArMVFsfUcnCDirTxUkEtPe3aF9qTesp9x420qX5bhOV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="340401965"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="340401965"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 23:13:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="713858685"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="713858685"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Mar 2023 23:13:21 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peVFD-000BfE-38;
        Tue, 21 Mar 2023 06:13:15 +0000
Date:   Tue, 21 Mar 2023 14:12:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anatolij Gustschin <agust@denx.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Use of_address_to_resource()
Message-ID: <202303211421.Vzx1L2QW-lkp@intel.com>
References: <20230319163154.225597-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319163154.225597-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes linus/master v6.3-rc3 next-20230321]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Herring/powerpc-Use-of_address_to_resource/20230320-003601
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20230319163154.225597-1-robh%40kernel.org
patch subject: [PATCH] powerpc: Use of_address_to_resource()
config: powerpc-mpc7448_hpc2_defconfig (https://download.01.org/0day-ci/archive/20230321/202303211421.Vzx1L2QW-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f382770f629740b86b433db077440e9b5059628a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rob-Herring/powerpc-Use-of_address_to_resource/20230320-003601
        git checkout f382770f629740b86b433db077440e9b5059628a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/sysdev/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303211421.Vzx1L2QW-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/sysdev/tsi108_dev.c: In function 'get_csrbase':
>> arch/powerpc/sysdev/tsi108_dev.c:50:38: error: invalid type argument of '->' (have 'struct resource')
      50 |                 tsi108_csr_base = res->start;
         |                                      ^~


vim +50 arch/powerpc/sysdev/tsi108_dev.c

    38	
    39	phys_addr_t get_csrbase(void)
    40	{
    41		struct device_node *tsi;
    42	
    43		if (tsi108_csr_base != -1)
    44			return tsi108_csr_base;
    45	
    46		tsi = of_find_node_by_type(NULL, "tsi-bridge");
    47		if (tsi) {
    48			struct resource res;
    49			of_address_to_resource(tsi, 0, &res);
  > 50			tsi108_csr_base = res->start;
    51			of_node_put(tsi);
    52		}
    53		return tsi108_csr_base;
    54	}
    55	EXPORT_SYMBOL(get_csrbase);
    56	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
