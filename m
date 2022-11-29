Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCC263BDCF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiK2KTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiK2KTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:19:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346C54AF23
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669717113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pAbL1ssqA8qFivaztpNHDU9ON2lj4Fx1D9mtv2aT0SY=;
        b=NDD647VoKttBpX7EmjKLu4p1cDM4EKdtaKS0sxyWDK5mGkPhmRt2xRXOsNkVjgv9TSn5km
        Y3WuLaB4HPLrN1jiQIlUxHnPIsjYYDYj66RPaFupNn6NBv7fo0Qu4LVPZAbMVnE7ZIWNhC
        VAXIEHk3eL+fMQhiwe28wq4xvHSa4TU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-601-90hpOUpoM3ySonjClet0_g-1; Tue, 29 Nov 2022 05:18:32 -0500
X-MC-Unique: 90hpOUpoM3ySonjClet0_g-1
Received: by mail-qv1-f72.google.com with SMTP id p9-20020ad452c9000000b004c697f6fdffso18952348qvs.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAbL1ssqA8qFivaztpNHDU9ON2lj4Fx1D9mtv2aT0SY=;
        b=KvnJXVb3W9lAsY9I9yDG2YcUaFBE/0YywpQ3tNFurMR/GAXu2usnb/tQcBBEOLjHtB
         SYsI1WKK4fr7jFqwPSXaWxwhaarMuPUNykykQqj9fClu3DG/TAQGqFt0J97WBJuMyTv3
         C2rHlOf9NUDy0bOsO5j8SnEasOOwFIxEVtkiOyELyv7FlKNXRtZiBg3sx9oMfyy8RqSF
         VJGvdfIz++XdW0loBhUD1lRflwQ9ZXSf/axrVhy9jxI0ISSSojqiShz5xDy/h6Z/Nw3+
         J6ay9kqy6GaRECfJBGwOdJJIp2hbRzeYv91T3aCz2xkQyISaca5u56ayQZHC3JajXIQO
         qa3A==
X-Gm-Message-State: ANoB5pmJLQzbd7Cic5W3jzIfpEc4467cWwmCO/lAJg0/ybZhixrVg1jj
        oTPPyQP3QSQRkNrQz5fv27f29Oyr5U14R8WR2IYJ4JYkVZTadJrTBQIX9DijIr6yjGJHSNWMG4z
        henPmnNdzQXfKD6ltqn5Eb1mu
X-Received: by 2002:ac8:7216:0:b0:3a5:fbf9:1f40 with SMTP id a22-20020ac87216000000b003a5fbf91f40mr34704961qtp.323.1669717111573;
        Tue, 29 Nov 2022 02:18:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6OG2Lp28aTI1uKnW89jB3ZtdEFhvIDHTXnonO17guMPNEl/wX4VHIXnut13EfQBgskRdIRrQ==
X-Received: by 2002:ac8:7216:0:b0:3a5:fbf9:1f40 with SMTP id a22-20020ac87216000000b003a5fbf91f40mr34704940qtp.323.1669717111296;
        Tue, 29 Nov 2022 02:18:31 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id d13-20020a05622a100d00b0039853b7b771sm8482973qte.80.2022.11.29.02.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 02:18:30 -0800 (PST)
Message-ID: <a8b0508520f0dbafd3a191aa2907996fac58af62.camel@redhat.com>
Subject: Re: [PATCH RESEND net-next] tcp: socket-specific version of
 WARN_ON_ONCE()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Breno Leitao <leitao@debian.org>, edumazet@google.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, leit@fb.com, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 29 Nov 2022 11:18:27 +0100
In-Reply-To: <20221124112229.789975-1-leitao@debian.org>
References: <20221124112229.789975-1-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, 2022-11-24 at 03:22 -0800, Breno Leitao wrote:
> There are cases where we need information about the socket during a
> warning, so, it could help us to find bugs that happens and do not have
> an easy repro.
> 
> This diff creates a TCP socket-specific version of WARN_ON_ONCE(), which
> dumps more information about the TCP socket.
> 
> This new warning is not only useful to give more insight about kernel bugs, but,
> it is also helpful to expose information that might be coming from buggy
> BPF applications, such as BPF applications that sets invalid
> tcp_sock->snd_cwnd values.

I personally find this use-case a little too tight, you could likelly
fetch the same information with a perf probe or something similar.

> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/net/tcp.h       |  3 ++-
>  include/net/tcp_debug.h | 10 ++++++++++
>  net/ipv4/tcp.c          | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 include/net/tcp_debug.h
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 14d45661a84d..e490af8e6fdc 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -40,6 +40,7 @@
>  #include <net/inet_ecn.h>
>  #include <net/dst.h>
>  #include <net/mptcp.h>
> +#include <net/tcp_debug.h>
>  
>  #include <linux/seq_file.h>
>  #include <linux/memcontrol.h>
> @@ -1229,7 +1230,7 @@ static inline u32 tcp_snd_cwnd(const struct tcp_sock *tp)
>  
>  static inline void tcp_snd_cwnd_set(struct tcp_sock *tp, u32 val)
>  {
> -	WARN_ON_ONCE((int)val <= 0);
> +	TCP_SOCK_WARN_ON_ONCE(tp, (int)val <= 0);
>  	tp->snd_cwnd = val;
>  }
>  
> diff --git a/include/net/tcp_debug.h b/include/net/tcp_debug.h
> new file mode 100644
> index 000000000000..50e96d87d335
> --- /dev/null
> +++ b/include/net/tcp_debug.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_TCP_DEBUG_H
> +#define _LINUX_TCP_DEBUG_H
> +
> +void tcp_sock_warn(const struct tcp_sock *tp);
> +
> +#define TCP_SOCK_WARN_ON_ONCE(tcp_sock, condition) \
> +		DO_ONCE_LITE_IF(condition, tcp_sock_warn, tcp_sock)
> +
> +#endif  /* _LINUX_TCP_DEBUG_H */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 54836a6b81d6..dd682f60c7cb 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4705,6 +4705,36 @@ int tcp_abort(struct sock *sk, int err)
>  }
>  EXPORT_SYMBOL_GPL(tcp_abort);
>  
> +void tcp_sock_warn(const struct tcp_sock *tp)
> +{
> +	const struct sock *sk = (const struct sock *)tp;
> +	struct inet_sock *inet = inet_sk(sk);
> +	struct inet_connection_sock *icsk = inet_csk(sk);
> +
> +	WARN_ON(1);
> +
> +	if (!tp)
> +		return;
> +
> +	pr_warn("Socket Info: family=%u state=%d sport=%u dport=%u ccname=%s cwnd=%u",
> +		sk->sk_family, sk->sk_state, ntohs(inet->inet_sport),
> +		ntohs(inet->inet_dport), icsk->icsk_ca_ops->name, tcp_snd_cwnd(tp));
> +
> +	switch (sk->sk_family) {
> +	case AF_INET:
> +		pr_warn("saddr=%pI4 daddr=%pI4", &inet->inet_saddr,
> +			&inet->inet_daddr);
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +		pr_warn("saddr=%pI6 daddr=%pI6", &sk->sk_v6_rcv_saddr,
> +			&sk->sk_v6_daddr);
> +		break;
> +#endif

Please, adjust the output format as suggested by Kuniyuki,

thanks!

Paolo

