Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCBE5BC1BB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 05:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiISDVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 23:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISDVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 23:21:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DC4627E;
        Sun, 18 Sep 2022 20:21:33 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MW8xM1kQYzlVyV;
        Mon, 19 Sep 2022 11:17:27 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 11:21:31 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 11:21:31 +0800
Subject: Re: [PATCH v8 2/3] Documentation: add a isolation strategy sysfs node
 for uacce
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20220902031304.37516-1-yekai13@huawei.com>
 <20220902031304.37516-3-yekai13@huawei.com> <Yxr5BpM+VIjKhVpZ@kroah.com>
CC:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <liulongfang@huawei.com>
From:   "yekai (A)" <yekai13@huawei.com>
Message-ID: <45a50cf5-7416-4fcf-925b-ecca787425a5@huawei.com>
Date:   Mon, 19 Sep 2022 11:21:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Yxr5BpM+VIjKhVpZ@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/9 16:27, Greg KH wrote:
> On Fri, Sep 02, 2022 at 03:13:03AM +0000, Kai Ye wrote:
>> Update documentation describing sysfs node that could help to
>> configure isolation strategy for users in the user space. And
>> describing sysfs node that could read the device isolated state.
>>
>> Signed-off-by: Kai Ye <yekai13@huawei.com>
>> ---
>>  Documentation/ABI/testing/sysfs-driver-uacce | 26 ++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
>> index 08f2591138af..af5bc2f326d2 100644
>> --- a/Documentation/ABI/testing/sysfs-driver-uacce
>> +++ b/Documentation/ABI/testing/sysfs-driver-uacce
>> @@ -19,6 +19,32 @@ Contact:        linux-accelerators@lists.ozlabs.org
>>  Description:    Available instances left of the device
>>                  Return -ENODEV if uacce_ops get_available_instances is not provided
>>  
>> +What:           /sys/class/uacce/<dev_name>/isolate_strategy
>> +Date:           Sep 2022
>> +KernelVersion:  6.0
>> +Contact:        linux-accelerators@lists.ozlabs.org
>> +Description:    (RW) Configure the frequency size for the hardware error
>> +                isolation strategy. This size is a configured integer value.
>> +                The default is 0. The maximum value is 65535. This value is a
>> +                threshold based on your driver strategies.
> I do not understand what the units are here.
>
> How is anyone supposed to know what they are?

This unit is the number of times. Number of occurrences in a period, also means threshold.
If the number of device pci AER error exceeds the threshold in a time window, the device is
isolated. 

>> +                For example, in the hisilicon accelerator engine, first we will
>> +                time-stamp every slot AER error. Then check the AER error log
>> +                when the device AER error occurred. if the device slot AER error
>> +                count exceeds the preset the number of times in one hour, the
>> +                isolated state will be set to true. So the device will be
>> +                isolated. And the AER error log that exceed one hour will be
>> +                cleared. Of course, different strategies can be defined in
>> +                different drivers.
> So this file can contain values of different units depending on the
> different driver that creates it?  How is anyone supposed to know what
> it is and what it should be?
>
> This feels very loose, please define this much better so that it can be
> understood and maintained properly.
>
> thanks,
>
> greg k-h
> .
>
Yes,  We started out with the idea of not restricting the different drive,  only specifying the input and output.
Because we think different drivers require different processing  strategy.
