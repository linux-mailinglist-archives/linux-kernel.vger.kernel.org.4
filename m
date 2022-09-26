Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37DF5EA914
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiIZOw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbiIZOvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:51:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22792BC31
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664198283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LtpLVF78yaQ8akL0eEAs7+Z0svwvAfFmddP3iRQwkjc=;
        b=bfAofHbQn9pOaAefG1DJxnTqxuPKTeraNDC2ZWVQsRiCROA7pygeF2QdKMw5TbfgjJs7se
        qlXjOOXr/V2Bffpe36bwP+HN53Uv8J48CykC8h0Zc8fmc9xMYKYBY5JUxIYwZEIdeNgZzN
        dFr2q5mHMLlFD3VEQ+oTPlsum8j28z0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-251-6qCkj__SM_S8e4-qY0kc_Q-1; Mon, 26 Sep 2022 09:18:02 -0400
X-MC-Unique: 6qCkj__SM_S8e4-qY0kc_Q-1
Received: by mail-qv1-f70.google.com with SMTP id lq8-20020a0562145b8800b004ad7229e4e9so3770521qvb.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LtpLVF78yaQ8akL0eEAs7+Z0svwvAfFmddP3iRQwkjc=;
        b=LK0C/qGesXiY/pH+3YemKfhZ4VCJ4uyA1IHFkG2iC0GRksLO7Zqz4a8Yq3YkJrTRrV
         cKoBTnEIomXHf3QgTvr5UR0Ny644IcQTWFX/LtDW4t2KFJnZFBJb7PgmeiUXxZTpZQJw
         z8AsQxxhKYKTndnN+mPn4JHKW9MYsHzX/1QYufqq40zHzm0lDXE1DWWIZh6aqySNm4ql
         9VfinPQ3jysZitI4RH83SGeG8vTT83/ZrrnA3dqzM/X5zU3H4ZT/UdSE9cHyLD/8nlOw
         HX29BLumVUT1HsIrgcE8eQ/TNu4c1Z0i+cGsJNDnppedk5T3E2/vHv29j5lMwe+JxAbM
         9qSQ==
X-Gm-Message-State: ACrzQf1fCZgmvFTsnHaPs0bKJP88FwPhQoMiT9YEgrBhNXLRRCAhMNID
        /qlrCJHhNT1qtbL3ppi6Av/kHBpNxyuC0feRhLB/WOaug909ZVADbN32rCp7E/WJVGX/Cuha4g/
        SiuvpzCvy5r7w7/NEh67zrT7O
X-Received: by 2002:a05:622a:654:b0:35c:f6e6:76b7 with SMTP id a20-20020a05622a065400b0035cf6e676b7mr17820462qtb.365.1664198278779;
        Mon, 26 Sep 2022 06:17:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4X2VsELTxq8A6XavJEjjHhj8YKH3iZ07B183UX0OdOkc1HRRewWyFvSFtXrHzQS3LMX97ORg==
X-Received: by 2002:a05:622a:654:b0:35c:f6e6:76b7 with SMTP id a20-20020a05622a065400b0035cf6e676b7mr17820441qtb.365.1664198278498;
        Mon, 26 Sep 2022 06:17:58 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-222.retail.telecomitalia.it. [79.46.200.222])
        by smtp.gmail.com with ESMTPSA id bm17-20020a05620a199100b006c73c3d288esm11765046qkb.131.2022.09.26.06.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:17:57 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:17:51 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobby.eshleman@gmail.com>
Cc:     Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <20220926131751.pdlc5mbx6gxqlmkx@sgarzare-redhat>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <3d1f32c4da81f8a0870e126369ba12bc8c4ad048.1660362668.git.bobby.eshleman@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3d1f32c4da81f8a0870e126369ba12bc8c4ad048.1660362668.git.bobby.eshleman@bytedance.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:56:07AM -0700, Bobby Eshleman wrote:
>This commit adds a feature bit for virtio vsock to support datagrams.
>
>Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> drivers/vhost/vsock.c             | 3 ++-
> include/uapi/linux/virtio_vsock.h | 1 +
> net/vmw_vsock/virtio_transport.c  | 8 ++++++--
> 3 files changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b20ddec2664b..a5d1bdb786fe 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -32,7 +32,8 @@
> enum {
> 	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
> 			       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
>-			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET)
>+			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET) |
>+			       (1ULL << VIRTIO_VSOCK_F_DGRAM)
> };
>
> enum {
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 64738838bee5..857df3a3a70d 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h
>@@ -40,6 +40,7 @@
>
> /* The feature bitmap for virtio vsock */
> #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
>+#define VIRTIO_VSOCK_F_DGRAM		2	/* Host support dgram vsock */

We already allocated bit 2 for F_NO_IMPLIED_STREAM , so we should use 3:
https://github.com/oasis-tcs/virtio-spec/blob/26ed30ccb049fd51d6e20aad3de2807d678edb3a/virtio-vsock.tex#L22
(I'll send patches to implement F_STREAM and F_NO_IMPLIED_STREAM 
negotiation soon).

As long as it's RFC it's fine to introduce F_DGRAM, but we should first 
change virtio-spec before merging this series.

About the patch, we should only negotiate the new feature when we really 
have DGRAM support. So, it's better to move this patch after adding 
support for datagram.

Thanks,
Stefano

>
> struct virtio_vsock_config {
> 	__le64 guest_cid;
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index c6212eb38d3c..073314312683 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -35,6 +35,7 @@ static struct virtio_transport virtio_transport; /* 
>forward declaration */
> struct virtio_vsock {
> 	struct virtio_device *vdev;
> 	struct virtqueue *vqs[VSOCK_VQ_MAX];
>+	bool has_dgram;
>
> 	/* Virtqueue processing is deferred to a workqueue */
> 	struct work_struct tx_work;
>@@ -709,7 +710,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 	}
>
> 	vsock->vdev = vdev;
>-
> 	vsock->rx_buf_nr = 0;
> 	vsock->rx_buf_max_nr = 0;
> 	atomic_set(&vsock->queued_replies, 0);
>@@ -726,6 +726,9 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
> 		vsock->seqpacket_allow = true;
>
>+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_DGRAM))
>+		vsock->has_dgram = true;
>+
> 	vdev->priv = vsock;
>
> 	ret = virtio_vsock_vqs_init(vsock);
>@@ -820,7 +823,8 @@ static struct virtio_device_id id_table[] = {
> };
>
> static unsigned int features[] = {
>-	VIRTIO_VSOCK_F_SEQPACKET
>+	VIRTIO_VSOCK_F_SEQPACKET,
>+	VIRTIO_VSOCK_F_DGRAM
> };
>
> static struct virtio_driver virtio_vsock_driver = {
>-- 
>2.35.1
>

