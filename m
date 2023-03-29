Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414516CCFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 03:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjC2B5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 21:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjC2B5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:57:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEA6E2;
        Tue, 28 Mar 2023 18:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680055058; x=1711591058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V/1sXQDCXlzQkKAyuFWjdRLSAuUIQdMwdqg1m6D3HS4=;
  b=ltWPG8muquKMcOmgU80CeG/jwZD3m8caS/fNidMWU2YFQVtDkQgrV4uW
   4JkWdYHPZvsivEL5rCn3XEtvJvZ0WOqiSwaruEg9lZ+0lkeAlL9ZUf1Am
   OraBGVTm4XEEQl9KX564YGDX7qW6J4Wyp0POAwP+dzsF37XG7IXMb+imN
   ou2o2R/EyvkChz4b92cS1SpkNZKTwCXoEj70ZRl78NgaQTwMZnd2jcHYX
   o+C74pgdCbvbn6Es3GRAlrJ7BFHlrLjrqukbFm/AXb/rXNEGGCLNTDiFp
   r0WgyHkyuNQXM/Ji0je62/sU3jiT/jYAD/NVKrUgDcERH7rU/G0bfIckG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="403366973"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="403366973"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 18:57:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="714443074"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="714443074"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Mar 2023 18:57:34 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phL45-000J4j-2U;
        Wed, 29 Mar 2023 01:57:29 +0000
Date:   Wed, 29 Mar 2023 09:56:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Minghao Zhang <quic_minghao@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        linus.walleij@linaro.or
Cc:     oe-kbuild-all@lists.linux.dev,
        Minghao Zhang <quic_minghao@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_satyap@quicinc.com,
        quic_tsoni@quicinc.com
Subject: Re: [PATCH] pinctrl: qcom: Add support to log pin status before
 suspend for TLMM
Message-ID: <202303290928.dSDvzIQo-lkp@intel.com>
References: <1680004791-4216-1-git-send-email-quic_minghao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680004791-4216-1-git-send-email-quic_minghao@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minghao,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next linus/master v6.3-rc4 next-20230328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Minghao-Zhang/pinctrl-qcom-Add-support-to-log-pin-status-before-suspend-for-TLMM/20230328-200200
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/1680004791-4216-1-git-send-email-quic_minghao%40quicinc.com
patch subject: [PATCH] pinctrl: qcom: Add support to log pin status before suspend for TLMM
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230329/202303290928.dSDvzIQo-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5a98341ba812869812018e6f72274e57343aa893
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Minghao-Zhang/pinctrl-qcom-Add-support-to-log-pin-status-before-suspend-for-TLMM/20230328-200200
        git checkout 5a98341ba812869812018e6f72274e57343aa893
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/pinctrl/qcom/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303290928.dSDvzIQo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/qcom/pinctrl-msm.c:1497:6: warning: no previous prototype for 'debug_pintctrl_msm_enable' [-Wmissing-prototypes]
    1497 | void debug_pintctrl_msm_enable(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/qcom/pinctrl-msm.c:1503:6: warning: no previous prototype for 'debug_pintctrl_msm_disable' [-Wmissing-prototypes]
    1503 | void debug_pintctrl_msm_disable(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/debug_pintctrl_msm_enable +1497 drivers/pinctrl/qcom/pinctrl-msm.c

  1496	
> 1497	void debug_pintctrl_msm_enable(void)
  1498	{
  1499		pinctrl_msm_log_mask = true;
  1500	}
  1501	EXPORT_SYMBOL(debug_pintctrl_msm_enable);
  1502	
> 1503	void debug_pintctrl_msm_disable(void)
  1504	{
  1505		pinctrl_msm_log_mask = false;
  1506	}
  1507	EXPORT_SYMBOL(debug_pintctrl_msm_disable);
  1508	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
