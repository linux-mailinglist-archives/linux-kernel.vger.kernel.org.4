Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D84C5B524D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 02:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiILAp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 20:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiILApX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 20:45:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD08914D0A
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 17:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662943522; x=1694479522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=viX+brJTpExQFsglg2LwYvr+BZipezfWZc8sCHKwFqc=;
  b=Omu8r2Y1vkf0t9+00xiutSPoEwD+FgwHsDoUqecuTPHU8+GKGWCb7h7Z
   x1XHqsy+0DMBZIYCSbW8/AX+imbusYM/8oaZqhBNiKVtYNqpuqYHOwJj/
   7DLKzBcRlhMgFkY8l2wZeVX8BhoGS5xnEQYuWfCZiLI700Fqi8WLUEtDw
   kby5Iw0gbSczrh7xmr+3EYTVlLCvpvfM/2ekgTbk8sxgir0JA/P3ZFC6u
   8FkPluXrIMdLwCzCTtqdds5vyHHWRZnp77c8Po7TrfQbnFIo+CxWRCNy8
   mF3/8z4Ey1CwxhVdN/GHPuqWtNWDpFqRDFOqAkZksGxmYFTt/BkNefLja
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="295347871"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="295347871"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 17:45:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="566988592"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Sep 2022 17:45:19 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXXZe-000229-29;
        Mon, 12 Sep 2022 00:45:18 +0000
Date:   Mon, 12 Sep 2022 08:44:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kbuild-all@lists.01.org, Elliot Berman <quic_eberman@quicinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v3] KVM: arm64: Ignore kvm-arm.mode if
 !is_hyp_mode_available()
Message-ID: <202209120812.lW9MTQPf-lkp@intel.com>
References: <20220911214059.2767620-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911214059.2767620-1-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 0982c8d859f8f7022b9fd44d421c7ec721bb41f9]

url:    https://github.com/intel-lab-lkp/linux/commits/Elliot-Berman/KVM-arm64-Ignore-kvm-arm-mode-if-is_hyp_mode_available/20220912-054253
base:   0982c8d859f8f7022b9fd44d421c7ec721bb41f9
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220912/202209120812.lW9MTQPf-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2266c3455ccaa7b42a9a0be751e15a15899d99b8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Elliot-Berman/KVM-arm64-Ignore-kvm-arm-mode-if-is_hyp_mode_available/20220912-054253
        git checkout 2266c3455ccaa7b42a9a0be751e15a15899d99b8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/kvm/arm.c: In function 'early_kvm_mode_cfg':
>> arch/arm64/kvm/arm.c:2281:17: error: expected ';' before 'return'
    2281 |                 return 0;
         |                 ^~~~~~


vim +2281 arch/arm64/kvm/arm.c

  2268	
  2269	static int __init early_kvm_mode_cfg(char *arg)
  2270	{
  2271		if (!arg)
  2272			return -EINVAL;
  2273	
  2274		if (strcmp(arg, "none") == 0) {
  2275			kvm_mode = KVM_MODE_NONE;
  2276			return 0;
  2277		}
  2278	
  2279		if (!is_hyp_mode_available()) {
  2280			pr_warn_once("KVM is not available. Ignoring kvm-arm.mode\n")
> 2281			return 0;
  2282		}
  2283	
  2284		if (strcmp(arg, "protected") == 0) {
  2285			if (!is_kernel_in_hyp_mode())
  2286				kvm_mode = KVM_MODE_PROTECTED;
  2287			else
  2288				pr_warn_once("Protected KVM not available with VHE\n");
  2289	
  2290			return 0;
  2291		}
  2292	
  2293		if (strcmp(arg, "nvhe") == 0 && !WARN_ON(is_kernel_in_hyp_mode())) {
  2294			kvm_mode = KVM_MODE_DEFAULT;
  2295			return 0;
  2296		}
  2297	
  2298		return -EINVAL;
  2299	}
  2300	early_param("kvm-arm.mode", early_kvm_mode_cfg);
  2301	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
