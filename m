Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4F26CB0AB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjC0V1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjC0V1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:27:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FE0173E;
        Mon, 27 Mar 2023 14:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679952459; x=1711488459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oY4+vDAxY0246pEy4b081gmn25gIUk5XxHRtZZZXKmo=;
  b=eWcsHfqNyr3bLC4hC5A5r/QvMxVjuWKa/aYC6yPByURrBaRIdiePYa6v
   7QZHL2NxgJAIOIydxuFyd6m1O1Ln/u2KqmK9vXjBciIUuVKWYXhAyrXxz
   AxYp/049jrP/W8LUBd4ZTJDFNbyIBcleViHefoukbPaC5phQiOutE963u
   DCy4okxMDboR158SjW0yREWaLBEltV7KnhJbI4ymPgkBANVy4WjbTvVKB
   DFtSZp+MRYr9EAPLG2/ssZk8IAn9iAwbr3bVOYm77RBBGbWRELex15DSD
   v/riTZo2DqGoFi06fqBqfTQmrRMG7h2IsKLb8vX5OPV8wpgkEiXAt/CTX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="368148896"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="368148896"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:27:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="1013280464"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="1013280464"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Mar 2023 14:27:35 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pguNK-000I1v-2P;
        Mon, 27 Mar 2023 21:27:34 +0000
Date:   Tue, 28 Mar 2023 05:27:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH v4 1/5] firmware: qcom_scm: provide a read-modify-write
 function
Message-ID: <202303280535.acb66sQT-lkp@intel.com>
References: <1679935281-18445-2-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679935281-18445-2-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mukesh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20230327]
[also build test WARNING on v6.3-rc4]
[cannot apply to linusw-pinctrl/devel linusw-pinctrl/for-next linus/master v6.3-rc4 v6.3-rc3 v6.3-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-Ojha/firmware-qcom_scm-provide-a-read-modify-write-function/20230328-004405
patch link:    https://lore.kernel.org/r/1679935281-18445-2-git-send-email-quic_mojha%40quicinc.com
patch subject: [PATCH v4 1/5] firmware: qcom_scm: provide a read-modify-write function
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20230328/202303280535.acb66sQT-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/47c3bb52fbb758e2238a7ab29c00e3188afe9754
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mukesh-Ojha/firmware-qcom_scm-provide-a-read-modify-write-function/20230328-004405
        git checkout 47c3bb52fbb758e2238a7ab29c00e3188afe9754
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/firmware/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303280535.acb66sQT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/qcom_scm.c: In function 'qcom_scm_io_update_field':
>> drivers/firmware/qcom_scm.c:419:49: warning: suggest parentheses around '-' inside '<<' [-Wparentheses]
     419 |         new = (old & ~mask) | (val << ffs(mask) - 1);
         |                                       ~~~~~~~~~~^~~


vim +419 drivers/firmware/qcom_scm.c

   409	
   410	int qcom_scm_io_update_field(phys_addr_t addr, unsigned int mask, unsigned int val)
   411	{
   412		unsigned int old, new;
   413		int ret;
   414	
   415		ret = qcom_scm_io_readl(addr, &old);
   416		if (ret)
   417			return ret;
   418	
 > 419		new = (old & ~mask) | (val << ffs(mask) - 1);
   420	
   421		return qcom_scm_io_writel(addr, new);
   422	}
   423	EXPORT_SYMBOL(qcom_scm_io_update_field);
   424	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
