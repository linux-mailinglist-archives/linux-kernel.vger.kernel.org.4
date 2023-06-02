Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CD471FAF3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjFBH1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjFBH1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:27:19 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E66B128
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:27:18 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-568a1011488so18219097b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 00:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685690837; x=1688282837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iKrlwDoHpe9gRi661od6BlAYjq4eVKNFoJJmd4gjjg=;
        b=DXv6Bz2K+iTxmhrVVgRWeYD001IAxxIlBIJFqn0/Roz5mgayh481V94B02RQ8E1gge
         tnUi6MtwSJOtYyWP9GUpoXzWngnMEXtqw8VWh8WXksCgc/ewiowsIGqDKz4B/KWD69Fs
         kShaW4Ydzj6uLYR65wsHA1+VDpLWHUSIlOSeNio9njhthyD1yK7Rt3GLsxdTmEdopMq9
         aU2vuf6soagLbuBcyJp/Dc2KiUyPklr9NOG9kHrjbt5dUoZ6zEQCWqwVx5wkDeDApJIq
         DR+Xh0J/gzp0YWFOPk0Hs4rm4BT6bp+7ZruSabE5OLzgPKy1YwUc9/Jy/Y6Wq0KLqEpq
         YsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685690837; x=1688282837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iKrlwDoHpe9gRi661od6BlAYjq4eVKNFoJJmd4gjjg=;
        b=RG2k6cPiqDuKu31fY+mOZs0v15pc0rgisFauZTfuWNqaEScWxPSgSrcCVzEbovE7l3
         kEY9QweXOU3W8uQdkvbrTFUg+UwUqJPJPOp4LABRjz0pnJ0eySzYT2LtD3QRpuWb5zZQ
         n0tSlcM+9DWWaT/epMZ0d0o8WagLADJVvQDGjhd2GzpE8OIkOSLhe5q95378gBKvc8Yy
         WzUPa07QkIbUBZpZUq1LkT64y6m4gJDoanTA4xn6BkwkruMj382bQpR2l7JWT2gfgRtN
         A1ZBsD0mwtff9k7Iu6ukOP4WBbJAXSxw7YtNM7fDZqXUj3gnucC9NPiaN3rRh0jSoWT+
         zXAg==
X-Gm-Message-State: AC+VfDx82oFBXzFyicybfUwiHabcuj9c2cZzdyjg8czWUIniXu//8tl1
        Yt0ElC4vf+6CdQCVtpodOrSdUNgzVkkFmlgXM5yf3Q==
X-Google-Smtp-Source: ACHHUZ5NEpY+OKVNq/RYBBHyUzUo0UwSgMvKCroP0Pf7nDQZt2Walm3Nsa9jSpnuykrAT20vk31ZaapaPjB/RR/M8x4=
X-Received: by 2002:a0d:d843:0:b0:561:e724:eb3 with SMTP id
 a64-20020a0dd843000000b00561e7240eb3mr11111373ywe.17.1685690837614; Fri, 02
 Jun 2023 00:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230424123522.18302-1-nikita.shubin@maquefel.me> <20230601054549.10843-2-nikita.shubin@maquefel.me>
In-Reply-To: <20230601054549.10843-2-nikita.shubin@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 2 Jun 2023 09:27:06 +0200
Message-ID: <CACRpkdY6VzYfGPUHed6rmNx8KbzWgVsz=G7wwCx1MkZ5pBxLaA@mail.gmail.com>
Subject: Re: [PATCH v1 20/43] net: cirrus: add DT support for Cirrus EP93xx
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 7:45=E2=80=AFAM Nikita Shubin <nikita.shubin@maquefe=
l.me> wrote:

> - find register range from the device tree
> - get "copy_addr" from the device tree
> - get phy_id from the device tree
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Looking really good.

Yours,
Linus Walleij
