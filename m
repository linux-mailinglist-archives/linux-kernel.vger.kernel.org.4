Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0514373E43C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjFZQJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjFZQJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE4B10F3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687795726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wVw/Wv9H1+jgHlFyXB8K46FNsZdoHq7Qo4C7jHkkuH8=;
        b=Gv8v5rVl/cKgWUrbeFOyOQnomcweQm+JwsJ1Ofl8xMSdyiM8n4l0trzu+bXSJZ6x4TRBro
        6nN9XnNXiE/dhKX7hmNr0SQonsEqmBT5rHd0jGaDTthNT41EDciIq8m04es0rv2ELD2Cfr
        dbBxlwGSyV1Bsql3GiGIRaYrLuTZc2I=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-ffazVNFRP6GpyAmwPkqD2A-1; Mon, 26 Jun 2023 12:08:44 -0400
X-MC-Unique: ffazVNFRP6GpyAmwPkqD2A-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-635e0889cc5so13638246d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687795722; x=1690387722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVw/Wv9H1+jgHlFyXB8K46FNsZdoHq7Qo4C7jHkkuH8=;
        b=gC5vFcE2YhrSAWm/jEWXmFOv+Hk5D2qqkAZemfFYEZ9BCBof79omjGgfE17RoHVA4y
         1jUqPeI2Vqdkh4V2ZmyB3c1ZlkKyrpqpr6FM5SE93Q2HutPTpEWjkIbWDul+1NSK1nRl
         +T61bRUelUGqCZCfznZIL9Xv+r75n3yexzC9ahM+X3ZV9hlQq8M8X3JPoTrIw2OXWwFE
         JG1jADezkqged0rvmhJ0LwDjdsXULYif6vyBa43R6XD2vVQi1rJe3kj6q+lb4seTgsGr
         jJh43aN00ECoF04nKjqUzqAOnLYx1rZU+uAzaV+F7x3mfPl5rSdinuiEnU9wkRppByGf
         nP6g==
X-Gm-Message-State: AC+VfDyvH7kDG2nPHZkT0vDPN/XIZoXkzd3wUuqd0vgdQ/weeDvJUxLN
        EeFdQK4mKhQh1lChLsm33neXjOotk8jMNum376vmQ0EwT5jOnfFCmOe9JjZBbgxZ8Ch5yvTGsDJ
        mDn6CpFL220gRWbJxABpAvR0z
X-Received: by 2002:a05:6214:27c9:b0:62d:f515:9320 with SMTP id ge9-20020a05621427c900b0062df5159320mr36074271qvb.28.1687795722199;
        Mon, 26 Jun 2023 09:08:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5raYOLH44gjALQWDUf6IbJggeYwYWXvVHtOWcRvbl3wuo2Ee6zIMMrWONEOeu5ohWrGHlbZg==
X-Received: by 2002:a05:6214:27c9:b0:62d:f515:9320 with SMTP id ge9-20020a05621427c900b0062df5159320mr36074244qvb.28.1687795721957;
        Mon, 26 Jun 2023 09:08:41 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it. [87.11.6.160])
        by smtp.gmail.com with ESMTPSA id l13-20020ad44d0d000000b0063227969cf7sm3308298qvl.96.2023.06.26.09.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:08:41 -0700 (PDT)
Date:   Mon, 26 Jun 2023 18:08:36 +0200
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
Subject: Re: [RFC PATCH v4 07/17] vsock: read from socket's error queue
Message-ID: <sq5jlfhhlj347uapazqnotc5rakzdvj33ruzqwxdjsfx275m5r@dxujwphcffkl>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-8-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230603204939.1598818-8-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 11:49:29PM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>is used to read socket's error queue instead of data queue. Possible
>scenario of error queue usage is receiving completions for transmission
>with MSG_ZEROCOPY flag.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> include/linux/socket.h   | 1 +
> net/vmw_vsock/af_vsock.c | 5 +++++
> 2 files changed, 6 insertions(+)
>
>diff --git a/include/linux/socket.h b/include/linux/socket.h
>index bd1cc3238851..d79efd026880 100644
>--- a/include/linux/socket.h
>+++ b/include/linux/socket.h
>@@ -382,6 +382,7 @@ struct ucred {
> #define SOL_MPTCP	284
> #define SOL_MCTP	285
> #define SOL_SMC		286
>+#define SOL_VSOCK	287

Maybe this change should go in another patch where we describe that
we need to support setsockopt()

>
> /* IPX options */
> #define IPX_TYPE	1
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 45fd20c4ed50..07803d9fbf6d 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -110,6 +110,7 @@
> #include <linux/workqueue.h>
> #include <net/sock.h>
> #include <net/af_vsock.h>
>+#include <linux/errqueue.h>
>
> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
> static void vsock_sk_destruct(struct sock *sk);
>@@ -2135,6 +2136,10 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	int err;
>
> 	sk = sock->sk;
>+
>+	if (unlikely(flags & MSG_ERRQUEUE))
>+		return sock_recv_errqueue(sk, msg, len, SOL_VSOCK, 0);
>+
> 	vsk = vsock_sk(sk);
> 	err = 0;
>
>-- 
>2.25.1
>

