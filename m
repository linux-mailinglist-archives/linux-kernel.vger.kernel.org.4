Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61C865CC11
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 04:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbjADDKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 22:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjADDKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 22:10:19 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D018BF7C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 19:10:17 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nmvh21FfRznTVg;
        Wed,  4 Jan 2023 11:08:50 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 11:10:15 +0800
Subject: Re: [PATCH v5 1/5] vfio/migration: Add debugfs to live migration
 driver
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <alex.williamson@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20221217063248.6735-1-liulongfang@huawei.com>
 <20221217063248.6735-2-liulongfang@huawei.com> <Y7RENxZvOfgOuA+v@nvidia.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <5ff89cd4-506a-0009-fca3-7a99e9a81772@huawei.com>
Date:   Wed, 4 Jan 2023 11:10:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y7RENxZvOfgOuA+v@nvidia.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/3 23:05, Jason Gunthorpe Wrote:
> On Sat, Dec 17, 2022 at 02:32:44PM +0800, Longfang Liu wrote:
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
>>  |Debugfs|state   |        |Debugfs|state   |
>>  +-------+--------+        +-------+--------+
>>  |   debug_root   |        |   debug_root   |
>>  +-------+--------+        +-------+--------+
>>
>> debugfs will create a public root directory "vfio_mig" file.
>> then create a "debug_root" file for each live migration VF device.
>> state file: used to get the status of the live migration device.
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
>>  drivers/vfio/pci/Makefile           |  4 ++
>>  drivers/vfio/pci/vfio_pci_core.c    |  3 ++
>>  drivers/vfio/pci/vfio_pci_debugfs.c | 76 +++++++++++++++++++++++++++++
>>  drivers/vfio/pci/vfio_pci_debugfs.h | 30 ++++++++++++
>>  include/linux/vfio.h                |  6 +++
>>  5 files changed, 119 insertions(+)
>>  create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.c
>>  create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.h
>>
>> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
>> index 24c524224da5..efe032623664 100644
>> --- a/drivers/vfio/pci/Makefile
>> +++ b/drivers/vfio/pci/Makefile
>> @@ -4,6 +4,10 @@ vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_con
>>  vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
>>  obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
>>  
>> +ifneq ($(CONFIG_DEBUG_FS),)
>> +	vfio-pci-core-y += vfio_pci_debugfs.o
>> +endif
> 
> This is now how makefile should be written
> 
> vfio-pci-core-$(CONFIG_DEBUG_FS) += vfio_pci_debugfs.o
> 

Ok, here it will be changed on the next patch version.

>> +static int vfio_pci_vf_state_read(struct seq_file *seq, void *data)
>> +{
>> +	struct device *vf_dev = seq->private;
>> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
>> +	struct vfio_device	*vdev = &core_device->vdev;
>> +	enum vfio_device_mig_state state;
>> +
>> +	(void)vdev->mig_ops->migration_get_state(vdev, &state);
> 
> Do not use (void) like this, and why not handle the error?
> 

Ok, here I will add an error handling.

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
>> +void vfio_pci_vf_debugfs_init(struct vfio_device *vdev)
>> +{
>> +	struct device *dev = vdev->dev;
>> +
>> +	vdev->debug_root = debugfs_create_dir(dev_name(dev), vfio_pci_debugfs_root);
>> +
>> +	debugfs_create_devm_seqfile(dev, "state", vdev->debug_root,
>> +				  vfio_pci_vf_state_read);
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
> 
> Why are these exported symbols? The core code should handle this on
> its own.
> 

I included this set of interfaces through the #ifdef CONFIG_DEBUG_FS macro
in vfio_pci_debugfs.h.
If EXPORT_SYMBOL_GPL is not added here, a compilation error will appear:

ERROR: modpost: "vfio_pci_vf_debugfs_exit" [drivers/vfio/pci/hisilicon/hisi-acc-vfio-pci.ko] undefined!
ERROR: modpost: "vfio_pci_vf_debugfs_init" [drivers/vfio/pci/hisilicon/hisi-acc-vfio-pci.ko] undefined!
scripts/Makefile.modpost:126: recipe for target 'Module.symvers' failed

> If the device defines migration_get_state() then the debugfs should be
> created.
> 

The trigger strategy created by the current debugfs is determined in the device
driver according to the setting method of vfio_device_ops.
If vfio_device_ops is enabled with live migration, then its migration_get_state()
will also be enabled.

> Mabye you need an op to populate the driver's debugfs to also trigger
> creating the directory
>

It is also possible to put this trigger strategy in the corresponding device driver, right?
Putting this strategy in this public vfio_pci_debugfs.c will also increase the implementation
complexity of this function.

> Jason
> .
> 
Thanks,
Longfang.
