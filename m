Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB7964D86C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiLOJSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiLOJSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:18:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725FF47329
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671095866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kmnYYXKDnONXqet/Ba7zchBT/kf22vjnntGXJ6DXVdQ=;
        b=dii1xxFMfbqn9e2U55xY0YIBiNVaJoFnpIH0gkNEQ9ndX2UNL5tfYnsyuV2vwKH6FyP4C7
        yOPaouE6FqYFGqLjTrUxcJxgbVIblym0560rbci9pVe2LYr/58xm65issRV1cd/L2nQ9vO
        AmycSZ1i8NhcU14g71b39nR12vdmrCM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-416-L3WwIPWhM9uMMEIlnVnxew-1; Thu, 15 Dec 2022 04:17:45 -0500
X-MC-Unique: L3WwIPWhM9uMMEIlnVnxew-1
Received: by mail-ej1-f70.google.com with SMTP id qb2-20020a1709077e8200b007bf01e43797so13328412ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmnYYXKDnONXqet/Ba7zchBT/kf22vjnntGXJ6DXVdQ=;
        b=ItIEJOyXAHtKzPhki7XDZGJeog46Vu0tCnzbxCBwhQeC9PgmTmtq286lyp3B9Kv9WL
         aHXvW3ddDIQTeU7IY2t+NV71YAlQPP4Nj6q2ZDtAyttORheVE9ZHgzBByx/HDLeVXE5S
         Zb3H4RAlD5Wk0CWJXPJPTnWAm2/gV6jz9U7+0NRY+czDzCTaVDegFfrWWucWrilM3V+9
         zMEsHt5UhZVTcrl85v50X8AOBxVoNK+U2oY/8O0vJ2FXuy+8wkwLRU9Gn6t8rdUv7TG7
         Puk0fTrvh47ESv811QSFd8EFJ1I5jYuSJPvA9Wkp2Tdeyhb+U5tcJGN6e6tozmEQM9mC
         tUeQ==
X-Gm-Message-State: ANoB5pnhN5y6XKxBARfDTTkkYWhfVMxjdHtlY+pOm+SFbiEyEmuxGhUk
        Ta6Zo6o4chAjg1hvXsB07TeBTCpZBpAPnp3fpbj3ImDL+OFofNRgmJp7uH7z5iq3qxrw/ZAui+y
        HtKgVJRMa+sfC+jAF12It+GSw
X-Received: by 2002:a17:907:2a57:b0:7c1:52a:e903 with SMTP id fe23-20020a1709072a5700b007c1052ae903mr27047756ejc.55.1671095864070;
        Thu, 15 Dec 2022 01:17:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf68zjRqwxW0Rg/EaYapy4hNTOYeUsPj6bIx6WhPOt5SYylioueIx0Qib28ihtqUP9A4/aNQPA==
X-Received: by 2002:a17:907:2a57:b0:7c1:52a:e903 with SMTP id fe23-20020a1709072a5700b007c1052ae903mr27047728ejc.55.1671095863737;
        Thu, 15 Dec 2022 01:17:43 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906210100b007c1675d2626sm5440885ejt.96.2022.12.15.01.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:17:43 -0800 (PST)
Date:   Thu, 15 Dec 2022 10:17:39 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8] virtio/vsock: replace virtio_vsock_pkt with
 sk_buff
Message-ID: <20221215091739.iuukh5xkoycei7ro@sgarzare-redhat>
References: <20221215043645.3545127-1-bobby.eshleman@bytedance.com>
 <20221215084757.6bpkciaovrnsxoiu@sgarzare-redhat>
 <20221215040320-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221215040320-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 04:04:53AM -0500, Michael S. Tsirkin wrote:
