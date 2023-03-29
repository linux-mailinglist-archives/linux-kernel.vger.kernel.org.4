Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A156CD27D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjC2HF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjC2HFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:05:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302C02D44;
        Wed, 29 Mar 2023 00:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073549; x=1711609549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9u41v9H8aOWFtd7PdN4yDSmbe6IszEMQdg0W0+HYDCM=;
  b=M0P19S5tTtnYMzy4NSp6ttL3yIr10yNcq5jObB/uSNN7sh5D8LhWaost
   H1tNsgpTZ8JdNZzT/z4INDD33LP8gH6LuJx7IK7HuEdhkV+PVXwYdgxCF
   MgOTUwkjE82pgneq13ZRUHLO/JTZpWl8irdCrHgU4SvkbeqoD1/VDAqGC
   S5sSOcBn2BJCQMuTa7i2q6/ah1e2daZpXmKuGZdgNVPMpWnt1YxxdFaZX
   KI1GpqepNUM6TN5apakcAA2iQ6y+jnqOhSOXr05vt6dWdYh66apyKx1xt
   J2xw4aOsJEeiUwLS611T2l6L2QcYZSpvEs0d8TUIZ6+mzodhDRPRMCni2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="321195501"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="321195501"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:05:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="1013903268"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="1013903268"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Mar 2023 00:05:45 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phPsJ-000JIG-1d;
        Wed, 29 Mar 2023 07:05:39 +0000
Date:   Wed, 29 Mar 2023 15:04:46 +0800
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
Message-ID: <202303291448.tIbGIbqh-lkp@intel.com>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linusw-pinctrl/for-next linus/master v6.3-rc4 next-20230328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Minghao-Zhang/pinctrl-qcom-Add-support-to-log-pin-status-before-suspend-for-TLMM/20230328-200200
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/1680004791-4216-1-git-send-email-quic_minghao%40quicinc.com
patch subject: [PATCH] pinctrl: qcom: Add support to log pin status before suspend for TLMM
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230329/202303291448.tIbGIbqh-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303291448.tIbGIbqh-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "_printk_deferred" [drivers/pinctrl/qcom/pinctrl-msm.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
