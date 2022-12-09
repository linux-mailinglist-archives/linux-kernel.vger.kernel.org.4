Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A269647F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLIImR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIImP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:42:15 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BBF4E402
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 00:42:13 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NT4Hd5vq6zRpqH;
        Fri,  9 Dec 2022 16:41:17 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Dec 2022 16:41:43 +0800
Subject: Re: [PATCH v4 3/5] hisi_acc_vfio_pci: register debugfs for hisilicon
 migration driver
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <alex.williamson@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20221202092625.35075-1-liulongfang@huawei.com>
 <20221202092625.35075-4-liulongfang@huawei.com> <Y4oX4zC0eUbZsmMW@nvidia.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <dd7cecc6-1726-f074-28aa-cb8be4d63f6d@huawei.com>
Date:   Fri, 9 Dec 2022 16:41:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y4oX4zC0eUbZsmMW@nvidia.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



ÔÚ 2022/12/2 23:21, Jason Gunthorpe Ð´µÀ:
> On Fri, Dec 02, 2022 at 05:26:23PM +0800, Longfang Liu wrote:
>> On the debugfs framework of VFIO, register the debug function
>> for the live migration driver of the hisilicon accelerator device.
>>
>> On the basis of the original public debug function, a private debug
>> function is added, so that the single-step debugging function
>> during live migration can be realized.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 250 ++++++++++++++++++
>>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.h    |   9 +
>>  drivers/vfio/pci/vfio_pci_debugfs.c           |  10 +-
>>  3 files changed, 268 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> index eb18edffbd5f..0f35cde6e8ec 100644
>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/anon_inodes.h>
>>  
>>  #include "hisi_acc_vfio_pci.h"
>> +#include "../vfio_pci_debugfs.h"
>>  
>>  /* Return 0 on VM acc device ready, -ETIMEDOUT hardware timeout */
>>  static int qm_wait_dev_not_ready(struct hisi_qm *qm)
>> @@ -609,6 +610,18 @@ hisi_acc_check_int_state(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>>  	}
>>  }
>>  
>> +static void hisi_acc_vf_migf_save(struct hisi_acc_vf_migration_file *src_migf,
>> +	struct hisi_acc_vf_migration_file *dst_migf)
>> +{
>> +	if (!dst_migf)
>> +		return;
>> +
>> +	dst_migf->disabled = false;
>> +	dst_migf->total_length = src_migf->total_length;
>> +	memcpy(&dst_migf->vf_data, &src_migf->vf_data,
>> +		    sizeof(struct acc_vf_data));
>> +}
>> +
>>  static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
>>  {
>>  	mutex_lock(&migf->lock);
>> @@ -621,12 +634,16 @@ static void hisi_acc_vf_disable_fd(struct hisi_acc_vf_migration_file *migf)
>>  static void hisi_acc_vf_disable_fds(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>>  {
>>  	if (hisi_acc_vdev->resuming_migf) {
>> +		hisi_acc_vf_migf_save(hisi_acc_vdev->resuming_migf,
>> +						hisi_acc_vdev->debug_migf);
>>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->resuming_migf);
>>  		fput(hisi_acc_vdev->resuming_migf->filp);
>>  		hisi_acc_vdev->resuming_migf = NULL;
>>  	}
>>  
>>  	if (hisi_acc_vdev->saving_migf) {
>> +		hisi_acc_vf_migf_save(hisi_acc_vdev->saving_migf,
>> +						hisi_acc_vdev->debug_migf);
>>  		hisi_acc_vf_disable_fd(hisi_acc_vdev->saving_migf);
>>  		fput(hisi_acc_vdev->saving_migf->filp);
>>  		hisi_acc_vdev->saving_migf = NULL;
>> @@ -1188,6 +1205,231 @@ static long hisi_acc_vfio_pci_ioctl(struct vfio_device *core_vdev, unsigned int
>>  	return vfio_pci_core_ioctl(core_vdev, cmd, arg);
>>  }
>>  
>> +static int hisi_acc_vf_debug_io(struct vfio_device *vdev)
>> +{
>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
>> +	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
>> +	struct device *dev = vdev->dev;
>> +	u64 data;
>> +	int ret;
>> +
>> +	data = readl(vf_qm->io_base + QM_MB_CMD_SEND_BASE);
>> +	dev_info(dev, "debug mailbox val: 0x%llx\n", data);
>> +
>> +	ret = qm_wait_dev_not_ready(vf_qm);
>> +	if (ret)
>> +		dev_err(dev, "VF device not ready!\n");
> 
> debugfs has helpers for this, you should use debugfs_print_regs32()
> 

I can try it with debugfs_print_regs32().

>> +static int hisi_acc_vf_debug_resume(struct vfio_device *vdev)
>> +{
>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
>> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
>> +	struct device *dev = vdev->dev;
>> +	int ret;
>> +
>> +	ret = vf_qm_state_save(hisi_acc_vdev, migf);
>> +	if (ret) {
>> +		dev_err(dev, "failed to save device data!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = vf_qm_check_match(hisi_acc_vdev, migf);
>> +	if (ret) {
>> +		dev_err(dev, "failed to match the VF!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = vf_qm_load_data(hisi_acc_vdev, migf);
>> +	if (ret) {
>> +		dev_err(dev, "failed to recover the VF!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	vf_qm_fun_reset(&hisi_acc_vdev->vf_qm);
>> +	dev_info(dev, "successful to resume device data!\n");
>> +
>> +	return 0;
>> +}
> 
> This doesn't seem like it belongs in debugfs at all, please just write
> a test progam using normal vfio ioctls to do these steps and put in
> the kernel selftests directory.
> 
>> +static int hisi_acc_vf_debug_save(struct vfio_device *vdev)
>> +{
>> +	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(vdev);
>> +	struct hisi_acc_vf_migration_file *migf = hisi_acc_vdev->debug_migf;
>> +	struct device *dev = vdev->dev;
>> +	int ret;
>> +
>> +	ret = vf_qm_state_save(hisi_acc_vdev, migf);
>> +	if (ret) {
>> +		dev_err(dev, "failed to save device data!\n");
>> +		return -EINVAL;
>> +	}
>> +	dev_info(dev, "successful to save device data!\n");
>> +
>> +	return 0;
>> +}
> 
> Ditto, I don't think debugfs should be accessing the device state
> independently of the main FSM.
> 

Putting it in debugfs is more free than making it into a kernel
self-test,if we want to use it, we don¡¯t need to configure and
compile it.

Thanks,
Longfang.
> Jason
> .
> 
