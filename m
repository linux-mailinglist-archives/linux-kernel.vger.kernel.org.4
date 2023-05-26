Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7769712AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjEZQqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbjEZQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:46:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729A8125
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:46:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f5dbd8f677so325e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685119577; x=1687711577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQypiCBwLug/0iNSH44aWt+z5fa/mlixwMi4GartHM0=;
        b=Gl+ikmk2cb05CjmCFREepzfL7BWw54b7H+Ki+DPwzP0esDIW+1wgi9TpO63y9oRMB0
         nh5s+qCsdOX+FDsPf901C0+qjRnScLo7OaTt5B0G9eneJ/gkWJMtsBBz3NWgDASdcD4c
         u7M3hoaZfNn5gHEt+UeS5zPFg0NjUkNJOVGn9XmwPuqoUttyizJQjXeBynCG/z0E/1+8
         IyvyilgyWsK3UPx7JjnTizNwPQAtyiDpqI1LL9Es9PFIKVlj8Ots/OqHWePWnc3cUWPT
         fu++w0sTarD1t3FIgbVcFUCLV7hFxkqcxufAU7bwKPcFjNvUzP2OKemzXBkgO6znv9v9
         ugFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685119577; x=1687711577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQypiCBwLug/0iNSH44aWt+z5fa/mlixwMi4GartHM0=;
        b=DPV/wr9zASL1ORXT5IY+bbFcm1ljrY1V+eHScg8SQu0FTkheVXQia74dYDXFnOVPNY
         Etn1pEUg21NydhrEd/+hqmq2pN43KWdPTdAhdQNRIE5XjjiH2ht+X7ZzhbFEquTXxacs
         Q/4HWfypeExK0ZDHo7Tr6T2yeJ7oUMlxqnWtq4m1f9ccJ/wmtCgvW/TkwAX2G4JE6cL9
         3d08rrOflfafKyr9Vcl2wgaKWdMESaedyjCGsMZruuUzIUOl1+yQr1Kjx9HqsP65uh/c
         oTPO850c1vYixJKCPZ7BSyUfot3llfNaZLkOQ0JY3s/WF0mhkx4cM5dEjtqaZRe5Aap7
         pJeQ==
X-Gm-Message-State: AC+VfDxn3EeiElpvq/GIMJOiEErzq+6Pl4XHv1aFmPORZgyt8f8DcYRG
        gNqUiNOsoN6/kg3gHgD6CzMMGBVHcKDOl5ktvfJfRg==
X-Google-Smtp-Source: ACHHUZ5Wz/wSuq/oW49oQmUQ7iTkDQCBshFiL2NwSFmUI/iPX+jRlImuRkfcFaF5AjXhiuSBhWKpoGKSzLUrvZ8mF0Q=
X-Received: by 2002:a05:600c:3c93:b0:3f4:2594:118a with SMTP id
 bg19-20020a05600c3c9300b003f42594118amr134216wmb.2.1685119576702; Fri, 26 May
 2023 09:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230526150806.1457828-1-VEfanov@ispras.ru> <CANn89i+p7_UB8Z5FQ+iWg4G_caAnUf9W4P-t+VOzigUuJo+qRw@mail.gmail.com>
 <c63e08fc-7abf-24fb-fc1e-9ecf36618aa6@ispras.ru>
In-Reply-To: <c63e08fc-7abf-24fb-fc1e-9ecf36618aa6@ispras.ru>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 May 2023 18:46:04 +0200
Message-ID: <CANn89iJkOOcombRniD7PP4KY=5Z6tx5QMQ-M24KS_AZ0h4nAcg@mail.gmail.com>
Subject: Re: [PATCH] udp6: Fix race condition in udp6_sendmsg & connect
To:     Vlad Efanov <vefanov@ispras.ru>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
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

On Fri, May 26, 2023 at 6:09=E2=80=AFPM Vlad Efanov <vefanov@ispras.ru> wro=
te:
>
> Eric,
>
>
> udp6_sendmsg() currently still locks the socket (on line 1595).
>

Not really, look more closely at lines 1580 -> 1594


>
> Best regards,
>
> Vlad.
>
>
> On 26.05.2023 18:29, Eric Dumazet wrote:
> > On Fri, May 26, 2023 at 5:08=E2=80=AFPM Vladislav Efanov <VEfanov@ispra=
s.ru> wrote:
> >> Syzkaller got the following report:
> >> BUG: KASAN: use-after-free in sk_setup_caps+0x621/0x690 net/core/sock.=
c:2018
> >> Read of size 8 at addr ffff888027f82780 by task syz-executor276/3255
> > Please include a full report.
> >
> >> The function sk_setup_caps (called by ip6_sk_dst_store_flow->
> >> ip6_dst_store) referenced already freed memory as this memory was
> >> freed by parallel task in udpv6_sendmsg->ip6_sk_dst_lookup_flow->
> >> sk_dst_check.
> >>
> >>            task1 (connect)              task2 (udp6_sendmsg)
> >>          sk_setup_caps->sk_dst_set |
> >>                                    |  sk_dst_check->
> >>                                    |      sk_dst_set
> >>                                    |      dst_release
> >>          sk_setup_caps references  |
> >>          to already freed dst_entry|
> >
> >> The reason for this race condition is: udp6_sendmsg() calls
> >> ip6_sk_dst_lookup() without lock for sock structure and tries to
> >> allocate/add dst_entry structure to sock structure in parallel with
> >> "connect" task.
> >>
> >> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
> >>
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > This is a bogus Fixes: tag
> >
> > In old times, UDP sendmsg() was using the socket lock.
> >
> > Then, in linux-4.0 Vlad Yasevich made UDP v6 sendmsg() lockless (and
> > racy in many points)
> >
> >
> >> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
> >> ---
> >>   net/ipv6/udp.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> >> index e5a337e6b970..a5ecd5d93b0a 100644
> >> --- a/net/ipv6/udp.c
> >> +++ b/net/ipv6/udp.c
> >> @@ -1563,12 +1563,15 @@ int udpv6_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
> >>
> >>          fl6->flowlabel =3D ip6_make_flowinfo(ipc6.tclass, fl6->flowla=
bel);
> >>
> >> +       lock_sock(sk);
> >>          dst =3D ip6_sk_dst_lookup_flow(sk, fl6, final_p, connected);
> >>          if (IS_ERR(dst)) {
> >>                  err =3D PTR_ERR(dst);
> >>                  dst =3D NULL;
> >> +               release_sock(sk);
> >>                  goto out;
> >>          }
> >> +       release_sock(sk);
> >>
> >>          if (ipc6.hlimit < 0)
> >>                  ipc6.hlimit =3D ip6_sk_dst_hoplimit(np, fl6, dst);
> >> --
> >> 2.34.1
> >>
> > There must be another way really.
> > You just killed UDP performance.
