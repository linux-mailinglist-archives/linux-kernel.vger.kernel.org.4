Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658665EDFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiI1PLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiI1PLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEDB8A7D4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664377907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N//yqD+aufpyhJZtChEf3+2TXlqXFfc1L7JPLKS/TRs=;
        b=FjahSpcgl73Vjq+gSivGQb2E7GYBunB6oRn4k6UaqGF0LWuoPLSLdI2adjR20yz7CURZVA
        A1SLXJPSX+6wikxnaI/swyZ25hIG7l2dMHW5APnXBPd8DBKGepcU3KYAOLRbgipO9/MrA9
        fXOOj8fV/w36DJeGN5M0EY8+fT6IjUE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-531-Qt0Q_9PDOZKYDmN4-uUYzA-1; Wed, 28 Sep 2022 11:11:45 -0400
X-MC-Unique: Qt0Q_9PDOZKYDmN4-uUYzA-1
Received: by mail-qt1-f198.google.com with SMTP id ay22-20020a05622a229600b0035bbb349e79so9129593qtb.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=N//yqD+aufpyhJZtChEf3+2TXlqXFfc1L7JPLKS/TRs=;
        b=AUuK8u7wyfkQ0Qzoe6xSksImQ4CwuVy6jELrkdy8Qel6LFkYc1v7GHqetpWJXcXJFK
         h490581pviiIAKk1yNdj0eOtQEvrZi1oPRKP+8vMbBcSiyTGWBCP8cqJcsQfn2I+r+Cb
         XZmJPnBS/DbodnuzHe0g2YkvG0onDKb1ELDWGDLXcgDTQ/zE7h4CHyjQGqg7YYABhfMQ
         Da9u78uYWQE7Oy+n1PCxEuqEnF3gEz1Z71phx0riXKL82RGptCfcmBWN4K+/TQYgD6hC
         St7sE81HVEUzZ+su6OCAO+6UIFW0kFUKS3CGKZ5Ti7yDqii0MXUxc70wqmdxgiVHX9y6
         t7qA==
X-Gm-Message-State: ACrzQf0mZ34eDr5O8w3jC9j/6P+Von1+YfK9tHSjXQjTWAdm9PV8+MMV
        jKfU38jalDx5s9GURvPlHxQCJ7TTRrBj0cfOcLTi9E75G3BgAqNrS4Jnf9+4Mkpq4s2eHjN+VIw
        2A5G6App5dxGCPomNlZnLPb9G
X-Received: by 2002:a37:68d6:0:b0:6cb:cf29:dfb with SMTP id d205-20020a3768d6000000b006cbcf290dfbmr21582940qkc.406.1664377905061;
        Wed, 28 Sep 2022 08:11:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6F5FAU27MZ7cS3Ks7xMKNVxbwnEj7yH65umY8MeviEbyJkDkQQ9uEbZ9y2Bnsn/Fvx15R7pQ==
X-Received: by 2002:a37:68d6:0:b0:6cb:cf29:dfb with SMTP id d205-20020a3768d6000000b006cbcf290dfbmr21582904qkc.406.1664377904744;
        Wed, 28 Sep 2022 08:11:44 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-222.retail.telecomitalia.it. [79.46.200.222])
        by smtp.gmail.com with ESMTPSA id h18-20020a05620a245200b006ced196a73fsm3185370qkn.135.2022.09.28.08.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:11:43 -0700 (PDT)
Date:   Wed, 28 Sep 2022 17:11:35 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Junichi Uekawa <uekawa@chromium.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH] vhost/vsock: Use kvmalloc/kvfree for larger packets.
Message-ID: <20220928151135.pvrlsylg6j3hzh74@sgarzare-redhat>
References: <20220928064538.667678-1-uekawa@chromium.org>
 <20220928082823.wyxplop5wtpuurwo@sgarzare-redhat>
 <20220928052738-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220928052738-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 05:31:58AM -0400, Michael S. Tsirkin wrote:
