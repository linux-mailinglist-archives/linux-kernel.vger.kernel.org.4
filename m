Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3435F74A2AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjGFQ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjGFQ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831F61FEF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688662566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DQmeZW7JJEADmCiQp/d8Tl0o1s0eDsc5Jt7E9LRdL4I=;
        b=jBT8ea68MTbatSIaWvO1KoJ8qiUiR0jMOKZplEORzMGFzjwsVXdMigjo4x0hnT9YDcYJh6
        nduRD6z6IZNeLW+3ikfx0yflJ8XsaAALCYTvVwYF86kcZasbObb+DP9lDXl83uBHbjqugx
        iJjxiY9TnHVD93pCttXhVjYfvJKJ7us=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-1-kimePFObOYx9IR4kJfaQ-1; Thu, 06 Jul 2023 12:56:05 -0400
X-MC-Unique: 1-kimePFObOYx9IR4kJfaQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51e10990adfso642664a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 09:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662564; x=1691254564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQmeZW7JJEADmCiQp/d8Tl0o1s0eDsc5Jt7E9LRdL4I=;
        b=SldRJncAw4FP3QnZhjeFhdSr1PWyqYa7ivMz5BB7OC7+CD7deywh9Cx9plAKvKQhka
         pSALRjbWM0xkgXpCsyX7sJ6wHHwqY652jxhdANKsSiO7k9zDWGPwTXM2NArx+jrtECUl
         IGGDNgA69lV+oQDClQPaygrDzA8V3hy+TvAK90tDW0I+kbIv72y6xFE+5hR0QhV0zvdQ
         f7pb6eB7arzkJH1LlZ0T7kNGZb7mS4B2CJNg33UZcIo71PSRA8hVJFuOIhtef2xcu7YZ
         CRLFyt4k5dn7r11cEkILuZ7LW6zKDd7C7qio3zx9oS591cq1C7+jIgFkaROiaE4w+vzL
         gdtg==
X-Gm-Message-State: ABy/qLZMOTjz4NzrezpJ8Rsux0CgHnYQc/anOSlJpjj6iv3D6tWkzg12
        kUPx/GDpwvZnKn1epQFw2ljO1jMl0JaaOoO2odp+W/uJ8/22qsxsdIoGJGjSCD1nsePWut8JPbP
        wFXNiO5frWPDn+RW+ZvHC1ES6
X-Received: by 2002:a05:6402:120b:b0:51b:ec86:b49a with SMTP id c11-20020a056402120b00b0051bec86b49amr2154479edw.7.1688662564107;
        Thu, 06 Jul 2023 09:56:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxoQPW4oanBsoLFqkOwrRRnKfPaR1KLUxeJaSGG1BqBJPWu7lxGmtL/ElaHswkY3m0t4dqDw==
X-Received: by 2002:a05:6402:120b:b0:51b:ec86:b49a with SMTP id c11-20020a056402120b00b0051bec86b49amr2154459edw.7.1688662563919;
        Thu, 06 Jul 2023 09:56:03 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it. [79.46.200.163])
        by smtp.gmail.com with ESMTPSA id w26-20020a056402129a00b0051a1ef536c9sm961703edv.64.2023.07.06.09.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:56:03 -0700 (PDT)
Date:   Thu, 6 Jul 2023 18:56:01 +0200
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
Subject: Re: [RFC PATCH v5 12/17] vsock/loopback: support MSG_ZEROCOPY for
 transport
Message-ID: <p2ctmue6xm6v7px7uir2rtav6lvgenakmh45t2hd5qvdxvbeyq@cqmlufisosgx>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-13-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230701063947.3422088-13-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 09:39:42AM +0300, Arseniy Krasnov wrote:
>Add 'msgzerocopy_allow()' callback for loopback transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Move 'msgzerocopy_allow' right after seqpacket callbacks.
>  * Don't use prototype for 'vsock_loopback_msgzerocopy_allow()'.
>
> net/vmw_vsock/vsock_loopback.c | 6 ++++++
> 1 file changed, 6 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 5c6360df1f31..048640167411 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -47,6 +47,10 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
> }
>
> static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
>+static bool vsock_loopback_msgzerocopy_allow(void)
>+{
>+	return true;
>+}
>
> static struct virtio_transport loopback_transport = {
> 	.transport = {
>@@ -79,6 +83,8 @@ static struct virtio_transport loopback_transport = {
> 		.seqpacket_allow          = vsock_loopback_seqpacket_allow,
> 		.seqpacket_has_data       = virtio_transport_seqpacket_has_data,
>
>+		.msgzerocopy_allow        = vsock_loopback_msgzerocopy_allow,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>-- 
>2.25.1
>

