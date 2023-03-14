Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104956B8EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjCNJmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCNJmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:42:10 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1039693E25
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 02:42:07 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PbT7g0DdDzKmcx;
        Tue, 14 Mar 2023 17:41:51 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 17:42:04 +0800
Subject: Re: [PATCH v8 1/5] vfio/migration: Add debugfs to live migration
 driver
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20230217084831.35783-1-liulongfang@huawei.com>
 <20230217084831.35783-2-liulongfang@huawei.com>
 <20230310164007.301adce8.alex.williamson@redhat.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <34da84f8-5b3d-3195-c6fd-5c40e0205246@huawei.com>
Date:   Tue, 14 Mar 2023 17:42:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230310164007.301adce8.alex.williamson@redhat.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/11 7:40, Alex Williamson wrote:
> On Fri, 17 Feb 2023 16:48:27 +0800
> Longfang Liu <liulongfang@huawei.com> wrote:
> 
>> There are multiple devices, software and operational steps involved
>> in the process of live migration. An error occurred on any node may
>> cause the live migration operation to fail.
>> This complex process makes it very difficult to locate and analyze
>> the cause when the function fails.
>>
>> In order to quickly locate the cause of the problem when the
>> live migration fails, I added a set of debugfs to the vfio
>> live migration driver.
>>                                +-------------------------------------------+
>>                                |                                           |
>>                                |                                           |
>>                                |                  QEMU                     |
>>                                |                                           |
>>                                |                                           |
>>                                +---+----------------------------+----------+
>>                                    |      ^                     |      ^
>>                                    |      |                     |      |
>>  +--------+                        |      |                     |      |
>>  |  vfio  |                        v      |                     v      |
>>  +--------+                     +---------+--+               +---------+--+
>>      ^                          |src vfio_dev|               |dst vfio_dev|
>>      |                          +--+---------+               +--+---------+
>>      |                             |      ^                     |      ^
>>      |                             |      |                     |      |
>>      |                             v      |                     |      |
>>      |  +-----------+         +-----------+----+                |      |
>>      +--+<bdf>file_x+<----+---+migration_attr  |                |      |
>>      |  +-----------+     |   +----------------+                |      |
>>      |                    +---+migration_data  |                |      |
>>      |                    |   +----------------+                |      |
>>      |                    +---+migration_debug |                |      |
>>      |                    |   +----------------+                |      |
>>      |                    |   +----------------+                |      |
>>      |                    +---+migration_state |                |      |
>>      |                        +----------------+                |      |
>>      |                                                          |      |
>>      |  +-----------+         +----------------+                |      |
>>      +--+<bdf>file_y|<----+---+migration_attr  |                |      |
>>         +-----------+     |   +----------------+                |      |
>>                           +---+migration_data  |                |      |
>>                           |   +----------------+<---------------+      |
>>                           +---+migration_debug |                       |
>>                           |   +----------------+                       |
>>                           |   +----------------+                       |
>>                           +---+migration_state +-----------------------+
>>                               +----------------+
>>
>> The entire debugfs directory will be based on the definition of
>> the CONFIG_DEBUG_FS macro. If this macro is not enabled, the
>> interfaces in vfio.h will be empty definitions, and the creation
>> and initialization of the debugfs directory will not be executed.
>>
>> debugfs will create a public root directory "vfio" file.
>> then create a device <bdf> named file for each live migration device.
> 
> dev_name(), it's only <sbdf> for PCI devices.
> 
Yes, this description needs revision.

