Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA3C74B21E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjGGNpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGGNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:45:16 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91472117
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:44:53 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-401f4408955so225661cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688737493; x=1691329493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMAD3rRxGAPJwgFsPYYUaElPo0zHq1tuXPrG8L429FU=;
        b=JgCvs3CKYDETsPK4T/fy6X9gIXBGRcayLS929Q4OvSducbjYV9maQRW2YPUmdmr+Ve
         4xvS/ntJgdwybTd0w7g9GUekvBe3Bo3L9ALOTpX+cysGifcS/DpR/TI4O8s/ijmPJDma
         qVdxVAegDHhAFQ4uRr9Q5DvnyzHg9+92EVOdW+TrLhmhWJFVq0ZPdwgRpclFVhdMJqJd
         ot9bZ9mceZsyaT11j0de8jKexnDAFs9176qwKIIkSPztk/MuUbNhBo9oMa6JXAOWkKMR
         enLJJQ7JHF9Nr3wdWNZewpsqXo7X/81auPH5GH2QXB0rk/d3001v+JeTvoStwoADTKI4
         WXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737493; x=1691329493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMAD3rRxGAPJwgFsPYYUaElPo0zHq1tuXPrG8L429FU=;
        b=aNssi7CwwSNzdlSzEneOUv8kpGOpBkII25qbtgvv98A4ZZjoZr7M1be9hJpGl3LPoh
         m8g3glzH+JtH2U04Io8bu/f4ALPG657V3okzJSKzRIiC0s/lHFt4OE7EJjyg8tHeokfM
         9JAESTXiaI+22jRRxDw04rr6wdRFKqVVW7aplKvtFr1FH5yzylQzum29ssA1cUuRpi7U
         RN2v9KY2ihVtdV1cB7PuG9gGOM6umSTpG+zTDgRVNRgU3Hj7IIBk8IJyZgPPLQp+3/C0
         vuC0tw8bBRpQINBXGDS7tCvt/y9OWIEfKpAW3+NZUUBoHYXJ/7qh21QbgSqGS+kw6ZRy
         bUTA==
X-Gm-Message-State: ABy/qLbW6KMP4hMw38k3WfFd3pxvQux7oK8nz/wKp5P8fW82ZDi3J/Ig
        sdzjRDszCcVViVlyphLiWFaU2QWPgLnvV34+kJoIfw==
X-Google-Smtp-Source: APBJJlG+KbNfFJ2cKFEADSdf6piIFjRq9AvIRzcUgJqcluzdvPf6Zb8obPMhoZfEpYCQZM5i8e1EavaWauaPzxYMGX0=
X-Received: by 2002:a05:622a:1015:b0:3f4:f841:df89 with SMTP id
 d21-20020a05622a101500b003f4f841df89mr149875qte.1.1688737492664; Fri, 07 Jul
 2023 06:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230707121650.GA17677@debian> <20230707122627.GA17845@debian>
In-Reply-To: <20230707122627.GA17845@debian>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 7 Jul 2023 15:44:41 +0200
Message-ID: <CANn89i+gm=0J3aR_9ikhroQmAvuQ+-dPMH1em9WrmE1o1pfi7w@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: gro: fix misuse of CB in udp socket lookup
To:     Richard Gobert <richardbgobert@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
        tom@herbertland.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gal@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 2:26=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
