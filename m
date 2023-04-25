Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858B76ED8CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 01:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjDXX2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 19:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjDXX2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 19:28:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8479BD;
        Mon, 24 Apr 2023 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682378895; x=1713914895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tuP9B5Hr7Z651Gr0S6ft3FGq8Z8Th3WtYREYd69oDRo=;
  b=YIGgeRbM7lOhA4cb+wLgFezQRtwcwWD6is2LRSi9RjtvPEOzKdfIW57h
   iXP65nTbscNL+8CDFXAG5uVqYdVq9678dMJoWvQ7kBUPNgrpRoCLp1tpd
   bAy3FEEIhN6MfA6CQK9GeS+sXgqPKtlS1FGv3qk8IqBbq+4CQXYYZSBOk
   KDNfk4SGVUr7H+evHEa+Zbzc9o9dW3gyOvM4ptBk7BOxtzcxNBYL0lzrl
   OAzUls0OZar4/9bGue+dffVfyV/oz7Uplcs59gNfE5fKEArNZ62fWNGRp
   LzecYsAa/QalycSm/Ynt/N5SAiB7MJGVQC+vXt5TrNgJ5Ng9UiX+BXIuI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="344074761"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="344074761"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 16:27:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="939522185"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="939522185"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Apr 2023 16:27:04 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pr5aJ-000iiS-2A;
        Mon, 24 Apr 2023 23:27:03 +0000
Date:   Tue, 25 Apr 2023 07:26:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        dmy@semihalf.com, tn@semihalf.com, dbehr@google.com,
        dbehr@chromium.org, upstream@semihalf.com, dtor@google.com,
        jgg@ziepe.ca, kevin.tian@intel.com, cohuck@redhat.com,
        abhsahu@nvidia.com, yishaih@nvidia.com, yi.l.liu@intel.com,
        kvm@vger.kernel.org, libvir-list@redhat.com,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: Re: [PATCH v2] vfio/pci: Propagate ACPI notifications to user-space
 via eventfd
Message-ID: <202304250702.Jn8hOwUl-lkp@intel.com>
References: <20230424162748.2711945-1-jaz@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424162748.2711945-1-jaz@semihalf.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grzegorz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on awilliam-vfio/for-linus]
[also build test WARNING on linus/master v6.3 next-20230424]
[cannot apply to awilliam-vfio/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Grzegorz-Jaszczyk/vfio-pci-Propagate-ACPI-notifications-to-user-space-via-eventfd/20230425-002935
base:   https://github.com/awilliam/linux-vfio.git for-linus
patch link:    https://lore.kernel.org/r/20230424162748.2711945-1-jaz%40semihalf.com
patch subject: [PATCH v2] vfio/pci: Propagate ACPI notifications to user-space via eventfd
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20230425/202304250702.Jn8hOwUl-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/62d759059cd5e6dab70052027e1b69c5d5cdc0f2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Grzegorz-Jaszczyk/vfio-pci-Propagate-ACPI-notifications-to-user-space-via-eventfd/20230425-002935
        git checkout 62d759059cd5e6dab70052027e1b69c5d5cdc0f2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/vfio/pci/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304250702.Jn8hOwUl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/vfio/pci/vfio_pci_core.c:709:6: warning: no previous prototype for function 'vfio_pci_acpi_notify_close_device' [-Wmissing-prototypes]
   void vfio_pci_acpi_notify_close_device(struct vfio_pci_core_device *vdev)
        ^
   drivers/vfio/pci/vfio_pci_core.c:709:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void vfio_pci_acpi_notify_close_device(struct vfio_pci_core_device *vdev)
   ^
   static 
>> drivers/vfio/pci/vfio_pci_core.c:1029:11: warning: variable 'events' set but not used [-Wunused-but-set-variable]
           __poll_t events;
                    ^
   2 warnings generated.


vim +/vfio_pci_acpi_notify_close_device +709 drivers/vfio/pci/vfio_pci_core.c

   708	
 > 709	void vfio_pci_acpi_notify_close_device(struct vfio_pci_core_device *vdev)
   710	{
   711		struct vfio_acpi_notification *acpi_notify = vdev->acpi_notification;
   712		struct pci_dev *pdev = vdev->pdev;
   713		struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
   714		struct notification_queue *entry, *entry_tmp;
   715		u64 cnt;
   716	
   717		if (!acpi_notify || !acpi_notify->acpi_notify_trigger)
   718			return;
   719	
   720		acpi_remove_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
   721					   vfio_pci_core_acpi_notify);
   722	
   723		eventfd_ctx_remove_wait_queue(acpi_notify->acpi_notify_trigger,
   724					      &acpi_notify->wait, &cnt);
   725	
   726		flush_work(&acpi_notify->acpi_notification_work);
   727	
   728		mutex_lock(&acpi_notify->notification_list_lock);
   729		list_for_each_entry_safe(entry, entry_tmp,
   730					 &acpi_notify->notification_list,
   731					 notify_val_next) {
   732			list_del(&entry->notify_val_next);
   733			kfree(entry);
   734		}
   735		mutex_unlock(&acpi_notify->notification_list_lock);
   736	
   737		eventfd_ctx_put(acpi_notify->acpi_notify_trigger);
   738	
   739		kfree(acpi_notify);
   740	
   741		vdev->acpi_notification = NULL;
   742	}
   743	#else
   744	void vfio_pci_acpi_notify_close_device(struct vfio_pci_core_device *vdev) {}
   745	#endif /* CONFIG_ACPI */
   746	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
