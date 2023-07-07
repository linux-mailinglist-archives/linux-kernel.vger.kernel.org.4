Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E1F74B686
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 20:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjGGSm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 14:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGGSm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 14:42:28 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CA71BF4;
        Fri,  7 Jul 2023 11:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1688755347; x=1720291347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7L26AVxMyRhx/91V3GVReGBwPcjkEqdQUUcuaP0rAuk=;
  b=PO4c4Qiv9Qc2HQDx3E5vqhvhdvoF4l2c6RjcY9uDzIqDF7thVl5H4IoS
   8tukc9Wr/4uJwj66DPU2RsrMMBodx0pmCQ1774WkHtEcPA3QLIV+b8Cep
   xtA5KxrKGG21TAZm7sqRLVLHl71DfGajSnOOc7Q1IbQ5EPizlFYhyMYpt
   c=;
X-IronPort-AV: E=Sophos;i="6.01,189,1684800000"; 
   d="scan'208";a="14911140"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 18:42:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com (Postfix) with ESMTPS id 203F560DD8;
        Fri,  7 Jul 2023 18:42:24 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 7 Jul 2023 18:42:23 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 7 Jul 2023 18:42:20 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <richardbgobert@gmail.com>
CC:     <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
        <gal@nvidia.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <tom@herbertland.com>,
        <willemdebruijn.kernel@gmail.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH 1/1] net: gro: fix misuse of CB in udp socket lookup
