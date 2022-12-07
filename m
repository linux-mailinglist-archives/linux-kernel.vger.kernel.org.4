Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22EE64504C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLGAYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLGAYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:24:36 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB422222
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 16:24:34 -0800 (PST)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NRdHK71G4zJp0Z;
        Wed,  7 Dec 2022 08:21:01 +0800 (CST)
Received: from [10.174.148.223] (10.174.148.223) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 08:24:28 +0800
Message-ID: <863668de-4ecb-34e0-aae6-207e4bea66cd@huawei.com>
Date:   Wed, 7 Dec 2022 08:24:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] vp_vdpa: harden the logic of set status
To:     Stefano Garzarella <sgarzare@redhat.com>
CC:     <stefanha@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <eperezma@redhat.com>, <cohuck@redhat.com>,
        <arei.gonglei@huawei.com>, <yechuan@huawei.com>,
        <huangzhichao@huawei.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20221206021321.2400-1-longpeng2@huawei.com>
 <20221206110040.q5i2k7ypojuira2e@sgarzare-redhat>
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
In-Reply-To: <20221206110040.q5i2k7ypojuira2e@sgarzare-redhat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100025.china.huawei.com (7.221.188.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/12/6 19:00, Stefano Garzarella 写道:
> On Tue, Dec 06, 2022 at 10:13:21AM +0800, Longpeng(Mike) wrote:
>> From: Longpeng <longpeng2@huawei.com>
>>
>> 1. We should not set status to 0 when invoking vp_vdpa_set_status(),
>>   trigger a warning in that case.
>>
>> 2. The driver MUST wait for a read of device_status to return 0 before
>>   reinitializing the device. But we also don't want to keep us in an
>>   infinite loop forever, so wait for 5s if we try to reset the device.
>>
>> Signed-off-by: Longpeng <longpeng2@huawei.com>
>> ---
>> Changes v1->v2:
>>  - use WARN_ON instead of BUG_ON. [Stefano]
>>  - use "warning + failed" instead of "infinite loop". [Jason, Stefano]
>>  - use usleep_range instead of msleep (checkpatch). [Longpeng]
>>
>> ---
>> drivers/vdpa/virtio_pci/vp_vdpa.c | 22 ++++++++++++++++++++++
>> 1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c 
>> b/drivers/vdpa/virtio_pci/vp_vdpa.c
>> index 13701c2a1963..a2d3b13ac646 100644
>> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>> @@ -214,6 +214,9 @@ static void vp_vdpa_set_status(struct vdpa_device 
>> *vdpa, u8 status)
>>     struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>>     u8 s = vp_vdpa_get_status(vdpa);
>>
>> +    /* We should never be setting status to 0. */
>> +    WARN_ON(status == 0);
>> +
>>     if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
>>         !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
>>         vp_vdpa_request_irq(vp_vdpa);
>> @@ -222,14 +225,33 @@ static void vp_vdpa_set_status(struct 
>> vdpa_device *vdpa, u8 status)
>>     vp_modern_set_status(mdev, status);
>> }
>>
>> +#define VP_VDPA_RESET_TMOUT_MS 5000 /* 5s */
> 
> What about moving this define on top of this file?
> Near the other macro.
> 
> And I would use TIMEOUT entirely.
> 
Okay.

>> +
>> static int vp_vdpa_reset(struct vdpa_device *vdpa, bool clear)
>> {
>>     struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>>     struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>>     u8 s = vp_vdpa_get_status(vdpa);
>> +    unsigned long timeout;
>>
>>     vp_modern_set_status(mdev, 0);
>>
>> +    /*
>> +     * As the virtio v1.1 spec (4.1.4.3.2) says: After writing 0 to
> 
> I think we can refer to the lates v1.2 (the section should be the same).
> 
Okay, will do in next version, thanks.

>> +     * device_status, the driver MUST wait for a read of device_status
>> +     * to return 0 before reinitializing the device.
>> +     * To avoid keep us here forever, we only wait for 5 seconds.
>> +     */
>> +    timeout = jiffies + msecs_to_jiffies(VP_VDPA_RESET_TMOUT_MS);
>> +    while (vp_modern_get_status(mdev)) {
>> +        usleep_range(1000, 1500);
>> +        if (time_after(jiffies, timeout)) {
>> +            dev_err(&mdev->pci_dev->dev,
>> +                "vp_vdpa: fail to reset device\n");
>> +            return -ETIMEDOUT;
>> +        }
>> +    }
>> +
>>     if (s & VIRTIO_CONFIG_S_DRIVER_OK)
>>         vp_vdpa_free_irq(vp_vdpa);
>>
>> -- 
>> 2.23.0
>>
> 
> The rest LGTM!
> 
> Thanks,
> Stefano
> 
> 
> .
