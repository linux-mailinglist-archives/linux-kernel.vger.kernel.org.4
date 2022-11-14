Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E40627539
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 05:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbiKNEWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 23:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiKNEWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 23:22:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF1560F3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668399703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/PxqSB+ZWaAy0kr4u8QvCLujCShnQRTc22NQiRK9IMQ=;
        b=B6avhRT8qoBLMeMDfNXHVUNmROMCvOmU3tq877bM5yzpf+mJ6YhXZQwXpKpgO3U/8k9MP3
        lk+t+wEEZwBFHRm7VT9NpA1Svgrhry38X/7TtYvLXerfqgOZ1AroXqwnVD+ibl196j/qXc
        n+sm0c7ZySMPjPHp2u9V218VKSpB/dI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-491-6CuyAmIpNOy1EuruQTLSBg-1; Sun, 13 Nov 2022 23:21:41 -0500
X-MC-Unique: 6CuyAmIpNOy1EuruQTLSBg-1
Received: by mail-pf1-f200.google.com with SMTP id u18-20020a627912000000b0056d93d8b8bdso5420641pfc.16
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/PxqSB+ZWaAy0kr4u8QvCLujCShnQRTc22NQiRK9IMQ=;
        b=WrXkdQ5EC5mVRo8V2XjVetoo4donCd2jOKdpPJL4nw+iaazgMc07nTL/HykoZqyejx
         R3dvlwb7W2SVEk4J0QghMTyUVRadorIohYEX4iOftFLsSVqbA4aZHsfjcSpbN5zyp9aF
         Kk/pU/iKrjnX2MBbe84l0bRZXkJBpRsdnYvezqmAEOCphSEMhhgwb4JK6WdlmhJhhQjO
         nOpT2zvtn7IziPjNyId1MlZmV/qHaBepzV8dqSq90+PgjovPHqd0x4Nn7lOCTBbJyRGB
         xD6pyVUjM99RXaPv6IF3Qx9nsQG0Mqz+wyPZeCVxFCMrTyZ0fCXiuUuzQbXV9q9E9qEW
         EQIA==
X-Gm-Message-State: ANoB5pk3EFrBQYDGcoLYodzZ7E09PXdqakKZvAYYJsgAZYq0l+RQ0Hsf
        Uq1lebCnwjXwV2nLC0Hdpl51SdrrWDmcOqU5hu/IqGxVnnXAHTXLK7qbvIUY4l1cZIVy/V4EwNf
        qVSTDATgTnevNUezmezCnQ5kn
X-Received: by 2002:a63:d642:0:b0:46f:d2d4:bac4 with SMTP id d2-20020a63d642000000b0046fd2d4bac4mr10220119pgj.178.1668399700797;
        Sun, 13 Nov 2022 20:21:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7ZM3CWWgOmrZsKXz+1lD6ieOkbU4UzqcrePVHDGP1OMS0RtsVteexvjrcHSmdn+J+iulaunA==
X-Received: by 2002:a63:d642:0:b0:46f:d2d4:bac4 with SMTP id d2-20020a63d642000000b0046fd2d4bac4mr10220096pgj.178.1668399700432;
        Sun, 13 Nov 2022 20:21:40 -0800 (PST)
Received: from [10.72.13.180] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jj3-20020a170903048300b001714c36a6e7sm6005269plb.284.2022.11.13.20.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 20:21:39 -0800 (PST)
Message-ID: <11062911-270a-6018-34a4-8edd50674999@redhat.com>
Date:   Mon, 14 Nov 2022 12:21:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] vp_vdpa: harden the logic of set status
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc:     stefanha@redhat.com, mst@redhat.com,
        virtualization@lists.linux-foundation.org, arei.gonglei@huawei.com,
        yechuan@huawei.com, huangzhichao@huawei.com,
        linux-kernel@vger.kernel.org, xiehong@huawei.com
References: <20221111145505.1232-1-longpeng2@huawei.com>
 <20221111151459.dyz42jclq26ai26q@sgarzare-redhat>
 <0f25506f-b9ca-1578-f944-cfb3936ced50@huawei.com>
 <20221111163548.x6yy2w74gk6biykw@sgarzare-redhat>
 <f8650844-1b28-92f0-5330-c164c95ee7ec@huawei.com>
