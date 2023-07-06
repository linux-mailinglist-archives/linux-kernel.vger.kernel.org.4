Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A88674A2A4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGFQ4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjGFQ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD76F1FC8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688662520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wsYIzXoEJlWb8NyyL4GSQKwnf6b27lly+h6hlBtZZFs=;
        b=DltiuwmjNVpOwioKT0lnA0kc5c1RjjRB/kLmODFfMh+pc/jB3OlgsxGr2Vey7u/egaq3gz
        +gadSB44iugrH67MqU29HBpAq0+2oBufXBXigK/QIDh/SytxDfn0K3ybfjO9I7UxWhKSUW
        Xjb2cDYP9Gjfww8Nve4PgBfigM//s1E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-u9O3j9rXNYmqswM3Z_TFAw-1; Thu, 06 Jul 2023 12:55:17 -0400
X-MC-Unique: u9O3j9rXNYmqswM3Z_TFAw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a355cf318so69165766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 09:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662516; x=1691254516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsYIzXoEJlWb8NyyL4GSQKwnf6b27lly+h6hlBtZZFs=;
        b=AUVUSm2qD/mvVwhYqYzoxMAOoDsV3AgxPoTevkU03W+iOpfu8+YL0RFkH7BPwccgJf
         fMAuc/vc2lrbhUS5QiCpU27vsbzwSpPLiPS9dieHIBmzDMkjGV2FdBrW5eYdx/htHJVT
         UblMjmqI4x8kjHKJoFK3W5dF9OjwJcVHU4a8eng3RlGXD3+aWpayQ5VjyOvxZO9PRdNb
         X1arTRnPzjW1A/09GXGSl7T13PkPBVaiWmLADXWs3ADP2Q2o1VgLzMpcjuuFq2BtyNxe
         I4yAA21dVKPhXKe964Vo9vm5+0eRt8IXfMJUENOBTWr5rBvOvlMRQs2sc0E77r9ieeOg
         rZ5A==
X-Gm-Message-State: ABy/qLaZmBWlGWcHBRmTDAs3BrSmvvLLSCCWnxp87DNOUl5J7o+SyJnW
        d81MaQD7GdBM/vptY4f9QOCO04eEIiNqWcFFMMCgRWcJZEv5Q2J7gv76D5z+jDX29SpiRsriwPO
        CMEDGWRzrZ8GbQ448UvRMDie9
X-Received: by 2002:a17:906:2ca:b0:979:65f0:cced with SMTP id 10-20020a17090602ca00b0097965f0ccedmr1934016ejk.17.1688662516699;
        Thu, 06 Jul 2023 09:55:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEkD0rlqSdTev+Q2IqNmZT5B5F3idaEZ37dXEcrn3WdUID6ErjT2MTHmJfkU0j9eSLaJFZ9qQ==
X-Received: by 2002:a17:906:2ca:b0:979:65f0:cced with SMTP id 10-20020a17090602ca00b0097965f0ccedmr1934002ejk.17.1688662516511;
        Thu, 06 Jul 2023 09:55:16 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it. [79.46.200.163])
        by smtp.gmail.com with ESMTPSA id mb8-20020a170906eb0800b009737b8d47b6sm1023809ejb.203.2023.07.06.09.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:55:16 -0700 (PDT)
Date:   Thu, 6 Jul 2023 18:55:13 +0200
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
Subject: Re: [RFC PATCH v5 09/17] vsock: enable SOCK_SUPPORT_ZC bit
Message-ID: <vaknax5rfvbb3ymylshak4cih2ddhsfhiq5dualh5frbedczmw@zduzizg2g6pa>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-10-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230701063947.3422088-10-AVKrasnov@sberdevices.ru>
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

On Sat, Jul 01, 2023 at 09:39:39AM +0300, Arseniy Krasnov wrote:
>This bit is used by io_uring in case of zerocopy tx mode. io_uring code
>checks, that socket has this feature. This patch sets it in two places:
>1) For socket in 'connect()' call.
>2) For new socket which is returned by 'accept()' call.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 6 ++++++
> 1 file changed, 6 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 033006e1b5ad..da22ae0ef477 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1406,6 +1406,9 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			goto out;
> 		}
>
>+		if (vsock_msgzerocopy_allow(transport))
>+			set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>+
> 		err = vsock_auto_bind(vsk);
> 		if (err)
> 			goto out;
>@@ -1560,6 +1563,9 @@ static int vsock_accept(struct socket *sock, struct socket *newsock, int flags,
> 		} else {
> 			newsock->state = SS_CONNECTED;
> 			sock_graft(connected, newsock);
>+			if (vsock_msgzerocopy_allow(vconnected->transport))
>+				set_bit(SOCK_SUPPORT_ZC,
>+					&connected->sk_socket->flags);
> 		}
>
> 		release_sock(connected);
>-- 
>2.25.1
>

