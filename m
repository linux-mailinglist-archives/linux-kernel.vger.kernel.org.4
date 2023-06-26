Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E1B73E456
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjFZQMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjFZQMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB43FE72
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687795870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vSj67Bysge00sGJTpLw1MntXa5IUhJN9aBkXlNz5ucg=;
        b=HthgAdd6i8VdS1scHQgAKryiDBduGgRyjory9YelfKNc/5vO/mNXyLSOZxN5mq6UHY7fKX
        EC5llfrMUXpAFGBmX6v5cMFDvB7kNHValD4FUvuCmLrv4IS74u68JxRpMq2yn+poXDsnLw
        9P1vHqJ/yIPm9usIlgD/b/LU2gL+nf0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-jw8sL1x-OzqfTcgdfS7ttA-1; Mon, 26 Jun 2023 12:11:09 -0400
X-MC-Unique: jw8sL1x-OzqfTcgdfS7ttA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76531f671c0so319183985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687795862; x=1690387862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSj67Bysge00sGJTpLw1MntXa5IUhJN9aBkXlNz5ucg=;
        b=Sxp1/yCgzFRcKx8pUzXr2ZHRaAp2hUvQeTcfq7JnadLMc+e4gnVgRztjvbYE7JzfeX
         hZYjuZ41nm0x5POWgVIKvgeGg0W9VEjYczISIBhYnYGoB2YOjdhQSEuKbXpf2/C2aMTN
         JtmKOiublLLIoUyoxRF28HbKx9pVXWurDSyOHWvob0nDE5yVp0ly1WP2n5MmTJ6eaYcu
         SZ8ZGUII9shRQ/m5QtR+Pa/XN63CQpAVG32nmAtkHtV2v/oqZ3FFequy9AtwLf4iH03V
         TTriRveE+Fbl66WWFxdtdJhvAHh4FiMkfkBaHfnqwTbAPGx/vQEzLAqyDmWAq0tLXOwP
         /YVA==
X-Gm-Message-State: AC+VfDx/Ccz/Zf6LNUhKvgHf5bOAG+2fIR0fLV/vKz7i9iUTvonrmMw8
        9zVQaZv0KK8a2DEL6yWCB8SpUzYT+kneeFQsRYdIC21hchPL+EpJJu/4XY0mFK6KfcLqQc/Jcur
        hu2OTdMSbf6wVe60Z/dAVu8vO
X-Received: by 2002:a05:620a:4542:b0:75b:23a1:830c with SMTP id u2-20020a05620a454200b0075b23a1830cmr40000791qkp.7.1687795862085;
        Mon, 26 Jun 2023 09:11:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5AAJeVZO0AaDvZksfxGubjZjegdRtILGSI73Wjq9DgEqaoTB4CbROal09UCjmsMp7T1Z9vfA==
X-Received: by 2002:a05:620a:4542:b0:75b:23a1:830c with SMTP id u2-20020a05620a454200b0075b23a1830cmr40000771qkp.7.1687795861845;
        Mon, 26 Jun 2023 09:11:01 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id c25-20020a05620a11b900b007607324644asm2806347qkk.118.2023.06.26.09.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:11:01 -0700 (PDT)
Date:   Mon, 26 Jun 2023 18:10:56 +0200
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
Subject: Re: [RFC PATCH v4 10/17] vhost/vsock: support MSG_ZEROCOPY for
 transport
Message-ID: <cqlp2jr7laleku3reiqf64swlieso6rvi47u5cnlu24kfn3fnm@3x45ihmjox77>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-11-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230603204939.1598818-11-AVKrasnov@sberdevices.ru>
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

On Sat, Jun 03, 2023 at 11:49:32PM +0300, Arseniy Krasnov wrote:
>Add 'msgzerocopy_allow()' callback for vhost transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> drivers/vhost/vsock.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b254aa4b756a..318866713ef7 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -396,6 +396,11 @@ static bool vhost_vsock_more_replies(struct vhost_vsock *vsock)
> 	return val < vq->num;
> }
>
>+static bool vhost_transport_msgzerocopy_allow(void)
>+{
>+	return true;
>+}
>+
> static bool vhost_transport_seqpacket_allow(u32 remote_cid);
>
> static struct virtio_transport vhost_transport = {
>@@ -442,6 +447,7 @@ static struct virtio_transport vhost_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+		.msgzerocopy_allow        = vhost_transport_msgzerocopy_allow,

Can we move this after .seqpacket section?

> 	},
>
> 	.send_pkt = vhost_transport_send_pkt,
>-- 
>2.25.1
>