>On Thu, Dec 15, 2022 at 09:47:57AM +0100, Stefano Garzarella wrote:
>> On Thu, Dec 15, 2022 at 04:36:44AM +0000, Bobby Eshleman wrote:
>> > This commit changes virtio/vsock to use sk_buff instead of
>> > virtio_vsock_pkt. Beyond better conforming to other net code, using
>> > sk_buff allows vsock to use sk_buff-dependent features in the future
>> > (such as sockmap) and improves throughput.
>> >
>> > This patch introduces the following performance changes:
>> >
>> > Tool/Config: uperf w/ 64 threads, SOCK_STREAM
>> > Test Runs: 5, mean of results
>> > Before: commit 95ec6bce2a0b ("Merge branch 'net-ipa-more-endpoints'")
>> >
>> > Test: 64KB, g2h
>> > Before: 21.63 Gb/s
>> > After: 25.59 Gb/s (+18%)
>> >
>> > Test: 16B, g2h
>> > Before: 11.86 Mb/s
>> > After: 17.41 Mb/s (+46%)
>> >
>> > Test: 64KB, h2g
>> > Before: 2.15 Gb/s
>> > After: 3.6 Gb/s (+67%)
>> >
>> > Test: 16B, h2g
>> > Before: 14.38 Mb/s
>> > After: 18.43 Mb/s (+28%)
>> >
>> > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> > ---
>> >
>> > Testing: passed vsock_test h2g and g2h
>> > Note2: net-next is closed, but sending out now in case more comments
>> > roll in, as discussed here:
>> > https://lore.kernel.org/all/Y34SoH1nFTXXLWbK@bullseye/
>> >
>> > Changes in v8:
>> > - vhost/vsock: remove unused enum
>> > - vhost/vsock: use spin_lock_bh() instead of spin_lock()
>> > - vsock/loopback: use __skb_dequeue instead of skb_dequeue
>> >
>> > Changes in v7:
>> > - use skb_queue_empty() instead of skb_queue_empty_lockless()
>> >
>> > Changes in v6:
>> > - use skb->cb instead of skb->_skb_refdst
>> > - use lock-free __skb_queue_purge for rx_queue when rx_lock held
>> >
>> > Changes in v5:
>> > - last_skb instead of skb: last_hdr->len = cpu_to_le32(last_skb->len)
>> >
>> > Changes in v4:
>> > - vdso/bits.h -> linux/bits.h
>> > - add virtio_vsock_alloc_skb() helper
>> > - virtio/vsock: rename buf_len -> total_len
>> > - update last_hdr->len
>> > - fix build_skb() for vsockmon (tested)
>> > - add queue helpers
>> > - use spin_{unlock/lock}_bh() instead of spin_lock()/spin_unlock()
>> > - note: I only ran a few g2h tests to check that this change
>> >  had no perf impact. The above data is still from patch
>> >  v3.
>> >
>> > Changes in v3:
>> > - fix seqpacket bug
>> > - use zero in vhost_add_used(..., 0) device doesn't write to buffer
>> > - use xmas tree style declarations
>> > - vsock_hdr() -> virtio_vsock_hdr() and other include file style fixes
>> > - no skb merging
>> > - save space by not using vsock_metadata
>> > - use _skb_refdst instead of skb buffer space for flags
>> > - use skb_pull() to keep track of read bytes instead of using an an
>> >  extra variable 'off' in the skb buffer space
>> > - remove unnecessary sk_allocation assignment
>> > - do not zero hdr needlessly
>> > - introduce virtio_transport_skb_len() because skb->len changes now
>> > - use spin_lock() directly on queue lock instead of sk_buff_head helpers
>> >  which use spin_lock_irqsave() (e.g., skb_dequeue)
>> > - do not reduce buffer size to be page size divisible
>> > - Note: the biggest performance change came from loosening the spinlock
>> >  variation and not reducing the buffer size.
>> >
>> > Changes in v2:
>> > - Use alloc_skb() directly instead of sock_alloc_send_pskb() to minimize
>> >  uAPI changes.
>> > - Do not marshal errors to -ENOMEM for non-virtio implementations.
>> > - No longer a part of the original series
>> > - Some code cleanup and refactoring
>> > - Include performance stats
>> >
>> > drivers/vhost/vsock.c                   | 213 +++++-------
>> > include/linux/virtio_vsock.h            | 126 +++++--
>> > net/vmw_vsock/virtio_transport.c        | 149 +++------
>> > net/vmw_vsock/virtio_transport_common.c | 422 +++++++++++++-----------
>> > net/vmw_vsock/vsock_loopback.c          |  51 +--
>> > 5 files changed, 495 insertions(+), 466 deletions(-)
>> >
>> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> > index 5703775af129..ee0a00432cb1 100644
>> > --- a/drivers/vhost/vsock.c
>> > +++ b/drivers/vhost/vsock.c
>> > @@ -51,8 +51,7 @@ struct vhost_vsock {
>> > 	struct hlist_node hash;
>> >
>> > 	struct vhost_work send_pkt_work;
>> > -	spinlock_t send_pkt_list_lock;
>> > -	struct list_head send_pkt_list;	/* host->guest pending packets */
>> > +	struct sk_buff_head send_pkt_queue; /* host->guest pending packets */
>> >
>> > 	atomic_t queued_replies;
>> >
>> > @@ -108,40 +107,33 @@ vhost_transport_do_send_pkt(struct vhost_vsock
>> > *vsock,
>> > 	vhost_disable_notify(&vsock->dev, vq);
>> >
>> > 	do {
>> > -		struct virtio_vsock_pkt *pkt;
>> > +		struct virtio_vsock_hdr *hdr;
>> > +		size_t iov_len, payload_len;
>> > 		struct iov_iter iov_iter;
>> > +		u32 flags_to_restore = 0;
>> > +		struct sk_buff *skb;
>> > 		unsigned out, in;
>> > 		size_t nbytes;
>> > -		size_t iov_len, payload_len;
>> > 		int head;
>> > -		u32 flags_to_restore = 0;
>> >
>> > -		spin_lock_bh(&vsock->send_pkt_list_lock);
>> > -		if (list_empty(&vsock->send_pkt_list)) {
>> > -			spin_unlock_bh(&vsock->send_pkt_list_lock);
>> > +		spin_lock_bh(&vsock->send_pkt_queue.lock);
>> > +		skb = __skb_dequeue(&vsock->send_pkt_queue);
>> > +		spin_unlock_bh(&vsock->send_pkt_queue.lock);
>>
>> Sorry for coming late, but I just commented in Paolo's reply.
>> Here I think we can directly use the new virtio_vsock_skb_dequeue().
>
>Yea, pretty late.
>And using that will prevent me from merging this since it's not in my tree yet.
>We can do a cleanup patch on top.

Yep, sure!
Functionally nothing changes, so it's fine with a patch on top.

So, for this patch:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

