Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEB4736696
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjFTIqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjFTIqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:46:32 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4639EE7E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:46:31 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3ff242aae7aso302261cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687250790; x=1689842790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpMN46255pLt0PRsCdWTS+xfZSx8+DsL9WPhOXxZ9yk=;
        b=PUqQz1EyhdM75s0SWzyaBzQzX0HnVw8z2tsr6Op5/cN/cUW4/9lVAm4tjUratYJjg6
         SAa1qHvWrjcDlnMecddAd8WdeBu5dKN6auGzZvp0P3LIZh1iETIFzdrWTUvD2wJE77qs
         2mLe8avFtMO/Ojubc766CY+rkfUD6VLkkeJ2sAPs9vMP+Iwa80zNJWBCR80BFGoGUkhi
         Fel8EfzQOxpGz9H+TJM8B0dV0ED1LULnMJPqQjmOoK+IbKR6NSdoy6B1QGfJ8QBASrbb
         VSrGJh6JuDJhShsGdLPxvy8QD+vwPBIL/1kPhfa45ywAyoSQiWFdkEBIbwP21rucqh1B
         nmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687250790; x=1689842790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpMN46255pLt0PRsCdWTS+xfZSx8+DsL9WPhOXxZ9yk=;
        b=AmeB5XET1JfuR1SEiof6ODhujBrylvvCvTAtYq0yW8o1AlN6zjkidm3hLfio2pilQW
         zmaLRz9znklpPXKqiHWxR907y7mMwyWmTTJbXppXeHROlEvYcwKKKOfv1MvpwzAQK1B5
         GEz3UDTpVEdeXA+vVy2cJE2jtVAzEFIrT6Mw426l+EA/vXEBw3rWqyLaWfw62gZQpfbw
         LNCx+66HCCSx/wIXrP12lMWQXZegHKuEpN2G3KxlI/R4mBtYNCyuY/7NY1dcNxiG4mko
         Kv6CE+ASPq2dydkClAD+2ci9NTzu8w7Q/48pQAEx6FdFyILJlwXHDujnYHel47ALzK1+
         3sBA==
X-Gm-Message-State: AC+VfDx2j/ZmRGB/ufbforpRauh0B0ReVTK4FVuipBEcXVzcxI/TBAqu
        +H4ZEpuqXmmzbKCi0nocMYtBrUM+u/tNAvG97C7YDQ==
X-Google-Smtp-Source: ACHHUZ7c7mEXwzWWmZ4Mt+o83/SYAZ8LwUtMYoMBccyXZedPSaPV4i/RlxgZcYvPYMXK14Xt5u73mUccGJ/IHDfsjYE=
X-Received: by 2002:ac8:5c4d:0:b0:3f9:ab2c:88b9 with SMTP id
 j13-20020ac85c4d000000b003f9ab2c88b9mr1096161qtj.25.1687250790235; Tue, 20
 Jun 2023 01:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230619082547.73929-1-wuyun.abel@bytedance.com>
 <CANn89i+deprQWB0dmsUD1sRmy1VQCQwKnZUkLu_AEGV=ow=PKQ@mail.gmail.com> <6ed78c81-c1ac-dba4-059c-12f6b2bb9c53@bytedance.com>
In-Reply-To: <6ed78c81-c1ac-dba4-059c-12f6b2bb9c53@bytedance.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 20 Jun 2023 10:46:19 +0200
Message-ID: <CANn89iK4hme4XmUyZVjTXMZYqAm8w+9tbwnrtHyJ3N28cAFYTw@mail.gmail.com>
Subject: Re: Re: [PATCH net-next] inet: Save one atomic op if no memcg to charge
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

On Tue, Jun 20, 2023 at 5:04=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> On 6/19/23 6:08 PM, Eric Dumazet wrote:
> > On Mon, Jun 19, 2023 at 10:26=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.=
com> wrote:
> >>
> >> If there is no net-memcg associated with the sock, don't bother
> >> calculating its memory usage for charge.
> >>
> >> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> >> ---
> >>   net/ipv4/inet_connection_sock.c | 18 +++++++++++-------
> >>   1 file changed, 11 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connectio=
n_sock.c
> >> index 65ad4251f6fd..73798282c1ef 100644
> >> --- a/net/ipv4/inet_connection_sock.c
> >> +++ b/net/ipv4/inet_connection_sock.c
> >> @@ -706,20 +706,24 @@ struct sock *inet_csk_accept(struct sock *sk, in=
t flags, int *err, bool kern)
> >>   out:
> >>          release_sock(sk);
> >>          if (newsk && mem_cgroup_sockets_enabled) {
> >> -               int amt;
> >> +               int amt =3D 0;
> >>
> >>                  /* atomically get the memory usage, set and charge th=
e
> >>                   * newsk->sk_memcg.
> >>                   */
> >>                  lock_sock(newsk);
> >>
> >> -               /* The socket has not been accepted yet, no need to lo=
ok at
> >> -                * newsk->sk_wmem_queued.
> >> -                */
> >> -               amt =3D sk_mem_pages(newsk->sk_forward_alloc +
> >> -                                  atomic_read(&newsk->sk_rmem_alloc))=
;
> >>                  mem_cgroup_sk_alloc(newsk);
> >> -               if (newsk->sk_memcg && amt)
> >> +               if (newsk->sk_memcg) {
> >> +                       /* The socket has not been accepted yet, no ne=
ed
> >> +                        * to look at newsk->sk_wmem_queued.
> >> +                        */
> >> +                       amt =3D sk_mem_pages(newsk->sk_forward_alloc +
> >> +                                          atomic_read(&newsk->sk_rmem=
_alloc));
> >> +
> >> +               }
> >> +
> >> +               if (amt)
> >>                          mem_cgroup_charge_skmem(newsk->sk_memcg, amt,
> >>                                                  GFP_KERNEL | __GFP_NO=
FAIL);
> >
> > This looks correct, but claiming reading an atomic_t is an 'atomic op'
> > is a bit exaggerated.
>
> Yeah, shall I change subject to 'inet: Skip usage calculation if no
> memcg to charge'? Or do you have any suggestions?

I would call this a cleanup or refactoring, maybe...
