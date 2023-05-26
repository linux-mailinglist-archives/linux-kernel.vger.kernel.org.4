Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F71712998
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243880AbjEZPeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244091AbjEZPed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3EFFB
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685115218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KX6Yf13i6AFU05QvowpPFEgdpwIwvJpfgfAn3ZM8pRQ=;
        b=HYIWgQq1N8OCSZc4ttGR4dgGYlMTYaRVavhwpHLNPkB/URDyDx/yohGbHyE+u+yQJdK8Vg
        3WHXCSJ29TmmWT2ojS5pXyrKiPRonTjicnHCUzn+5TyObrEjpCI6KDt0NBIUqB3FJKMrhS
        5EHbkZ9NHBh4oaf7pAVNEKGydtFxHv4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-tijk1wmRMTmddSo2xgedRg-1; Fri, 26 May 2023 11:33:37 -0400
X-MC-Unique: tijk1wmRMTmddSo2xgedRg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f603380047so1609125e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685115216; x=1687707216;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KX6Yf13i6AFU05QvowpPFEgdpwIwvJpfgfAn3ZM8pRQ=;
        b=aYZf8LluojupSOn5bdrVkcSo0UNKGbBOtUKj+oR6W7i8HfH9U6wCJN/RXF602Ok9/s
         cymg/J3S/7on+Ao/mIC5R73qIvqgThLfTFv/iYVaVr8XC3f6FjZlRrli358TPEKFOiL9
         WF48PyMG6h5xrDh8tfFG4bI596Fbt1DtEHbaHRSdMrWbXnXBUHcdl3jrW2kBpjttF9OH
         CFWXUHI7xma2JnhdAmxZwDVq/2gNMI5/MPcfsB3d5EOr8VzzPXkxInrkDR+uf4gvN7iR
         cNLR3TiMjcQkst70CplE4abSBanIIfklHfSpYTr9RbJ0tBgrb1TcRy1FnyHFoxl8N9jn
         glBw==
X-Gm-Message-State: AC+VfDx3knzSaucoBYQ4ZbjaiYnbd580RhY/sL8yo+n7zxqRT3aqrz36
        bYb5A6+uh6uIgZ2KZsgeeSYhkOnXsXPTtgWb9o3ZPea05kPkw0RY15GLq4Sx4a/u3w72AWKw4XB
        mY+IDAAIlQp/Nj2PJCdgCThGB
X-Received: by 2002:a05:600c:4f4f:b0:3f5:f543:d81f with SMTP id m15-20020a05600c4f4f00b003f5f543d81fmr2188082wmq.3.1685115216239;
        Fri, 26 May 2023 08:33:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4GSpzfZiK8iVr9tQwfRMfENLOhQxCjKCJ+HBLpAgkdilXnYmr8E7MZ2dgmTLXldgx1QPx3Pg==
X-Received: by 2002:a05:600c:4f4f:b0:3f5:f543:d81f with SMTP id m15-20020a05600c4f4f00b003f5f543d81fmr2188058wmq.3.1685115215893;
        Fri, 26 May 2023 08:33:35 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-255.dyn.eolo.it. [146.241.241.255])
        by smtp.gmail.com with ESMTPSA id f9-20020a1c6a09000000b003f4272c2d0csm5513594wmc.36.2023.05.26.08.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 08:33:35 -0700 (PDT)
Message-ID: <27614af23cd7ae4433b909194062c553a6ae16ac.camel@redhat.com>
Subject: Re: [PATCH] udp6: Fix race condition in udp6_sendmsg & connect
From:   Paolo Abeni <pabeni@redhat.com>
To:     Vladislav Efanov <VEfanov@ispras.ru>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Date:   Fri, 26 May 2023 17:33:33 +0200
In-Reply-To: <20230526150806.1457828-1-VEfanov@ispras.ru>
References: <20230526150806.1457828-1-VEfanov@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-05-26 at 18:08 +0300, Vladislav Efanov wrote:
> Syzkaller got the following report:
> BUG: KASAN: use-after-free in sk_setup_caps+0x621/0x690 net/core/sock.c:2=
018
> Read of size 8 at addr ffff888027f82780 by task syz-executor276/3255
>=20
> The function sk_setup_caps (called by ip6_sk_dst_store_flow->
> ip6_dst_store) referenced already freed memory as this memory was
> freed by parallel task in udpv6_sendmsg->ip6_sk_dst_lookup_flow->
> sk_dst_check.
>=20
>           task1 (connect)              task2 (udp6_sendmsg)
>         sk_setup_caps->sk_dst_set |
>                                   |  sk_dst_check->
>                                   |      sk_dst_set
>                                   |      dst_release
>         sk_setup_caps references  |
>         to already freed dst_entry|
>=20
> The reason for this race condition is: udp6_sendmsg() calls
> ip6_sk_dst_lookup() without lock for sock structure and tries to
> allocate/add dst_entry structure to sock structure in parallel with
> "connect" task.
>=20
> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>

Thank you for the detailed report!

> ---
>  net/ipv6/udp.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index e5a337e6b970..a5ecd5d93b0a 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1563,12 +1563,15 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr =
*msg, size_t len)
> =20
>  	fl6->flowlabel =3D ip6_make_flowinfo(ipc6.tclass, fl6->flowlabel);
> =20
> +	lock_sock(sk);

Acquiring the socket lock in this fast-path is going to kill the xmit
performances, I think we can't do that.

What about something like the following instead? Does that addresses
the UaF? (completely untested, not even built ;) If so, feel free to
take it over.

Thanks.

Paolo
---
diff --git a/net/core/sock.c b/net/core/sock.c
index 5440e67bcfe3..24f2761bdb1d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2381,7 +2381,6 @@ void sk_setup_caps(struct sock *sk, struct dst_entry =
*dst)
 {
 	u32 max_segs =3D 1;
=20
-	sk_dst_set(sk, dst);
 	sk->sk_route_caps =3D dst->dev->features;
 	if (sk_is_tcp(sk))
 		sk->sk_route_caps |=3D NETIF_F_GSO;
@@ -2400,6 +2399,7 @@ void sk_setup_caps(struct sock *sk, struct dst_entry =
*dst)
 		}
 	}
 	sk->sk_gso_max_segs =3D max_segs;
+	sk_dst_set(sk, dst);
 }
 EXPORT_SYMBOL_GPL(sk_setup_caps);
=20

