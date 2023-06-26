Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE4F73E0A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjFZN1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjFZN1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:27:10 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B74913D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:27:09 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3459a62fd29so176375ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687786028; x=1690378028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSZHpIGj9wwkIa9hVVPRK76zK+0CMnJhqGyhyWSAmH0=;
        b=QU4ktPnXPtrQ92+3m0NNpOS4TkW9tT8cF2/6OaqIvDumeqYRw1chYYeWj+qFv3ZZic
         633YwIC/xGZ8YUufw/n14aRWQHKHl9mv8zsizHuo3QKfoOoDmXOGHcXb8b6eC1G88uT5
         R2EzLBjalpwcH5/4zbymHE2aGsJ5LYu+3bi4xERIwMYTIUK/Hr4aork0TQtEMa/cEGan
         GUjoYvLBntTEZhNhpTE5PrSHQw87xRk4mOpCg83icdiafcTfKR2eH9XxJc+Nv71hiWr3
         /cnTZkQqepl1NzAjv6ze7VVWzWiZfV+kECbHO+K6OJtLlUlCfIlOOgwXn9rKxIQzAL7J
         3RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687786028; x=1690378028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSZHpIGj9wwkIa9hVVPRK76zK+0CMnJhqGyhyWSAmH0=;
        b=k4MIZGESixQ39nhq7QtS6F8vuz53iyk656hEbakGYKt22yGDAm36wrUpPez90KaLI3
         pu7h0+3Ia/1lKp9a+Qsnswdb0X/Rdprxvl0WyPfoaUyzuHy+VvjhR70Zi8Rqm+4HyalR
         BDsWRGnmdExojFEWbSRuZy9s5ICgWc3JFqllA6PoMxC41QqWM0eVNBR5IA1YUewji8BL
         oVtuT5f0RF2G1Sckis8vptpEuvVOwTcS46s1XrLIoUAepH3rto0GIiTBbbck0gEct+bg
         od+UiCwN2h2Dvn5LnyLyhNiVsRCNkN+V6ggXrsuXh4MhLlCQIey/GFDtGzC1p54dni1L
         JJCA==
X-Gm-Message-State: AC+VfDxfmE4qa3zF6TapdAfeRWxYxMg9id2QezAqbBaddxTifSOHvrMV
        FNBTqYwtDcqDa/8CPcWEizgH6y5PI0SRIl+CnkJVUg==
X-Google-Smtp-Source: ACHHUZ7tqs35ui6sqUKq3bHPizstRYS1nwRSk/Hqeqy7U1a2le2mFRC6yXGJ+/38BAUVTwK+xygXVymA05bBPBNXUHI=
X-Received: by 2002:a05:6e02:1b09:b0:33b:5343:c1d6 with SMTP id
 i9-20020a056e021b0900b0033b5343c1d6mr346378ilv.21.1687786028373; Mon, 26 Jun
 2023 06:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230626100107.4102329-1-imagedong@tencent.com>
In-Reply-To: <20230626100107.4102329-1-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 26 Jun 2023 15:26:57 +0200
Message-ID: <CANn89iKHfAWj_e6aqWiNQJfe2LOeaX3-Grx3w0LpxoKH9i86Cg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp: support to probe tcp receiver OOM
To:     menglong8.dong@gmail.com
Cc:     ncardwell@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, dsahern@kernel.org,
        kuniyu@amazon.com, morleyd@google.com, imagedong@tencent.com,
        mfreemon@cloudflare.com, mubashirq@google.com,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Jun 26, 2023 at 12:01=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> For now, skb will be dropped directly if rmem schedule fails, which means
> tcp_try_rmem_schedule() returns an error. This can happen on following
> cases:
>
> 1. The total memory allocated for TCP protocol is up to tcp_mem[2], and
>    the receive queue of the tcp socket is not empty.
> 2. The receive buffer of the tcp socket is full, which can happen on smal=
l
>    packet cases.
>
> If the user hangs and doesn't take away the packet in the receive queue
> with recv() or read() for a long time, the sender will keep
> retransmitting until timeout, and the tcp connection will break.
>
> In order to handle such case, we introduce the tcp protocol OOM detection
> in following steps, as Neal Cardwell suggested:

net-next is closed.

I think I suggested something much simpler, and not intrusive like your pat=
ch.
(Your patch adds code in the fast path, and yet another sysctl)

If we can not queue an incoming packet because we are under memory stress,
simply send an ACK with WIN 0
