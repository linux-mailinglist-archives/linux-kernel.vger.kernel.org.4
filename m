Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286436568D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiL0JSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiL0JSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA9B6582
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672132649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bktaJTYphckb8lHBVzp0LupQSLPFA4q1rNEqzTk5Pg=;
        b=ew05d883WO+YhK+lA8JRgLHyb7fQqkt+iGRJWCl5AMMy1OC9L0uwY/wTAS42911GANc5gI
        b18QCYQj7LDU6O/6P9fNeMkBx6jzm3Ggs1Wx4Qyhoal7SbW5pqBhCvda3o5k895FDG4fd9
        HMzlm0QyXYWgViGs6SGxW/tQMm6eNg0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-159-pyz99Af7Oi6p8BCDSOhPgQ-1; Tue, 27 Dec 2022 04:17:27 -0500
X-MC-Unique: pyz99Af7Oi6p8BCDSOhPgQ-1
Received: by mail-pl1-f199.google.com with SMTP id m13-20020a170902f64d00b001899a70c8f1so9888017plg.14
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bktaJTYphckb8lHBVzp0LupQSLPFA4q1rNEqzTk5Pg=;
        b=gRK1NapuVdUAF5rk785QXfZpzH95NqQHbrqdSizhmQGFSJOzukeIj/HHF16obEzvL9
         IumwTf2Ael3190ghCkZMDEmz9K9QtgEIRtsCHu/KHsM5ygJ1YwdqaZlFeiqH2NkznjA3
         6m5c80cuZXzFHZVuwFur6GUxH8vyHVrhgJDCBB0oP2ZV+g8ezUI1Ine22tzMsoafA6W8
         mxHzEwLTdXeIt/FMMboC3e3C6S3YYuAdKiVizA+atHkwAPT/tja5+HxzOWksawbv5amG
         zJFEQjvb6c/1iyGtfhJP75JgV9V6DUuNLkFkmNa/pX+Ln98D0s5YAOBBpcMC1KYpK30z
         ESiA==
X-Gm-Message-State: AFqh2koLDi1FD7EMHzqTF796z1yJMf77Igl8pPp3jKxPe8uIDNVy45w5
        G5tuVgLeKg52SkSbh6ux11cQeNaNse0NCPwyGc8SeYNCSTH1429OXIVm2vAS8hDDb31vVeQm1cQ
        h2K34g7ly0ryXhMiVylzo5eQz
X-Received: by 2002:a17:902:bf45:b0:189:fa12:c98a with SMTP id u5-20020a170902bf4500b00189fa12c98amr19633296pls.66.1672132646700;
        Tue, 27 Dec 2022 01:17:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs9EjmLJOCvG9yHpAmbhIHrWsBZcO0zpncQsDqCZILYEeGXTIH6gY7wrxLHaEgelRlHT8YkLg==
X-Received: by 2002:a17:902:bf45:b0:189:fa12:c98a with SMTP id u5-20020a170902bf4500b00189fa12c98amr19633282pls.66.1672132646435;
        Tue, 27 Dec 2022 01:17:26 -0800 (PST)
Received: from [10.72.13.143] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903120600b00188a908cbddsm8485162plh.302.2022.12.27.01.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 01:17:26 -0800 (PST)
Message-ID: <1ddb2a26-cbc3-d561-6a0d-24adf206db17@redhat.com>
Date:   Tue, 27 Dec 2022 17:17:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, eperezma@redhat.com,
        edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
        pabeni@redhat.com, davem@davemloft.net
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-5-jasowang@redhat.com>
 <1672107557.0142956-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvzhAFj5HCmP--9DKfCAq_4wPNwsmmg4h0Sbv6ra0+DrQ@mail.gmail.com>
 <20221227014641-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221227014641-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/12/27 14:58, Michael S. Tsirkin 写道:
> On Tue, Dec 27, 2022 at 12:33:53PM +0800, Jason Wang wrote:
>> On Tue, Dec 27, 2022 at 10:25 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>> On Mon, 26 Dec 2022 15:49:08 +0800, Jason Wang <jasowang@redhat.com> wrote:
>>>> We used to busy waiting on the cvq command this tends to be
>>>> problematic since:
>>>>
>>>> 1) CPU could wait for ever on a buggy/malicous device
>>>> 2) There's no wait to terminate the process that triggers the cvq
>>>>     command
>>>>
>>>> So this patch switch to use virtqueue_wait_for_used() to sleep with a
>>>> timeout (1s) instead of busy polling for the cvq command forever. This
>>> I don't think that a fixed 1S is a good choice.
>> Well, it could be tweaked to be a little bit longer.
>>
>> One way, as discussed, is to let the device advertise a timeout then
>> the driver can validate if it's valid and use that timeout. But it
>> needs extension to the spec.
> Controlling timeout from device is a good idea, e.g. hardware devices
> would benefit from a shorter timeout, hypervisor devices from a longer
> timeout or no timeout.


