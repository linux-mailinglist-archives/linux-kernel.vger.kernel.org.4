Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170D673B27B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFWIPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjFWIPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A1B2112
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687508049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JeBlVZM+vk7VXLRaLbx1OUJTp+51gYAZJZ/CNxFsOXc=;
        b=EDfOulLQB9fqqGeU/OaullVy30uwO//hVmgNEbevVqUqWha93XsPC1FpTQ54TectyZ+Jjz
        JjDCvg4EPVG1lcrh1dZvB2vis5AhQR9GlfVwR1vYhQX8N4KgH3E/xOzv3cktfYA21W5mJf
        IA81ifG8ZVaYqhEQb1+6ZHsgraRcyns=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-5qzXKaYSNZmKLn4o6tBbDg-1; Fri, 23 Jun 2023 04:14:07 -0400
X-MC-Unique: 5qzXKaYSNZmKLn4o6tBbDg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-977e6c94186so24629666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687508046; x=1690100046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeBlVZM+vk7VXLRaLbx1OUJTp+51gYAZJZ/CNxFsOXc=;
        b=fzRkmzUMo0jZMhjkk6mwEI8fw2D9LB6Qnyb0sEFeTjEn7j/KxSZLJxLxQtSY8/9xlH
         eIzxnBwqi9jXJKQj/NPP5QfvW+zAa4HSbMY/+J8mo+w/Q1rMB9ryaull+uQeIA86QieM
         O3iKjda8NTMHp1gUU/VLXWttUFeQRN5QLBztuXOp3eOGO2eGjNbHOQ83VA0MBTju1GBo
         GXGaY3PpDLehI3wNnzvYOQD4nVmDJUlNrPHhwzldzBLaJmlE3slX7a+7dpFFtDOVla95
         RuqC4hitMXJgQG7EMjhRkNH182wRwBLXE3O4PiL1JlkbBKLF+v2TgaOb8ga6oCAgFSsT
         iRrQ==
X-Gm-Message-State: AC+VfDxbrDNTyZMxp5Ro0UtDjnJommH2zF+M9FDZE3iP5P6JkML/9j0u
        gknujGyVvPYY8Hv6tasBb9wDT21WQnT8feR1S+nWoMHjmaaqSemnx/T2B7VxXFeh3hY6yrYthpt
        fEJADkjPRLsz3IZeXaZcAMCw9
X-Received: by 2002:a17:906:da82:b0:978:ae78:a77f with SMTP id xh2-20020a170906da8200b00978ae78a77fmr16237960ejb.21.1687508046621;
        Fri, 23 Jun 2023 01:14:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HDzIUYL3ZcY6yWc9wfXCTAhoCdzZJYjzJRHdkWLqyNhxtqeQIHBVsXF+PJMK2/7/DgNfiIg==
X-Received: by 2002:a17:906:da82:b0:978:ae78:a77f with SMTP id xh2-20020a170906da8200b00978ae78a77fmr16237948ejb.21.1687508046315;
        Fri, 23 Jun 2023 01:14:06 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id gu1-20020a170906f28100b009829a5ae8b3sm5704966ejb.64.2023.06.23.01.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 01:14:05 -0700 (PDT)
Date:   Fri, 23 Jun 2023 10:14:03 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Bobby Eshleman <bobbyeshleman@gmail.com>
Cc:     Arseniy Krasnov <oxffffaa@gmail.com>, linux-hyperv@vger.kernel.org,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Simon Horman <simon.horman@corigine.com>,
        virtualization@lists.linux-foundation.org,
        Eric Dumazet <edumazet@google.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bryan Tan <bryantan@vmware.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vishnu Dasa <vdasa@vmware.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC net-next v4 1/8] vsock/dgram: generalize recvmsg and
 drop transport->dgram_dequeue
