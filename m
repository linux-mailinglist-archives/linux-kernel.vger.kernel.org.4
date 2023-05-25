Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2406711AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbjEYXnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEYXnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:43:00 -0400
Received: from out-34.mta0.migadu.com (out-34.mta0.migadu.com [IPv6:2001:41d0:1004:224b::22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB5312F
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 16:42:59 -0700 (PDT)
Message-ID: <7188429a-c380-14c8-57bb-9d05d3ba4e5e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685058175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cEWHFC+tyHwwjk19PVCSJ1YdwxL9+T4gCvhEfMMt5tI=;
        b=Hbnh35/ncWfFI5sf/wrM3kOXXVBum+XmbBuy7X03+bbvbaSXBa7oajd2kzFJveRI6famim
        NP7Jq/gGzFcjlCP59SssUXEh7Bt+liNPx/zQrbjz/lf5TL7QJxgff1KRdDc7irDi9eNgGS
        x/Ik1cMlCnS9xAjQfxkKx1hWN2dKTsk=
Date:   Thu, 25 May 2023 16:42:46 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf, net: Support SO_REUSEPORT sockets with
 bpf_sk_assign
Content-Language: en-US
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Joe Stringer <joe@cilium.io>, Martin KaFai Lau <kafai@fb.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Joe Stringer <joe@wand.net.nz>
References: <20230525081923.8596-1-lmb@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230525081923.8596-1-lmb@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/23 1:19 AM, Lorenz Bauer wrote:
> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
> index 56f1286583d3..3ba4dc2703da 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -48,6 +48,13 @@ struct sock *__inet6_lookup_established(struct net *net,
>   					const u16 hnum, const int dif,
>   					const int sdif);
>   
> +struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
> +				    struct sk_buff *skb, int doff,
> +				    const struct in6_addr *saddr,
> +				    __be16 sport,
> +				    const struct in6_addr *daddr,
> +				    unsigned short hnum);
> +
>   struct sock *inet6_lookup_listener(struct net *net,
>   				   struct inet_hashinfo *hashinfo,
>   				   struct sk_buff *skb, int doff,
> @@ -85,14 +92,33 @@ static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
>   					      int iif, int sdif,
>   					      bool *refcounted)
>   {
> -	struct sock *sk = skb_steal_sock(skb, refcounted);
> -
> +	bool prefetched;
> +	struct sock *sk = skb_steal_sock(skb, refcounted, &prefetched);
> +	struct net *net = dev_net(skb_dst(skb)->dev);
> +	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
> +
> +	if (prefetched) {
> +		struct sock *reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,

If sk is TCP_ESTABLISHED, I suspect sk->sk_reuseport is 1 (from sk_clone)?

If it is, it should still work other than an extra inet6_ehashfn. Does it worth 
an extra sk->sk_state check or it is overkill?


> +							       &ip6h->saddr, sport,
> +							       &ip6h->daddr, ntohs(dport));

