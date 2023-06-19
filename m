Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4BB735186
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjFSKIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjFSKIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:08:20 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6620134
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:08:19 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3fde9bfb3c8so216131cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687169299; x=1689761299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sc9cJ6usscm6Ij2tQjnNdZlm85wrZazMfBi//urMko4=;
        b=MB/K51c4OvvhQqEdFScFEhKv86Sx+OoRDgl6LnByrRNcI+KEtwH0qYyMmCI/0pqIuI
         h3Vci0bo7z8H2Tvc+MYx8vaBMWVx0bKrRrPgd636nQJTLowPBm2U2bGOH+nSOJJAKdnB
         FRLUBYC+XJwEhxO1Mkbo1O5fEyi+vWwsypu5iZnsAD8Za/8rtBUZJaXmj848eKRKBR3a
         TlvwRZ9QmQJZftJ5c9A0vX8fFIWr4LYHnaUc9Ciq3W0R7nkCz7eUgsGxsWw/p7xvMmlz
         P3bakp8ebGg+uukalg1Vs3BVehnhJ2hezWwOJKnzDj5Cw86yzqRZXvH/vnnNOlywZDde
         zhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687169299; x=1689761299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sc9cJ6usscm6Ij2tQjnNdZlm85wrZazMfBi//urMko4=;
        b=jGa9jOJz/Rgd7NhklSbmwf9HPqnBXJuM1m/ccGrB0RLVdsxRuWqYh5apiqyu0O7JeV
         UuG9Z9GdLlaGxuEbI2BjYXctW0mUEWsWetAyoM0gGuVkgOBrGyEPSdWu6/NNn0Qt+li/
         bHzY4aAsdmFJMpmTLKsmgThbRxYtYLAnY/u501qUr7ZLubbWF2DhNr3kP4MSbOHR4ZDA
         uxhpe5p+NeKw7n4h4HxGPaaSF7tWwEyB2knCAlBqAexul3roUaY+cLzzE1pwp3pPvQKU
         HJf2+9dV329t5wm2zqWYez3PBfZMtJXBECEgquubIezSY2O2Kf2NZGiY/5OKL6JErm1Z
         CHwQ==
X-Gm-Message-State: AC+VfDx1bjxlYSh+u4e9vnpSHqIM8QPuRhs58sn4xInJ8uGQmLyFmOYL
        Ua1eJd+B3KePb8jmOPk1qGNGsH7+ZzeTA/j0eQX7sQ==
X-Google-Smtp-Source: ACHHUZ6DXozSYx4P4n9OspYAxsZSyNwGnGWiAr7oC/mIlQO5JIaYJtuZVYyz/Bwbl52/VZU2z8SqimCjlDFsfQobdL0=
X-Received: by 2002:ac8:5992:0:b0:3f5:2006:50f1 with SMTP id
 e18-20020ac85992000000b003f5200650f1mr908051qte.12.1687169298618; Mon, 19 Jun
 2023 03:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230619082547.73929-1-wuyun.abel@bytedance.com>
In-Reply-To: <20230619082547.73929-1-wuyun.abel@bytedance.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 19 Jun 2023 12:08:07 +0200
Message-ID: <CANn89i+deprQWB0dmsUD1sRmy1VQCQwKnZUkLu_AEGV=ow=PKQ@mail.gmail.com>
Subject: Re: [PATCH net-next] inet: Save one atomic op if no memcg to charge
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING [IPv4/IPv6]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Mon, Jun 19, 2023 at 10:26=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com>=
 wrote:
>
> If there is no net-memcg associated with the sock, don't bother
> calculating its memory usage for charge.
>
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  net/ipv4/inet_connection_sock.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 65ad4251f6fd..73798282c1ef 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -706,20 +706,24 @@ struct sock *inet_csk_accept(struct sock *sk, int f=
lags, int *err, bool kern)
>  out:
>         release_sock(sk);
>         if (newsk && mem_cgroup_sockets_enabled) {
> -               int amt;
> +               int amt =3D 0;
>
>                 /* atomically get the memory usage, set and charge the
>                  * newsk->sk_memcg.
>                  */
>                 lock_sock(newsk);
>
> -               /* The socket has not been accepted yet, no need to look =
at
> -                * newsk->sk_wmem_queued.
> -                */
> -               amt =3D sk_mem_pages(newsk->sk_forward_alloc +
> -                                  atomic_read(&newsk->sk_rmem_alloc));
>                 mem_cgroup_sk_alloc(newsk);
> -               if (newsk->sk_memcg && amt)
> +               if (newsk->sk_memcg) {
> +                       /* The socket has not been accepted yet, no need
> +                        * to look at newsk->sk_wmem_queued.
> +                        */
> +                       amt =3D sk_mem_pages(newsk->sk_forward_alloc +
> +                                          atomic_read(&newsk->sk_rmem_al=
loc));
> +
> +               }
> +
> +               if (amt)
>                         mem_cgroup_charge_skmem(newsk->sk_memcg, amt,
>                                                 GFP_KERNEL | __GFP_NOFAIL=
);

This looks correct, but claiming reading an atomic_t is an 'atomic op'
is a bit exaggerated.