>> First, create a unified state acquisition file of "migration_state"
>> in this device directory.
>> Then, create your own debugging files independently according to
>> the functional requirements of each device.
>>
>> Here, HiSilicon accelerator creates three debug files:
>> migration_attr: used to obtain the attribute parameters of the
>> current live migration device.
>> migration_data: used to get the live migration data of the current
>> live migration device.
>> migration_debug: Used to debug the current live migration device
>> through commands.
>>
>> The live migration function of the current device can be tested by
>> operating the debug files, and the functional status of the equipment
>> and software at each stage can be tested step by step without
>> performing the complete live migration function. And after the live
>> migration is performed, the migration device data of the live migration
>> can be obtained through the debug files.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  drivers/vfio/Makefile       |  2 +-
>>  drivers/vfio/vfio.h         | 14 +++++++
>>  drivers/vfio/vfio_debugfs.c | 82 +++++++++++++++++++++++++++++++++++++
>>  drivers/vfio/vfio_main.c    |  5 +++
>>  include/linux/vfio.h        |  8 ++++
>>  5 files changed, 110 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/vfio/vfio_debugfs.c
>>
>> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
>> index 70e7dcb302ef..1debcff31d30 100644
>> --- a/drivers/vfio/Makefile
>> +++ b/drivers/vfio/Makefile
>> @@ -7,7 +7,7 @@ vfio-y += vfio_main.o \
>>  vfio-$(CONFIG_IOMMUFD) += iommufd.o
>>  vfio-$(CONFIG_VFIO_CONTAINER) += container.o
>>  vfio-$(CONFIG_VFIO_VIRQFD) += virqfd.o
>> -
>> +vfio-$(CONFIG_DEBUG_FS) += vfio_debugfs.o
>>  obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
>>  obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
>>  obj-$(CONFIG_VFIO_PCI) += pci/
>> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
>> index e9721d8424bc..66c00f97e9cc 100644
>> --- a/drivers/vfio/vfio.h
>> +++ b/drivers/vfio/vfio.h
>> @@ -258,4 +258,18 @@ static inline void vfio_device_put_kvm(struct vfio_device *device)
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_DEBUG_FS
>> +void vfio_debugfs_create_root(void);
>> +void vfio_debugfs_remove_root(void);
>> +
>> +void vfio_vf_debugfs_init(struct vfio_device *vdev);
>> +void vfio_vf_debugfs_exit(struct vfio_device *vdev);
> 
> s/vf_// throughout.
> 
Yes, it is not vf anymore, the function name needs to be modified