.com> wrote:
>
> This patch fixes a misuse of IP{6}CB(skb) in GRO, while calling to
> `udp6_lib_lookup2` when handling udp tunnels. `udp6_lib_lookup2` fetch th=
e
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
> @@ -299,6 +299,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, in=
t optname,
>  int udp_lib_setsockopt(struct sock *sk, int level, int optname,
>                        sockptr_t optval, unsigned int optlen,
>                        int (*push_pending_frames)(struct sock *));
> +void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif);
>  struct sock *udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport=
,
>                              __be32 daddr, __be16 dport, int dif);
>  struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr, __be16 spo=
rt,
> @@ -310,6 +311,7 @@ struct sock *udp6_lib_lookup(struct net *net,
>                              const struct in6_addr *saddr, __be16 sport,
>                              const struct in6_addr *daddr, __be16 dport,
>                              int dif);
> +void udp6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif);
>  struct sock *__udp6_lib_lookup(struct net *net,
>                                const struct in6_addr *saddr, __be16 sport=
,
>                                const struct in6_addr *daddr, __be16 dport=
,
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 42a96b3547c9..0581ab184afd 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -550,15 +550,32 @@ static inline struct sock *__udp4_lib_lookup_skb(st=
ruct sk_buff *skb,
>                                  inet_sdif(skb), udptable, skb);
>  }
>
> +void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
> +{
> +       *iif =3D inet_iif(skb) || skb->dev->ifindex;

This looks wrong. Did you mean

        *iif =3D inet_iif(skb) ?: skb->dev->ifindex;

> +       *sdif =3D 0;
> +
> +#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
> +       if (netif_is_l3_slave(skb->dev)) {
> +               struct net_device *master =3D netdev_master_upper_dev_get=
_rcu(skb->dev);
> +               *sdif =3D *iif;
> +               *iif =3D master ? master->ifindex : 0;
> +       }
> +#endif
> +}
> +
>  struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
>                                  __be16 sport, __be16 dport)
>  {
>         const struct iphdr *iph =3D ip_hdr(skb);
>         struct net *net =3D dev_net(skb->dev);
> +       int iif, sdif;
> +
> +       udp4_get_iif_sdif(skb, &iif, &sdif);
>
>         return __udp4_lib_lookup(net, iph->saddr, sport,
> -                                iph->daddr, dport, inet_iif(skb),
> -                                inet_sdif(skb), net->ipv4.udp_table, NUL=
L);
> +                                iph->daddr, dport, iif,
> +                                sdif, net->ipv4.udp_table, NULL);
>  }
>
>  /* Must be called under rcu_read_lock().
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 75aa4de5b731..70d760b271db 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -603,10 +603,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk_b=
uff *skb, __be16 sport,
>  {
>         const struct iphdr *iph =3D skb_gro_network_header(skb);
>         struct net *net =3D dev_net(skb->dev);
> +       int iif, sdif;
> +
> +       udp4_get_iif_sdif(skb, &iif, &sdif);
>
>         return __udp4_lib_lookup(net, iph->saddr, sport,
> -                                iph->daddr, dport, inet_iif(skb),
> -                                inet_sdif(skb), net->ipv4.udp_table, NUL=
L);
> +                                iph->daddr, dport, iif,
> +                                sdif, net->ipv4.udp_table, NULL);
>  }
>
>  INDIRECT_CALLABLE_SCOPE
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 317b01c9bc39..aac9b20d67e4 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -294,15 +294,32 @@ static struct sock *__udp6_lib_lookup_skb(struct sk=
_buff *skb,
>                                  inet6_sdif(skb), udptable, skb);
>  }
>
> +void udp6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
> +{
> +       *iif =3D skb->dev->ifindex;

ipv6_rcv() inits

IP6CB(skb)->iif =3D skb_dst(skb) ?
ip6_dst_idev(skb_dst(skb))->dev->ifindex : dev->ifindex;

You chose to always use skb->dev->ifindex instead ?

You might add a comment why it is okay.

> +       *sdif =3D 0;
> +
> +#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
> +       if (netif_is_l3_slave(skb->dev)) {
> +               struct net_device *master =3D netdev_master_upper_dev_get=
_rcu(skb->dev);
> +               *sdif =3D *iif;
> +               *iif =3D master ? master->ifindex : 0;
> +       }
> +#endif
> +}
> +
>  struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
>                                  __be16 sport, __be16 dport)
>  {
>         const struct ipv6hdr *iph =3D ipv6_hdr(skb);
>         struct net *net =3D dev_net(skb->dev);
> +       int iif, sdif;
> +
> +       udp6_get_iif_sdif(skb, &iif, &sdif);
>
>         return __udp6_lib_lookup(net, &iph->saddr, sport,
> -                                &iph->daddr, dport, inet6_iif(skb),
> -                                inet6_sdif(skb), net->ipv4.udp_table, NU=
LL);
> +                                &iph->daddr, dport, iif,
> +                                sdif, net->ipv4.udp_table, NULL);
>  }
>
>  /* Must be called under rcu_read_lock().
> diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
> index ad3b8726873e..88191d79002e 100644
> --- a/net/ipv6/udp_offload.c
> +++ b/net/ipv6/udp_offload.c
> @@ -119,10 +119,13 @@ static struct sock *udp6_gro_lookup_skb(struct sk_b=
uff *skb, __be16 sport,
>  {
>         const struct ipv6hdr *iph =3D skb_gro_network_header(skb);
>         struct net *net =3D dev_net(skb->dev);
> +       int iif, sdif;
> +
> +       udp6_get_iif_sdif(skb, &iif, &sdif);
>
>         return __udp6_lib_lookup(net, &iph->saddr, sport,
> -                                &iph->daddr, dport, inet6_iif(skb),
> -                                inet6_sdif(skb), net->ipv4.udp_table, NU=
LL);
> +                                &iph->daddr, dport, iif,
> +                                sdif, net->ipv4.udp_table, NULL);
>  }
>
>  INDIRECT_CALLABLE_SCOPE
> --
> 2.36.1
>