Yes.


>
>>> Some of the DPUs are very
>>> lazy for cvq handle.
>> Such design needs to be revisited, cvq (control path) should have a
>> better priority or QOS than datapath.
> Spec says nothing about this, so driver can't assume this either.


Well, my understanding is that it's more than what spec can define or 
it's a kind of best practice.

The current code is one example, that is, driver may choose to busy poll 
which cause spike.


>
>>> In particular, we will also directly break the device.
>> It's kind of hardening for malicious devices.
> ATM no amount of hardening can prevent a malicious hypervisor from
> blocking the guest. Recovering when a hardware device is broken would be
> nice but I think if we do bother then we should try harder to recover,
> such as by driving device reset.


Probably, but as discussed in another thread, it needs co-operation in 
the upper layer (networking core).


>
>
> Also, does your patch break surprise removal? There's no callback
> in this case ATM.


I think not (see reply in another thread).

Thanks


>
>>> I think it is necessary to add a Virtio-Net parameter to allow users to define
>>> this timeout by themselves. Although I don't think this is a good way.
>> Very hard and unfriendly to the end users.
>>
>> Thanks
>>
>>> Thanks.
>>>
>>>
>>>> gives the scheduler a breath and can let the process can respond to
>>>> asignal. If the device doesn't respond in the timeout, break the
>>>> device.
>>>>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> ---
>>>> Changes since V1:
>>>> - break the device when timeout
>>>> - get buffer manually since the virtio core check more_used() instead
>>>> ---
>>>>   drivers/net/virtio_net.c | 24 ++++++++++++++++--------
>>>>   1 file changed, 16 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index efd9dd55828b..6a2ea64cfcb5 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -405,6 +405,7 @@ static void disable_rx_mode_work(struct virtnet_info *vi)
>>>>        vi->rx_mode_work_enabled = false;
>>>>        spin_unlock_bh(&vi->rx_mode_lock);
>>>>
>>>> +     virtqueue_wake_up(vi->cvq);
>>>>        flush_work(&vi->rx_mode_work);
>>>>   }
>>>>
>>>> @@ -1497,6 +1498,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>>>>        return !oom;
>>>>   }
>>>>
>>>> +static void virtnet_cvq_done(struct virtqueue *cvq)
>>>> +{
>>>> +     virtqueue_wake_up(cvq);
>>>> +}
>>>> +
>>>>   static void skb_recv_done(struct virtqueue *rvq)
>>>>   {
>>>>        struct virtnet_info *vi = rvq->vdev->priv;
>>>> @@ -1984,6 +1990,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
>>>>        return err;
>>>>   }
>>>>
>>>> +static int virtnet_close(struct net_device *dev);
>>>> +
>>>>   /*
>>>>    * Send command via the control virtqueue and check status.  Commands
>>>>    * supported by the hypervisor, as indicated by feature bits, should
>>>> @@ -2026,14 +2034,14 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>>>>        if (unlikely(!virtqueue_kick(vi->cvq)))
>>>>                return vi->ctrl->status == VIRTIO_NET_OK;
>>>>
>>>> -     /* Spin for a response, the kick causes an ioport write, trapping
>>>> -      * into the hypervisor, so the request should be handled immediately.
>>>> -      */
>>>> -     while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>>>> -            !virtqueue_is_broken(vi->cvq))
>>>> -             cpu_relax();
>>>> +     if (virtqueue_wait_for_used(vi->cvq)) {
>>>> +             virtqueue_get_buf(vi->cvq, &tmp);
>>>> +             return vi->ctrl->status == VIRTIO_NET_OK;
>>>> +     }
>>>>
>>>> -     return vi->ctrl->status == VIRTIO_NET_OK;
>>>> +     netdev_err(vi->dev, "CVQ command timeout, break the virtio device.");
>>>> +     virtio_break_device(vi->vdev);
>>>> +     return VIRTIO_NET_ERR;
>>>>   }
>>>>
>>>>   static int virtnet_set_mac_address(struct net_device *dev, void *p)
>>>> @@ -3526,7 +3534,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>>>>
>>>>        /* Parameters for control virtqueue, if any */
>>>>        if (vi->has_cvq) {
>>>> -             callbacks[total_vqs - 1] = NULL;
>>>> +             callbacks[total_vqs - 1] = virtnet_cvq_done;
>>>>                names[total_vqs - 1] = "control";
>>>>        }
>>>>
>>>> --
>>>> 2.25.1
>>>>
>>>> _______________________________________________
>>>> Virtualization mailing list
>>>> Virtualization@lists.linux-foundation.org
>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

