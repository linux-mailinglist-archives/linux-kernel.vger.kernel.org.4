Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBF76FEBCC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbjEKGgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjEKGgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:36:35 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC40172D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:36:32 -0700 (PDT)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B24503F4A5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 06:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683786990;
        bh=XY9w/Ra5VtNNGnAwkTxPLsHPDd0g0Ln+BJiNp09GaI8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Tx3JQ68gQyyJiecPEj22651LvG+uDvs5cvlCHPYyNZEe8O1yE+8Y+R+Qn0qqQbFCL
         UIhXSzmdCu5Q8XN8A2fQIxyNER1wie5WK/7MkS/IrdsDecYjMejbpv2N1aDEW9jYOR
         2b3og0nasy1A1i9DMcU923ce6l2YdC+ETq/uupAXTdIfLDCYvRUe1aKd3wFoX5ANwp
         cQu1JOIR9h82oH+8iHJ6qThsnX2YH+hYlbKwXh+qwfmAopxeSOsAbcEPcEP4XS7Gn5
         1ZZyaHh6mpSmOAJ7OVqjAFNIwsthohkJrdwxSLO9nTkMosAHN9nLX7XLO2EzsiZ8rM
         HRFdHXSf9SFEA==
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-b9a829a3de0so18387879276.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683786989; x=1686378989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XY9w/Ra5VtNNGnAwkTxPLsHPDd0g0Ln+BJiNp09GaI8=;
        b=GXUU3dAu1IX/sYlnnSccSrMaZ/6jO0RoDDEnln8r3L/RxJ43xkDmDvSvmOZCR4Oo+Y
         00C5d1kaY5M2NMgyicsw41zlKWoqqODXrIENiE/iLng5zUp0BnWJllPPAgCeIGypzpRi
         SRn7zihcvmPzKhz+VAUAsxFsF5WWsYnUPE0c66Dq/5K4SU9rRzV0+XzVa72XN3CINMv+
         /1Vuv4n+SNF2S+qkVwtTJgLL3xDfP5bBdCSQS2QSCPsGWQUkI622aDVtx9ZbomWVYhUg
         Jr5dMUg8FYOtAxF7DpENLhpyxbRgF2Siuaq6H/mOfQxVNZtz/8RL7W0qPk8tnOo5k+FQ
         iLYQ==
X-Gm-Message-State: AC+VfDxFTnoV+GjCJbnw0GN9TrSIM3qOCaQz178BeSiP+S0U/S/OegIj
        C6nT1350RvARaT1lKwvcJMsD/mMVm/GZTxuZnD9hoqMiRy74qhrzsB8kqzbJtcC4cv8VAkhDXOZ
        KnKy1mUsdpiZaGAJ6G7WgTjeQTAyoqgzi95jp6AyZ+41yvQLjmFSNoDOpl/1v3CFhVw==
X-Received: by 2002:a05:6902:18cd:b0:b9a:29e5:1922 with SMTP id ck13-20020a05690218cd00b00b9a29e51922mr23466510ybb.8.1683786989298;
        Wed, 10 May 2023 23:36:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4aqEPhDtnnC3jxp7GBApiXjpoGJ1ZYWQ92e1ax//bm5EDJ4xKVFAWI4h84qH1T8addxQ3Ey0LwN/+K1Ew0Kc4=
X-Received: by 2002:a05:6902:18cd:b0:b9a:29e5:1922 with SMTP id
 ck13-20020a05690218cd00b00b9a29e51922mr23466501ybb.8.1683786989089; Wed, 10
 May 2023 23:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230510152216.1392682-1-aleksandr.mikhalitsyn@canonical.com>
 <CAKH8qBuAoobsVP2Q5KN06fZ2NM3_aMwT7Y2OoKwS4Cf=cv3ZGg@mail.gmail.com>
 <CAEivzxc3hzqMROfCgshD6qW3=NErpF6LWXFGjoBhPNNzEZ3kDg@mail.gmail.com> <CAKH8qBvp3iNPHrus3NpgwN1JCkSxzTTi3G3WoAR2LKwX1-QzhQ@mail.gmail.com>
