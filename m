Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8446A5793
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjB1LNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjB1LNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:13:34 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D8A1CAED
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677582813; x=1709118813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G24/opbAUqcXRpUKwjkJGw7GwOgKfog2WaV5I4vX2IM=;
  b=DBLDUxSQb3BmCyhHjemyYhD4QDurxYsMqWJXTa11rMSiXc1QESlR7Whw
   WHt7QLrHTv50zQXxZMQN9fDbGC5QBZplPrZv2Wvb4CQj7zRVTihFYWYnZ
   7i+aAMV57WW8rTh1Ubtv3lOTEV0m0bRHBiiB3DAc6of+iOPqQgrWKllN7
   QDfsdEe1Rc7dXZD0l2ChcmWoDQRDwinFcYJfysNG6Noc7/BNZk0/scUyk
   ufPxtHt2gle/4lhHJoeaw6AxSAq6T2YwjSWSHtvD7tjpi7HdF1Y1wRXOY
   yqRmuT5bwY8FY7SshH9NV+ipON5q0h419QjGLWqwbW28kgLaWKeJrD9mC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="317908759"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="317908759"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 03:13:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="798034600"
X-IronPort-AV: E=Sophos;i="5.98,221,1673942400"; 
   d="scan'208";a="798034600"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2023 03:13:30 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWxvF-0005Kx-0A;
        Tue, 28 Feb 2023 11:13:29 +0000
Date:   Tue, 28 Feb 2023 19:12:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        jasowang@redhat.com, tglx@linutronix.de, hch@lst.de
Cc:     oe-kbuild-all@lists.linux.dev,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/11] vduse: Support automatic irq callback affinity
Message-ID: <202302281954.jRA7Qzq4-lkp@intel.com>
References: <20230228094110.37-6-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228094110.37-6-xieyongji@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xie,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on linus/master next-20230228]
[cannot apply to mst-vhost/linux-next v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xie-Yongji/lib-group_cpus-Export-group_cpus_evenly/20230228-174438
patch link:    https://lore.kernel.org/r/20230228094110.37-6-xieyongji%40bytedance.com
patch subject: [PATCH v3 05/11] vduse: Support automatic irq callback affinity
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230228/202302281954.jRA7Qzq4-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6c15cc28cb814c0e6cb80955bc59517e80c15ae2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xie-Yongji/lib-group_cpus-Export-group_cpus_evenly/20230228-174438
        git checkout 6c15cc28cb814c0e6cb80955bc59517e80c15ae2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/vdpa/vdpa_user/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302281954.jRA7Qzq4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/vdpa/vdpa_user/vduse_dev.c:725:1: warning: no previous prototype for 'create_affinity_masks' [-Wmissing-prototypes]
     725 | create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
         | ^~~~~~~~~~~~~~~~~~~~~


vim +/create_affinity_masks +725 drivers/vdpa/vdpa_user/vduse_dev.c

   723	
   724	struct cpumask *
 > 725	create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
   726	{
   727		unsigned int affvecs = 0, curvec, usedvecs, i;
   728		struct cpumask *masks = NULL;
   729	
   730		if (nvecs > affd->pre_vectors + affd->post_vectors)
   731			affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
   732	
   733		if (!affd->calc_sets)
   734			affd->calc_sets = default_calc_sets;
   735	
   736		affd->calc_sets(affd, affvecs);
   737	
   738		if (!affvecs)
   739			return NULL;
   740	
   741		masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
   742		if (!masks)
   743			return NULL;
   744	
   745		/* Fill out vectors at the beginning that don't need affinity */
   746		for (curvec = 0; curvec < affd->pre_vectors; curvec++)
   747			cpumask_setall(&masks[curvec]);
   748	
   749		for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
   750			unsigned int this_vecs = affd->set_size[i];
   751			int j;
   752			struct cpumask *result = group_cpus_evenly(this_vecs);
   753	
   754			if (!result) {
   755				kfree(masks);
   756				return NULL;
   757			}
   758	
   759			for (j = 0; j < this_vecs; j++)
   760				cpumask_copy(&masks[curvec + j], &result[j]);
   761			kfree(result);
   762	
   763			curvec += this_vecs;
   764			usedvecs += this_vecs;
   765		}
   766	
   767		/* Fill out vectors at the end that don't need affinity */
   768		if (usedvecs >= affvecs)
   769			curvec = affd->pre_vectors + affvecs;
   770		else
   771			curvec = affd->pre_vectors + usedvecs;
   772		for (; curvec < nvecs; curvec++)
   773			cpumask_setall(&masks[curvec]);
   774	
   775		return masks;
   776	}
   777	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
