Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88C274A2B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjGFQ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjGFQ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:57:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69881FCD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688662593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AOn2FSR/F+AepHAW4tuhLZ6J2d0DqA3sGZENm8WNhBk=;
        b=LfT1q7y3oey3dA+zRdYoN0jx2O0yUrOUG/GEElrZFqKWbnJ8VzqlwJMI/jj8et47I1YWcr
        M243UWufS2CQxGuWVXATG4EryH2kHLK7z9hHwZCO1I977BZNN0NOl4wFG+lObUZYLRi8MC
        Nb6Aowz+aNnwe2/75Vy5W/bWmkoBwjs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-Edxb_TzhPDab37APUVuDvQ-1; Thu, 06 Jul 2023 12:56:28 -0400
X-MC-Unique: Edxb_TzhPDab37APUVuDvQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b703d64832so10560001fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 09:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662587; x=1691254587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOn2FSR/F+AepHAW4tuhLZ6J2d0DqA3sGZENm8WNhBk=;
        b=aIZGze+yl+3eMlGb3brNCI7Rd50QAYyjKKDuAM0FsqlCen/S+6pqxt5LAaNHmxRsR0
         neiv+flsquOy4Vk3TGZu2hogXw2mqBfs2hC3cv+n+3BXIgULFJ+A2QeWe0enOvF8SF/i
         QOvtf2VscK7eL77evEZ/nmGJk7NdDHcFP88JkyvReOHwvs52YOtyrKgjuy4J5ZwpbCsk
         eR8cyBqR/AAEOtmR/OvFwchmSIRMOzHYdv6F5LY37BfW3L86oe3fH7bXpV3JW04FkLnu
         ZdEf4P37zIF7qn573kubuNwi1GsEFNK0YL66JfnglKx9/A33mnf87LzV4UIVOA/zF13c
         FKtQ==
X-Gm-Message-State: ABy/qLbh/6WzucNtWpVH8pmaqe/JqLqAkwAnjM+ZweUqJh5yx9ArWMS8
        UYvn1kRQEYLZ7/We2Bus15/JGYkHi0YoJOAZpiQ4GHwDiopspxIEBBc4rC7qCBcu3IBMFgt8y0Z
        XrfrDCc3xeUGZFSl3BIxu7sPi
X-Received: by 2002:a2e:99d3:0:b0:2b6:e3e2:5045 with SMTP id l19-20020a2e99d3000000b002b6e3e25045mr1907497ljj.18.1688662587338;
        Thu, 06 Jul 2023 09:56:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG+MGDRqQfF9kapT4zmm8lQzVMW6DfZBqPPwvO/e9jD6LvFab7VnpcM4MmvpSS7cFxJwa1qgw==
X-Received: by 2002:a2e:99d3:0:b0:2b6:e3e2:5045 with SMTP id l19-20020a2e99d3000000b002b6e3e25045mr1907472ljj.18.1688662586938;
        Thu, 06 Jul 2023 09:56:26 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it. [79.46.200.163])
        by smtp.gmail.com with ESMTPSA id a6-20020aa7cf06000000b0051de20c59d7sm975495edy.15.2023.07.06.09.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:56:26 -0700 (PDT)
Date:   Thu, 6 Jul 2023 18:56:23 +0200
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
Subject: Re: [RFC PATCH v5 13/17] vsock: enable setting SO_ZEROCOPY
Message-ID: <di3hhsulz5smngtyfwyvnvanlju22xuii46szrn5fmu3woj2ro@3toj6n4kbks3>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-14-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230701063947.3422088-14-AVKrasnov@sberdevices.ru>
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