In-Reply-To: <CAKH8qBvp3iNPHrus3NpgwN1JCkSxzTTi3G3WoAR2LKwX1-QzhQ@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Thu, 11 May 2023 08:36:18 +0200
Message-ID: <CAEivzxfso6dJCB31MsrCkMg4DXBszY9QxQKsX-x0oMoaUQz5Fg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:58=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
>
> On Wed, May 10, 2023 at 2:41=E2=80=AFPM Aleksandr Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > On Wed, May 10, 2023 at 11:31=E2=80=AFPM Stanislav Fomichev <sdf@google=
.com> wrote:
> > >
> > > On Wed, May 10, 2023 at 8:23=E2=80=AFAM Alexander Mikhalitsyn
> > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > >
> > > > We have per struct proto ->bpf_bypass_getsockopt callback
> > > > to filter out bpf socket cgroup getsockopt hook from being called.
> > > >
> > > > It seems worthwhile to add analogical helper for SOL_SOCKET
> > > > level socket options. First user will be SO_PEERPIDFD.
> > > >
> > > > This patch was born as a result of discussion around a new SCM_PIDF=
D interface:
> > > > https://lore.kernel.org/all/20230413133355.350571-3-aleksandr.mikha=
litsyn@canonical.com/
> > > >
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: Stanislav Fomichev <sdf@google.com>
> > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > Cc: Eric Dumazet <edumazet@google.com>
> > > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > > Cc: Paolo Abeni <pabeni@redhat.com>
> > > > Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: netdev@vger.kernel.org
> > > > Cc: bpf@vger.kernel.org
> > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonic=
al.com>
> > > > ---
> > > >  include/linux/bpf-cgroup.h | 8 +++++---
> > > >  include/net/sock.h         | 1 +
> > > >  net/core/sock.c            | 5 +++++
> > > >  3 files changed, 11 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.=
h
> > > > index 57e9e109257e..97d8a49b35bf 100644
> > > > --- a/include/linux/bpf-cgroup.h
> > > > +++ b/include/linux/bpf-cgroup.h
> > > > @@ -387,10 +387,12 @@ static inline bool cgroup_bpf_sock_enabled(st=
ruct sock *sk,
> > > >         int __ret =3D retval;                                      =
              \
> > > >         if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT) &&               =
            \
> > > >             cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))      =
            \
> > > > -               if (!(sock)->sk_prot->bpf_bypass_getsockopt ||     =
            \
> > > > -                   !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypa=
ss_getsockopt, \
> > > > +               if (((level !=3D SOL_SOCKET) ||                    =
              \
> > > > +                    !sock_bpf_bypass_getsockopt(level, optname)) &=
&           \
> > > > +                   (!(sock)->sk_prot->bpf_bypass_getsockopt ||    =
            \
> > >
> > > Any reason we are not putting this into bpf_bypass_getsockopt for
> > > af_unix struct proto? SO_PEERPIDFD seems relevant only for af_unix?
> >
> > Yes, that should work perfectly well. The reason why I'm going this
> > way is that we are
> > declaring all SOL_SOCKET-level options in the net/core/sock.c which is
> > not specific to any address family.
> > It seems reasonable to have a way to filter out getsockopt for these
> > options too.
> >
> > But I'm not insisting on that way.
>
> Yeah, let's move it into af_unix struct proto for now. That should
> avoid adding extra conditionals for a few places that care about
> performance (tcp zerocopy fastpath).
> If we'd ever need to filter out generic SOL_SOCKET level options that
> apply for all sockets, we might put (and copy-paste) them in the
> respective {tcp,udp,unix,etc}_bpf_bypass_getsockopt.

Will do.

Thanks!

Kind regards,
Alex

>
> > Kind regards,
> > Alex
> >
> > >
> > > > +                    !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_byp=
ass_getsockopt, \
> > > >                                         tcp_bpf_bypass_getsockopt, =
            \
> > > > -                                       level, optname))           =
            \
> > > > +                                       level, optname)))          =
            \
> > > >                         __ret =3D __cgroup_bpf_run_filter_getsockop=
t(            \
> > > >                                 sock, level, optname, optval, optle=
n,          \
> > > >                                 max_optlen, retval);               =
            \
> > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > index 8b7ed7167243..530d6d22f42d 100644
> > > > --- a/include/net/sock.h
> > > > +++ b/include/net/sock.h
> > > > @@ -1847,6 +1847,7 @@ int sk_getsockopt(struct sock *sk, int level,=
 int optname,
> > > >                   sockptr_t optval, sockptr_t optlen);
> > > >  int sock_getsockopt(struct socket *sock, int level, int op,
> > > >                     char __user *optval, int __user *optlen);
> > > > +bool sock_bpf_bypass_getsockopt(int level, int optname);
> > > >  int sock_gettstamp(struct socket *sock, void __user *userstamp,
> > > >                    bool timeval, bool time32);
> > > >  struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned lon=
g header_len,
> > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > index 5440e67bcfe3..194a423eb6e5 100644
> > > > --- a/net/core/sock.c
> > > > +++ b/net/core/sock.c
> > > > @@ -1963,6 +1963,11 @@ int sock_getsockopt(struct socket *sock, int=
 level, int optname,
> > > >                              USER_SOCKPTR(optlen));
> > > >  }
> > > >
> > > > +bool sock_bpf_bypass_getsockopt(int level, int optname)
> > > > +{
> > > > +       return false;
> > > > +}
> > > > +
> > > >  /*
> > > >   * Initialize an sk_lock.
> > > >   *
> > > > --
> > > > 2.34.1
> > > >
