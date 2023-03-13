Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC466B730A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjCMJpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjCMJpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:45:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBA123D87;
        Mon, 13 Mar 2023 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678700711; x=1710236711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1NFfDSORfMlH4hF3O8xRpPjpGjg4L01H/LfaTbjqU6U=;
  b=eIRxiOhuuEnnbvwwaq9luP2eJZaFrSzVYr0QnTS3UuDu9ihXXkAsaolm
   W4QOKqVO9cDn//gXCPubvgonVeEvlkvCqRtnuUctgJg35boGlQvhY6M16
   4YO3cAjxiJaUhc+mRvzoRW+ZP3NKnqDILWGyE1JzFL3FkhH2RHZKaIGH9
   ecBhE5O63La+0q9tQ3le/xhPMx9jbIx6PDX6EZVAcaBaRQeeN7Jcy+my7
   g0mvUqcvlcbGAGR06GcOfU10AKLWQerlFcdZSzUmiFNhoHewzVNj4K76z
   vgvnTwBVTurvyjTLqtMWlVU++3azTALP+qHkMrgzU6+ub0yfbCO/GHC9S
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="334582275"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="334582275"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 02:45:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="711063568"
X-IronPort-AV: E=Sophos;i="5.98,256,1673942400"; 
   d="scan'208";a="711063568"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Mar 2023 02:45:08 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pbejr-0005X1-2d;
        Mon, 13 Mar 2023 09:45:07 +0000
Date:   Mon, 13 Mar 2023 17:44:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Komal Bajaj <quic_kbajaj@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 4/5] soc: qcom: Add LLCC support for multi channel DDR
Message-ID: <202303131704.RIYLnDCZ-lkp@intel.com>
References: <20230313071325.21605-5-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313071325.21605-5-quic_kbajaj@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Komal,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.3-rc2 next-20230310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Komal-Bajaj/soc-qcom-llcc-Refactor-llcc-driver-to-support-multiple-configuration/20230313-151543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230313071325.21605-5-quic_kbajaj%40quicinc.com
patch subject: [PATCH 4/5] soc: qcom: Add LLCC support for multi channel DDR
config: arc-randconfig-r043-20230313 (https://download.01.org/0day-ci/archive/20230313/202303131704.RIYLnDCZ-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ef96faadeb37bb94f77361aef72e2d863fe6e0f9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Komal-Bajaj/soc-qcom-llcc-Refactor-llcc-driver-to-support-multiple-configuration/20230313-151543
        git checkout ef96faadeb37bb94f77361aef72e2d863fe6e0f9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303131704.RIYLnDCZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/soc/qcom/llcc-qcom.c:20:10: fatal error: linux/qcom_scm.h: No such file or directory
      20 | #include <linux/qcom_scm.h>
         |          ^~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +20 drivers/soc/qcom/llcc-qcom.c

  > 20	#include <linux/qcom_scm.h>
    21	#include <linux/soc/qcom/llcc-qcom.h>
    22	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
