Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7796CD06B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjC2C6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC2C6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:58:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1AC2686;
        Tue, 28 Mar 2023 19:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680058717; x=1711594717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5LePkkYiHZYDqDkNtKAdQySugvf94qLRBMhTgjYplz4=;
  b=Sdprw4IkP6eXsDtitufSUx/MssjGP2aXQRLiQTq87YpmO+NQ/vOqRaYR
   BhEHYNyeNRYLAfH8QQs0CgO0CJTnqEVmnuFXOHOVTaTiBEAToniJGQe1/
   FaXiZ8tFshk1MN0sadh3e75+AyN+qoA26VroQshG5cim4xG61Rzs/7GB+
   F/CdmqqQCoNxdBY7i7biusuWtIpZIDVxtACgpTtxbRb6/LB9rZ8xajSjR
   Kl6aFqKNZs+LoPtRS/IpcuGu6EWEdEtkB0Gtg/2k68STuj5c28s8Q/FOo
   /2cjkqgqj4o7kO4Mu1dCpOB4tsgh0T287HRaaIQbt2aArdS/7erXG24EX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="342349271"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="342349271"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 19:58:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="827709542"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="827709542"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2023 19:58:33 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phM1A-000J83-0g;
        Wed, 29 Mar 2023 02:58:32 +0000
Date:   Wed, 29 Mar 2023 10:58:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>, jgg@nvidia.com,
        yishaih@nvidia.com, shameerali.kolothum.thodi@huawei.com,
        kevin.tian@intel.com, alex.williamson@redhat.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        tglx@linutronix.de, darwi@linutronix.de, kvm@vger.kernel.org,
        dave.jiang@intel.com, jing2.liu@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tom.zanussi@linux.intel.com,
        reinette.chatre@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 7/8] vfio/pci: Support dynamic MSI-x
Message-ID: <202303291023.2Kc7CcsV-lkp@intel.com>
References: <419f3ba2f732154d8ae079b3deb02d0fdbe3e258.1680038771.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419f3ba2f732154d8ae079b3deb02d0fdbe3e258.1680038771.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

I love your patch! Yet something to improve:

[auto build test ERROR on 197b6b60ae7bc51dd0814953c562833143b292aa]

