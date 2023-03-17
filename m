Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB556BF046
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCQR7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCQR7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:59:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EBA31E1A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:59:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3ed5cf9a455so56705e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679075948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjvTte7bz790I4DeoccGypf45T5SSdILVtKRKvCiFOI=;
        b=EiNd16NuxHMFHB8ctHAXApT18HqEP/MdXDPr2xnMxoD1lwuNdMZhlZjzYNoP5JAhye
         jPCSCKpLbjXQq5dSNifqsuUuHUYIP2o8tyNXn9Xj6a9Hm30Fm5nITDHlOfbB5y9djsSU
         n24l0ALbmhr/8jlrXM9LAcnxiVwzIOs0hRiCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679075948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjvTte7bz790I4DeoccGypf45T5SSdILVtKRKvCiFOI=;
        b=YC3GBFCg8lIDzpruapywihX0A+bJSIQ7omJgirczCAtakO5V1nLHh93U7V87Fu8Etb
         siqbP3kL93a1SQCo0KlMRYIbtqf8gPcEC0t1NKM9rl4S6SIBEywBSwONHx1XaF0pGmyr
         BvwZOY1fvfl83c3983UD6D/C5ah9BqQrmkDATb8o9J/anwaWskq75l5AXl9Hj//fHhUA
         VZZW3POJLdJegk2CvjKDFhTeMEFDhO4E5NJBlvH9Q4r2gf1w9xQv24Mb3J9EeP95VXG5
         yLN4ngcCxSSFUhVA24MQxo8GZidqBYhzbEkCV4KcZOfCJurEAQSSQKaOxpnWmviTcXFt
         oFOw==
X-Gm-Message-State: AO0yUKUnG7TlZ7umT7IWJyD5kS6/lbyK7NqYIrHAzHS6mvbhZr98XFzb
        9Z7k5Ek0pWdL7Lk9I9jNnx5NzimeVLbJhixVT+zuvg==
X-Google-Smtp-Source: AK7set9e34KRiIz2HRwC5yN5XBvua7H4JERtmCm0RF+b7/ldiI4eo4W76D8K0TRd0iAc0fFvvaZyKu5z80jjulMa5QU=
X-Received: by 2002:a05:600c:3589:b0:3e2:1a5e:b13c with SMTP id
 p9-20020a05600c358900b003e21a5eb13cmr961wmq.2.1679075947629; Fri, 17 Mar 2023
 10:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230314055410.3329480-1-grundler@chromium.org> <20230315220822.6d8cf7ed@kernel.org>
In-Reply-To: <20230315220822.6d8cf7ed@kernel.org>
From:   Grant Grundler <grundler@chromium.org>
Date:   Fri, 17 Mar 2023 10:58:55 -0700
Message-ID: <CANEJEGv0fSa9ZqArTDJcSwUpjKrOS=502Uz6C6LRh3gptfTs9g@mail.gmail.com>
Subject: Re: [PATCHv4 net] net: asix: fix modprobe "sysfs: cannot create
 duplicate filename"
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Grant Grundler <grundler@chromium.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Eizan Miyamoto <eizan@chromium.org>,
        netdev <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Anton Lundin <glance@acc.umu.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 10:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 13 Mar 2023 22:54:10 -0700 Grant Grundler wrote:
> > @@ -690,6 +704,7 @@ static int ax88772_init_phy(struct usbnet *dev)
> >       priv->phydev =3D mdiobus_get_phy(priv->mdio, priv->phy_addr);
> >       if (!priv->phydev) {
> >               netdev_err(dev->net, "Could not find PHY\n");
> > +             ax88772_mdio_unregister(priv);
>
> this line needs to go now..
>
> >               return -ENODEV;
>
> .. since if we return error here ..
>
> >       }
> >
> > @@ -896,16 +911,23 @@ static int ax88772_bind(struct usbnet *dev, struc=
t usb_interface *intf)
> >
> >       ret =3D ax88772_init_mdio(dev);
> >       if (ret)
> > -             return ret;
> > +             goto mdio_err;
> >
> >       ret =3D ax88772_phylink_setup(dev);
> >       if (ret)
> > -             return ret;
> > +             goto phylink_err;
> >
> >       ret =3D ax88772_init_phy(dev);
>
> .. it will pop out here ..
>
> >       if (ret)
> > -             phylink_destroy(priv->phylink);
> > +             goto initphy_err;
> >
> > +     return 0;
> > +
> > +initphy_err:
> > +     phylink_destroy(priv->phylink);
> > +phylink_err:
> > +     ax88772_mdio_unregister(priv);
>
> .. and then call ax88772_mdio_unregister() a second time.

Doh! Yes - good catch. Let me fix that.

cheers,
grant

>
> > +mdio_err:
> >       return ret;
> >  }
