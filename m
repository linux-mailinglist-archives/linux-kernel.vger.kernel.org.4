Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF368685DF2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 04:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjBADg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 22:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjBADg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 22:36:28 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B872845BF0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:36:26 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P66yl0bQ5zfZ45;
        Wed,  1 Feb 2023 11:36:15 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 1 Feb 2023 11:36:24 +0800
Subject: Re: [PATCH v7 5/5] vfio: update live migration device status
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20230120032930.43608-1-liulongfang@huawei.com>
 <20230120032930.43608-6-liulongfang@huawei.com>
 <20230126122808.3c0963f2.alex.williamson@redhat.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <06453add-847e-3969-c313-b93a14ddfd0a@huawei.com>
Date:   Wed, 1 Feb 2023 11:36:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20230126122808.3c0963f2.alex.williamson@redhat.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/27 3:28, Alex Williamson wrote:
> On Fri, 20 Jan 2023 11:29:30 +0800
> Longfang Liu <liulongfang@huawei.com> wrote:
> 
>> migration debugfs needs to perform debug operations based on the
>> status of the current device. If the device is not loaded or has
>> stopped, debugfs does not allow operations.
>>
>> so, after the live migration function is executed and the device is
>> turned off, the device no longer needs to be accessed. At this time,
>> the status of the device needs to be set to stop.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 3 +++
>>  drivers/vfio/pci/mlx5/main.c                   | 3 +++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> index 96e2a021a956..bdb9043f88f1 100644
>> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
>> @@ -1607,6 +1607,9 @@ static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
>>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
>>  	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
>>  
>> +	if (core_vdev->mig_ops)
>> +		hisi_acc_vdev->mig_state = VFIO_DEVICE_STATE_STOP;
>> +
>>  	iounmap(vf_qm->io_base);
>>  	vfio_pci_core_close_device(core_vdev);
>>  }
>> diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
>> index 031ac8cc215d..64b2fe58355a 100644
>> --- a/drivers/vfio/pci/mlx5/main.c
>> +++ b/drivers/vfio/pci/mlx5/main.c
>> @@ -1092,6 +1092,9 @@ static void mlx5vf_pci_close_device(struct vfio_device *core_vdev)
>>  	struct mlx5vf_pci_core_device *mvdev = container_of(
>>  		core_vdev, struct mlx5vf_pci_core_device, core_device.vdev);
>>  
>> +	if (mvdev->migrate_cap)
>> +		mvdev->mig_state = VFIO_DEVICE_STATE_STOP;
>> +
>>  	mlx5vf_cmd_close_migratable(mvdev);
>>  	vfio_pci_core_close_device(core_vdev);
>>  }
> 
> It seems prone to issues to manipulate the migration state outside of
> the driver state machine.  If the device is closed, shouldn't the
> debugfs state interface return -EINVAL?  Thanks,
> 

This operation itself should be paired with the operation of setting mig_state to
the VFIO_DEVICE_STATE_RUNNING state in the open_device of vfio_device_ops.
It's just that this problem was not found when the debugfs function was not added.
In addition, this setting mig_state to VFIO_DEVICE_STATE_STOP state will be used
in hisi_acc_vf_debug_check, which is to prevent the wrong operation of debugfs
through this state, and return -EINVAL.

> Alex
> 
Thanks,
Longfang.
> .
> 
