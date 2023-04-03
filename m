Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CC76D4377
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjDCL1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjDCL1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:27:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0493C2D4A;
        Mon,  3 Apr 2023 04:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680521237; x=1712057237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TpJaxxgvyYIwwvsbOp+DaMX5nbWFA+YkO5xwdnPiHiU=;
  b=NBSPwYUDLhgUBSjGOFbJVSTa+3MEAmZgmSaSpXMLlXcSvEEMmj89akjc
   Ci/MeM7AKuBEHUobgou9TBoHMMbkDYs+a6xLT3TuklhGNoPtLrkuSsPpS
   21yNMGTUtMGkSjssi4DiuIi26WCitRpEzK1baw/nuXPYJBZa3eKKj0d/v
   7q9qX/VRIomvLIpNDRyzW+nQpbuRmiSw9UPDfxbtsTIaeg+4ZbWF/MmTp
   BKUavnQpIgUua4dWz7yHePoyVEcUYreVTpWYVLTeY1kIX51Ez2BB+eK30
   c6XheZvG28sTeIAnJpytolx0fZutmdcUttv2Dr9SCUa+Zy/3vvz7hMFf8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="344423530"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="344423530"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 04:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="750447104"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="750447104"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 Apr 2023 04:27:04 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjIL1-000OEN-0N;
        Mon, 03 Apr 2023 11:27:03 +0000
Date:   Mon, 3 Apr 2023 19:26:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Yajun Deng <yajun.deng@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: drivers with target_index() must set freq_table
Message-ID: <202304031955.76jRZiQR-lkp@intel.com>
References: <53d4ed4e5b18a59a48790434f8146fb207e11c49.1680494945.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53d4ed4e5b18a59a48790434f8146fb207e11c49.1680494945.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.3-rc5 next-20230331]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Viresh-Kumar/cpufreq-drivers-with-target_index-must-set-freq_table/20230403-121021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/53d4ed4e5b18a59a48790434f8146fb207e11c49.1680494945.git.viresh.kumar%40linaro.org
patch subject: [PATCH] cpufreq: drivers with target_index() must set freq_table
config: riscv-randconfig-r003-20230403 (https://download.01.org/0day-ci/archive/20230403/202304031955.76jRZiQR-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/3b521388b742e3d7b9bbba198655408c6d152579
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Viresh-Kumar/cpufreq-drivers-with-target_index-must-set-freq_table/20230403-121021
        git checkout 3b521388b742e3d7b9bbba198655408c6d152579
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/cpufreq/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304031955.76jRZiQR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/cpufreq.c:76:6: warning: no previous prototype for function 'has_target_index' [-Wmissing-prototypes]
   bool has_target_index(void)
        ^
   drivers/cpufreq/cpufreq.c:76:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool has_target_index(void)
   ^
   static 
   1 warning generated.


vim +/has_target_index +76 drivers/cpufreq/cpufreq.c

    75	
  > 76	bool has_target_index(void)
    77	{
    78		return !!cpufreq_driver->target_index;
    79	}
    80	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
