Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A24B623DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiKJIoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiKJIoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:44:21 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81828275E6;
        Thu, 10 Nov 2022 00:44:20 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7FfD2lFxzpWSg;
        Thu, 10 Nov 2022 16:40:36 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 16:44:17 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 16:44:17 +0800
Subject: Re: [PATCH] drivers: base: transport_class: fix possible memory leak
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lduncan@suse.com>,
        <cleech@redhat.com>, <michael.christie@oracle.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <rafael@kernel.org>
References: <20221110034809.17258-1-yangyingliang@huawei.com>
 <Y2yzwB0IuaVS3AVq@kroah.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <d509e930-779b-866e-9b1f-d58db6abfc43@huawei.com>
Date:   Thu, 10 Nov 2022 16:44:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y2yzwB0IuaVS3AVq@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2022/11/10 16:18, Greg KH wrote:
> On Thu, Nov 10, 2022 at 11:48:09AM +0800, Yang Yingliang wrote:
>> Current some drivers(like iscsi) call transport_register_device()
>> failed, they don't call transport_destroy_device() to release the
>> memory allocated in transport_setup_device(), because they don't
>> know what was done, it should be internal thing to release the
>> resource in register function. So fix this leak by calling destroy
>> function inside register function.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   include/linux/transport_class.h | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/transport_class.h b/include/linux/transport_class.h
>> index 63076fb835e3..f4835250bbfc 100644
>> --- a/include/linux/transport_class.h
>> +++ b/include/linux/transport_class.h
>> @@ -70,8 +70,15 @@ void transport_destroy_device(struct device *);
>>   static inline int
>>   transport_register_device(struct device *dev)
>>   {
>> +	int ret;
>> +
>>   	transport_setup_device(dev);
>> -	return transport_add_device(dev);
>> +	ret = transport_add_device(dev);
>> +	if (ret) {
>> +		transport_destroy_device(dev);
>> +	}
> Please use scripts/checkpatch.pl on your patches before sending them out
Sure, of course. :)
> so you don't get grumpy maintainers asking you to use
> scripts/checkpatch.pl on your patches :)
I sent a fix patch to iscsi system earlier:
https://patchwork.kernel.org/project/linux-scsi/patch/20221109092421.3111613-1-yangyingliang@huawei.com/

Mike give his point in the mail, so I send a new patch keep iscsi 
maintainers Cced.

Thanks,
Yang
>
> thanks,
>
> greg k-h
>
> .
