Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F076FC0CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjEIHxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEIHxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C10E10A
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 00:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683618753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hq9XOb+LYS7v46jM7SOsafcU6iQdpNEsWNBu53l8jpc=;
        b=hEIOKSfnjsAkZlY8G7Yl1FsnTe7m65+p+vTClOFdElpfiAis5ZOnWEQBWLM+heHcOl0/Pk
        YIG/FDHYeHDDXwhLloq2dw/OM3m+sELMdt8NS1uWJYyTP/NfcUYKZn3h4PPjSU/IMABfWZ
        80ZT85b0JdIc6UJdLj9sp2jspTtQ2Qg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-aarvtca1OcOwk8YrHLpWVw-1; Tue, 09 May 2023 03:52:31 -0400
X-MC-Unique: aarvtca1OcOwk8YrHLpWVw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f427ccf3b6so2125675e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 00:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683618750; x=1686210750;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hq9XOb+LYS7v46jM7SOsafcU6iQdpNEsWNBu53l8jpc=;
        b=AiMaO1wY8VHb/ehoUZ6oAtf3LfoHxmBLOH5Ednx0lGriV0G20a4xKvS65ZiysW8HNz
         KXJG4oVwJEhZV8pRQfv9tINYl9/J0H0tmifdIlaygIi+mGwLK7ioFWeKc3/tSpp4H5kG
         /35V+/+5jaS4UU8f79/eqqeno3Le731Ss5L8MoTKZ30Rt/92DNwLLp7oEvcXwBCnJe7V
         8Tpdx9zE6cRTRSfzN0oU4UwIoxhhIhjx/cqQeLbZFmozVhTNrQ4CXLAX1t8DNO32pE3k
         0wkyMACSkDc2EiLNjodPsjTJOFOM95JqE4NyFPSsErvX0Pb07KNl43nBOYA2rb8bEKQw
         8OtA==
X-Gm-Message-State: AC+VfDxOCVcw432l4iwkk3yRsqXPA+fp62GwipgKKw8TvkRNvFSDmO4Z
        cWDw04XuDx6BX5Pvmp16CaUepZe+9N2081vEEH/Ko+TqiKXp8xrxnFez9jSTJtyj6YQulW0Gb2b
        4j5cD0n15sXyzBkws2ty5pGjf0ejRcP2Q
X-Received: by 2002:a5d:67c6:0:b0:2e4:aa42:7872 with SMTP id n6-20020a5d67c6000000b002e4aa427872mr7692573wrw.4.1683618750387;
        Tue, 09 May 2023 00:52:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4H4IfkEQuX9n/ueDeNBX8m3xSSf2wAl4ge9AgLHxQsyhBchYvRkFhX7uFEBEr7GhEbh5UJqQ==
X-Received: by 2002:a5d:67c6:0:b0:2e4:aa42:7872 with SMTP id n6-20020a5d67c6000000b002e4aa427872mr7692557wrw.4.1683618749972;
        Tue, 09 May 2023 00:52:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-255-65.dyn.eolo.it. [146.241.255.65])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d65c7000000b00307925ff35bsm6816071wrw.49.2023.05.09.00.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 00:52:29 -0700 (PDT)
Message-ID: <588689343dcd6c904e7fc142a001043015e5b14e.camel@redhat.com>
Subject: Re: [PATCH] sock: Fix misuse of sk_under_memory_pressure()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 May 2023 09:52:28 +0200
In-Reply-To: <20230506085903.96133-1-wuyun.abel@bytedance.com>
References: <20230506085903.96133-1-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-05-06 at 16:59 +0800, Abel Wu wrote:
> The commit 180d8cd942ce ("foundations of per-cgroup memory pressure
> controlling") wrapped proto::memory_pressure status into an accessor
> named sk_under_memory_pressure(), and in the next commit e1aab161e013
> ("socket: initial cgroup code") added the consideration of net-memcg
> pressure into this accessor.
>=20
> But with the former patch applied, not all of the call sites of
> sk_under_memory_pressure() are interested in net-memcg's pressure.
> The __sk_mem_{raise,reduce}_allocated() only focus on proto/netns
> pressure rather than net-memcg's.=C2=A0

Why do you state the above? The current behavior is established since
~12y, arguably we can state quite the opposite.

I think this patch should at least target net-next, and I think we need
a more detailed reasoning to introduce such behavior change.

> IOW this accessor are generally
> used for deciding whether should reclaim or not.
>=20
> Fixes: e1aab161e013 ("socket: initial cgroup code")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  include/net/sock.h |  5 -----
>  net/core/sock.c    | 17 +++++++++--------
>  2 files changed, 9 insertions(+), 13 deletions(-)
>=20
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8b7ed7167243..752d51030c5a 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1404,11 +1404,6 @@ static inline int sk_under_cgroup_hierarchy(struct=
 sock *sk,
>  #endif
>  }
> =20
> -static inline bool sk_has_memory_pressure(const struct sock *sk)
> -{
> -	return sk->sk_prot->memory_pressure !=3D NULL;
> -}
> -
>  static inline bool sk_under_memory_pressure(const struct sock *sk)
>  {
>  	if (!sk->sk_prot->memory_pressure)
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 5440e67bcfe3..8d215f821ea6 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3017,13 +3017,14 @@ int __sk_mem_raise_allocated(struct sock *sk, int=
 size, int amt, int kind)
>  		}
>  	}
> =20
> -	if (sk_has_memory_pressure(sk)) {
> -		u64 alloc;
> -
> -		if (!sk_under_memory_pressure(sk))
> -			return 1;
> -		alloc =3D sk_sockets_allocated_read_positive(sk);
> -		if (sk_prot_mem_limits(sk, 2) > alloc *
> +	if (prot->memory_pressure) {
> +		/*
> +		 * If under global pressure, allow the sockets that are below
> +		 * average memory usage to raise, trying to be fair between all
> +		 * the sockets under global constrains.
> +		 */
> +		if (!*prot->memory_pressure ||
> +		    sk_prot_mem_limits(sk, 2) > sk_sockets_allocated_read_positive(sk)=
 *

The above introduces unrelated changes that makes the code IMHO less
readable - I don't see a good reason to drop the 'alloc' variable.

Cheers,

Paolo

