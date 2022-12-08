Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE37A646AB8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLHIkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLHIkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:40:06 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25EC6176F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 00:40:05 -0800 (PST)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NSSHd6BpTzRpsP;
        Thu,  8 Dec 2022 16:39:09 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Dec 2022 16:40:01 +0800
Subject: Re: [PATCH v4 1/5] vfio/migration: Add debugfs to live migration
 driver
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <alex.williamson@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20221202092625.35075-1-liulongfang@huawei.com>
 <20221202092625.35075-2-liulongfang@huawei.com> <Y4oW/ToMZEUnlYZ1@nvidia.com>
 <f17dfd5d-3d65-d51e-426a-e60f7e99a3d6@huawei.com>
 <Y434Pivb5PwzP0TI@nvidia.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <e0c5a5b9-55b5-3c43-61d6-94c80ffd02c1@huawei.com>
Date:   Thu, 8 Dec 2022 16:40:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y434Pivb5PwzP0TI@nvidia.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/12/5 21:55, Jason Gunthorpe Wrote:
> On Mon, Dec 05, 2022 at 09:39:29PM +0800, liulongfang wrote:
>> On 2022/12/2 23:17, Jason Gunthorpe wrote:
>>> On Fri, Dec 02, 2022 at 05:26:21PM +0800, Longfang Liu wrote:
>>>
>>>> +static ssize_t vfio_pci_vf_state_read(struct file *filp, char __user *buffer,
>>>> +			   size_t count, loff_t *pos)
>>>> +{
>>>
>>> This would be better to use debugfs_create_devm_seqfile()
>>>
>>> Then you can simply use seq_printf()
>>>
>>
>> The previous debugfs used this method in my patch.
>> Is it now recommended to use the interface with "devm" ?
> 
> It doesn't matter, the point is not the devm, it is to use the right
> helper for the data you want to expose over debugfs 
>  
>>>> @@ -119,6 +129,8 @@ struct vfio_migration_ops {
>>>>  				   enum vfio_device_mig_state *curr_state);
>>>>  	int (*migration_get_data_size)(struct vfio_device *device,
>>>>  				       unsigned long *stop_copy_length);
>>>> +	int (*migration_get_data)(struct vfio_device *device, char *buffer);
>>>> +	int (*migration_get_attr)(struct vfio_device *device, char
>>>>  				   *buffer);
>>>
>>> Still no to passing through debugfs ops, create these files in the
>>> driver.
>>>
>>
>> If this part is also created and enabled in the device driver, why do we need
>> to put this debugfs in the vfio public framework?
> 
> To create the directory, and the few actually common files
> 

OK, Only use the state as a public function, and create other debug files
inside the driver.

Thanks,
Longfang.
> Jason
> .
> 
