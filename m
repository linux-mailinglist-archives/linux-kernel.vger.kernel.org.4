Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF16B74A29C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjGFQzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjGFQzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB001BE2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688662484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=glhZ+2qeJMm9MWfPWx9SoMWGjL42JiHnlLy0ooXyD8I=;
        b=X36w60RsYOFhDSr5ly5vuKgqqmY2IzWrrG8E+UxHrqhOdmk6x0u3x/goXjMfe0uwLRgS87
        Pn9gb62pZLzm5CeKiGoGNlaHLtygT48kpH1jMK/PP+bPyywAWKtGbhKPmgfbTSi7Fy1eEO
        itQBfQPw1K6dwLdItyEj+Y/mx61dse8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-64ZUp9REPJGNUToUmbtQEQ-1; Thu, 06 Jul 2023 12:54:43 -0400
X-MC-Unique: 64ZUp9REPJGNUToUmbtQEQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99388334de6so64681366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 09:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662482; x=1691254482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glhZ+2qeJMm9MWfPWx9SoMWGjL42JiHnlLy0ooXyD8I=;
        b=ExaJPpmOi0ea2CU2QqLzJxH0W+NB8XhWW0arDX+XSiYwn8u69CghHAAz+k+MSWqbEK
         M6wp6dJ5VaRBBcoWZ78WFE62GUsUAlTA2lVGuzjdWJb//aN0aHZkryfUenStlN2y7QS5
         eou7ir7h4VTAhiVJ+ZUWLDiAmZ7fxdsLHQjAAp4rVT4e6Zjq4g161TBQaWTSfwq00PNS
         UlfClKfOaG7WqnvtiAnaOJNJIOZ8ktQR8EWyHQZ7vaqSz4t6iPNajHwXtdaQDVZnwioq
         JMyq93rzifAt3POPjF6JQdFr7LterlqI2r6YFE5snehwm4UmTMgLFCChVxfKMXmD3VXf
         NjtQ==
X-Gm-Message-State: ABy/qLbHPbu9/GR2gQw732q91upAzG/4qqJ9ZPLZVuiRxXudK1nW6c+p
        S/1Q2Ug4XjwnSBVJn5aXhAQYQPJaATyVH6Q74+PiMfN67c8oCULcoW/88i9StJbSLfvc13TGzo7
        tj0ZkSDhALltCLmy7MddlRfJd
X-Received: by 2002:a17:906:89a0:b0:98c:cc3c:194e with SMTP id gg32-20020a17090689a000b0098ccc3c194emr1668112ejc.52.1688662482341;
        Thu, 06 Jul 2023 09:54:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF62VXDxBiD2YIMucVbmZsWHocuUY9mKHoepmGkw2mj8oHke7cYIWYsLK4/i6qDTk9eWPxoDA==
X-Received: by 2002:a17:906:89a0:b0:98c:cc3c:194e with SMTP id gg32-20020a17090689a000b0098ccc3c194emr1668102ejc.52.1688662482046;
        Thu, 06 Jul 2023 09:54:42 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it. [79.46.200.163])
        by smtp.gmail.com with ESMTPSA id k12-20020a170906970c00b0096f6a131b9fsm1034242ejx.23.2023.07.06.09.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:54:41 -0700 (PDT)
Date:   Thu, 6 Jul 2023 18:54:39 +0200
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
Subject: Re: [RFC PATCH v5 07/17] vsock: read from socket's error queue
Message-ID: <ho76zima4fe7yxm5ckj66ibgyl6kstjaexf4x5dxq7azjamoif@tny2uqb5yifn>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-8-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230701063947.3422088-8-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 09:39:37AM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>is used to read socket's error queue instead of data queue. Possible
>scenario of error queue usage is receiving completions for transmission
>with MSG_ZEROCOPY flag. This patch also adds 'SOL_VSOCK' define.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Update commit message by adding sentence that 'SOL_VSOCK' is also
>    added.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
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