>On Wed, Sep 28, 2022 at 10:28:23AM +0200, Stefano Garzarella wrote:
>> On Wed, Sep 28, 2022 at 03:45:38PM +0900, Junichi Uekawa wrote:
>> > When copying a large file over sftp over vsock, data size is usually 32kB,
>> > and kmalloc seems to fail to try to allocate 32 32kB regions.
>> >
>> > Call Trace:
>> >  [<ffffffffb6a0df64>] dump_stack+0x97/0xdb
>> >  [<ffffffffb68d6aed>] warn_alloc_failed+0x10f/0x138
>> >  [<ffffffffb68d868a>] ? __alloc_pages_direct_compact+0x38/0xc8
>> >  [<ffffffffb664619f>] __alloc_pages_nodemask+0x84c/0x90d
>> >  [<ffffffffb6646e56>] alloc_kmem_pages+0x17/0x19
>> >  [<ffffffffb6653a26>] kmalloc_order_trace+0x2b/0xdb
>> >  [<ffffffffb66682f3>] __kmalloc+0x177/0x1f7
>> >  [<ffffffffb66e0d94>] ? copy_from_iter+0x8d/0x31d
>> >  [<ffffffffc0689ab7>] vhost_vsock_handle_tx_kick+0x1fa/0x301 [vhost_vsock]
>> >  [<ffffffffc06828d9>] vhost_worker+0xf7/0x157 [vhost]
>> >  [<ffffffffb683ddce>] kthread+0xfd/0x105
>> >  [<ffffffffc06827e2>] ? vhost_dev_set_owner+0x22e/0x22e [vhost]
>> >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
>> >  [<ffffffffb6eb332e>] ret_from_fork+0x4e/0x80
>> >  [<ffffffffb683dcd1>] ? flush_kthread_worker+0xf3/0xf3
>> >
>> > Work around by doing kvmalloc instead.
>> >
>> > Signed-off-by: Junichi Uekawa <uekawa@chromium.org>
>
>My worry here is that this in more of a work around.
>It would be better to not allocate memory so aggressively:
>if we are so short on memory we should probably process
>packets one at a time. Is that very hard to implement?

Currently the "virtio_vsock_pkt" is allocated in the "handle_kick" 
callback of TX virtqueue. Then the packet is multiplexed on the right 
socket queue, then the user space can de-queue it whenever they want.

So maybe we can stop processing the virtqueue if we are short on memory, 
but when can we restart the TX virtqueue processing?

I think as long as the guest used only 4K buffers we had no problem, but 
now that it can create larger buffers the host may not be able to 
allocate it contiguously. Since there is no need to have them contiguous 
here, I think this patch is okay.

However, if we switch to sk_buff (as Bobby is already doing), maybe we 
don't have this problem because I think there is some kind of 
pre-allocated pool.

>
>
>
>> > ---
>> >
>> > drivers/vhost/vsock.c                   | 2 +-
>> > net/vmw_vsock/virtio_transport_common.c | 2 +-
>> > 2 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> > index 368330417bde..5703775af129 100644
>> > --- a/drivers/vhost/vsock.c
>> > +++ b/drivers/vhost/vsock.c
>> > @@ -393,7 +393,7 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
>> > 		return NULL;
>> > 	}
>> >
>> > -	pkt->buf = kmalloc(pkt->len, GFP_KERNEL);
>> > +	pkt->buf = kvmalloc(pkt->len, GFP_KERNEL);
>> > 	if (!pkt->buf) {
>> > 		kfree(pkt);
>> > 		return NULL;
>> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > index ec2c2afbf0d0..3a12aee33e92 100644
>> > --- a/net/vmw_vsock/virtio_transport_common.c
>> > +++ b/net/vmw_vsock/virtio_transport_common.c
>> > @@ -1342,7 +1342,7 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
>> >
>> > void virtio_transport_free_pkt(struct virtio_vsock_pkt *pkt)
>> > {
>> > -	kfree(pkt->buf);
>> > +	kvfree(pkt->buf);
>>
>> virtio_transport_free_pkt() is used also in virtio_transport.c and
>> vsock_loopback.c where pkt->buf is allocated with kmalloc(), but IIUC
>> kvfree() can be used with that memory, so this should be fine.
>>
>> > 	kfree(pkt);
>> > }
>> > EXPORT_SYMBOL_GPL(virtio_transport_free_pkt);
>> > --
>> > 2.37.3.998.g577e59143f-goog
>> >
>>
>> This issue should go away with the Bobby's work about introducing sk_buff
>> [1], but we can queue this for now.
>>
>> I'm not sure if we should do the same also in the virtio-vsock driver
>> (virtio_transport.c). Here in vhost-vsock the buf allocated is only used in
>> the host, while in the virtio-vsock driver the buffer is exposed to the
>> device emulated in the host, so it should be physically contiguous (if not,
>> maybe we need to adjust virtio_vsock_rx_fill()).
>
>More importantly it needs to support DMA API which IIUC kvmalloc
>memory does not.
>

Right, good point!

Thanks,
Stefano