>> +#else
>> +static inline void vfio_debugfs_create_root(void) { }
>> +static inline void vfio_debugfs_remove_root(void) { }
>> +
>> +static inline void vfio_vf_debugfs_init(struct vfio_device *vdev) { }
>> +static inline void vfio_vf_debugfs_exit(struct vfio_device *vdev) { }
>> +#endif /* CONFIG_DEBUG_FS */
>> +
>>  #endif
>> diff --git a/drivers/vfio/vfio_debugfs.c b/drivers/vfio/vfio_debugfs.c
>> new file mode 100644
>> index 000000000000..c5df1496fe0e
>> --- /dev/null
>> +++ b/drivers/vfio/vfio_debugfs.c
>> @@ -0,0 +1,82 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2023, HiSilicon Ltd.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/vfio.h>
>> +#include "vfio.h"
>> +
>> +static struct dentry *vfio_debugfs_root;
>> +
>> +static int vfio_vf_state_read(struct seq_file *seq, void *data)
>> +{
>> +	struct device *vf_dev = seq->private;
>> +	struct vfio_device *vdev = container_of(vf_dev, struct vfio_device, device);
>> +	enum vfio_device_mig_state state;
>> +	int ret;
>> +
>> +	ret = vdev->mig_ops->migration_get_state(vdev, &state);
>> +	if (ret) {
>> +		dev_err(vf_dev, "failed to get device migration state");
> 
> Isn't the errno below sufficient?  No need to add the ability to fill
> logs as well.
> 
OK£¬I will remove it in the next version.

>> +		return -EINVAL;
>> +	}
>> +
>> +	switch (state) {
>> +	case VFIO_DEVICE_STATE_RUNNING:
>> +		seq_printf(seq, "%s\n", "RUNNING");
>> +		break;
>> +	case VFIO_DEVICE_STATE_STOP_COPY:
>> +		seq_printf(seq, "%s\n", "STOP_COPY");
>> +		break;
>> +	case VFIO_DEVICE_STATE_STOP:
>> +		seq_printf(seq, "%s\n", "STOP");
>> +		break;
>> +	case VFIO_DEVICE_STATE_RESUMING:
>> +		seq_printf(seq, "%s\n", "RESUMING");
>> +		break;
>> +	case VFIO_DEVICE_STATE_RUNNING_P2P:
>> +		seq_printf(seq, "%s\n", "RESUMING_P2P");
>> +		break;
>> +	case VFIO_DEVICE_STATE_ERROR:
>> +		seq_printf(seq, "%s\n", "ERROR");
>> +		break;
>> +	default:
>> +		seq_printf(seq, "%s\n", "Invalid");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +void vfio_vf_debugfs_init(struct vfio_device *vdev)
>> +{
>> +	struct device *dev = &vdev->device;
>> +
>> +	vdev->debug_root = debugfs_create_dir(dev_name(vdev->dev), vfio_debugfs_root);
>> +
>> +	debugfs_create_devm_seqfile(dev, "migration_state", vdev->debug_root,
>> +				  vfio_vf_state_read);
>> +}
>> +EXPORT_SYMBOL_GPL(vfio_vf_debugfs_init);
>> +
>> +void vfio_vf_debugfs_exit(struct vfio_device *vdev)
>> +{
>> +	debugfs_remove_recursive(vdev->debug_root);
>> +}
>> +EXPORT_SYMBOL_GPL(vfio_vf_debugfs_exit);
> 
> The above two should probably be vfio_device_debugfs_{init,exit}().
> 
OK

>> +
>> +void  vfio_debugfs_create_root(void)
>> +{
>> +	vfio_debugfs_root = debugfs_create_dir("vfio", NULL);
>> +}
>> +EXPORT_SYMBOL_GPL(vfio_debugfs_create_root);
>> +
>> +void  vfio_debugfs_remove_root(void)
>> +{
>> +	debugfs_remove_recursive(vfio_debugfs_root);
>> +	vfio_debugfs_root = NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(vfio_debugfs_remove_root);
> 
> As Jason notes, this becomes part of the vfio module, these latter two
> don't need to be exported to be called by vfio_main.
> 

Let me re-debug to see if I can delete the following exports

> Thanks,
> Alex
> 
Thanks£¬
Longfang

>> +
>> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
>> index 3a597e799918..09772fd3a396 100644
>> --- a/drivers/vfio/vfio_main.c
>> +++ b/drivers/vfio/vfio_main.c
>> @@ -1408,6 +1408,9 @@ static int __init vfio_init(void)
>>  	}
>>  
>>  	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
>> +
>> +	vfio_debugfs_create_root();
>> +
>>  	return 0;
>>  
>>  err_dev_class:
>> @@ -1425,6 +1428,8 @@ static void __exit vfio_cleanup(void)
>>  	vfio_virqfd_exit();
>>  	vfio_group_cleanup();
>>  	xa_destroy(&vfio_device_set_xa);
>> +
>> +	vfio_debugfs_remove_root();
>>  }
>>  
>>  module_init(vfio_init);
>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>> index 93134b023968..fa6b898ebb58 100644
>> --- a/include/linux/vfio.h
>> +++ b/include/linux/vfio.h
>> @@ -63,6 +63,14 @@ struct vfio_device {
>>  	struct iommufd_ctx *iommufd_ictx;
>>  	bool iommufd_attached;
>>  #endif
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +	/*
>> +	 * debug_root is a static property of the vfio_device
>> +	 * which must be set prior to registering the vfio_device.
>> +	 */
>> +	struct dentry *debug_root;
>> +#endif
>>  };
>>  
>>  /**
> 
> .
> 
