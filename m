Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EFE6429BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiLENnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiLENmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:42:46 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BEC2196
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:42:43 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NQl8L6mDLz15Mvd;
        Mon,  5 Dec 2022 21:41:54 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 21:42:41 +0800
Subject: Re: [PATCH v4 1/5] vfio/migration: Add debugfs to live migration
 driver
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
References: <20221202092625.35075-1-liulongfang@huawei.com>
 <20221202092625.35075-2-liulongfang@huawei.com>
 <b82d39c50be94d95a485ab0b279f2362@huawei.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <bb8b2407-cd61-d046-835d-c938bddfff4c@huawei.com>
Date:   Mon, 5 Dec 2022 21:42:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b82d39c50be94d95a485ab0b279f2362@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/2 18:02, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: liulongfang
>> Sent: 02 December 2022 09:26
>> To: alex.williamson@redhat.com; jgg@nvidia.com; Shameerali Kolothum
>> Thodi <shameerali.kolothum.thodi@huawei.com>; john.garry@huawei.com
>> Cc: cohuck@redhat.com; linux-kernel@vger.kernel.org;
>> linuxarm@openeuler.org; liulongfang <liulongfang@huawei.com>
>> Subject: [PATCH v4 1/5] vfio/migration: Add debugfs to live migration driver
>>
>> There are multiple devices, software and operational steps involved
>> in the process of live migration. An error occurred on any node may
>> cause the live migration operation to fail.
>> This complex process makes it very difficult to locate and analyze
>> the cause when the function fails.
>>
>> In order to quickly locate the cause of the problem when the
>> live migration fails, I added a set of debugfs to the vfio
>> live migration driver.
>>
>>  +------------------------------------------+
>>  |                                          |
>>  |                                          |
>>  |                 QEMU                     |
>>  |                                          |
>>  |                                          |
>>  +-----+-------------------------+----------+
>>        |   ^                     |   ^
>>        v   |                     v   |
>>      +-----+--+                +-----+--+
>>      | src VF |                | dst VF |
>>      +-+------+                +-+------+
>>        |   ^                     |   ^
>>        v   |                     v   |
>>  +-------+-+------+        +-------+-+------+
>>  |       |state   |        |       |state   |
>>  |       +--------+        |       +--------+
>>  |Debugfs|mig_data|        |Debugfs|mig_data|
>>  |       +--------+        |       +--------+
>>  |       |mig_attr|        |       |mig_attr|
>>  +-------+--------+        +-------+--------+
>>  |   debug_root   |        |   debug_root   |
>>  +-------+--------+        +-------+--------+
>>
>> debugfs will create a public root directory "vfio_mig" file.
>> then create a "debug_root" file and three debug files for each
>> live migration VF device.
>> state file: used to get the status of the live migration device.
>> mig_data file: used to get the migration data of the live migration device
>> mig_attr file: used to get device attributes of the live migration device
>> debug_root: used to create your own custom debug files for live
>> migration device drivers.
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
>>  drivers/vfio/pci/Makefile           |   4 +
>>  drivers/vfio/pci/vfio_pci_core.c    |   3 +
>>  drivers/vfio/pci/vfio_pci_debugfs.c | 142 ++++++++++++++++++++++++++++
>>  drivers/vfio/pci/vfio_pci_debugfs.h |  32 +++++++
>>  include/linux/vfio.h                |  12 +++
>>  5 files changed, 193 insertions(+)
>>  create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.c
>>  create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.h
>>
>> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
>> index 24c524224da5..efe032623664 100644
>> --- a/drivers/vfio/pci/Makefile
>> +++ b/drivers/vfio/pci/Makefile
>> @@ -4,6 +4,10 @@ vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o
>> vfio_pci_rdwr.o vfio_pci_con
>>  vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
>>  obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
>>
>> +ifneq ($(CONFIG_DEBUG_FS),)
>> +	vfio-pci-core-y += vfio_pci_debugfs.o
>> +endif
>> +
>>  vfio-pci-y := vfio_pci.o
>>  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
>>  obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 189d4930c276..1d6dd61aef7d 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -28,6 +28,7 @@
>>  #include <linux/nospec.h>
>>  #include <linux/sched/mm.h>
>>
>> +#include "vfio_pci_debugfs.h"
>>  #include "vfio_pci_priv.h"
>>
>>  #define DRIVER_AUTHOR   "Alex Williamson
>> <alex.williamson@redhat.com>"
>> @@ -2548,11 +2549,13 @@
>> EXPORT_SYMBOL_GPL(vfio_pci_core_set_params);
>>
>>  static void vfio_pci_core_cleanup(void)
>>  {
>> +	vfio_pci_debugfs_remove_root();
>>  	vfio_pci_uninit_perm_bits();
>>  }
>>
>>  static int __init vfio_pci_core_init(void)
>>  {
>> +	vfio_pci_debugfs_create_root();
>>  	/* Allocate shared config space permission data used by all devices */
>>  	return vfio_pci_init_perm_bits();
>>  }
>> diff --git a/drivers/vfio/pci/vfio_pci_debugfs.c
>> b/drivers/vfio/pci/vfio_pci_debugfs.c
>> new file mode 100644
>> index 000000000000..94a42869539e
>> --- /dev/null
>> +++ b/drivers/vfio/pci/vfio_pci_debugfs.c
>> @@ -0,0 +1,142 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022, HiSilicon Ltd.
>> + */
>> +
>> +#include <linux/pci.h>
>> +#include <linux/vfio_pci_core.h>
>> +
>> +#include "vfio_pci_debugfs.h"
>> +
>> +#define VFIO_DEV_BUF_LEN		4096
>> +static struct dentry *vfio_pci_debugfs_root;
>> +
>> +static ssize_t vfio_pci_vf_data_dump(struct file *filp, char __user *buffer,
>> +			   size_t count, loff_t *pos)
>> +{
>> +	struct vfio_device	*vdev = filp->private_data;
>> +	char tbuf[VFIO_DEV_BUF_LEN];
>> +	int  len;
>> +
>> +	if (!vdev->mig_ops || !vdev->mig_ops->migration_get_data) {
>> +		dev_err(vdev->dev, "device not support get data!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	len = vdev->mig_ops->migration_get_data(vdev, tbuf);
>> +
>> +	return simple_read_from_buffer(buffer, count, pos, tbuf, len);
>> +}
>> +
>> +static const struct file_operations vfio_vf_data_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = simple_open,
>> +	.read = vfio_pci_vf_data_dump,
>> +};
>> +
>> +static ssize_t vfio_pci_vf_attr_show(struct file *filp, char __user *buffer,
>> +			   size_t count, loff_t *pos)
>> +{
>> +	struct vfio_device	*vdev = filp->private_data;
>> +	char tbuf[VFIO_DEV_BUF_LEN];
>> +	int  len;
>> +
>> +	if (!vdev->mig_ops || !vdev->mig_ops->migration_get_attr) {
>> +		dev_err(vdev->dev, "device not support get attribute!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	len = vdev->mig_ops->migration_get_attr(vdev, tbuf);
>> +
>> +	return simple_read_from_buffer(buffer, count, pos, tbuf, len);
>> +}
>> +
>> +static const struct file_operations vfio_vf_attr_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = simple_open,
>> +	.read = vfio_pci_vf_attr_show,
>> +};
>> +
>> +static ssize_t vfio_pci_vf_state_read(struct file *filp, char __user *buffer,
>> +			   size_t count, loff_t *pos)
>> +{
>> +	struct vfio_device	*vdev = filp->private_data;
>> +	char buf[VFIO_DEV_DBG_LEN];
>> +	enum vfio_device_mig_state state;
>> +	int  len;
>> +
>> +	(void)vdev->mig_ops->migration_get_state(vdev, &state);
>> +	switch (state) {
>> +	case VFIO_DEVICE_STATE_RUNNING:
>> +		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
>> +			"RUNNING\n");
>> +		break;
>> +	case VFIO_DEVICE_STATE_STOP_COPY:
>> +		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
>> +			"STOP_COPY\n");
>> +		break;
>> +	case VFIO_DEVICE_STATE_STOP:
>> +		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
>> +			"STOP\n");
>> +		break;
>> +	case VFIO_DEVICE_STATE_RESUMING:
>> +		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
>> +			"RESUMING\n");
>> +		break;
>> +	case VFIO_DEVICE_STATE_RUNNING_P2P:
>> +		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
>> +			"RESUMING_P2P\n");
>> +		break;
>> +	case VFIO_DEVICE_STATE_ERROR:
>> +		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
>> +			"ERROR\n");
>> +		break;
>> +	default:
>> +		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
>> +			"Invalid\n");
>> +	}
>> +
>> +	return simple_read_from_buffer(buffer, count, pos, buf, len);
>> +}
>> +
>> +static const struct file_operations vfio_vf_state_fops = {
>> +	.owner = THIS_MODULE,
>> +	.open = simple_open,
>> +	.read = vfio_pci_vf_state_read,
>> +};
>> +
>> +void vfio_pci_vf_debugfs_init(struct vfio_device *vdev)
>> +{
>> +	struct device *dev = vdev->dev;
>> +
>> +	vdev->debug_root = debugfs_create_dir(dev_name(dev),
>> vfio_pci_debugfs_root);
>> +	debugfs_create_file("state", 0444, vdev->debug_root,
>> +				  vdev, &vfio_vf_state_fops);
>> +
>> +	debugfs_create_file("mig_data", 0444, vdev->debug_root,
>> +				  vdev, &vfio_vf_data_fops);
>> +
>> +	debugfs_create_file("mig_attr", 0444, vdev->debug_root,
>> +				  vdev, &vfio_vf_attr_fops);
> 
> I would probably avoid creating the mig_attr as well in the common code,
> retaining only the "state" and optional "mig_data" here. 
> 


In the live migration driver, in addition to the device state and device migration data,
the functional attributes of the migrating device should also be a common part.

Thanks,
Longfang.

> 
> Thanks,
> Shameer
> 
>> +}
>> +EXPORT_SYMBOL_GPL(vfio_pci_vf_debugfs_init);
>> +
>> +void vfio_pci_vf_debugfs_exit(struct vfio_device *vdev)
>> +{
>> +	debugfs_remove_recursive(vdev->debug_root);
>> +}
>> +EXPORT_SYMBOL_GPL(vfio_pci_vf_debugfs_exit);
>> +
>> +void  vfio_pci_debugfs_create_root(void)
>> +{
>> +	vfio_pci_debugfs_root = debugfs_create_dir("vfio_mig", NULL);
>> +}
>> +EXPORT_SYMBOL_GPL(vfio_pci_debugfs_create_root);
>> +
>> +void  vfio_pci_debugfs_remove_root(void)
>> +{
>> +	debugfs_remove_recursive(vfio_pci_debugfs_root);
>> +	vfio_pci_debugfs_root = NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(vfio_pci_debugfs_remove_root);
>> +
>> diff --git a/drivers/vfio/pci/vfio_pci_debugfs.h
>> b/drivers/vfio/pci/vfio_pci_debugfs.h
>> new file mode 100644
>> index 000000000000..92031196a637
>> --- /dev/null
>> +++ b/drivers/vfio/pci/vfio_pci_debugfs.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * vfio_pci_debugfs.h - VFIO migration debugfs interface
>> + *
>> + * Copyright (c) 2022, HiSilicon Ltd.
>> + *
>> + * Author: Longfang Liu <liulongfang@huawei.com>
>> + */
>> +
>> +#ifndef __VFIO_PCI_DEBUGFS_H
>> +#define __VFIO_PCI_DEBUGFS_H
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/vfio.h>
>> +
>> +#define VFIO_DEV_DBG_LEN		256
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +void  vfio_pci_debugfs_create_root(void);
>> +void  vfio_pci_debugfs_remove_root(void);
>> +
>> +void vfio_pci_vf_debugfs_init(struct vfio_device *vdev);
>> +void vfio_pci_vf_debugfs_exit(struct vfio_device *vdev);
>> +#else
>> +static inline void vfio_pci_debugfs_create_root(void) { }
>> +static inline void vfio_pci_debugfs_remove_root(void) { }
>> +
>> +static inline void vfio_pci_vf_debugfs_init(struct vfio_device *vdev) { }
>> +static inline void vfio_pci_vf_debugfs_exit(struct vfio_device *vdev) { }
>> +#endif /* CONFIG_DEBUG_FS */
>> +
>> +#endif /* __VFIO_PCI_DEBUGFS_H */
>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>> index 43b67e46a2cb..ee441ccdcc71 100644
>> --- a/include/linux/vfio.h
>> +++ b/include/linux/vfio.h
>> @@ -54,6 +54,12 @@ struct vfio_device {
>>  	struct completion comp;
>>  	struct list_head group_next;
>>  	struct list_head iommu_entry;
>> +
>> +	/*
>> +	 * debug_root is a static property of the vfio_device
>> +	 * which must be set prior to registering the vfio_device.
>> +	 */
>> +	struct dentry *debug_root;
>>  };
>>
>>  /**
>> @@ -110,6 +116,10 @@ struct vfio_device_ops {
>>   * @migration_get_data_size: Optional callback to get the estimated data
>>   *          length that will be required to complete stop copy. It's
>> mandatory for
>>   *          VFIO_DEVICE_FEATURE_MIGRATION migration support.
>> + * @migration_get_data: Optional callback to get the migration data
>> + *         that will be required by vfio debugfs.
>> + * @migration_get_attr: Optional callback to get the device attributes
>> + *         that will be required by vfio debugfs.
>>   */
>>  struct vfio_migration_ops {
>>  	struct file *(*migration_set_state)(
>> @@ -119,6 +129,8 @@ struct vfio_migration_ops {
>>  				   enum vfio_device_mig_state *curr_state);
>>  	int (*migration_get_data_size)(struct vfio_device *device,
>>  				       unsigned long *stop_copy_length);
>> +	int (*migration_get_data)(struct vfio_device *device, char *buffer);
>> +	int (*migration_get_attr)(struct vfio_device *device, char *buffer);
>>  };
>>
>>  /**
>> --
>> 2.24.0
> 
> .
> 
