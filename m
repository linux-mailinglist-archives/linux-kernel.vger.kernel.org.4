Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8342E6FE65F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjEJVlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEJVlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:41:03 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC0F3A85
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:41:01 -0700 (PDT)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ED6503F4A4
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 21:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683754857;
        bh=m6wgVd9NGqSXcldf6QvSjr1yIoYB5cxk8Q6ivPxNQdY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=GpWzHDCbRZeGMvaTA9C51w62z71GTubTvzZWo3Lc/7xmNebUQvP2YI3TD+3T8DKSL
         yx+onOMnKfIA4ZxUIOdluIRaBnQu/jub6Td14Fx7vcCY77w184qHuv+IAQEQovASSI
         kAl69j4csi2KbHq9HDG1PRAe9trwKYnWcK6nbLmCspFLbwRqKUWYj0BYGOZlgS20Rh
         F3xpgGUw1J8ipiVYxtUVlF3otSYpOJW+4gmynXU7UrbJUrNbpaT1ADTq73kYdKeRds
         FqWk/JHUgeiCqy7gPwjIIe79tU9gBx+I+UkeeEqABmxYI8Yyb+7zy8kBIPcOWmKN0j
         SXBKLCbNT1c4w==
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-ba237aec108so6638020276.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683754857; x=1686346857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6wgVd9NGqSXcldf6QvSjr1yIoYB5cxk8Q6ivPxNQdY=;
        b=eeoy48d3HdKtk6OOobWVAOwbN7UzWDx78Nnn4XutEr9zF+I03oL6C1cL98CCFlGiZ3
         0KzJOjp+a/DUsvU45NkiHMM531WPywvNIkjBNN2uwB5bTPuP8GfcN6rgd+E/BuiPLQVp
         0fAtsdjH01IEzLmEItW9bftYTdHJXSiFlWnF0e0yiy+soiNVs7c/S7SaGbRXIM37T3m0
         5Jrfhart5zIIXCJ2sWdHmOlEMyqJuh2TTstYfsdzGuRXB98sSGJrCwwesV/2NYCizAIr
         bHq5dYyh1MvKAje6O2V/o0jq1zGm5XVO2UuF/VAC49Zt6WDkhKDQKe+7O/CdhoXsK3d3
         QwtA==
X-Gm-Message-State: AC+VfDxgrMhaG49zUE0T6VBsF2XtbhJ58tbv9N9hdsuZ44G9CERAQzXS
        3vS50W+b9w0LeDxyuflvM+WjiXvYYTtV4p2jTuv4ooLuHtRLDT7j+LSkazdHVY+Jgz4UeXphLLs
        do0p7AIndLc67beizhjJ6JrR+ROzjY3D/Jz5v33rNm4FkDzRZk+9Q4ru63A==
X-Received: by 2002:a05:6902:727:b0:b9e:6d19:8dcc with SMTP id l7-20020a056902072700b00b9e6d198dccmr21751048ybt.59.1683754857050;
        Wed, 10 May 2023 14:40:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6HxJ/1TQ3NAW43qRmB0YIfRnnDmDVwytpoKPgforTBE0sLyzrGcvHKku5yUsSLyJO4L6tbCM74I0m2bKdOnRM=
X-Received: by 2002:a05:6902:727:b0:b9e:6d19:8dcc with SMTP id
 l7-20020a056902072700b00b9e6d198dccmr21751038ybt.59.1683754856770; Wed, 10
 May 2023 14:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230510152216.1392682-1-aleksandr.mikhalitsyn@canonical.com> <CAKH8qBuAoobsVP2Q5KN06fZ2NM3_aMwT7Y2OoKwS4Cf=cv3ZGg@mail.gmail.com>
