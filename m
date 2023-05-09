Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919FE6FC222
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbjEIIzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjEIIzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:55:19 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21A8268F
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:55:17 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f396606ab0so125101cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683622517; x=1686214517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vuyu6kE4VP+GmN/RFWs7fKPD4dCEoMLF4EREkOIT10=;
        b=bKSuoqPWNJKysVKLjrKWrb03pH4C9ONPgwu5dTyD5iNEYO8LsXHWkg5+2rTQ5Uxiro
         xayXEOxa2GDacF+8ZrDNLCUt99xSj/fc8BcDS3wLxnkCiK29y+gEO8CHoWgdQXCAc3Lo
         +cP0ni4d1ObMHX58DJJ4/YKtkpdkHaWS7n/+7OlVbAXM0SubGOIiGN5Mf4y999gKTxb3
         wphr5r1QQP5zototr1qDvICpW59Rqn9mHeFpZtJIW9cxY+PCBBO70KsUZdD355t5K+AX
         KHtbkljFtbX6EoL4HkQK0NjkY6HekajWUCFDp1/4GXHzSk3BVdrAqGttDMYyTPLPzHrp
         hIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683622517; x=1686214517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vuyu6kE4VP+GmN/RFWs7fKPD4dCEoMLF4EREkOIT10=;
        b=Z8NxJ4ru3BNLxbrX09efIbFYEm4ZtJ36i6H3VjYRxW5uXnLpZwymXyzgvchWL5hMjh
         R6i1Fr/sUXHddkINblZtl1uKA20Q/e+qn+qoQB57kOfqNbqjrWzHUSJ7ju6Z1nC9J3Nk
         y2ZA2G2G9ggQvIUOzDv0RLT/vjkRDUM6d3Zt4vUKVtlgF23I6EiJO5nSoXbGyq/Ysw/j
         X8RXRMyGZXfAlKBoJMumc7BYPP6hDoEBUY7gN+vkHGO5cvtvA4bQDxe3hhXU6As8UX49
         r4vHy0Ede6u+hXIEf1y+Fqi1HY+TvLfyKva+nd+kI9Xc/OEeBcZgn7RvJEIGgWIcL8zh
         OQiA==
X-Gm-Message-State: AC+VfDww3Rt7sDYHrbc4zYrFR3hrQFiSteWNxn3iPX/QajK0u3NyhNHP
        aq4rbM9GGE0JUsbNhV+5h1pEOh8540X0ooXR8GwHPw==
X-Google-Smtp-Source: ACHHUZ4HZRTeSZ9MQv2Drxl1T+SrAZVjktaDT8isCG6PeQmGHcyT7JAjTr8dnNqE5ORML/IYxQSk4aPuA4aO9NR8J2A=
X-Received: by 2002:a05:622a:178e:b0:3ef:2f55:2204 with SMTP id
 s14-20020a05622a178e00b003ef2f552204mr354044qtk.6.1683622516809; Tue, 09 May
 2023 01:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230506085903.96133-1-wuyun.abel@bytedance.com>
In-Reply-To: <20230506085903.96133-1-wuyun.abel@bytedance.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 9 May 2023 10:55:05 +0200
Message-ID: <CANn89iK154B-NzRFymx_ggO9ZuVW-0YyHEKi6C46zjHpdRfokQ@mail.gmail.com>
Subject: Re: [PATCH] sock: Fix misuse of sk_under_memory_pressure()
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 6, 2023 at 10:59=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> The commit 180d8cd942ce ("foundations of per-cgroup memory pressure
> controlling") wrapped proto::memory_pressure status into an accessor
> named sk_under_memory_pressure(), and in the next commit e1aab161e013
> ("socket: initial cgroup code") added the consideration of net-memcg
> pressure into this accessor.
>
> But with the former patch applied, not all of the call sites of
> sk_under_memory_pressure() are interested in net-memcg's pressure.
> The __sk_mem_{raise,reduce}_allocated() only focus on proto/netns
> pressure rather than net-memcg's. IOW this accessor are generally
> used for deciding whether should reclaim or not.
>
> Fixes: e1aab161e013 ("socket: initial cgroup code")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  include/net/sock.h |  5 -----
>  net/core/sock.c    | 17 +++++++++--------
>  2 files changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8b7ed7167243..752d51030c5a 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1404,11 +1404,6 @@ static inline int sk_under_cgroup_hierarchy(struct=
 sock *sk,
>  #endif
>  }
>
> -static inline bool sk_has_memory_pressure(const struct sock *sk)
> -{
> -       return sk->sk_prot->memory_pressure !=3D NULL;
> -}
> -
>  static inline bool sk_under_memory_pressure(const struct sock *sk)
>  {
>         if (!sk->sk_prot->memory_pressure)
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 5440e67bcfe3..8d215f821ea6 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3017,13 +3017,14 @@ int __sk_mem_raise_allocated(struct sock *sk, int=
 size, int amt, int kind)
>                 }
>         }
>
> -       if (sk_has_memory_pressure(sk)) {
> -               u64 alloc;
> -
> -               if (!sk_under_memory_pressure(sk))
> -                       return 1;
> -               alloc =3D sk_sockets_allocated_read_positive(sk);
> -               if (sk_prot_mem_limits(sk, 2) > alloc *
> +       if (prot->memory_pressure) {

I do not understand this patch.

Changelog is evasive, I do not see what practical problem you want to solve=
.

sk_has_memory_pressure() is not about memcg, simply the fact that a
proto has a non NULL memory_pressure pointer.
