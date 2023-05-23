Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE9170DA75
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbjEWK1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEWK1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A877FD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684837581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDdw3l9KKy0UCjIiHWsNrDWX8rtgZNTSVJWydUkRdjo=;
        b=SLouiJZiGqrQ1hHtQ7u27+BxCexPKNGcs4aRAmQRbLE6lXY9+UvMdRiWJHg5YmdlbeGXv2
        ALY37XA/phUu5KeePhfsBmhLItMVCBPLGn+Rlu2NT20KfZYfsAgN7+K3dT7qO4TzeQHofT
        RVTjo8itZ11yahNYLSvQ5Aj+GyaKCPQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-bv6br0XUPIWbN_gvs_wfQg-1; Tue, 23 May 2023 06:26:20 -0400
X-MC-Unique: bv6br0XUPIWbN_gvs_wfQg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f6b1853e80so3190491cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684837579; x=1687429579;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDdw3l9KKy0UCjIiHWsNrDWX8rtgZNTSVJWydUkRdjo=;
        b=CEMUFD3jAg7SoTV5TJJhYpfghE9odwyG/TpubXWEevDVvum50FyZj1ljgKcnWlkQU3
         XxYpIIrx9w7v7CTnqVfJvtnv//1wMIfpoTcW99YXHof3mj/+7Trz0WDdh1w8OQYR85lj
         Rtb9C7TgT8P3vgzc+INfDg0Henb7swvD517vzAtZ1lNXUDy75Zmgh/Q7llO4TcHRoXGV
         co/NGI94RQF+CbA/S2sV++cgh4dzB8Nbs2yl5QPaF3UytYeuISSkr1a2KqZpnur4JRjT
         1K++nLheC/IfPpniq6jFHKzISEqiJeWNmpeMyKt3tbKidLgzH7VhwG616C8BPA2DDNnR
         IQxQ==
X-Gm-Message-State: AC+VfDxEVLLa7WeiPi3wilI6G8MCxRX8vXKH/54xpdJevykChIonS6Ff
        T/yJuSkB1Ihv7cCzFnzKEQP38xcLxSxGDOa1QbzaPDAu/kgh67SRxDsV7EaGzm0u5j1LJf1q05C
        uB9gyCXqeWkeSvhy8N22pcO5l
X-Received: by 2002:a05:622a:1a05:b0:3f4:41e:efc1 with SMTP id f5-20020a05622a1a0500b003f4041eefc1mr21739084qtb.6.1684837579644;
        Tue, 23 May 2023 03:26:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7x8tD9BWNAQSOclB7GYJihJ8cWOhhvYEn9guvqFeJammgD0xdwqLwU+ViaeFQv6Dp23dzhIg==
X-Received: by 2002:a05:622a:1a05:b0:3f4:41e:efc1 with SMTP id f5-20020a05622a1a0500b003f4041eefc1mr21739071qtb.6.1684837579322;
        Tue, 23 May 2023 03:26:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-246-0.dyn.eolo.it. [146.241.246.0])
        by smtp.gmail.com with ESMTPSA id a11-20020a05622a02cb00b003f6a9d0ade2sm1193045qtx.75.2023.05.23.03.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 03:26:19 -0700 (PDT)
Message-ID: <58241c427684e6da0ab454d344421c2fb29a0465.camel@redhat.com>
Subject: Re: [PATCH v3 4/5] sock: Consider memcg pressure when raising
 sockmem
From:   Paolo Abeni <pabeni@redhat.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 23 May 2023 12:26:15 +0200
In-Reply-To: <20230523094652.49411-5-wuyun.abel@bytedance.com>
References: <20230523094652.49411-1-wuyun.abel@bytedance.com>
         <20230523094652.49411-5-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-05-23 at 17:46 +0800, Abel Wu wrote:
> For now __sk_mem_raise_allocated() mainly considers global socket
> memory pressure and allows to raise if no global pressure observed,
> including the sockets whose memcgs are in pressure, which might
> result in longer memcg memstall.
>=20
> So take net-memcg's pressure into consideration when allocating
> socket memory to alleviate long tail latencies.
>=20
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  net/core/sock.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 801df091e37a..b899e0b9feda 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2976,22 +2976,31 @@ EXPORT_SYMBOL(sk_wait_data);
>  int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kin=
d)
>  {
>  	bool memcg_charge =3D mem_cgroup_sockets_enabled && sk->sk_memcg;
> +	bool charged =3D true, pressured =3D false;
>  	struct proto *prot =3D sk->sk_prot;
> -	bool charged =3D true;
>  	long allocated;
> =20
>  	sk_memory_allocated_add(sk, amt);
>  	allocated =3D sk_memory_allocated(sk);
> -	if (memcg_charge &&
> -	    !(charged =3D mem_cgroup_charge_skmem(sk->sk_memcg, amt,
> -						gfp_memcg_charge())))
> -		goto suppress_allocation;
> +
> +	if (memcg_charge) {
> +		charged =3D mem_cgroup_charge_skmem(sk->sk_memcg, amt,
> +						  gfp_memcg_charge());
> +		if (!charged)
> +			goto suppress_allocation;
> +		if (mem_cgroup_under_socket_pressure(sk->sk_memcg))
> +			pressured =3D true;
> +	}
> =20
>  	/* Under limit. */
> -	if (allocated <=3D sk_prot_mem_limits(sk, 0)) {
> +	if (allocated <=3D sk_prot_mem_limits(sk, 0))
>  		sk_leave_memory_pressure(sk);
> +	else
> +		pressured =3D true;

The above looks not correct to me.=20

	allocated > sk_prot_mem_limits(sk, 0)=20

does not mean the protocol has memory pressure. Such condition is
checked later with:

	if (allocated > sk_prot_mem_limits(sk, 1))

Here an allocation could fail even if memcg charge is successful and
the protocol is not under pressure, which in turn sounds quite (too
much?) conservative.

Cheers,

Paolo

