Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EC46B0BE1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjCHOwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjCHOwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:52:06 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A78358C;
        Wed,  8 Mar 2023 06:52:02 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C9AE8FF80B;
        Wed,  8 Mar 2023 14:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678287121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QCzOOOnS+zYy1dphlSYdevee9Uf5FRZUlz22AyL3o4c=;
        b=HwV4nNMfPCSVyjJbjzMU7LKkzSJ33ar8ScAHGwVLq5CuxQJdWV5j7F1mhfZPTsBtF+vkUB
        rrB5aY1t0XriiNOnKIDT3okoqppx4fQiutIw7YFJV/LFjf4iAW4Q6J+XW47070lTrXzsSP
        x28wtow8tK4ylSWOgsoVlz2niEZDCweKXOhW7lryqO35do/aFCpOK3ycDLkKE5ck5Vzks9
        o2UbZ3+hZGAiTnZGQffoS70VooyHPNe2JyjqLhb/Aj8MSiqitSqDgIx1pBLRfWsUN9ovHv
        OOY7/e9Y40cT6lb2fn74rYoblsZKHmcVaYUvMwMYiKu7gqwo1h6+jb/eKCES2Q==
Date:   Wed, 8 Mar 2023 15:51:58 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 04/21] of: Move of_modalias() to module.c
Message-ID: <20230308155158.4ceecc05@xps-13>
In-Reply-To: <20230308002306.GB513330-robh@kernel.org>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
        <20230307165359.225361-5-miquel.raynal@bootlin.com>
        <20230308002306.GB513330-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Tue, 7 Mar 2023 18:23:06 -0600:

> On Tue, Mar 07, 2023 at 05:53:42PM +0100, Miquel Raynal wrote:
> > Create a specific .c file for of related module handling.
> > Move of_modalias() inside as a first step. =20
>=20
> Perhaps a comment as to why it needs to be public? Or is it just shared=20
> within the DT core? If so, we have of_private.h for that.

Good point. This helper is actually only used internally (was static
before). At first I wanted to convert all users to use the "new" OF
module-related helpers, but unfortunately, the "dev->of_node_reused"
check makes this impossible. I thus need to keep a few users of
of_modalias() in of_device.h in the coming patches. I could move
of_modalias() to of_private.h but that would mean exposing all the
internals and private definitions to the drivers including of_device.h,
which seemed extremely unsatisfying to me.

I've updated the commit log with:

    The helper is exposed through of.h even though it is only used by core
    files because the users from device.c will soon be split into an OF-only
    helper in module.c as well as a device-oriented inline helper in
    of_device.h. Putting this helper in of_private.h would require to
    include of_private.h from of_device.h, which is not acceptable.

>=20
> >=20
> > Suggested-by: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/of/Makefile |  2 +-
> >  drivers/of/device.c | 37 -------------------------------------
> >  drivers/of/module.c | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/of.h  |  8 ++++++++
> >  4 files changed, 52 insertions(+), 38 deletions(-)
> >  create mode 100644 drivers/of/module.c
> >=20
> > diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> > index e0360a44306e..ae9923fd2940 100644
> > --- a/drivers/of/Makefile
> > +++ b/drivers/of/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -obj-y =3D base.o device.o platform.o property.o
> > +obj-y =3D base.o device.o module.o platform.o property.o
> >  obj-$(CONFIG_OF_KOBJ) +=3D kobj.o
> >  obj-$(CONFIG_OF_DYNAMIC) +=3D dynamic.o
> >  obj-$(CONFIG_OF_FLATTREE) +=3D fdt.o
> > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > index 2bbb67798916..44f1f2ef12b7 100644
> > --- a/drivers/of/device.c
> > +++ b/drivers/of/device.c

[...]

> > diff --git a/drivers/of/module.c b/drivers/of/module.c
> > new file mode 100644
> > index 000000000000..9c6a53f32c0f
> > --- /dev/null
> > +++ b/drivers/of/module.c
> > @@ -0,0 +1,43 @@
> > +// SPDX-License-Identifier: GPL-2.0+ =20
>=20
> Existing license was GPL-2.0 (-only).

Oh right, I took the license from base.c, you're right I should have
taken the one from device.c.

Thanks,
Miqu=C3=A8l
