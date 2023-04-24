Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC2F6ECB68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjDXLex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjDXLev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:34:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154BE3A9A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:34:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94f1a6e66c9so767018666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682336088; x=1684928088;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rnBwe/xxNXcbECdM+6fJE9BhNtlcNCnbsvJvDgaRMPg=;
        b=BE5+DhasXIgwzV9/rUrifzuMR0XeXCkkrMc4T03NejVwBELCf/Zn7cyY1iBqowTg/C
         fZUYqwJmkJWet0A9axenACl9YZyrVpnNvTDjZOagwjW1cdi7XjbKMGIA89hwgwrka5Qr
         +nDivC9jAjCJ5abUWytc8A+5SS0Kx06CWtvhKXoNVD3TPhP9cGoQ3NkG/ZqkK0Rqayxo
         +c13R2Ux9+sFZqflpFP5Rn2cPwX8qq7kxhCnm3nIzc+Em7DoJX+GGodqE7vl1nA8/mNE
         dhI26ESOcfLUIaQWl1k0qP9LleVoAEbHrRiDX+uKhSGf/Uj8fxDdj0c/n3ZyRVjGoWz8
         wiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682336088; x=1684928088;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnBwe/xxNXcbECdM+6fJE9BhNtlcNCnbsvJvDgaRMPg=;
        b=AXM+GWioWwdN1ZOqY7yIOxrBK2QyDgMdVlrMadN2Rjpmux2+xW8vlUKj8Uo4n4OsiG
         xuI4Dmsene5Wp/WbuAwTJyVj1+lG1fKTY2Le7roZPHWX23u4MwYg5hDk3iHlqSTLtNrK
         mpfxxD0OwNRPuni5wHk0BuwWJRXYTxNruvzQU3ZDcnrkMmmCX39b5+Whfm/aMAWZ8vO4
         X4ZxoYWLSCv2yKO6vyDM7SHJPPzCoFxpX3qdhbv51Hl+tCrH23+8B4ib0WLwX6BYkADy
         i9ogaSnfK78w88Z7UOzx/ms5U5oDiz4SopOAr/WkcPYdtFqcK3FtoN70bzssDI8VwMw+
         7XUw==
X-Gm-Message-State: AAQBX9cyEsED0/U9VaDNk59ElZDlhXFPF4cATlzf6gAvVbdsvhGYNJnd
        myg1FEsKJzWoIuBMzw/1bKo=
X-Google-Smtp-Source: AKy350brAySoHRwodleIfHAAvUTJBtwdizt9p/uA3TovQvM+vKRzlVPKQocK+NpWi5IhWhLoVW6eFQ==
X-Received: by 2002:a17:906:c201:b0:953:3736:3b8f with SMTP id d1-20020a170906c20100b0095337363b8fmr9805620ejz.64.1682336088247;
        Mon, 24 Apr 2023 04:34:48 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id y21-20020a17090614d500b0094b87711c9fsm5442879ejc.99.2023.04.24.04.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 04:34:47 -0700 (PDT)
Message-ID: <2e0268d352731a188a8302892bb9a404616dcf4a.camel@gmail.com>
Subject: Re: [PATCH 02/43] soc: Add SoC driver for Cirrus ep93xx
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Conor Dooley <conor.dooley@microchip.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Walker Chen <walker.chen@starfivetech.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sven Peter <sven@svenpeter.dev>,
        Brian Norris <briannorris@chromium.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Apr 2023 13:34:46 +0200
In-Reply-To: <20230424123522.18302-3-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230424123522.18302-3-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-04-24 at 15:34 +0300, Nikita Shubin wrote:
> This adds an SoC driver for the ep93xx. Currently there
> is only one thing not fitting into any other framework,
> and that is the swlock setting.
>=20
> It's used for clock settings and restart.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>=20
> Notes:
> =C2=A0=C2=A0=C2=A0 rfc -> v0
> =C2=A0=C2=A0=C2=A0 Alexander Sverdlin:
> =C2=A0=C2=A0=C2=A0 - replace spinlock with local_irq
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Arnd Bergmann:
> =C2=A0=C2=A0=C2=A0 - wildcards changed to ep9301
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Linus Walleij:
> =C2=A0=C2=A0=C2=A0 - added tag, i hope changes are not significant enough=
 to drop
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Reviewed-by tag
>=20
> =C2=A0drivers/soc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/soc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/soc/cirrus/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 11 +++
> =C2=A0drivers/soc/cirrus/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 2 +
> =C2=A0drivers/soc/cirrus/soc-ep93xx.c=C2=A0=C2=A0 | 134 +++++++++++++++++=
+++++++++++++
> =C2=A0include/linux/soc/cirrus/ep93xx.h |=C2=A0 16 +++-
> =C2=A06 files changed, 161 insertions(+), 4 deletions(-)
> =C2=A0create mode 100644 drivers/soc/cirrus/Kconfig
> =C2=A0create mode 100644 drivers/soc/cirrus/Makefile
> =C2=A0create mode 100644 drivers/soc/cirrus/soc-ep93xx.c

--=20
Alexander Sverdlin.

