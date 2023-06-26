Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E93873E31A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjFZPVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjFZPVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660F2191
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687792855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZvpxX10aYP99VlzwnMI/RQCwxTqEDpTN7KDyAKniNg=;
        b=cMz8ke4J0GDr+vL9cCbW4rYbMj3OYNNu/H22P5P3yMtyxeDEIhr6ODt9ozBRoLDWQC6R1g
        z7XP9YVdyEZgqRNd2hGd0/A5v8EtvrH/+mBnjPFJjAxBPqWrD2iVm8N7yHbZuvBTAA5g7o
        usVONZCjGAKey4uee2+tQuD6+1CXoWI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-44zDndvUOmWTSxlErHxPPQ-1; Mon, 26 Jun 2023 11:20:54 -0400
X-MC-Unique: 44zDndvUOmWTSxlErHxPPQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-62ff1cbacdeso34907426d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687792853; x=1690384853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZvpxX10aYP99VlzwnMI/RQCwxTqEDpTN7KDyAKniNg=;
        b=iTQDb+7EzvxPHweV6IbWuy66CCsmXzMtJF9qAr7cDxnkTPuyeQdq2Xqk+wl8WD+7+Z
         DniodDJb5bWX4zm7+oJO6FhXoHPOTKQ0kBtyiBh00Yf+w6Hif/Zz9mdvuSu9YXVjTfdI
         HigtbfrI1/5dlObEYP+KUvGtP/OJXc6r0SAT4sC5DAHHtfPa+2IIWAdMUPAwRi2TBswT
         5U2EseEDONWplfDIyTdvXz8cyzlJRxm4vXizIDnOg7We722mxhgGIM/DPS1rYD/Bl/yy
         Ie7ClPuxjg0piMUB4SEbsULP93x/cCdyZudm545XIi44jjqs9S009tYRrHm6Xh/R/bJO
         X0vQ==
X-Gm-Message-State: AC+VfDzOqaElG7m8NsRzkyQYE572DbPZXvqM4KBmoJ20cKmD1Jei59Ll
        ZyCtiml8//rgZUXt5Gq4MdWflAB0t3Q6UTJknOSR7mjIxjd1q31MkQd77EKe4xyISdN4mpIaDEk
        RrSgGimotSgfnnlYS72vwQkW1
X-Received: by 2002:a05:6214:2486:b0:61a:c2bf:9f0b with SMTP id gi6-20020a056214248600b0061ac2bf9f0bmr29907875qvb.6.1687792853650;
        Mon, 26 Jun 2023 08:20:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79txX5PUlEMmKBylhJEDfi2jPBI2lzhF1I3Y4ASIeZLv/SSsCD6iAI5fZZMX/mtlnCf92x8w==
X-Received: by 2002:a05:6214:2486:b0:61a:c2bf:9f0b with SMTP id gi6-20020a056214248600b0061ac2bf9f0bmr29907843qvb.6.1687792853402;
        Mon, 26 Jun 2023 08:20:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id i7-20020a056214030700b0062ff362d87fsm3199090qvu.105.2023.06.26.08.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:20:52 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:20:48 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
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
Subject: Re: [RFC PATCH v4 01/17] vsock/virtio: read data from non-linear skb
Message-ID: <tlovtchnzv4sq2dd67jhxpx4eafpwsu6m7hey55xa2broon7i3@2vhzqzqwovfp>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-2-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230603204939.1598818-2-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 11:49:23PM +0300, Arseniy Krasnov wrote:
>This is preparation patch for non-linear skbuff handling. It replaces
>direct calls of 'memcpy_to_msg()' with 'skb_copy_datagram_iter()'. Main
>advantage of the second one is that is can handle paged part of the skb
>by using 'kmap()' on each page, but if there are no pages in the skb,
>it behaves like simple copying to iov iterator. This patch also adds
>new field to the control block of skb - this value shows current offset
>in the skb to read next portion of data (it doesn't matter linear it or
>not). Idea is that 'skb_copy_datagram_iter()' handles both types of
>skb internally - it just needs an offset from which to copy data from
>the given skb. This offset is incremented on each read from skb. This
>approach allows to avoid special handling of non-linear skbs:
>1) We can't call 'skb_pull()' on it, because it updates 'data' pointer.
>2) We need to update 'data_len' also on each read from this skb.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport_common.c | 26 +++++++++++++++++--------
> 2 files changed, 19 insertions(+), 8 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index c58453699ee9..17dbb7176e37 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -12,6 +12,7 @@
> struct virtio_vsock_skb_cb {
> 	bool reply;
> 	bool tap_delivered;
>+	u32 frag_off;
> };
>
> #define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index b769fc258931..5819a9cd4515 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -355,7 +355,7 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> 	spin_lock_bh(&vvs->rx_lock);
>
> 	skb_queue_walk_safe(&vvs->rx_queue, skb,  tmp) {
>-		off = 0;
>+		off = VIRTIO_VSOCK_SKB_CB(skb)->frag_off;
>
> 		if (total == len)
> 			break;
>@@ -370,7 +370,10 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
> 			 */
> 			spin_unlock_bh(&vvs->rx_lock);
>
>-			err = memcpy_to_msg(msg, skb->data + off, bytes);
>+			err = skb_copy_datagram_iter(skb, off,
>+						     &msg->msg_iter,
>+						     bytes);
>+
> 			if (err)
> 				goto out;
>
>@@ -414,24 +417,28 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 		skb = skb_peek(&vvs->rx_queue);
>
> 		bytes = len - total;
>-		if (bytes > skb->len)
>-			bytes = skb->len;
>+		if (bytes > skb->len - VIRTIO_VSOCK_SKB_CB(skb)->frag_off)
>+			bytes = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->frag_off;

What about storing `VIRTIO_VSOCK_SKB_CB(skb)->frag_off` in a variable?
More for readability than optimization, which I hope the compiler
already does on its own.

The rest LGTM.

Stefano

>
> 		/* sk_lock is held by caller so no one else can dequeue.
> 		 * Unlock rx_lock since memcpy_to_msg() may sleep.
> 		 */
> 		spin_unlock_bh(&vvs->rx_lock);
>
>-		err = memcpy_to_msg(msg, skb->data, bytes);
>+		err = skb_copy_datagram_iter(skb,
>+					     VIRTIO_VSOCK_SKB_CB(skb)->frag_off,
>+					     &msg->msg_iter, bytes);
>+
> 		if (err)
> 			goto out;
>
> 		spin_lock_bh(&vvs->rx_lock);
>
> 		total += bytes;
>-		skb_pull(skb, bytes);
>
>-		if (skb->len == 0) {
>+		VIRTIO_VSOCK_SKB_CB(skb)->frag_off += bytes;
>+
>+		if (skb->len == VIRTIO_VSOCK_SKB_CB(skb)->frag_off) {
> 			u32 pkt_len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>
> 			virtio_transport_dec_rx_pkt(vvs, pkt_len);
>@@ -503,7 +510,10 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> 				 */
> 				spin_unlock_bh(&vvs->rx_lock);
>
>-				err = memcpy_to_msg(msg, skb->data, bytes_to_copy);
>+				err = skb_copy_datagram_iter(skb, 0,
>+							     &msg->msg_iter,
>+							     bytes_to_copy);
>+
> 				if (err) {
> 					/* Copy of message failed. Rest of
> 					 * fragments will be freed without copy.
>-- 
>2.25.1
>