On Sat, Jul 01, 2023 at 09:39:43AM +0300, Arseniy Krasnov wrote:
>For AF_VSOCK, zerocopy tx mode depends on transport, so this option must
>be set in AF_VSOCK implementation where transport is accessible (if
>transport is not set during setting SO_ZEROCOPY: for example socket is
>not connected, then SO_ZEROCOPY will be enabled, but once transport will
>be assigned, support of this type of transmission will be checked).
>
>To handle SO_ZEROCOPY, AF_VSOCK implementation uses SOCK_CUSTOM_SOCKOPT
>bit, thus handling SOL_SOCKET option operations, but all of them except
>SO_ZEROCOPY will be forwarded to the generic handler by calling
>'sock_setsockopt()'.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * This patch is totally reworked. Previous version added check for
>    PF_VSOCK directly to 'net/core/sock.c', thus allowing to set
>    SO_ZEROCOPY for AF_VSOCK type of socket. This new version catches
>    attempt to set SO_ZEROCOPY in 'af_vsock.c'. All other options
>    except SO_ZEROCOPY are forwarded to generic handler. Only this
>    option is processed in 'af_vsock.c'. Handling this option includes
>    access to transport to check that MSG_ZEROCOPY transmission is
>    supported by the current transport (if it is set, if not - transport
>    will be checked during 'connect()').

Yeah, great, this is much better!

>
> net/vmw_vsock/af_vsock.c | 44 ++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 42 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index da22ae0ef477..8acc77981d01 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1406,8 +1406,18 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			goto out;
> 		}
>
>-		if (vsock_msgzerocopy_allow(transport))
>+		if (!vsock_msgzerocopy_allow(transport)) {

Can you leave `if (vsock_msgzerocopy_allow(transport))` and just add
the else branch with this new check?

		if (vsock_msgzerocopy_allow(transport)) {
			...
		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
			...
		}

>+			/* If this option was set before 'connect()',
>+			 * when transport was unknown, check that this
>+			 * feature is supported here.
>+			 */
>+			if (sock_flag(sk, SOCK_ZEROCOPY)) {
>+				err = -EOPNOTSUPP;
>+				goto out;
>+			}
>+		} else {
> 			set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>+		}
>
> 		err = vsock_auto_bind(vsk);
> 		if (err)
>@@ -1643,7 +1653,7 @@ static int vsock_connectible_setsockopt(struct socket *sock,
> 	const struct vsock_transport *transport;
> 	u64 val;
>
>-	if (level != AF_VSOCK)
>+	if (level != AF_VSOCK && level != SOL_SOCKET)
> 		return -ENOPROTOOPT;
>
> #define COPY_IN(_v)                                       \
>@@ -1666,6 +1676,34 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>
> 	transport = vsk->transport;
>
>+	if (level == SOL_SOCKET) {

We could reduce the indentation here:
		if (optname != SO_ZEROCOPY) {
			release_sock(sk);
			return sock_setsockopt(sock, level, optname, optval, optlen);
		}

Then remove the next indentation.

>+		if (optname == SO_ZEROCOPY) {
>+			int zc_val;

`zerocopy` is more readable.
>+
>+			/* Use 'int' type here, because variable to
>+			 * set this option usually has this type.
>+			 */
>+			COPY_IN(zc_val);
>+
>+			if (zc_val < 0 || zc_val > 1) {
>+				err = -EINVAL;
>+				goto exit;
>+			}
>+
>+			if (transport && !vsock_msgzerocopy_allow(transport)) {
>+				err = -EOPNOTSUPP;
>+				goto exit;
>+			}
>+
>+			sock_valbool_flag(sk, SOCK_ZEROCOPY,
>+					  zc_val ? true : false);

Why not using directly `zc_val`?
The 3rd param of sock_valbool_flag() is an int.

>+			goto exit;
>+		}
>+
>+		release_sock(sk);
>+		return sock_setsockopt(sock, level, optname, optval, optlen);
>+	}
>+
> 	switch (optname) {
> 	case SO_VM_SOCKETS_BUFFER_SIZE:
> 		COPY_IN(val);
>@@ -2321,6 +2359,8 @@ static int vsock_create(struct net *net, struct socket *sock,
> 		}
> 	}
>
>+	set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
>+
> 	vsock_insert_unbound(vsk);
>
> 	return 0;
>-- 
>2.25.1
>