Date:   Fri, 7 Jul 2023 11:42:12 -0700
Message-ID: <20230707184212.23411-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230707122627.GA17845@debian>
References: <20230707122627.GA17845@debian>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.9]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gobert <richardbgobert@gmail.com>
Date: Fri, 7 Jul 2023 14:26:28 +0200
> This patch fixes a misuse of IP{6}CB(skb) in GRO, while calling to
> `udp6_lib_lookup2` when handling udp tunnels. `udp6_lib_lookup2` fetch the
> device from CB. The fix changes it to fetch the device from `skb->dev`.
> l3mdev case requires special attention since it has a master and a slave
> device.
> 
> Fixes: a6024562ffd7 ("udp: Add GRO functions to UDP socket")
> Reported-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/udp.h      |  2 ++
>  net/ipv4/udp.c         | 21 +++++++++++++++++++--
>  net/ipv4/udp_offload.c |  7 +++++--
>  net/ipv6/udp.c         | 21 +++++++++++++++++++--
>  net/ipv6/udp_offload.c |  7 +++++--
>  5 files changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/udp.h b/include/net/udp.h
> index 4d13424f8f72..48af1479882f 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -299,6 +299,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
>  int udp_lib_setsockopt(struct sock *sk, int level, int optname,
>  		       sockptr_t optval, unsigned int optlen,
>  		       int (*push_pending_frames)(struct sock *));
> +void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif);
>  struct sock *udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
>  			     __be32 daddr, __be16 dport, int dif);
>  struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
> @@ -310,6 +311,7 @@ struct sock *udp6_lib_lookup(struct net *net,
>  			     const struct in6_addr *saddr, __be16 sport,
>  			     const struct in6_addr *daddr, __be16 dport,
>  			     int dif);
> +void udp6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif);
>  struct sock *__udp6_lib_lookup(struct net *net,
>  			       const struct in6_addr *saddr, __be16 sport,
>  			       const struct in6_addr *daddr, __be16 dport,
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 42a96b3547c9..0581ab184afd 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -550,15 +550,32 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
>  				 inet_sdif(skb), udptable, skb);
>  }
> 
> +void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
> +{
> +	*iif = inet_iif(skb) || skb->dev->ifindex;
> +	*sdif = 0;
> +
> +#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
> +	if (netif_is_l3_slave(skb->dev)) {
> +		struct net_device *master = netdev_master_upper_dev_get_rcu(skb->dev);

nit: blank line here for checkpatch.


> +		*sdif = *iif;
> +		*iif = master ? master->ifindex : 0;
> +	}
> +#endif
> +}
> +
>  struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
>  				 __be16 sport, __be16 dport)
>  {
>  	const struct iphdr *iph = ip_hdr(skb);
>  	struct net *net = dev_net(skb->dev);
> +	int iif, sdif;
> +
> +	udp4_get_iif_sdif(skb, &iif, &sdif);
> 
>  	return __udp4_lib_lookup(net, iph->saddr, sport,
> -				 iph->daddr, dport, inet_iif(skb),
> -				 inet_sdif(skb), net->ipv4.udp_table, NULL);
> +				 iph->daddr, dport, iif,
> +				 sdif, net->ipv4.udp_table, NULL);
>  }
> 
>  /* Must be called under rcu_read_lock().
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 75aa4de5b731..70d760b271db 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -603,10 +603,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
>  {
>  	const struct iphdr *iph = skb_gro_network_header(skb);
>  	struct net *net = dev_net(skb->dev);
> +	int iif, sdif;
> +
> +	udp4_get_iif_sdif(skb, &iif, &sdif);
> 
>  	return __udp4_lib_lookup(net, iph->saddr, sport,
> -				 iph->daddr, dport, inet_iif(skb),
> -				 inet_sdif(skb), net->ipv4.udp_table, NULL);
> +				 iph->daddr, dport, iif,
> +				 sdif, net->ipv4.udp_table, NULL);
>  }
> 
>  INDIRECT_CALLABLE_SCOPE
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 317b01c9bc39..aac9b20d67e4 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -294,15 +294,32 @@ static struct sock *__udp6_lib_lookup_skb(struct sk_buff *skb,
>  				 inet6_sdif(skb), udptable, skb);
>  }
> 
> +void udp6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
> +{
> +	*iif = skb->dev->ifindex;
> +	*sdif = 0;
> +
> +#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
> +	if (netif_is_l3_slave(skb->dev)) {
> +		struct net_device *master = netdev_master_upper_dev_get_rcu(skb->dev);

Same here.


> +		*sdif = *iif;
> +		*iif = master ? master->ifindex : 0;
> +	}
> +#endif
> +}
> +
>  struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
>  				 __be16 sport, __be16 dport)
>  {
>  	const struct ipv6hdr *iph = ipv6_hdr(skb);
>  	struct net *net = dev_net(skb->dev);
> +	int iif, sdif;
> +
> +	udp6_get_iif_sdif(skb, &iif, &sdif);
> 
>  	return __udp6_lib_lookup(net, &iph->saddr, sport,
> -				 &iph->daddr, dport, inet6_iif(skb),
> -				 inet6_sdif(skb), net->ipv4.udp_table, NULL);
> +				 &iph->daddr, dport, iif,
> +				 sdif, net->ipv4.udp_table, NULL);
>  }
> 
>  /* Must be called under rcu_read_lock().
> diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
> index ad3b8726873e..88191d79002e 100644
> --- a/net/ipv6/udp_offload.c
> +++ b/net/ipv6/udp_offload.c
> @@ -119,10 +119,13 @@ static struct sock *udp6_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
>  {
>  	const struct ipv6hdr *iph = skb_gro_network_header(skb);
>  	struct net *net = dev_net(skb->dev);
> +	int iif, sdif;
> +
> +	udp6_get_iif_sdif(skb, &iif, &sdif);
> 
>  	return __udp6_lib_lookup(net, &iph->saddr, sport,
> -				 &iph->daddr, dport, inet6_iif(skb),
> -				 inet6_sdif(skb), net->ipv4.udp_table, NULL);
> +				 &iph->daddr, dport, iif,
> +				 sdif, net->ipv4.udp_table, NULL);
>  }
> 
>  INDIRECT_CALLABLE_SCOPE
> --
> 2.36.1
