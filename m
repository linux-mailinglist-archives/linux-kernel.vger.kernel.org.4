Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCB1712AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbjEZQr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbjEZQrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:47:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9275FD9
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:47:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f606e111d3so525e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685119669; x=1687711669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgH2Cdrwxvw4IfwvJTzYeY7KIodASo/zB54J71C8SXg=;
        b=kFmq4/Ubiomw+bSsqMt5jQCtPHuEgbhKdix+7oMl8jygp6e/xbdU1rHaWGp6XxzdFZ
         eJyu4fpze/watbsoKe0EVFrHthAqk+FzLOywBlLBCK0ha9s7esYXtkSb36CewsJlO/gH
         U0V2hQ26/1rnlmQp/Y86IHBxkv55Op0K74qXQ3beUTDGGF9NiS68oRIOvg24+kjl6mZU
         pVXo53O392GyUDGU2GL+ZLpQ/z0IPKATdTRrt8M9ErhzbA2K57x2ioir4gm9fojNd1iQ
         CedzWO/QzZNftE2cgMKMstgBGdQ3c0e4fBxqdD4kFobF30kjuBI9SUBRsZE9B/utpJlH
         bt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685119669; x=1687711669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgH2Cdrwxvw4IfwvJTzYeY7KIodASo/zB54J71C8SXg=;
        b=gK6Im7gedLIVg5PRgCnhVS6ioFaLdlvVhYSyTbOcoOPdAGYmqCV7hFkw9NJdLUVYCQ
         nF9Ch10hqx9eVc9+ajqMrNR2L1bEBodywaYMSO7y0BUd+MYV+l1U71YviQmApkPsGsmn
         tUUqcUQaHPuwdqh5okN11TQ2TWYOYK8wqTUdBj1IDwiP81R29/5kq3w8qFUDDyq8m+OJ
         7Z2+Gfe8FIWIFzYOr3i9tDFFOE9dzzIExqIu/BEPn74cjdi8WGeJJhyoVR9ShGKZd+pi
         pD8G62+FSGu9fUnNb34QDNDX0nJOhwJTz2kQKtc/f2p5qHXhF/WVEDILyAwoa634TSKq
         bZVg==
X-Gm-Message-State: AC+VfDw45xdsrmREQCbDWuiD7obueXDayXIn+pNi2DYiIUWHFRsZpXuE
        6gw0R6ktUcjv694UO42b6+ITwJ5LW8A8pzbq5n6Vew==
X-Google-Smtp-Source: ACHHUZ7/0H65ZD/H44M1y+JBCNzkWKJ3dgQZ+8Lbr2uPV0C4C5HK5fM5ucCTSf8USInqYp++NXhtlDOSXY2HHA4TS2g=
X-Received: by 2002:a05:600c:539b:b0:3f4:df95:17e0 with SMTP id
 hg27-20020a05600c539b00b003f4df9517e0mr118254wmb.5.1685119668896; Fri, 26 May
 2023 09:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230526150806.1457828-1-VEfanov@ispras.ru> <27614af23cd7ae4433b909194062c553a6ae16ac.camel@redhat.com>
 <027d28a0-b31b-ab42-9eb6-2826c04c9364@ispras.ru> <CANn89iLGOVwW-KHBuJ94E+QoVARWw5EBKyfh0mPkOT+5ws31Fw@mail.gmail.com>
 <d3fccbd0-c92e-9aff-8c32-48c1171746c3@ispras.ru>
In-Reply-To: <d3fccbd0-c92e-9aff-8c32-48c1171746c3@ispras.ru>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 May 2023 18:47:36 +0200
Message-ID: <CANn89i+UYRXD16epov9x7+Zr5vCKL+DTCidsOaQdMBjWMmK8CA@mail.gmail.com>
Subject: Re: [PATCH] udp6: Fix race condition in udp6_sendmsg & connect
To:     Vlad Efanov <vefanov@ispras.ru>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
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

On Fri, May 26, 2023 at 6:41=E2=80=AFPM Vlad Efanov <vefanov@ispras.ru> wro=
te:
>
> sk_dst_set() is called by sk_setup_caps().
>
> sk_dst_set() replaces dst in socket using xchg() call and we still have
> two tasks use one socket but expect different dst in sk_dst_cache.
>
>
> __sk_dst_set() is rcu protected, but it checks for socket lock.
>
>
> static inline void
> __sk_dst_set(struct sock *sk, struct dst_entry *dst)
> {
>      struct dst_entry *old_dst;
>
>      sk_tx_queue_clear(sk);
>      sk->sk_dst_pending_confirm =3D 0;
>      old_dst =3D rcu_dereference_protected(sk->sk_dst_cache,
>                          lockdep_sock_is_held(sk));
>      rcu_assign_pointer(sk->sk_dst_cache, dst);
>      dst_release(old_dst);
> }

I am quite familiar with this code.

What are you trying to say exactly ?

Please come with a V2 without grabbing the socket lock.
