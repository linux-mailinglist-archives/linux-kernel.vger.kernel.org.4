Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D277221B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjFEJF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjFEJFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:05:54 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FBB99
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 02:05:51 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685955950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G1HS5GQheslp9a6/umV1cLiyP8gp9jVsiTEQEBu6cgc=;
        b=fzJ+JgiAN6PVqSgGMobsDNfS4fqwP6UO6mdylIiOlPlxCrDepQdRc4otQfAKJxF8tWSjPv
        dozYQn66toUoD5o9la508y3qkKmb/POcp3sxZd6+4E5vFuVUD2hLKQPy0IBea0oY5xQ9WH
        wsDNycWqbVDsOMOhu50pmb4oHk3HZZMXHcnqh/Y94Rt1NzobU+S/4YR+6Ven7VUUtMOMT2
        zxnq9ReE/PBaXeCMbInpcU1m7wp0uIQ7076OaEPDQ5YMPiiUtnfQv+Dfzw+PCoZHEQ429B
        1QOADvxgg43c2h5f6f5KfpTZJMZEL+R0Y7dTbUYhnoZpjXjhE0flcDCUUXfQzA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0CF1240004;
        Mon,  5 Jun 2023 09:05:47 +0000 (UTC)
Date:   Mon, 5 Jun 2023 11:05:46 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 2/6] mtd: rawnand: meson: wait for command in
 polling mode
Message-ID: <20230605110546.6cb00a8d@xps-13>
In-Reply-To: <9e106d50-2524-c999-48b1-a20760238aaf@sberdevices.ru>
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
        <20230601061850.3907800-3-AVKrasnov@sberdevices.ru>
        <20230601100751.41c3ff0b@xps-13>
        <9e106d50-2524-c999-48b1-a20760238aaf@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

> >> @@ -1412,6 +1419,8 @@ static int meson_nfc_probe(struct platform_devic=
e *pdev)
> >>  		return ret;
> >>  	}
> >> =20
> >> +	nfc->use_polling =3D of_property_read_bool(dev->of_node, "polling");=
 =20
> >=20
> > This is a problem. You cannot add a polling property like that.
> >=20
> > There is already a nand-rb property which is supposed to carry how are
> > wired the RB lines. I don't see any in-tree users of the compatibles, I
> > don't know how acceptable it is to consider using soft fallback when
> > this property is missing, otherwise take the values of the rb lines
> > provided in the DT and user hardware control, but I would definitely
> > prefer that. =20
>=20
> I see. So i need to implement processing of this property here? And if it
> is missed -> use software waiting. I think interesting thing will be that:
>=20
> 1) Even with support of this property here, I really don't know how to pa=
ss
>    RB values to this controller - I just have define for RB command and t=
hat's
>    it. I found that this property is an array of u32 - IIUC each element =
is
>    RB pin per chip. May be i need to dive into the old vendor's driver to=
 find
>    how to use RB values (although this driver uses software waiting so I'=
m not
>    sure that I'll find something in it).

Liang, can you please give use the relevant information here? How do we
target RB0 and RB1? It seems like you use the CS as only information
like if the RB lines where hardwired internally to a CS. Can we invert
the lines with a specific configuration?

Arseniy, if the answer to my above question is no, then you should
expect the nand-rb and reg arrays to be identical. If they are not,
then you can return -EINVAL.

If the nand-rb property is missing, then fallback to software wait.

> 2) I can't test RB mode - I don't have such device :(=20
>=20
> Also for example in arasan-nand-controller.c parsed 'nand-rb' values are =
used
> in controller specific register for waiting (I guess Meson controller has=
 something
> like that, but I don't have doc). While in marvell_nand.c it looks like t=
hat they parse
> 'nand-rb' property, but never use it.

Yes, the logic around the second RB line (taking care of CS1/CS3) is
slightly broken or at least badly documented, and thus should not be
used.

> > In any case you'll need a dt-binding update which must be acked by
> > dt-binding maintainers. =20
>=20
> You mean to add this property desc to Documentation/devicetree/bindings/m=
td/amlogic,meson-nand.yaml ?

Yes. In a dedicated patch. Something along the lines:

	nand-rb: true

inside the nand chip object should be fine. And flag the change as a
fix because we should have used and parsed this property since the
beginning.

Thanks,
Miqu=C3=A8l
