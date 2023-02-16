Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499C16997C0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjBPOpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBPOpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:45:14 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D97C7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:45:12 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PHd2v3FxfznW8k;
        Thu, 16 Feb 2023 22:42:47 +0800 (CST)
Received: from [10.174.178.198] (10.174.178.198) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Feb 2023 22:45:09 +0800
Message-ID: <1601ce95-5ec7-3656-cdcd-bf052cf6d222@huawei.com>
Date:   Thu, 16 Feb 2023 22:45:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] uio:uio_pci_generic:Don't clear master bit when the
 process does not exit
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <mst@redhat.com>, <linux-kernel@vger.kernel.org>,
        <shikemeng@huawei.com>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, <zhanghongtao22@huawei.com>
References: <20230214132157.472753-1-suweifeng1@huawei.com>
 <Y+uJ6ejVNl6RoQPk@kroah.com>
From:   "Suweifeng (Weifeng, EulerOS)" <suweifeng1@huawei.com>
In-Reply-To: <Y+uJ6ejVNl6RoQPk@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.198]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/14 21:17, Greg KH wrote:
> On Tue, Feb 14, 2023 at 09:21:57PM +0800, Su Weifeng wrote:
>> From: Weifeng Su <suweifeng1@huawei.com>
>>
>> The /dev/uioX device is used by multiple processes. The current behavior
>> is to clear the master bit when a process exits. This affects other
>> processes that use the device, resulting in command suspension and
>> timeout. This behavior cannot be sensed by the process itself.
>> The solution is to add the reference counting. The reference count is
>> self-incremented and self-decremented each time when the device open and
>> close. The master bit is cleared only when the last process exited.
>>
>> Signed-off-by: Weifeng Su <suweifeng1@huawei.com>
>> ---
>>   drivers/uio/uio_pci_generic.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
>> index e03f9b532..d36d3e08e 100644
>> --- a/drivers/uio/uio_pci_generic.c
>> +++ b/drivers/uio/uio_pci_generic.c
>> @@ -31,6 +31,7 @@
>>   struct uio_pci_generic_dev {
>>   	struct uio_info info;
>>   	struct pci_dev *pdev;
>> +	refcount_t  dev_refc;
>>   };
>>   
>>   static inline struct uio_pci_generic_dev *
>> @@ -39,10 +40,22 @@ to_uio_pci_generic_dev(struct uio_info *info)
>>   	return container_of(info, struct uio_pci_generic_dev, info);
>>   }
>>   
>> +static int open(struct uio_info *info, struct inode *inode)
>> +{
>> +	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
>> +
>> +	if (gdev)
>> +		refcount_inc(&gdev->dev_refc);
> 
> This flat out does not work, sorry.
> 
> You should never rely on trying to count open/release calls, just let
> the vfs layer handle that for us as it currently does so.
> 
> Think about what happens if you call dup() in userspace on a
> filehandle...
> 
>> +	return 0;
>> +}
>> +
>>   static int release(struct uio_info *info, struct inode *inode)
>>   {
>>   	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
>>   
>> +	if (gdev && refcount_dec_not_one(&gdev->dev_refc))
> 
> I don't think you actually tested this as it is impossible for gdev to
> ever be NULL.
> 
> sorry, but this patch is not correct.
> 
> greg k-h

First of all, thank you for taking the time to read this patch, your 
comments are very enlightening, but I do have a strange problem here, I 
test such programs on kernels 5.10 and 6.2.
fd = open("/dev/uio0". O_RDWR);
while (true)
	sleep(1);
This program only opens the uio device. After starting multiple such 
processes, I close one of them. From the added print, it can be seen 
that the "uio_pci_generic.c:release" function is called and the master 
bit is cleared, instead of being called when the last process exits as 
expected. I think the vfs is not protected as it should be. Such a 
problem cannot be handled in the user-mode program. We have to clear the 
master bit when the last process exits. Otherwise, user-mode programs 
(for example, the DPDK process that uses uio_pci_generic) cannot work 
properly.

Best regards,
Weifeng Su
