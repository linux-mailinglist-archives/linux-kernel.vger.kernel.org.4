Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ED472457D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbjFFOP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjFFOP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:15:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84483A6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:15:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-514ad92d1e3so6619a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686060923; x=1688652923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLyWS7SWDOyM7foxXo03DIfgZrJGdKALWcjxSFuqPSI=;
        b=1cfXwlvFLwgvPEeXmsASNwRbD653BTsqwYQ1LcNEPTT4BXneAbe3wpottMa1T+McCm
         /0VySIIR7jmqr0XHfHmiXeYY7OVPAN1fXRLBV3VC3OkeHg+Qr/KHJJDvjJTkP+TZpKfu
         EOCz5fMHtU0fbAozamIsIJK3zAdmWUBVeh2pyu5HAqSdCM1d9PZgTaB2QpTIyGHIeZXr
         OTVQr+UpEAuuVVm8mmDP8x6xj45nMc4cCaYV5IrRaJ7PKEBQaHYr4vajfGhIKhXyBXtn
         Mf76PocRSBEBPgvTbRjIbl1RK/Q71kxbWeGtXy7AUKYXgNu8Wj5YgY1Ml2avpsuX9dSg
         C2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686060923; x=1688652923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLyWS7SWDOyM7foxXo03DIfgZrJGdKALWcjxSFuqPSI=;
        b=Q0gn8laK/8KMe4ENYVOSQCtiI2Af624WSbXhVr/1QVfqUoT0C+cjQEvIkiOT5TvmvV
         JsJxuyk/GzJr9FO7sp7Zpych7xCnEf45gqypYdYUjnCaBalbw0hmAo4ESJE2d5DFEi8J
         F5gEEqN0ApAIdij/FjwZpwmfKFfij+vL86cJ1unHne8YyW4oYtdpm9xxWBziuQJJoqXv
         b6SVOwzwsbDH+gBVIo99YykRnW2X8AfYouYjnmMFMdoxdoy2fwi4jliZ3N4i/O5XY7Ft
         mjqPG+/abF2v5VEiJ2qwpaHo+4DXSWGgLqI4gpC852KhevZcA9+Z8VN7/ul+1tSqMseo
         Zf0w==
X-Gm-Message-State: AC+VfDxbUQdy3hzf3TLYZu9a3sNviaIrZwOnSbqJyj1u2Na5vhl5qV7a
        4F/zyjr6Wf6rv6vDEc3nozFsQWoI2VYifpxPS6PWc+zbUxsoWG8hTDYLEg==
X-Google-Smtp-Source: ACHHUZ68AhSKzPq8oXoEUT1tuXri7wnaVhz47pC1frMiObKMMqCIEmjZaT2DD/yWdmVRtuXH14kOqx9aeXEnylwgS9c=
X-Received: by 2002:a50:c05b:0:b0:50b:f6ce:2f3d with SMTP id
 u27-20020a50c05b000000b0050bf6ce2f3dmr160246edd.0.1686060923361; Tue, 06 Jun
 2023 07:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230606140041.3244713-1-ptf@google.com>
In-Reply-To: <20230606140041.3244713-1-ptf@google.com>
From:   Patrick Thompson <ptf@google.com>
Date:   Tue, 6 Jun 2023 10:15:12 -0400
Message-ID: <CAJs+hrHAz17Kvr=9e2FR+R=qZK1TyhpMyHKzSKO9k8fidHhTsA@mail.gmail.com>
Subject: Re: [PATCH] r8169: Disable multicast filter for RTL_GIGA_MAC_VER_46
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        nic_swsd@realtek.com
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

For added context I came across this issue on this realtek adapter:
10ec:8168:103c:8267. The device erroneously filters multicast packets
that I can see with other adapters using the same netdev settings.


On Tue, Jun 6, 2023 at 10:00=E2=80=AFAM Patrick Thompson <ptf@google.com> w=
rote:
>
> MAC_VER_46 ethernet adapters fail to detect IPv6 multicast packets
> unless allmulti is enabled. Add exception for VER_46 in the same way
> VER_35 has an exception.
>
> Signed-off-by: Patrick Thompson <ptf@google.com>
> ---
>
>  drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
> index 4b19803a7dd01..96245e96ee507 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2583,7 +2583,8 @@ static void rtl_set_rx_mode(struct net_device *dev)
>                 rx_mode |=3D AcceptAllPhys;
>         } else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
>                    dev->flags & IFF_ALLMULTI ||
> -                  tp->mac_version =3D=3D RTL_GIGA_MAC_VER_35) {
> +                  tp->mac_version =3D=3D RTL_GIGA_MAC_VER_35 ||
> +                  tp->mac_version =3D=3D RTL_GIGA_MAC_VER_46) {
>                 /* accept all multicasts */
>         } else if (netdev_mc_empty(dev)) {
>                 rx_mode &=3D ~AcceptMulticast;
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>