url:    https://github.com/intel-lab-lkp/linux/commits/Reinette-Chatre/vfio-pci-Consolidate-irq-cleanup-on-MSI-MSI-X-disable/20230329-055735
base:   197b6b60ae7bc51dd0814953c562833143b292aa
patch link:    https://lore.kernel.org/r/419f3ba2f732154d8ae079b3deb02d0fdbe3e258.1680038771.git.reinette.chatre%40intel.com
patch subject: [PATCH V2 7/8] vfio/pci: Support dynamic MSI-x
config: i386-randconfig-a014-20230327 (https://download.01.org/0day-ci/archive/20230329/202303291023.2Kc7CcsV-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/420198d6ba9227a0ef81a2192ca35019fa6439cf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Reinette-Chatre/vfio-pci-Consolidate-irq-cleanup-on-MSI-MSI-X-disable/20230329-055735
        git checkout 420198d6ba9227a0ef81a2192ca35019fa6439cf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/vfio/pci/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303291023.2Kc7CcsV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/vfio/pci/vfio_pci_intrs.c:427:14: error: implicit declaration of function 'pci_msix_can_alloc_dyn' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (msix && pci_msix_can_alloc_dyn(vdev->pdev))
                       ^
   1 error generated.


vim +/pci_msix_can_alloc_dyn +427 drivers/vfio/pci/vfio_pci_intrs.c

   413	
   414	static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
   415					      unsigned int vector, int fd, bool msix)
   416	{
   417		struct pci_dev *pdev = vdev->pdev;
   418		struct vfio_pci_irq_ctx *ctx;
   419		struct msi_map msix_map = {};
   420		bool allow_dyn_alloc = false;
   421		struct eventfd_ctx *trigger;
   422		bool new_ctx = false;
   423		int irq, ret;
   424		u16 cmd;
   425	
   426		/* Only MSI-X allows dynamic allocation. */
 > 427		if (msix && pci_msix_can_alloc_dyn(vdev->pdev))
   428			allow_dyn_alloc = true;
   429	
   430		ctx = vfio_irq_ctx_get(vdev, vector);
   431		if (!ctx && !allow_dyn_alloc)
   432			return -EINVAL;
   433	
   434		irq = pci_irq_vector(pdev, vector);
   435		/* Context and interrupt are always allocated together. */
   436		WARN_ON((ctx && irq == -EINVAL) || (!ctx && irq != -EINVAL));
   437	
   438		if (ctx && ctx->trigger) {
   439			irq_bypass_unregister_producer(&ctx->producer);
   440	
   441			cmd = vfio_pci_memory_lock_and_enable(vdev);
   442			free_irq(irq, ctx->trigger);
   443			if (allow_dyn_alloc) {
   444				msix_map.index = vector;
   445				msix_map.virq = irq;
   446				pci_msix_free_irq(pdev, msix_map);
   447				irq = -EINVAL;
   448			}
   449			vfio_pci_memory_unlock_and_restore(vdev, cmd);
   450			kfree(ctx->name);
   451			eventfd_ctx_put(ctx->trigger);
   452			ctx->trigger = NULL;
   453			if (allow_dyn_alloc) {
   454				vfio_irq_ctx_free(vdev, ctx, vector);
   455				ctx = NULL;
   456			}
   457		}
   458	
   459		if (fd < 0)
   460			return 0;
   461	
   462		if (!ctx) {
   463			ctx = vfio_irq_ctx_alloc_single(vdev, vector);
   464			if (!ctx)
   465				return -ENOMEM;
   466			new_ctx = true;
   467		}
   468	
   469		ctx->name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-msi%s[%d](%s)",
   470				      msix ? "x" : "", vector, pci_name(pdev));
   471		if (!ctx->name) {
   472			ret = -ENOMEM;
   473			goto out_free_ctx;
   474		}
   475	
   476		trigger = eventfd_ctx_fdget(fd);
   477		if (IS_ERR(trigger)) {
   478			ret = PTR_ERR(trigger);
   479			goto out_free_name;
   480		}
   481	
   482		cmd = vfio_pci_memory_lock_and_enable(vdev);
   483		if (msix) {
   484			if (irq == -EINVAL) {
   485				msix_map = pci_msix_alloc_irq_at(pdev, vector, NULL);
   486				if (msix_map.index < 0) {
   487					vfio_pci_memory_unlock_and_restore(vdev, cmd);
   488					ret = msix_map.index;
   489					goto out_put_eventfd_ctx;
   490				}
   491				irq = msix_map.virq;
   492			} else {
   493				/*
   494				 * The MSIx vector table resides in device memory which
   495				 * may be cleared via backdoor resets. We don't allow
   496				 * direct access to the vector table so even if a
   497				 * userspace driver attempts to save/restore around
   498				 * such a reset it would be unsuccessful. To avoid
   499				 * this, restore the cached value of the message prior
   500				 * to enabling.
   501				 */
   502				struct msi_msg msg;
   503	
   504				get_cached_msi_msg(irq, &msg);
   505				pci_write_msi_msg(irq, &msg);
   506			}
   507		}
   508	
   509		ret = request_irq(irq, vfio_msihandler, 0, ctx->name, trigger);
   510		if (ret)
   511			goto out_free_irq_locked;
   512	
   513		vfio_pci_memory_unlock_and_restore(vdev, cmd);
   514	
   515		ctx->producer.token = trigger;
   516		ctx->producer.irq = irq;
   517		ret = irq_bypass_register_producer(&ctx->producer);
   518		if (unlikely(ret)) {
   519			dev_info(&pdev->dev,
   520			"irq bypass producer (token %p) registration fails: %d\n",
   521			ctx->producer.token, ret);
   522	
   523			ctx->producer.token = NULL;
   524		}
   525		ctx->trigger = trigger;
   526	
   527		return 0;
   528	
   529	out_free_irq_locked:
   530		if (allow_dyn_alloc && new_ctx) {
   531			msix_map.index = vector;
   532			msix_map.virq = irq;
   533			pci_msix_free_irq(pdev, msix_map);
   534		}
   535		vfio_pci_memory_unlock_and_restore(vdev, cmd);
   536	out_put_eventfd_ctx:
   537		eventfd_ctx_put(trigger);
   538	out_free_name:
   539		kfree(ctx->name);
   540		ctx->name = NULL;
   541	out_free_ctx:
   542		if (allow_dyn_alloc && new_ctx)
   543			vfio_irq_ctx_free(vdev, ctx, vector);
   544		return ret;
   545	}
   546	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
