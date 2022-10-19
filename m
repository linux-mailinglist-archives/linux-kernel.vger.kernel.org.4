Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFEF603A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJSHSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJSHSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:18:07 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDD574E1B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:18:02 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mshp05zszzJn5w;
        Wed, 19 Oct 2022 15:15:20 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 15:17:46 +0800
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 15:17:45 +0800
Subject: Re: [Linuxarm] [PATCH 1/2] hisi_acc_vfio_pci: Add debugfs to
 migration driver
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     John Garry <john.garry@huawei.com>, <alex.williamson@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20221014025757.39415-1-liulongfang@huawei.com>
 <20221014025757.39415-2-liulongfang@huawei.com>
 <42d12308-4777-47a7-a1ae-50dfada050cf@huawei.com>
 <7c041671-71bf-d558-d47a-70296fe5c30e@huawei.com>
 <Y01GdiFbt2J9La2Y@nvidia.com>
 <9826a418-4a14-aa4a-9eb8-6faf3e43c8e3@huawei.com>
 <Y06Voma/Prezqmag@nvidia.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <c6293062-a20c-490e-9694-4e517b918ccf@huawei.com>
Date:   Wed, 19 Oct 2022 15:17:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y06Voma/Prezqmag@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/10/18 20:01, Jason Gunthorpe Wrote:
> On Tue, Oct 18, 2022 at 03:06:43PM +0800, liulongfang wrote:
>> On 2022/10/17 20:11, Jason Gunthorpe Wrote:
>>> On Mon, Oct 17, 2022 at 05:20:34PM +0800, liulongfang wrote:
>>>> On 2022/10/14 17:20, John Garry wrote:
>>>>> On 14/10/2022 03:57, Longfang Liu wrote:
>>>>>> +static void hisi_acc_vf_debugfs_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
>>>>>> +{
>>>>>> +    struct pci_dev *vf_pdev = hisi_acc_vdev->vf_dev;
>>>>>> +    struct device *dev = &vf_pdev->dev;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    if (!atomic_read(&hisi_acc_root_ref))
>>>>>> +        hisi_acc_debugfs_root = debugfs_create_dir("hisi_vfio_acc", NULL);
>>>>>> +    atomic_inc(&hisi_acc_root_ref);
>>>>>> +
>>>>>
>>>>> This looks totally racy, such that I wonder why even bother using an atomic for hisi_acc_root_ref.
>>>>
>>>>
>>>> When enabling VF, it is possible for multiple VMs to enable VF at the same time. The atomic variable
>>>> is used to ensure that only one "hisi_vfio_acc" is created. When other VFs are enabled,
>>>> it will not be created again, but will be used directly.
>>>
>>> It is still completely racy. Use a lock
>>>

Um! I understand your previous solution. Since we did not put module_init() in the driver,
to avoid competition, we first need to modify the module_init() interface of the driver,
then put debugfs_create_dir() into module_init(), and finally put debugfs_create_file()
into probe().

I will implement this way in the next version.

>>
>> Do you have any suggested solutions?
> 
> If you want to keep it like this, use a lock around the creation.
> 
> Jason
> .
> 
Thanks,
Longfang
