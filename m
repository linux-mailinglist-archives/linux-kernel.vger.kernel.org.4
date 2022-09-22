Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AB85E5CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiIVHvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIVHvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:51:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43228C88A8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:51:45 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MY6n00vMBzMnh9;
        Thu, 22 Sep 2022 15:47:00 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 15:51:42 +0800
Received: from [10.67.102.118] (10.67.102.118) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 15:51:42 +0800
Subject: Re: [PATCH 1/5] hisi_acc_vfio_pci: Fixes a memory leak bug
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
References: <20220915013157.60771-1-liulongfang@huawei.com>
 <20220915013157.60771-2-liulongfang@huawei.com>
 <20220920103443.72654dd7.alex.williamson@redhat.com>
 <YynsesGyvJl26jDI@nvidia.com> <04a17bfa71c440e8a38cba2337a8c6ac@huawei.com>
 <ad6cd915-89c4-299e-03d2-8caab500809a@huawei.com>
 <c39afd09b50b4d5e948369774e9c62c2@huawei.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <d2f1ed3c-f855-ff67-47f7-8955ec922e55@huawei.com>
Date:   Thu, 22 Sep 2022 15:51:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c39afd09b50b4d5e948369774e9c62c2@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/21 15:27, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: liulongfang
>> Sent: 21 September 2022 04:13
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> Jason Gunthorpe <jgg@nvidia.com>; Alex Williamson
>> <alex.williamson@redhat.com>
>> Cc: cohuck@redhat.com; linux-kernel@vger.kernel.org;
>> linuxarm@openeuler.org
>> Subject: Re: [PATCH 1/5] hisi_acc_vfio_pci: Fixes a memory leak bug
>>
>> On 2022/9/21 1:03, Shameerali Kolothum Thodi wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Jason Gunthorpe [mailto:jgg@nvidia.com]
>>>> Sent: 20 September 2022 17:38
>>>> To: Alex Williamson <alex.williamson@redhat.com>
>>>> Cc: liulongfang <liulongfang@huawei.com>; Shameerali Kolothum Thodi
>>>> <shameerali.kolothum.thodi@huawei.com>; cohuck@redhat.com;
>>>> linux-kernel@vger.kernel.org; linuxarm@openeuler.org
>>>> Subject: Re: [PATCH 1/5] hisi_acc_vfio_pci: Fixes a memory leak bug
>>>>
>>>> On Tue, Sep 20, 2022 at 10:34:43AM -0600, Alex Williamson wrote:
>>>>> On Thu, 15 Sep 2022 09:31:53 +0800
>>>>> Longfang Liu <liulongfang@huawei.com> wrote:
>>>>>
>>>>>> During the stop copy phase of live migration, the driver allocates a
>>>>>> memory for the migrated data to save the data.
>>>>>>
>>>>>> When an exception occurs when the driver reads device data, the
>>>>>> driver will report an error to qemu and exit the current migration state.
>>>>>> But this memory is not released, which will lead to a memory leak
>>>>>> problem.
>>>>
>>>> Why isn't it released? The fput() releases it:
>>>>
>>>> static int hisi_acc_vf_release_file(struct inode *inode, struct file *filp) {
>>>> 	struct hisi_acc_vf_migration_file *migf = filp->private_data;
>>>>
>>>> 	hisi_acc_vf_disable_fd(migf);
>>>> 	mutex_destroy(&migf->lock);
>>>> 	kfree(migf);
>>>>         ^^^^^^^^^^
>>>>
>>>> This patch looks wrong to me.
>>>
>>> That's right. Missed that. Sorry of the oversight.
>>>
>> Yes, fput will call release in ops of file, here will call hisi_acc_vf_release_file
>> to complete the release operation of migf, so this patch is unnecessary.
>>
>> But there is another place that needs to be modified:
>> hisi_acc_vf_disable_fd in hisi_acc_vf_disable_fds is not needed,
>> because it will have an fput next. Is this correct?
> 
> I don't think that is correct either. fput() decrements ref count and 
> will only call release() if the count is zero. We have an explicit get_file()
> for the hisi_acc_vf_disable_fds(). Isn't it?
> 
> Thanks,
> Shameer
> 
> 

OK! These are not necessary to be modified, so there is no need to add them to
the patchset. I am going to modify the patchset and send it out in the next
version.

>  
>>> Thanks,
>>> Shameer
>>>
>>> .
>> Thanks,
>> Longfang.
>>>
> .
Thanks,
Longfang.
> 
