Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2D168A8C7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 08:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBDHYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 02:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBDHYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 02:24:46 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF1528857;
        Fri,  3 Feb 2023 23:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675495484; x=1707031484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xv4erXaIjU/U2PyCOdDnNNxcvF32iclosxBe50Xccfk=;
  b=U0LcpJyvbI0NHYOoqdfJqmwHBi3ghev6ELepUl5IuyieNzrpctCPIU2Z
   8fGGEOKYsvlIDJC3xsXKe2U2q0UqQ8SiuYCgVfZ4X1u5SW9H/UcXLWsqS
   qbFkb0ipemF1E6yGrgS/gYn0pnp+Q7GK7PprmXM3VU7ceaCv8Va3F6REG
   b9mv4taUuPsxN6WUwzZvzXKcRg+ZpisOrYEc2VKGt/DTGOebBS94TY2vd
   e5z1/7SoZGgL4I+FgxET6P2aqH4KKWiorsNMFA0KsuU39yWcyD/y/vQ1U
   4bpr8zz9gF4IJC9DzM08P9bYFg6ykj8RTsp5SZp1mNdWFhOv6irARnGSy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="308566331"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="308566331"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 23:24:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="659346575"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="659346575"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 Feb 2023 23:24:36 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOCuZ-00017z-2L;
        Sat, 04 Feb 2023 07:24:35 +0000
Date:   Sat, 4 Feb 2023 15:23:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Paul Olaru <paul.olaru@nxp.com>,
        Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-imx <linux-imx@nxp.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2] remoteproc: imx_dsp_rproc: add custom memory copy
 implementation for i.MX DSP Cores
Message-ID: <202302041520.m9CY8p6U-lkp@intel.com>
References: <20230131170436.31280-1-iuliana.prodan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131170436.31280-1-iuliana.prodan@oss.nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iuliana,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on remoteproc/rproc-next]
[also build test WARNING on linus/master v6.2-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Iuliana-Prodan-OSS/remoteproc-imx_dsp_rproc-add-custom-memory-copy-implementation-for-i-MX-DSP-Cores/20230201-011011
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
patch link:    https://lore.kernel.org/r/20230131170436.31280-1-iuliana.prodan%40oss.nxp.com
patch subject: [PATCH v2] remoteproc: imx_dsp_rproc: add custom memory copy implementation for i.MX DSP Cores
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230204/202302041520.m9CY8p6U-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/65bca8739891378a92cf6a5774e2ad72630a4276
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Iuliana-Prodan-OSS/remoteproc-imx_dsp_rproc-add-custom-memory-copy-implementation-for-i-MX-DSP-Cores/20230201-011011
        git checkout 65bca8739891378a92cf6a5774e2ad72630a4276
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:15,
                    from include/linux/clk.h:13,
                    from drivers/remoteproc/imx_dsp_rproc.c:6:
   drivers/remoteproc/imx_dsp_rproc.c: In function 'imx_dsp_rproc_memcpy':
>> drivers/remoteproc/imx_dsp_rproc.c:732:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     732 |         if (!IS_ALIGNED((u64)dest, 4))
         |                         ^
   include/linux/align.h:13:44: note: in definition of macro 'IS_ALIGNED'
      13 | #define IS_ALIGNED(x, a)                (((x) & ((typeof(x))(a) - 1)) == 0)
         |                                            ^
>> drivers/remoteproc/imx_dsp_rproc.c:732:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     732 |         if (!IS_ALIGNED((u64)dest, 4))
         |                         ^
   include/linux/align.h:13:58: note: in definition of macro 'IS_ALIGNED'
      13 | #define IS_ALIGNED(x, a)                (((x) & ((typeof(x))(a) - 1)) == 0)
         |                                                          ^
   drivers/remoteproc/imx_dsp_rproc.c: In function 'imx_dsp_rproc_memset':
   drivers/remoteproc/imx_dsp_rproc.c:776:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     776 |         if (!IS_ALIGNED((u64)addr, 4))
         |                         ^
   include/linux/align.h:13:44: note: in definition of macro 'IS_ALIGNED'
      13 | #define IS_ALIGNED(x, a)                (((x) & ((typeof(x))(a) - 1)) == 0)
         |                                            ^
   drivers/remoteproc/imx_dsp_rproc.c:776:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     776 |         if (!IS_ALIGNED((u64)addr, 4))
         |                         ^
   include/linux/align.h:13:58: note: in definition of macro 'IS_ALIGNED'
      13 | #define IS_ALIGNED(x, a)                (((x) & ((typeof(x))(a) - 1)) == 0)
         |                                                          ^


vim +732 drivers/remoteproc/imx_dsp_rproc.c

   717	
   718	/*
   719	 * Custom memory copy implementation for i.MX DSP Cores
   720	 *
   721	 * The IRAM is part of the HiFi DSP.
   722	 * According to hw specs only 32-bits writes are allowed.
   723	 */
   724	static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
   725	{
   726		const u8 *src_byte = src;
   727		u32 affected_mask;
   728		u32 tmp;
   729		int i, q, r;
   730	
   731		/* destination must be 32bit aligned */
 > 732		if (!IS_ALIGNED((u64)dest, 4))
   733			return -EINVAL;
   734	
   735		q = size / 4;
   736		r = size % 4;
   737	
   738		/* __iowrite32_copy use 32bit size values so divide by 4 */
   739		__iowrite32_copy(dest, src, q);
   740	
   741		if (r) {
   742			affected_mask = (1 << (8 * r)) - 1;
   743	
   744			/* first read the 32bit data of dest, then change affected
   745			 * bytes, and write back to dest.
   746			 * For unaffected bytes, it should not be changed
   747			 */
   748			tmp = ioread32(dest + q * 4);
   749			tmp &= ~affected_mask;
   750	
   751			/* avoid reading after end of source */
   752			for (i = 0; i < r; i++)
   753				tmp |= (src_byte[q * 4 + i] << (8 * i));
   754	
   755			iowrite32(tmp, dest + q * 4);
   756		}
   757	
   758		return 0;
   759	}
   760	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
