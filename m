Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F1B63A30F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiK1Ias (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiK1Iap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:30:45 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9376313D5E;
        Mon, 28 Nov 2022 00:30:43 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6046760008;
        Mon, 28 Nov 2022 08:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669624242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V24Aaq988HpFuk8FMBp0+VYNbQHp6mco9JU3lqfOz1Q=;
        b=NnFQLqfWAY0F9/IpVrR3n0Tuv2AAexr6Q/CLUzGAXiupV52Xhw4ApUSmF7reojh1MykfhM
        o19kH/AoVRM3S3prp+q474utljNy1XVKFg7HJiLlJakBFZYzmU1+4mK7EbFJs+qsKOj1a3
        DCj8u+zkhtu4wMAyXg+lagZx3Qswfhnlq9uGOAG6S7l2BF7paVOXBIxqMCXBR9VICXMt9T
        5PvClBssOBYWZJi9Wr+hxF86l7vkC+Amv2qXIUGMa2PjFUaypSBwQN5ga7YUHBd2QgdziA
        oHLYHTPFmsIudsC3qABWWeLTVCwjw+v3G90S0ACBvX1dgkejEBZz4QfKNyih1A==
Date:   Mon, 28 Nov 2022 09:30:34 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?B?UmFmYcWC?= =?UTF-8?B?IE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 1/2] nvmem: core: refactor .cell_post_process() CB
 arguments
Message-ID: <20221128093034.6646f191@xps-13>
In-Reply-To: <f2bb569404903bc937fbe3840582f3c4@walle.cc>
References: <20221128065923.1180-1-zajec5@gmail.com>
        <f2bb569404903bc937fbe3840582f3c4@walle.cc>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafal,

michael@walle.cc wrote on Mon, 28 Nov 2022 08:35:24 +0100:

> Am 2022-11-28 07:59, schrieb Rafa=C5=82 Mi=C5=82ecki:
> > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >=20
> > Pass whole NVMEM cell struct and length pointer as arguments to > callb=
ack
> > functions.
> >=20
> > This allows:
> >=20
> > 1. Cells content to be modified based on more info
> >    Some cells (identified by their names) contain specific data that
> >    needs further processing. This can be e.g. MAC address stored in an
> >    ASCII format. NVMEM consumers expect MAC to be read in a binary > fo=
rm.
> >    More complex cells may be additionally described in DT. This change
> >    allows also accessing relevant DT nodes and reading extra info.
> >=20
> > 2. Adjusting data length
> >    If cell processing results in reformatting it, it's required to
> >    adjust length. This again applies e.g. to the MAC format change from
> >    ASCII to the byte-based.

Michael's series brings read_post_process, isn't what you need here?

> >=20
> > Later on we may consider more cleanups & features like:
> > 1. Dropping "const char *id" and just using NVMEM cell name
> > 2. Adding extra argument for cells providing multiple values
> >=20
> > Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > ---
> > This solution conflicts with 1 part of Michael's work:
> > [PATCH v2 00/20] nvmem: core: introduce NVMEM layouts
> > https://lore.kernel.org/linux-arm-kernel/20220901221857.2600340-1-micha=
el@walle.cc/
> >=20
> > Instead of:
> > 1. Adding NVMEM cell-level post_process callback
> > 2. Adding callback (.fixup_cell_info()) for setting callbacks
> > 3. Dropping NVMEM device-level post_process callback
> > I decided to refactor existing callback.
> >=20
> > Michael's work on adding #nvmem-cell-cells should be possible to easily
> > rebase on top of those changes. =20

Yeah, I guess since Michael's series has been out for 2 years and we
finally agreed on the bindings plus some implementation points, I would
expect it to be merged very soon (I don't know if Srinivas still plans
to take it for this release or for the next?) unless someone speaks up
against it.

> As yours should be easily added on top of my series. I've showed that
> providing a global post process hook is bad because that way you need
> to have *all* cells of your device read-only.
>=20
> -michael

Thanks,
Miqu=C3=A8l
