Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0F96DD475
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjDKHl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjDKHl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:41:57 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003BCE77;
        Tue, 11 Apr 2023 00:41:52 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7972CC000A;
        Tue, 11 Apr 2023 07:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681198910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHCUEdoazzzTZWGVmhHLNHj7jb6meksPxErHfFWeViA=;
        b=ZYZR6+iIcGKMjxRTU74mQnD/gmwfnJh+tAu7h2V7wPtkJskUGOGfha+0zaYNwElItaxfMn
        vbjK9o0uimHAVORYgrn210J1S26QdVZBVvPHiHw0Ii4uLiGBaqCDM75s/MILJz1vFk5NlQ
        Xl+lMo5EJLtU/xNIvvj8eDuZG7efKsHfmZ/Fvx8/OSXW2hor9R8IJiCXOfivq8PxYNWpLO
        aiClY7phQoAzSN6BA9tKdEHAM9XAloYB9STE1JLJheycjX6zD6gBG67qWVTyXXr1F/M2EH
        1xqpbtycOxLjrvhOH6nxebrEqyIdn4MyT16i+fJWX2YyUpTO9dYM4XgbT4x/kQ==
Date:   Tue, 11 Apr 2023 09:41:48 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robherring2@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 devicetree tree
Message-ID: <20230411094148.79730b00@xps-13>
In-Reply-To: <2023041121-hazily-dedicator-f7b4@gregkh>
References: <20230411135728.07539d81@canb.auug.org.au>
        <2023041121-hazily-dedicator-f7b4@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

greg@kroah.com wrote on Tue, 11 Apr 2023 09:33:30 +0200:

> On Tue, Apr 11, 2023 at 01:57:28PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Today's linux-next merge of the char-misc tree got a conflict in:
> >=20
> >   drivers/of/Makefile
> >=20
> > between commit:
> >=20
> >   bac06718990c ("of: Move CPU node related functions to their own file")
> >=20
> > from the devicetree tree and commit:
> >=20
> >   bd7a7ed774af ("of: Move of_modalias() to module.c")
> >=20
> > from the char-misc tree.
> >=20
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >=20
> > --=20
> > Cheers,
> > Stephen Rothwell
> >=20
> > diff --cc drivers/of/Makefile
> > index 10f704592561,ae9923fd2940..000000000000
> > --- a/drivers/of/Makefile
> > +++ b/drivers/of/Makefile
> > @@@ -1,5 -1,5 +1,5 @@@
> >   # SPDX-License-Identifier: GPL-2.0
> > - obj-y =3D base.o cpu.o device.o platform.o property.o
> >  -obj-y =3D base.o device.o module.o platform.o property.o
> > ++obj-y =3D base.o cpu.o device.o module.o platform.o property.o
> >   obj-$(CONFIG_OF_KOBJ) +=3D kobj.o
> >   obj-$(CONFIG_OF_DYNAMIC) +=3D dynamic.o
> >   obj-$(CONFIG_OF_FLATTREE) +=3D fdt.o =20
>=20
>=20
> Merge looks good to me, thanks!

Agreed :)

Thanks,
Miqu=C3=A8l