In-Reply-To: <CAKH8qBuAoobsVP2Q5KN06fZ2NM3_aMwT7Y2OoKwS4Cf=cv3ZGg@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Wed, 10 May 2023 23:40:45 +0200
Message-ID: <CAEivzxc3hzqMROfCgshD6qW3=NErpF6LWXFGjoBhPNNzEZ3kDg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: core: add SOL_SOCKET filter for bpf
 getsockopt hook
To:     Stanislav Fomichev <sdf@google.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:31=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
>
> On Wed, May 10, 2023 at 8:23=E2=80=AFAM Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > We have per struct proto ->bpf_bypass_getsockopt callback
> > to filter out bpf socket cgroup getsockopt hook from being called.
> >
> > It seems worthwhile to add analogical helper for SOL_SOCKET
> > level socket options. First user will be SO_PEERPIDFD.
> >
> > This patch was born as a result of discussion around a new SCM_PIDFD in=
terface:
> > https://lore.kernel.org/all/20230413133355.350571-3-aleksandr.mikhalits=
yn@canonical.com/
> >
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: bpf@vger.kernel.org
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  include/linux/bpf-cgroup.h | 8 +++++---
> >  include/net/sock.h         | 1 +
> >  net/core/sock.c            | 5 +++++
> >  3 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> > index 57e9e109257e..97d8a49b35bf 100644
> > --- a/include/linux/bpf-cgroup.h
> > +++ b/include/linux/bpf-cgroup.h
> > @@ -387,10 +387,12 @@ static inline bool cgroup_bpf_sock_enabled(struct=
 sock *sk,
> >         int __ret =3D retval;                                          =
          \
> >         if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT) &&                   =
        \
> >             cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))          =
        \
> > -               if (!(sock)->sk_prot->bpf_bypass_getsockopt ||         =
        \
> > -                   !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypass_g=
etsockopt, \
> > +               if (((level !=3D SOL_SOCKET) ||                        =
          \
> > +                    !sock_bpf_bypass_getsockopt(level, optname)) &&   =
        \
> > +                   (!(sock)->sk_prot->bpf_bypass_getsockopt ||        =
        \
>
> Any reason we are not putting this into bpf_bypass_getsockopt for
> af_unix struct proto? SO_PEERPIDFD seems relevant only for af_unix?

Yes, that should work perfectly well. The reason why I'm going this
way is that we are
declaring all SOL_SOCKET-level options in the net/core/sock.c which is
not specific to any address family.
It seems reasonable to have a way to filter out getsockopt for these
options too.

But I'm not insisting on that way.

Kind regards,
Alex

>
> > +                    !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypass_=
getsockopt, \
> >                                         tcp_bpf_bypass_getsockopt,     =
        \
> > -                                       level, optname))               =
        \
> > +                                       level, optname)))              =
        \
> >                         __ret =3D __cgroup_bpf_run_filter_getsockopt(  =
          \
> >                                 sock, level, optname, optval, optlen,  =
        \
> >                                 max_optlen, retval);                   =
        \
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 8b7ed7167243..530d6d22f42d 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1847,6 +1847,7 @@ int sk_getsockopt(struct sock *sk, int level, int=
 optname,
> >                   sockptr_t optval, sockptr_t optlen);
> >  int sock_getsockopt(struct socket *sock, int level, int op,
> >                     char __user *optval, int __user *optlen);
> > +bool sock_bpf_bypass_getsockopt(int level, int optname);
> >  int sock_gettstamp(struct socket *sock, void __user *userstamp,
> >                    bool timeval, bool time32);
> >  struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long he=
ader_len,
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 5440e67bcfe3..194a423eb6e5 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -1963,6 +1963,11 @@ int sock_getsockopt(struct socket *sock, int lev=
el, int optname,
> >                              USER_SOCKPTR(optlen));
> >  }
> >
> > +bool sock_bpf_bypass_getsockopt(int level, int optname)
> > +{
> > +       return false;
> > +}
> > +
> >  /*
> >   * Initialize an sk_lock.
> >   *
> > --
> > 2.34.1
> >
