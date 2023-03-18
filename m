Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C1D6BFBB9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCRRD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjCRRDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:03:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335A01C320
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679159033; x=1710695033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XcB5EbMNvgUpWfINz+kBReMdS53A6Wt/Z9ePb9ARtu8=;
  b=L7MM9c2Ta7aefSTX0bxoTp5iLVnKVTqgvxKT5Sp1OFPlL3FfcJqEA7zC
   GsPxLu2MoQPA4HgZ0fx++uaVTjw/2xk98+tl9j27Ug/80Okw4vi8musRm
   bu4EbwGLS4MC9u8pvAzrXYw68It6VbnYtoGJkypgY/Yb8lYdEV9NxFQPn
   MsrYsZSSr5cCC0qSxcQPqROhv76Q0xbHkBTmGgY+Lz8g04yeGF4VlkwH9
   XCVtJ2ytaVEFZ0wOMI6iR1IOZffTdxpNunWdt+mnnfnntRAGEkKareVPj
   duKAmLKzrod4u9Eq7eI4uL6d3OaGf/La4AWSNKkZo1NqZcY5O0xCg4YmU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="401023820"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="401023820"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 10:03:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="1010006306"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="1010006306"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2023 10:03:50 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdZy9-000AAg-0y;
        Sat, 18 Mar 2023 17:03:49 +0000
Date:   Sun, 19 Mar 2023 01:03:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v5 2/2] optee: add per cpu asynchronous notification
Message-ID: <202303190039.RsU7kCIu-lkp@intel.com>
References: <20230317172859.989650-2-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317172859.989650-2-etienne.carriere@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Etienne,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on robh/for-next krzk-dt/for-next linus/master v6.3-rc2 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Etienne-Carriere/optee-add-per-cpu-asynchronous-notification/20230318-013004
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20230317172859.989650-2-etienne.carriere%40linaro.org
patch subject: [PATCH v5 2/2] optee: add per cpu asynchronous notification
config: arm64-randconfig-s053-20230312 (https://download.01.org/0day-ci/archive/20230319/202303190039.RsU7kCIu-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/58552ace9e840f772ba5cb7d4694e332c74802e8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Etienne-Carriere/optee-add-per-cpu-asynchronous-notification/20230318-013004
        git checkout 58552ace9e840f772ba5cb7d4694e332c74802e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/firmware/smccc/ drivers/tee/optee/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303190039.RsU7kCIu-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/tee/optee/smc_abi.c:1068:45: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct optee_pcpu [noderef] __percpu *pcpu @@     got struct optee_pcpu * @@
   drivers/tee/optee/smc_abi.c:1068:45: sparse:     expected struct optee_pcpu [noderef] __percpu *pcpu
   drivers/tee/optee/smc_abi.c:1068:45: sparse:     got struct optee_pcpu *
>> drivers/tee/optee/smc_abi.c:1097:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct optee_pcpu [noderef] __percpu *p @@     got struct optee_pcpu * @@
   drivers/tee/optee/smc_abi.c:1097:49: sparse:     expected struct optee_pcpu [noderef] __percpu *p
   drivers/tee/optee/smc_abi.c:1097:49: sparse:     got struct optee_pcpu *
>> drivers/tee/optee/smc_abi.c:1069:31: sparse: sparse: dereference of noderef expression
   drivers/tee/optee/smc_abi.c:1099:17: sparse: sparse: dereference of noderef expression

vim +1068 drivers/tee/optee/smc_abi.c

  1065	
  1066	static irqreturn_t notif_pcpu_irq_handler(int irq, void *dev_id)
  1067	{
> 1068		struct optee_pcpu __percpu *pcpu = (struct optee_pcpu *)dev_id;
> 1069		struct optee *optee = pcpu->optee;
  1070	
  1071		if (irq_handler(optee) == IRQ_WAKE_THREAD)
  1072			queue_work(optee->smc.notif_pcpu_wq,
  1073				   &optee->smc.notif_pcpu_work);
  1074	
  1075		return IRQ_HANDLED;
  1076	}
  1077	
  1078	static void notif_pcpu_irq_work_fn(struct work_struct *work)
  1079	{
  1080		struct optee_smc *optee_smc = container_of(work, struct optee_smc,
  1081							   notif_pcpu_work);
  1082		struct optee *optee = container_of(optee_smc, struct optee, smc);
  1083	
  1084		optee_smc_do_bottom_half(optee->ctx);
  1085	}
  1086	
  1087	static int init_pcpu_irq(struct optee *optee, u_int irq)
  1088	{
  1089		struct optee_pcpu __percpu *optee_pcpu;
  1090		int cpu, rc;
  1091	
  1092		optee_pcpu = alloc_percpu(struct optee_pcpu);
  1093		if (!optee_pcpu)
  1094			return -ENOMEM;
  1095	
  1096		for_each_present_cpu(cpu) {
> 1097			struct optee_pcpu __percpu *p = per_cpu_ptr(optee_pcpu, cpu);
  1098	
  1099			p->optee = optee;
  1100		}
  1101	
  1102		rc = request_percpu_irq(irq, notif_pcpu_irq_handler,
  1103					"optee_pcpu_notification", optee_pcpu);
  1104		if (rc)
  1105			goto err_free_pcpu;
  1106	
  1107		INIT_WORK(&optee->smc.notif_pcpu_work, notif_pcpu_irq_work_fn);
  1108		optee->smc.notif_pcpu_wq = create_workqueue("optee_pcpu_notification");
  1109		if (!optee->smc.notif_pcpu_wq) {
  1110			rc = -EINVAL;
  1111			goto err_free_pcpu_irq;
  1112		}
  1113	
  1114		optee->smc.optee_pcpu = optee_pcpu;
  1115		optee->smc.notif_irq = irq;
  1116	
  1117		pcpu_irq_num = irq;
  1118		rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "optee/pcpu-notif:starting",
  1119				       optee_cpuhp_enable_pcpu_irq,
  1120				       optee_cpuhp_disable_pcpu_irq);
  1121		if (!rc)
  1122			rc = -EINVAL;
  1123		if (rc < 0)
  1124			goto err_free_pcpu_irq;
  1125	
  1126		optee->smc.notif_cpuhp_state = rc;
  1127	
  1128		return 0;
  1129	
  1130	err_free_pcpu_irq:
  1131		free_percpu_irq(irq, optee_pcpu);
  1132	err_free_pcpu:
  1133		free_percpu(optee_pcpu);
  1134	
  1135		return rc;
  1136	}
  1137	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
