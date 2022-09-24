Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8935E875E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 04:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbiIXCVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 22:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiIXCVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 22:21:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAA512C1D0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 19:21:10 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MZCNm4H1bzpVT0;
        Sat, 24 Sep 2022 10:18:16 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 10:21:07 +0800
Message-ID: <a6b50b85-63c1-e464-f758-eee3168048c1@huawei.com>
Date:   Sat, 24 Sep 2022 10:21:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] tty: moxa: add missing pci_disable_device()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <jirislaby@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220923092530.3088080-1-ruanjinjie@huawei.com>
 <Yy2C1gKxIENxMiT3@kroah.com>
 <95e4a84f-dcc6-72cd-69a0-3ba59ea73a9c@huawei.com>
 <Yy2Xo30/WB9rja13@kroah.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <Yy2Xo30/WB9rja13@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/23 19:25, Greg KH wrote:
> On Fri, Sep 23, 2022 at 06:12:03PM +0800, Ruan Jinjie wrote:
>>
>>
>> On 2022/9/23 17:56, Greg KH wrote:
>>> On Fri, Sep 23, 2022 at 05:25:30PM +0800, ruanjinjie wrote:
>>>> Driver should call pci_disable_device() if it returns from
>>>> moxa_pci_probe() with error.
>>>
>>> Why?
>>>
>>> That is not a normal thing to do, as you can disable other PCI devices
>>> attached to it, right?

I think pci_enable_device and pci_disable_device should be paired. If
there are other PCI devices, they will not be disabled because they are
disabled only when reference counting enable_cnt is reduced to 0.

When these devices are initialized, pci_enable_device is called and
reference counting enable_cnt is incremented. Therefore, when the
current device invokes pci_disable_device, other devices are working
normally and have not invoke pci_disable_device. As a result, the value
of enable_cnt is not 0, and the device will not be really disabled.
There's no problem with that.

On the other hand, if there are no other PCI devices attached to it, and
this driver do not call pci_disable_device() if it returns from
moxa_pci_probe() with error or during removal, the device will never be
disabled.

>>>
>>>> Meanwhile, the driver calls pci_enable_device() in
>>>> moxa_pci_probe(), but never calls pci_disable_device() during removal.
>>>
>>> And is that really a problem?
>>>
>>>>
>>>> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
>>>> ---
>>>>  drivers/tty/moxa.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> Do you have this hardware to test with?
>>>
>>> How did you find this issue?
>>>
>>
>> We use static analysis via coccinelle to find the above issue. The
>> command we use is below:
>>
>> spatch -I include -timeout 60 -very_quiet -sp_file
>> pci_disable_device_missing.cocci drivers/tty/moxa.c
> 
> Please test with real hardware and look up what pci_disable_device()
> does.
> 
> greg k-h
