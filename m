Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E866AC161
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCFNfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjCFNfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:35:33 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C69B93D9;
        Mon,  6 Mar 2023 05:35:31 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6386260013;
        Mon,  6 Mar 2023 13:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678109730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VnpGU86Ni72zhxHdNK/dhWD3Go/gB3mzWOJCmEu360g=;
        b=Jk37TFlJrDLiUnBNheMFtT7rymsUHbSMxbmWDgzFV5GTJqxArTPg6NaoOOtgUWJ4yUqHj0
        eOYmTWhLaaLH7O0qvtVpD3MxQsIXCPnGrfPCLjHbJzN7/SuTLC6RH4bvCS0zX7N5v4NivA
        RtWeZ9sFj9DSRXkAkZLt8XsJqgMKz+wK4Zl5iA6OwQV1eaiZfXb+vuZboDl8Ooio4k1DUO
        1zKXqhTgjvPNm7xO7O7wzON2GfmUb+mrc9DxgCHMG3RS6ntD/OcIZUVzQltX1chqO7J2w+
        FNAApnnZn3Jk5tznVy/sgkSaQ1FAv5LjP/7m+yasTMOmoQlEFTnmNPkIvuRZBg==
Date:   Mon, 6 Mar 2023 14:35:28 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        rafal@milecki.pl
Subject: Re: [PATCH 0/8] nvmem: Let layout drivers be modules
Message-ID: <20230306143528.7407fda5@xps-13>
In-Reply-To: <ee7923a8b5fa8358e6805d20df7d8049@walle.cc>
References: <20230301152239.531194-1-miquel.raynal@bootlin.com>
        <ee7923a8b5fa8358e6805d20df7d8049@walle.cc>
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

Hi Michael,

michael@walle.cc wrote on Mon, 06 Mar 2023 14:01:34 +0100:

> > Miquel Raynal (8):
> >   of: Fix modalias string generation
> >   of: Change of_device_get_modalias() main argument
> >   of: Create an of_device_request_module() receiving an OF node
> >   nvmem: core: Fix error path ordering
> >   nvmem: core: Handle the absence of expected layouts
> >   nvmem: core: Request layout modules loading
> >   nvmem: layouts: sl28vpd: Convert layout driver into a module
> >   nvmem: layouts: onie-tlv: Convert layout driver into a module =20
>=20
> With the fixes series [1] applied:

Thanks for the series! Looks good to me. I believe both series can live
in separate tress, any reason why we would like to avoid this? I am keen
to apply [1] into the mtd tree rather soon.

I will handle the remaining deferral errors in the regular mtd path as
discussed on IRC.

> Tested-by: Michael Walle <michael@walle.cc>
>=20
> I didn't test module autoloading, but I presume you did.

Yes, I generated an initramfs with Buildroot, in which an overlay
containing the result of modules_install got merged (storage device =3Dy
and nvmem layout to =3Dm). I could observe the modprobe call being
successful and the layout driver being loaded early.

> Thanks for working on this!

=F0=9F=91=8D

> -michael
>=20
> [1] https://lore.kernel.org/r/20230306125805.678668-1-michael@walle.cc/

Thanks,
Miqu=C3=A8l
