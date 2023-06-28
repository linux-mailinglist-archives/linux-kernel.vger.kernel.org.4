Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC23D741939
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjF1UEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjF1UEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:04:14 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008F62132;
        Wed, 28 Jun 2023 13:04:12 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5658573b1faso230092eaf.1;
        Wed, 28 Jun 2023 13:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687982652; x=1690574652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LShLkpq2kaVqJKc1RK3ziSqQG3OYar6M393HgmIhy/8=;
        b=Nf/hOwO44fgI+3JqQ5xwEDzpvwhyz/UvKI22RcOemapDYUN73aNR19jOZzpp5kBr8/
         +dSHso9z9TCUvzhpH2lCPAwO9SxrLfudERiUELZmeBi+zlut9sqlVkLrNeiHuYEmw2fr
         Zb1rm251xybGYVje071GAnLOmUUfq5M9pkminAP5guOQMPulJABm//oZokmrZYNsBgi7
         Lz/Kpa3Aet/hWFDVaEU1ckVv1pJYwFwcTly7GxjhZqfrA5fdKGc1gYa+fMuvWxB6W5l+
         plj39ze8CJV6jhMFbR8cJZZMOKsdZxgnqAdmD2KJqGqoxojcbF5Q72qP9Z/8WyVDw3f4
         qIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687982652; x=1690574652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LShLkpq2kaVqJKc1RK3ziSqQG3OYar6M393HgmIhy/8=;
        b=Ib99nmnCxjCraHfoPrIuM/LGtyXkENa26v0L4AY3F61B4OGzG7hfdw3+PV7EV7F22+
         /rocNRm3+xr7yEYrfG0Nf84XKFi66E0w16ZK6Kz8w9STAZLOuwMxMF+Yq/ESYRMsQE0C
         X00+QaEYk+7dRQtcKUstCMSGlc88iqFnbCp/S003iTLs1YuZni9+VepaDNEmmwuUcQdb
         Q8fAJMAX6FKGdLGT9ZBEuMXMJS5sWPm9Ejk5RPKTaxJPR4Q6tM2rZTXu/00xVni0dYQX
         XATj74eOZT4Vq4JSq+7qqdKKjIcCMsmAEfCTlP/4Ts8MI4I1B+MaKBWY6OjwK/THtSVC
         SDuA==
X-Gm-Message-State: ABy/qLaDDziq21dup/A8lH9CD+97WooO09ZjFCG14Fs1wGeujpxUcDNf
        75LxorLBV+pTJ9Rd0fJQcYa0jrgzSaFgcnLSox4=
X-Google-Smtp-Source: APBJJlHi2R8anXXdjkOvNtmXPZjlvtDN/IY4GwitUMXvKUUw+9jFBMn6gVxSeTKynpLCuuho5J6zmkcFklRGgDBnNSc=
X-Received: by 2002:a05:6359:69c:b0:134:e603:116e with SMTP id
 ei28-20020a056359069c00b00134e603116emr744826rwb.6.1687982652055; Wed, 28 Jun
 2023 13:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
 <20230625115343.1603330-7-paweldembicki@gmail.com> <20230625145445.ialdexs2wxu6lu73@skbuf>
In-Reply-To: <20230625145445.ialdexs2wxu6lu73@skbuf>
From:   =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date:   Wed, 28 Jun 2023 22:04:00 +0200
Message-ID: <CAJN1Kky+uYT198htPD7QOr249LjEXHjCZoE0JW4k8CvhpGkCqg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/7] net: dsa: vsc73xx: fix MTU configuration
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 25 cze 2023 o 16:54 Vladimir Oltean <olteanv@gmail.com> napisa=C5=
=82(a):
>
> On Sun, Jun 25, 2023 at 01:53:42PM +0200, Pawel Dembicki wrote:
> > Switch in MAXLEN register store maximum size of data frame.
> > MTU size is 18 bytes smaller than frame size.
> >
> > Current settings causes problems with packet forwarding.
> > This patch fix MTU settings to proper values.
> >
> > Fixes: fb77ffc6ec86 ("net: dsa: vsc73xx: make the MTU configurable")
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> > ---
>
> Please split this patch from the rest of the series and re-target it
> towards net.git.
>

I resend it.
https://lore.kernel.org/netdev/20230628194327.1765644-1-paweldembicki@gmail=
.com/

--
Pawel Dembicki

> > v2:
> >   - fix commit message style issue
> >
> >  drivers/net/dsa/vitesse-vsc73xx-core.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/v=
itesse-vsc73xx-core.c
> > index c946464489ab..59bb3dbe780a 100644
> > --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> > +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> > @@ -979,17 +979,18 @@ static int vsc73xx_change_mtu(struct dsa_switch *=
ds, int port, int new_mtu)
> >       struct vsc73xx *vsc =3D ds->priv;
> >
> >       return vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port,
> > -                          VSC73XX_MAXLEN, new_mtu);
> > +                          VSC73XX_MAXLEN, new_mtu + ETH_HLEN + ETH_FCS=
_LEN);
> >  }
> >
> >  /* According to application not "VSC7398 Jumbo Frames" setting
> > - * up the MTU to 9.6 KB does not affect the performance on standard
> > + * up the frame size to 9.6 KB does not affect the performance on stan=
dard
> >   * frames. It is clear from the application note that
> >   * "9.6 kilobytes" =3D=3D 9600 bytes.
> >   */
> >  static int vsc73xx_get_max_mtu(struct dsa_switch *ds, int port)
> >  {
> > -     return 9600;
> > +     /* max mtu =3D 9600 - ETH_HLEN - ETH_FCS_LEN */
> > +     return 9582;
>
> This can also be:
>
>         return 9600 - ETH_HLEN - ETH_FCS_LEN;
>
> since the arithmetic is on constants, it can be evaluated at compile
> time and it results in the same generated code, but the comment is no
> longer necessary.
>
> >  }
> >
> >  static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port=
,
> > --
> > 2.34.1
> >
>
