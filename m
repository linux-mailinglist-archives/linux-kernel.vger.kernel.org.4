Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E463071297F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243803AbjEZP37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244148AbjEZP34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:29:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EF510A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:29:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f5dbd8f677so58015e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685114992; x=1687706992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11kvH2/w8+/j27zICJ7H+elZ2FOLnEq/iHQYQEgeVyU=;
        b=Xk/GvjBDVdqc+7jqhKEG3aIsPCmQ+0jViFDIaERZ7pysnS+oInnRks/1a2hNnsPX0e
         LpqZi+qhKBPgBAMNCNf3qVeY1UnEj8OPYwqsI4YALxpXPbJQ8jISsH47Yf36HyH8eNXi
         7PnSrcKGSlk7VyyGLQkCkz5QFeHRYlU4PoLk7S4yNBmvGO7JuITjeNZxf9Dsvyhk6zCb
         t6JipA3vXrgfF5ugk4gUIPKGhyNQ3xWLiLGlROuVAKH6NsfKQhHtWfYHdtsY+tDoF2BT
         Mle7Z0+er7X78IRUr9LHj8rO/OwYfxBhvl1qx4eZ1/agCnwVcfkOPxqduq9rmP0sHR9+
         kVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685114992; x=1687706992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11kvH2/w8+/j27zICJ7H+elZ2FOLnEq/iHQYQEgeVyU=;
        b=XNGZKf0UBHGaREcAQ9VlqKLNEWDzpp1WmOJhswgRFZfTWjQRwX17rkJ49cVWEVcXv0
         NrEF8PbSUTtw2yT6PqFHwS0/i5fR3tWIOr2q8+V5Qal9RYrK3vLSvP3TrKGhILEq4Zpi
         rTSLQyPr3xFAJQBmTEaO0MSKSykeIIsj/REcYuj+318sCvRgVhL0rJBIEbt+Yu/U/0M6
         PyuKzFSlZwdzmZLhvVkTBubGHA3VjIhY0KTgx7yvzBfspi3h0v+3xlGn4m7q+U3Yu0+C
         RlJiBI4KrkAYqIJ0PFhqDPyrPB8f4yhYVnpdOTw4vkXtuEhHuCc1TNun5f+PbY7GGp0A
         Z3CA==
X-Gm-Message-State: AC+VfDyeGM83ZY6g9RWWI+AC1+gfLbRi/P6FLA0I8ZoKaZATd/OEYxrG
        Xqq2ARpuWZrGRaeJiT/RoNH+ZboMgLaWBMaWNfyCAQ==
X-Google-Smtp-Source: ACHHUZ7/PW5oi1QxByQp+2dnJSmeNg5G3WW6rGN9o5Q5Y7U7JvrxNI5F50BfkNMxcYP0mt7Aq9GozHET7p34VjflXM0=
X-Received: by 2002:a05:600c:cca:b0:3f1:70d1:21a6 with SMTP id
 fk10-20020a05600c0cca00b003f170d121a6mr120145wmb.0.1685114992299; Fri, 26 May
 2023 08:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230526150806.1457828-1-VEfanov@ispras.ru>
In-Reply-To: <20230526150806.1457828-1-VEfanov@ispras.ru>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 May 2023 17:29:40 +0200
Message-ID: <CANn89i+p7_UB8Z5FQ+iWg4G_caAnUf9W4P-t+VOzigUuJo+qRw@mail.gmail.com>
Subject: Re: [PATCH] udp6: Fix race condition in udp6_sendmsg & connect
To:     Vladislav Efanov <VEfanov@ispras.ru>
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

On Fri, May 26, 2023 at 5:08=E2=80=AFPM Vladislav Efanov <VEfanov@ispras.ru=
> wrote:
>
> Syzkaller got the following report:
> BUG: KASAN: use-after-free in sk_setup_caps+0x621/0x690 net/core/sock.c:2=
018
> Read of size 8 at addr ffff888027f82780 by task syz-executor276/3255

Please include a full report.

>
> The function sk_setup_caps (called by ip6_sk_dst_store_flow->
> ip6_dst_store) referenced already freed memory as this memory was
> freed by parallel task in udpv6_sendmsg->ip6_sk_dst_lookup_flow->
> sk_dst_check.
>
>           task1 (connect)              task2 (udp6_sendmsg)
>         sk_setup_caps->sk_dst_set |
>                                   |  sk_dst_check->
>                                   |      sk_dst_set
>                                   |      dst_release
>         sk_setup_caps references  |
>         to already freed dst_entry|


>
> The reason for this race condition is: udp6_sendmsg() calls
> ip6_sk_dst_lookup() without lock for sock structure and tries to
> allocate/add dst_entry structure to sock structure in parallel with
> "connect" task.
>
> Found by Linux Verification Center (linuxtesting.org) with syzkaller.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

This is a bogus Fixes: tag

In old times, UDP sendmsg() was using the socket lock.

Then, in linux-4.0 Vlad Yasevich made UDP v6 sendmsg() lockless (and
racy in many points)


> Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
> ---
>  net/ipv6/udp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index e5a337e6b970..a5ecd5d93b0a 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -1563,12 +1563,15 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr =
*msg, size_t len)
>
>         fl6->flowlabel =3D ip6_make_flowinfo(ipc6.tclass, fl6->flowlabel)=
;
>
> +       lock_sock(sk);
>         dst =3D ip6_sk_dst_lookup_flow(sk, fl6, final_p, connected);
>         if (IS_ERR(dst)) {
>                 err =3D PTR_ERR(dst);
>                 dst =3D NULL;
> +               release_sock(sk);
>                 goto out;
>         }
> +       release_sock(sk);
>
>         if (ipc6.hlimit < 0)
>                 ipc6.hlimit =3D ip6_sk_dst_hoplimit(np, fl6, dst);
> --
> 2.34.1
>

There must be another way really.
You just killed UDP performance.