Content-Language: en-US
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <f8650844-1b28-92f0-5330-c164c95ee7ec@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/11/12 15:33, Longpeng (Mike, Cloud Infrastructure Service Product 
Dept.) 写道:
>
>
> 在 2022/11/12 0:35, Stefano Garzarella 写道:
>> On Fri, Nov 11, 2022 at 11:49:10PM +0800, Longpeng (Mike, Cloud 
>> Infrastructure Service Product Dept.) wrote:
>>>
>>>
>>> 在 2022/11/11 23:14, Stefano Garzarella 写道:
>>>> On Fri, Nov 11, 2022 at 10:55:05PM +0800, Longpeng(Mike) wrote:
>>>>> From: Longpeng <longpeng2@huawei.com>
>>>>>
>>>>> 1. We should not set status to 0 when invoking vp_vdpa_set_status().
>>>>>
>>>>> 2. The driver MUST wait for a read of device_status to return 0 
>>>>> before
>>>>>   reinitializing the device.
>>>>>
>>>>> Signed-off-by: Longpeng <longpeng2@huawei.com>
>>>>> ---
>>>>> drivers/vdpa/virtio_pci/vp_vdpa.c | 11 ++++++++++-
>>>>> 1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c 
>>>>> b/drivers/vdpa/virtio_pci/vp_vdpa.c
>>>>> index d448db0c4de3..d35fac5cde11 100644
>>>>> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>>>>> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>>>>> @@ -212,8 +212,12 @@ static void vp_vdpa_set_status(struct 
>>>>> vdpa_device *vdpa, u8 status)
>>>>> {
>>>>>     struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>>>>>     struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
>>>>> -    u8 s = vp_vdpa_get_status(vdpa);
>>>>
>>>> Is this change really needed?
>>>>
>>> No need to get the status if we try to set status to 0 (trigger BUG).
>>>
>>
>> Okay, but that's the case that should never happen, so IMHO we can 
>> leave it as it is.
>>
> OK.
>
>>>>> +    u8 s;
>>>>> +
>>>>> +    /* We should never be setting status to 0. */
>>>>> +    BUG_ON(status == 0);
>>>>
>>>> IMHO panicking the kernel seems excessive in this case, please use 
>>>> WARN_ON and maybe return earlier.
>>>>
>>> Um...I referenced the vp_reset/vp_set_status,
>>
>> Ah I see, maybe it's an old code, because recently we always try to 
>> avoid BUG_ON().
>>
> OK. The checkpatch.pl script also triggered a waring about it.
> I'll use WARN_ON in next version.
>
>>>
>>>>>
>>>>> +    s = vp_vdpa_get_status(vdpa);
>>>>>     if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
>>>>>         !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
>>>>>         vp_vdpa_request_irq(vp_vdpa);
>>>>> @@ -229,6 +233,11 @@ static int vp_vdpa_reset(struct vdpa_device 
>>>>> *vdpa)
>>>>>     u8 s = vp_vdpa_get_status(vdpa);
>>>>>
>>>>>     vp_modern_set_status(mdev, 0);
>>>>> +    /* After writing 0 to device_status, the driver MUST wait for 
>>>>> a read of
>>>>> +     * device_status to return 0 before reinitializing the device.
>>>>> +     */
>>>>> +    while (vp_modern_get_status(mdev))
>>>>> +        msleep(1);
>>>>
>>>> Should we set a limit after which we give up? A malfunctioning 
>>>> device could keep us here forever.
>>>>
>>> Yes, but the malfunctioning device maybe can not work anymore, how 
>>> to handle it?
>>
>> Maybe we should set the status to broken, but in this case we could 
>> just return an error if we couldn't reset it, how about that?
>>
> It can work, but it seems to violate the specification. Maybe we can 
> also wait for other guys' suggestions and then decide how to handle 
> the exception.


Need more thought but it's not an issue that is introduced in this 
patch, we can do optimization on top.

Probably a warning plus FAILED. Then at least the device can DOS the 
driver which is good for hardening as well.

Thanks


>
>> Thanks,
>> Stefano
>>
>> .
>

