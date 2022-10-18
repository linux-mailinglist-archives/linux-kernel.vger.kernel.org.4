Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84B36024C8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJRGzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJRGzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:55:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C133F13E37
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 23:55:17 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ms4Hs0SlxzmV85;
        Tue, 18 Oct 2022 14:50:33 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 14:55:11 +0800
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 14:55:10 +0800
Subject: Re: [Linuxarm] [PATCH 1/2] hisi_acc_vfio_pci: Add debugfs to
 migration driver
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "John Garry" <john.garry@huawei.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
References: <20221014025757.39415-1-liulongfang@huawei.com>
 <20221014025757.39415-2-liulongfang@huawei.com>
 <42d12308-4777-47a7-a1ae-50dfada050cf@huawei.com>
 <7c041671-71bf-d558-d47a-70296fe5c30e@huawei.com>
 <b8bf06ebd8da46a5a72001bead4b4a09@huawei.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <43a109b8-7cde-7bc6-f05d-73d322cea3c2@huawei.com>
Date:   Tue, 18 Oct 2022 14:55:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b8bf06ebd8da46a5a72001bead4b4a09@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2022/10/17 21:57, Shameerali Kolothum Thodi Wrote:
> 
> 
>> -----Original Message-----
>> From: liulongfang
>> Sent: 17 October 2022 10:21
>> To: John Garry <john.garry@huawei.com>; alex.williamson@redhat.com;
>> jgg@nvidia.com; Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>
>> Cc: cohuck@redhat.com; linux-kernel@vger.kernel.org;
>> linuxarm@openeuler.org
>> Subject: Re: [Linuxarm] [PATCH 1/2] hisi_acc_vfio_pci: Add debugfs to
>> migration driver
>>
>> On 2022/10/14 17:20, John Garry wrote:
>>> On 14/10/2022 03:57, Longfang Liu wrote:
>>>> +static void hisi_acc_vf_debugfs_init(struct hisi_acc_vf_core_device
>> *hisi_acc_vdev)
>>>> +{
>>>> +    struct pci_dev *vf_pdev = hisi_acc_vdev->vf_dev;
>>>> +    struct device *dev = &vf_pdev->dev;
>>>> +    int ret;
>>>> +
>>>> +    if (!atomic_read(&hisi_acc_root_ref))
>>>> +        hisi_acc_debugfs_root = debugfs_create_dir("hisi_vfio_acc",
>> NULL);
>>>> +    atomic_inc(&hisi_acc_root_ref);
>>>> +
>>>
>>> This looks totally racy, such that I wonder why even bother using an atomic
>> for hisi_acc_root_ref.
>>
>>
>> When enabling VF, it is possible for multiple VMs to enable VF at the same
>> time. The atomic variable
>> is used to ensure that only one "hisi_vfio_acc" is created. When other VFs
>> are enabled,
>> it will not be created again, but will be used directly.
>>
>>  Indeed, why is hisi_acc_debugfs_root not created in the driver module init?
>>>
>> Because the normal function of VF is to perform encryption and decryption
>> services, the live migration
>> function is an auxiliary function, which no need to be used in scenarios
>> where only encryption and
>> decryption services are performed.
>>
>> During module init, it can register ops(hisi_acc_vfio_pci_ops) that only
>> perform encryption and
>> decryption services, and can also register with live migration function
>> ops(hisi_acc_vfio_pci_migrn_ops),
>> and this debugfs only needs to register it when the the ops is
>> hisi_acc_vfio_pci_migrn_ops.
> 
> Isn't the ops registration happens at probe()? In any case, I think you can move
> the hisi_acc_debugfs_root creation to module_init() as suggested above
> and avoid the race.
> 

mig_root_ref uses atomic to prevent race, and another function is for reference counting.
Even if this hisi_acc_debugfs_root() is moved to module_init(), this mig_root_ref is still
needed, because the driver needs to ensure that the debugfs file is created when the first
VF is enabled, destroy it when the last VF have unloaded.


> Thanks,
> Shameer
> 
Thanks,
Longfang.
