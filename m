Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49F473F605
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjF0HtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjF0Hs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118E8F7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687852093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whaOhWVIaKHzUbZWclTPzFtnTVD/3jITld51dEdWQ0A=;
        b=MaK30NahsOXLpiw5LuaBIl0FvjQ3hcZBApEg0T+GxeU6Ap8qca17buBL2veYiJgVaCw1gs
        ATUU20Z6IjPcM0vhbj4cEh4+xB6/A80oJjfwgOYChlGQHVBjBKzs+n4SJhVMQ/vJ54H6fv
        cIPmLIxLfNfFGUZ6gKFeQJR38cYcci4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-1DGTIHzZM6iJ6CvthQrTZw-1; Tue, 27 Jun 2023 03:48:11 -0400
X-MC-Unique: 1DGTIHzZM6iJ6CvthQrTZw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-988907e1b15so378175766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687852090; x=1690444090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whaOhWVIaKHzUbZWclTPzFtnTVD/3jITld51dEdWQ0A=;
        b=TNVV8++AtL0wS5JWPsMXoVr7KlwSyHgNRvczLmFHXoTecs+v6u2dlRlsFLEZ3EnDfY
         U9LNDzJoUYF4ejrovUkxKn9qur5CPHdB2xOLgceGik5u6ABvU7Si+629tSrJ2TwSGxDa
         thXTHzv7YPYpRaTFCpas760874zUyYSl0MAh3qW99WiKedUM0Poy41eSNVmL0mizLa7T
         HosYuZwA5ZRnwUC3qMC0n6RF93n2Qa+MfdSjXCSobwIvZMJHLz3OuAcYLwHniEkbkdW7
         u51M7C6yYnVCHYRagYNAXkr6UeoTaAA54Z/BWOgf5dqB9MtggCIi/lymill9q8epn9l+
         O11w==
X-Gm-Message-State: AC+VfDzNZ36F20QKmisdTUCsRobJNprLzYVqJBjIrbf6LIhTK96YJlwD
        pqnRVBSgdmuavJD174ZVRNeSrrj3XtIdafBiK/SX4aIQoegEs5KNCWPFPThv2GOhgNs31SsbvQD
        xovP/1qkRE67E5f783Z6plCFD
X-Received: by 2002:a17:906:da84:b0:988:f307:aea7 with SMTP id xh4-20020a170906da8400b00988f307aea7mr21595728ejb.7.1687852090423;
        Tue, 27 Jun 2023 00:48:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ob/ReyhK7BIZNcKDNmnYWuzv3zeM/wIdMcpgjlvuvypLCy8x/HUywv68r17c73ooOglaGQw==
X-Received: by 2002:a17:906:da84:b0:988:f307:aea7 with SMTP id xh4-20020a170906da8400b00988f307aea7mr21595713ejb.7.1687852090093;
        Tue, 27 Jun 2023 00:48:10 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id s16-20020a170906355000b00991ba677d92sm2190941eja.84.2023.06.27.00.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 00:48:09 -0700 (PDT)
Date:   Tue, 27 Jun 2023 09:48:06 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v1 2/4] virtio/vsock: support MSG_PEEK for
 SOCK_SEQPACKET
Message-ID: <4pcexfrdtuisz53c4sb4pse4cyjw7zsuwtqsnnul23njo4ab5l@4jvdk6buxmj3>
References: <20230618062451.79980-1-AVKrasnov@sberdevices.ru>
 <20230618062451.79980-3-AVKrasnov@sberdevices.ru>
 <yiy3kssoiyzs6ehnlo7g2xsb26zee5vih3jpgyc7i3dvfcyfpv@xvokxez3lzpo>
 <9553a82f-ce31-e2e0-ff62-8abd2a6b639b@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9553a82f-ce31-e2e0-ff62-8abd2a6b639b@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 07:34:29AM +0300, Arseniy Krasnov wrote:
>
>
>On 26.06.2023 19:28, Stefano Garzarella wrote:
>> On Sun, Jun 18, 2023 at 09:24:49AM +0300, Arseniy Krasnov wrote:
>>> This adds support of MSG_PEEK flag for SOCK_SEQPACKET type of socket.
>>> Difference with SOCK_STREAM is that this callback returns either length
>>> of the message or error.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>> net/vmw_vsock/virtio_transport_common.c | 63 +++++++++++++++++++++++--
>>> 1 file changed, 60 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>> index 2ee40574c339..352d042b130b 100644
>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>> @@ -460,6 +460,63 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>>     return err;
>>> }
>>>
>>> +static ssize_t
>>> +virtio_transport_seqpacket_do_peek(struct vsock_sock *vsk,
>>> +                   struct msghdr *msg)
>>> +{
>>> +    struct virtio_vsock_sock *vvs = vsk->trans;
>>> +    struct sk_buff *skb;
>>> +    size_t total, len;
>>> +
>>> +    spin_lock_bh(&vvs->rx_lock);
>>> +
>>> +    if (!vvs->msg_count) {
>>> +        spin_unlock_bh(&vvs->rx_lock);
>>> +        return 0;
>>> +    }
>>> +
>>> +    total = 0;
>>> +    len = msg_data_left(msg);
>>> +
>>> +    skb_queue_walk(&vvs->rx_queue, skb) {
>>> +        struct virtio_vsock_hdr *hdr;
>>> +
>>> +        if (total < len) {
>>> +            size_t bytes;
>>> +            int err;
>>> +
>>> +            bytes = len - total;
>>> +            if (bytes > skb->len)
>>> +                bytes = skb->len;
>>> +
>>> +            spin_unlock_bh(&vvs->rx_lock);
>>> +
>>> +            /* sk_lock is held by caller so no one else can dequeue.
>>> +             * Unlock rx_lock since memcpy_to_msg() may sleep.
>>> +             */
>>> +            err = memcpy_to_msg(msg, skb->data, bytes);
>>> +            if (err)
>>> +                return err;
>>> +
>>> +            spin_lock_bh(&vvs->rx_lock);
>>> +        }
>>> +
>>> +        total += skb->len;
>>> +        hdr = virtio_vsock_hdr(skb);
>>> +
>>> +        if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
>>> +            if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOR)
>>> +                msg->msg_flags |= MSG_EOR;
>>> +
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    spin_unlock_bh(&vvs->rx_lock);
>>> +
>>> +    return total;
>>
>> Should we return the minimum between total and len?
>
>I guess no, because seqpacket dequeue callback always returns length of message,
>then, in af_vsock.c we return either number of bytes read or length of message
>depending on MSG_TRUNC flags.

Right! We should always return the total lenght of the packet.

Thanks,
Stefano

>
>Thanks, Arseniy
>
>>
>> Thanks,
>> Stefano
>>
>>> +}
>>> +
>>> static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
>>>                          struct msghdr *msg,
>>>                          int flags)
>>> @@ -554,9 +611,9 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>>>                    int flags)
>>> {
>>>     if (flags & MSG_PEEK)
>>> -        return -EOPNOTSUPP;
>>> -
>>> -    return virtio_transport_seqpacket_do_dequeue(vsk, msg, flags);
>>> +        return virtio_transport_seqpacket_do_peek(vsk, msg);
>>> +    else
>>> +        return virtio_transport_seqpacket_do_dequeue(vsk, msg, flags);
>>> }
>>> EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>>>
>>> -- 
>>> 2.25.1
>>>
>>
>

