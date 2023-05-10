Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2CA6FE655
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjEJVbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjEJVbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:31:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C40273A
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:31:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-643990c5373so7787961b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683754296; x=1686346296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dilDKvLCh912/JBRw2vO/HiVmrKv/M0bEgV3+XRucAc=;
        b=CWdjuapDrxVvjL+NbU0Z7r7YLgIF/8WG4X8TGoU/rY0/jBkTpsVNpN8BuGOUwfDydi
         /C4sQDaca9lTm7Ttwlpxhy3oiv8L86cQJ5n2s8e5XZEI8VJeiXykB6wcUDMLwC8WToUK
         57Xwdy7G1OtX1rHqs6ynvUDGhszNOmgbxEszHbS8+DYh8lxr9iDXkbL52IDHpVVdDqbD
         vWhS7GmUZLXfoGHkBUpYxrmqrR88fCnywib0lJs4+j2t/o4U4CGrjQr9NJSGNooy6oFj
         BFlZhhvk4fJ+C6xOld8dFfukqDzRflnVqtuxW78TGmvpx3vbohx35h1SAV0G/yNxpb7R
         kZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683754296; x=1686346296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dilDKvLCh912/JBRw2vO/HiVmrKv/M0bEgV3+XRucAc=;
        b=Cn7+9ggDKHDtGFIfORyVeN55/irLqXcq0/27tnX1Vuw/Dtlb5yPpqvOQ/iMHWmoY5J
         5UDd1DGuURmXB/O3k9F7Fm1sJAtg38pS495mj5SuUSnKvUCKZQw9LF8ZoraGB8TuL2lU
         YHSWQkbrZvQg2NxgzTjf3rKkEZKdI/ZMLcpggaPcZWLmutq2KsTvVi99ViqF2tpo4b5P
         p2p4pdF5CYcHi/BTVMrKrMrSDVLoSjrf0Ssqk+fOww/G9fiLKSIrhlZc7FcL9ZvYHvS5
         uAeaiGMx0T9mTuCIsf651IPlie6oUKGESSslqFp5fAr+NskGRnrWBI2ow4kk0hfFGDqL
         Le1w==
X-Gm-Message-State: AC+VfDxwnMPLML+pT4y/LAol7oCjS3RPtG2lRg7dqIedg6LWUjBp5LPX
        WhcB12/JY3hNfsE4vFBFGOL5raxkvMl358XzCdZ1Cw==
X-Google-Smtp-Source: ACHHUZ74oA92M2oyte9ZwQqFQMLwi4FAmCL45SgTYqyIDZnMMcH93WNEj5//wMcp0Tf/bB3sl4rmpo4z3TUompF7XqU=
X-Received: by 2002:a17:902:ba84:b0:1ab:1c09:2df8 with SMTP id
 k4-20020a170902ba8400b001ab1c092df8mr19326387pls.50.1683754295424; Wed, 10
 May 2023 14:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230510152216.1392682-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20230510152216.1392682-1-aleksandr.mikhalitsyn@canonical.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 10 May 2023 14:31:24 -0700
Message-ID: <CAKH8qBuAoobsVP2Q5KN06fZ2NM3_aMwT7Y2OoKwS4Cf=cv3ZGg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: core: add SOL_SOCKET filter for bpf
 getsockopt hook
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     davem@davemloft.net, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Christian Brauner <brauner@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
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

On Wed, May 10, 2023 at 8:23=E2=80=AFAM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> We have per struct proto ->bpf_bypass_getsockopt callback
> to filter out bpf socket cgroup getsockopt hook from being called.
>
> It seems worthwhile to add analogical helper for SOL_SOCKET
> level socket options. First user will be SO_PEERPIDFD.
>
> This patch was born as a result of discussion around a new SCM_PIDFD inte=
rface:
> https://lore.kernel.org/all/20230413133355.350571-3-aleksandr.mikhalitsyn=
@canonical.com/
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> ---
>  include/linux/bpf-cgroup.h | 8 +++++---
>  include/net/sock.h         | 1 +
>  net/core/sock.c            | 5 +++++
>  3 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 57e9e109257e..97d8a49b35bf 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -387,10 +387,12 @@ static inline bool cgroup_bpf_sock_enabled(struct s=
ock *sk,
>         int __ret =3D retval;                                            =
        \
>         if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT) &&                     =
      \
>             cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))            =
      \
> -               if (!(sock)->sk_prot->bpf_bypass_getsockopt ||           =
      \
> -                   !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypass_get=
sockopt, \
> +               if (((level !=3D SOL_SOCKET) ||                          =
        \
> +                    !sock_bpf_bypass_getsockopt(level, optname)) &&     =
      \
> +                   (!(sock)->sk_prot->bpf_bypass_getsockopt ||          =
      \

Any reason we are not putting this into bpf_bypass_getsockopt for
af_unix struct proto? SO_PEERPIDFD seems relevant only for af_unix?

> +                    !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypass_ge=
tsockopt, \
>                                         tcp_bpf_bypass_getsockopt,       =
      \
> -                                       level, optname))                 =
      \
> +                                       level, optname)))                =
      \
>                         __ret =3D __cgroup_bpf_run_filter_getsockopt(    =
        \
>                                 sock, level, optname, optval, optlen,    =
      \
>                                 max_optlen, retval);                     =
      \
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8b7ed7167243..530d6d22f42d 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1847,6 +1847,7 @@ int sk_getsockopt(struct sock *sk, int level, int o=
ptname,
>                   sockptr_t optval, sockptr_t optlen);
>  int sock_getsockopt(struct socket *sock, int level, int op,
>                     char __user *optval, int __user *optlen);
> +bool sock_bpf_bypass_getsockopt(int level, int optname);
>  int sock_gettstamp(struct socket *sock, void __user *userstamp,
>                    bool timeval, bool time32);
>  struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long head=
er_len,
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 5440e67bcfe3..194a423eb6e5 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1963,6 +1963,11 @@ int sock_getsockopt(struct socket *sock, int level=
, int optname,
>                              USER_SOCKPTR(optlen));
>  }
>
> +bool sock_bpf_bypass_getsockopt(int level, int optname)
> +{
> +       return false;
> +}
> +
>  /*
>   * Initialize an sk_lock.
>   *
> --
> 2.34.1
>
