Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D126267AB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 08:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiKLHdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 02:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbiKLHdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 02:33:15 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FE62FFF9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:33:14 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N8S3D3Q8Pz15MW2;
        Sat, 12 Nov 2022 15:32:56 +0800 (CST)
Received: from [10.174.148.223] (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 15:33:11 +0800
Message-ID: <f8650844-1b28-92f0-5330-c164c95ee7ec@huawei.com>
Date:   Sat, 12 Nov 2022 15:33:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] vp_vdpa: harden the logic of set status
To:     Stefano Garzarella <sgarzare@redhat.com>
CC:     <stefanha@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <arei.gonglei@huawei.com>, <yechuan@huawei.com>,
        <huangzhichao@huawei.com>, <linux-kernel@vger.kernel.org>,
        <xiehong@huawei.com>
References: <20221111145505.1232-1-longpeng2@huawei.com>
 <20221111151459.dyz42jclq26ai26q@sgarzare-redhat>
 <0f25506f-b9ca-1578-f944-cfb3936ced50@huawei.com>
 <20221111163548.x6yy2w74gk6biykw@sgarzare-redhat>
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
In-Reply-To: <20221111163548.x6yy2w74gk6biykw@sgarzare-redhat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100025.china.huawei.com (7.221.188.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/12 0:35, Stefano Garzarella 写道:
> On Fri, Nov 11, 2022 at 11:49:10PM +0800, Longpeng (Mike, Cloud 
> Infrastructure Service Product Dept.) wrote:
>>
>>
>> 在 2022/11/11 23:14, Stefano Garzarella 写道:
>>> On Fri, Nov 11, 2022 at 10:55:05PM +0800, Longpeng(Mike) wrote:
>>>> From: Longpeng <longpeng2@huawei.com>
>>>>
>>>> 1. We should not set status to 0 when invoking vp_vdpa_set_status().
>>>>
>>>> 2. The driver MUST wait for a read of device_status to return 0 before
>>>>   reinitializing the device.
>>>>
>>>> Signed-off-by: Longpeng <longpeng2@huawei.com>
>>>> ---
>>>> drivers/vdpa/virtio_pci/vp_vdpa.c | 11 ++++++++++-
>>>> 1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c 
>>>> b/drivers/vdpa/virtio_pci/vp_vdpa.c
>>>> index d448db0c4de3..d35fac5cde11 100644
>>>> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>>>> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>>>> @@ -212,8 +212,12 @@ static void vp_vdpa_set_status(struct 
>>>> vdpa_device *vdpa, u8 status)
>>>> {
>>>>     struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>>>>     struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>>>> -    u8 s = vp_vdpa_get_status(vdpa);
>>>
>>> Is this change really needed?
>>>
>> No need to get the status if we try to set status to 0 (trigger BUG).
>>
> 
> Okay, but that's the case that should never happen, so IMHO we can leave 
> it as it is.
> 
OK.

>>>> +    u8 s;
>>>> +
>>>> +    /* We should never be setting status to 0. */
>>>> +    BUG_ON(status == 0);
>>>
>>> IMHO panicking the kernel seems excessive in this case, please use 
>>> WARN_ON and maybe return earlier.
>>>
>> Um...I referenced the vp_reset/vp_set_status,
> 
> Ah I see, maybe it's an old code, because recently we always try to 
> avoid BUG_ON().
> 
OK. The checkpatch.pl script also triggered a waring about it.
I'll use WARN_ON in next version.

>>
>>>>
>>>> +    s = vp_vdpa_get_status(vdpa);
>>>>     if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
>>>>         !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
>>>>         vp_vdpa_request_irq(vp_vdpa);
>>>> @@ -229,6 +233,11 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
>>>>     u8 s = vp_vdpa_get_status(vdpa);
>>>>
>>>>     vp_modern_set_status(mdev, 0);
>>>> +    /* After writing 0 to device_status, the driver MUST wait for a 
>>>> read of
>>>> +     * device_status to return 0 before reinitializing the device.
>>>> +     */
>>>> +    while (vp_modern_get_status(mdev))
>>>> +        msleep(1);
>>>
>>> Should we set a limit after which we give up? A malfunctioning device 
>>> could keep us here forever.
>>>
>> Yes, but the malfunctioning device maybe can not work anymore, how to 
>> handle it?
> 
> Maybe we should set the status to broken, but in this case we could just 
> return an error if we couldn't reset it, how about that?
> 
It can work, but it seems to violate the specification. Maybe we can 
also wait for other guys' suggestions and then decide how to handle the 
exception.

> Thanks,
> Stefano
> 
> .