Message-ID: <vqocs2hgezf77nvaj3wb7qjrtkanxjp6ethk3jw5cnkwdwmgqv@wfbqx3xi2s27>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-1-0cebbb2ae899@bytedance.com>
 <3eb6216b-a3d2-e1ef-270c-8a0032a4a8a5@gmail.com>
 <63ko2n5fwjdefot6rzcxdftfh6pilg6vmqn66v4ue5dgf4oz53@tntmdijw4ghr>
 <ZJTbRsU5kQfLEV9c@bullseye>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZJTbRsU5kQfLEV9c@bullseye>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 11:37:42PM +0000, Bobby Eshleman wrote:
>On Thu, Jun 22, 2023 at 04:51:41PM +0200, Stefano Garzarella wrote:
>> On Sun, Jun 11, 2023 at 11:43:15PM +0300, Arseniy Krasnov wrote:
>> > Hello Bobby! Thanks for this patchset! Small comment below:
>> >
>> > On 10.06.2023 03:58, Bobby Eshleman wrote:
>> > > This commit drops the transport->dgram_dequeue callback and makes
>> > > vsock_dgram_recvmsg() generic. It also adds additional transport
>> > > callbacks for use by the generic vsock_dgram_recvmsg(), such as for
>> > > parsing skbs for CID/port which vary in format per transport.
>> > >
>> > > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> > > ---
>> > >  drivers/vhost/vsock.c                   |  4 +-
>> > >  include/linux/virtio_vsock.h            |  3 ++
>> > >  include/net/af_vsock.h                  | 13 ++++++-
>> > >  net/vmw_vsock/af_vsock.c                | 51 ++++++++++++++++++++++++-
>> > >  net/vmw_vsock/hyperv_transport.c        | 17 +++++++--
>> > >  net/vmw_vsock/virtio_transport.c        |  4 +-
>> > >  net/vmw_vsock/virtio_transport_common.c | 18 +++++++++
>> > >  net/vmw_vsock/vmci_transport.c          | 68 +++++++++++++--------------------
>> > >  net/vmw_vsock/vsock_loopback.c          |  4 +-
>> > >  9 files changed, 132 insertions(+), 50 deletions(-)
>> > >
>> > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> > > index 6578db78f0ae..c8201c070b4b 100644
>> > > --- a/drivers/vhost/vsock.c
>> > > +++ b/drivers/vhost/vsock.c
>> > > @@ -410,9 +410,11 @@ static struct virtio_transport vhost_transport = {
>> > >  		.cancel_pkt               = vhost_transport_cancel_pkt,
>> > >
>> > >  		.dgram_enqueue            = virtio_transport_dgram_enqueue,
>> > > -		.dgram_dequeue            = virtio_transport_dgram_dequeue,
>> > >  		.dgram_bind               = virtio_transport_dgram_bind,
>> > >  		.dgram_allow              = virtio_transport_dgram_allow,
>> > > +		.dgram_get_cid		  = virtio_transport_dgram_get_cid,
>> > > +		.dgram_get_port		  = virtio_transport_dgram_get_port,
>> > > +		.dgram_get_length	  = virtio_transport_dgram_get_length,
>> > >
>> > >  		.stream_enqueue           = virtio_transport_stream_enqueue,
>> > >  		.stream_dequeue           = virtio_transport_stream_dequeue,
>> > > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> > > index c58453699ee9..23521a318cf0 100644
>> > > --- a/include/linux/virtio_vsock.h
>> > > +++ b/include/linux/virtio_vsock.h
>> > > @@ -219,6 +219,9 @@ bool virtio_transport_stream_allow(u32 cid, u32 port);
>> > >  int virtio_transport_dgram_bind(struct vsock_sock *vsk,
>> > >  				struct sockaddr_vm *addr);
>> > >  bool virtio_transport_dgram_allow(u32 cid, u32 port);
>> > > +int virtio_transport_dgram_get_cid(struct sk_buff *skb, unsigned int *cid);
>> > > +int virtio_transport_dgram_get_port(struct sk_buff *skb, unsigned int *port);
>> > > +int virtio_transport_dgram_get_length(struct sk_buff *skb, size_t *len);
>> > >
>> > >  int virtio_transport_connect(struct vsock_sock *vsk);
>> > >
>> > > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> > > index 0e7504a42925..7bedb9ee7e3e 100644
>> > > --- a/include/net/af_vsock.h
>> > > +++ b/include/net/af_vsock.h
>> > > @@ -120,11 +120,20 @@ struct vsock_transport {
>> > >
>> > >  	/* DGRAM. */
>> > >  	int (*dgram_bind)(struct vsock_sock *, struct sockaddr_vm *);
>> > > -	int (*dgram_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
>> > > -			     size_t len, int flags);
>> > >  	int (*dgram_enqueue)(struct vsock_sock *, struct sockaddr_vm *,
>> > >  			     struct msghdr *, size_t len);
>> > >  	bool (*dgram_allow)(u32 cid, u32 port);
>> > > +	int (*dgram_get_cid)(struct sk_buff *skb, unsigned int *cid);
>> > > +	int (*dgram_get_port)(struct sk_buff *skb, unsigned int *port);
>> > > +	int (*dgram_get_length)(struct sk_buff *skb, size_t *length);
>> > > +
>> > > +	/* The number of bytes into the buffer at which the payload starts, as
>> > > +	 * first seen by the receiving socket layer. For example, if the
>> > > +	 * transport presets the skb pointers using skb_pull(sizeof(header))
>> > > +	 * than this would be zero, otherwise it would be the size of the
>> > > +	 * header.
>> > > +	 */
>> > > +	const size_t dgram_payload_offset;
>> > >
>> > >  	/* STREAM. */
>> > >  	/* TODO: stream_bind() */
>> > > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> > > index efb8a0937a13..ffb4dd8b6ea7 100644
>> > > --- a/net/vmw_vsock/af_vsock.c
>> > > +++ b/net/vmw_vsock/af_vsock.c
>> > > @@ -1271,11 +1271,15 @@ static int vsock_dgram_connect(struct socket *sock,
>> > >  int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>> > >  			size_t len, int flags)
>> > >  {
>> > > +	const struct vsock_transport *transport;
>> > >  #ifdef CONFIG_BPF_SYSCALL
>> > >  	const struct proto *prot;
>> > >  #endif
>> > >  	struct vsock_sock *vsk;
>> > > +	struct sk_buff *skb;
>> > > +	size_t payload_len;
>> > >  	struct sock *sk;
>> > > +	int err;
>> > >
>> > >  	sk = sock->sk;
>> > >  	vsk = vsock_sk(sk);
>> > > @@ -1286,7 +1290,52 @@ int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>> > >  		return prot->recvmsg(sk, msg, len, flags, NULL);
>> > >  #endif
>> > >
>> > > -	return vsk->transport->dgram_dequeue(vsk, msg, len, flags);
>> > > +	if (flags & MSG_OOB || flags & MSG_ERRQUEUE)
>> > > +		return -EOPNOTSUPP;
>> > > +
>> > > +	transport = vsk->transport;
>> > > +
>> > > +	/* Retrieve the head sk_buff from the socket's receive queue. */
>> > > +	err = 0;
>> > > +	skb = skb_recv_datagram(sk_vsock(vsk), flags, &err);
>> > > +	if (!skb)
>> > > +		return err;
>> > > +
>> > > +	err = transport->dgram_get_length(skb, &payload_len);
>>
>> What about ssize_t return value here?
>>
>> Or maybe a single callback that return both length and offset?
>>
>> .dgram_get_payload_info(skb, &payload_len, &payload_off)
>>
>
>What are your thoughts on Arseniy's idea of using skb->len and adding a
>skb_pull() just before vmci adds the skb to the sk receive queue?

Yep, I agree on that!

Thanks,
Stefano

