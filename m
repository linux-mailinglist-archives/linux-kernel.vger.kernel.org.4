Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A531731AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344703AbjFOOFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344716AbjFOOEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:04:52 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FE41FCC;
        Thu, 15 Jun 2023 07:04:49 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686837888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCDagffXM08ITBYbD5wJrdDy47fDn0stQukREXmzgL0=;
        b=jbeW/3yG2DUBLu9x31tH0lJY7Uyd78NZALXo/IB9de7RpWpkk0lm4ti70wM2OAUZ0Qhr2J
        zYaoJrgKe8h5amn/hvsBHiC4hDeMgU24NDWjoJZfEV5N94tYcyhKkaFKdrr2GC8mkn6Dg6
        jBryGFMkdQ9wFy7vBbp+MxP3H566TFPbdfY3Jxi0vt2bdExwSLuhTjnvW+aLnapXvUUVu/
        fN4qv0krzD+ixksPvGhPqU0FcPSVYwKHzFJBoCo+OyJqVt1MGQ9PqWfRzd2/R/8uoTWbev
        YHGRGFtQZ3t3O99J9INi3zs+Qtm5ArbZR5gaH8SfvZRJvFDuzBh0d3GyIynCYw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 696F3240003;
        Thu, 15 Jun 2023 14:04:47 +0000 (UTC)
Date:   Thu, 15 Jun 2023 16:04:46 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] power: reset: at91-reset: use driver structure as
 status parameter
Message-ID: <20230615160446.60625339@xps-13>
In-Reply-To: <20230609231422.taqokbmxojbfdn2v@mercury.elektranox.org>
References: <20230609143912.849995-1-miquel.raynal@bootlin.com>
        <20230609143912.849995-2-miquel.raynal@bootlin.com>
        <20230609231422.taqokbmxojbfdn2v@mercury.elektranox.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

sebastian.reichel@collabora.com wrote on Sat, 10 Jun 2023 01:14:22
+0200:

> Hi,
>=20
> On Fri, Jun 09, 2023 at 04:39:11PM +0200, Miquel Raynal wrote:
> > It is quite uncommon to use a driver helper with parameters like *pdev
> > and __iomem *base. It is much cleaner and close to today's standards to
> > provide the per-device driver structure and then access its
> > internals. Let's do this with at91_resete_status() before making more
> > modifications to this helper.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/power/reset/at91-reset.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at9=
1-reset.c
> > index 741e44a017c3..a8a6f3997768 100644
> > --- a/drivers/power/reset/at91-reset.c
> > +++ b/drivers/power/reset/at91-reset.c
> > @@ -149,11 +149,10 @@ static int at91_reset(struct notifier_block *this=
, unsigned long mode,
> >  	return NOTIFY_DONE;
> >  }
> > =20
> > -static void __init at91_reset_status(struct platform_device *pdev,
> > -				     void __iomem *base)
> > +static void __init at91_reset_status(struct at91_reset *reset)
> >  {
> > +	u32 reg =3D readl(reset->rstc_base + AT91_RSTC_SR);
> >  	const char *reason;
> > -	u32 reg =3D readl(base + AT91_RSTC_SR);
> > =20
> >  	switch ((reg & AT91_RSTC_RSTTYP) >> 8) {
> >  	case RESET_TYPE_GENERAL: =20
>=20
> You also need to update the code calling this functions, otherwise
> the series is not bisectable.

Of course, I was not paying enough attention here, sorry about that.

Thanks,
Miqu=C3=A8l
